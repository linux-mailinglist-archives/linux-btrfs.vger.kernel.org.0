Return-Path: <linux-btrfs+bounces-11443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ECEA338EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 08:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45374162EF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701E20A5EF;
	Thu, 13 Feb 2025 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OL0rFZnc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC8207A3D
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432075; cv=none; b=itV3av15czfjCQhuB5stGkm9ViKQ5OeW4hQtenIKCgsy6bVoMgi3+wEwLUhQCgEjSDmWd4lKwv5R3ZKqOfymT2Emx2r0jPJHd6PzhrHrMqmXayvsfrHUqR2uAx5oWuM22li5olPKj8mOfV4ab39oIl5GYzOpwhTCup9DkiesaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432075; c=relaxed/simple;
	bh=CFykP4oHk7gQ8rM2uOMhOX73F9GgadJ4NqLHKjgj9gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6efCbWufctzFqrHGQ6VReZDpL5jSfXI2suai98RXDOo/JRoHz35BWs7CAmzg8voMT0emjYp0KjfH8SUEKdrZad+muyQn5rin9837uIwirOrs069ONdlyw9C+xe1N/9brq3px1TGrjmlLry5Usjtx5/+KIhHSF2wv2ZMjoSpESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OL0rFZnc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739432071; x=1740036871; i=quwenruo.btrfs@gmx.com;
	bh=YhCVyHECUfaaUp/A3AkimfPyq1veTsjFblSbMnqRbaY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OL0rFZncWyQxn+aiIg3d0wYRSdae9Hb2liPUYjYU1AynjmTqE9iD2Ffpw5Wln3L4
	 FRc4HxQ9BnrhHUiL5aSPipCRalTP2myXIVC3bXDNfuLZB3zBOnBDdth4eO5F9NIOn
	 CECQP1Qp9jQCqItURLTfZYeY2TCxx5p5VRdXCtefU/PbGnCIs5bX+ZdQJkpVBtRHh
	 LG25PnFi1hM2NKPdBIlHL4rAtlfcqK+RD7bmooo9zbNOZTiz6LDLr9zBE9IQxUXBq
	 1SLXLf5neuZEdaofCWNgYsj5GREIq8w5/k9pPKUEykv13NW/Jc5Vh68ltVwrsJK6/
	 fPtE6PyrCRC8EDt20g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQvCv-1u3kJt3F4x-00ID8b; Thu, 13
 Feb 2025 08:34:31 +0100
