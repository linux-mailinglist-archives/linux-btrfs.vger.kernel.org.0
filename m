Return-Path: <linux-btrfs+bounces-17804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD3BDC6C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 06:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D66406763
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 04:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836E32EAB64;
	Wed, 15 Oct 2025 04:09:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71A1C5496;
	Wed, 15 Oct 2025 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501358; cv=none; b=JGRYHJuGybKTOdGbSD9H9idRS2laJCgsseY1YDmmtcpH28B2yApMOicSGnh+3xtu/aa6vP/wtvJ/Hj+Jv17UgKVTLKR3A/yVm41tFffv722eNCLZL5kALDQlcloA0ZfGAwUaL2DnxnYfDNiiWpn7AtBID1pByEKnL7WngjHk6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501358; c=relaxed/simple;
	bh=mwZ2iZsUxn3Weur1JnxwK6Yofr+e6e1jCQsnmp1x0Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPXPQsWlvoV4aI8m+PlNQwqcyZ8CYkyEsGztiOarpSAbki3o2gRyh5hrkorsDOIeD+JOoe7WYDbB1U5tRQvG3UOG651KFK9SHpf1R4QlawlEgpipWza7mtiPfR2GStQvvu6bIDLIpmTLnaIEq0kfRG0qhYH2PVjJZhuT2CDocp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 93E9D227A87; Wed, 15 Oct 2025 06:09:12 +0200 (CEST)
Date: Wed, 15 Oct 2025 06:09:12 +0200
From: hch <hch@lst.de>
To: Anand Jain <anajain.sg@gmail.com>
Cc: hch <hch@lst.de>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Zorro Lang <zlang@redhat.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v3 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251015040912.GB6880@lst.de>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com> <20251013080759.295348-4-johannes.thumshirn@wdc.com> <006ae40b-b2e6-441a-b2d3-296d1e166787@gmail.com> <4eeb481f-b94d-4c2f-909e-7c29ac2440b2@wdc.com> <97aece25-d146-4447-9756-f537acadace1@gmail.com> <20251014043000.GA30741@lst.de> <fb51de17-1d18-4763-8eb4-454e6e6f55d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb51de17-1d18-4763-8eb4-454e6e6f55d9@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 14, 2025 at 10:38:55PM +0800, Anand Jain wrote:
> Right now (v3) the errors are going to stdout instead
> of $seqres.full. I was thinking it'd be cleaner if they
> went to $seqres.full instead.
>
> Now:
>   _try_mkfs_dev $zloop 2>&1 >> $seqres.full ||
>
> Suggested:
>   _try_mkfs_dev $zloop >> $seqres.full 2>&1 ||
>
> Best. Anand

Yes, that makes sense.  Sorry for being so dense.

