Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE4E71424F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 05:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjE2D3X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 May 2023 23:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2D3V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 May 2023 23:29:21 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3482AF;
        Sun, 28 May 2023 20:29:17 -0700 (PDT)
X-UUID: 0a3d9e25f7e642aab2a349ed109e0856-20230529
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8b011c80-db7e-4bf6-807f-ae12dff5c8a8,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:8b011c80-db7e-4bf6-807f-ae12dff5c8a8,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:d507a33c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:23052622413414FINTUN,BulkQuantity:2,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 0a3d9e25f7e642aab2a349ed109e0856-20230529
Received: from node4.com.cn [(39.156.73.12)] by mailgw
        (envelope-from <pengfuyuan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1110830383; Mon, 29 May 2023 11:29:02 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
        by node4.com.cn (NSMail) with SMTP id 1885516002C04;
        Mon, 29 May 2023 11:29:02 +0800 (CST)
X-ns-mid: postfix-64741BFE-284645
Received: from [172.20.20.15] (unknown [172.20.20.15])
        by node4.com.cn (NSMail) with ESMTPA id 0380C16002C04;
        Mon, 29 May 2023 03:28:59 +0000 (UTC)
Message-ID: <871f146c-2fd8-4322-2288-4be90c0baf8a@kylinos.cn>
Date:   Mon, 29 May 2023 11:28:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: Fix csum_tree_block to avoid tripping on
 -Werror=array-bounds
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523070956.674019-1-pengfuyuan@kylinos.cn>
 <a79a7e9d-f6b5-00c8-65c8-f914cf0be0b2@gmx.com>
 <20230523193212.GA32559@twin.jikos.cz> <20230526143514.GA575@twin.jikos.cz>
From:   pengfuyuan <pengfuyuan@kylinos.cn>
In-Reply-To: <20230526143514.GA575@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 2023/5/26 22:35, David Sterba wrote:
> On Tue, May 23, 2023 at 09:32:12PM +0200, David Sterba wrote:
>> On Tue, May 23, 2023 at 03:33:22PM +0800, Qu Wenruo wrote:
>>> On 2023/5/23 15:09, pengfuyuan wrote:
>>> Although even with such change, I'm still not sure if it's any better or
>>> worse, as most of the calculation can still be bulky.
>> Yeah I think the calculations would have to be conditional or keeping
>> some state. I'd like to keep the structure of the first page and the
>> rest.
>>
>> Possible ways is to add extra condition
>>
>> 	for (i = 1; i < num_pages && i < INLINE_EXTENT_BUFFER_PAGES; i++)
> The final version is
>
> 	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++)
>
> ie. 'INLINE_EXTENT_BUFFER_PAGES > 1' can be evaluated at compile time
> and result in removing the for loop completely.
>
> Pengfuyuan, can you please do a build test that it does not report the
> warning anymore? The diff is:
>
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -88,7 +88,6 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>          const int first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
>          SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>          char *kaddr;
> -       int i;
>   
>          shash->tfm = fs_info->csum_shash;
>          crypto_shash_init(shash);
> @@ -96,7 +95,7 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>          crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>                              first_page_part - BTRFS_CSUM_SIZE);
>   
> -       for (i = 1; i < num_pages; i++) {
> +       for (int i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
>                  kaddr = page_address(buf->pages[i]);
>                  crypto_shash_update(shash, kaddr, PAGE_SIZE);
>          }
> ---

I did a build test on the mips64 architecture, the compilation passed, 
and it no longer reported warnings.

Thank you very much and wish you a happy life.


Thanks.

