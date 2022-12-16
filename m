Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB8664F556
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 00:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLPXvX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 18:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLPXvW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 18:51:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B882BD6
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 15:51:19 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1ot78i47Ob-014XX7; Sat, 17
 Dec 2022 00:51:14 +0100
Message-ID: <4b75ddb6-b53f-810f-3b59-347a91fa96f2@gmx.com>
Date:   Sat, 17 Dec 2022 07:51:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] btrfs: fix uninitialized return value in raid56 scrub
 code
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <df5b246d7aa5c8eb382b1e06c7bcf7a7f2fd9d59.1671209272.git.josef@toxicpanda.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <df5b246d7aa5c8eb382b1e06c7bcf7a7f2fd9d59.1671209272.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZjywNe210X2f/KOWic6L/oVSjbY9YcxN/AKUo75m9omqYHxre9n
 NSQiMxm84syYD3TgYOLFoTAu6CmvYLj9Yxh75eXaRUp1B6XdefZCrAXVf85Di4F1BysdHNO
 cBWMOJYi+3l/w3yj0r52MfkRw2yOOPrtuv5N8yR8YgjFzIGvaUkvv1lDsHHzIK7NRmZ1L/z
 AMW5xCfDC6hr/S3fUigLQ==
UI-OutboundReport: notjunk:1;M01:P0:G/eFITpNytY=;UWTZpylwaCcOZMYeP1qWiGilqf7
 bdeddV6ayH9gpYXV3jxCg56HYLOOWQS4Ik0kyhRMl8q+C1+skpVMf4+hEIoIm4Y3Clcmqrc6O
 mrio2q9sfk8Iid6wBfWpuZVf+2R7XmkooLC8ZWy1JIrmNN8ZnnwA/O4rd5AJY5gB03XyS7tY8
 05fVFsdJgsaU2ZP3KM0TPj2THe1o0AIaXftuKOZP//T7az/Csg2kbaoOnSwmuTDDV/456CrwP
 hMJhAEwLgLJgOLsGv6BiRzSC+YDA4a1lQao41++4lIB1sABcQ0ZsqWZEOrUeuH3u6Ai2ORtgU
 bnmIZDHqEpHt3rstWwIPXCcOk2j5Ou7D2Ig8rY0/x9UBUbEL8kMUFX6t5bYqUfqhNrfoNyrUo
 J39ZqaCSlyiKI9KT/TYzW9ZidSJ5EkUY8bWrz/j7LUaEcMrnhKiuLDEj+zg4U9Wuk35RWhHJ4
 kGXLnTEU91AtVRo+JRQBkMwv3OCoiTLT82xR7ssCCSm06aIv2ml7QlMHqosdUfbOdQAmIG24d
 Z9VQwLxhenlvCIVSzB1JwvzbFjDWBtFOMtF5nagnCke6gLoEAZK0dFKwYCn5AE0KgDjkBkcpT
 XPBT7/cDI8n4+2k0TmQ+xXi4Kw/6Np+spva37sQavNxHHiUPKaKYNQhKWD0IQ/nR+BZJEASjA
 mX+7Aa+F34iGT4pF85IeXlKypWmhhhXg0netrndTLp4YecBN/WvgWKcPu/RAxEwYmHDVLLjwJ
 9OP5cApTehwMYsPas7G3M0Wu7Z7yR5zTHc3MU4+GMeP+dAma8ioGIdvESNC37GQCDLxFtPTlm
 ecJ3Yct78L61VhZEvBLSXZIML32T2cDerv/ADTR8H/CO2rVJSWx5eNrzmsrCkK9IgNMPG4N/3
 jQX60ZtEywtJYCyd3TUSUFR6A8jDi91Xfq45/BmVWtdr02KcSbsAwKtDkIy74okFgkw+OhQn/
 j1R1KhVrQJnEziF87EWAEllvoWE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/17 00:48, Josef Bacik wrote:
> Fixes: 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery
> path to use error_bitmap") introduced an uninitialized return variable.
> I'm not entirely sure why this wasn't caught by the compiler, but I
> can't get any combination of compiler flags to catch it for us.  We have
> been failing the raid56 scrub tests since this patch was merged, however
> I assumed it was a progs related thing that I was missing and didn't
> look into it until recently.  Initialize this value to 0 so we don't
> errantly report scrub errors for raid56.
> 
> Fixes: 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery path to use error_bitmap")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

All my bad.

Didn't notice that if there is no found errors, then @ret is never 
initialized.

I'm surprised my configs (for both aarch64 and x86_64) are not hitting 
the problem for a long time.

Maybe something config or toolchain setup is setting all stack values to 
zero here?

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 2d90a6b5eb00..6a2cf754912d 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2646,7 +2646,7 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
>   	void **pointers = NULL;
>   	void **unmap_array = NULL;
>   	int sector_nr;
> -	int ret;
> +	int ret = 0;
>   
>   	/*
>   	 * @pointers array stores the pointer for each sector.
