Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23273710A26
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbjEYKcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 06:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240946AbjEYKcA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 06:32:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD211A1
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685010713; i=quwenruo.btrfs@gmx.com;
        bh=jfjPAcKVpPmdb2ajHTb6K4KsL5Bw+Z18I4s1qjqkUK4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=jD79JXLj3jMCqb98PR9EwtJun2G1aVAiA55GwlOguzOjQ7e/5K+UKWDbOtnEXmqDF
         ezVe8w4fOI6RVJXzONXqAbrC+3ETRR8y40glXBmMPP9Vx7kXafg986GuEzWHq2X7Lc
         nVM+kVXAXNUbThbkmv5CTgzIUTQU3bykwNI8X2qTjMK4t2FycxweAs+bBTo3XoKAXu
         yiVMRfH9x53fM8Z2ch7/LAaZ/33r8fqAXwbX9KmnsI8F3t//e1+xPBY+MNmMsVhUlY
         zUzHfF0gR8VCqyFCFdn/VR18P6bQ+2/5I0dcFMH+fv1dLPas6O5eVDNmcAJSqGGjK+
         9mYnL8+irgrSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBm1U-1ppziW3OG4-00C89A; Thu, 25
 May 2023 12:31:53 +0200
Message-ID: <2635900b-7012-9a62-e8d9-ba10c785045a@gmx.com>
Date:   Thu, 25 May 2023 18:31:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/9] btrfs: open code set_extent_delalloc
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684967923.git.dsterba@suse.com>
 <7a0532b77dd6f3571da6b17228bb19501e9b3f26.1684967923.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7a0532b77dd6f3571da6b17228bb19501e9b3f26.1684967923.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kUIeB4PAxzRB89f8wOOj5mWq90tx7Y8CK/WYFyKCeT9YU4zRE4S
 1ovThCqQnupQPLNVr7nS3/BN00ly8X7n0Wgp2PUGZQk1i881Jw3il2w1Clm3/rMjUh6N/5u
 HmfQZEwA6EEmTcz5Iva/02I2DmXnM7B5aAalMvwQ60ztw6HtNy8bEVbu8kq1ojffMCgPBUS
 vQFG3XyDtUV4aRyiNDmqQ==
UI-OutboundReport: notjunk:1;M01:P0:G7bdix+Fjww=;tCvuDato8q4Ae3l0GgZoHkx0ATj
 YamaLWkkW2peTBCXrdx4x16vqjqI3BFSx/5V+nmzVpgMyt0D9Hs7ZNavWYK99G0hIH7ZNYyO0
 HN5bzvmQ8itWMil0U3UeQO42/vmkLD42vLcZ5aWxo7aAlyB3o5CdNrfR89x2yH8eAGAi/FYl0
 wpNp/34HqqEvsmER2GTmTgvoSsc+P5KqH/vFM7bPobwM8Di1k1mvNE45DjOWxW7iPSQX4RooN
 T5Xlu3LLKDVC3UJFuGJZbeIuiieg5aUsjYSjEZTPNkVVXUsRRDuBNi7tKrC7RuPEliEsphwLI
 l1xMEvDFo9YFLN9ovq+TlUhfD6A1SLy538DDtwSvLQsgObNPEtRBZLcXnvhjSHTfsJUf56BKZ
 pMZBWbcropKqBQhCFAOdrL+HnkCiVYLRB2mqQEf+WBm3gb++acmVl4Hs6vtdmBF+DxeB7DPs0
 kMXO2EAbqkQtzrljikPZaM7IzUZOAZv9S2QYVXLTzsPSM8A8sMAOTgmOzeXOsI0UDCpMP22QV
 ZM5lXUW/hE5B58QNbm3n+7ycSsAN1+Z+FuQtJU/pkXBLRgqsiGbvGNyzioGK7Mee67ZJ4gt7k
 hguqqS3H+GwAen36z954MqwdnBvLwmqa2F9/NPBYSO2e44HjL3UV+g3jEZT2KjWltcgVx3YGC
 dJLmTbb/CcTkgpEAZTdjrfdoEWT78sGocTGAf/MUXORdMGqWFaTOr+7bfO81YKKLkOxmk6jD/
 JYfaFsBulkKjrC7HfDu7uRomiUy12IHxaYjHoh7QBjbmT4RvuMub9ywS4F54uOkp2ox/PJJFG
 s8p52muNiuY5ea3CIgeuU/OjzvnKXzZdG7tuE3cdzqxM9MefbeRcEY+n3yoNbIfdWOP9PsaIT
 TLYfdLzaSUnKh1YnnCvrLJE03Jxn+fDPWP1l668S+D6+6LfJEMnLIpolrIcqyZKMSFuOgORTf
 7IRQdugECN111ex/OITwWhqvOd0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/25 07:04, David Sterba wrote:
