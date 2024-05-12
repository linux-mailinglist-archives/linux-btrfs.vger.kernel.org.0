Return-Path: <linux-btrfs+bounces-4926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BDD8C38F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 00:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52237281850
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 22:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F165645D;
	Sun, 12 May 2024 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hz7WMsuY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D656443
	for <linux-btrfs@vger.kernel.org>; Sun, 12 May 2024 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715551812; cv=none; b=ILIqM1Nqa20cbwkaUuMQpAHoexIQneG88G8AaUGbsNYXM2KhD73v2noiNZ9aiNFhpfNdKCxAiq7js9HVLhUdfpjhKJVE+W8REnD7hnQcRqzDas/wIHmJJXqa26oJh8z2g6EsShRo9c7dqCmceN31/OJ7finKynCbSBYV88VEY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715551812; c=relaxed/simple;
	bh=ifbJ3eel09f3ZJ0gYLOH0mhzUhCKfPGXWGJCTyLJaxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTzG/UfJ0dPn8s8gcTxflkhVHpvWzsz69np9Uw/o5nyISBv3Fq8+BVHNFIzJSbdT6C88BIP8+s/I5BwXbRmoXBXZkzZpydYhABejf6tYThkbajjpHiHAkaeW+dQxQPXQMHQSrkuLIC3XdEGGOeOCmnaJwW9HBRpQndEbRGO4Q+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hz7WMsuY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715551805; x=1716156605; i=quwenruo.btrfs@gmx.com;
	bh=ifbJ3eel09f3ZJ0gYLOH0mhzUhCKfPGXWGJCTyLJaxk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hz7WMsuY7GMtYmVO0WKaEDjy6euLFwU8Zxdx8bDZyGl8U4tRPT2IhdmzqFIK5hAD
	 f8dSHuB6dHASDFV8QFtqVh+bQiT78IBEya+58+UG9mhIzk3lorUpplAYdxVRhBuh/
	 oA5lPIF+qd684AwiHBxL6cs+0m3b0EbF/N0VKbu3njQy8/vT+zVYcqVFmTsmQy0A7
	 0xZV05bIsjM986mbJZTjUJp25h0D8jXjls1gYfzzYUhfM7H8Tlu0+3UU60cqqfnXr
	 fJ7in/p/82KJaqDEsgg37z7Zl58gv8+0tJFH2AvKH/GN2gKXvuWxgiG7SszrT2Srb
	 HVP52PA1JuEnlxhDvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXFx-1sJ9Y52TBZ-00GVBY; Mon, 13
 May 2024 00:10:05 +0200
Message-ID: <56cf6f8b-f035-4324-8f6a-05221cdcca4d@gmx.com>
Date: Mon, 13 May 2024 07:39:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Qu Wenruo
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <cover.1715386434.git.wqu@suse.com>
 <91da2c388f3152f40af0e3e8c7ca7c7f8f6687db.1715386434.git.wqu@suse.com>
 <84a9472d-87b0-41dc-a8dc-b9c644e81b53@wdc.com>
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
In-Reply-To: <84a9472d-87b0-41dc-a8dc-b9c644e81b53@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2h9HpLsf0hvT1J52c4ycu/GMCaTMw9PuuNGj1CG3F3jeqj72Gwo
 tmPCY8GRve6LfmM7H8+Vm4FLNjB/rzlvv6kmMy2YLip8yIVchz9ak2AkvxmqqStiRk3+76/
 5EtBMGvIw+LN5skXq+UzFGETsHtk7xZY9NiM4ikaPknUUcna7CWjIBRQGV0yYq0xKz6XfVx
 T5S9Xweb92oTs0XzfVEkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7L9t6C2dks4=;bbqRfDpymgpMW699z+G2GVJKbp3
 PZMFdRuiXIh8Y/o3+7Hvl5PCMhwPSwR7GoH063tcuM2sl92KIijFy1iwjpGvHQDhGurFZmSCc
 lBsKoNIenIIMRUudFQag80MSaQYI08UxYHNlob5DU0Afq2euPC2TfrVkU4Uu0vwGuUN7xDvxw
 Ri1glsKJFSbZE4harSqCBsBoCEKatwI4cUp5Mdi4d0eNLqWUrDgl2hqLRUi00VoqgTlNc24Bh
 sHokPwAD0d63okLudruEWJBmKcN+ib5DOWQ+uO/7JlnH2iEI4eGl7y3jSp2RqIw7E/cXWeBXg
 Kt7l8I6WTadL2g8eieNAzpuixb+ZMcRNKxZ8+L5qcrE8CWfOf/aymOEwFW2tXH1qAcmu5s67p
 I/3wU0mQJzGdft4HzUzEZ7tVY7nI9rryCQLOHoCXlV15ElkwUfE+rh0FKWDMfRoXmBnLk3wRm
 KrHnVN1odmzSxc+NNEQt+ykDEbsr6vIqFsKAKyDZ2gSwkr9NDnzJ6MfMxqIfT+okgzHYkeFmF
 eIOCCqSSYiwzw20xYnI9bETOwdVN8YovZuSZL1GNj8R4qgfx+v6RavVyCl0FZz9nUrBvYjg1/
 mFyILWyz5c3632Z99roxY8xdIsRYspyCNKI5lm/2Rhm0MntTVJfDPQmXuF9cuugNJnbnBdTcd
 6ftp5ebCTPMobq7XWycgs+exxY6sKV/05FkHi8UCaCqfKbrTrYGYiy/G3ee0JTG3EHv8yzf9b
 GnokbhWnZcQ+jChZaI1HU2TjFgPWXXp1mbiQ5z5sex3YaeOuryhC8hp35cYjPIytyN2iCaH1U
 UTtGqSlpyZJdf87yrYaZNT3Xx7Eq8SRgwIxZF1WHW77bI=



=E5=9C=A8 2024/5/13 02:38, Johannes Thumshirn =E5=86=99=E9=81=93:
> Why do we even need this patch in the first place, when we're basically
> reverting it again in Patch 4/6?

Indeed, I'll merge this patch into 4/6.

Thanks,
Qu

