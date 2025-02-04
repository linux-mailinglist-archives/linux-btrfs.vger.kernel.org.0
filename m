Return-Path: <linux-btrfs+bounces-11272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C01EA273BF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 15:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EF5164344
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36222135CF;
	Tue,  4 Feb 2025 13:49:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB520DD79;
	Tue,  4 Feb 2025 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676949; cv=none; b=tn/XbjG9tlsNHa/kgMIVJxH3QR81ALrNGeepmNEFTjr/loxvXWlzNsT3/Zu9N4YrAAI+0JWz8noy8X10Tj6nkuwcGXGK7AbZ1WHYubGPc7RG1hNmRSCTPGCTE70DFXAxXxMLJG2aVOg5Ybop21dycq5BkNGA+F0AD2ksfXnBQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676949; c=relaxed/simple;
	bh=S7vAkxtOE9yBZCnA7S1RsSnD5HPre7KO6PV4xtrABWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdCmsukHGKfO8cBVZ0Pg/6M4pmbkOtKeganFhYzLygr8kVEyJy0cQ7AtyPkRUbKY4eVwvLTNeoPXGQEbc91ad1CLqNQPCgGoKVQlVd4TKNiQZCsyC17fI4tgMWputXvYtYSaL5fBoHujPDaTg3WtFtYluwnIR/p8BaJDr0F0X8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2825968D05; Tue,  4 Feb 2025 14:49:02 +0100 (CET)
Date: Tue, 4 Feb 2025 14:49:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250204134901.GA11902@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com> <20250131074424.GA16182@lst.de> <yq17c66kfxs.fsf@ca-mkp.ca.oracle.com> <20250204051208.GG28103@lst.de> <yq15xlpg9tj.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq15xlpg9tj.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 04, 2025 at 07:52:38AM -0500, Martin K. Petersen wrote:
> I have been told that some arrays use it to disable PI when writing the
> RAID parity blocks. I guess that makes sense if the array firmware is
> mixing data and parity blocks in a single write operation. For my test
> tool I just use WRPROTECT=3 to disable checking when writing "bad" PI.

Hmm, why would you disable PI for parity blocks?  But yes, outside of
Linux there might be uses.  Just thinking of a "perfect" format for
our needs.

> >
> > That would also work fine.  NVMe supports 4byte crc32c + 2 byte app tag +
> > 12 byte guard tag / storage tag and 8-byte crc64 + 2 byte app tag + 6
> > byte guard / storage tag, although Linux only supports the latter so far.
> 
> Yep, the CRC32C variant should be easy to wire up. I've thought about
> the storage tag but haven't really come up with a good use case. It's
> essentially the same situation as with the app tag.

Exactly, it's an app tag by other means.


