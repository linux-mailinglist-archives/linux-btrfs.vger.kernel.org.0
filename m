Return-Path: <linux-btrfs+bounces-6356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461EE92DF9F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 07:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2E01F227DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 05:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC92382899;
	Thu, 11 Jul 2024 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OprD4Ovo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACA7829C;
	Thu, 11 Jul 2024 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675797; cv=none; b=XzZJTzlNQcidYh5RsA7wSnLTAsWTwkmxClKWc3zABsYei9U1/ru6jHmEyAeWxmd4ZD+sMaQVJxir9MtKlAf8NMrtuFfGfQCep5bYtImyx/hv/WKwy0O4p1JoK1INz2IDtSv5oO5ek7OmagPGwISaC5cK8CPnSdPEZIiKjpzYgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675797; c=relaxed/simple;
	bh=tVi+AdVtLCoo0xLNKhOl4i2hgIaH2Q3fdb81B0+VlsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9BAO1DOVoy4Ll2l+3LVv/M+M7vbDMNYvR+54+LF18YcrzTP2IS/NlYquywZNuOoCnHnI9I8wxD0FdLYOdCV3l2dz3vhQZPOM2H+4glsYnjcPxb5ALwJ1SiQyYFrnGp6eVzvArPnhD/RioXbDTrbEQAX7bHvMh6mWl7LQuF+1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OprD4Ovo; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720675785; x=1721280585; i=quwenruo.btrfs@gmx.com;
	bh=+RR1hUYr3X9lDdEoYTmfRGxXIBBbKKDuAWup2kRpIkA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OprD4OvohLpOFHYrjUCh7WLJmnMy4OInb2IgqUpSl+SzJdnc/48jWuw3LIdLInjI
	 eFnE7M6/k0ddA39b8Pbwxe2YypuGG7kbvSLGKwY0Z2PyTsiuTwuL5t3UrqsH2Lqig
	 CXeGZBiNauyKH6YOBsUmgfv6autPgnm1vPDtrPfA5zhWnJiKF2HlKydFHEdqI7zq0
	 eWf3j+vahV0rWLZgl+gbyM2pPTT2Iq28pET3oFlj4ePGulHxt3Wa39ROd7PulfbB3
	 YtTISwg0K6fADcZEscG18mavkqcBR+hM2wjygkcWoi3lZDNZXzcdVA1zubMnl9jtD
	 kZJ3uldjVNnPhbUd5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhlGk-1rx8SP0Ft2-00mlSF; Thu, 11
 Jul 2024 07:29:45 +0200
Message-ID: <edcd0036-5782-4c29-9f5e-b7610ea9eb4e@gmx.com>
Date: Thu, 11 Jul 2024 14:59:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: Fix slab-use-after-free Read in
 add_ra_bio_pages
To: Pei Li <peili.dev@gmail.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, skhan@linuxfoundation.org,
 syzkaller-bugs@googlegroups.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
