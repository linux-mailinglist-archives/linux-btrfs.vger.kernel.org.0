Return-Path: <linux-btrfs+bounces-8848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390E6999E2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 09:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBC01F246C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B75209F3B;
	Fri, 11 Oct 2024 07:45:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9BF194C8B
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632721; cv=none; b=kfmCL4pmAR/A0cY6SupAzzDfp46Rpcbh0CTpqP11rUv5pQrZ80G2yGwDTiA6iAEd7JuO/+bNsRO4qEMdCSjHHdvN1zLbIJNdeRq8ZJcLkdsCYBmmBc2/ajaghQtTpyLGsadDzzNC0Ovcz/UnduDY7yuI8AfhFDKWpJvGEr9bfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632721; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfC0J1G2+l4YSz/lOO7qVFUqAoH4wsqwbQfg0sr5ZkWhjvCEx+AXBlQwh3mZpCN2Oi895ZaT1aVyuv/RHGadhf6sYN3h157IUn1zndoRKxbuyQ3L7iXOA+HrHjUBTZVlCvE+mYUUtTZmcESOEnDuLyeD9HMt9nOEQv9ZzjAx4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AD09227AB3; Fri, 11 Oct 2024 09:45:15 +0200 (CEST)
Date: Fri, 11 Oct 2024 09:45:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com, hch@lst.de
Subject: Re: [PATCH v2] btrfs: fix error propagation of split bios
Message-ID: <20241011074514.GA2713@lst.de>
References: <1d4f72f7fee285b2ddf4bf62b0ac0fd89def5417.1728575379.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d4f72f7fee285b2ddf4bf62b0ac0fd89def5417.1728575379.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


