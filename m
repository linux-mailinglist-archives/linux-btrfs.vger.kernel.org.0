Return-Path: <linux-btrfs+bounces-6542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E82934C3B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056941C219CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0EB137903;
	Thu, 18 Jul 2024 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jku.at header.i=@jku.at header.b="BxWEhoHy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from emailsecure.uni-linz.ac.at (emailsecure.uni-linz.ac.at [140.78.3.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816812F5B1
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.78.3.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301050; cv=pass; b=UCqC5lQHlQ00QmnH9BLEdRd7mM4RIvW2UusCzmCs1g4ZIy4hIzIHfCasOmWFj4zl0byjdYGtdPcfhhiLvwjJ6GVppX74DboGqVVEMVB1iYLbngtLR7YtP/uHdISaLLubbgu6SFfmjvvFoR9YPHKiBJgmtOB+R+b2g1dGOABc6JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301050; c=relaxed/simple;
	bh=+7Tcsz8PHvuGRgYQ15ifqxrG3sdCqY9CDuBFpfNmKGI=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=cv6MyUm4917zJ5fh/3WWUEasxL12xpYKltiAzabp45vfrbx2tIDDVdYkCRPaHlojjlXfp2QCqxdhwu1AvHdKcsak4cT/KXWbv3fuGCeEBNTGjoysw8j46mymFqAZG9G/p9h6d78mAjoV2pUlH1rwaHDRFiAtuWdKh+8F68LaiNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jku.at; spf=pass smtp.mailfrom=jku.at; dkim=pass (2048-bit key) header.d=jku.at header.i=@jku.at header.b=BxWEhoHy; arc=pass smtp.client-ip=140.78.3.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jku.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jku.at
Received: from [140.78.146.150] (unknown [140.78.146.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by emailsecure.uni-linz.ac.at (Postfix) with ESMTPSA id 4WPqdY3pkCz4vyr
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 13:02:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=jku.at; s=202311-arc; t=1721300545; cv=none;
	b=T+xjvDAcam3gPYMntqUKYqUmyIMYMbjYaxFQzM0kQIOoKTHfcA5Iywf4H6w2hIibIZYoOWDTfiFS69LEMlEi+FdjojycrB535LfcbD/EZ63LxPeBXPrWHZBqLlWC4zxd3SwFfI2pp8HsymVJXHdU1TzBQPOdbOzfTK0V73WT3vmNWAS69fYulPBXI0eIIc5jZRzq9GPpw5e/5b00CxGWYykXFYjLoUrrGxLDrdeQ98L8+x6UawJKu+aisWQWaTTh40K2dB6fL6EXhXMcBjr6REBeUOOr/4vqetLA58PWpvpH1XwTq6gVt33fPv+/M45NKUUCtmCc5NkMu+voB+r7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=jku.at; s=202311-arc;
	t=1721300545; c=relaxed/simple;
	bh=+7Tcsz8PHvuGRgYQ15ifqxrG3sdCqY9CDuBFpfNmKGI=;
	h=DKIM-Signature:Message-ID:Subject:From:To:Date:MIME-Version; b=F4GXlDOOhVDXSz/KbIe6g8OTndKRlo8UFs9uZ7qT3NYzMGhpLCXnW+pkB2/Mz5WrlJgdBx21TkrRNMq/tCSvxG5eWkynqbMcGefeTBnMJ+IfsLhHO2bxqgHLUEu/D1CODe+tkueygVeTb4I1M1GFk+/BM21wUekiadT8WqZY1mem9Re5WO7HMTo2OPsQyyCRLwvuIWtOyrEeyDTL1ejAKxDvN3EOpixV94TgXW5y6pLgNRL8u7U65v0foB8xvT6h4Ps5T3bqRvcRrv3prtKfX0iaSqqwEJEJqkPH4AAsPoCq9vi3dXK2XttCuX06rDmJD6+TsPAhsZ5zx2S2RY0nUw==
ARC-Authentication-Results: i=1; emailsecure.uni-linz.ac.at
DKIM-Filter: OpenDKIM Filter v2.11.0 emailsecure.uni-linz.ac.at 4WPqdY3pkCz4vyr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jku.at;
	s=202312-dkim-jkuat; t=1721300545;
	bh=Wg74UcMH4GycQyLZpo9G/MAOHWrcDdjeXDrrRL73Zk0=;
	h=Subject:From:To:Date:From;
	b=BxWEhoHyZ1H1+X2gC1gSsG6kY09F0HGNuSA5bnOKHOV3F2bVNd0Obfgd328GbO6Rp
	 NCFCzonVYHnU6Skq75adJ4vMemFbQJuWGcpkAvcmIEN4gwdn7yWNBAe4C7LgD0D9m+
	 P+ZiIYw8aydI9PYUvV7JPkJatt1TD29MPz/Vxy9RNmMxiKU2p81ysLm+ZrZ60QUNke
	 TB/JExCzlscMrRiVqhH9X0sN+p/LFTEv0zsWWG5Z4wJddrVLnOAvYKcoS9V3Yg6lxR
	 dDzzbU3e+pwGkPAXRhwAEixSCdLyvMXWIhv1uR5SSwKtFrdshRHSsdniXU2Z87Ep8m
	 Yia3N970o4ncA==
Message-ID: <4426d5d3202c37b9bc7cea5281c017f77521074b.camel@jku.at>
Subject: Question about 32 bit limitations
From: David Schiller <david.schiller@jku.at>
To: linux-btrfs@vger.kernel.org
Date: Thu, 18 Jul 2024 13:02:25 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

I'm running a four disk "raid1" array on old Atom-based NAS hardware (no
64 bit compatibility). It's a mixed set of disks (2x 4T, 2x 6T) and
"btrfs filesystem usage" reports around 18 TiB under device size. I'm
aware of the logical address limit and was regularly seeing the 5/8
warning in the kernel log (the FS was created before this warning was
introduced). The system is non-critical and only sees I/O once a day
when an rsync job is running.

Everything ran fine until the FS was remounted read-only during a scrub.
The scrub finished without errors and a reboot got it back to read-write
immediately. At this point I thought to delete a subvolume and resize
the FS on the two larger disks to come in at under 16 TiB device size
total. Unfortunately the delete and subsequent background clean task
kept OOM'ing on this ancient machine and I had to temporarily move the
disks to a different (64 bit) machine with more memory. There the
deletion worked fine and I did a check, two resizes and a balance (in
hindsight the last one was probably a mistake). Now device size is 15.99
TiB, but when I move the disks back, I can't mount the FS anymore.

[  604.404057] BTRFS error (device sdb1): reached 32bit limit for logical a=
ddresses                    =20
[  604.404110] BTRFS error (device sdb1): due to page cache limit on 32bit =
systems, metadata beyond 16T can't be accessed
[  604.404145] BTRFS error (device sdb1): please consider upgrading to 64bi=
t kernel/hardware
[  604.404175] BTRFS error (device sdb1): failed to read chunk tree: -75
[  604.441574] BTRFS error (device sdb1): open_ctree failed

I guess since it talks about "logical" addresses and not physical ones,
the resize was pointless to begin with. Is there anything I can do to
make this FS mountable on 32 bit again?

I don't want to decommission this box, so the alternative would be to
recreate the file system from scratch and restore from backup. This is a
very low priority system, that's why I ignored the warning initially.
This is by no means the fault of BTRFS.

Best regards
Dave




