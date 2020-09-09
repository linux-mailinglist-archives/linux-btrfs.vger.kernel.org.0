Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42793262DDF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIILcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 07:32:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:55379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgIILbA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 07:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599651055;
        bh=T9TKQx7UWV+LvYgAuUb8LYOOQF/I266tlr5iy6yMOtU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UMbLLxcm3nRp/FA1BRgdTO1a0KhXSqvDsqweDY9CHBGmPneQ5DmFKAS4bvEON0rpv
         lXfOB9cHZAJWiJmC7Q+ls2D7gkNqczNyxskH8zJ9khU+zSVcIV4STk7Z+SiWlydhIr
         pqpgDDO6C7fVeLCnGQ4wKt5YkR7RlttDQAS7Outo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4QwW-1khuwl1PZG-011Okw; Wed, 09
 Sep 2020 13:24:22 +0200
Subject: Re: [PATCH 05/10] btrfs: Remove btrfs_get_extent indirection from
 __do_readpage
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-6-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <8d1907b2-9f1f-72ef-6949-f25e64d001d8@gmx.com>
Date:   Wed, 9 Sep 2020 19:24:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909094914.29721-6-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:49j7qRQys27go6/r470f5Twwsz5wz/2fqeqjmEVtN8PW0uC+o0f
 bSSAch2sDyAjRhhbDmvLAQRkuIwm0z0lRTTNpTRgHxVdwFhjxG9K3Ou4pOdrgyJ+fDQd+p2
 2MGmnCfl7IPkzQ6k9qEkpDbh5l02iVJeXVZkaLEjRyITWZvBcdICc4r+KpduKjRdEAFRt5K
 oKxIRUmgQXS+D1Qc/PObA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uf2YZ2o2ewE=:+GGO6Wjsl/9wNgz/OgXtDf
 bQ6LXccnrpCi4eX8hOdYvXtJ7MXme4+O6LFX5h9zarRVec3UvjTPkb9HVRHGBJ/1TKiD1JvKy
 jNjteFnNOgjc08YKHHohs1xtPqJ6NZhLPzbjozYQpyG5ajgpoD5vnXg2ZQhg4fCkoFFvRKeWh
 0IeR23OyQZJmjcRKWBUJlgLy9mASIdYjUQqxzVyDFa+xAnW/4j1yv5VaOs+2KezVddfs06eFi
 08vSiVd0J2UQxnn0OhfumNufeNH9v6R1AlLFHWph7gmPbpUQH27hFkjZXvMaH0xq9L+BhYg2r
 aeAGDQefX0Q7s9RXJkrb8FA3Y2vOx3otXBSGjkY+G/m9/o9JJu/4GacOfzG8cjampTY0puPQU
 47HaT+ldIgpkidUKoH/CtLpmYaNYnWsAgu3whNERAT/nSMHu4/6GWdNxCn5I/5rCZSX0B701s
 FjkVDogBUGeCW7FHJ+IeKmJxbRWQy3FgOY/Eo8SsiZhV2/a2/mY7xDSlCWLbfuRnkBypBfONJ
 Ek8EKVYcOQ5q8gJYj9UmWwCNtuGL2x/zSKH9dwnrLPgYkLN71RARg/Us2aKMb4gt+kw4Amnps
 l+St3CtZ31yGfEhlIwhnH0GSuBr8fqcq3uCRs8de1Sgo5PvDfHRBgYB/s81qJaYPbsgESm5wF
 joXTWdhjB/8rHPVN6Y736HkF/iORj5yLN2RD+I58NWQ1kMnNMnTna/VDHgjhx5gals787haRy
 qQXin0WGJ5LrS70oCXgweR1T/PDaNimidmq1+7u6SVduL4lNBmjUKE/kXw/2J/6hWlYh0B1ep
 cQH2bOg5aMj3f/neZj0vd/zslKRkQwh9kFBI6+p25+JLbJbksJrI+8IXjIZiggT06VEMt6dNo
 jXqvrV0gZxYhCo0r4KcQf0i4/ZsyX2AcJV1daSQlmZsFH10nwan5e6HGi3OjgR/KU9t8l7PC7
 ALmMYMnjrAaxPfIOTQxHz57gPixdkE6t1rEhRSADHn69lDmRlmG7oMeJ6HX/9vYg1iMM8fT+N
 Z+AsA9ScxaHtkodLPeM5TgfFpbzzLwCKDPufCE177oy7m0At7XkOqP8vCm8uDwfXnomLk863d
 5wNBxFI1UglQiFlxFFgbGjtdF/ukGhBVQxtQQfvuZYuoyxrQNLA1N+UNwiPCadYBTuvzLftl7
 dXIKlKnbdPT67LMsz/FnPicUyAxSsVoUCDh2Ic4BGtutyNr95qjcTCIA2FXhiowpZCFPCW+/X
 OZMiOZWBv/zPikiJngcYB38fPAgs+K/SnRNDu6w==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/9 =E4=B8=8B=E5=8D=885:49, Nikolay Borisov wrote:
> Now that this function is only responsible for reading data pages it's
> no longer necessary to pass get_extent_t parameter across several
> layers of functions. This patch removes this parameter from multiple
> functions: __get_extent_map/__do_readpage/__extent_read_full_page/
> extent_read_full_page and simply calls btrfs_get_extent directly in
> __get_extent_map.

Then it would be much nicer to see a patch renaming all these functions
to specifically name as like
get_data_extent_map/do_data_readpage/data_extent_read_full_page.

The current extent/page naming is too generic, not really distinguish
the completely different path between data and metadata.

And maybe split extent_io into meta_io and data_io. <- That may be
overkilled I guess...

