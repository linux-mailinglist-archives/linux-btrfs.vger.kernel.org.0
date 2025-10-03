Return-Path: <linux-btrfs+bounces-17420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AECBB82E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 23:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E5E4A6F05
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016625DCE0;
	Fri,  3 Oct 2025 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JOjGjDdY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248631F63FF
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526322; cv=none; b=cDN2XNNj6qNQO9Vn+AcY6vgAcB8Ug4XP4b6L52yYrbWpc/tdHaxrUB8gFB+swrJ5E5Lb7DzIxavT6D/pCvdHnzkANpZ85hb4QlJtuKhC0d3OxvAMx2+71lPKVRZOlwXIe4Y3U6iAK86Mfn616varzc/lsAEM9ii/8Id73o7QfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526322; c=relaxed/simple;
	bh=cdi8diOKvl/kFzstYU62V3dp+byOlFAovUvaea9RHdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzX8gd65I9b5/xrmdw3hgy3Lzb0x0AYCBqbFH94PjpA9Ohn3ttiW361h/CVvhE6Kv12UJAZZYcdmW/A8ML+b4/l6glOlAnMQvp8V8d+zGvjR3EdNRnoh7f/O2mygEduiYeKxK6sguMI5lyQqWw3KvCzToZ4+2C4VO03w9jREebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JOjGjDdY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759526318; x=1760131118; i=quwenruo.btrfs@gmx.com;
	bh=ClOl3KBa/fy5rJhCOL7memoPu2mkys7ELD5JHWEkEtc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JOjGjDdY22NgZcABCzuruymCVxpy9JdysN3dSvJbkwSuox1Cw+GZkRdltYsBIPz9
	 i6rc1cXkkOnycqISSuGbnVzbToAMHwUN2LQUFbAGT2kMq0KzRBMy2dJwIcvh+LGYr
	 MRnMydwrvG/PgY8A5sXlDuFUWKEolUToKJ0TdRcN+Rtemt6VKAEpTspt8HMP7c60M
	 0lAuJV7W+3CDvEB9RrKme9Lp4sqc4zJ17/uzI8DflKtqPDqCUcCVI3oliTYjJ3eud
	 d0BjtCtWcHLGbhuEHZ2tdb4pcfw93yt4fGUP+0utThzzWmo1RxxYtkz8/5Yp/YLbE
	 n8ziF96Cg7HUFOUj/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XU1-1uA1YC2NAv-00tvZE; Fri, 03
 Oct 2025 23:18:38 +0200
Message-ID: <e6efa85d-744d-4041-b156-9f9909ca99a0@gmx.com>
Date: Sat, 4 Oct 2025 06:48:33 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] btrfs: make btrfs_repair_io_failure() handle bs > ps
 cases without large folios
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev
References: <202510030550.mqFoO0Dw-lkp@intel.com>
 <234df03b-e6fc-44c8-a28f-aa51305d87a0@gmx.com>
 <aN-rOq9boL0hXZ3R@stanley.mountain>
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
In-Reply-To: <aN-rOq9boL0hXZ3R@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z9W0w/aMEbBUZfUL8mNd9BCT8+hGTUtbIKrLqeUXjbIySpsQYa6
 2Eap3rXiY+kGFQ+nFMVieakfOz2JMyXEe6QqvAtQ9JbbJnYb4S9q9GBRq8dI09RgTINbOA6
 kXVDSot1kKDk2XJJV5yKJw9V0OyslLSH6rRzrvnMt3JucdxCFZ7nsMksCdsVplrDh4ZDilP
 pLCwR6bqma1BwMvkBNofA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/+uAWj/nRIg=;GtprqLy8GiiRPtC3A4p5Yh0i8i2
 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



=E5=9C=A8 2025/10/3 20:23, Dan Carpenter =E5=86=99=E9=81=93:
> On Fri, Oct 03, 2025 at 06:47:11PM +0930, Qu Wenruo wrote:
>>> cc53bd2085c8fa David Sterba      2025-09-17  885  	if (unlikely(!smap.=
dev->bdev ||
>>> cc53bd2085c8fa David Sterba      2025-09-17  886  		     !test_bit(BTR=
FS_DEV_STATE_WRITEABLE, &smap.dev->dev_state))) {
>>> bacf60e5158629 Christoph Hellwig 2022-11-15  887  		ret =3D -EIO;
>>> bacf60e5158629 Christoph Hellwig 2022-11-15  888  		goto out_counter_d=
ec;
>>> bacf60e5158629 Christoph Hellwig 2022-11-15  889  	}
>>> bacf60e5158629 Christoph Hellwig 2022-11-15  890
>>> 2d65a91734a195 Qu Wenruo         2025-10-01  891  	bio =3D bio_alloc(s=
map.dev->bdev, nr_steps, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
>>> 2d65a91734a195 Qu Wenruo         2025-10-01  892  	/* Backed by fs_bio=
_set, shouldn't fail. */
>>> 2d65a91734a195 Qu Wenruo         2025-10-01  893  	ASSERT(bio);
>>> 2d65a91734a195 Qu Wenruo         2025-10-01 @894  	bio->bi_iter.bi_sec=
tor =3D smap.physical >> SECTOR_SHIFT;
>>
>> I have no idea how to make smatch happy.
>=20
> I would just delete the unnecessary NULL check,

Sounds good, as all other fses are doing without a NULL check.

Thanks,
Qu

> but an equally valid
> thing is to just ignore the warning.  In the kernel, all old warnings
> are false positives.  I'm never aiming for being completely free from
> static checker warnings because that means we have to be less ambitious
> about what we check for.
>=20
> regards,
> dan carpenter
>=20
>=20


