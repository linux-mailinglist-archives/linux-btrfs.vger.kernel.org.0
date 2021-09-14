Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5E140AAE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhINJdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 05:33:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47308 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhINJdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 05:33:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E12A1FDD3;
        Tue, 14 Sep 2021 09:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631611910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=APRvrED9rvtWowSBxY3ndU1jLjDW+kpj/G+go1Op1DM=;
        b=GA5flshiFNolX5I/VSweV8c6V1RPibZWu2UEKOS6bY4s/DnQEgNaN9nSeup8HNUmWPSTCe
        angSNnmgIWFAMg66uDUG09e1t/tbOnso1fQt1+Ci1fabi7xIv0TfRdkUC3Wb/XRdDxAhbo
        zsUFdCsiS6uhW4mV/dg8fNuS/1l/R0E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A81F13E55;
        Tue, 14 Sep 2021 09:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vomLOwVsQGFXRgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 14 Sep 2021 09:31:49 +0000
Subject: Re: [PATCH v2 0/8] Implement progs support for removing received uuid
 on RW vols
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
 <f75b31ce-9f33-4706-e187-dd0911d22f7d@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <0dd22937-8879-af0f-df90-4ceb20d7d449@suse.com>
Date:   Tue, 14 Sep 2021 12:31:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f75b31ce-9f33-4706-e187-dd0911d22f7d@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.09.21 г. 12:30, Qu Wenruo wrote:
> 
> 
> On 2021/9/14 下午5:05, Nikolay Borisov wrote:
>> Here's V2 which takes into account Qu's suggestions, namely:
>>
>> - Add a helper which contains the common code to clear receive-related
>> data
>> - Now there is a single patch which impements the check/clear for both
>> orig and
>> lowmem modes
>> - Added Reviewed-by from Qu.
>>
>>
>> Nikolay Borisov (8):
>>    btrfs-progs: Add btrfs_is_empty_uuid
>>    btrfs-progs: Remove root argument from btrfs_fixup_low_keys
>>    btrfs-progs: Remove fs_info argument from leaf_data_end
>>    btrfs-progs: Remove root argument from btrfs_truncate_item
>>    btrfs-progs: Add btrfs_uuid_tree_remove
>>    btrfs-progs: Implement helper to remove received information of RW
>>      subvol
>>    btrfs-progs: check: Implement removing received data for RW subvols
>>    btrfs-progs: tests: Add test for received information removal
>>
>>   check/main.c                                  |  21 +++-
>>   check/mode-common.c                           |  40 ++++++++
>>   check/mode-common.h                           |   1 +
>>   check/mode-lowmem.c                           |  11 ++-
>>   kernel-shared/ctree.c                         |  62 +++++-------
>>   kernel-shared/ctree.h                         |  12 ++-
>>   kernel-shared/dir-item.c                      |   2 +-
>>   kernel-shared/extent-tree.c                   |   2 +-
>>   kernel-shared/file-item.c                     |   4 +-
>>   kernel-shared/inode-item.c                    |   4 +-
>>   kernel-shared/uuid-tree.c                     |  93 ++++++++++++++++++
>>   .../050-subvol-recv-clear/test.raw.xz         | Bin 0 -> 493524 bytes
> 
> The image looks a little large than expected, so that the mailing list
> is rejected the armored patch.
> 
> Can we use btrfs-image? As there is no need for special layout which
> can't be dumped by btrfs-image.
> Thus using btrfs-image -c9 would save quite some space.

Well I did use a raw image, compressed with xz. But sure, I'll look into
this but for the time being will wait to gather more feedback.

> 
> Thanks,
> Qu
> 
>>   12 files changed, 202 insertions(+), 50 deletions(-)
>>   create mode 100644 tests/fsck-tests/050-subvol-recv-clear/test.raw.xz
>>
>> -- 
>> 2.17.1
>>
> 