References: <20240710-bug11-v2-1-e7bc61f32e5d@gmail.com>
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
In-Reply-To: <20240710-bug11-v2-1-e7bc61f32e5d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ox+U2OEvYY4rVIdz47iUwojWUYdvqQIDD2B1PU937XY42mwDTyW
 Q9tiqbtT3EfE9DKOvcKxzDZDhxJ9UXuVjvMIleGlbQIqPkqXoZZ5FRh1OBV+NY5x+qwuV0h
 SGQS7J9kUYi34AwRL+zWloCk+ivUIvou8dFNrQnzirKJWxxPnokEw5BVF70ZvyEmExPP2Xg
 9QccyLEAk44uZdt7YUEzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w4iUgBVpG5M=;o49mxWNPbOyzJaXhBCeFaWdsVcG
 o4R84zsczPUv/aWyMPoOlJsAmCQJsithZ4XVUasgVUGLm7kCZthtaofSYjqripn4YGG6Jqq5/
 1zRTdxxvihkbufcXLY37DyrXEF4LaN7o/Jav9LdsIyHewSHNqUNFzXNhGSgpBJDucvgydxErl
 uTwTIl17lDqfBce1yH8CPF3Mxvbc/u0RBlY7BXYD5f+spCUEk46tgRudzBH6siEe9qWeMp7ik
 eod+5l/HkiuVPiIS0H2zEcpgcr6nrR5dAxHSiW5uUJNvi9A3+ETyk+UqvuhnSzrmvEOm07XWw
 yIVOlvc+wMZ3xYoVRxJBylpzaYCb23hl0rrKB05vNMbiOV9/AfrrrHIT8MrsKnHeF3YOsR71S
 gIrOZsiNA0AJi0Ef+zlJZB6X62OAGAHTsPfCquaAaF31OVbjtR/irsa+yXehrKcjlFoHBwQOh
 skRDiTP0t63jicAOcfHdewVcXvMI9OPqyzmY3yF+uJBnpdEwZxHKxDYy1oqN81hHQFe8tKGOw
 i+f4Q8+DnUlpl/5IvxbtACNxlALWAgtahBegSxAped73hdOuilw7bEX3C6YnNd+inK6rQYdXK
 ecc63czZyPIx+QPzG7XikyA6URatxrTh75QLfApASgGivj35QjByw3PWGLmJyNRGOWcOtJrSP
 QGbYH/J4BuH6I1iywHVajjC8G9l+HXl1pO83tyJUtGVCnAK9sAeekuBzSqLPWbLo38ezX2diI
 yTUeaFtIGfJ459hyVUqZQhpvYVEtM6g4YprFdWe/9rcQsXsTdBqMkaDe4WypSu/ypiRTwjCul
 8Tak27/d2aHvjj25uMfo7u7mNa6ZjyPoT7WwnsolUU654=



=E5=9C=A8 2024/7/11 13:59, Pei Li =E5=86=99=E9=81=93:
> We are accessing the start and len field in em after it is free'd.
>
> This patch moves the line accessing the free'd values in em before
> they were free'd so we won't access free'd memory.
>
> Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D853d80cba98ce1157ae6
> Signed-off-by: Pei Li <peili.dev@gmail.com>
> ---
> Syzbot reported the following error:
> BUG: KASAN: slab-use-after-free in add_ra_bio_pages.constprop.0.isra.0+0=
xf03/0xfb0 fs/btrfs/compression.c:529
>
> This is because we are reading the values from em right after freeing it
> before through free_extent_map(em).
>
> This patch moves the line accessing the free'd values in em before
> they were free'd so we won't access free'd memory.
>
> Fixes: 6a4049102055 ("btrfs: subpage: make add_ra_bio_pages() compatible=
")

This fixes tag, along with the syzbot report, should be in the main
commit message, not after the "---" line, which would be discarded when
applying.

> ---
> Changes in v2:
> - Adapt Qu's suggestion to move the read-after-free line before freeing
> - Cc stable kernel

It's not just Ccing to the stable list, but with a version tag.

For all the proper tags usage, you can check this commit, it has all the
correct tags.

b2a616676839 ("btrfs: fix rw device counting in __btrfs_free_extra_devids"=
)

Otherwise the code looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> - Link to v1: https://lore.kernel.org/r/20240710-bug11-v1-1-aa02297fbbc9=
@gmail.com
> ---
>   fs/btrfs/compression.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 6441e47d8a5e..f271df10ef1c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -514,6 +514,8 @@ static noinline int add_ra_bio_pages(struct inode *i=
node,
>   			put_page(page);
>   			break;
>   		}
> +		add_size =3D min(em->start + em->len, page_end + 1) - cur;
> +
>   		free_extent_map(em);
>
>   		if (page->index =3D=3D end_index) {
> @@ -526,7 +528,6 @@ static noinline int add_ra_bio_pages(struct inode *i=
node,
>   			}
>   		}
>
> -		add_size =3D min(em->start + em->len, page_end + 1) - cur;
>   		ret =3D bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
>   		if (ret !=3D add_size) {
>   			unlock_extent(tree, cur, page_end, NULL);
>
> ---
> base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
> change-id: 20240710-bug11-a8ac18afb724
>
> Best regards,

