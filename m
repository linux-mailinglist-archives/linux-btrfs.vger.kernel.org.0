Return-Path: <linux-btrfs+bounces-15449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D4B01553
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA08517A060
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3151F8690;
	Fri, 11 Jul 2025 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k9OX9r/i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE71A0BE0
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220954; cv=none; b=DcBIUB0Gu7VjpWSg0VR3fZgeC0UtuY3VMO2AvH/BFQv+Me3RvskYY6nkQZBxSIFyqrXetMKMbj4xhYk+KUJ4Owzz7wBew0b3c1DW/HLMDj9tVxWazyqDHaOXEVxqV+d7uUA6tWeSzJTQljmD4OZmS9ItSM8gt2XwbD6ZDAJo4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220954; c=relaxed/simple;
	bh=61vKUam5AOvEL7U+/XPxT8nPcBej8QMVbmmsdvFyI0k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PEiiobDA3U6Zgi3U0NVH36CXsee1VR8s3G6Az+/ncBi/oK5arQF7GTc8DycKlxRr9yznIvAAjjmvLMyG7ET5/uBB7fMohP8YKVKe6zJOGI64H0/jxrorRtU3ozRrsIf/dxeK1w7U/i2vi1zrvNIibrndpaZ194mg/OIX/t4N2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k9OX9r/i; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752220950; x=1752825750; i=quwenruo.btrfs@gmx.com;
	bh=61vKUam5AOvEL7U+/XPxT8nPcBej8QMVbmmsdvFyI0k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k9OX9r/irW+fxY8FTtebSLG1RpCYGzivzFg23DNWhU8rLyOJHYWAYBHc8Rf6wn9r
	 KucVObNKHAuSe0bG9kze0S9CYQY4MmtbTltVHlaecCY60xfFMo/4p8wSVzoOFCQqX
	 rOUCtbKzmapFvNOt8UEgLiEqXql3Jb/ramZxhEsB1g6WXUCmAlhPbvpLceBSqwihN
	 jhL+p2/pKDhxoF3Gjb0dpHgLxhLXG7m40KixdodaIWVLnjkjd8IJkgh9yBG4KjdzI
	 oadZ2+ggQLboprbphttipSmp1DqxbMu+5i0iWK25Fq3cYzwfMKtuPOuE6o19Qii5W
	 N99XKwjHq1/cnN9e2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGRp-1uHfS51YWT-00WlnZ; Fri, 11
 Jul 2025 10:02:28 +0200
Message-ID: <5a5e64ef-97cb-4540-915b-db6bece862b0@gmx.com>
Date: Fri, 11 Jul 2025 17:32:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: set EXTENT_NORESERVE before range unlock in
 btrfs_truncate_block()
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b780ff5c6ffae11065555177e508a1c78cdf9ad9.1752049280.git.fdmanana@suse.com>
 <1f074a1d-c423-4edf-a7ee-4642d3565759@gmx.com>
Content-Language: en-US
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
In-Reply-To: <1f074a1d-c423-4edf-a7ee-4642d3565759@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4UUWpGVNQYsSPLMR1t+NnZslRGN9NzsTW5My5c5NXfVWxbw3Rvq
 y2h/BI6c0kIHgs9qZq7PvK7K673BbtnGJtKkgYJ1KS6oQ2eE3aZk/tQNMP/ZC2NcU0PfkLC
 lio18qnbD3EZmIvtriOWdyTVGbIgSHei9e7kmnDuyaQxKysrriYTkDHclhV+fkNmK6xw1K4
 +bzG/wMSZr8xhcT0aQ1cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dd851U7zZFU=;Ku79IIKmDH1U0qBQbzvEBsuRxui
 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



=E5=9C=A8 2025/7/11 17:16, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/7/9 17:56, fdmanana@kernel.org =E5=86=99=E9=81=93:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> Set the EXTENT_NORESERVE bit in the io tree before unlocking the range =
so
>> that we can use the cached state and speedup the operation, since the
>> unlock operation releases the cached state.
>>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>=20
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>=20
>=20
>> ---
>> =C2=A0 fs/btrfs/inode.c | 5 +++--
>> =C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index d7a2ea7d121f..d060a64f8808 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -4999,11 +4999,12 @@ int btrfs_truncate_block(struct btrfs_inode=20
>> *inode, u64 offset, u64 start, u64 e
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_end + 1 - block_start)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_folio_set_dirty(fs_info, folio, bl=
ock_start,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_end + 1 - block_start)=
;
>> -=C2=A0=C2=A0=C2=A0 btrfs_unlock_extent(io_tree, block_start, block_end=
, &cached_state);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (only_release_metadata)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_extent=
_bit(&inode->io_tree, block_start, block_end,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXTENT_NORESERVE, NULL=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXTENT_NORESERVE, &cac=
hed_state);
>> +
>> +=C2=A0=C2=A0=C2=A0 btrfs_unlock_extent(io_tree, block_start, block_end=
, &cached_state);
>=20
> Feel free to use the same cached_state for fallback_to_cow(), which is=
=20
> calling btrfs_clear_extent_bits(), which doesn't benefit from the cached=
=20
> state.
>=20
> That's the only other location where I can find an extent bit operation=
=20
> after extent unlock.

Sorry, I mean extent io tree usage without using the cached state.

There is one other location like btrfs_inode_set_file_extent_range()=20
which is just btrfs_set_extent_bit() wrapper, but without the usage of=20
cached_state.

>=20
> Thanks,
> Qu
>=20
>> =C2=A0 out_unlock:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>=20
>=20


