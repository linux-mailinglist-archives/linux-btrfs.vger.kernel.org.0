Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFE68B9AA
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 11:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBFKQm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 05:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBFKQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 05:16:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B22CA1
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 02:16:39 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmKX-1p9n2j41xR-00K7A6; Mon, 06
 Feb 2023 11:16:29 +0100
Message-ID: <83b8df1f-004b-7075-234b-f907f886e8c2@gmx.com>
Date:   Mon, 6 Feb 2023 18:16:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] btrfs: reduce div64 calls by limiting the number of
 stripes of a chunk to u32
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1675586554.git.wqu@suse.com>
 <275da997c70615256bed3cff8e74ab2b3fecbafc.1675586554.git.wqu@suse.com>
 <Y+ChvlcfOGHB7gd0@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y+ChvlcfOGHB7gd0@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4KGHTCFTOj7jcvS7GVVza+H9wTf8UUIFle5KECTScVt9miYVlHk
 N8oyTDKE5m+U+FrrTL/EUk8rmFlyqeYFc3bLiQDqbIxra2fkmeoB1CL5Gn6VGTdR/+LPq71
 yNLWqC1zbHBnOPTahIrAOCuL8zae4ewNA46YzWF7/BEzk4L3ZMmO+Ltku6k4j7LZsN1S2eV
 RsptQ4aYjnVPUbUsJSq0g==
UI-OutboundReport: notjunk:1;M01:P0:Dk/BmsvOQ74=;LnyQ6DY03KiI2ZKP0HXObArslst
 mcJp4EMS+kphwoNB4Hee13mdfGF8jH0w7u6d61AVavJrZlc//SWPc2XHnc9L61PhbtSR2Ihil
 JetoYbFGO6lrt09BbiI03oF64ATIT7vdu6br7aW+eiA7AgugegxPZZINSEv3gnQxTxuGu8JiS
 8hBVK8DAiU8Y9yWXXMgt5U1KYrYkaWLAky5HKZvV/x3I32AVgcXLvpEOPySJWlZwoIgB4ozZA
 I414VRujtc3BT1XYFU10VrSImwsPLjKgM6EYbXX+ji1xKTfXKcdIMI1E9g4Ch9AkZ2mTJldzZ
 6ew05qkdDJnbEQUzEekDfL4bC7wMshV89NjqoxgaPI+pfd4n0icCDUVo6a4rs6IrF+/wt6YQH
 2AM5Vh9/VwtCVW1C7Cn7rJ8Fr9ac5dSh3QezCNCpbBRHu9O9hEdrXVjsNC+dCHwDqi2+GYIGd
 RXC7BU+Ryg3vTq4VMVFq4AD+LvHTdLSQxB+1NwusffDykNP7kwOkXCOrHmUnXsqUUSyfE2xCr
 8V9rJ60uj1eMTvOd3t/wqrknipjL7x9gV1JbI+DDstL54GcgoUNoAAklURgBywtDPifpy0Z8A
 Ae5qZTfqsbl6Wuels6aEJw5bHWwyMFoubB2R0pkvdxDx1tQMoY4+QHiDxi4NnPDTfZaPRTSMl
 IuCYtYweE7SpAZW0gcr+8f06HnADezu+h10dPYfVvnY5PrLpJldgQ0F7GX/rJAeklN/aVO8JM
 2FNpS2BbUGQxN3kskC0ME+tpjavgA7SfAz3lVLJDK2FkV9wCMOtCXqxAfOONKccJdeN6jTLcr
 6V5fQiv51adbO8uD8pJBP9o8vIUMtiG0kuPWqze8X9dtDOW0SNm8DFow3RnNxT+FCPLqeuNLp
 TmU3jHK+QwZJDLtCRRJioehbLPrn6RUN8wbFWb3PUEaD8TG1hIFOfbze5O3g/Mb2dgFqMo2Th
 McG9ySh3yyjKwO9+upRiuEsYmHY=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/6 14:44, Christoph Hellwig wrote:
>> +	if (unlikely(((u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT) <= length)) {
> 
> Nit, at least to me this order reads weird and I had to stop and think
> a while.   This version:
> 
> 	if (unlikely(length >= ((u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT))) {
> 
> would be more obvious.
> 
>> @@ -6344,7 +6345,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
>>   
>>   	io_geom->len = len;
>>   	io_geom->offset = offset;
>> -	io_geom->stripe_len = stripe_len;
>> +	io_geom->stripe_len = BTRFS_STRIPE_LEN;
> 
> This conflicts with the bio split series that has been in for-next
> for a few weeks (but not in misc-next yet).

I really hope David could solve it manually.

As I'm not sure if we should really base most of our development on 
for-next, as normally that branch is not updated frequently as misc-next.

Thanks,
Qu
