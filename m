Return-Path: <linux-btrfs+bounces-17805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02008BDC6D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 06:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E92189B70F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 04:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65F2EB844;
	Wed, 15 Oct 2025 04:10:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9941C5496;
	Wed, 15 Oct 2025 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501418; cv=none; b=BfNM3KjcoieAacNAPGqHTvOfCRScyZHSgE2lZWBER+gZu75+QtycS8ZIE8fIOJ42f/fdqpZ0amU/7XQtkBCthyK17B26eYSpKiawzwjxwpUzDHZPvUCb8gRRXaXO2e30ceeU6hlHudvZQNQtRfSfZ4BuVprY4pApVxOAFvIBq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501418; c=relaxed/simple;
	bh=IlmN5mWzJFaHy3mBtl9MtyiUGnBk2SDeWe3O1+6seRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw5AMOPkyAKIf61Natb03leijuQzzVID9ZNsx5RwPAxI5RCLg4CThsb0HyZABVoxauRnnitWlgHo5wnhEQzEfqH5TXJ+I3OJ6ymXRNcYBjkE4j0LSIflkOtH5BJYRW3C53JRCsC8DVOQ9wkPpVIVfGGCyfdsOqndgX7Ee4cz0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8415D227A88; Wed, 15 Oct 2025 06:10:13 +0200 (CEST)
Date: Wed, 15 Oct 2025 06:10:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v4 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251015041013.GC6880@lst.de>
References: <20251014084625.422974-1-johannes.thumshirn@wdc.com> <20251014084625.422974-4-johannes.thumshirn@wdc.com> <20251014210253.GC6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014210253.GC6188@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 14, 2025 at 02:02:53PM -0700, Darrick J. Wong wrote:
> > +_cleanup()
> > +{
> > +	if test -b "$zloop"; then
> > +		ID=$(echo $zloop | grep -oE '[0-9]+$')
> > +		echo "remove id=$ID" > /dev/zloop-control
> 
> Probably ought to be a teardown helper ^^
> 
> _destroy_zloop() {
> 	local zloop="$1"
> 
> 	test -b "$zloop" || return
> 	local id=$(echo $zloop | grep -oE '[0-9]+$')
> 
> 	echo "remove id=$id" > /dev/zloop-control
> }
> 
> Then everyone's cleanups can become:

Yes, that's actually something I asked for in the review for the last
version.


