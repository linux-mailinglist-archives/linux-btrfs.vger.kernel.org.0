Return-Path: <linux-btrfs+bounces-1459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A5D82E7B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 02:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633DF1F22D2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2579D0;
	Tue, 16 Jan 2024 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bluemole.com header.i=@bluemole.com header.b="aF/b6m00"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx04lb.world4you.com (mx04lb.world4you.com [81.19.149.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBF7499
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluemole.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluemole.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bluemole.com; s=dkim11; h=To:Date:Message-Id:Subject:Mime-Version:
	Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qEPSQ+5bvnmfTsHAUBwtXOT/I+BytFcTfetORs7rBkw=; b=aF/b6m00fKDo997zWfBTGqeCJr
	mXlP5GgqqqLUDkX9ZwI+Mxd9wSurW8ouH9Ca7Sui68QY6rrHb47qya+ja9p7Z9lPvFWfycE5r6TIJ
	H65D2RpKMHaRCguN1h5CYb5njJ7ERvzpzO8WDiDnqE01vnJFlJkTWkfjDrnWyxLXOQtyNXb/s/pnC
	wSWuhZh6HoDeyL3A6YDT1ptqDLKf4wH9Spy0ialpd6uzHEt0GpFkoZPqULG85zBNOjfv+6JGtgbpC
	pJwz4X606ntoBPUaLIgEShBxxRj63wGQS4uloYOjG/Hh1nmTlFM89EtIIZRZzyXo22UuNgKrZwvAU
	P8L2opBg==;
Received: from [62.240.134.68] (helo=cox.noco)
	by mx04lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ubu@bluemole.com>)
	id 1rPXzD-00042B-1D
	for linux-btrfs@vger.kernel.org;
	Tue, 16 Jan 2024 02:11:27 +0100
From: Michael Zacherl <ubu@bluemole.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Checking status of potentially hibernating encrypted BTRFS?
Message-Id: <70AC3CE8-D407-4409-AAB7-1F1FF38A7ECE@bluemole.com>
Date: Tue, 16 Jan 2024 02:11:26 +0100
To: linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
X-AV-Do-Run: Yes

Hello,
after I accidentally rendered a system with encrypted BTRFS un-bootable, =
I=E2=80=99m trying to check the state of the BTRFS before I try to mount =
it externally.
After some intense experience *) I=E2=80=99d prefer to proceed very =
carefully.
I=E2=80=99ve to assume the system is hibernating, so the FS is not in a =
clean state.
In order to fix the system I=E2=80=99d have to mount the FS externally.

What=E2=80=99s a save way to proceed?
Thank you very much!

Michael.


*) =
https://lore.kernel.org/linux-btrfs/12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@b=
luemole.com/=

