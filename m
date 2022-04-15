Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A75031CE
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Apr 2022 01:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356353AbiDOWie (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 18:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbiDOWid (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 18:38:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F17BB89A5
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 15:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650062157;
        bh=P4GqT8MasZGf//1aU0JEO53MgQG4a2HCglX0DwwaBZo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EU8jcea2z+MBW/L/9nfxqlOeFcPjOS1/9puikPyGbHxWKv6mCkmgiIgCVGvp2bWkR
         YbmszJhUR/bk64ey80G/Wzxk9sjKl9sMqZiDO433G63l8SRJBPTJKllH/RGQS3P+nJ
         m6Lx71LNjoX615WqbCEhXstO7XVhV8JD66SjdmF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVeI2-1nXh2P0O04-00Rauw; Sat, 16
 Apr 2022 00:35:57 +0200
Message-ID: <3ab4f6bb-9508-a9bc-a3a9-6cbd637ededf@gmx.com>
Date:   Sat, 16 Apr 2022 06:35:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/5] btrfs: remove the unused bio_flags argument to
 btrfs_submit_metadata_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220415143328.349010-1-hch@lst.de>
 <20220415143328.349010-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220415143328.349010-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bhZ3JZVfDtSJwnnJIi5UsyWqjoLYxJWVITNQfSSFw/94PbQr8eZ
 oYxht/dJMIXU4/hR5GbTNM/Jk3Hq3uWK6HBo+/O5k0sF0hZ51Q0hzuctI9jPL47/228Q4IP
 Hl4WTnZKfOpK1E9/84l2Iv59y5IH5E7AfcGAL0bJ5bv7gUG7aupuZzzQwwp4Q3QMOSm15WI
 ZeBw2jBY/G5pPlbtP940A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mKpATsNijto=:zf5t6lrFqMn+pM8l8GEd/3
 1dk+VVkm8F+8lZXc4rM41nZCrw4IT8QzQJobh52XeH2TKq8O+0GgDUiPF1PLQLSvopKTPZ3jK
 AvSI1dWzl4vMkl4WQZQmeCz4B1FJ6xq5w64WDDU4eECQCNz2mpF5xM/bv05LHDKb1/hPrzIFq
 cyLxj6PLoZAwxCPGzcugqkktiWRPZLF314FnldP0ak5ghdTvEiErgIALfub6bTh8v3BDa7xbW
 anO+FNiCqdPESojstxDTCNMhaszXunhlXOjSMqxkbXvtnduguWnv35KMm9ZJFnjXhgcwQq/8e
 eWKV9Nc05OvkifYVttKZKhRZXp1MWOit8VpYgbxwJ9xD+b2TJ2MbDPIXoKJ92I9TgZ12EhOOK
 TT7t3PGvbFGcN0456jp4QP5eANoF0FNbBkaSaF5iDChxHsNTR51SidFKt3DTEISuifrhxsJTQ
 fca4p9p9LxBOExEoBAQjwh0E4Bx/wp0PktgQs1hen9rzcniPsoxFTeVPmKeHQSVF8yBwZ2ayk
 LKairxqpoYWRIf9NME9BCWnCZwudd9/zfdiZO/7mWYGBNrryv3qkz7/pDmO53zKyAPDOcNntO
 SI02HfKWQzpNZP1v270LxVZADVKtVZNakDSkbC+hWCu8hSqO+HuefQQDbx/MIM16L8MHA9/Yy
 X8xneuCApJGK1JwzeWJ9Hhkzs/JY/NYTBnCLzVHan15qUAiY5TtGPNQcCRdihGA5RJw37H9GA
 SOIdyts6unilqX9dmB1DehHQl7sT/RbtbRnOwDR2I4hlSYZxfy97Ftt4hoTp7Nty6HCks5x8J
 Cf+N/lTnhb7JTDos0rlABl4jyrDLXb4RjmpOubW3oLpKgKmWibwtsNZcxraPchu+GQfnOiA98
 Dow/pUkSa7j5N69yV6Qn27xChA7REyLhV9dO5fQ3iDsmiqCw7Nm/YtUKms5UqNqwtI3RJgw0b
 TWg1vKK7RPl7CEngg5UkHZ9PeJYE+sN5vB+z5DlqDfRFPXzCa4fNVhVCrOt2xwUUGrJ4IojXk
 QoAAV3uzQmCJuRuopv0pLXOeqChzQx5+Iy8NLw5URUwF4AokErgB68Yws3PcjDzj7m7uY02G8
 ulzpvmqM5Sm4LU=
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/15 22:33, Christoph Hellwig wrote:
> This argument is unused since commit 953651eb308f ("btrfs: factor out
> helper adding a page to bio") and commit 1b36294a6cd5 ("btrfs: call
> submit_bio_hook directly for metadata pages") reworked the way metadata
> bio submission is handled.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c   | 2 +-
>   fs/btrfs/disk-io.h   | 2 +-
>   fs/btrfs/extent_io.c | 3 +--
>   3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 2689e85896272..28b9cf020b8df 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -921,7 +921,7 @@ static bool should_async_write(struct btrfs_fs_info =
*fs_info,
>   }
>
>   blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio=
 *bio,
> -				       int mirror_num, unsigned long bio_flags)
> +				       int mirror_num)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	blk_status_t ret;
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 2a401592124d3..56607abe75aa4 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -88,7 +88,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *b=
bio,
>   				   struct page *page, u64 start, u64 end,
>   				   int mirror);
>   blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio=
 *bio,
> -				       int mirror_num, unsigned long bio_flags);
> +				       int mirror_num);
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_inf=
o);
>   #endif
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index fe146ba21415e..ef3f77e0b0fed 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -191,8 +191,7 @@ static void submit_one_bio(struct bio *bio, int mirr=
or_num,
>   		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
>   					    bio_flags);
>   	else
> -		btrfs_submit_metadata_bio(tree->private_data, bio,
> -						mirror_num, bio_flags);
> +		btrfs_submit_metadata_bio(tree->private_data, bio, mirror_num);
>   	/*
>   	 * Above submission hooks will handle the error by ending the bio,
>   	 * which will do the cleanup properly.  So here we should not return
