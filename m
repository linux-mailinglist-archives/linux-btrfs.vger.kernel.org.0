Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A976B8CA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 09:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCNIJF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 04:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCNIIi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 04:08:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB898EBA
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 01:07:34 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmjq-1q5ALw1CDS-00TAjy; Tue, 14
 Mar 2023 09:06:51 +0100
Message-ID: <f4c1659b-f8d4-5fdf-af2c-40eaa40e77a0@gmx.com>
Date:   Tue, 14 Mar 2023 16:06:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/21] btrfs: fix sub-page error bit in
 end_bio_subpage_eb_writepage
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230314061655.245340-1-hch@lst.de>
 <20230314061655.245340-3-hch@lst.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230314061655.245340-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YhMp5LDG6NFs5mozvqaI/Y6OVGk2FcjmC94Phhtt0++c6PmfYCd
 YGOxVNbCiwBk48i1khVwUv4K7Uc+IFznOJSwz41+tZ/nO0dxmbaEghs1cFVLkkO3YhuGXKU
 N7cVhYkSD9I1bb5SnmcfkKwJHvGjv4z4RDTVqqQFQ2+s0a0XZ5MYPwn+GB5EnbN+tGQ8E2I
 0/xS7Pd6qEtCGQIhEvTNw==
UI-OutboundReport: notjunk:1;M01:P0:AhoXc+xYCxk=;/UphEObCjtJoZfzv5te+JVd/eIg
 lK4e8K3C4sZhivaba6qSkcYloR9g1hX9jl9o1BxtqXVmmqkZ23EBN/0oABxsUwwgqv2naw46B
 tqn9B42H+nDK7UNb2s+mFvUhW3KzumcpIgjKWUbitHcpl+3GGcSH7WkdwsAu6toCInFYee8tU
 CGZosCKlvUDk1CZkiH2UYF5DH1TWPsieBor7v6MmYZioo5QVgUJ7aFVQd/MfQ7a5tdWdagYnN
 FBxwfG7EWrBcWaYxGByJCJjzDnw49FUJ0CEjAk12vjQb8eoxvUpueSluLKlOWMwMAXxlU4awh
 zcCTVJLjJ+mRjUVzVBhpB32WfNlRLenrQX+aiHFe5I2J2v1O+6viaan7/ycn8loJZdUVIVHB/
 WH3t7HlVyqK3ksdjJ2mLwX8t9BemUoGOp3brNUIIZab3GZ0BbBP4/V02tupCHP72ZN3boLgg3
 FNBB7qEeigb7hTZf7/t5ZX+5f+G5d3DxXWibez5cmpvsOqS3/8O8iLHi1iPWmKiHi2LDMhp4S
 Z1yEUU4nD8/5tRyZcggtAW0zzDJ+D3FHxQJi7BRqxnH61QT6PN1VnpN4Zod7+7na5cEIMczmx
 e2wLpPGcSu1IiYNplw+7XEdf1G3eHvjAuPqSHQJQayB9sMW2Rb1hfjBrmUfJM5E01CRDccYEZ
 OpzZZ7sQXHARpCBn32XYr38Aa3P/ykr1J7MD5+Fp1aC35Bu9BRSQAEcE0Q4q9l4GrSeSu9c8c
 wrxkeCoNgALjlzfGmYd3rT0lv116gkrGN0XtLRR0+CjuTjL/1CuqwMId9tQ3R3yJfSfS022OJ
 mztthQFLDQ7YGLvCKZ1S+Ba80RCCUB8kexdfOuloiSN5Nw+vbyQwTkylEAfYafQF/IPOSlvRg
 07tVH078PGnO3UDu8++Hugt+3zVrW7GBX7kn6EfwTHdtWqN1fyFHDSjGyHPlDggJSUOokniNF
 A8jUGsS/kelqt0sTITs5htUzQTI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/14 14:16, Christoph Hellwig wrote:
> Call btrfs_page_clear_uptodate instead of ClearPageUptodate to properly
> manage the error bit for the subpage case.

I guess you mean "uptodate bit".

> 
> Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 302af9b01bda2a..2bc141b3f3bc4b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1914,7 +1914,8 @@ static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
>   
>   			if (bio->bi_status ||
>   			    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
> -				ClearPageUptodate(page);
> +				btrfs_page_clear_uptodate(fs_info, page,
> +							  eb->start, eb->len);
>   				set_btree_ioerr(page, eb);
>   			}
>   
