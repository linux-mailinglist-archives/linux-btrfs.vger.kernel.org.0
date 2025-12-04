Return-Path: <linux-btrfs+bounces-19517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE05CA31E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 10:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A11A33029F76
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC058338586;
	Thu,  4 Dec 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKLDIdoU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E13314D2;
	Thu,  4 Dec 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842378; cv=none; b=LolhN8DxJ1MFWA9xp4x5w6q8Gsori86XKuf8OEpycDctkYjdksh01nXsV4oMIEoxjkH5Nc/4/6ho/Buig30aj+YZIcdD2TFd7KpQl9uLKrtH7gNWoa8dkxuzk+PVKMLN0KltSt144LY+EcTlZ4PxmaDEpcbqxvMUPgiz70ZJUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842378; c=relaxed/simple;
	bh=bKQ1aSb+kxRbljnBy/GEZgzfWtGnkxP+MuD+2XGeYhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHkixlP9y4yE1z+4voR+/UfqfFzgvSgxtn7Gq+zI5IyyIwfEabluSxu+cgEZdWw2HgUmLtK65b57LP9G7BZWsI3Uenvlks1I3T1GQvZZfr3LOgJUow1ZfW11h9aa2IM+hHBt3W36KEOvzlWZcSWe/2Q9hpM11Ew9fNv8pKmo8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BKLDIdoU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uW1SLGbAr1/8Oln+k28NcAw2m07zsFZY10hIvhWXZOM=; b=BKLDIdoUpaCgKn1hygv8LyXWVL
	KcTUdRqshjeypbVXWksfk6CluU3LC3aswAJClPm10K1HUCIjX95pl4PREaDUy+P96E2fc2RC3zAIn
	l+tDDFPCskLQCQCITcsyAl5pnLf2hn0A2KVHFqAUrY4W/xZ+lB5umghTKBeP6Ho4NzYKvEXUnYyGm
	63lG4yNO9aJvgySRstnx5t4F5TB7SsDHIaLW6TRTiEc1FeYRZzdK7iAxFIBQA9h/HlMhMJvClthTF
	+vLg7TMombo+d/svNLf2YDdKhS4vL2/J9HMvPJlm1eG2oypN/zl2PW0HIocjxzGlGpZXWolOZ1kcT
	qiBTLZgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR67Y-00000007oTF-1TKA;
	Thu, 04 Dec 2025 09:59:32 +0000
Date: Thu, 4 Dec 2025 01:59:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Jani Partanen <jiipee@sotapeli.fi>, clm@fb.com, dsterba@suse.com,
	terrelln@fb.com, herbert@gondor.apana.org.au,
	linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	qat-linux@intel.com, cyan@meta.com, brian.will@intel.com,
	weigang.li@intel.com, senozhatsky@chromium.org
Subject: Re: [RFC PATCH 00/16] btrfs: offload compression to hardware
 accelerators
Message-ID: <aTFbhOZKFy1SfoiH@infradead.org>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <aS6a_ae64D4MvBpW@infradead.org>
 <8d3e44b0-23d8-4493-8e7e-33bbe1d904ef@sotapeli.fi>
 <aS_f9axsi0QmmhiL@infradead.org>
 <aTANwYrQi5MwRyUQ@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTANwYrQi5MwRyUQ@gcabiddu-mobl.ger.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 03, 2025 at 10:15:29AM +0000, Giovanni Cabiddu wrote:
> The compression ratio with QAT-ZLIB-L9 is close to SW-ZSTD-L3 (lower is better).

Oh, right, this makes the numbers looks much better.

> > All the while you significantly complicate the code.
> The changes in BTRFS are about 800 LOC and the core logic is straightforward:
> convert folios to scatterlists and invoke the acomp APIs for offloading
> compression/decompression.

That is quite a bit of code.  Even more so given that we're really
trying to kill the spread of scatterlists.

I think a better argument could be made it we had a generic compression
API that doesn't require structures like the scatterlist and handles
software compression without significant slowdowns.  I.e. something
replacing the btrfs internal method table for the different algorithms.



