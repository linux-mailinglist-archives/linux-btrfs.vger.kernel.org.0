Return-Path: <linux-btrfs+bounces-4856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D8B8C0B1A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 07:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CAD1C20ECD
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 05:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3701494AD;
	Thu,  9 May 2024 05:43:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B1C13C;
	Thu,  9 May 2024 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715233435; cv=none; b=CDeTifWAMYoIATOEX0QyHIC3GRY+kB2qRBvQ5WrrfP+Jo5lncYENgmi2K4hK4OdHxr0sMu9vcrgbz9nYwSzs5r1SyTDELF7MeJ7XBCgE/wpuUixXncNo2hQgST5JeSCB1QJgNFoMXg7e9FZgGAFd4m7wNbx64ynxK62+PqXH5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715233435; c=relaxed/simple;
	bh=mpoeMUMNma16XJaP4ma+Jr4Gd/AxpWxrZRPZt6gGj/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOo5U1aUwkjsOpfYbsbx5zfjOAvCJQh+znyogG5uvsvRwAp1UlMambesvZfCLOnlXO44QMrmYC+jcGyRYkrzRPcn43AGFjb93HJsDuSQJNCrjNpa3Ax+923ayD4fELZ81HXMYgyx44Gd1MPtBEylNHLuHXmUzTDLIZj0EV+gRc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 509A168BEB; Thu,  9 May 2024 07:43:48 +0200 (CEST)
Date: Thu, 9 May 2024 07:43:47 +0200
From: "hch@lst.de" <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, Zorro Lang <zlang@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Matias Bj??rling <Matias.Bjorling@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@lst.de" <hch@lst.de>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"daeho43@gmail.com" <daeho43@gmail.com>
Subject: Re: [PATCH] generic: add gc stress test
Message-ID: <20240509054347.GA5519@lst.de>
References: <20240415112259.21760-1-hans.holmberg@wdc.com> <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com> <20240416185437.GC11935@frogsfrogsfrogs> <20240417124317.lje5w5hgawy4drkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <eddca2b5-0c15-4060-ba7b-89552de4a45d@wdc.com> <20240417140648.k3drgreciyiozkbq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <edcb31e0-cddb-4458-b45e-34518fbb828d@wdc.com> <20b38963-2994-401c-88f8-0a9d0729a101@wdc.com> <20240508085135.gwo3wiaqwhptdkju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508085135.gwo3wiaqwhptdkju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

[really annoying multi-level full quote snipped]

On Wed, May 08, 2024 at 04:51:35PM +0800, Zorro Lang wrote:
> I remembered you metioned btrfs fails on this test, and I can reproduce it
> on btrfs [1] with general disk. Have you figured out the reason? I don't
> want to give btrfs a test failure suddently without a proper explanation :)
> If it's a case issue, better to fix it for btrfs.

As a rule of thumb, what do we about generally useful tests that fail
on a fs due to fs bugs?  Not adding the test seems a bit counter productive.
Do we need a

_expected_failure $FSTYP

helper to annotate them instead of blocking the test?


