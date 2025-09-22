Return-Path: <linux-btrfs+bounces-17091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFD9B92646
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5AE7A2AC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3E931352B;
	Mon, 22 Sep 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JSHWbUdS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B3122A813
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561657; cv=none; b=qHG6uueSnDSipnO8XsmD6TxJI15KM1i9OAYAyInPj1uOTZgfEqRGiVZ8lNXso0tCZorY8pb/EU3amNBU/mEEhXCkmn6cPPnMf2396vAxGSbzSOu3G/zemPuVbyrOZj8So7soKaDrLpsBMwzjIc15GCrBt6Nm0Oa6TmGTOVuKFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561657; c=relaxed/simple;
	bh=1liFhTO2+Ef51eluIvg5LOTXvTvmUZTypWiNv6m2vOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK+8FzPL6nQX3ImVmskjjkHjJOs/DDUHH9TfmpkL1dLvSPB3Xc/La5HHwvcTNeblhozJVENL4O5ihODDjqeSxtQZK9mBZjJTKffDqjGCpygzlpsCM2F7rWFKrIMpk+2XYRL/L+2r65DwYTGLmNdZuLljCBtzaaks90gtHzJJNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JSHWbUdS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZUqYeyVCAhhyrM17pHdpamEteiDug+p2Bn/wU9XYNrU=; b=JSHWbUdS/3Ky/exr64mSfHrKwL
	dkB8RmDt9ZDfqNR+z9VRooU0/xB+Dz63oTzmVmj3qs7GKRIvldeJGajBhhRl8psGhvHSXwPtRzIDq
	85yuP1lm4+69YJqcD+zaGOBkDrBq5g8+57eDpJDMcMxWDio6cIkGnCebUq7x1eRk0OUGPKGhhKv6r
	Tmxt0hvABQkGCY+hmlh9CCKB4J9n3lUYw8heWBGg4Ukb9qVLKm7AafvGNeRnOBRXx/lLx0pi9lmN2
	B2plyXmLfhwugDswFsM79HYgSfB+b6AqtxfyqB1fzG4VzbQpDMPOP/pLr0NSkQyekKKyRMIHpaEC+
	1rOLdK4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kDf-0000000B6H6-2H4v;
	Mon, 22 Sep 2025 17:20:55 +0000
Date: Mon, 22 Sep 2025 10:20:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
Message-ID: <aNGFdxq6Xqduoj6w@infradead.org>
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <aNF9xH30pAEq5y4r@infradead.org>
 <38f350b0-9a71-4627-9d36-57bf2f85e67a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f350b0-9a71-4627-9d36-57bf2f85e67a@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 22, 2025 at 01:18:52PM -0400, Demi Marie Obenour wrote:
> Is it safe on XFS if there is no RT device and both files have been
> fsync'd and are not modified by userspace?  I believe this is the case
> here: reflinks are used to snapshot the files before they are looked at.

No.  Yo ucan still have defragementation or garbage collection going on
underneath.


