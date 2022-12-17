Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B49964F61A
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 01:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLQAYF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 19:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiLQAXd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 19:23:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D3482DC4
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 16:18:24 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dsb-1os1ap13av-015dAS; Sat, 17
 Dec 2022 01:18:19 +0100
Message-ID: <dc3edf3b-a287-69d0-d6d3-4b6704dda30a@gmx.com>
Date:   Sat, 17 Dec 2022 08:18:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
 <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HwPDaiSAKVzDs4jZcRei1BrT+h/apds7uXQNHrWZA4OtSNKGEwz
 t/qlMdGACrbD7LyPxCI5+AAcHpW5SBIqZRC+YqTkHOVF0Q2Odx9fJpwjoO6VUA6bilqkxfK
 TLfyeYPuD7ND+nFv3UPCSrjSIXhJAcTl9oBPoJV1rElIpva9Hu7tbjA3heVtuEVGD1Wq58T
 DmMuI9W2A3r7arGvqoG7Q==
UI-OutboundReport: notjunk:1;M01:P0:nj2s9ASTNNw=;r9o+CWVLbqHP5V8z42KpZOeUk3S
 R1zQ34GtDGbW68ezBgBwy5XbLNTcepjLLsGUDfcN78qfbSLW1BcGaR/LTFc3elpYEk8XfyJWV
 P01t1IW5zzbWGYwD31pGBWBYMjx5e20BsQNlffPLHOcgd401Lo5vdfkdT2fAl343BrODdrJL1
 qP0RZ7Ixk18D2fgL6RQkiZivC2Ibq3oDjx6giL3vhhVM8czTFZK7Sa7EQYpPDHID5/+RfZjAY
 fpPGerZ5A8Cem4+o31uWznxpeWFjdHnvId/RWlVQ4L9DCQO1EWgnVCK1tsW31yR5oxH6/lk+X
 pzkOke4CYiHphdMhpGjZuYjmzC89aYx6SiM4wkWfiqa99WHlyAmAWT90Exbo3B9TL2Q0i/sJr
 U1xtHNLrfPjT46Sl+6HPDlqZU7SYFOmFUEspI1bxHiF3hWB0luvPoQcXpMbgqG92FoYncWLwN
 s/JMUZkVHb7FQuLPBQky2M5CnY5SYxBwCgl2MTxXFjSRe0JzpTO5lgZMbk5mrJZfYWsTibhJI
 L6vlx67qlYuzcwwlfBUjKfCqMozGa7y0pxI+BpgeZlhJBmCypLYpVgpM9ApYHZoD2a2+btW0v
 CttMYPxL1p362P7315nQqtb+jg6fZ3LOnkf4k9J8NmdR6pvhlcib5VppkYP6Vazoc7vo8XqQM
 NFXdAuCIexeU5ZoB6jpgVKW3i3Wufsbc/37N8CKBjTL/3rX2+vsoLYoasFm1PGs7mAuWeEPpM
 p00vMeDN/9CMfWviqdL7QGoeGs3NYbPLRTKdVyWNenfBqhevv07EddxWMbCJ6qXsbbCDq7V/c
 pqRrGksTlGs4JtOapxB3g/1Y/+9zo5RNd4Jnf9VGWcEtZiGIgQ6TaTZFGQCt1rojgF23Kb0e/
 xIgcryoeDnSmQLQRTWL635OdUTJLRIeFt5BXeyo1LETn4IpdS45Kx+3G9iVtzWMMEyKPf58UD
 0DW5kCoR8NOETqxbhPoe4hGop4E=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/17 04:15, Josef Bacik wrote:
> We had a recent bug that would have been caught by a newer compiler with
> -Wmaybe-uninitialized and would have saved us a month of failing tests
> that I didn't have time to investigate.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Tested with gcc 12.2.0, no new warnings.

Thanks,
Qu

> ---
>   fs/btrfs/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 555c962fdad6..eca995abccdf 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -7,6 +7,7 @@ subdir-ccflags-y += -Wmissing-format-attribute
>   subdir-ccflags-y += -Wmissing-prototypes
>   subdir-ccflags-y += -Wold-style-definition
>   subdir-ccflags-y += -Wmissing-include-dirs
> +subdir-ccflags-y += -Wmaybe-uninitialized
>   condflags := \
>   	$(call cc-option, -Wunused-but-set-variable)		\
>   	$(call cc-option, -Wunused-const-variable)		\
