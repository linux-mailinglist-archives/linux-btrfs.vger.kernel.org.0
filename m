Return-Path: <linux-btrfs+bounces-3368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A33387F0FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 21:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD226280D28
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D69457881;
	Mon, 18 Mar 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cPr89OpB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6939D57874
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792758; cv=none; b=ATIWVBJlllXkNYLZp21kJCjPnsAOoLVBtcPQIUgN7vbbSvI+8wRDDVUV8Lv6XLkwLxnByI1Om4iykKZDnBk2DTu7DcAK6K08G2kSMCV1uMWStOQWAhT89PfQgCqrg+gckTgqU38AUP1j5vZdszRXbaxLKFJ4GS4ejmeDrSsOsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792758; c=relaxed/simple;
	bh=7/NcXw2Mq2wWEov4/Hpruajgb4M9SXNYcpa1b17NCCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=liVtj81OPohI4sINc3YcOYW/00itb20ux7oR/ZRCvY5ub4ULhz+yJ42PuUOe5iIp6aVEo/Vy/q9QJBPNFq68qq3QNXKZk0KwRTQj+PIZokSBIePSz9290ctpeakDT/tDZt0/bHDujVjcupTRLHkDiHbpM6wgB3IkRxINI6IjFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cPr89OpB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710792750; x=1711397550; i=quwenruo.btrfs@gmx.com;
	bh=gXOMMArR5Oh8aE7tR/TUXsU6PzlBq1uMyXOfosqVE+8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=cPr89OpBT0bc3+sRgTxID6TzGoZSqIentoV/vWQBwLhgSZEP2sRaYn+mOLWkf/j0
	 781I2abTvgkA0x6SFTPVvym7UvYsozyr9PQfmo5/F1nR72bmvQL0YTRDw047JRWE2
	 vrh9qNlxTUV5FGsM5rJijNrllx0/dlKKWBO6aB3EkbSDvmbjUNnlrPQY6JRecaeaJ
	 xppMDdJlClJCWjy6UYKBDqFSxYvq4JYUW0DgXiEgicoE0lq6wirWPf1xPfoDjeAi3
	 ASCPRW/kZ7vR1VrsW6bs2kslqYZ3YvDdRewt+pWm/HYntaTQxm2kbQ200HLN2U6T+
	 UTpOhE3A+4LQZsa2xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6bfw-1qhh9n2p5C-0180am; Mon, 18
 Mar 2024 21:12:30 +0100
Message-ID: <5a8d9a84-8eaa-4c6f-aba5-209a94c7b02b@gmx.com>
Date: Tue, 19 Mar 2024 06:42:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: remove a couple pointless callback wrappers
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1710763611.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1710763611.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UBNdV97jkaHQWFhWOOmhYN47Ykl2ZleHNybBaJMdUTbKC+ysQyn
 8PgAGbdzgGFvd0obHuhA8Z0Qr8wqQP6XT9efD4QxnCcVP8hsTbD5L8g6Gaa1QhObwm+zSEC
 0Y4t4iJg++ejqP8ptlSZqLm3K3/oabaZb+W2R+Qc36RKVhFFb1JTytbZdBPYj7hQI+0aSvV
 CUOLlQ8wy4PKV3AeKrQUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DjCtDN/yV/0=;cLW/tTCBRxPk47xf1PqFJUSJSb1
 jv4I+rW8BZtGaikLBQ+Ge48OkChZcjC66768piQom+KOk1QHlhD7QeksgAI//CYoGNplGRqVu
 m98MLul9BfYyvhNEWaOgX29AvWHpa2tQ8hsOAvKoRfSTqwLDt7FSnER4oBtYHYNE0eM3W0EQ3
 CCkv8ocQquv4RaaNLC7eitYCK6i9AfV9w9gmE9MMHg6SeGFEkhC/Iu2AZhdDYIe+DSI+CrW8n
 MKNR6dfHOMb8Ksi2o/xU8f+9nAKRb+pqHQ5CcQTT+pmysB0n7btrZ8VS4WoJ7BAi8VIj8Dso0
 Qxe4d5Grc9QajrkWBP7kwk/Sb8Tt7OafJmNlTgNVbs2CrEWm3rJTcmWrsFPtCsxrKJCIPQUQG
 3euRp6zSvxYHMnLTU4ExmdxvPl+aJe/fa3usnHdmcDPcYpz+7HhgsWDg/gEwqjajcoXBfrpYn
 wo9u6IcqlQLR64neCjUoVDiejdsQ+BE32tdD6mN664QBRicwhb5NzG1WA3ATqDGqE6+Bl/04a
 f8btLNKqlcGuTjg/bd2bcOqz4ERT0q+yPe4+dtPxVKFRXM+l5OXNkce6AcutGKQbb/BSBVW42
 MQVTsKo67pNhRziIvXFCM1dX6Y1baQQlhttn2t7iZrTf5LAxroIvpC5WX11uk/kPm8rSANvzy
 ygG6BncaFRLLfJfpmniRex+GcroAzkzTdOrAxxZNj/f1Vxy7rba9Cr7Nz5sqBPPTK0tAaUOKo
 VmR3sERjq3NlyW/GUNDb8GBT9C/jc50yFvEdZnAAQVRO0bLw17DF5NzShUZrkYT8LdxPmGW1g
 g5+6bw6Ld0cmNVhdoFt0eWmlJQZoRo4uPfZrwHi0/EBuE=



=E5=9C=A8 2024/3/18 22:44, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Trivial stuff, details in the change logs.

I guess it's just exposed by some random code reading?

No automatic tools to expose such single line wrapper?

>
> Filipe Manana (2):
>    btrfs: remove pointless readahead callback wrapper
>    btrfs: remove pointless writepages callback wrapper

Anyway looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
>   fs/btrfs/extent_io.c |  5 ++---
>   fs/btrfs/extent_io.h |  5 ++---
>   fs/btrfs/inode.c     | 11 -----------
>   3 files changed, 4 insertions(+), 17 deletions(-)
>

