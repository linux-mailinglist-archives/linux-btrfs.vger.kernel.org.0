Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7512595663
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiHPJaw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 05:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiHPJaJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 05:30:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB0DD51F2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 00:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660636221;
        bh=ySKUGR+bCMe0V7jvI8tvUhcj37WAZLSbQpWl1RLLwnM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=bgZt8e3/HVNpiHBg3MWA+fR/U8atVGKvQ+QI33Th5FlRNNP4jdg2MNk7jaRCVwx67
         JyBCQ5ckG9ftwAf5K1kvzCQn4X1xUM9VJYWfawofGAtNF5zS2IKLT8OiJQKXL0Bxbm
         4DAkqH8+hSY4JXc8DF/su1fhXer8YRCd7jaLEytk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1o93DO3Krm-00H3Yp; Tue, 16
 Aug 2022 09:50:21 +0200
Message-ID: <c48fd0c4-64b4-cce2-273f-90c6940e3d99@gmx.com>
Date:   Tue, 16 Aug 2022 15:50:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] btrfs-progs: avoid redefined __bitwise__ warning
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220816013703.72722-1-wangyugui@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220816013703.72722-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xi9Cs6+bTDF/NT6KuGV489emJIDOs9IiLNKM8KExIEJomN7ueNk
 C6HQRqenrBzU0N+OCIgN2B8IBlajXxzoPkQ9XHREP3CTD0Gha76U7ZtXeO4q4cA4zkPAZYQ
 QToLh+wpMmNQkxlQGE9rJDrDAnzpy2yErQ8exZmpaS4ACyU68+k49QIuQhKaj3EppO9OIsQ
 QY/FUUGW1ArdZhYDKWsGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r3j3ahFZWNk=:tTz+A8DXP7yqx47uKPaJWT
 XjEu7aQU2ow/fUR955X/AbQk11+5F1wdEhjUoQFU1CAETljp+1/KsHKUQKAxbHykDAQTcVXgA
 AbHwr0OR4h5TZP1M2iJYM3ruTHcet01ZIeUCwEGbM10vFpnNFKlTouayX85DcR57sZklrphzm
 3AHsj1yGfvD6PM/U6kEC6EXJkNjqu0CsqgT9VeNuWb47C5r7kQJUJWzrzRxUTfnR2Jgg7fTt8
 sVc1Oe/OIrkTO1ekbQJeo2EUFCHOUnVqM4rM6g8ANR9GScrc5mTq5Gf4NZMnnSUC8EsMP5ElF
 5wRx6tYul+vDvRm9phFy++9wLZQt4bmpHdAWvLhEIlmwOTPrkSTsq5ZuClYGJN7sIxaSBCTw+
 l5i3vR5TgiKFHD63n6EBZN+6s/EaH1tbgRz78tdntph98w5K25dtzNIobbAnyIOjalm0l0mWH
 Emcq/YSi/TcMVralVE44ckTJn5y8xY8/mrsyb+wEWWR5LoFW6r9kcP6sIyk4iTJ0taO7NN5YF
 xNm7fEC7pBSIzUiW2E+OXfPHjv3IyZ9Pf51c0IHE/G9v4gb5zyC14ibmbOL3mrauxIbQHzgos
 GvsOdwwljRo3bc56jWt/ub0DmlJhed28xgqPmnXlPNTjB7VnS+8ikxfQackoyNmcqco1heg7o
 gxbj01GsYla8N1EsDAYKB8gPfcAbHxaEGiY5amJgmrPk8Wewt9KmZEHZhjKjS9IYLbhhGOoWe
 kv8ylXOmd7AG9PAPs+H+H9R0m9YTm7rgZe81KSeL5FXhroSd//MErVL/anlC/Cd1gddnArF8c
 2Ps28GzoYWwXpcJVDNbdk6c2E0biaCkHyluicUVED8WFDTItUkvp3yxKnGm3tjyKtQlyvrsKy
 DpXZoYYQCjlz8gMZNa4uIgR06ygnYNL/GmH7TlnBfbPTY4YNczwlbQB8hmLzQilut1yBRfuUn
 mZJ159Df6Bwd7wzLkDo4D/mtR0BlW9qv81z0MyY8F8wQDvaCvxCXX/9igqKvoQUk+2LWsuqBj
 NKrEqQVT9UHYkJSHM+/ABAg9EszS5fW8EACvvrq2gVHm7DL82xdkhdgRoL0tNliO/mRapWYJB
 8jl9yCOL4lqC3rlayqQYaVsLh6erkxKa7GK1TQxPbNpZ6enU2/FIJfQ7g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/16 09:37, Wang Yugui wrote:
> compile warning:
>      ./kerncompat.h:142: warning: "__bitwise__" redefined
>      #define __bitwise__
>
>      In file included from ./kerncompat.h:35,
>                      from check/qgroup-verify.c:24:
>      /usr/include/linux/types.h:25: note: this is the location of the pr=
evious definition
>      #define __bitwise__ __bitwise
>
> Because  __bitwise__ is already defined in newer kernel-headers
> (/usr/include/linux/types.h), so add #ifndef to avoid this warning.
>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   kerncompat.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kerncompat.h b/kerncompat.h
> index f6477990..15595500 100644
> --- a/kerncompat.h
> +++ b/kerncompat.h
> @@ -139,8 +139,10 @@ static inline void bugon_trace(const char *assertio=
n, const char *filename,
>   #define __bitwise__ __attribute__((bitwise))
>   #else
>   #define __force
> +#ifndef __bitwise__
>   #define __bitwise__
>   #endif
> +#endif
>
>   #ifndef __CHECKER__
>   /*
