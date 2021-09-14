Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A540AB35
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 11:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhINJ4a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 05:56:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43434 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhINJ43 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 05:56:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3AE921F1E;
        Tue, 14 Sep 2021 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631613310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qoG1fjr4wuBvAqS6bG7WIyoHl3aLqM6QTKH5KXkG1o4=;
        b=aYY41/NMqFgf+ndbpQs6VvoEOutg9d0L4zdtB1CdsydchVnOt5xtx5Rp0aDAu3n5Z4j+4X
        aEyQg5Q9VBzLJTa2f3M+8cuRCpcncuLjqb6mtJ/Lm6wTeTfxJgSn3/P1pW/4SLRh8SGtyE
        2gxYUVtrXGEGrJSsFtVseWB4WbngyNU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE08A13E55;
        Tue, 14 Sep 2021 09:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GuXpK35xQGFsUwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 14 Sep 2021 09:55:10 +0000
Subject: Re: [PATCH v2 7/8] btrfs-progs: check: Implement removing received
 data for RW subvols
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
 <20210914090558.79411-8-nborisov@suse.com>
 <15295190-51cb-7fff-c9dd-1f604a177064@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <646edbe5-d652-2ea3-7202-3d5304b0e54f@suse.com>
Date:   Tue, 14 Sep 2021 12:55:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <15295190-51cb-7fff-c9dd-1f604a177064@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.09.21 г. 12:25, Qu Wenruo wrote:
> 
> 
> On 2021/9/14 下午5:05, Nikolay Borisov wrote:
>> Making a received subvolume RO should preclude doing an incremental send
>> of said subvolume since it can't be guaranteed that nothing changed in
>> the structure and this in turn has correctness implications for send.
>>
>> There is a pending kernel change that implements this behavior and
>> ensures that in the future RO volumes which are switched to RW can't be
>> used for incremental send. However, old kernels won't have that patch
>> backported. To ensure there is a supported way for users to put their
>> subvolumes in sane state let's implement the same functionality in
>> progs.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>   check/main.c        | 16 +++++++++++++++-
>>   check/mode-lowmem.c | 11 ++++++++++-
>>   2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/check/main.c b/check/main.c
>> index 6369bdd90656..9d3822a2ebae 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -3544,6 +3544,7 @@ static int check_fs_root(struct btrfs_root *root,
>>       int ret = 0;
>>       int err = 0;
>>       bool generation_err = false;
>> +    bool rw_received_err = false;
>>       int wret;
>>       int level;
>>       u64 super_generation;
>> @@ -3658,6 +3659,19 @@ static int check_fs_root(struct btrfs_root *root,
>>                       sizeof(found_key)));
>>       }
>>
>> +    if (!((btrfs_root_flags(root_item) & BTRFS_ROOT_SUBVOL_RDONLY) ||
>> +            btrfs_is_empty_uuid(root_item->received_uuid))) {
>> +        error("Subvolume id: %llu is RW and has a received uuid",
>> +                root->root_key.objectid);
>> +        rw_received_err = true;
>> +        if (repair) {
>> +            ret = repair_received_subvol(root);
>> +            if (ret)
>> +                return ret;
>> +            rw_received_err = false;
>> +        }
>> +    }
>> +
>>       while (1) {
>>           ctx.item_count++;
>>           wret = walk_down_tree(root, &path, wc, &level, &nrefs);
>> @@ -3722,7 +3736,7 @@ static int check_fs_root(struct btrfs_root *root,
>>
>>       free_corrupt_blocks_tree(&corrupt_blocks);
>>       gfs_info->corrupt_blocks = NULL;
>> -    if (!ret && generation_err)
>> +    if (!ret && (generation_err ||  rw_received_err))
>>           ret = -1;
>>       return ret;
>>   }
>> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
>> index 323e66bc4cb1..d8f783bea424 100644
>> --- a/check/mode-lowmem.c
>> +++ b/check/mode-lowmem.c
>> @@ -5197,8 +5197,17 @@ static int check_btrfs_root(struct btrfs_root
>> *root, int check_all)
>>           ret = check_fs_first_inode(root);
>>           if (ret < 0)
>>               return FATAL_ERROR;
>> -    }
>>
>> +        if (!((btrfs_root_flags(root_item) &
>> BTRFS_ROOT_SUBVOL_RDONLY) ||
>> +                    btrfs_is_empty_uuid(root_item->received_uuid))) {
>> +            error("Subvolume id: %llu is RW and has a received uuid",
>> +                  root->root_key.objectid);
>> +            if (repair)
>> +                ret = repair_received_subvol(root);
>> +            if (ret < 0)
>> +                return FATAL_ERROR;
>> +        }
> 
> Not sure if we need to error out completely.
> 
> I guess continue the check would be better?

There's that, but we still need to find a way to signify there is an
error. So for lowmem mode the possibility is to introduce yet another
bit (from 26 to 27) to signify this particular problem. Ok, will fix it
in the next iteration but I'm still waiting for more feedback,
especially from David.
> 
> Despite that, everything looks good to me.
> 
> Thanks,
> Qu
>> +    }
>>
>>       level = btrfs_header_level(root->node);
>>       btrfs_init_path(&path);
>>
> 
