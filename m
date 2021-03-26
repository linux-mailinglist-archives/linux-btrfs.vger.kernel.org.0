Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722E034A9C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 15:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCZOc3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 10:32:29 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:45592 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhCZOcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 10:32:22 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id F3D1D6C00A19;
        Fri, 26 Mar 2021 16:32:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1616769141; bh=bITWAQzq8Hp0WMZmQv06Uyk7j95D6FxkDcQ+gCExTWs=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=ZxVYfdPGobOFEQ1ObrnCObF3hQo0fNq1zXP9wM6LNooPlHpwp3Oc6TNdq3Lm1Kn63
         G6xf7iL0IS6kpOmc0N5BovZdATw31lSgSA7FDGZ4JZ+97eLEywRoza72EmdHfDN5R3
         vxXn+IdRvC20qMKmIfDYvjj0fWgIWB5YHRy+n4yM=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id DBC686C009F4;
        Fri, 26 Mar 2021 16:32:20 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id osvGzPAIHXxR; Fri, 26 Mar 2021 16:32:19 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 9AB2B6C00A05;
        Fri, 26 Mar 2021 16:32:19 +0200 (EET)
Received: from nas (unknown [45.87.95.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 7529B1BE0093;
        Fri, 26 Mar 2021 16:32:16 +0200 (EET)
References: <20210326125047.123694-1-wqu@suse.com>
 <20210326125047.123694-3-wqu@suse.com> <v99e6mjl.fsf@damenly.su>
User-agent: mu4e 1.5.8; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 2/3] btrfs-progs: image: enlarge the output file if no
 tree modification is needed for restore
Date:   Fri, 26 Mar 2021 22:29:16 +0800
In-reply-to: <v99e6mjl.fsf@damenly.su>
Message-ID: <pmzm6l5n.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m7upSY16pjlu/S3zADAMpqyJVPp7o+PvJrhAZwzvmU1qJf04NURK/nm1yS2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Fri 26 Mar 2021 at 21:52, Su Yue <l@damenly.su> wrote:

> On Fri 26 Mar 2021 at 20:50, Qu Wenruo <wqu@suse.com> wrote:
>
>> [BUG]
>> If restoring dumpped image into a new file, under most cases
>> kernel will
>> reject it:
>>
>>  # mkfs.btrfs -f /dev/test/test
>>  # btrfs-image /dev/test/test /tmp/dump
>>  # btrfs-image -r /tmp/dump ~/test.img
>>  # mount ~/test.img /mnt/btrfs
>>  mount: /mnt/btrfs: wrong fs type, bad option, bad superblock 
>>  on
>>  /dev/loop0, missing codepage or helper program, or other 
>>  error.
>>  # dmesg -t | tail -n 7
>>  loop0: detected capacity change from 10592 to 0
>>  BTRFS info (device loop0): disk space caching is enabled
>>  BTRFS info (device loop0): has skinny extents
>>  BTRFS info (device loop0): flagging fs with big metadata
>>  feature
>>  BTRFS error (device loop0): device total_bytes should be at
>>  most 5423104 but found 10737418240
>>  BTRFS error (device loop0): failed to read chunk tree: -22
>>  BTRFS error (device loop0): open_ctree failed
>>
>> [CAUSE]
>> When btrfs-image restores an image into a file, and the source
>> image
>> contains only single device, then we don't need to modify the
>> chunk/device tree, as we can reuse the existing chunk/dev tree
>> without
>> any problem.
>>
>> This also means, for such restore, we also won't do any target
>> file
>> enlarge. This behavior itself is fine, as at that time, kernel
>> won't
>> check if the device is smaller than the device size recorded in
>> device
>> tree.
>>
>> But later kernel commit 3a160a933111 ("btrfs: drop never met
>> disk total
>> bytes check in verify_one_dev_extent") introduces new check on
>> device
>> size at mount time, rejecting any loop file which is smaller
>> than the
>> original device size.
>>
>> [FIX]
>> Do extra file enlarge for single device restore.
>>
>> Reported-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  image/main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/image/main.c b/image/main.c
>> index 24393188e5e3..9933f69d0fdb 100644
>> --- a/image/main.c
>> +++ b/image/main.c
>> @@ -2706,6 +2706,49 @@ static int restore_metadump(const char
>> *input, FILE *out, int old_restore,
>>  		close_ctree(info->chunk_root);
>>  		if (ret)
>>  			goto out;
>> +	} else {

The indent... Never mind. I think I should go to sleep.

Reviewed-by: Su Yue <l@damenly.su>

>> +		struct btrfs_root *root;
>> +		struct stat st;
>> +		u64 dev_size;
>> +
>> +		if (!info) {
>>
> Here info is not NULL else above fixup_chunks_and_devices()
> already
> crashed at deferencing fs_info->super_copy. So I guess the 
> branch
> can be deleted?

>> +			root = open_ctree_fd(fileno(out), target, 0, 0);
>> +			if (!root) {
>> +				error("open ctree failed in %s", target);
>> +				ret = -EIO;
>> +				goto out;
>> +			}
>> +
>> +			info = root->fs_info;
>> +
>> +			dev_size = btrfs_stack_device_total_bytes(
>> +					&info->super_copy->dev_item);
>> +			close_ctree(root);
>> +			info = NULL;
>> +		} else {
>> +			dev_size = btrfs_stack_device_total_bytes(
>> +					&info->super_copy->dev_item);
>> +		}
>> +
>> +		/*
>> +		 * We don't need extra tree modification, but if the
>> output is
>> +		 * a file, we need to enlarge the output file so that
>> +		 * newer kernel won't report error.
>> +		 */
>> +		ret = fstat(fileno(out), &st);
>> +		if (ret < 0) {
>> +			error("failed to stat result image: %m");
>> +			ret = -errno;
>> +			goto out;
>> +		}
>> +		if (S_ISREG(st.st_mode)) {
>> +			ret = ftruncate64(fileno(out), dev_size);
>> +			if (ret < 0) {
>> +				error("failed to enlarge result image: %m");
>> +				ret = -errno;
>> +				goto out;
>>
> I see there is a same pattern inside fixup_device_size().

