Return-Path: <linux-btrfs+bounces-5216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB28CC8FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 00:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C921F21CD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85A148306;
	Wed, 22 May 2024 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HOkXRuMM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FD811E0
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716416508; cv=none; b=jheOsr/GkMamvIBcS67NZA3+D6/YVYfHom6NfIZsksWDMskuMhDcLq14F7esstx6ZsbJBxd5vUxdn+sfMqBrWrBS12FsM0xW05NUJWQ9KIPtCy0/Xdb/GUK6kvUzB9dVcjfITfFLak8Uv/lSSR69bRHAGcjiCYf2X5jhaVl3iR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716416508; c=relaxed/simple;
	bh=0WiTmQMSbLcjwpyBCZK7T2X3h2jQXh22cS8/XEElrdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=scV6FsiwbN3kXeN4kHKiu2vJpQJErGXwmGA9R1w894UYDlV/dSvzErFcTexRGezMRPMFLt9ROab+4j/nslPHQESw3ymWE14B72onE3ds0wiemzK8hAErPIA8gySZmgwFb7P706/CtrR5mpqeuzIrUF3/alUI04Jy746x/cexXbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HOkXRuMM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716416500; x=1717021300; i=quwenruo.btrfs@gmx.com;
	bh=j9L7qTWdE+IAEiWNZ7RL5iXR+zNOQuS31jNmcdcMVtI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HOkXRuMMWYrLCJQATtzozWpu5Oq9/A1lQYU6cpIKB/GvuYW1bAPdX6r9/J0/DGpe
	 86Q7hINx+8nO4UUltwgW2zZ20FGXcknZA0UihN+T0JKCXJTiO+K2NdHMaVFW5RjNv
	 cCeNre5RK83KCo79KYLSZGLjmVAezhBRf5zJwUTrb3LuMMgLQWYTKZPihyOAgo2iQ
	 K/lw5t+2i/sfjLb/vMCFJgyOILt/G1bCh/4aZKKIJd1gSxNI29BNHfQszhkcOLqq/
	 zUIuKCyc3rKV89LJZlUayVhGNyXiSWH2w3BgTWLmVQYMKKIxCaQY5qemzaj4VeoTj
	 ao1xQODKKByMRNYIzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUosN-1s1HL00SKP-00Qk7E; Thu, 23
 May 2024 00:21:39 +0200
Message-ID: <0452200a-1285-4f34-bd15-3ffb6b49c688@gmx.com>
Date: Thu, 23 May 2024 07:51:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] btrfs: avoid some unnecessary commit of empty
 transactions
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1716386100.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1716386100.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TGgQnn2frKiJLsOOHbmVJDTiONdtG73yD/aYj5QbVNvQHpYsIa1
 JM0QY0X/hLBsvTYtbYDt9EquJnHbhUtXV1B1iytHbvpWQ9KIAi5gYh5AfNwLRDc8Nb36UYr
 QDenw/ZBtozumgDTtuPN4fr43/u/v2jEwSlHvAe3RhnaXxl+wwOddLKCl5NeJBA15gjDATP
 1jAgkjAQzFVey+g2G9Sxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xD1C45Dxsj0=;UbwzW5R+OfnAm2BtfXal6tkfhdZ
 OC6m9YDKETWptG95rzZILCSgfZPkH30BAFRhERVeAlbklSizagXj9ChiK0OLfHRhuI/lYzRuq
 AwCqSxe5/u39pkcc12QIN/9WZMLHNPITbsbGzfssq9R4xVZKSgD8Wz2hiImOMGAi0Habu9C8e
 uhTzW0VJyzF7VTWrhTNdibuVmmiX2zL61sUun+L1WsJsyDqtIL0JE4eO26pwqwWVMhUcyonyz
 kv90Q7P2XIPjcBStJFjZ5yDXotKw92eGigrBsRwg9pe0PoEeaIy9KSb2TWriasO6RIUm8ECcB
 GyHruy02hrC9Dh74YP+etiXDf8BrIIwwJClQCFjxWAE+CxW01aFFogNp1Gh287YktQXz1ypUm
 qOq9GBZoSd1B0dEN13pC0vcjxXmotuWM6z1x5wK/WEF0CCnMBFUUhGTJdIP4+MedmsGKDdVuR
 VVS7Aqh84lcb5uGRt/zTYDcMetyuUEWVdMRLgdn3LdrEr+rT6Tm3xWZWz1IkRLeLvxCoNnF97
 XUPvt9c/earYI7Up7eWAIpxj02L00GT2XcNU4xNr6TgHsLO+yB1KHBpD51Qzlwl6xznVC951T
 SwHZq1SJl6CDX8vUSNMMflApjzzRGL6EIeaePHtDMR1NKaEEacnD74etFlgVCRkMpe75hYv7w
 oji+zekW9Asx2qL9aL7e7ydQefioDgsxhUYaaghn5Wu5Tau9AG3nSrtfpbkGQp17MuctR9CaY
 L2kphKeTsBJPisebP2QhE7IWtgSZCgOdzk4c5KcGnK60ia3ZsXc402UlFhbgk5g8e+9B39zMq
 QGq5gAxYqj+q4WNd6ZgC+WwrPJ/FX88p6UjxvcIG+Bivg=



=E5=9C=A8 2024/5/23 00:06, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> A few places can unnecessarily create an empty transaction and then comm=
it
> it, when the goal is just to catch the current transaction and wait for
> its commit to complete. This results in wasting IO, time and rotation of
> the precious backup roots in the super block. Details in the change logs=
.
> The patches are all independent, except patch 4 that applies on top of
> patch 3 (but could have been done in any order really, they are independ=
ent).

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Have you considered outputting a warning if we're committing an empty
transaction (for debug build)?

That would prevent such problem from happening again.

Thanks,
Qu
>
> Filipe Manana (7):
>    btrfs: qgroup: avoid start/commit empty transaction when flushing res=
ervations
>    btrfs: avoid create and commit empty transaction when committing supe=
r
>    btrfs: send: make ensure_commit_roots_uptodate() simpler and more eff=
icient
>    btrfs: send: avoid create/commit empty transaction at ensure_commit_r=
oots_uptodate()
>    btrfs: scrub: avoid create/commit empty transaction at finish_extent_=
writes_for_zoned()
>    btrfs: add and use helper to commit the current transaction
>    btrfs: send: get rid of the label and gotos at ensure_commit_roots_up=
todate()
>
>   fs/btrfs/disk-io.c     |  8 +-------
>   fs/btrfs/qgroup.c      | 31 +++++--------------------------
>   fs/btrfs/scrub.c       |  6 +-----
>   fs/btrfs/send.c        | 32 ++++++++------------------------
>   fs/btrfs/space-info.c  |  9 +--------
>   fs/btrfs/super.c       | 11 +----------
>   fs/btrfs/transaction.c | 19 +++++++++++++++++++
>   fs/btrfs/transaction.h |  1 +
>   8 files changed, 37 insertions(+), 80 deletions(-)
>

