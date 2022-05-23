Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71D5306DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 May 2022 02:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiEWAia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 20:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiEWAi2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 20:38:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BF830569
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 17:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653266298;
        bh=x4l0s9bCdQSeLYpXJWto0dkJjn5ZUVxxBz+O/XzVOwA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IzitXpHKwhfTJ4kh7VKlWmR+uPiM5kEDtRux5/b/kpQ1ubShWJXHepi5nrgk8lGZN
         WQs/GfnHbQlzjP6k9sAnAvW3aLtBA8/C6JrLUL7mpiM7BsDtJ4d4+UrHuLj2hyxE/2
         3Ie2daPjomi/IwcBNigc5xjmSnubiqFOHjckYPTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9Bu-1nXMR533mY-00oFsr; Mon, 23
 May 2022 02:38:18 +0200
Message-ID: <d459113f-7325-ebe9-77de-6639c646f0df@gmx.com>
Date:   Mon, 23 May 2022 08:38:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/8] btrfs: introduce a pure data checksum checking helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <20220522114754.173685-1-hch@lst.de>
 <20220522114754.173685-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220522114754.173685-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:chHF5UtfpUeDoGm7nkQQInu8gzHPw+x91yKaLabZ4vPdxc8aNkD
 Ln+v4DzLYAZJ7JmiEYMG5Xzq0HV315hR2bN0O+6D8764mOxOMAdBb38FsdijWUJicfK9WbT
 to1kjIYO1wZ678p+bhdFviSMgtJzLiCMogWtFRf1GCPK5tufeEu/S6XurFvn7Xw3jXNIKx7
 yAvh5U0EVWRl6c+dtHzvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:00X90mB6gso=:OBBgxAzsBwj2GsLIkGigaO
 KM9idIwasFJzK5jYjp+ErwqKVhOK+h4qJ0PwmYajYa9AWcyZmOpq0NNNTmhu/8kdJl4b4anNo
 3LDZ1t/KlfefVYuj4iERtUzTjs1rBLtvcCq1cJ1QAFvVzRW8ikHgzZ/Bycco5AG8DBoBxPKKn
 n4Ts2UfRN9g0DvxEL+k8126t3GISv7N+zqpsbPWglrLvlMxR2Wg+AH/r7ujLgJVhnC0NV2nAt
 IwwTPWa2syI8s9GEaWbC+aR6556UiyvlkFEsrZ8xnZkOnK+ghFr6E0KzsV0ZBM61p7G+XmTQ4
 FZJp9IQl4SE+LtgSKotqjfQbmYUH4pjhU2/gdFa54xeLo/4ioeVO0JThUHfCeyuxnejxz/CIV
 2FyF709oKMTQV/xlMqhTw8ZZ3kktOcR2Il2gAB0FKFx2UndQ+3gtNGMFOzppY7oghbh/w/hD2
 yTjSWVouElxqi2+uEze7SEMSq2NnkUROBWqLzQ6qGeZ8xuuHv8LZH5rS7g3tCr63J/SP+kI30
 F4fCPZk7b2s/XX85B6af8DGh702nHQM/4pvznN4qEJh/ZbsMFrkh9RMcXkWeYaDBD1fp5Emvj
 XWcVD+KUMa2AxIncNbDkBF2D0iYKi+0/ljqFhAy9Awj8zkxKDTy2c10knrnNKk/tTbDbICun/
 HXoRjDyjKvB2p9uvV0z+BMce1hNYKfP/4lI0INBZs9k9p5FZXvk+X89YEjeMH0jmZeRtpT8ZW
 KlZa9KiiRTwIQTwydVhdM8CQGQzwinwhIfYhOEs0f4xEbARjT9Q2TlnkNDI1S4ZixqcIN52HB
 i+ORUDGxF2pNCdNv2jfOvHlgqDv0SbTApUzzGN8lQS8+lxHyivp3YZLubUjkYuSQXKPSkT9wh
 SkTW5zv9JAu7pVwPCFnyqDG3A4YTwXLiOZIsjhDtrVVSn8bQiTAWLYP5fqZ1CmG2CHQQ7U3Kz
 B5ehwAR+JH7EeQi6F+d3DT3gHR+876TUJvYAniOYA3imRYzJ1GAfXsNLOimd1NjRfCp8Lrtco
 ZdCMTFoyJcCds+8f3eXQKi7+cnZX1+zJihzW3szwZ+K6jeGwotdGc1K4lDqBvzGh5jdFiTixY
 h+m0cmBLqvSSneio5ZbEJTHN26AVW+hVzXcZ1xFoM6sfWDleK2bI0Qf9g==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/22 19:47, Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
>
> Although we have several data csum verification code, we never have a
> function really just to verify checksum for one sector.
>
> Function check_data_csum() do extra work for error reporting, thus it
> requires a lot of extra things like file offset, bio_offset etc.
>
> Function btrfs_verify_data_csum() is even worse, it will utizlie page
> checked flag, which means it can not be utilized for direct IO pages.
>
> Here we introduce a new helper, btrfs_check_sector_csum(), which really
> only accept a sector in page, and expected checksum pointer.
>
> We use this function to implement check_data_csum(), and export it for
> incoming patch.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [hch: keep passing the csum array as an arguments, as the callers want
>        to print it, rename per request]