> The helper is used once in fs code and a few times in the self test
> code.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent-io-tree.h        | 9 ---------
>   fs/btrfs/inode.c                 | 4 ++--
>   fs/btrfs/tests/extent-io-tests.c | 6 +++---
>   3 files changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index ea344e5ca24f..e5289d67b6b7 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -193,15 +193,6 @@ int convert_extent_bit(struct extent_io_tree *tree,=
 u64 start, u64 end,
>   		       u32 bits, u32 clear_bits,
>   		       struct extent_state **cached_state);
>
> -static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 =
start,
> -				      u64 end, u32 extra_bits,
> -				      struct extent_state **cached_state)
> -{
> -	return set_extent_bit(tree, start, end,
> -			      EXTENT_DELALLOC | extra_bits,
> -			      cached_state, GFP_NOFS);
> -}
> -
>   static inline int set_extent_new(struct extent_io_tree *tree, u64 star=
t,
>   		u64 end)
>   {
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2e83fb225052..6144a2b89db2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2922,8 +2922,8 @@ int btrfs_set_extent_delalloc(struct btrfs_inode *=
inode, u64 start, u64 end,
>   			return ret;
>   	}
>
> -	return set_extent_delalloc(&inode->io_tree, start, end, extra_bits,
> -				   cached_state);
> +	return set_extent_bit(&inode->io_tree, start, end,
> +			      EXTENT_DELALLOC | extra_bits, cached_state, GFP_NOFS);
>   }
>
>   /* see btrfs_writepage_start_hook for details on why this is required =
*/
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io=
-tests.c
> index dfc5c7fa6038..b9de94a50868 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -159,7 +159,7 @@ static int test_find_delalloc(u32 sectorsize)
>   	 * |--- delalloc ---|
>   	 * |---  search  ---|
>   	 */
> -	set_extent_delalloc(tmp, 0, sectorsize - 1, 0, NULL);
> +	set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL, GFP_NOFS=
);
>   	start =3D 0;
>   	end =3D start + PAGE_SIZE - 1;
>   	found =3D find_lock_delalloc_range(inode, locked_page, &start,
> @@ -190,7 +190,7 @@ static int test_find_delalloc(u32 sectorsize)
>   		test_err("couldn't find the locked page");
>   		goto out_bits;
>   	}
> -	set_extent_delalloc(tmp, sectorsize, max_bytes - 1, 0, NULL);
> +	set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL, =
GFP_NOFS);
>   	start =3D test_start;
>   	end =3D start + PAGE_SIZE - 1;
>   	found =3D find_lock_delalloc_range(inode, locked_page, &start,
> @@ -245,7 +245,7 @@ static int test_find_delalloc(u32 sectorsize)
>   	 *
>   	 * We are re-using our test_start from above since it works out well.
>   	 */
> -	set_extent_delalloc(tmp, max_bytes, total_dirty - 1, 0, NULL);
> +	set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, NULL,=
 GFP_NOFS);
>   	start =3D test_start;
>   	end =3D start + PAGE_SIZE - 1;
>   	found =3D find_lock_delalloc_range(inode, locked_page, &start,
