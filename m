Return-Path: <linux-btrfs+bounces-766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F6080AE60
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 21:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB23B281AE0
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 20:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8CC4CB3E;
	Fri,  8 Dec 2023 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pTzx836F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B93B1724
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 12:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702069011; x=1702673811; i=quwenruo.btrfs@gmx.com;
	bh=XPxymVaJ0lyZdOK0EOI5586YTWd3cgVjwj/bhE0y+KM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=pTzx836F6QSHLawLQO8jrP9LETeIHu2P/K+fjg4K/OEW6shD6lPqan1yhj/2Dvxi
	 KfgXnPO+txYm6uKc2Izd37wtI96bHN9fB8HUXWjvKQa78tcdoGsaUGqbDHGmYWea/
	 ik0HB49NvuIjC3/u2q5tFctxdKCJM8NKWYfKHLdG2MUBfb+oDpw3sW+Zkl30c2YTJ
	 fkwJbKfzdRoPfFJb/qFIw062+AYZI69sFtQb/OgFUWLelFdqYrtY1a9PWM9yY9gE/
	 6ptsJEm04rKh087+3Z4zEhJM2al7pt0LZn0IyZnp1H7xq15Ub5txFp+XQqONr6Fqd
	 CQoNtk1I02Z/QACnOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([118.102.94.57]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sDq-1r6lwu2h1u-004yz3; Fri, 08
 Dec 2023 21:56:51 +0100
Message-ID: <b9b91cd5-80be-41c0-a7fe-a64cbbcc6d85@gmx.com>
Date: Sat, 9 Dec 2023 07:26:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: Convert defrag_prepare_one_page() to use a
 folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20231208192725.1523194-1-willy@infradead.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231208192725.1523194-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xe+DjDhQeWJTcn2KTkqGDeX+b2e+3UOuCApxgSMSP5T7ZjRL03E
 CD7FmhASmUDPPqP71VZaqBo50fHrBuqneqFiSrPsSy8/HcR7wpZHzA7NmPq0tcJVcfnUkfd
 ZZYAnJ0BhonXdy9RqNJiZjoOHXpk40dLVs0YZd4KtlHG8XYGVCs6wauw3dRAxPum+QJDwcq
 xP7h20MEmDT3WkbaFlcdg==
UI-OutboundReport: notjunk:1;M01:P0:znHyaOfREis=;82zpz40L3un22jdKJIxvzEk7pDL
 iFXAv1iOiZs9o9+EYez7XMRhgB5OE7gOWfEMzcvxxVoujmTMRYpb4aCD1KSPdDOlmvrq1nly4
 GGrY0MhiIw4H4HmBQ/eUMw5f3CrZJzK9CcdsbBGxAfQZher+hu/mb9rifDKBiHXHAQKRJx+tE
 GiLnBRsEJa5gMSCm/ekfELlVLWbohR2xIYqbFg0I3CqZTII9Yw9qivIOevF5eXDjb5cWmOUFd
 Z0iyZyTd/57Pd+KJLhtAXZHdc6J61swWOJDtnPUZihW5fYqfKgce+I+iAbRryQjM0mzb8amcb
 NGGnUmE2/BvmydN6SVnZperwOhCvQQJvKLpa9p00CilEbt4tV1LU1YAceSVjxlhwHc7qaPA6k
 frq62R7pdj6U39QS1wb1JzkLEVid936FOzEcmPG5riWHy5o9zJug9vFdtfnDzzYJ+k3DCsqEt
 blnu6UShkWSaSnqN/ZS2WL33If9rV5ChKpQ/Zftcti2CNop7syzUT/Z6D9hiN1C5EjgLCOAKJ
 SB1GCZEc2TyfAW3Pt1d4thZZWUMP/XxZWz7L+NSXrvjuLiCAN96/R2zKmLSjOXrbbdJO/uQKK
 F9fnUOiBzdlOSNMhlJzmtpEWkEwvSJ7dTFRxUPaRnzdQDEWWpRzm1+AL9FBs5DAI2OpuWTQ1x
 36JQ0OEGr4sQlD530IU1mgo6gSzSQ2rZwVRx4R8bIMDWwY5xii0bg7s6Vwg0jB5IEVOh64ovH
 WeWZIls/U0IprRPKsZ/fggOkhvIWMJ9wa/LyV7/p0h+DS/zOlfBRWb5OxGtZ/lcMmi/5z2jmA
 wsuDrnlmuJ9QNeKIHZ9U7Jr6tA5WX/OjT5/SzbCtmmNnhV3PEFBPfqtN8cZpboKpThsAqWwRU
 AyCUZGeqr+l8Pzo778gSxJCaiZ/VcFmeiBV7ceXH7Y5MuAo7FY58S8J5JakD6CL4S6M6SyzW5
 litSAw==



On 2023/12/9 05:57, Matthew Wilcox (Oracle) wrote:
> Use a folio throughout defrag_prepare_one_page() to remove dozens of
> hidden calls to compound_head().  There is no support here for large
> folios; indeed, turn the existing check for PageCompound into a check
> for large folios.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me.

Although some comments inlined below
> ---
>   fs/btrfs/defrag.c | 53 ++++++++++++++++++++++++-----------------------
>   1 file changed, 27 insertions(+), 26 deletions(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index a9a068af8d6e..17a13d3ed131 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -868,13 +868,14 @@ static struct page *defrag_prepare_one_page(struct=
 btrfs_inode *inode, pgoff_t i
>   	u64 page_start =3D (u64)index << PAGE_SHIFT;
>   	u64 page_end =3D page_start + PAGE_SIZE - 1;
>   	struct extent_state *cached_state =3D NULL;
> -	struct page *page;
> +	struct folio *folio;
>   	int ret;
>
>   again:
> -	page =3D find_or_create_page(mapping, index, mask);
> -	if (!page)
> -		return ERR_PTR(-ENOMEM);
> +	folio =3D __filemap_get_folio(mapping, index,
> +			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);

When I was (and still am) a newbie to the folio interfaces, the "__"
prefix is driving me away to use it.

Mind to change it in the future? Like adding a new
filemap_get_or_create_folio()?



> +	if (IS_ERR(folio))
> +		return &folio->page;
>
>   	/*
>   	 * Since we can defragment files opened read-only, we can encounter
> @@ -884,16 +885,16 @@ static struct page *defrag_prepare_one_page(struct=
 btrfs_inode *inode, pgoff_t i
>   	 * executables that explicitly enable them, so this isn't very
>   	 * restrictive.
>   	 */
> -	if (PageCompound(page)) {
> -		unlock_page(page);
> -		put_page(page);
> +	if (folio_test_large(folio)) {
> +		folio_unlock(folio);
> +		folio_put(folio);
>   		return ERR_PTR(-ETXTBSY);
>   	}
>
> -	ret =3D set_page_extent_mapped(page);
> +	ret =3D set_page_extent_mapped(&folio->page);

With my recent patches, set_page_extent_mapped() is already using folio
interfaces, I guess it's time to finally change it to accept a folio.

>   	if (ret < 0) {
> -		unlock_page(page);
> -		put_page(page);
> +		folio_unlock(folio);
> +		folio_put(folio);
>   		return ERR_PTR(ret);
>   	}
>
> @@ -908,17 +909,17 @@ static struct page *defrag_prepare_one_page(struct=
 btrfs_inode *inode, pgoff_t i
>   		if (!ordered)
>   			break;
>
> -		unlock_page(page);
> +		folio_unlock(folio);
>   		btrfs_start_ordered_extent(ordered);
>   		btrfs_put_ordered_extent(ordered);
> -		lock_page(page);
> +		folio_lock(folio);
>   		/*
> -		 * We unlocked the page above, so we need check if it was
> +		 * We unlocked the folio above, so we need check if it was
>   		 * released or not.
>   		 */
> -		if (page->mapping !=3D mapping || !PagePrivate(page)) {
> -			unlock_page(page);
> -			put_page(page);
> +		if (folio->mapping !=3D mapping || !folio->private) {

This folio->private check is not the same as PagePrivate(page) IIRC.
Isn't folio_test_private() more suitable here?

Thanks,
Qu

> +			folio_unlock(folio);
> +			folio_put(folio);
>   			goto again;
>   		}
>   	}
> @@ -927,21 +928,21 @@ static struct page *defrag_prepare_one_page(struct=
 btrfs_inode *inode, pgoff_t i
>   	 * Now the page range has no ordered extent any more.  Read the page =
to
>   	 * make it uptodate.
>   	 */
> -	if (!PageUptodate(page)) {
> -		btrfs_read_folio(NULL, page_folio(page));
> -		lock_page(page);
> -		if (page->mapping !=3D mapping || !PagePrivate(page)) {
> -			unlock_page(page);
> -			put_page(page);
> +	if (!folio_test_uptodate(folio)) {
> +		btrfs_read_folio(NULL, folio);
> +		folio_lock(folio);
> +		if (folio->mapping !=3D mapping || !folio->private) {
> +			folio_unlock(folio);
> +			folio_put(folio);
>   			goto again;
>   		}
> -		if (!PageUptodate(page)) {
> -			unlock_page(page);
> -			put_page(page);
> +		if (!folio_test_uptodate(folio)) {
> +			folio_unlock(folio);
> +			folio_put(folio);
>   			return ERR_PTR(-EIO);
>   		}
>   	}
> -	return page;
> +	return &folio->page;
>   }
>
>   struct defrag_target_range {

