Return-Path: <linux-btrfs+bounces-11439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349EA3378A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 06:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742E73A92B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 05:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E06D2063DB;
	Thu, 13 Feb 2025 05:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OBKJMKJe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6954206F05;
	Thu, 13 Feb 2025 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425799; cv=none; b=AtQUevp1aHs2mc6He4v4F87VuKGiw3dqGZmEcQuaQE4aO9rsNSf1OrNsH0R8Y1EAFtfJAkUZOSGEi7DyxzOt4jAiQa72vdUfmCpYrUN/58lyLmt8EqfwTcEi0rORjItvqqKfYf15hr/5HnjytL66Kn9ejGWxjy8YaQZ2+wi0xKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425799; c=relaxed/simple;
	bh=aTK5VATF++OZ78F6LSTaDZsOYjkDpWS/+3qWodgJS3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgvvgEc8pIVtX2xNywpRJVPUaax1JLM6TJf+KlHLO2+P9OWgdMgs20iGfeu2EV8wPYbweYKT4Mj6ZZ401hTCfLbcV6oY6I+UkvcAhOUzil+FCb6kAHt1jrJvyok33yF1fuTifct75tCazwi6Q6WWscJGmZHd67nebeM/+jaicfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OBKJMKJe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lk7TBzZqvAfCNrl4R7OE8KOuo++lHMcoT34T0q90xw8=; b=OBKJMKJezrY6LhNV4vomv4cSer
	GcuCOmky3ZsMPddPz4m7ma+MpVCyoGr7crA6o62OhqaqQb2fjSzIgtRbHmYVKduvny3VAm8Ch5OFt
	+gRdldtDSPVjycDYZmgWn+CM/gy8PrFvUzIoGYsyfqcsgVkmkp2ENjMik3rW8f6yJuNvT2gEDiDDx
	emyDklA0cd9cxluO74yMXnkgkuZ0kMN9dB2CcSylOleAS+pbZ/qugDCNhoAtB6dGjz92NcRa7/mo/
	9eGQxx6kdJ/F92EedRbtYz1h4jbKLC2UbeQ7fu6k7oynaZmq03OJxGpa25QI2K4lQ6kLTkXMDGUtT
	kBsMA8vA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiS6m-00000009qCu-423N;
	Thu, 13 Feb 2025 05:49:56 +0000
Date: Wed, 12 Feb 2025 21:49:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v3] fstests: add a generic test to verify direct IO
 writes with buffer contents change
Message-ID: <Z62IBLnGOb8C2A1K@infradead.org>
References: <93410edfde1cb0405c133cca49a8291dcdb90e2e.1739329404.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93410edfde1cb0405c133cca49a8291dcdb90e2e.1739329404.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 12, 2025 at 01:34:06PM +1030, Qu Wenruo wrote:
> The test case passes on the following fses:
> - ext4
> - xfs
> - btrfs with "nodatasum" mount option
>   No data checksum to bother.
> 
> - btrfs with default "datasum" mount option and the fix "btrfs: always
>   fallback to buffered write if the inode requires checksum"
>   This makes btrfs to fallback on buffered IO so the contents won't
>   change during writeback of page cache.
> 
> And fails on the following fses:
> 
> - btrfs with default "datasum" mount option and without the fix
>   Expected.

It also fails (as expected) for XFS on a T10-DIF capable device.

The test looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>


