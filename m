Return-Path: <linux-btrfs+bounces-3988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C5889A74C
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 00:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5AD1F24F02
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E4521362;
	Fri,  5 Apr 2024 22:32:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013911718
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356321; cv=pass; b=rim+YhOsb+IxRXU7ltRCCNkDMTp5jaxiZgSESFtH6GyG3DvYAt/efxDx+s5nnoPzLGd9aBeaQH54MvxfczYtERlmaV5Ccs4UTXrfuGg1+wgC4fJ4a75isNJZHt6yxwMceSKNLKQsqaOz6BIbU4SUU+L0N1B0S1FKdroOJtYk59U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356321; c=relaxed/simple;
	bh=v1yHfuaXLgVAuTt0QKRTVKi3dcN6gQobR1nlHmJg0aI=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=GZPJaH1NzkVMgim3Mr/Cdcdju60OJaG02/60/IiXIFERjcIkJO/3KulGaiZVYkmG8t8ZKd8kMbpkHWi0NJRQrjaxN0ymHvxZIe/a3AOa0+ETk6rULRSJdM2JAAihEKCIGh0YA/CEiCEFP9guVdRfrIfA51NIrQuU7zVtJ2uZLNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6F23E102406
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 22:22:59 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id C4C551024E2
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 22:22:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1712355779; a=rsa-sha256;
	cv=none;
	b=+XKMn/nbZa1Ckz8e/o4sD/GA6/sJbM8Mq0IJ/3nq98229fJ3BCm8eRBVMLozc55yS++BxX
	oDxP+5hKTJnZQGinxdgTyD49M+eWeCgkChRy1/l3P41nnQlgdc5shE0d/Eg2GRUp8AfwMd
	HE2GDYEKk9da/tprRvWsmsyxqWxIlVqMBzhNoHyoLVC6/u/YcSLbHjWyK0L6+zVKZJRAvE
	VmCCrNCNyNHrZbHmZFHPUJet7/FHr8+HiNsyVkTJhLc8lZXWSWEfPF0gBmhy3Pqrr8nwka
	dsmdl0VYbLOvg6dAL8p8yvBw5RpgHUquIJTBQaBi9yxkh0uQjnij7n97v7pg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1712355779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zvNwLLJxSJ78rVbu0dxLtC5xeJY1jy9Ra+jJjqZR2VM=;
	b=UKQgMZ4dvuE93xXcscbPr6hROsUkEOw7Dc8gYw1FTicfIX/YsBdM8zI5Bg3zL9fCxSkcKF
	lD2elxmtbnLGOAdoEBKbe0wBDjk/fpJu6MTxCtPJ1yvIPGF3DdEEjYru94iWBRh0BlaPYM
	PIquy2unjaqGDhHoRqZ+mwGXNCwutnDewFUKtSsrekRNP/cqOYCE8Li3WfnkuqTgGj88T7
	Lpas6JDTmr+nbwqo9+LoYMi+N17+WYH1RFy9WfDZdbu5g3i5gkvLGnVenFbXxSTBiSEJ8l
	Ws0UPMWqPKRJ4eHKBC5yODiz1VnBHC2879u4oXSBmWZhiIL+D91l+d9xh+4N0Q==
ARC-Authentication-Results: i=1;
	rspamd-687b9dd446-f88kd;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Tank-Hook: 286f584d0b0ad7b3_1712355779294_1227226886
X-MC-Loop-Signature: 1712355779294:311039943
X-MC-Ingress-Time: 1712355779294
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.117.91.86 (trex/6.9.2);
	Fri, 05 Apr 2024 22:22:59 +0000
Received: from p5b0eda68.dip0.t-ipconnect.de ([91.14.218.104]:56732 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rsrxX-0004Yh-2K
	for linux-btrfs@vger.kernel.org;
	Fri, 05 Apr 2024 22:22:57 +0000
Message-ID: <896a5d36071a30605c38779dd03103b6429ebcae.camel@scientia.org>
Subject: exactly shrinking btrfs on a device?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date: Sat, 06 Apr 2024 00:22:52 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1+b1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.

Assuming one has a btrfs (e.g. even on multiple devices)... one can
shrink the total fs via:
   btrfs filesystem resize

(or even it's usage on a specific device via
 btrfs filesystem resize devid:=E2=80=A6 )


If that btrfs on some given device was placed within some other
container (e.g. a partition, LUKS, LVM, etc.) one likely wants to next
shrink that outer container.

How does one do that? I mean, how do I find out the exact last by that
btrfs uses on a particular device?


Is it what btrfs inspect-internal dump-super /dev/<particular device>
gives me as:
   dev_item.total_bytes	...
?

Is that always a multiple of 512?

And I'd assume that's the length, so the address of the last used byte
would be dev_item.total_bytes - 1 ?



Respectively if I have that fs in a partition like:
Number  Start (sector)    End (sector)  Size       Code  Name
   2         2097152       976773119   464.8 GiB   8300  Linux filesystem

That would mean, the last used / end sector is :
2097152 + ceil(dev_item.total_bytes/512) - 1


Does that sound right?


Cheers,
Chris.

