Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BAD660DE6
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jan 2023 11:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjAGK0c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Jan 2023 05:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjAGKZ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Jan 2023 05:25:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9743A8BF17
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Jan 2023 02:23:58 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBDnI-1p4mgy1Ezu-00Ckph; Sat, 07
 Jan 2023 11:23:51 +0100
Message-ID: <a4d6650d-1055-a06a-6277-bc055436f117@gmx.com>
Date:   Sat, 7 Jan 2023 18:23:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Hao Peng <flyingpenghao@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <CAPm50aLoApkx5SCCmKj8+tFWNn9TbyJssaJFmQW-wkT1HD35yg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: adjust error jump position
In-Reply-To: <CAPm50aLoApkx5SCCmKj8+tFWNn9TbyJssaJFmQW-wkT1HD35yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kJA5Q6463YwEzgswOlPN4es74T+6OYOK0oOcm0kgYHKB64glG53
 g4XmGb31D52tjrHxCrxWB0WTPDQj7CsUFkowh6dOs3i5C8IkXwwpSKGbCwmQTRuiOJOKV8F
 u/ZG6SGW/VIJMbD1LZxl+pJeaqVlhJ+HfotcY7xRpuwI6evcarSLyT15glh7U684eMvMI42
 xoCF6wZC1+Or9zPSgRdxA==
UI-OutboundReport: notjunk:1;M01:P0:Y5ewqnFC30s=;OEameM1e+8SnyQpm2vLGDwWZ/55
 MDHWZdycKBgyjtnaCg61elD8ZU3VjTXOW42+URHGiu9Q8M60eVbWSvfo8w0tdPzCKa1Fq3rcs
 3+OODqGfAERYbYPBxgrogcEnvo3SoDEW9hU0/vpiTGLCNomTvmYFIUPzVSOIVfHSSN6tyyRm6
 4zeShYKRs3nZcpFRPQbNcsq8Rbc27brOV1hafhOIlxFFUdn6rky0nT/nEGWYifaruBqCS0aNX
 5Tc7ePRQnGFG/se9zSLcR3Pp5Yfwq/B900BHdXpUrP36sg3Foa+NlSw4cH6x/6d8/WhCGJalF
 gnQirduyKIXC9rroDqoU8NxewxbD8ae7IoYITx6cDcP59TV5h4m32sEPs2OlpZNNAYUF3SVF9
 83ptqo6wzvOidbbtWNtRe5MuAyfTn5PrPVb1pM0ldaMahtXWMu4FaFjPy15JDYrc/awtNl40s
 7xbiIXutvPQ5m5ZzbrUkX/OXPiVE95X1UsqlLYE0oqwugqQOOb+3P2U0eSvVuga3z42fagvyI
 9knlCJLNOIzLl/+CbTapXEi0ZeLidIEehPW+axaryQdjSlxG7NTb2dIpMkmF9IbC61h1ijr3G
 W/kHLuta/yt6ORcx8dc9mC0NMHJd2ixZ/rlh7T1eA080ruowViv78kWLEuh6KfIVu6o7n3nYi
 GMnzFR421g9YK13FNIr022srKUApYwmqp5SaUYwzmhQM2/Q5x2QFlz/eP5TMu3fjYDbM1JhtZ
 +pydbdm50orwkbxUFlUrkRqjkmiOvBO0ksh12AL4kcX7H+/T4xE2VDxkjsjZUNAQ1n/7aD3qX
 OGtc+2BGWBeErbJUCUusSQkKx3lTcU2DM/AQVFDTckyOvuQtTK3RnOmDsHCWg8b1146XtpaL3
 NsZJGbbq8b7BarC8WdwA2yW1+mmVDG+9nZCdYklBkWT3aO7QA0+H2+a45IJLR6YFlgarmzSoZ
 gA1B4gNepIZOJXsCKEfwJuTQh/E=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/7 18:00, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> Since 'em' has been set to NULL, you can jump directly to out_err.

Then why not remove out_err tag completely? Since free_extent_map() can 
handle empty pointers, and only keep one exit tag is helpful.
Otherwise it provides no benefit and even compiler can optimize it better.

Thus I'd recommend consider the benefit and put it into the commit 
message (especially under your company's name).

Thanks,
Qu
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0e516aefbf51..0ee2e82d6be2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7997,7 +7997,7 @@ static void btrfs_submit_direct(const struct
> iomap_iter *iter,
>                  if (IS_ERR(em)) {
>                          status = errno_to_blk_status(PTR_ERR(em));
>                          em = NULL;
> -                       goto out_err_em;
> +                       goto out_err;
>                  }
>                  ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
>                                              logical, &geom);
> --
> 2.27.0
