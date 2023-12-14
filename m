Return-Path: <linux-btrfs+bounces-963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3594F813E3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 00:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07CE1F218D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54E6C6E6;
	Thu, 14 Dec 2023 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="N6k1loJB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83446C6CD
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702596358; x=1703201158; i=quwenruo.btrfs@gmx.com;
	bh=YHgD3mGT0EKYYRrroH6yXzTWGnVsrfLU6k9SCNdyncU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=N6k1loJB/OJT6v76QTOA277rkg8fwsKBdx96yTLqYJXKL+QORu+LxgImhj21TSmB
	 VtCXQNdvRvHY6EUkpz5Tw2AvssMNZqRA+zqZYwrEoObRs6BNFZOu7CQJYw4g3WX2B
	 v95lf9u/8+HA1cWvkCyfK9tj+dWR31OPuWxsia+Br8OIwjDYIZfRH/NmnTwqGtArK
	 +alW2BfWeN0BeeJ33HpHp/flmRSnJrNWPTneSxtYW9eS5SKcXcv4g8BHcaneepujs
	 H9fmrslNwY5hOVcgKi0Od2M11frzinA8nCVayKqYk7B3OJr5igbGyJU17yQGQ0yAU
	 EcXkG6P2fa/TyNAFoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.79.20]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3HU-1qyZ1p3JKi-00FOwm; Fri, 15
 Dec 2023 00:25:58 +0100
Message-ID: <8d366735-f767-4a00-b327-354648e4835a@gmx.com>
Date: Fri, 15 Dec 2023 09:55:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RESEND] btrfs: don't double put our subpage reference in
 alloc_extent_buffer
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <dd32747467e46ee7ce4feb8a1c3a30d93fd4b133.1702593423.git.josef@toxicpanda.com>
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
In-Reply-To: <dd32747467e46ee7ce4feb8a1c3a30d93fd4b133.1702593423.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fr92bYXWTL+6OK1VBY2opOxr9p6SjSCaCHIQD8aZnixznymVSpX
 zO6t+iDXjJz9cnx+oEz2390/0nNTJClj4fYyFWNZskpNLUVoa3zauqfkgX7h3SwLcBvwNfi
 XMF7JIbEkOjHKyPFq91p3WgHUIzc957mVeCbRyfxYJxC+bFjbkjctO124JVO5nRzKqa1q3A
 Phbcqsn2fGF+f1sOXqj+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yJgBhICd1Xk=;eKTEHzrfxUzKHWbJbt8i45JBu9k
 VXJPl+19N2V0Pfpyw6IAw5in5UVMBdS2DkOBVIux9UNZ5k60HSiQdhYjb9wjQBAR4owJY+oWe
 KK5fv1DiR/U4bbmekEnVCAUJ+IvPyJN2HDJcCHFVc/3C9cANum99wvu609rHAJK09kUBPdhv+
 80QPuFIlm7/zhnrZqNL3WTS2Vg8CThSCZ/EhTjryZh4ONHsSEBplI4+JW5K+H75RV6aDJdkvt
 VKOXD4QcWULcMs0yFaZG9AeiVEn/WEjDCx5l7jO2DzRFPSfuMSYYHJ7KxQFCt4PmPndEHH8dQ
 BoeYNMU4m9y30iWPImwQba8TT9RE+D8WR/dmAoTTRVPY41RKpg0LL+gTDMCNGLRpEfDPx3ggK
 rClDSgmiregStdhJEWvLKQGov8+aBlteNzfiZ7y4G4HXJ0TB8jIxzOibzQZTDNNi/5/TDLXAS
 zSa94kQXwiC1a4oWakpnLcSLVOTzBkHqvkiq7BM1Cj/XrpYXvBX4bHRW5bbuMvwWuR1tviwSi
 9w5kOu8X71cvUa4HEL6l1E1MtClQKhyM+3cxGuXsth+/tUrbZ3Um/VNjykEdbAIubfaHLr/1j
 KzmUOU4uTEOt2snrnuAgbvKxiuBMX10tvS6S/A7Sq09i/5tJMEXGIJijJ1Iiz97kc4gnPQyQU
 Qe09xOG15MfnClSUc8T1QxgNkREkcmbns35YzgZ8oiS2Q12qQ/5SWOI+WJAbupzWMejE4VT07
 HVC62Lbn/ryTC9EyFwwjT/FqxH3/82G89wpC7tmuiWGKffWBs4SLXeGpli0NqhVBJPPMcTORL
 8PYbNwYF9Uz8uSQuTSm6Soab2i+zv7MZoJvw0aBAWQUGrat6pVsjRoZOO+2oE6BbZAUTFmG3U
 MZY66TYHL4RIc5sBifh66eSUYIvsgtTKOMKcJpI0+/kLYn84E3gUSeu7OBvg07RXWb8AO69/I
 NnKpinLhewB14cVQMIDdFW9uCzM=