Thanks,
Qu

>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent_io.c | 31 ++++++++++++-------------------
>  fs/btrfs/extent_io.h |  3 +--
>  fs/btrfs/inode.c     |  2 +-
>  3 files changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1789a7931312..4c04d3655538 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3110,8 +3110,7 @@ void set_page_extent_mapped(struct page *page)
>
>  static struct extent_map *
>  __get_extent_map(struct inode *inode, struct page *page, size_t pg_offs=
et,
> -		 u64 start, u64 len, get_extent_t *get_extent,
> -		 struct extent_map **em_cached)
> +		 u64 start, u64 len, struct extent_map **em_cached)
>  {
>  	struct extent_map *em;
>
> @@ -3127,7 +3126,7 @@ __get_extent_map(struct inode *inode, struct page =
*page, size_t pg_offset,
>  		*em_cached =3D NULL;
>  	}
>
> -	em =3D get_extent(BTRFS_I(inode), page, start, len);
> +	em =3D btrfs_get_extent(BTRFS_I(inode), page, start, len);
>  	if (em_cached && !IS_ERR_OR_NULL(em)) {
>  		BUG_ON(*em_cached);
>  		refcount_inc(&em->refs);
> @@ -3142,9 +3141,7 @@ __get_extent_map(struct inode *inode, struct page =
*page, size_t pg_offset,
>   * XXX JDM: This needs looking at to ensure proper page locking
>   * return 0 on success, otherwise return error
>   */
> -static int __do_readpage(struct page *page,
> -			 get_extent_t *get_extent,
> -			 struct extent_map **em_cached,
> +static int __do_readpage(struct page *page, struct extent_map **em_cach=
ed,
>  			 struct bio **bio, int mirror_num,
>  			 unsigned long *bio_flags, unsigned int read_flags,
>  			 u64 *prev_em_start)
> @@ -3211,7 +3208,7 @@ static int __do_readpage(struct page *page,
>  		if (pg_offset !=3D 0)
>  			trace_printk("PG offset: %lu iosize: %lu\n", pg_offset, iosize);
>  		em =3D __get_extent_map(inode, page, pg_offset, cur,
> -				      end - cur + 1, get_extent, em_cached);
> +				      end - cur + 1, em_cached);
>  		if (IS_ERR_OR_NULL(em)) {
>  			SetPageError(page);
>  			unlock_extent(tree, cur, end);
> @@ -3364,16 +3361,14 @@ static inline void contiguous_readpages(struct p=
age *pages[], int nr_pages,
>  	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
>
>  	for (index =3D 0; index < nr_pages; index++) {
> -		__do_readpage(pages[index], btrfs_get_extent, em_cached,
> -				bio, 0, bio_flags, REQ_RAHEAD, prev_em_start);
> +		__do_readpage(pages[index], em_cached, bio, 0, bio_flags,
> +			      REQ_RAHEAD, prev_em_start);
>  		put_page(pages[index]);
>  	}
>  }
>
> -static int __extent_read_full_page(struct page *page,
> -				   get_extent_t *get_extent,
> -				   struct bio **bio, int mirror_num,
> -				   unsigned long *bio_flags,
> +static int __extent_read_full_page(struct page *page, struct bio **bio,
> +				   int mirror_num, unsigned long *bio_flags,
>  				   unsigned int read_flags)
>  {
>  	struct btrfs_inode *inode =3D BTRFS_I(page->mapping->host);
> @@ -3383,20 +3378,18 @@ static int __extent_read_full_page(struct page *=
page,
>
>  	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
>
> -	ret =3D __do_readpage(page, get_extent, NULL, bio, mirror_num,
> -			    bio_flags, read_flags, NULL);
> +	ret =3D __do_readpage(page, NULL, bio, mirror_num, bio_flags, read_fla=
gs,
> +			    NULL);
>  	return ret;
>  }
>
> -int extent_read_full_page(struct page *page, get_extent_t *get_extent,
> -			  int mirror_num)
> +int extent_read_full_page(struct page *page, int mirror_num)
>  {
>  	struct bio *bio =3D NULL;
>  	unsigned long bio_flags =3D 0;
>  	int ret;
>
> -	ret =3D __extent_read_full_page(page, get_extent, &bio, mirror_num,
> -				      &bio_flags, 0);
> +	ret =3D __extent_read_full_page(page, &bio, mirror_num, &bio_flags, 0)=
;
>  	if (bio)
>  		ret =3D submit_one_bio(bio, mirror_num, bio_flags);
>  	return ret;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 41621731a4fe..57786feffdbf 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -193,8 +193,7 @@ typedef struct extent_map *(get_extent_t)(struct btr=
fs_inode *inode,
>  int try_release_extent_mapping(struct page *page, gfp_t mask);
>  int try_release_extent_buffer(struct page *page);
>
> -int extent_read_full_page(struct page *page, get_extent_t *get_extent,
> -			  int mirror_num);
> +int extent_read_full_page(struct page *page, int mirror_num);
>  int extent_write_full_page(struct page *page, struct writeback_control =
*wbc);
>  int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
>  			      int mode);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a7b62b93246b..c8d1d935c8c7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8036,7 +8036,7 @@ static int btrfs_fiemap(struct inode *inode, struc=
t fiemap_extent_info *fieinfo,
>
>  int btrfs_readpage(struct file *file, struct page *page)
>  {
> -	return extent_read_full_page(page, btrfs_get_extent, 0);
> +	return extent_read_full_page(page, 0);
>  }
>
>  static int btrfs_writepage(struct page *page, struct writeback_control =
*wbc)
>
