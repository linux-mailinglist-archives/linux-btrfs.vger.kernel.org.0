Return-Path: <linux-btrfs+bounces-2983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CEF86F102
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 16:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE70B1F21EA9
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Mar 2024 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E73210E9;
	Sat,  2 Mar 2024 15:56:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B120B27
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Mar 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709395008; cv=none; b=vCfqUwbdn8YUzvIGv7qx1H9IT+tIn3v7ODw0yrD/S2vgb4jgiiRq/eaFj0DEP3N7TXpu0EPHZsOHHfZcaJ0M7nJdTVF5C1sgx4bW+F9wVaVqENYfY/PPBXTdT6mbwtuICtIAptXvTd1FYlhCNwDUGT4XfrEcZMB7GkGKsMFbS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709395008; c=relaxed/simple;
	bh=JVpDii7bEPosS0TTW4nrSIoyqmk7U4WBzrDmhbZzHSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKwXm4TjSETffySN3zRBnY64Bgq6gGbQoLMJHqnrKtqjdpRp/RmSqEHmYoZGLPExZDmBD/ZoIQXJJoYnlfMhVjn8/a1N9H/RmRYFjbEqALmqLDtzMgUhglK5VgN9IQ8A7ASvlLNg5O9t4cK0Qc5hpBYc3GZBxB+yE1ibKty4Dqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (unknown [IPv6:fd39::4a:3cff:fe57:d6b5])
	by shin.romanrm.net (Postfix) with SMTP id 5727F3F8ED;
	Sat,  2 Mar 2024 15:47:32 +0000 (UTC)
Date: Sat, 2 Mar 2024 20:47:26 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Nigel Kukard <nkukard@LBSD.net>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs ontop of LVM ontop of MD RAID1 supported?
Message-ID: <20240302204726.6d2dcd87@nvm>
In-Reply-To: <1cfb237c-5583-44e9-8bad-d91f34e29972@LBSD.net>
References: <1cfb237c-5583-44e9-8bad-d91f34e29972@LBSD.net>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Mar 2024 15:01:43 +0000
Nigel Kukard <nkukard@LBSD.net> wrote:

> I'm wondering if btrfs ontop of LVM ontop of MD RAID1 is supported?=C2=A0=
=20

Should be absolutely supported.

> I've managed to reproduce with 100% accuracy severe data corruption=20
> using this configuration on 6.6.19.
>=20
> 2 x 1.92T NVMe's in MD RAID1 configuration
> LVM volume created ontop of the MD RAID1
> btrfs filesystem on the LV
>=20
> I then write about 100-200G of data. Create a snapshot. Read/write the=20
> file and get these messages...

Has the MD RAID1 finished its initial sync after creation?

Have you tried waiting until it finishes and only then do thewrites to see =
if
the corruption is still observed (of course that's in no way a "workaround",
just to see what might cause the bug).

Do you know any kernel versions or series where this corruption did not hap=
pen?

I assume you're not saying it appeared in 6.6.19 compared to 6.6.18.

Can you try the 6.1 series? Or maybe also 6.8?

I made a Btrfs on top of LVM on top of RAID1 myself now, but on consumer SS=
Ds.
Copying some files to it now, to check. Would be also helpful if you can fi=
nd
a precise sequence of commands which can trigger the bug, less vague than
copy some files to it and see.

--=20
With respect,
Roman

