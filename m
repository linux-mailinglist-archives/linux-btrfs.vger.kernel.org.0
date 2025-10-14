Return-Path: <linux-btrfs+bounces-17751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ABEBD7424
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 06:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D8704E90EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 04:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3722E3074B3;
	Tue, 14 Oct 2025 04:33:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3A21E0AD;
	Tue, 14 Oct 2025 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416398; cv=none; b=PdFfgkcuBE5iKDbK05mrNniHEoJPhzcocCHJc2ge1yg9milU9hF5i3Dcfn5bV2FMNgIFzg/WOu89Fv2GK38pIWKNIGEQhS5oEqScHjep3bsuSZ2MLraIy7zNODJupQ8Um7tb6f/w3DUQIdy/MaD1p3E/FONlj5Nsxcx/VZdYV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416398; c=relaxed/simple;
	bh=z+5Og1vHAWJn7tLBB4xWtnVFL7zGHFZZPwKtxmFDsaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxYvF14RPYajM9WwXLU4g94meBXqfgWDtBGoV45NToPdDU+aJyoGlIJ4MpFWBnimEBuyjHMA/NbjVGCr3Hjcx5t8MFNBzt97qkLOQWzsWYF1/mQiIOTrKWyEqqebzNp/OLF6eEPH1rSkbO0YwFA2xMju6bSrbm0Ojxq/4DefTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 226B96732A; Tue, 14 Oct 2025 06:33:13 +0200 (CEST)
Date: Tue, 14 Oct 2025 06:33:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v3 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251014043312.GB30741@lst.de>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com> <20251013080759.295348-4-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013080759.295348-4-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 13, 2025 at 10:07:59AM +0200, Johannes Thumshirn wrote:
> +_cleanup()
> +{
> +	if test -b /dev/zloop$ID; then
> +		echo "remove id=$ID" > /dev/zloop-control
> +	fi
> +}

> +mkdir -p "$zloopdir/$ID"
> +mkdir -p $mnt
> +_create_zloop $ID $zloopdir 256 2
> +zloop="/dev/zloop$ID"

To got back to my comments on the first round (sorry, slow to catch up
due to conference travel)+, I would expect most of this to be
in common/zloop helpers, i.e. have a helper that has basically all
the code in the cleanup helper except that it gets passed the ID, and
also have the +mkdir -p "$zloopdir/$ID" indluded in _create_zloop.
And maybe _create_zloop should also return the device name, turning
the above into

zloop=`_create_next_zloop $zloopdir 256 2`

?

