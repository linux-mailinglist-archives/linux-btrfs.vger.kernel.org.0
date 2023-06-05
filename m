Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8A87231F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 23:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjFEVKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 17:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjFEVKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 17:10:54 -0400
Received: from libero.it (smtp-34.italiaonline.it [213.209.10.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187DED
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 14:10:52 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.140])
        by smtp-34.iol.local with ESMTPA
        id 6HTWq2vv9bjox6HTWqo9hg; Mon, 05 Jun 2023 23:10:51 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1685999451; bh=4aRUnF55/r+Hcrj3/SdPSCFDOz5th2pfhPLzYiTGgSY=;
        h=From;
        b=IOUcEulJM3GIxLLYXZyWGxF1uuwtezfDsJmi0ZjaHP7kQYDUnd1B3rxDzSvCXhuts
         RrU0TuGmAmddvu0sE41oDtSJhBT8wR9HyL/NW242k9L0brKa2GxuUWnv2mNbsl7qjY
         dBlUp6OLWIW0Y/hv6kNZxNoZpOgrCvCOjOu/+OPslWXaxjOYLwjUwYbwXwgaJqozpp
         v9IctXBgN0/XZc+GOLL2jPok7TSIuc/75OlCVap7WpYzFrMCUT3GUyliPnCCBD6Th1
         jDD+fE9yNxtVfLeiroVoAOnkaarqIzTCnAOVmj7hFBdxOVAz1anJ7xS6n0YNUSV3+d
         5g/Xq7qO0HhZA==
X-CNFS-Analysis: v=2.4 cv=Q80Uoa6a c=1 sm=1 tr=0 ts=647e4f5b cx=a_exe
 a=SDvFMQE/2DkMPFoCQNiONA==:117 a=SDvFMQE/2DkMPFoCQNiONA==:17
 a=IkcTkHD0fZMA:10 a=eXWbqwVcqhzD6vftIbcA:9 a=QEXdDO2ut3YA:10
Message-ID: <ed8c45b9-1b83-d706-add9-fa2d5f41576d@libero.it>
Date:   Mon, 5 Jun 2023 23:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v3] [btrfs] Add handling for RAID1CN/DUP to,
 `btrfs_reduce_alloc_profile`
Content-Language: en-US
To:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <276ea9bf-13f3-1349-a5b6-4dfcaaab7ef2@bluematt.me>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <276ea9bf-13f3-1349-a5b6-4dfcaaab7ef2@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKBZ5Pop8Iz0DovO/52zv/NazZkiIlRSmgFbWRfYpmsgYMNCZLaBECRf3RWKfjL6uiPdbmSNnxgm+EDBqkHI1j7qKOyfQ9tiRdaCvP2/zniC8LO0DRQb
 p0pS3XYGnh7Ntjn1gWNfTylsntXUa5OfoQuXMpEvLTNH+tzwYgtZoVksbPhqRkEWTRdtru2JplGFPpxZCnqOL4cVb5ZBQONLXAPtwoaB/uIN2IcGtK+j4gxp
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Matt,
On 05/06/2023 21.31, Matt Corallo wrote:
> Changes since v2: added fall-through WARN_ON to make future debugging easier and handling for the DUP profile.
> 
> Callers of `btrfs_reduce_alloc_profile` expect it to return exactly
> one allocation profile flag, and failing to do so may ultimately
> result in a WARN_ON and remount-ro when allocating new blocks, like
> the below transaction abort on 6.1.
> 
> `btrfs_reduce_alloc_profile` has two ways of determining the profile,
> first it checks if a conversion balance is currently running and
> uses the profile we're converting to. If no balance is currently
> running, it returns the max-redundancy profile which at least one
> block in the selected block group has.
> 
> This works by simply checking each known allocation profile bit in
> redundancy order. However, `btrfs_reduce_alloc_profile` has not been
> updated as new flags have been added - first with the `DUP` profile
> and later with the `RAID1CN` profiles.

Does SINGLE is missing too ? It should be replaced by
BTRFS_AVAIL_ALLOC_BIT_SINGLE...
> 
> Because of the way it checks, if we have blocks with different
> profiles and at least one is known, that profile will be selected.
> However, if none are known we may return a flag set with multiple
> allocation profiles set.
[...]
> 
> Signed-off-by: Matt Corallo <blnxfsl@bluematt.me>
> ---
>   fs/btrfs/block-group.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 4b69945755e4..60b3fe910a4a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -79,16 +79,28 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
>       }
>       allowed &= flags;
> 
> -    if (allowed & BTRFS_BLOCK_GROUP_RAID6)
> +    /* Select the highest-redundancy RAID level */
> +    if (allowed & BTRFS_BLOCK_GROUP_RAID1C4)
> +        allowed = BTRFS_BLOCK_GROUP_RAID1C4;
> +    else if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>           allowed = BTRFS_BLOCK_GROUP_RAID6;
> +    else if (allowed & BTRFS_BLOCK_GROUP_RAID1C3)
> +        allowed = BTRFS_BLOCK_GROUP_RAID1C3;
>       else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>           allowed = BTRFS_BLOCK_GROUP_RAID5;
>       else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>           allowed = BTRFS_BLOCK_GROUP_RAID10;
>       else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>           allowed = BTRFS_BLOCK_GROUP_RAID1;
> +    else if (allowed & BTRFS_BLOCK_GROUP_DUP)
> +        allowed = BTRFS_BLOCK_GROUP_DUP;
>       else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>           allowed = BTRFS_BLOCK_GROUP_RAID0;

+    else if (allowed & BTRFS_AVAIL_ALLOC_BIT_SINGLE)
+        /* BTRFS_BLOCK_GROUP_SINGLE would be 0, so
+           use BTRFS_AVAIL_ALLOC_BIT_SINGLE */
+        allowed = BTRFS_AVAIL_ALLOC_BIT_SINGLE;

> +    else {
> +        /* We should have selected a single flag by this point */
> +        WARN(1, "Missing ordering for block group flags %llx", allowed);
> +        allowed = rounddown_pow_of_two(allowed);


I think that it is more coherent and safe to return BTRFS_AVAIL_ALLOC_BIT_SINGLE,
when we encounter a new unknown profile.

Coherent because btrfs_reduce_alloc_profile() selects a SINGLE profile when there
is not a valid combination "selected profile" and "enough disks number".

Safe because using rounddown_pow_of_two() assumes:
- the highest bit is the safest choice
- a new profile will be represented by *only* one bit
- the higher bits are only used for select a profile [*]

Even tough all these assumption are quite reasonable alone, I am not confident
that together make the code less brittle than before, which was a goal of this patch.

So I suggest to return BTRFS_AVAIL_ALLOC_BIT_SINGLE.

BR
G.Baroncelli

[*] for example see BTRFS_SPACE_INFO_GLOBAL_RSV

> +    }
> 
>       flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

