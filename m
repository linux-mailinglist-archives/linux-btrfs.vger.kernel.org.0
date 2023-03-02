Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEB6A8CE4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCBXUv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCBXTs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:19:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0340E2
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:19:27 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhUK-1qLU9c2krs-00ngXu; Fri, 03
 Mar 2023 00:19:13 +0100
Message-ID: <9d67ef59-59b2-866c-b3ed-6b4020757b9a@gmx.com>
Date:   Fri, 3 Mar 2023 07:19:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 01/10] btrfs: remove unused members from struct
 btrfs_encoded_read_private
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-2-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EYI2Ch02nSSGTD5wdgg0aqlUXxLmNXyaTscQf+csmqPi481IRQc
 goPev1roZIDG+9FI79WrpyVNSTUyj4GmwhjzZiNtxn7cDO0uR4hcxptHdCHudTZq3fPIbJH
 YLXXvH7MDMo1QTCi1r5fgrrQSm08Uv0gxsa8zHitrdZ09A2JcZtbD0vCO8x9olsaUNNvoQ+
 6Rg+GVotIFAGx7N7INcmQ==
UI-OutboundReport: notjunk:1;M01:P0:gtZsm5Pr/Rg=;pkIa+s+Iw6Tb6z9/iJvX7QefNDW
 tqXnHNKreVrndfL0t1ukcwu2+nmQMVZABmShScjPGdc+lmqVUhZGnSgDepJvAWgY/oXhkg+rJ
 eSDd352/COXhPjlnY3ysV/f2vdzNWxmBjzeLvx9lE942ikJSOtXA6a9R6SWcAmDkNHLbgiQod
 9Go/JGi8VIXjilSRfEw8SN+zF7r2O3l4Iw0cXUuCnk941TZhKyhgV2GmLb+uAffpzFovuQY/Q
 u36mxyUu9PeX8y7CVYteiqEQds+0Pgb16tJN54b6gnn+xitZau5TB8xb1axFYmrkjWVfuyxj3
 H2aPEIDpTSWVXDD9atVOTcEyXEfQZyi6n6XuJplEMvn80/XR394YfFFVkmSSkEU8Hfacgr+gx
 +ur7Y9MRbGfJ5VFPamE3Buy8OfnmMrQNYja4dGhb0ncKqO9iTCS2RkDvjZJruV65CVGxI9Q9j
 SmHEcFUDHPyonn+12zy1HOpn9kWzLrRLYDoUArzwlsVaFLu7WbaZ8Q/feiO7T8YI1mOsHRReA
 6wrKBmMzoLW1VgNngpVzIBoJMlYvHexu5V47cmYXVYu03pGctEDKgIIUbaSmz1UQYdWCPW0vu
 O2pO/AhHGW+BHEav6YvTwt0LXLLY6T8fZckgdJ5deqsxBge3T5+BP5Llb/7XZpIxImxINjy3D
 3ojrHTQYWkOgjPbgHzU6Ja5kKJdEef2ZadBRs+scehVVtaG+AxBDLI9VNVgVPz6Jh0Fs/i5RK
 CIVXJ61OhI862G8tH+7ejyZ+a/pM5W0hdjDaIoOKA4FkQert4OGpNoq45KzxhtCsIn1ISKoHi
 R6MQmsw7X+PrLZ3FxVyk/pq2qmbDVIoMc9GQ4qpdK0G2x4XlKEYHYCgPpX1kYojMitNybkwDu
 vfg4JNnO5tINpb0lUr6THghp/jd6NyhmLpBEL1+sCRrTJT3eJrKyIZUQJSFHULX9HaYzFwHws
 oBKmkN61q+ZZuF1KfHICqlnsgDY=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> The inode and file_offset members in truct btrfs_encoded_read_private
> are unused, so remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ecd0aa83927949..9ad0d181c7082a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9926,8 +9926,6 @@ static ssize_t btrfs_encoded_read_inline(
>   }
>   
>   struct btrfs_encoded_read_private {
> -	struct btrfs_inode *inode;
> -	u64 file_offset;
>   	wait_queue_head_t wait;
>   	atomic_t pending;
>   	blk_status_t status;
> @@ -9958,8 +9956,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>   					  u64 disk_io_size, struct page **pages)
>   {
>   	struct btrfs_encoded_read_private priv = {
> -		.inode = inode,
> -		.file_offset = file_offset,
>   		.pending = ATOMIC_INIT(1),
>   	};
>   	unsigned long i = 0;