Message-ID: <ed9e1081-527f-406e-9e8c-095ce31f8a3c@gmx.com>
Date: Thu, 13 Feb 2025 18:04:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] btrfs: remove btrfs_fs_info::sectors_per_page
To: Dan Carpenter <dan.carpenter@linaro.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <555b6669-5b30-4f76-9073-23f44c563aa3@stanley.mountain>
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
In-Reply-To: <555b6669-5b30-4f76-9073-23f44c563aa3@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lnBrMOflHIXRIXRjWCXRx2U+OCHX3vGKoAuw9HlxSwiGNzbdUGf
 TRJN2IVbyEP/X08u+4KiJMS9lPq88dR/5Flun2C421XcnrVUCrneP5J3fwjB5UQPhl5qSyK
 M96fpzvXt0xBJz3fhrHZhJZu2iCmNC7DJOOf6eiKay3YPYq1+ZlLhmM0DN2fh8S2g1Yuecr
 QTnQjtj4Cj8OKH24yP9mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jN8yR094ugo=;pFCwSbWFBkC/Xm1vIPrXwMDgcPc
 APFokV8Iuu3R6ZzqiYHckRf6+Xm2BfIsc+VbNqjucmflmgBmB3x0Dc4QqzJUlF/ZgKAR/Fnwq
 hBfU8Q29kgLstbqXyVj6yWJtBpQ4KjFk45TTGNJcS4FktNHw5ztS5KfPLUD3N4+skfR7G2rxa
 U1/pQMWRX/AWHO+y5KnHP7H/I/rD57KiqeaR4zCLetuVBb/e8JgHlqZmWXueLqaQkh117aU0Q
 uWDmMrKcAI5opsEnu1Ys/Fqhy4Z1hLKQYbAnuqkJhEFUqKkUIQO+LRk7ynHkc2ASVXrT1F0bz
 dfVsSJsS0qoPdNlrcSn0cPtJzIRLbwCk5UG0pUufJt1onFduYu/4kW8R+R3id08/KVLgRELIy
 070MrCrmXsOIAMyrvDH8bQdEkQceS+NbG0/vIoujExrxgx4jLcpv0sYGbexh0B+UKCi9qTE8R
 Y57Iog5Lo3aD8k3tS7vxCdseWYdFsJCX8num32JDhpOltHVnYfD3S8L7JHRPx8ySTfHbWye5d
 w4gBFEC9oU8PS4VE6ZRdWzGVyIoRKeHNMkfds5rmxYM4pMrGHFL1mlkCCOKzfqbxEK+pe6wKB
 NhGqnYaXa/thEDVJnaBMNlZ01s+aoBzrjIjN59GFdZeZZPj5HmYZVJhG5P+h8wRvVT1EKLQzs
 sld16f5TQyxXadjoYdCAESlDWgJ/aGaPOZAiYlkmS881PMoFEbv6Iaoh+E7BYXn3ULqgI6Uc1
 ryfWjMbyM9Uffk5j/OXQ6QHD6qnHfo947freMMT92tClIxCk+4TVUuegpOLKzhpEnjTVGmB3L
 3eUEbMBfLBAfxSyuRybZZa86C58h3P9lXri44SyFHjpkry4RM2+ANXouRYzFpDfJRntjQ1T3J
 jZ9RcKh7Flwe7cVdxTj1SIm1ooamR26RShNtf1MOsOkGZJEJzFlR27MEaHIDWMqE0e9BuKf47
 DozYXf0MMg2nyxL+QfLqm0ha3HSclYU/LEhaWWYQumgqPPZ+Rxbm+lB7CTHCN58BBbzp0vZ94
 dvbfJrhAZLO1j1IGcr5wRt28NzuT/hpgwQjHnRfK3wQCLaAD4yTWODU9FiBeXWX3778p3s4N5
 z4pCITMp+8FdpkkN/Q/Ouc8L5WNmyvqtkBVDfwmpcj/M2hUuf2OcSi5ujdf+Wbu2s+e6bl2hL
 zv+B3TjqUpquKmKhHytUfEOetcMnXUytNFtz/ybK+pTdpGa59H+1w/PieDSarTivdH6XkBwg+
 qe/sHsyk3DkyQJCxuTU/wtp1GNfe1HoiEjosn0XTaPdgSdabC9sdE7R7byCuj6Bulorl/fhCV
 01tkwRAm+biZbKxE7t6FteBxZ2wWLXUq30Uk1K1xe2YILzR7Mj87tLx19OwU7Lili1fd+GL9q
 E7TFe5wXBfNdwiXGk3YQvK/QQyzvwYNX0Xk2o=



=E5=9C=A8 2025/2/13 18:01, Dan Carpenter =E5=86=99=E9=81=93:
> Hello Qu Wenruo,
>
> This is a semi-automatic email about new static checker warnings.
>
> Commit 8685d7a75e5f ("btrfs: remove btrfs_fs_info::sectors_per_page")
> from Jan 24, 2025, leads to the following Smatch complaint:
>
>      fs/btrfs/subpage.c:743 btrfs_folio_set_lock()
>      warn: variable dereferenced before check 'fs_info' (see line 739)
>
> fs/btrfs/subpage.c
>     738		unsigned int nbits;
>     739		const unsigned int blocks_per_folio =3D btrfs_blocks_per_folio(=
fs_info, folio);
>                                                                         =
      ^^^^^^^
> The patch adds a dereference
>
>     740		int ret;
>     741
>     742		ASSERT(folio_test_locked(folio));
>     743		if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->map=
ping))
>                               ^^^^^^^^
> Checked too late.
>
>     744			return;
>     745
>

Right! Thanks for catching this, will fix it in our for-next.

Thanks,
Qu
> regards,
> dan carpenter
>


