Return-Path: <linux-btrfs+bounces-11262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3620BA26B3A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 06:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EDB3A53D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 05:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AEE1AA782;
	Tue,  4 Feb 2025 05:12:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B712D758;
	Tue,  4 Feb 2025 05:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738645937; cv=none; b=MfcRXdJWF6+lLLKfN9a5XHm9p0+ozXjfToTOKWad0ij6N2wCk72fux7vy057Xb73WuEAYaMkUCOqM6ajJZ5WO1RaDNp/lVo7odKLLrLKJYAKdwko2GyMDdmdNARLMMhzHCdTIWqHlmFExnHPKhrSZ31O1RMP9g2LJzpZnQOXoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738645937; c=relaxed/simple;
	bh=1L+Z81WayhZk/cFtAsdZO0aI4Qela1jUgmtsvzY7Bjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvxLJluIIDTS8ARvp8KRahBXlspJQCLav1B4ksPzFFECRMQr32UakZ7GJ3BBUUDR/I0nWiE3dB6nPU5mthR2eUCp9//HlQKPVDsW470cpUZHfY3KlskIW9rqf4bpNglwD/oCYn4tZsNJRIGrqNFnvsTFyiUOFBIJxUqxkn1UlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6583668AFE; Tue,  4 Feb 2025 06:12:08 +0100 (CET)
Date: Tue, 4 Feb 2025 06:12:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250204051208.GG28103@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com> <20250131074424.GA16182@lst.de> <yq17c66kfxs.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq17c66kfxs.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 03, 2025 at 02:31:13PM -0500, Martin K. Petersen wrote:
> > I never could come up with a good use of the app_tag for file systems,
> > so not wasting space for that is actually a good thing.
> 
> I wish we could just do 4 bytes of CRC32C + 4 bytes of ref tag. I think
> that would be a reasonable compromise between space and utility.

Agreed.

> But we
> can't do that because of the app tag escape. We're essentially wasting 2
> bytes per block to store a single bit flag.

Well, what do we actually need the app tag escape for except for
historical precedence?  In NVMe the app tag escape is an option for
deallocated blocks, but it's only one of the options, there other beeing
a synthetic guard/ref tag with the expected value.

> In general I think 4096+16 is a reasonable format going forward. With
> either CRC32C or CRC64 plus full LBA as ref tag.

That would also work fine.  NVMe supports 4byte crc32c + 2 byte app tag +
12 byte guard tag / storage tag and 8-byte crc64 + 2 byte app tag + 6
byte guard / storage tag, although Linux only supports the latter so far.

