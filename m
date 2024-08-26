Return-Path: <linux-btrfs+bounces-7515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70F95F841
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 19:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2957B283B0C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EDF198A35;
	Mon, 26 Aug 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jiJVXq1+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160334D8BB;
	Mon, 26 Aug 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693909; cv=none; b=jNW8+790cFtSVi5uszfU+tMog+PnBr/wsZ3GWbDV/ffJYSfk9jSbeNDPR3Rmyb+PBKsufIMRMm6GFRmuwyKgfJjSCUB5XPI8Z5rZvw2mhBfMi4mDKv8YxFe/U3pmR0lut6fNsgiYdf9jXSrL4T21taUI4yBTI/Rh2vHKNXI+h4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693909; c=relaxed/simple;
	bh=GXMt/y4VhRvgHBnL3dEzVGhWuTEGKE0/B97uItfaIVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pG4SUYGl6nSSn8wqk5rKbXI96l2uE2Aph8JeSGSpm/mpgH5dTMPCrmjn3N28wdWvW1kI3LXT/LI9CQG84RLsUA2SN8Av8oltixff80OA/d34iY26DF86cRF40DoH5Hehqxm2yfqN1uEEPItqo9ndet++V0w08KT2nzz+oxgrgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jiJVXq1+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gqoW+iGUYB4hizD/QVZ/oFJyQw57sCqGaKoaykSjMdw=; b=jiJVXq1+65fJhLhgfs6qJ089hl
	uKSpON1SjWfnbaVudTF4MDkxDTIBfCUeejnuBxgIp+rYju7u+OSpMwqSmG6I6qQAaIquLHQZlnHJ3
	YUgmiGXvCztVzFUbqnnB8oN/cAJ+vTjnKrpJWfyiGMLLQ2GjKeB17qS/ex5Lh4bshmMy1Hq56bQW+
	7pJwuUG14CpVDn+ko1QFp2NjkH3nbs00RW5nN1ChtuIOYjUV8PNLmSkIyWBEAK0EIFSJHsB0Ny4tc
	TLni8gS13rTQkmksQMIAxlS9ws2djS6pGtE7VZ0Cpr9qA6X1KQniA+0ABEs4RiPhdEY0F8+QZSKkm
	RyQUD5ww==;
Received: from 2a02-8389-2341-5b80-a8a7-5c16-efec-d7f9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a8a7:5c16:efec:d7f9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sidfc-00000008Fu6-2g6J;
	Mon, 26 Aug 2024 17:38:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: fix unintentional splitting of zone append bios
Date: Mon, 26 Aug 2024 19:37:53 +0200
Message-ID: <20240826173820.1690925-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series fixes code that incorrectly splits of zoned append bios due
to checking for a wrong max_sectors limit.  A big part of the cause is
that the bio splitting code is a bit of a mess and full of landmines, so
I fixed this as well.

To hit this bug a submitter needs to submit a bio larger than max_sectors
of device, but smaller than max_hw_sectors.  So far the only thing that
reproduces it is my not yet upstream zoned XFS code, but in theory this
could affect every submitter of zone append bios.

Diffstat:
 block/blk-merge.c      |  162 ++++++++++++++++++++++---------------------------
 block/blk-mq.c         |   11 +--
 block/blk.h            |   70 +++++++++++++++------
 fs/btrfs/bio.c         |   30 +++++----
 include/linux/bio.h    |    4 -
 include/linux/blkdev.h |    3 
 6 files changed, 153 insertions(+), 127 deletions(-)

