Return-Path: <linux-btrfs+bounces-19620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A69EACB2934
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 10:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DF593102CD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 09:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D5E26CE04;
	Wed, 10 Dec 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uP74H12X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CD239E8B
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359158; cv=none; b=ZKFhLqTt4Mdf0lnBs4atOXz+MmnTzJoLMWM1V+aaIagGbOFCF78JJCu41F2MEVHECexZwyfVKHVbtYrWJ3O2nBW8ROyWh4U7ABXfYC+Hld9yHv0w8QqZdOk/WoHQ2GKK4+ZiklE4yMS8xrcmdrCitPKhVlyi8GwIiuJwwf7CNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359158; c=relaxed/simple;
	bh=W11ED969Y3sHthiaKx+qGTJlPtrC3AV30XS+JXnn9+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mspOEHkiNfSlB/4MbgsKG3xArFn98tg1ivAC44r7E05fslb9/H0k/dLcuY5LEa0hR16Cn+7BqSHsUwPGGwqr0mB4AUlLSD8F5P2LLNoZTf7PrU8IAiNkZD8NAZJ/heL9q6SJlePDSF1AMUhnueV6FmC/hcWPbNTxXHd4mBeFRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uP74H12X; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765359148; x=1765963948; i=quwenruo.btrfs@gmx.com;
	bh=0XPCZ/GqLFNgG4Bf2s2yH1u0U/2va7g+K05yxZ7VbSU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uP74H12Xm9t/YXbMgoG9lSwTSWGYignn83E7NdZ5FO9zK918843zKrlV33zk8vuD
	 sdRLRyB/70y31qi4t4x6p6qTApcC0AXcysuCP+7QZvb8YwvA6qxaYDUsyfUGlNYVF
	 Wo+u8Rmrh+5XGxcyrqsSsJHaNF1oZFyfCk4NDtVVV7gG+HQOZqm81L2EdequGLb3X
	 zYlxG4CtmNOoMuoJS+1gx7OgbHeWqXKn6ZRb0R3ea/U0AJPjEX7jE3JuaIE8CagFv
	 E2ynGvdRLMcfjMtAIoRSnbryhOQeptKXexk5A09HRHmaoGDysipelNAERhBhQePiF
	 KjT/hS9ILO1s97XTNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWih0-1vVTUa0suG-00N8tb; Wed, 10
 Dec 2025 10:32:28 +0100
Message-ID: <b77d5f0e-ac09-4f64-940c-623ef3c7811b@gmx.com>
Date: Wed, 10 Dec 2025 20:02:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: search for larger extent maps inside
 btrfs_do_readpage()
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <2d0cc7c454a8cb80219ab4c218fa73843ff5f809.1764131228.git.wqu@suse.com>
 <CAL3q7H7q783cixa=8njX4Zc_sPQ6D-exmK1fph7X_unj_XyQGg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7q783cixa=8njX4Zc_sPQ6D-exmK1fph7X_unj_XyQGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:38r9pdbneY5CUMQBmEFvUkv+2qz/U+d0LFxTc7iToJt/FP8oBcV
 0rEqLBi6l8WNrzmACEMPLzzfcjEmL9p6yxlapKflmFrp1N5Wkdqn2W25CLE1SkDvmDm+j8B
 AI6Pqhlv3IpDKD4d+zCtvJG+G9R5AAZow08kBvdYjKy+elSJifB472eDdkG9rvkS8Wa0dXU
 8NWYu1ypqs2mj3o5alDIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qQ7dVnhnMkI=;zZ+h4cy5PKTRlKpb01o7OFJSXCu
 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



