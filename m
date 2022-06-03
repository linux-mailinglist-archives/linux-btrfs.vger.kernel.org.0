Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE853C8DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 12:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbiFCKlE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 06:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiFCKlC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 06:41:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938443BBF6
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654252856;
        bh=pPzDJyQ3b/rX72IxKJ1fohO88EhdGtA6BPbOlE3utgQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=im1c1qo9ltPqF32duS1cosjZTXotAuYLlILRqG/EbIzhqOUprF3T+hOGq4+TkNj4M
         LaL+pBmWYK21bkmqDOYSzUSRFpEafOAz+aSKZWW9YPqwMZDZ1UA4PZ0A/GgLNklc75
         mFUbz+hssSjUM2GRC80ALGZ8jsto9zrv+E5z2fS4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqaxU-1nS7gl1DAO-00mZZs; Fri, 03
 Jun 2022 12:40:55 +0200
Message-ID: <3c22fa37-e48b-fd63-e70a-90a9c286663c@gmx.com>
Date:   Fri, 3 Jun 2022 18:40:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] btrfs: merge end_write_bio and flush_write_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220603071103.43440-1-hch@lst.de>
 <20220603071103.43440-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220603071103.43440-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5EE5qiLaDRcw4GDVsiyPPhPHFykzIh5daG/Mme9ZhjrxpsO6d5q
 ByVl3NrWhj+oVCCUeHOCyCUy1giGdMGWxlC1HMzuOJAysOhytwKqKcXgF19dQHpCPkf9I7y
 uRqoXjKUCs3rx7qg36Dlhj2XGxaeQNXGTU/L+UwLKa9MqJM6/6NLMI4DMv2b09tZDHVzA4h
 8igySuaGmERVb+HJmjUrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CFYvtlx1Oz4=:9gR8wETXldTIqSmHvPhXtr
 d+Psg4MyRRM6txCpPsj3g/v4xWC9tae4XDyfvV3o2d/PK6+gYV1pgGwpw0t7Gu0LzkPedKYpe
 S5UMmBK5dBb0bbVDr7vvqJHkOk5c4CYZcHqCBTErRuk+bGCEgswYX2xJtn/7tgnoExZ2yjtfS
 P+Bn3fiIaLrrituYsygnOLZAAtS+862cjNHmRB3JVSHHa59J1ayLjDixYp1n6T54jHYnTK2ax
 ok/3aNq64UU12YYKlP7bSvOYFy7nCeLVAyQ76+3jy+LE+n7zRTyecNnm1YS/zQ9+MbRiH27kC
 rSS7ZiT0urj6Vcy0hNcUkc/y856unn+GbcVgKNSmDfiyKKltH8R5j9FW+jCvoEbdkQ4s8lmkp
 y7THWrcIRKm861r4qtHnzb18xZkM/q2ZJwREh7QUWBSoG4c1eHe2+M8GpNRNt0S/yiR/jXZ2b
 uDZxS7kF4LpRPhCynElG2JNBsmsl9Ef02yCm6MB7TFhcDBUeuMwIlAtVSx2DSB8uwWYHchpvc
 HUxsn981J8SwVQjjFiz6dv/F6/CMr1kv11+dtT8MI6C53JqFO2NxXexL8f5itX6DpmC4h2Mmi
 eZc0F12e59Qzz8A/rmwwfi3mKH1yzAigwjAoY4ClHpB81Rwtvd6hVArt0EvEuVPrkKTRroHvl
 2zBmEAqJ3PulIEOLy+EC/0SY5vxoY+d2lUt3SHnoxb00T52AvEtmOlD4xFl8MYyvk2o93BeFx
 Tsi6+P+OJWpuTyGNtKI6kBjbQ0bviAZm75XF1PFuqzwE9wDf1TSWVvtvv5sBWcSm4Pw76vXk7
 cT0IfaXYY3kBAYnrARbI/z1joI7La3aoZyRusFfYeVCxFx/JCZyv8c1wG/yjH/tyGOYLp/E29
 pKZ4I6fts6ZxNj0bVSaQaGhnZl8SuZd/rA7rjCaZRHJdxoTsBOGxHUMTvzwT7WvW6XdDfDiR9
 bZAX3oJ5YZUK00zKld6uU3uCdu1780fF2JOk3tuc9N6priEk1Xz59H7C2MgonsFVv5o4zp4OO
 I58y1ltafKIc3WZzEXY2OFcVE15pplVPqoPuGkyRkKPzd8CVpHfgWg0zxf3jZiN+DB6mTvmQ1
 YjyvjYHxiuP7D9tbEL6lhNUrTw4TMoZ3KZgKFqOs7IJ2vk6x9AB0W/MKw==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/3 15:11, Christoph Hellwig wrote:
