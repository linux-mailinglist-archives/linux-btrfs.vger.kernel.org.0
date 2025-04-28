Return-Path: <linux-btrfs+bounces-13451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D68A9E594
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 02:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECBB174D47
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 00:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D1E824A3;
	Mon, 28 Apr 2025 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="S7XvtHjr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D62701C4;
	Mon, 28 Apr 2025 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745801716; cv=none; b=eMaozg5/8yZ+FYAVqrYEafdZKm+ektfL0pz+BwsbIUjIihXWYrwcmTF+0HcWcILelRuwR5OvQMurDVVYQhywyO5Mv6Lt4wXVlMcQ52XL5UH56cuI5cOKMKS8j3GwEHnhfrwvPjALklXVWiehKb0i4siKNA+2Rllh82mHcXmQWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745801716; c=relaxed/simple;
	bh=rbL4RzpEsNCUPPzGCnLsq1KKLwbH6W+3/T3nVBW+730=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZS9HVDVx2Shp/5Gmm7Tv47pwabV+I1CINbRh22LUNY4Uc0qJaDmYIWKTVMkgubCNtifAlWtsAn0a4bl4f2ChSztjJJZTcwaLjvHU5AzQzAkLX0vw/RuwUDSS6xB/2zBOniHb1jjhnqE8IPN1ztN7i0LvKLfkxBAGoHLHJEnF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=S7XvtHjr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745801690; x=1746406490; i=quwenruo.btrfs@gmx.com;
	bh=cHMkMtPuzLwDzlVBTFVYY1/QbmNVDFs84MpxZ9e/lKI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S7XvtHjrOgMLXZ0UQku9PJCeV+GcVA6mCWdyaQXtv08PvnPIIkWw7S3yTjgcRUsC
	 46qsrQL4Pw4a/I8htig/+7p5jr+Gj0waIGIEQga1ljfE//vEWpTotho0HsQqZhk++
	 IdAZeZBm8Cm9m1KYD9gsGys3JgPLWDVJcjJm3a5rL+AYRCoMMzyzOTcN3rYtVw7mx
	 N0+c7TBCxuhDQpnm1bkFpQus+aTTrJHileQuHd3QOowVxHRcFU8f86g0TKTzvhDOS
	 8m6JbomE6P4lGEw7T2uDRGM7nmVh3PCN3AmqtcbdT9392mygHk2CRe4JHLzlk7fnO
	 Tdyn6QTcuQ4UqbYTig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1usk401NQQ-00nVPT; Mon, 28
 Apr 2025 02:54:50 +0200
Message-ID: <30968c68-7ec2-4185-9b48-f8335dc2e0b0@gmx.com>
Date: Mon, 28 Apr 2025 10:24:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] btrfs: drop usage of folio_index
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20250427185908.90450-1-ryncsn@gmail.com>
 <20250427185908.90450-3-ryncsn@gmail.com>
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
In-Reply-To: <20250427185908.90450-3-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NQVBIz7u97G+ffMZGnSDD9pxOzVK7bZg7PkD30uIkaBEFjBer5z
 SE1jlkBt6t2RkcBO7p98qoOuWUGRwDPJpD1Md03rbjcps9xU1FUmiGCX2xb7ro9Eq+6e7zI
 CtRa5gMcKXUxiAWSrsUqESqPg3+eYkVJw0rjstmW5YFh3yuoZVga/8tvuCrBvlb+jcrBNw0
 hr0iQQvW+yD08n7ujtUFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z8CNmOw/eCM=;M3B0+QdhUVIszmb9Hbo8r1q2tFi
 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



=E5=9C=A8 2025/4/28 04:29, Kairui Song =E5=86=99=E9=81=93:
> From: Kairui Song <kasong@tencent.com>
>=20
> folio_index is only needed for mixed usage of page cache and swap
> cache, for pure page cache usage, the caller can just use
> folio->index instead.

The patch looks good to me, but I'm afraid the next commit message is=20
not accurate.

>=20
> It can't be a swap cache folio here.  Swap mapping may only call into fs
> through `swap_rw` and that is not supported for btrfs.  So just drop it
> and use folio->index instead.

Btrfs supports swap file, it's just not through the swap_rw() callback.

In this particular case, the folio belongs to the metadata (btree)=20
inode, thus it will never be swap cache folio.

With that changed, it looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: Josef Bacik <josef@toxicpanda.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: David Sterba <dsterba@suse.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   fs/btrfs/extent_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 197f5e51c474..e08b50504d13 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3509,7 +3509,7 @@ static void btree_clear_folio_dirty_tag(struct fol=
io *folio)
>   	xa_lock_irq(&folio->mapping->i_pages);
>   	if (!folio_test_dirty(folio))
>   		__xa_clear_mark(&folio->mapping->i_pages,
> -				folio_index(folio), PAGECACHE_TAG_DIRTY);
> +				folio->index, PAGECACHE_TAG_DIRTY);
>   	xa_unlock_irq(&folio->mapping->i_pages);
>   }
>  =20


