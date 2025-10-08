Return-Path: <linux-btrfs+bounces-17526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772CBC4BB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 14:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 238064EBB47
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D061F3B8A;
	Wed,  8 Oct 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="I2Udx5M7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C51BD9C9;
	Wed,  8 Oct 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925761; cv=none; b=c3PG52KWcK2WHb3iWB1FD5VuvO3fvBfIHF/lFwwBstP4tjcpirtblR46NU1Hq8CpLfVwYS2qmusoA6hR6xu1m5dxrHbuyw2pqX2jLHB6f0T1mHStgXOcdMgilF5sSpcpSTwiTzmjqM3iNzJ1QYlAPUK6elhdE73iosXbmAowFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925761; c=relaxed/simple;
	bh=93IyCHjB3Ax0uc0tApTUMsWRh68t21wrn+aAJm7g6jQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hSlqFMKcNxncuR4Mkiz8AJ/2Ww6utKVGut9k46BvbNelUaK/QRiwK/N85nW8sSl8djmrME/eh13WBPuj2R16TDhGnZRJ1iI6uFxCpCLsgEN9N5QuYR8KWvrJaJCy/NNKeh+unOYJ88l83N+Je01eZN8puQ8Asqf4LjmpiHl7CzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=I2Udx5M7; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4chX5w64gxzB0G7;
	Wed,  8 Oct 2025 14:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759925748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsKcMA7Np9zfXutebWNor08si/Vz6e3ZvS1//Dcsj0M=;
	b=I2Udx5M7RxxlAvZkXvNx01SznjlinivyB64MRDnVg+pllPJPCpV2EqIigyuHXbwAo2VNma
	fd6E4oc4yQLKDBI1qm9vIblTlKQfyABTLrGq3ORLJyiXH0Pm3KKdN2QDR0Pl5v1LJKCoQX
	r8UXR9rXYNEdvu2cry0rcVHqmERh2OBNvfGSaUsj9O4gqgPox5N0mpG+SIfaouxJXBJN4C
	MMa1KLj9NlKUEMzvTzlvOg27WNhy55p8lfxf9FvVieiiqR7Yp2R1nK/LaT07BvmQQOqo1P
	TBhvnP4upCWfDHEEBvp+ys6sXTAu+rhCsmu5nhrLGTji7eOFuB8/H4gOUXr73w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::102 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
  "clm@fb.com" <clm@fb.com>,  "dsterba@suse.com" <dsterba@suse.com>,
  Naohiro Aota <Naohiro.Aota@wdc.com>,  "boris@bur.io" <boris@bur.io>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: fix memory leaks when rejecting a non SINGLE
 data profile without an RST
In-Reply-To: <2e943abf-2adc-4726-85db-c2ee5dd97017@wdc.com> (Johannes
	Thumshirn's message of "Wed, 8 Oct 2025 12:04:12 +0000")
References: <20251008074031.17830-1-mssola@mssola.com>
	<2e943abf-2adc-4726-85db-c2ee5dd97017@wdc.com>
Date: Wed, 08 Oct 2025 14:15:45 +0200
Message-ID: <878qhld1xq.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4chX5w64gxzB0G7

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Johannes Thumshirn @ 2025-10-08 12:04 GMT:

> On 10/8/25 9:41 AM, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index e3341a84f4ab..8f767a6cd49b 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -1753,7 +1753,11 @@ int btrfs_load_block_group_zone_info(struct btrfs=
_block_group *cache, bool new)
>>   	    !fs_info->stripe_root) {
>>   		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
>>   			  btrfs_bg_type_to_raid_name(map->type));
>> -		return -EINVAL;
>> +		/*
>> +		 * Note that this might be overwritten by later if statements,
>> +		 * but the error will be at least printed by the line above.
>> +		 */
>
>
> Not convinced the comment is useful.
>
>> +		ret =3D -EINVAL;
>>   	}
>>
>>   	if (unlikely(cache->alloc_offset > cache->zone_capacity)) {
>> @@ -1785,6 +1789,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_=
block_group *cache, bool new)
>>   		btrfs_free_chunk_map(cache->physical_map);
>>   		cache->physical_map =3D NULL;
>>   	}
>> +
>>   	bitmap_free(active);
>>   	kfree(zone_info);
>>
>
>
> Stray newline.
>
> Other than that,
>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Thanks for the review! Let me send a v3 shortly with your comments
applied.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjmVfEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZVtcEACmUM9RHg4i24f6OzrhxEtMXLpJZ5PTHyAIYibSw4RqemAFv9CZ+sQprrkH
z/RztJWSzeWo3FFcLHE8qCPLSI/UrrgRK+ztj8RlBFwU0tDjxOEavFEbxbMbG29o
6NmnIP/R6pePAhjvvRaZzoMBfpwqZ4izFAMDutQyrQv4pxwlm1XwdU1kQM5X7soH
4V9i+pSOETaE4eNSNlcCTZK6gjdqucrJB7LoSPiLSvWXHqIEELF5a2BEgy1F/Z0Y
RCLYJ4kB80VUtGrBGsUHTm6jGEbbgP2KVfNBcQkaGzLPxuampR7SavEmNdiTpdzB
Uec4XSmQpLc3RMUpzFB+jZA1QkcOd4cHbxbCYG4FJkTjW8RTwuHrNV4DdYuH4Akk
iOJTr62ZzM7G+CZ7W17PK0A7qQNmFBBFExXOGaNFB0ST8UFrNXfIdcrPui8e364I
n++6bHa92fs9fFGiCdPBQSeDn8LjhgKvxyVXPjWlaD5rJ4fH93zJh4HKn96A7JPm
oANdRtXRDTMLpF8pfEFemgIIBugphrZtRzkTg4gytrqx0U6KPyJbwWNxWkLM08Nr
yF72LY7AcbRRaEzd2hwU4X7pdZDbIfnluG2zjqbE51RxLYQtgdWiDGJ5lHRh0GM/
N0BClw+XpfsnlA5tXek8kaqDxHT4krCz+OO7GMKUGQgGdni2iQ==
=bdCs
-----END PGP SIGNATURE-----
--=-=-=--