On 2023/12/15 09:09, Josef Bacik wrote:
> ** Apologies if you're getting this twice, I fat fingered my email comma=
nd **
>
> This fix can be folded into "btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method".
>
> We have been seeing panics in the CI for the subpage stuff recently, it
> happens on btrfs/187 but could potentially happen anywhere.
>
> In the subpage case, if we race with somebody else inserting the same
> extent buffer, the error case will end up calling
> detach_extent_buffer_page() on the page twice.
>
> This is done first in the bit
>
> for (int i =3D 0; i < attached; i++)
> 	detach_extent_buffer_page(eb, eb->pages[i];
>
> and then again in btrfs_release_extent_buffer().
>
> This works fine for !subpage because we're the only person who ever has
> ourselves on the private, and so when we do the initial
> detach_extent_buffer_page() we know we've completely removed it.
>
> However for subpage we could be using this page private elsewhere, so
> this results in a double put on the subpage, which can result in an
> early free'ing.
>
> The fix here is to clear eb->pages[i] for everything we detach.  Then
> anything still attached to the eb is freed in
> btrfs_release_extent_buffer().
>
> Because of this change we must update
> btrfs_release_extent_buffer_pages() to not use num_extent_folios,
> because it assumes eb->folio[0] is set properly.  Since this is only
> interested in free'ing any pages we have on the extent buffer we can
> simply use INLINE_EXTENT_BUFFER_PAGES.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for exposing and fix the bug,
Qu

> ---
>   fs/btrfs/extent_io.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7898e17e8d84..b42603098b6b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3185,11 +3185,9 @@ static void detach_extent_buffer_folio(struct ext=
ent_buffer *eb, struct folio *f
>   /* Release all pages attached to the extent buffer */
>   static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb=
)
>   {
> -	int num_folios =3D num_extent_folios(eb);
> -
>   	ASSERT(!extent_buffer_under_io(eb));
>
> -	for (int i =3D 0; i < num_folios; i++) {
> +	for (int i =3D 0; i < INLINE_EXTENT_BUFFER_PAGES; i++) {
>   		struct folio *folio =3D eb->folios[i];
>
>   		if (!folio)
> @@ -3754,10 +3752,28 @@ struct extent_buffer *alloc_extent_buffer(struct=
 btrfs_fs_info *fs_info,
>
>   out:
>   	WARN_ON(!atomic_dec_and_test(&eb->refs));
> +
> +	/*
> +	 * Any attached folios need to be detached before we unlock them.  Thi=
s
> +	 * is because when we're inserting our new folios into the mapping, an=
d
> +	 * then attaching our eb to that folio.  If we fail to insert our foli=
o
> +	 * we'll lookup the folio for that index, and grab that EB.  We do not
> +	 * want that to grab this eb, as we're getting ready to free it.  So w=
e
> +	 * have to detach it first and then unlock it.
> +	 *
> +	 * We have to drop our reference and NULL it out here because in the
> +	 * subpage case detaching does a btrfs_folio_dec_eb_refs() for our eb.
> +	 * Below when we call btrfs_release_extent_buffer() we will call
> +	 * detach_extent_buffer_folio() on our remaining pages in the !subpage
> +	 * case.  If we left eb->folios[i] populated in the subpage case we'd
> +	 * double put our reference and be super sad.
> +	 */
>   	for (int i =3D 0; i < attached; i++) {
>   		ASSERT(eb->folios[i]);
>   		detach_extent_buffer_folio(eb, eb->folios[i]);
>   		unlock_page(folio_page(eb->folios[i], 0));
> +		folio_put(eb->folios[i]);
> +		eb->folios[i] =3D NULL;
>   	}
>   	/*
>   	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag=
,

