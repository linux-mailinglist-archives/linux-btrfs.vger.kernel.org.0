Return-Path: <linux-btrfs+bounces-18146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD72BFA3DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 08:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3987119A2F66
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 06:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93F32ECEAC;
	Wed, 22 Oct 2025 06:33:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4532D5927;
	Wed, 22 Oct 2025 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114812; cv=none; b=ad+aPhmwlk3gz/sCeuuHyM9I0C+4gttdsAGZt/bbDpYhFuiEpns5Ep3ywR+bE/svP1sW0Xh4HM2WkN8fdYTsKlj9fvKMyI6dOMlj5ZkiFLk54KVWkNAjV9YLiWm69Qfk6eIstnhB5e5cryPfatNPiKsIrm1j90mEn6HSOZhc7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114812; c=relaxed/simple;
	bh=cMQeQrog4sZU6Ks69egByTYxwNdt0DxVEk9F56QI46A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxIPgRSahV8ZFhrY9ktEba9gGAU08szgU0JpQclFYMFUUVm/0+fjIwCtDV05bYWMfU0mvZhqinVfUlLTx74h3HrptKH9+8cn7/7GbHDQHUCjLhpRHGOPbg+G/+L0oRMBDGUahdqrx5Aog9vv2jhmzuy6sSAvJ8psz2Xke06NYDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1CC70227A88; Wed, 22 Oct 2025 08:33:26 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:33:25 +0200
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Zorro Lang <zlang@redhat.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251022063325.GA4874@lst.de>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com> <20251016152032.654284-4-johannes.thumshirn@wdc.com> <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com> <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <8253d6b9-e98b-4a05-80c0-f255ec32ee38@wdc.com> <16e539fe-b9f0-4645-b135-3930df249eab@wdc.com> <20251022043514.GB2371@lst.de> <3c47abbf-1e0f-46d9-b8b9-5edc3d163a49@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c47abbf-1e0f-46d9-b8b9-5edc3d163a49@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 22, 2025 at 06:27:37AM +0000, Johannes Thumshirn wrote:
> Well currently 2 of the 3 filesystems with zoned support tell you if 
> they do. But ok I'll leave it that way, _try_mkfs is the catch all.

You'll still need to check if the userspace programs support it too.


