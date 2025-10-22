Return-Path: <linux-btrfs+bounces-18138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB16BF9F46
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 06:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089D8560387
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 04:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B02D6E43;
	Wed, 22 Oct 2025 04:35:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B52877C3;
	Wed, 22 Oct 2025 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107721; cv=none; b=qhvlbbv5XLug6+v1Dmsmbz0fMM0ZCPF8PhJLVZS4GFlePFYTKSkFys/NFGHGF3zrKpdIB9VvFEMgqHX5ZW+vbUBgEOYt0FyfEiUc++Lytgh2qyrNBS/YyFVIXjT6PLEJR238yNTG/YylQPEgK87Nz5eZmN188zsCdk0oUPx0MH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107721; c=relaxed/simple;
	bh=/Faae89lEwvJS4yyi1YA/qsxw/sb+7D3+aqQEVafdhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdPO6aFz9ygtZ/RTVN7HfNh4VoVLTNfpJho7amNuaeY1fSDgLuCUaeLn5psOS04h+w1TRvvOuF6VUOUXfyBOuNSyAd8qRW7bKUkqq0tw1vqnaLY0P0F4coXw+1ijEfnHExxJ0BayHchfwBYvog+uPbczDRoT061ZpQc/hTyaAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85D49227A88; Wed, 22 Oct 2025 06:35:14 +0200 (CEST)
Date: Wed, 22 Oct 2025 06:35:14 +0200
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>,
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
Message-ID: <20251022043514.GB2371@lst.de>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com> <20251016152032.654284-4-johannes.thumshirn@wdc.com> <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com> <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <8253d6b9-e98b-4a05-80c0-f255ec32ee38@wdc.com> <16e539fe-b9f0-4645-b135-3930df249eab@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e539fe-b9f0-4645-b135-3930df249eab@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 21, 2025 at 09:33:05AM +0000, Johannes Thumshirn wrote:
> Should I bring that helper back so all FSes but f2fs, btrfs and xfs are 
> skipped and then still use _try_mkfs so xfs without zoned RT support is 
> skipped?

So that'd we need to hack another place for the next zoned file system?