Mind to constify the @csum_expected parameter?

Thanks,
Qu
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/compression.c | 13 ++++---------
>   fs/btrfs/ctree.h       |  2 ++
>   fs/btrfs/inode.c       | 38 ++++++++++++++++++++++++++++----------
>   3 files changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index f4564f32f6d93..6ab82e142f1f8 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -147,12 +147,10 @@ static int check_compressed_csum(struct btrfs_inod=
e *inode, struct bio *bio,
>   				 u64 disk_start)
>   {
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>   	const u32 csum_size =3D fs_info->csum_size;
>   	const u32 sectorsize =3D fs_info->sectorsize;
>   	struct page *page;
>   	unsigned int i;
> -	char *kaddr;
>   	u8 csum[BTRFS_CSUM_SIZE];
>   	struct compressed_bio *cb =3D bio->bi_private;
>   	u8 *cb_sum =3D cb->sums;
> @@ -161,8 +159,6 @@ static int check_compressed_csum(struct btrfs_inode =
*inode, struct bio *bio,
>   	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
>   		return 0;
>
> -	shash->tfm =3D fs_info->csum_shash;
> -
>   	for (i =3D 0; i < cb->nr_pages; i++) {
>   		u32 pg_offset;
>   		u32 bytes_left =3D PAGE_SIZE;
> @@ -175,12 +171,11 @@ static int check_compressed_csum(struct btrfs_inod=
e *inode, struct bio *bio,
>   		/* Hash through the page sector by sector */
>   		for (pg_offset =3D 0; pg_offset < bytes_left;
>   		     pg_offset +=3D sectorsize) {
> -			kaddr =3D kmap_atomic(page);
> -			crypto_shash_digest(shash, kaddr + pg_offset,
> -					    sectorsize, csum);
> -			kunmap_atomic(kaddr);
> +			int ret;
>
> -			if (memcmp(&csum, cb_sum, csum_size) !=3D 0) {
> +			ret =3D btrfs_check_sector_csum(fs_info, page, pg_offset,
> +						      csum, cb_sum);
> +			if (ret) {
>   				btrfs_print_data_csum_error(inode, disk_start,
>   						csum, cb_sum, cb->mirror_num);
>   				if (btrfs_bio(bio)->device)
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0e49b1a0c0716..8dd7d36b83ecb 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3253,6 +3253,8 @@ u64 btrfs_file_extent_end(const struct btrfs_path =
*path);
>   /* inode.c */
>   void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>   			   int mirror_num, enum btrfs_compression_type compress_type);
> +int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page =
*page,
> +			    u32 pgoff, u8 *csum, u8 *csum_expected);
>   unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>   				    u32 bio_offset, struct page *page,
>   				    u64 start, u64 end);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index da13bd0d10f12..e4acdec9ffc69 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3326,6 +3326,29 @@ void btrfs_writepage_endio_finish_ordered(struct =
btrfs_inode *inode,
>   				       finish_ordered_fn, uptodate);
>   }
>
> +/*
> + * Verify the checksum for a single sector without any extra action tha=
t
> + * depend on the type of I/O.
> + */
> +int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page =
*page,
> +			    u32 pgoff, u8 *csum, u8 *csum_expected)
> +{
> +	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> +	char *kaddr;
> +
> +	ASSERT(pgoff + fs_info->sectorsize <=3D PAGE_SIZE);
> +
> +	shash->tfm =3D fs_info->csum_shash;
> +
> +	kaddr =3D kmap_local_page(page) + pgoff;
> +	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
> +	kunmap_local(kaddr);
> +
> +	if (memcmp(csum, csum_expected, fs_info->csum_size))
> +		return -EIO;
> +	return 0;
> +}
> +
>   /*
>    * check_data_csum - verify checksum of one sector of uncompressed dat=
a
>    * @inode:	inode
> @@ -3336,14 +3359,15 @@ void btrfs_writepage_endio_finish_ordered(struct=
 btrfs_inode *inode,
>    * @start:	logical offset in the file
>    *
>    * The length of such check is always one sector size.
> + *
> + * When csum mismatch detected, we will also report the error and fill =
the
> + * corrupted range with zero. (thus it needs the extra parameters)
>    */
>   static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio=
,
>   			   u32 bio_offset, struct page *page, u32 pgoff,
>   			   u64 start)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> -	char *kaddr;
>   	u32 len =3D fs_info->sectorsize;
>   	const u32 csum_size =3D fs_info->csum_size;
>   	unsigned int offset_sectors;
> @@ -3355,16 +3379,10 @@ static int check_data_csum(struct inode *inode, =
struct btrfs_bio *bbio,
>   	offset_sectors =3D bio_offset >> fs_info->sectorsize_bits;
>   	csum_expected =3D ((u8 *)bbio->csum) + offset_sectors * csum_size;
>
> -	kaddr =3D kmap_atomic(page);
> -	shash->tfm =3D fs_info->csum_shash;
> -
> -	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
> -	kunmap_atomic(kaddr);
> -
> -	if (memcmp(csum, csum_expected, csum_size))
> +	if (btrfs_check_sector_csum(fs_info, page, pgoff, csum, csum_expected)=
)
>   		goto zeroit;
> -
>   	return 0;
> +
>   zeroit:
>   	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expecte=
d,
>   				    bbio->mirror_num);
