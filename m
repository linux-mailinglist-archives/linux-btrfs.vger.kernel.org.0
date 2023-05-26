Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC07712056
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbjEZGkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 02:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbjEZGkj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 02:40:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEE8E65
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 23:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685083200; i=quwenruo.btrfs@gmx.com;
        bh=mp0a9ZG7eldtoJmVTByc2i19Rp2rkVozmUrN83DjK28=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nrMdwlsVUGCWr6edE7xHJBSMAZ0oX2lDTvLkbAd2SVAz38H/UW3q2B9EKoZBw7SIH
         GfNS+gHYn2InbJ4++/KarlsGYgxenFVxiBuSvFvrwl8YR20OyKQTQ+6hhht0R8lrba
         NTqAPQF6/ATnJNXmmah61Rrjjsw8dtMFCb/y2Hd1zp49i5dgptbPUd6DbqYe5eDdl0
         0qWMsmdRMERboVYEZyAwAZ0Gov3llTMfM9Jmb1PP92ZYcKoMMfZsZVSxXvMTtVzx3Q
         V1/lbXCy7K3R0mGmxHtzq+aOU5rKA6KnAiPzC2mcdxYbDldubU3GQUG+ZlDORuxALj
         JnKK6PerSKRtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel81-1qd8yg2M0z-00an1b; Fri, 26
 May 2023 08:40:00 +0200
Message-ID: <1442e52f-9ba1-d9fa-f439-34d31b46800f@gmx.com>
Date:   Fri, 26 May 2023 14:39:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 15/21] btrfs: remove the extent_buffer lookup in btree
 block checksumming
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
References: <20230503152441.1141019-1-hch@lst.de>
 <20230503152441.1141019-16-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230503152441.1141019-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fbrz5dBSPrhU9bu9D2S8iem4c0INH9eqaj/u4S08VPmNBxSRUsa
 6toAYudQBIQkd2W5vMnpkMgPtz+ZViUsBOEj+8alQkwUFiDxprq4b8LZ5Vlt8oPD3R9zXXP
 XKsEVNLuu34VjL8r33iElha0mAwDhmECLOAVMPveHvOYGdqszcJodW2QPsU5Y8LhexNq/xK
 5UwOmcKRI0rU4VxWXt6dA==
UI-OutboundReport: notjunk:1;M01:P0:S9F4HIyVOzI=;ynDdiD9eWp8VokRC19M8g5E3MAW
 nm8ZYsyw5wvRM1WQfP3UFPrqLgr94bedhjEHpyHSUtdiyEuP2Wezy1fyGrngDvbzKkRbqsYvE
 rS3ooLZ6suw4ARSzbEuO/qvIlWDHCO1E+XKfYHNhmVKu/kRBlSaZIv+FYkHZaZnKe/jLGyGR/
 faq2JGox9/6OuGH+f5Sk5W3HUQxdcx0V1g7TDfEVRj9BmXfAHgnHVp+6vhI5tvB5nMtI1xgcI
 qcy25PApCdKXlV7fCzOHq53F3YuBBJ/4tyOSbRbiwBx+QexFHVSpOX062QT8n/VJd7y8s63so
 xVAJDlgA5vm6Gclk1swMvuSUlbvNUxZ6gID9uiSygvlLkLBKtzbQF3408ifW+HjJPsou+pcM/
 tgpDYDFBRz+KQDajpoz1B3nyxi10XZw3+qIvzBvYThJv9d/RsQnV4C5AFFosoxf7o5i2aKNjN
 u/9HcJvN6zr3LR6tfh5FzOcRqEH5BJTt+jM9ZFqZpTd5gapYgqMDNPr8I9GLM9t66YzHKfwoz
 XNwSb2xMtcoT5IGCBT5UsOmXKejBmVUPDiwx8Rh1ha9LWf5my3f22Z4rQ7z9k8QHMSq73zGrI
 g8pYQ2GOxwPMOYVvZgl3VeWyO3HzAxX2U0ruoDiKRcdKshtfPVnZIuMrGTotyoyYyAeVJlsXL
 z1bwyqnd3Otd1ElfeF3svSD9W60HacbgawkT1qQj3+KGE3g6mXuYPiijH1k9ADwmjmevDGr8e
 uo+DRjzOlm+4E/OkBVNzPzzQ2xQH715jia3b/zwdB13iPDJnmmR22n/zj7pfjHSLXNrdJ2Ex1
 rAar84NPVtoDmnPAMDkSyI8szTv9zPns2tAS/gY3wG5QktrK/YiJVWakpq/UjnwT3ZirgnS32
 VYJv+QKvoqfnu9ULQ5CiouxHqrcXnUXtC4wVekHvzNFzLSUDJ3d+kiFQJVmDUiSf3Rj/vppiY
 sDbMow==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/3 23:24, Christoph Hellwig wrote:
