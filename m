Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED46C64F602
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 01:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLQAWm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 19:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiLQAWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 19:22:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679F5897EA
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 16:16:11 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRMi-1pTX692PwC-00ThLB; Sat, 17
 Dec 2022 01:16:06 +0100
Message-ID: <b33c3770-51d5-05ee-f0e2-d3f457cb7e58@gmx.com>
Date:   Sat, 17 Dec 2022 08:16:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/8] btrfs: fix uninit warning in
 btrfs_cleanup_ordered_extents
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
 <8224d05027554e265bb92bd4a7862950e6c7d224.1671221596.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8224d05027554e265bb92bd4a7862950e6c7d224.1671221596.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:v2sZK5ZWDuyJWuPl3tv4jeDZWGeFbGuVb26F6cI9WOICPYy/+8f
 E+sXWsJH0XD6ChOufKwpCTW1uVJcMI1uhqsWxIQbJX5x7GHHU0zXaOApoqsHPVM6PxfzlR9
 UQg2cj6COiYPGK6+auBOecSYBvKAbRVpZElnZJUmlaRYJMp9oEhfvZT43cilKCQOmXM1Pgg
 9fWqUn8pZKOwWFXkxiK6Q==
UI-OutboundReport: notjunk:1;M01:P0:dY1FM9xjUGw=;66gc1asJUXdnL1ooCFRImnyUmu4
 WiFvp7uGp+LSi6myDi7S09jGxo9BvsYaJ2JN6MUp6y/PFrrTptOMOsMU38T8fUIoBiBHv5QkS
 hnL1jXhANCEQIzIZWFgSlMMVvZyo3/R7NnlQ4uhvc54p/hy4HsKA+0ai9ofOyBsFhFCoj+euL
 prn1FR8gZuFmZyKunLuXTGXwG7/7W+LfcRch6KF/MYv8OStZ/Oayr6mDcY8iuHV0KgJDDrjcy
 Dq+U1VNH8yzPOMD/Cer7GEp3dzyTkJ4u6rH3+WgXQv75xd0YE7wcwhdIJnIGpCTIsqH1VvW7H
 CNv6YGFidtEqtmzqZRSwWF6q/+XIvXZMuFWGCYJy2QeDNTrWNy0nTYONiZLrJSiiktXNTDx97
 V6Nbyt5hEhC8SCe21ToTyjPK4vIbkWhzgq/l2PO6lGVwIaEprOgk3uGWwtpd6zE8PIOuVi6x8
 /YuDiKX9s5LvBOPck2iUZSiwRvtOh42+UNNoo/o+SBIkmcVghx1j1dugOvxV0CRgOgg3l6+D2
 sdczvVFo8pOZBPWmWTbbfGUOJa4sXBMCPkvVV7FWULuniGjAu4VLD074irqzrqSWRa2fmHAsy
 qPMZRTF7Jm0c1k7ZIaqscqEtUdyJo0aZPg8wWp4MFSAWK3MFOlVrnnEsQ+e3V5yQCO2CDcOX+
 0bDuhJkJhrtutWFkJbfqEfxUALroutVe8RaHBjeEVdM4rZLYoJqwYnW5Jk+kcXpM/DwurnqTN
 hTmk9UZC/PD3FUebIxKwDDybXf2IiDMB3rWPsLraji0BaFicmEgY8u2+r4imjuh1BRE98AATS
 X2ilf3jisaDh+flBfb3uqLyiey1Kp8x2s6Q+doEeoB3pND4SkJuPTdqJN6dcNXMTvmAZPSJ22
 ioz+eFQ5knGbJeVWZvyThscwTFmLQJGCiWfolbXBb/oPsqGqzlruHdTDXJieYVnoDcAHfeE6p
 vdkK1Ezl4QQfqI5J/6vrRLzO2nI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/17 04:15, Josef Bacik wrote:
> We can conditionally pass in a locked page, and then we'll use that page
> range to skip marking errors as that will happen in another layer.
> However this causes the compiler to complain because it doesn't
> understand we only use these values when we have the page.  Make the
> compiler stop complaining by setting these values to 0.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 905ea19df125..dfceaf79d5d4 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -228,7 +228,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
>   {
>   	unsigned long index = offset >> PAGE_SHIFT;
>   	unsigned long end_index = (offset + bytes - 1) >> PAGE_SHIFT;
> -	u64 page_start, page_end;
> +	u64 page_start = 0, page_end = 0;
>   	struct page *page;
>   
>   	if (locked_page) {
