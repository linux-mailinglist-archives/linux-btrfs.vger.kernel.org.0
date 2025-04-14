Return-Path: <linux-btrfs+bounces-13002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 697DCA88B57
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 20:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9DB176A9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFB82949FF;
	Mon, 14 Apr 2025 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KM+OUBSD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1428E61F
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655550; cv=none; b=IKp9XQ0v5Lzx/cbZWGHvCyXhTJctuSoqMScs3HSTAoDGnGORKNNOHNm9avMScqnNG3zeaWNE3wwU6TprHFRrh67wZObhbCd/MiN82EbpW3aXcGni3WJVOHXyoMJk2Sc7fH95DX9vHGS8mc93UizHS7QeIc2T71j7rDElV2758VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655550; c=relaxed/simple;
	bh=48vQzwMouV+57+4bD0wF4EKBr465DeOVOqg7VR/KuVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1odNNTdjnwx5OsD60DKWdbtZ9LQgTdoig5z2uT5LRklUgSRGilBMYsgpGoyqTMLxI/MMI/LRBJ924lchyV+WyQCCqRO3HdPvK+lT5p73+KPPYI6+oWq/XANLD7/wOmi+LQKqYASZs1Tr8U990sLzobnC8Br3plVtoYG3P2bG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KM+OUBSD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v45/UskLFObqJtpFMkbzySSGVAHvij3jg9dTFuq8zr0=; b=KM+OUBSDTPOdc1yC9RA0tzKhno
	W+n4NkfhstnCgqrCgc8FmdwI+HSl+9Fhu1tDwbNKE6DFXdy43UE8msGdhXYFPno51Mm5/FiQlF1v6
	b4eDCQpGsWWDs1qad4IjKEnm2urSJ3gmd+z4rO5Pgab/A2LPZfrU9kBiVls90DdYCP701RDoCpbmZ
	I3RI/4xhLoeBUs5wT3x8MDQNTH8SS9mS6SgGvrLJUUoA2C3Wqn+DEj3hdh87ZClfVU9rJ+psI6DRp
	AIYXtbnv2lxJLzDDlcjiWqPPBP5RM7Jtqz2yIYH2EZrgbGULAFCNbMV50SUgBvi6gq+VcAlOWMGuh
	CDzpRYqA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1u4ObY-003Fqb-RF; Mon, 14 Apr 2025 18:32:25 +0000
From: Nicholas D Steeves <sten@debian.org>
To: kreijack@inwind.it
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-btrfs@vger.kernel.org
Subject: Re: P.S. Re: Odd snapshot subvolume
In-Reply-To: <72d7150b-4e0b-4e15-bd3f-ab410be4a767@libero.it>
References: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
 <87friais1a.fsf@navis.mail-host-address-is-not-set>
 <87cydeirkl.fsf@navis.mail-host-address-is-not-set>
 <72d7150b-4e0b-4e15-bd3f-ab410be4a767@libero.it>
Date: Mon, 14 Apr 2025 14:32:16 -0400
Message-ID: <87tt6q1tn3.fsf@navis.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: sten

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Goffredo Baroncelli <kreijack@libero.it> writes:

> On 14/04/2025 19.24, Nicholas D Steeves wrote:
>> P.S.
>>=20
>> Nicholas D Steeves <sten@debian.org> writes:
>>=20
>>>> just remove it?
>>>
>>>    # mkdir -p /btrfs-admin
>>>    # mount -o subvolid=3D5 /dev/disk/by-uuid/c08a988c-ddd5-164e-b01e-51=
ac26bf018b /btrfs-admin
>>=20
>> Oops!  This /\ is wrong, because btrfs subvolume show / returns the
>> filesystem UUID, and the command above uses the disk UUID.
>
> I have to correct you: "btrfs sub show" shows the *SUBVOLUME* uuid, where
> /dev/disk/by-uuid/XXXX refers to the *FILESYSTEM* uuid.
> Apart that, it is correct that you can't take the UUID from "btrfs sub sh=
ow"
> to mount a filesystem. You need the UUID from "btrfs fi show"

Of course 'subvolume show' gets subvolume UUID, 'filesystem show' gets
filesystem UUID, and this is too complicated.  Yes, it's logical, once
one understands btrfs, but multiple of my colleagues have looked at
stuff like this, thrown up their arms, and exclaimed things to the
effect of "I have more important things to think about".

To encourage btrfs adoption I think we need to do better.  After
considering alternatives, I wonder if there is anything simpler/better
than

  # findmnt -n -o SOURCE /foo | cut -d[ -f1

to get the device suitable for mounting -o subvolid=3D5 | subvol=3D/ ?  Ie:
"Just let me see everything with as little fuss as possible. Make it
simple!", without relying on fstab.

Cheers,
Nicholas


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmf9VLAQHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYQm2D/9Mcpu35SJ5n1p1BOkK1C2oOEWA7RQ34+Zj
0miB7crp56g9a+QzsmPa+gIQkdDabcijD+jzRaSMgH1L4VWJfsB67DvzgeHnQU19
Qa7noWVPZ2UOjhXES78WlQZhsJLTtpjZiO4MenD4yvw28L5FFLpzNj+FoEteMMFg
B+ZDiY0ylR6AqFLmwPaNNfir7MSlcjJzjJc6GeTO6BllIgCkE1uXymO4ZbKr6FdI
LO3qvuv3boqh/HsjP7daMavZSghIc1eDV43lLowT5RIyZ28voaKOsA2+ayghqoXz
hdYZI9KPqaostamb3Sw0k5LD8Vc3p40rJ2IbDJhX/ROTajgI/zcapSZqrsfo6sqC
8l2cE03uxdodiRQ9lddDZYFPAXb4emQN7xX4GG9c6+nUN57zT3Ru5zVdR4ns4LVT
PX+6rkQqr0cPbi2koQUTkgpwA4+l68p2ZOU8IZbdDIUrtVXk3i/3gH43hcF0q6Z+
BvRy1IjPNR57eDZ90dECefB4Qv99N5Qfba9yLkUyeyYJuQ0o+RrAMeG24e998IhI
7+uXt3B5JL/expWGEj24kQ/3btpcFBcL8Z8JM1tdqsHiO0otv8e1rKB7JNIYbWqL
ZCgFt+ez6XJY2apyKWxKXgVxdYBQ+MzZodMsKJFhDViYrcx/t9k0fhvVtAoW+XhV
J00yeSjAVQ==
=SazR
-----END PGP SIGNATURE-----
--=-=-=--

