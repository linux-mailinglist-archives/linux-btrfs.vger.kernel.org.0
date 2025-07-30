Return-Path: <linux-btrfs+bounces-15752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4421CB15F2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 13:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9F61668EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957BC28726C;
	Wed, 30 Jul 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kLPNjjXF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A425761
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874407; cv=none; b=N3pSjOPY3g4VC9nqEweITystfY8DJKVXFp1dRqyGi8Opd9IBkVqYIz2mJcPMTqMzE67q/Rpe4DYlNkS3IVyTdkCJ5OgmDB20AJk/jGy4qQYZ+ZJBjGaXalsyGqNKEGO/Tfygz2OmLoIs6scfYX6RhN6ADMd3HXuHHflshhRpqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874407; c=relaxed/simple;
	bh=8z92i3X3FiuhFMvK/MHLbI8q8r89kZsL+nr3x4CH+nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbFrW3IXqRFha4WpU74RE5PUC9s7++d4BIQbUwSRq/cvCZT8Lt4ThmYMc5glScDv6G3jhzSsVERl2m6+BwlpNE3SZfcVNSGdzeeyLtGmJVvtaS1EIjev3B5xISwregPk6g2eX8eFFGGmIPTvob5s0Y0L6X50TdLBxFkDThWy3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kLPNjjXF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753874400; x=1754479200; i=quwenruo.btrfs@gmx.com;
	bh=liVec7CGTIpSItrjF85kun3o6sQhp0TfhnrHlpAvqR4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kLPNjjXFIQRuY5SCwp6KmID3k6w0l6S54JnPjH0Sgxan9R91PKwK88+9xOiDS4YY
	 4bwPPp7YYKUWRucnkTAgKEynQLtBs+uvSDxH7cOAW3V6a+Bs02e33ZbBVodW6Hwdn
	 3BuP7vkP1IVlaVArBv4zkH7qUqeM48869JsbDWeqphzdn7DQetCrAYIEK+3WTmJhu
	 STBTSutY8KLMUBHO1W6/ILOHVkH+qQ2VLDZFn0kuwIRbNvPYayGtG4qQgDd2RJW8b
	 ucUCtbsj2XDtLeDIZmV8DA+KOKNbE5BbBIMs+BK/a6TqdpMF7tspBM63GkngpS/dJ
	 XOJ+ra1MIfRVb+zLGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1uWvKN1E32-014JMP; Wed, 30
 Jul 2025 13:20:00 +0200
Message-ID: <dde2b8b0-49a1-4f3d-aa26-c1ab635b42a1@gmx.com>
Date: Wed, 30 Jul 2025 20:49:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: subpage: keep TOWRITE tag until folio is cleaned
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: wqu@suse.com
References: <20250730103534.259857-1-naohiro.aota@wdc.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20250730103534.259857-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pltue13M9vmjlkO+zqgHHocp6DSqBXLP2Z+2d1IaZEDvrunl+/s
 nmX9yqTRbhlWlybY2H8y1dmc3zzN+ZAfiJBaoTmYiBXBxvrRqYz2TeVTJY2smtEO/37oNcT
 itKc5cPAzXrC08/WYejWvJ/xY0mvJzaQWq5960w5HBSg+fjNSEuXozC2CYtmJMbCgyVpRFP
 j9v/htx9SueXaj6dXCgRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O6F9Ll67Vr8=;6DcpbGdep2UMfdSYkLAi+U9hFb1
 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
 6LfazM4CYOPFQ+OfUSol2Zo=



=E5=9C=A8 2025/7/30 20:05, Naohiro Aota =E5=86=99=E9=81=93:
> btrfs_subpage_set_writeback() calls folio_start_writeback() the first ti=
me
> a folio is written back, and it also clears the PAGECACHE_TAG_TOWRITE ta=
g
> even if there are still dirty pages in the folio.

I'd like to change the words "dirty pages" to "dirty blocks" here.

As we can have subpage block size, and in that case we can still have a=20
single page sized folio, but multiple blocks.

> This can break ordering
> guarantees, such as those required by btrfs_wait_ordered_extents().

It would be better to give an example. I believe this would lead to=20
hanging btrfs_wait_ordered_extents().

>=20
> Consider process A calling writepages() with WB_SYNC_NONE. In zoned mode=
 or
> for compressed writes, it locks several folios for delalloc and starts
> writing them out. Let's call the last locked folio folio X.

In this case, I'd prefer to have some simple ASCII charts explaining the=
=20
situation.

E.g. with 16K page size, 4K block size, no large folio.

     0     4K    8K     12K     16K    20K    24K   28K    32K
     |//////////////////////////|//////|      |////////////|

Ranges [0, 20K) and [24K, 32K) are dirty.

I believe this would be a little more easier to explain just using folio X=
.

> Suppose the
> write range only partially covers folio X, leaving some pages dirty.
> Process A calls btrfs_subpage_set_writeback() when building a bio. This
> function call clears the TOWRITE tag of folio X.
>=20
> Now suppose process B concurrently calls writepages() with WB_SYNC_ALL. =
It
> calls tag_pages_for_writeback() to tag dirty folios with
> PAGECACHE_TAG_TOWRITE. Since folio X is still dirty, it gets tagged. The=
n,
> B collects tagged folios using filemap_get_folios_tag() and must wait fo=
r
> folio X to be written before returning from writepages().
>=20
> However, between tagging and collecting, process A may call
> btrfs_subpage_set_writeback() and clear folio X=E2=80=99s TOWRITE tag. A=
s a result,
> process B won=E2=80=99t see folio X in its batch, and returns without wa=
iting for
> it. This breaks the WB_SYNC_ALL ordering requirement.
>=20
> Fix this by using btrfs_subpage_set_writeback_keepwrite(), which retains
> the TOWRITE tag. We now manually clear the tag only after the folio beco=
mes
> clean, via the xas operation.
>=20
> Fixes: 55151ea9ec1b ("btrfs: migrate subpage code to folio interfaces")

I guess the real fixes commit would be even earlier?

Even before that commit, we're already using set_page_writeback() which=20
is the same as folio_start_writeback() and clears TAG_TOWRITE.

> CC: stable@vger.kernel.org # 6.12+

In that case, the stable will go back to the initial v5.15 subpage=20
support...

> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Thanks a lot for not only catching this bug, but also fixing it.
The code looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/subpage.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index c9b3821957f7..67cbf0b15b4a 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -448,8 +448,25 @@ void btrfs_subpage_set_writeback(const struct btrfs=
_fs_info *fs_info,
>  =20
>   	spin_lock_irqsave(&bfs->lock, flags);
>   	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
> +
> +	/*
> +	 * Don't clear the TOWRITE tag when starting writeback on a still-dirt=
y
> +	 * folio. Doing so can cause WB_SYNC_ALL writepages() to overlook it,
> +	 * assume writeback is complete, and exit too early =E2=80=94 violatin=
g sync
> +	 * ordering guarantees.
> +	 */
>   	if (!folio_test_writeback(folio))
> -		folio_start_writeback(folio);
> +		folio_start_writeback_keepwrite(folio);
> +	if (!folio_test_dirty(folio)) {
> +		struct address_space *mapping =3D folio_mapping(folio);
> +		XA_STATE(xas, &mapping->i_pages, folio->index);
> +		unsigned long flags;
> +
> +		xas_lock_irqsave(&xas, flags);
> +		xas_load(&xas);
> +		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
> +		xas_unlock_irqrestore(&xas, flags);
> +	}
>   	spin_unlock_irqrestore(&bfs->lock, flags);
>   }
>  =20


