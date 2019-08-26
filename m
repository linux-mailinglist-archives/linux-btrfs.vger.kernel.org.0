Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF19D014
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 15:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbfHZNJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 09:09:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:33680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731174AbfHZNJC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 09:09:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0EC5AC2E;
        Mon, 26 Aug 2019 13:09:00 +0000 (UTC)
Subject: Re: [PATCH] btrfs: Deprecate BTRFS_SUBVOL_CREATE_ASYNC flag
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20190826123728.2854-1-nborisov@suse.com>
 <c758a9fe-e63c-52a8-2518-fd0a5128c1b9@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <93d47492-8a82-d3f0-e421-1697f9d13f26@suse.com>
Date:   Mon, 26 Aug 2019 16:08:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c758a9fe-e63c-52a8-2518-fd0a5128c1b9@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.08.19 г. 16:03 ч., Qu Wenruo wrote:
> 
> 
> On 2019/8/26 下午8:37, Nikolay Borisov wrote:
>> Support for asynchronous snapshot creation was originally added in
>> 72fd032e9424 ("Btrfs: add SNAP_CREATE_ASYNC ioctl") to cater for
>> ceph's backend needs. However, since Ceph has deprecated support for
>> btrfs
> 
> Any reference for that?
> 
> From what I have read, btrfs is still supported, although only
> recommended for testing/development.
> From ceph filesystem recommendations:

The principal author of btrfs (and funnily enough, original implementer
of the async subvolume) says so himself:

http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-July/019095.html:

On 06/30/2017 06:48 PM, Sage Weil wrote:

> Ah, crap.  This is what happens when devs don't read their own
> documetnation.  I recommend against btrfs every time it ever comes
> up, the downstream distributions all support only xfs, but yes, it
> looks like the docs never got updated... despite the xfs focus being
> 5ish years old now.


> 
> We used to recommend btrfs for testing, development, and any
> non-critical deployments becuase it has the most promising set of
> features. However, we now plan to avoid using a kernel file system
> entirely with the new BlueStore backend. btrfs is still supported and
> has a comparatively compelling set of features, but be mindful of its
> stability and support status in your Linux distribution.
> 
> (Anyway, still better than the not recommended ext4).
> 
> Thanks,
> Qu
> 
>> there is no longer need for that support in btrfs. Additionally,
>> this was never supported by btrfs-progs, the official userspace tools.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  fs/btrfs/ioctl.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index c343f72a84d5..a412bd2036bb 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1837,8 +1837,12 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
>>  		goto free_args;
>>  	}
>>
>> -	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC)
>> +	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC) {
>> +		pr_warn("BTRFS: async snapshot creation is deprecated and will"
>> +			" be removed in kernel 5.7\n");
>> +
>>  		ptr = &transid;
>> +	}
>>  	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
>>  		readonly = true;
>>  	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
>> @@ -4214,6 +4218,10 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
>>  	u64 transid;
>>  	int ret;
>>
>> +
>> +	pr_warn("BTRFS: START_SYNC ioctl is deprecated and will be removed in "
>> +		"kernel 5.7\n");
>> +
>>  	trans = btrfs_attach_transaction_barrier(root);
>>  	if (IS_ERR(trans)) {
>>  		if (PTR_ERR(trans) != -ENOENT)
>> @@ -4241,6 +4249,9 @@ static noinline long btrfs_ioctl_wait_sync(struct btrfs_fs_info *fs_info,
>>  {
>>  	u64 transid;
>>
>> +	pr_warn("BTRFS: WAIT_SYNC ioctl is deprecated and will be removed in "
>> +		"kernel 5.7\n");
>> +
>>  	if (argp) {
>>  		if (copy_from_user(&transid, argp, sizeof(transid)))
>>  			return -EFAULT;
>>
> 
