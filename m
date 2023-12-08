Return-Path: <linux-btrfs+bounces-770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEE780AED0
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 22:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503D21C2088D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 21:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64CE57891;
	Fri,  8 Dec 2023 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AydEYSMH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DCB93
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 13:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702070700; x=1702675500; i=quwenruo.btrfs@gmx.com;
	bh=Z3h7gzzGVhmyzvKDn58CzGTxGY/UB+tov5wOF/k5wNE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=AydEYSMHZOgX3yuv038u4UvJcJ1ztSNRa9Uo4mYwBByIKr2oRT4Z7SwehWrKl3O4
	 iVJc2TghTVfFg50N4IgUHRien2q7u7GcfjCiRobqEO7qXpSzALPFgQpbFQOCsCdix
	 wqiGIo5JjU3osAjMGTxriLirgULJE4ZIOp+PI37dN2VpHO6oMWD/2dMyA5Cn4hh+u
	 1kJGmPpuBHjFzbxuHQGVg54Yx14Id7JAHtjnDHN5QkR2gFgy1hPCiG2NV0YgAn3bn
	 JFahQa+Uc6gTSagBB92NQep2vPqg90yQwPLxWa5ijqMRo0BlP/3feqyEolGwzRf9u
	 rMZgI4C3989HcvXr/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([118.102.94.57]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUGiJ-1qkay01aOB-00RKol; Fri, 08
 Dec 2023 22:25:00 +0100
Message-ID: <d8a0c35b-2879-48eb-8bb3-2a8186a235ff@gmx.com>
Date: Sat, 9 Dec 2023 07:54:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: Convert defrag_prepare_one_page() to use a
 folio
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20231208192725.1523194-1-willy@infradead.org>
 <b9b91cd5-80be-41c0-a7fe-a64cbbcc6d85@gmx.com>
 <ZXOHsADLeXY03p4P@casper.infradead.org>
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
In-Reply-To: <ZXOHsADLeXY03p4P@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A0za3D1vVE68KLBIxgskms0ogPXr6UXOC/JTIjX87n7ONMOf4O9
 oDy4JXuIDGJArKzaKFdsg1fniHn7xT849mhYTlainjXn+VsQ64TzyqfZnPkJeJQyX66yttW
 Z3JpOJmW2cllGagiD1wZLehdf34onaF/oQFGUh5ONPUPrtCzQvjmk83Gi+06MTkXw+JFaOI
 tve3/fY/UrqEkZuKVKSeQ==
UI-OutboundReport: notjunk:1;M01:P0:THzQl7QqbKw=;i0V2l5Ym1S60oy81yu2vxQ1x1m4
 VhNRtw5Ju9ufrEkCkn7HeiQJTi5H0bEmvRRHlD5XT8ArRxUPvfIzOGW6jOa8NuwlnGeA/e7h1
 Ozstg2yvb5ekC5d/oyznIMbpF7lhSP1QiJQWsbZRlwCifB9TzXxFBjYoc88QeFlVeRxbYzWop
 FKw9HBv9Y1Gp4PziiTjnu+j2wFFnruw6O6jqPS1tLtLMmVajIXAI3fXzWvb69YMmsSjOpxpj1
 qJiZM79LaFnMCNg5cJjF6pgv93NbcC/Z4S7GxKNvNCcO9jxC4u5pk4pr+t7u3NEeXfqoNvRID
 CZnOiCpELV6q0Tr4lJdkRNyGFh7i52A10S6A5o5YTHMm4Hli1CnFxaf35ZJ6Xgoqo52QvwvC8
 4DGlWuVeyXyMFtSlW5CuzJat1XYSYm61JtuBePeyFa1X9zYdxbXofD8+dNe+1N+mn+RZ0d0Ul
 my6X+T/k0X9teJ5BMdK4oyUA7WKlhlmzpQCUni35JT2gdlLCy8cSaXNshE+w0FlbPHggP3V1H
 qPaN3d3NusaNX6+FfJierFoenRpV37neRH0BhFJQT0YZHO6au11fplAGiQlbYdwsu8oOUMoHF
 1eMw/chiyB5o0PRHloqrpToLRhtUzGLr8V3kYZwyPYM4C3y/IN1x1WYbKrGRUeO67hMG6H2b+
 qvNTRwlrzrAVBrXdoiU+3ObpAxd/5o7tMHbuHY4UC+jD7v3KTYRkEeGg5lrwQy6frN3hw4E/P
 VbEuKXijScQbpiv3GUwbXnbqaj+lYfsjmAmumMDpXDtZEIAiIL4st2RPSp06yhMfVqXmEvw2q
 7revSx0V8cSIRGURpPPlawhWBuKMAIqYcq/dW8OQLV3lwEWvA9WB+UlNJ7+cdsfAMF33nknue
 GiXxeZ/sos0pqbEaO8cZja4r31ltghgr3hBJp7cNYMNGyQ+NJdOgwhDDjrZUjTCPU0ZjOVRzD
 MzwqdQ==



On 2023/12/9 07:46, Matthew Wilcox wrote:
> On Sat, Dec 09, 2023 at 07:26:45AM +1030, Qu Wenruo wrote:
>>>    again:
>>> -	page =3D find_or_create_page(mapping, index, mask);
>>> -	if (!page)
>>> -		return ERR_PTR(-ENOMEM);
>>> +	folio =3D __filemap_get_folio(mapping, index,
>>> +			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
>>
>> When I was (and still am) a newbie to the folio interfaces, the "__"
>> prefix is driving me away to use it.
>>
>> Mind to change it in the future? Like adding a new
>> filemap_get_or_create_folio()?
>
> I'm always open to better naming ideas.  We definitely have too many
> inline functions that call pagecache_get_page():
>
> find_get_page()
> find_get_page_flags()
> find_lock_page()
> find_or_create_page()
> grab_cache_page_nowait()
>
> ... and I don't think anyone could tell you when to use which one
> without looking at the implementations or cribbing from another
> filesystem.
>
> So I've tried to keep it simple for the folio replacements and so
> far we only have:
>
> filemap_get_folio()
> filemap_lock_folio()
> filemap_grab_folio()
>
> and honestly, I don't love filemap_grab_folio() and I'm regretting
> its creation.

In that case, I'd prefer just a single filemap_get_folio(), passing all
the GFP and FGP flags just like __filemap_get_folio(), and get rid of
any wrappers.

In fact, I'd say the __filemap_get_folio() with all the FGP flags is
easier to read to me at least.
(And with direct FGP control for callers, we can make it easier to
allocate higher order folios if the caller wants)

>
> What I do like is the creation of FGP_WRITEBEGIN, but that doesn't
> address your concern about the leading __.  Would you be happier if
> we renamed __filemap_get_folio() to filemap_get_folio_flags()?

Oh, with a _flags() suffix it would be also a good idea.
>
> This would all be much better if C allowed you to specify default
> arguments to functions :-P
>
>>> -	ret =3D set_page_extent_mapped(page);
>>> +	ret =3D set_page_extent_mapped(&folio->page);
>>
>> With my recent patches, set_page_extent_mapped() is already using folio
>> interfaces, I guess it's time to finally change it to accept a folio.
>
> I'll add this as a prep patch:
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b5a2399ed420..99ae54ab004c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -909,18 +909,22 @@ static int attach_extent_buffer_page(struct extent=
_buffer *eb,
>
>   int set_page_extent_mapped(struct page *page)
>   {
> -	struct folio *folio =3D page_folio(page);
> +	return set_folio_extent_mapped(page_folio(page));
> +}
> +
> +int set_folio_extent_mapped(struct folio *folio)
> +{
>   	struct btrfs_fs_info *fs_info;
>
> -	ASSERT(page->mapping);
> +	ASSERT(folio->mapping);
>
>   	if (folio_test_private(folio))
>   		return 0;
>
> -	fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +	fs_info =3D btrfs_sb(folio->mapping->host->i_sb);
>
> -	if (btrfs_is_subpage(fs_info, page))
> -		return btrfs_attach_subpage(fs_info, page, BTRFS_SUBPAGE_DATA);
> +	if (btrfs_is_subpage(fs_info, &folio->page))
> +		return btrfs_attach_subpage(fs_info, &folio->page, BTRFS_SUBPAGE_DATA=
);
>
>   	folio_attach_private(folio, (void *)EXTENT_FOLIO_PRIVATE);
>   	return 0;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index c73d53c22ec5..b6b31fb41bdf 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -202,6 +202,7 @@ int btree_write_cache_pages(struct address_space *ma=
pping,
>   void extent_readahead(struct readahead_control *rac);
>   int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info=
 *fieinfo,
>   		  u64 start, u64 len);
> +int set_folio_extent_mapped(struct folio *folio);
>   int set_page_extent_mapped(struct page *page);
>   void clear_page_extent_mapped(struct page *page);
>
>
>>> -		if (page->mapping !=3D mapping || !PagePrivate(page)) {
>>> -			unlock_page(page);
>>> -			put_page(page);
>>> +		if (folio->mapping !=3D mapping || !folio->private) {
>>
>> This folio->private check is not the same as PagePrivate(page) IIRC.
>> Isn't folio_test_private() more suitable here?
>
> One of the projects I'm pursuing on the side is getting rid of PG_privat=
e.
> There's really no need to burn a very precious page flag telling us
> whether the filesystem has something stored in folio->private when we
> could just look at folio->private instead.
>
> So yes, generates different code, but the two should be the same.

OK, got it. And hoping before we can get rid of PG_private, we can get
rid of page usage inside btrfs first.

Thanks,
Qu

