Return-Path: <linux-btrfs+bounces-18155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5476ABFA963
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0919343D70
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187932F9984;
	Wed, 22 Oct 2025 07:34:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FF2F5498;
	Wed, 22 Oct 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118477; cv=none; b=OR6xPE+w8kLmB5mTI6nQvuMXQ+kP/Igz42BboBLUIILi45n0XnT03o8VzULIe8Y0Pz9eAtLXGLWG+nEn3kVcHwSc9mg/hFRLD6zddvC/A6/QX/97Nh5VlLcooStk0qBatBSF1U0y1I33Fup+gCoO3HFie4y6ikUbjG5nAXGTj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118477; c=relaxed/simple;
	bh=eyXJCFDsCkhpZlgqjwhIIX+LFXlOaWVeUNNQR0t27/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEs7j8U07S3kDeuAhgwDMMZRwQsYVc68KAUFWjaJtBBb83zDHHkdcTno0BiYxpnhU9oJor6iZZzR16XT663oAPHWwdiUey3AnRcm+tOPYmOWxA/3LhrhQ0Ajz2HCQHp1kffFUDnxAkTfP8GYIySfjHULUQoomxG6KxF8IPMeENI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 62C1C227A8E; Wed, 22 Oct 2025 09:34:30 +0200 (CEST)
Date: Wed, 22 Oct 2025 09:34:29 +0200
From: hch <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, hch <hch@lst.de>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251022073429.GA7845@lst.de>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com> <20251016152032.654284-4-johannes.thumshirn@wdc.com> <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com> <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <8253d6b9-e98b-4a05-80c0-f255ec32ee38@wdc.com> <16e539fe-b9f0-4645-b135-3930df249eab@wdc.com> <20251021144920.GH3356773@frogsfrogsfrogs> <20251022072442.lnu5d7chvtqn6zuj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022072442.lnu5d7chvtqn6zuj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 22, 2025 at 03:24:42PM +0800, Zorro Lang wrote:
> As this's a generic test case, so there're 2 questions from me:
> 1) Can all FSTYPs (on SCRATCH_MNT) be the underlying fs of a zloop device?

Yes.

> 2) Can all FSTYPs works on zloop device?

No.

> If the 1st question is "yes", but looks like the `_try_mkfs_dev $zloop` restricts the
> FSTYP from being un-localfs (e.g. nfs, cifs, afs, overlay etc:)

Yes, we had this come up before, this test should be limited
to block based file system.  I.e. probably a
_require_block_device on $SCRATCH_DEV even if that's not strictly
speaking the exactly correct check.


