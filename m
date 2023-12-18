Return-Path: <linux-btrfs+bounces-1004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA8F8165BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 05:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B38A1F21450
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 04:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F7C63A3;
	Mon, 18 Dec 2023 04:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G3yVKWwo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F8566A
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rnl1r2gT3X4Y2iVxedi3hdahWEIAm2dDStbQQiBDYrc=; b=G3yVKWwoOTNJq32X0npIhv3BFt
	hHY3kZHrq+3RBRqSyqiQFOuRQDB8/NnyggNwz4VWuBalfeKWa2AbPCN/QPDBHNkTn1CXU0EgD0QLV
	TejTsRfVhCMcZP2rw+9V72cbBBuBoZCMfbhboBxF65Pki2nDHmqQBmi9yrCmlhZvAwm8Dz0U2QeEg
	TcZ4iVRvRcJDEM6q86oh1pCcAqNM9ZERG2xTh7DG7bCvhVinxGpozrU/iqtuENRSZpAbrAEz6UYTz
	7wOPXcAvkLyH6OpAe7AU1blv6Z5O2EPUf8yCdoAWcjtujUZKMAUPMBAfqbGJx0DH4giFEHqzwiOoF
	m0JaszLQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rF5ZP-0094D4-31;
	Mon, 18 Dec 2023 04:49:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: use the super_block as bdev holder
Date: Mon, 18 Dec 2023 05:49:28 +0100
Message-Id: <20231218044933.706042-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series contains the btrfs parts of the "remove get_super" from June
that managed to get lost.

I've dropped all the reviews from back then as the rebase against the new
mount API conversion led to a lot of non-trivial conflicts.

Josef kindly ran it through the CI farm and provided a fixup based on that.

Diffstat:
 disk-io.c |    4 +--
 super.c   |   71 ++++++++++++++++++++++++++++++++++----------------------------
 volumes.c |   60 +++++++++++++++++++++++++++-------------------------
 volumes.h |    8 ++++--
 4 files changed, 78 insertions(+), 65 deletions(-)

