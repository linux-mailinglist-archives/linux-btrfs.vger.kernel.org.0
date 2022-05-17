Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E173952ADF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 00:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiEQWRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 18:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEQWRg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 18:17:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247F83BA65
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 15:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652825847;
        bh=pLybnxYDlzA22SXpWT0CbsvcZiHmPx3zuSoasIIzHMU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OC5s69kcHTmkiPt5+Z7K4NsBpK7rgN+b+GGc46f0awlo9dA7biHT2Wag1Ji2f2rrn
         cxwQqXc40Cc0sSBvwsdEXT/1Jwellq0pF1rILAzqIfpO49KnRdrQmGpty15vetOtBB
         fRmeJfJaQWNyjbKF8wz5rGLzLKG8MHTFMLDXu7/s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QWG-1nvTDZ2ucC-004SnK; Wed, 18
 May 2022 00:17:26 +0200
Message-ID: <0ddf001d-ca02-5bbb-4dfe-679c5106581c@gmx.com>
Date:   Wed, 18 May 2022 06:17:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 07/15] btrfs: factor out a helper to end a single sector
 from submit_data_read_repair
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-8-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220517145039.3202184-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4tJiB1LLlHP0jhvo2RBWXE1QzGZRrRkWCk+ZitJiovtgMjbaglS
 +tsFFSv1oEh5SzUNDMQFLrDQ7744lfPsWHyOZus6C9SfLkT1Lkh5tLk28dUwkv+ZSCT++HZ
 fdEf4YtcJ7HABMjnz7G4JadDqcAYuhvfql7kf7spZercrFkG9AWIq5v6kuC4xAmvH4diCkh
 GjF3+qT45Zj9W+S2t/5PQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cc5fMVQL7Mw=:VFSMYwyXkM9XBN1qmPO1YK
 GmaJSALxJQ2zF9ViaUZ2hOPowBOc4FLH/M1Kioox2bFFLcwauNayQ2uWy63PfwNHeLSIlOIZz
 5+T9MBDOBJRPVsREBYqEEmesSLUaAsEEgvpONLiyVTmAgd9BW+FkOoi+vjiVGKJ7GLwJEL0Fd
 otWuEdI+aXq6dsXij/6tOkITzzHj690vC5eimB8ZdEc7rG4tNwPPS03kUN96e90kvepOPeLrt
 oK/FiXwWUFf4wxuvcoL38Q4HgCYCdGqVK6K2yC4Hi2NoNzzHA0V0mZKLdckLlHnN7c08nYgFV
 CYpSdHpgdgQzRIVH8h3eRKW0wKEMMRAuPNPidRjfua3YkMItzfZiS0wTeHStglUuzRtl118rw
 SgiQlwI0vElKjA/BbeMPbs2wugzNvrX8cKvCwWu20MkkvXLx/3YzrKXiBHR9o+lu/6fKpWA/t
 aVv330nw6ctiwQBCRS4IHaH54SZvhjQgPQEs1GN+4lyu9gWyQvcGcBUme5I/Sow5f7DYe3RQy
 svtKLao84GA7RpRUHx/OANMW1oEGDqFBcna3FNkq3VlZb+iPQyy30EnJFrgFqMp2BjT4fQfBO
 ZRIlK17eoC8KhXwLhXJO6YDuQQeJc2LYviRnTB+d/3hF5ORErr6eUMkaPDSYxsA/iNzAe+jZU
 Vl6CbS8r6ym8Ee1BQ3fLgSUmPa6Q23LGq8YP+7dpqqTP6rUUBCwehKQ6cYVXis1bpQJ9wTfb3
 KcOZnmRzZiWAOalSHGY0oMbrCDCACs/4/4XAeWEaYpPCTzxDAxlfHvTarxPoQJh9R4Tm9uEC6
 XdyGs4nHFhYxymIv6y3M42ddToZ/+qJaQMjdY8/ATMUf2sxX2GcwKGUIzKv+ovWYAQ8mdOu2z
 L642RCdABaUsCo7doR1GMuP/kICCfx8ke2TtHHiSeTPyK5SudXNOSCQgiuwNz9Dvt4bqU9pwR
 jixE9kP/hi9XAJUX84PVRH7xjx90HNRjgt6Xqh3VCM/cJg7jnu43bRyI/EONmUqNKCjL9TJZV
 aC1+ZlPaAcdKYHfiVBVY3zgUZLLbsvPnNfMxEkY9woN1J5aZgBLROykc0MujqZZu8WUQk8AW4
 lDa7qo4Ed3kbWrvMCTrll5ewE2WxYuTreiGXtbcPbXtn9m1n2LV7mRy+w==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 22:50, Christoph Hellwig wrote:
> Add a helper to end I/O on a single sector, which will come in handy wit=
h
> the new read repair code.

The code looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one thing to mention, I also considered such refactor, but the main
reason to prevent me doing this is, there are already more than enough
helpers, and without a good enough naming, it can be messy easily.

Although it looks like we're fine with the new helper for now.

Thanks,
Qu
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 75466747a252c..f96d5b7071813 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2740,6 +2740,20 @@ static void end_page_read(struct page *page, bool=
 uptodate, u64 start, u32 len)
>   		btrfs_subpage_end_reader(fs_info, page, start, len);
>   }
>
> +static void end_sector_io(struct page *page, u64 offset, bool uptodate)
> +{
> +	struct inode *inode =3D page->mapping->host;
> +	u32 sectorsize =3D btrfs_sb(inode->i_sb)->sectorsize;
> +	struct extent_state *cached =3D NULL;
> +
> +	end_page_read(page, uptodate, offset, sectorsize);
> +	if (uptodate)
> +		set_extent_uptodate(&BTRFS_I(inode)->io_tree, offset,
> +				offset + sectorsize - 1, &cached, GFP_ATOMIC);
> +	unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree, offset,
> +			offset + sectorsize - 1, &cached);
> +}
> +
>   static void submit_data_read_repair(struct inode *inode, struct bio *f=
ailed_bio,
>   		u32 bio_offset, const struct bio_vec *bvec, int failed_mirror,
>   		unsigned int error_bitmap)
> @@ -2770,7 +2784,6 @@ static void submit_data_read_repair(struct inode *=
inode, struct bio *failed_bio,
>   	/* Iterate through all the sectors in the range */
>   	for (i =3D 0; i < nr_bits; i++) {
>   		const unsigned int offset =3D i * sectorsize;
> -		struct extent_state *cached =3D NULL;
>   		bool uptodate =3D false;
>   		int ret;
>
> @@ -2801,16 +2814,7 @@ static void submit_data_read_repair(struct inode =
*inode, struct bio *failed_bio,
>   		 * will not be properly unlocked.
>   		 */
>   next:
> -		end_page_read(page, uptodate, start + offset, sectorsize);
> -		if (uptodate)
> -			set_extent_uptodate(&BTRFS_I(inode)->io_tree,
> -					start + offset,
> -					start + offset + sectorsize - 1,
> -					&cached, GFP_ATOMIC);
> -		unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
> -				start + offset,
> -				start + offset + sectorsize - 1,
> -				&cached);
> +		end_sector_io(page, start + offset, uptodate);
>   	}
>   }
>
