Return-Path: <linux-btrfs+bounces-19766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68815CC06DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 02:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 957F43022AA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 01:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE1239E7D;
	Tue, 16 Dec 2025 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mikkel.cc header.i=@mikkel.cc header.b="UU2PtI2g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F601C8E6
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765847665; cv=none; b=phl0eF8QYLeunAwVpPQURTXc/EVP4J43h7n32qlW/XajcFkz5mIPq02i0yRbmbgFBR7+9yqVBP6cc9IX5ZNUVKpKADKU6jG4o9NCo1BNumr266ub5NZfyUJYCENnfovcmfxIdY8uSWk9cTxD/2PaLG63fj6Wwk/Hwrj16vjqNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765847665; c=relaxed/simple;
	bh=Vvgle8S/EAJWeYsSZ/4/5XMl4HCd52fUVlb1pDqZJE8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=nnDE8FUzyTDpKWONhXh/s3OUDU9/oVk52iuKdfZ+aZPFjIBMg+bVEIHXeDZHPdrduaAwcXmlubYq+l9LVI2rk0WHcFt3NjdExweAyfAf3jpO4ZDfXZCxNpuH40q/QmZpYHWJMreyjhwOFnfZUlH+wMjD6sXhNI7vr9mVT1CdIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mikkel.cc; spf=pass smtp.mailfrom=mikkel.cc; dkim=pass (2048-bit key) header.d=mikkel.cc header.i=@mikkel.cc header.b=UU2PtI2g; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mikkel.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikkel.cc
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mikkel.cc; s=key1;
	t=1765847659; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apUIh6FOV0xXhe0Kvjw47fKl1r66rid8/zqSYuHcpg8=;
	b=UU2PtI2gJC/e9BZL0IYXahHiJLVIhIlx1E6ZNfapW4HkY9MgcYrxSzmu9HQQhh1WOvL0i4
	6XczeqQKYwIEmzDL3r474/1yGchAM+pHq+W9HxnMARZKgNkCp0VD8B69RfHkCcKJM99zeK
	axEfBDgyrD4Z7mSHp5P6LFQDK2VWh9F2yHu8Qe6IVBLfmiAEwleB3NXoMAsGodGkCHp+Mg
	fJMRpTSGu016Y7dKr5oMnTDwahWudlVjFXpKbxMT24dvUxYQkEPVWQsSVoBANQ+H4pGekY
	bKQekdWny0A2brKy1Uanh+SkKnXfXxCnqudrSZRVi4jO/3I12rpxAVhqNA1IdA==
Date: Tue, 16 Dec 2025 01:14:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: mikkel@mikkel.cc
Message-ID: <bc11ac085b08b3e55e79d1d5ffb85d7a62672b6b@mikkel.cc>
Reply-To: mikkel+btrfs@mikkel.cc
TLS-Required: No
Subject: Re: kernel 6.17 and 6.18, WARNING: CPU: 5 PID: 7181 at
 fs/btrfs/inode.c:4297 __btrfs_unlink_inode, forced readonly
To: "Qu Wenruo" <wqu@suse.com>, mikkel+btrfs@mikkel.cc,
 lists@colorremedies.com
Cc: linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com
In-Reply-To: <4960584d-eb14-40ee-a039-c1ca27f20a05@suse.com>
References: <3187ffcc-bbaa-45a3-9839-bb266f188b47@app.fastmail.com>
 <acefecca-9fbb-4268-a26a-b889756019e7@mikkel.cc>
 <4960584d-eb14-40ee-a039-c1ca27f20a05@suse.com>
X-Migadu-Flow: FLOW_OUT

On Tuesday, December 16, 2025 12:05:54 AM Central European Standard Time =
Qu=20
Wenruo=20wrote:

>=20
>=20=E5=9C=A8 2025/12/16 08:31, Mikkel Jeppesen =E5=86=99=E9=81=93:
>  Hi there. Affected user here :)
>=20=20
>=20 On Monday, December 15, 2025 3:47:13 PM Central European Standard Ti=
me
>  Chris
>=20=20
>=20 Murphy wrote:
>  > ...
>  > >> Looks like --repair changed from "errors 4" to "errors 6"
>  > >>=20
>=20 > >>=20
>=20 > >> [1/8] checking log
>  > >> [2/8] checking root items
>  > >> [3/8] checking extents
>  > >> [4/8] checking free space tree
>  > >> [5/8] checking fs roots
>  > >>=20
>=20 > >> unresolved ref dir 1924 index 0 namelen 40 name
>  > >> AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E filetype 1 errors 6, no =
dir
>  > >> index, no inode ref
>  > >
>  > > And repair again?
>  >=20
>=20 > No change.
>  >=20
>=20 > sudo btrfs-image -t 16 -c 9 -ss /dev/sda3 fs_post_repair.img
>  >=20
>=20 > https://paste.mikkel.cc/gNwpLmyw
>  >=20
>=20 > > If after repair, readonly check still shows error, I can craft a
>  > > quick
>  > >=20
>=20 > > fix branch for the reporter.
>  >=20
>=20 > I'll check to see if they still have the file system. I asked them=
 to
>=20=20
>=20 make a
>=20=20
>=20 > btrfs-image before starting over. Thanks Qu!
>=20=20
>=20 I installed a new F43 install on a different SSD, so I still have th=
e
>  affected
>=20=20
>=20 file system/install available for any testing.
>=20=20
>=20 Thanks a lot. If your fs doesn't contain confidential info in the fi=
le
>  names (btrfs-image dump doesn't contain regular data, but may still
>  contain inlined data), a regular btrfs-image dump would be the best wa=
y
>  for us to test.
>=20=20
>=20 Unfortunately this corruption involves filename, thus the "-s"/"-ss"
>  option is screwing up the result.
=20
There=20shouldn't be any issues there. I hadn't used the system for much =
other=20
than=20one steam game before this happened.
Here's the image:
https://paste.mikkel.cc/FH3jEN9z

>=20
>=20If there is confidential filenames involved, please provide the
>  following dump from the original fs:
>=20=20
>=20 # btrfs ins dump-tree <device> | grep -C 7
>  "AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E"
>=20=20
>=20 And unfortunately we will need to communicate for each new dump, so =
this
>  will take some time.
>=20
That's=20all good. I'm heading off for tonight, but I'll try and keep an =
eye on=20
my=20email when I'm home :)

>=20
>=20And before posting the content of above dump, make sure no confidenti=
al
>  filename is involved.
>=20=20
>=20 Thanks,
>  Qu
>=20=20
>=20 Thanks for the quick and good responses to this! :)
>

