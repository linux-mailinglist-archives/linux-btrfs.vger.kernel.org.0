Return-Path: <linux-btrfs+bounces-5454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAAE8FBF50
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 00:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB481C22408
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 22:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9514C5BA;
	Tue,  4 Jun 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GsIU95R/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B138199A2
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541428; cv=none; b=VzuB6TKqAF8V2CrMWjn59wF+QQsydI4fxR3cv9/FbNQaQF0Mrow5dfi1+c1BtPoKpD44InpyS1HbswKzMlC8qehS/fuio359Ky0935qPPmMz9q9W5iuxu/2W+tPQFuAI/lxM6SGRf7DqJ4zjROWw0cUaoCrj5Jd+fMi2sOXPRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541428; c=relaxed/simple;
	bh=vI30hkzhXEAcuHImWd6E+DQZ4wI3kRBF8QWmdB1rSe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HV6w5ToAJp12U5Ymf6TrqNsEaPYmQQ3xnfEa6ndn5eILr/MAb8mudZPfx+Fg2dnklPg961vOfVhycunt6nwH6BF0Z0lSXc086+1a6Up+VItgBqMI37fZ9zf3f+dEMGi4XxbYYpt/zx+70V6PXiaNlRG4OfRE87CvwOH1e7rZj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GsIU95R/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717541420; x=1718146220; i=quwenruo.btrfs@gmx.com;
	bh=yuTXf08S8VH8fitJrh1X/KCvqccs6MkoPuyCnH5tKMI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GsIU95R/oKHyWbtp8t8m8w2moN8ItSYFXyRvoUWWLNFSXhCv5/0pWPr/lEroyOOe
	 GBqneFkeu/zt7CLCqSnmfO4eESfDJJ5mLfNN2uLL2KvQLfZsxRTR6oMzZKqOxiKji
	 3Fa1X7Qqjp3leoBe3fVonEY9hC4ZEG5SimQcrkH18m83uPGW5txeNi3S420lTTTo/
	 vt/tCkaXeap1IW3FCK2CaQQYVvcQ7TRsnCzSyFtfnlEOyfYl3l3Mv5SsQWyb9hey3
	 A6pUcpXDYFGO1Jd3i/nGJ3503G6jkJlp9XXxFATK3NAiUyMIGsuqYz8D1n5ngWvS8
	 tCDhDJnNqn5sTlbK7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCtj-1sllbo0vRP-00c8kA; Wed, 05
 Jun 2024 00:50:19 +0200
Message-ID: <05a63b5d-3f00-477f-a41b-eb9555a0398c@gmx.com>
Date: Wed, 5 Jun 2024 08:20:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] btrfs: some tweaks and cleanups around ordered
 extents
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1717495660.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1717495660.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ESj3nTjypJxc6wYzahQMgTDquBTZ45aP9ivBkKIchQ9UNg1HGhz
 sIleYN6kucuFopgIiE/HKFNEm16cmNASXPnxQt0YXAzEmbciDRrJosRVcQEhZwoIt3Ji6MR
 MggL3lK0bJRWWgNGKlmUF+B+uCSLKTzfNqJPUWbIc9kt4CR0fVd+uv5i6wWFYme3c1O+7GZ
 nYyT2h1HldUrLdQ/a5lIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BalT8Q+TGAk=;NNGFCUyAcs+p5IP7026F6zgobuA
 HZcMeVoWi9/47LwVfyNiHaF9C7ZLRWW9m7+VW1MhoTjRVw7dc/OB090r8pzxn9LaZQq/fKjC2
 SneISO1lUsnHwN+j7VTpOGXw4ZWNSy311TQpQIpcwypoaRE52rZS6pyjqRNDac0jcEQxswGmO
 r8gYEZISK1jFG7uiT2PMfRkjYpNRLBiXa20gLiiT4zvOS/8BrDGLtK/FqT88iljcpHvQ+OJBO
 LswSN9gkCe1p152KJshL1z76uggd67Kc4WU2CtIBoxXov022yE7faQa13zGT2IA+M0aMKkE5K
 Vh61H1OvHcQWHMlvAGV6H59ycHotSUVJm5wmCAhT65hYmaQ3Eurph6Frh+Lrzfk9U7JE009M3
 VX6k38woAKgIUz+Cx39sKs09DdbyW7N0wMxdrcGJyStOqhZalK9kXDk1z5jrKqhXpDh53CMty
 iA4vCWBZBVgRpNDkTh0rhZOzaIrWYuBU/elgRSb7LFgi4wfyqiQ3Yn+wMAbLBKqW1cGizWmdN
 2rpxT7SNeUrgsj6xUt1hD/u5Oq42n4W2wInwqOpTg3L0tt4QTFEJBV9qIJJNGySgIyXq33vaP
 0FSzqejDZxzvNsEVLQ4vw6ljuIG3hBhuQsuiNPO6noflV2MWJDTSoUF5eRjyUkfH5OcpsYDEP
 B8TbH0H54EePC+4R2aqUjYa+8Huymr6Iv9AldViZPukXPIB7BEkPlt/EnG5BxroKdolaukKlY
 TUGaru4poNJwKtpcEIz5uPXnzozem413EFxWJyMtWsspcCEgOYiN/4DvxZAA8K8gB8cIxuW2z
 K8ze7UEgChH0QbNxVToyQjveYJ0M0r71dtWdHeQrTNKxU=



=E5=9C=A8 2024/6/4 20:38, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Details in the individual change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Filipe Manana (6):
>    btrfs: reduce critical section at btrfs_wait_ordered_roots()
>    btrfs: reduce critical section at btrfs_wait_ordered_extents()
>    btrfs: add comment about locking to btrfs_split_ordered_extent()
>    btrfs: avoid removal and re-insertion of split ordered extent
>    btrfs: mark ordered extent insertion failure checks as unlikely
>    btrfs: update panic message when splitting ordered extent
>
>   fs/btrfs/ordered-data.c | 51 ++++++++++++++++++++++++-----------------
>   1 file changed, 30 insertions(+), 21 deletions(-)
>

