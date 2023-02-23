Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175F46A059C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 11:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjBWKHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 05:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjBWKHd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 05:07:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1AF3B841
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 02:07:27 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1oWo5t1NRE-01399n; Thu, 23
 Feb 2023 11:07:22 +0100
Message-ID: <41570e39-6e49-8cb5-c2f1-4b77ed8260be@gmx.com>
Date:   Thu, 23 Feb 2023 18:07:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] btrfs: fix percent calculation for reclaim message
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Cc:     Forza <forza@tnonline.net>
References: <6107ccae94e0af75c60d1d1f6a5a0dd59aaafc58.1677003060.git.johannes.thumshirn@wdc.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6107ccae94e0af75c60d1d1f6a5a0dd59aaafc58.1677003060.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Gp4Xll7/hOyr//Ty6CaH4Co7tlGqgcOs7TXMt99d3XXjcniRLPZ
 mVCH9nFd+06L9wkzFEdOnD2XBNr7hoceE4XYPSNKTsB/Hj3kHjEHlZ8L+eTU7Ms2KLQGhNy
 LlnElK5cpJ2LF53loj69lVJ5I7o9vu1uDneKI9uiMCar29ogvM+jQ40nJFn2cLPIghUY3rD
 brnC1yiIAjjBa2L7woJPg==
UI-OutboundReport: notjunk:1;M01:P0:nQ/KjRtlbp4=;+JSyOv1wV74b7PeVBtiSCysNGFP
 U+MrYfT8qx3zFMM2jffZ4id9Op4Kx+t55gw8MpTrnS3HuASf4wo5kAQFl3voyQA+fgeLkDr6G
 uhuqdu/ji4fQEVIMGLX8Vxqe0nWzjRvNhy9Z5VbqkeILnx+GAIKDHEREKiSJEjsh6b/qA9a4y
 HTZmCNe8JpsnQ2tQeHLQvKMCdOAcVZ2bIOrD5xoR6Ybgj7IbS3jWa66HdC64lWO+o4/a0pmDZ
 Yxg+RUMxpzG0Gb+ZV88r6Rd2YwDsOkERuwPBAEFmvBAXQrrJtbK5326KzlP/o0pU6k5dPsJtv
 Ia6w76C8gfsootKgK6jenmYElTM+wW3AS2BYbapT9eLiZ/RDiQnmFSeOFWQxRycgRaSko2HEh
 8XARNIxOknXaNZhRAIaD3HVuNDYXk81FrHqYoREnxrTyFytNN0PRDwHoIeisBDyEC8dTEzMRA
 deKd9OLQrEEAr8PU2Gl1K/+ijbxP7hL/g3mrnSseN4JflZaUYFs/YbNPQdlzdCD+L1flXVLqu
 F4lRyGEIOsrBirrvS8P5R4Ka4Lg+vMcBZ9RxDqdc7SL4omrozvVWWdRlvamtaqNJOirh7KOqs
 AU4HRqmjHMHHyCntN0o5lPJUyrM5Lfh8CFpNprcMbCoCbLyYnJqIaSORDdEemgQ4Cn96dPPLG
 jowzat/gizzaU2Z1jyRG5iDJg1S8dbfzKbUUugPiKI+hj3P+A8txkUuGcpAjt+pdl4jmogmx2
 Q64IR/uNxNlVCnTTWs38/FiZzaL2BhuyP8CK5CmXBaKHnUEsNffW6y8CrzJZmFaFr1S2s1qZD
 cyZulhoajiEOmewf1G5itfNj6oj2gcHVW+cBvMJYtG8yLCHtnRuJwkyRva/+aLfpC//OYm98y
 Q+tIdOmiqSjODxC6xJwPN8h6N4UomZgtSGe+ZUyIhSHkQRUPf4xuKMybC2svWqI8BAQuOrjKn
 UIWa5azStD71ufJyruxxwv2dOnc=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/22 02:11, Johannes Thumshirn wrote:
> We have a report, that the info message for block-group reclaim is crossing the
> 100% used mark.
> 
> This is happening as we were truncaating the divisor for the division (the
> block_group->length) to a 32bit value.
> 
> Fix this by using div64_u64() to not truncate the divisor.

Reviewed-by: Qu Wenruo <wqu@suse.com>

In the worst case, it can lead to a div by zero error.

And I believe it's not that hard to trigger, just 4 disks RAID0, and 
each device is large enough, then we're doomed:

   $ mkfs.btrfs  -f /dev/test/scratch[1234] -m raid1 -d raid0
   btrfs-progs v6.1
   [...]
   Filesystem size:    40.00GiB
   Block group profiles:
     Data:             RAID0             4.00GiB <<<
     Metadata:         RAID1           256.00MiB
     System:           RAID1             8.00MiB

Maybe this can be turned into a test case?

Thanks,
Qu
> 
> Reported-by: Forza <forza@tnonline.net>
> Link: https://lore.kernel.org/linux-btrfs/e99483.c11a58d.1863591ca52@tnonline.net/
> Fixes: 5f93e776c673 ("btrfs: zoned: print unusable percentage when reclaiming block groups")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/block-group.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index fe4a60d7a49e..c6b9d5a04f3e 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1826,7 +1826,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>   
>   		btrfs_info(fs_info,
>   			"reclaiming chunk %llu with %llu%% used %llu%% unusable",
> -				bg->start, div_u64(bg->used * 100, bg->length),
> +				bg->start,
> +				div64_u64(bg->used * 100, bg->length),
>   				div64_u64(zone_unusable * 100, bg->length));
>   		trace_btrfs_reclaim_block_group(bg);
>   		ret = btrfs_relocate_chunk(fs_info, bg->start);
