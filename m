Return-Path: <linux-btrfs+bounces-17504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CACBBC113B
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 13:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2E6F4F3BD6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 11:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55FD2D73A7;
	Tue,  7 Oct 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="Cvod0Cms"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941E2528FD;
	Tue,  7 Oct 2025 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835097; cv=none; b=Gdk2TWAYgVaDMafofsYqRmFuXBh4aGkHf/4K/dERoegUDDSMagoyh79bFZ8nP+eUzRWEYLjmx/1WmXktTJsM015zepRCRfpcXFQk5Q99VkT0MPFkei80tAxHe4231xtqgxqU2OThhsgZyAZrnJrgBB4t93VC0bJ6omHvXg4nwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835097; c=relaxed/simple;
	bh=jzPBhqvo5H7y+wsZyZ1t2fUquxyErwMM1+R/dmftZNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cFD2QmJwaljcen0nrp+MNk4SYDC4UtjOXES1vYqURlp0JRMLgapnVfrA3ZOm0GZSL6c0B/hdKyD0uorL3tJvihQ1ak/QkbVybou7HRiXcpWV61pdzg4demTMqxQXr5P3RVX0+ycLTtdOkq5PDVgLKQpoS3whiXhnxADExa4Ktls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=Cvod0Cms; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cgtZV0Js2z9xvJ;
	Tue,  7 Oct 2025 13:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759835090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QvaJKv3xB/AHfuhApccXEYsaBiwHN9t2jnBpVMkwmqU=;
	b=Cvod0Cms0YvX0FFubS2+qErFat1mHWaFM4dYINa1sd9KFA31G7/or7R8fEAbP8kAXTdkdP
	n7xIRKORLvK9BB4VwUoOI/7/OA2DpNGsLqtRBohgXu8Et9K4+ZF82AVWPsdHP+NDsvloxf
	77wKjFR4Yd2Z7NdOI00Qpy3bFuKzBPjfvuqw0GH6f7Q34V+2a6+xQo35NjKScMYcJUEM7N
	RFLuNbZ7NTlZIEC6rG/8d/mM+Mr81TLx5iZlildqMJ/Sf8kPEXyKaPKJ2Xc7pbDLg5KwHT
	vcwsUGsxN3vym7+PrqPLxCrHRdKhEF/f+hRjGdzqyRtHEpAwyKPIWM5hpg1SmA==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
  "clm@fb.com" <clm@fb.com>,  "dsterba@suse.com" <dsterba@suse.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix memory leak when rejecting a non SINGLE data
 profile without an RST
In-Reply-To: <e82bb44e-5f56-4ddc-976a-9ff268a5b705@wdc.com> (Johannes
	Thumshirn's message of "Tue, 7 Oct 2025 10:13:18 +0000")
References: <20251007055453.343450-1-mssola@mssola.com>
	<e82bb44e-5f56-4ddc-976a-9ff268a5b705@wdc.com>
Date: Tue, 07 Oct 2025 13:04:46 +0200
Message-ID: <874isbj7ld.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Johannes Thumshirn @ 2025-10-07 10:13 GMT:

> On 10/7/25 7:55 AM, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>> At the end of btrfs_load_block_group_zone_info() the first thing we do
>> is to ensure that if the mapping type is not a SINGLE one and there is
>> no RAID stripe tree, then we return early with an error.
>>
>> Doing that, though, prevents the code from running the last calls from
>> this function which are about freeing memory allocated during its
>> run. Hence, in this case, instead of returning early go to the freeing
>> section of this function and leave then.
>>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>> ---
>>   fs/btrfs/zoned.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index e3341a84f4ab..b0f5d61dbfd2 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -1753,7 +1753,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_=
block_group *cache, bool new)
>>   	    !fs_info->stripe_root) {
>>   		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
>>   			  btrfs_bg_type_to_raid_name(map->type));
>> -		return -EINVAL;
>> +		ret =3D -EINVAL;
>> +		goto out_free;
>>   	}
>>
>>   	if (unlikely(cache->alloc_offset > cache->zone_capacity)) {
>> @@ -1785,6 +1786,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_=
block_group *cache, bool new)
>>   		btrfs_free_chunk_map(cache->physical_map);
>>   		cache->physical_map =3D NULL;
>>   	}
>> +
>> +out_free:
>>   	bitmap_free(active);
>>   	kfree(zone_info);
>>
>
> Wouldn't it make more sense to only set "ret =3D -EINVAL" and run the rest
> of the functions cleanup? I.e. with your patch the chunk_map isn't freed
> as well.

The short answer is that I wanted to keep the patch as minimal as
possible while preserving the intent of the original code. From the
original code (see commit 5906333cc4af ("btrfs: zoned: don't skip block
group profile checks on conventional zones")), I get that the intent was
to return as early as possible, so to not go through all the if
statements below as they were not relevant on that case (that is, not
just the one you mention where the cache->physical_map is
freed). Falling through as you suggest would go into these if/else
blocks, which I don't think is what we want to do.

But it still sounds good that we should probably also free the chunk map
as you say. Hence, maybe we could move the new "out_free:" label before
the `if (!ret)` block right above where I've put it now. This way we
ensure that the chunk map is freed, and we avoid going through the other
if/else blocks which the aforementioned commit wanted to avoid.

As a last note, maybe for v2 I should add:

Fixes: 5906333cc4af ("btrfs: zoned: don't skip block group profile checks o=
n conventional zones")

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjk884bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZS8QD/4g0xAyzy8qNMkfel8YyqnJcQYa5IW+2l6UiYBkkjhSmVxRXPuoWcWSSsXs
7AtdiMywTNMfl97chKBV0kVY8K1/EMD43SoLKImGUOrX1A+VaaaKMrXg5fu8Bs6v
itC9KudolA2rpwM7RYgrXvbNNLYcMxduvFY3ZjlZ1fIEJeuKaxYRpeStzcoSZ1qi
6v8YulnfH5um+cTe+q9T77g23v5BLIWjVBtRd2skFfsm3GFKbnEfXysE8dAZVj6Q
93EZ8C0KxoPnVNBDCrbDyxViAQB+oai8dzdNSTIpWjm5zNfiq8t7hZfx0hISfhZN
c5pxV65UGWrpvtQ7Oj4eXy7OeJM+XQ5KJm7YZ0k91VdHWdBYzpJj/A7TGl94qQCN
zYuu/fijRgJiEPWVpyhqcPrl2gNq43WFmei06hhFWowIfFxPnXfSzlJsI61A2HQ5
W9lDVFokdFpjE9JDGlCSrUHHlexLu+q5iGnzeQywz13kme4oW1sNBUPe5E7pCStk
hphtvlTSu1UxILQvDnqdrAag5wI0MOVv98o6BPFKNoBkmovmKj9NrHj7qPcsGtGm
7T84CrWBWqLfFzZCiZB4dV2V0JA+EWsqqUIeIgB+RYDi2b67iDi7n/NmQeM9BwdV
bpg1rbVyA2ExYg4iGXINLWi5RtiDabIpuLmB+DuneGuJBC3Ajg==
=Dxpf
-----END PGP SIGNATURE-----
--=-=-=--