> The checksumming of btree blocks always operates on the entire
> extent_buffer, and because btree blocks are always allocated contiguousl=
y
> on disk they are never split by btrfs_submit_bio.
>
> Simplify the checksumming code by finding the extent_buffer in the
> btrfs_bio private data instead of trying to search through the bio_vec.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c | 121 ++++++++++-----------------------------------
>   1 file changed, 25 insertions(+), 96 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a32469e0c1e4f4..d5c204bbb9786c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -312,12 +312,35 @@ int btrfs_read_extent_buffer(struct extent_buffer =
*eb,
>   	return ret;
>   }
>
> -static int csum_one_extent_buffer(struct extent_buffer *eb)
> +/*
> + * Checksum a dirty tree block before IO.
> + */
> +blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
>   {
> +	struct extent_buffer *eb =3D bbio->private;
>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
> +	u64 found_start =3D btrfs_header_bytenr(eb);
>   	u8 result[BTRFS_CSUM_SIZE];
>   	int ret;
>
> +	/*
> +	 * Btree blocks are always contiguous on disk.
> +	 */
> +	if (WARN_ON_ONCE(bbio->file_offset !=3D eb->start))
> +		return BLK_STS_IOERR;
> +	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size !=3D eb->len))
> +		return BLK_STS_IOERR;
> +
> +	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags)) {
> +		WARN_ON_ONCE(found_start !=3D 0);
> +		return BLK_STS_OK;
> +	}
> +
> +	if (WARN_ON_ONCE(found_start !=3D eb->start))
> +		return BLK_STS_IOERR;
> +	if (WARN_ON_ONCE(!PageUptodate(eb->pages[0])))
> +		return BLK_STS_IOERR;

Unfortunately this is screwing up subpage support.

Previously subpage goes its own helper, which replaces the uptodate
check to using the subpage helper.

Since PageUptodate flag is only set when all eb in that page is uptodate.
If we have a hole in the page range, the page will never be marked Uptodat=
e.

Thus for any subpage mount, this would lead to transaction abort during
metadata writeback.

We have btrfs_page_clamp_test_uptodate() for this usage.

Thanks,
Qu

> +
>   	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
>   				    offsetof(struct btrfs_header, fsid),
>   				    BTRFS_FSID_SIZE) =3D=3D 0);
> @@ -344,8 +367,7 @@ static int csum_one_extent_buffer(struct extent_buff=
er *eb)
>   		goto error;
>   	}
>   	write_extent_buffer(eb, result, 0, fs_info->csum_size);
> -
> -	return 0;
> +	return BLK_STS_OK;
>
>   error:
>   	btrfs_print_tree(eb, 0);
> @@ -359,99 +381,6 @@ static int csum_one_extent_buffer(struct extent_buf=
fer *eb)
>   	 */
>   	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG) ||
>   		btrfs_header_owner(eb) =3D=3D BTRFS_TREE_LOG_OBJECTID);
> -	return ret;
> -}
> -
> -/* Checksum all dirty extent buffers in one bio_vec */
> -static int csum_dirty_subpage_buffers(struct btrfs_fs_info *fs_info,
> -				      struct bio_vec *bvec)
> -{
> -	struct page *page =3D bvec->bv_page;
> -	u64 bvec_start =3D page_offset(page) + bvec->bv_offset;
> -	u64 cur;
> -	int ret =3D 0;
> -
> -	for (cur =3D bvec_start; cur < bvec_start + bvec->bv_len;
> -	     cur +=3D fs_info->nodesize) {
> -		struct extent_buffer *eb;
> -		bool uptodate;
> -
> -		eb =3D find_extent_buffer(fs_info, cur);
> -		uptodate =3D btrfs_subpage_test_uptodate(fs_info, page, cur,
> -						       fs_info->nodesize);
> -
> -		/* A dirty eb shouldn't disappear from buffer_radix */
> -		if (WARN_ON(!eb))
> -			return -EUCLEAN;
> -
> -		if (WARN_ON(cur !=3D btrfs_header_bytenr(eb))) {
> -			free_extent_buffer(eb);
> -			return -EUCLEAN;
> -		}
> -		if (WARN_ON(!uptodate)) {
> -			free_extent_buffer(eb);
> -			return -EUCLEAN;
> -		}
> -
> -		ret =3D csum_one_extent_buffer(eb);
> -		free_extent_buffer(eb);
> -		if (ret < 0)
> -			return ret;
> -	}
> -	return ret;
> -}
> -
> -/*
> - * Checksum a dirty tree block before IO.  This has extra checks to mak=
e sure
> - * we only fill in the checksum field in the first page of a multi-page=
 block.
> - * For subpage extent buffers we need bvec to also read the offset in t=
he page.
> - */
> -static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_=
vec *bvec)
> -{
> -	struct page *page =3D bvec->bv_page;
> -	u64 start =3D page_offset(page);
> -	u64 found_start;
> -	struct extent_buffer *eb;
> -
> -	if (fs_info->nodesize < PAGE_SIZE)
> -		return csum_dirty_subpage_buffers(fs_info, bvec);
> -
> -	eb =3D (struct extent_buffer *)page->private;
> -	if (page !=3D eb->pages[0])
> -		return 0;
> -
> -	found_start =3D btrfs_header_bytenr(eb);
> -
> -	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags)) {
> -		WARN_ON(found_start !=3D 0);
> -		return 0;
> -	}
> -
> -	/*
> -	 * Please do not consolidate these warnings into a single if.
> -	 * It is useful to know what went wrong.
> -	 */
> -	if (WARN_ON(found_start !=3D start))
> -		return -EUCLEAN;
> -	if (WARN_ON(!PageUptodate(page)))
> -		return -EUCLEAN;
> -
> -	return csum_one_extent_buffer(eb);
> -}
> -
> -blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
> -{
> -	struct btrfs_fs_info *fs_info =3D bbio->inode->root->fs_info;
> -	struct bvec_iter iter;
> -	struct bio_vec bv;
> -	int ret =3D 0;
> -
> -	bio_for_each_segment(bv, &bbio->bio, iter) {
> -		ret =3D csum_dirty_buffer(fs_info, &bv);
> -		if (ret)
> -			break;
> -	}
> -
>   	return errno_to_blk_status(ret);
>   }
>