=E5=9C=A8 2025/12/10 19:26, Filipe Manana =E5=86=99=E9=81=93:
> On Wed, Nov 26, 2025 at 4:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [CORNER CASE]
>> If we have the following file extents layout, btrfs_get_extent() can
>> return a smaller hole during read, and cause unnecessary extra tree
>> searches:
>>
>>          item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
>>                  generation 9 type 1 (regular)
>>                  extent data disk byte 13631488 nr 4096
>>                  extent data offset 0 nr 4096 ram 4096
>>                  extent compression 0 (none)
>>
>>          item 7 key (257 EXTENT_DATA 32768) itemoff 15757 itemsize 53
>>                  generation 9 type 1 (regular)
>>                  extent data disk byte 13635584 nr 4096
>>                  extent data offset 0 nr 4096 ram 4096
>>                  extent compression 0 (none)
>>
>> In above case, range [0, 4K) and [32K, 36K) are regular extents, and
>> there is a hole in range [4K, 32K), and the fs has "no-holes" feature,
>> meaning the hole will not have a file extent item.
>>
>> [INEFFICIENCY]
>> Assume the system has 4K page size, and we're doing readahead for range
>> [4K, 32K), no large folio yet.
>>
>>   btrfs_readahead() for range [4K, 32K)
>>   |- btrfs_do_readpage() for folio 4K
>>   |  |- get_extent_map() for range [4K, 8K)
>>   |     |- btrfs_get_extent() for range [4K, 8K)
>>   |        We hit item 6, then for the next item 7.
>>   |        At this stage we know range [4K, 32K) is a hole.
>>   |        But our search range is only [4K, 8K), not reaching 32K, thu=
s
>>   |        we go into not_found: tag, returning a hole em for [4K, 8K).
>>   |
>>   |- btrfs_do_readpage() for folio 8K
>>   |  |- get_extent_map() for range [8K, 12K)
>>   |     |- btrfs_get_extent() for range [8K, 12K)
>>   |        We hit the same item 6, and then item 7.
>>   |        But still we goto not_found tag, inserting a new hole em,
>>   |        which will be merged with previous one.
>>   |
>>   | [ Repeat the same btrfs_get_extent() calls until the end ]
>>
>> So we're calling btrfs_get_extent() again and again, just for a
>> different part of the same hole range [4K, 32K).
>>
>> [ENHANCEMENT]
>> Make btrfs_do_readpage() to search for a larger extent map if readahead
>> is involved.
>>
>> For btrfs_readahead() we have bio_ctrl::ractl set, and lock extents for
>> the whole readahead range.
>>
>> If we find bio_ctrl::ractl is set, we can use that end range as extent
>> map search end, this allows btrfs_get_extent() to return a much larger
>> hole, thus reduce the need to call btrfs_get_extent() again and again.
>>
>>   btrfs_readahead() for range [4K, 32K)
>>   |- btrfs_do_readpage() for folio 4K
>>   |  |- get_extent_map() for range [4K, 32K)
>>   |     |- btrfs_get_extent() for range [4K, 32K)
>>   |        We hit item 6, then for the next item 7.
>>   |        At this stage we know range [4K, 32K) is a hole.
>>   |        So the hole em for range [4K, 32K) is returned.
>>   |
>>   |- btrfs_do_readpage() for folio 8K
>>   |  |- get_extent_map() for range [8K, 32K)
>>   |     The cached hole em range [4K, 32K) covers the range,
>>   |     and reuse that em.
>>   |
>>   | [ Repeat the same btrfs_get_extent() calls until the end ]
>>
>> Now we only call btrfs_get_extent() once for the whole range [4K, 32K),
>> other than the old 8 times.
>>
>> Although again I do not expect much difference for the real world
>> performance.
>=20
> Why don't you measure it?

Because it's a very tiny difference.

I tried this on aarch64 with 64K page size and 4K fs block size, which=20
should have the best result, reading a 1GiB hole with buffered read.

The average (32 runs) buffered read times are:

- Before: 0.20823 s
- After:  0.20635 s

Resulting an improve of 0.9% improvement.

Not to mention buffered read itself can be noisy, as memory=20
pressure/reclaim can easily affect the result more.

I can put that part into the changelog if you wish.

Thanks,
Qu

>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 2d32dfc34ae3..c8c8d3659135 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -997,6 +997,8 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>>          struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>>          u64 start =3D folio_pos(folio);
>>          const u64 end =3D start + folio_size(folio) - 1;
>> +       const u64 locked_end =3D bio_ctrl->ractl ? (readahead_pos(bio_c=
trl->ractl) +
>> +                              readahead_length(bio_ctrl->ractl) - 1) :=
 end;
>=20
> This is a rather long expression, it's more readable with an if-else sta=
tement.
>=20
> Thanks.
>=20
>>          u64 extent_offset;
>>          u64 last_byte =3D i_size_read(inode);
>>          struct extent_map *em;
>> @@ -1036,7 +1038,14 @@ static int btrfs_do_readpage(struct folio *folio=
, struct extent_map **em_cached,
>>                          end_folio_read(folio, true, cur, blocksize);
>>                          continue;
>>                  }
>> -               em =3D get_extent_map(BTRFS_I(inode), folio, cur, end -=
 cur + 1, em_cached);
>> +               /*
>> +                * Search extent map for the whole locked range.
>> +                * This will allow btrfs_get_extent() to return a large=
r hole
>> +                * when possible.
>> +                * This can reduce duplicated btrfs_get_extent() calls =
for large
>> +                * holes.
>> +                */
>> +               em =3D get_extent_map(BTRFS_I(inode), folio, cur, locke=
d_end - cur + 1, em_cached);
>>                  if (IS_ERR(em)) {
>>                          end_folio_read(folio, false, cur, end + 1 - cu=
r);
>>                          return PTR_ERR(em);
>> --
>> 2.52.0
>>
>>
>=20