> Merge end_write_bio and flush_write_bio into a single submit_write_bio
> helper, that either submits the bio or ends it if a negative errno was
> passed in.  This consolidates a lot of duplicated checks in the callers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 94 ++++++++++++++------------------------------
>   1 file changed, 30 insertions(+), 64 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 025349aeec31f..72a258fa27947 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -201,39 +201,26 @@ static void submit_one_bio(struct bio *bio, int mi=
rror_num,
>   	 */
>   }
>
> -/* Cleanup unsubmitted bios */
> -static void end_write_bio(struct extent_page_data *epd, int ret)
> -{
> -	struct bio *bio =3D epd->bio_ctrl.bio;
> -
> -	if (bio) {
> -		bio->bi_status =3D errno_to_blk_status(ret);
> -		bio_endio(bio);
> -		epd->bio_ctrl.bio =3D NULL;
> -	}
> -}
> -
>   /*
> - * Submit bio from extent page data via submit_one_bio
> - *
> - * Return 0 if everything is OK.
> - * Return <0 for error.
> + * Submit or fail the current bio in an extent_page_data structure.
>    */
> -static void flush_write_bio(struct extent_page_data *epd)
> +static void submit_write_bio(struct extent_page_data *epd, int ret)
>   {
>   	struct bio *bio =3D epd->bio_ctrl.bio;
>
> -	if (bio) {
> +	if (!bio)
> +		return;
> +
> +	if (ret) {
> +		ASSERT(ret < 0);
> +		bio->bi_status =3D errno_to_blk_status(ret);
> +		bio_endio(bio);
> +	} else {
>   		submit_one_bio(bio, 0, 0);
> -		/*
> -		 * Clean up of epd->bio is handled by its endio function.
> -		 * And endio is either triggered by successful bio execution
> -		 * or the error handler of submit bio hook.
> -		 * So at this point, no matter what happened, we don't need
> -		 * to clean up epd->bio.
> -		 */
> -		epd->bio_ctrl.bio =3D NULL;
>   	}
> +
> +	/* The bio is owned by the bi_end_io handler now */
> +	epd->bio_ctrl.bio =3D NULL;
>   }
>
>   int __init extent_state_cache_init(void)
> @@ -4248,7 +4235,7 @@ static noinline_for_stack int lock_extent_buffer_f=
or_io(struct extent_buffer *eb
>   	int ret =3D 0;
>
>   	if (!btrfs_try_tree_write_lock(eb)) {
> -		flush_write_bio(epd);
> +		submit_write_bio(epd, 0);
>   		flush =3D 1;
>   		btrfs_tree_lock(eb);
>   	}
> @@ -4258,7 +4245,7 @@ static noinline_for_stack int lock_extent_buffer_f=
or_io(struct extent_buffer *eb
>   		if (!epd->sync_io)
>   			return 0;
>   		if (!flush) {
> -			flush_write_bio(epd);
> +			submit_write_bio(epd, 0);
>   			flush =3D 1;
>   		}
>   		while (1) {
> @@ -4305,7 +4292,7 @@ static noinline_for_stack int lock_extent_buffer_f=
or_io(struct extent_buffer *eb
>
>   		if (!trylock_page(p)) {
>   			if (!flush) {
> -				flush_write_bio(epd);
> +				submit_write_bio(epd, 0);
>   				flush =3D 1;
>   			}
>   			lock_page(p);
> @@ -4721,7 +4708,7 @@ static int submit_eb_subpage(struct page *page,
>
>   cleanup:
>   	/* We hit error, end bio for the submitted extent buffers */
> -	end_write_bio(epd, ret);
> +	submit_write_bio(epd, ret);
>   	return ret;
>   }
>
> @@ -4900,10 +4887,6 @@ int btree_write_cache_pages(struct address_space =
*mapping,
>   		index =3D 0;
>   		goto retry;
>   	}
> -	if (ret < 0) {
> -		end_write_bio(&epd, ret);
> -		goto out;
> -	}
>   	/*
>   	 * If something went wrong, don't allow any metadata write bio to be
>   	 * submitted.
> @@ -4930,21 +4913,17 @@ int btree_write_cache_pages(struct address_space=
 *mapping,
>   	 *   Now such dirty tree block will not be cleaned by any dirty
>   	 *   extent io tree. Thus we don't want to submit such wild eb
>   	 *   if the fs already has error.
> -	 */
> -	if (!BTRFS_FS_ERROR(fs_info)) {
> -		flush_write_bio(&epd);
> -	} else {
> -		ret =3D -EROFS;
> -		end_write_bio(&epd, ret);
> -	}
> -out:
> -	btrfs_zoned_meta_io_unlock(fs_info);
> -	/*
> +	 *
>   	 * We can get ret > 0 from submit_extent_page() indicating how many e=
bs
>   	 * were submitted. Reset it to 0 to avoid false alerts for the caller=
.
>   	 */
>   	if (ret > 0)
>   		ret =3D 0;
> +	if (!ret && BTRFS_FS_ERROR(fs_info))
> +		ret =3D -EROFS;
> +	submit_write_bio(&epd, ret);
> +
> +	btrfs_zoned_meta_io_unlock(fs_info);
>   	return ret;
>   }
>
> @@ -5046,7 +5025,7 @@ static int extent_write_cache_pages(struct address=
_space *mapping,
>   			 * tmpfs file mapping
>   			 */
>   			if (!trylock_page(page)) {
> -				flush_write_bio(epd);
> +				submit_write_bio(epd, 0);
>   				lock_page(page);
>   			}
>
> @@ -5057,7 +5036,7 @@ static int extent_write_cache_pages(struct address=
_space *mapping,
>
>   			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
>   				if (PageWriteback(page))
> -					flush_write_bio(epd);
> +					submit_write_bio(epd, 0);
>   				wait_on_page_writeback(page);
>   			}
>
> @@ -5097,7 +5076,7 @@ static int extent_write_cache_pages(struct address=
_space *mapping,
>   		 * page in our current bio, and thus deadlock, so flush the
>   		 * write bio here.
>   		 */
> -		flush_write_bio(epd);
> +		submit_write_bio(epd, 0);
>   		goto retry;
>   	}
>
> @@ -5118,13 +5097,7 @@ int extent_write_full_page(struct page *page, str=
uct writeback_control *wbc)
>   	};
>
>   	ret =3D __extent_writepage(page, wbc, &epd);
> -	ASSERT(ret <=3D 0);
> -	if (ret < 0) {
> -		end_write_bio(&epd, ret);
> -		return ret;
> -	}
> -
> -	flush_write_bio(&epd);
> +	submit_write_bio(&epd, ret);
>   	return ret;
>   }
>
> @@ -5185,10 +5158,7 @@ int extent_write_locked_range(struct inode *inode=
, u64 start, u64 end)
>   		cur =3D cur_end + 1;
>   	}
>
> -	if (!found_error)
> -		flush_write_bio(&epd);
> -	else
> -		end_write_bio(&epd, ret);
> +	submit_write_bio(&epd, found_error ? ret : 0);
>
>   	wbc_detach_inode(&wbc_writepages);
>   	if (found_error)
> @@ -5214,12 +5184,8 @@ int extent_writepages(struct address_space *mappi=
ng,
>   	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
>   	ret =3D extent_write_cache_pages(mapping, wbc, &epd);
>   	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
> -	ASSERT(ret <=3D 0);
> -	if (ret < 0) {
> -		end_write_bio(&epd, ret);
> -		return ret;
> -	}
> -	flush_write_bio(&epd);
> +
> +	submit_write_bio(&epd, ret);
>   	return ret;
>   }
>
