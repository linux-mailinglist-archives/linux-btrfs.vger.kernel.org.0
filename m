Return-Path: <linux-btrfs+bounces-12913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BACA82327
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 13:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0F44C1E4C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9B425D537;
	Wed,  9 Apr 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YqO4vEEG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88D2459FB
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197061; cv=none; b=vC25FVSYHneEMbAP1zLxGjAcSoP2cJeI+iIyRjRIbgdfDHOwN1/eX9uCDoR6rpCCRlp+6zpL3QpIA4lXMgey+1MUsiWc/GGbYsv1HLME2PDG0670BaqiU/yv7mzphKn+d1NzTrgekyFU05zT2s5vx7FDGgVqcV0ihUp6546GYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197061; c=relaxed/simple;
	bh=wJNuZjMqteP9LK74V8laA28JzwvO1eYXLm19zgkHh6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAevI9h7qErSGy6CJjD78Q7T/gsED3s+i9tTDotBOfibWYFfNRcmQqSWvGGrboHM00UM4Ncm/7vFSCFjLAgqQYOa5XdztkEjvRBxDIfXl19ZjegcS6kchUUD4Vojmqr5fVSa+oskBeLV8TL05V8uVC/wFCYh+daoZl5p7yQdQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YqO4vEEG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CELUKF2DkIY8AGm5uxJL6cST+s99Vc3UY2Aa9DGhiiE=; b=YqO4vEEG7p1srl7EZrhJFd2LTU
	ZbwzVgp6QKKj0d6nfNnmshzJUescaUWwB9r8HO7K51CO14g63RQOtTCyeikzFH6hb9DiyQ+HS9FKe
	+WksmIyosWkHm59N+CwUsADag3CDZxAKDUjxEVvIEO36ARcvLD6d8NZw1+ta/YzAE4Axy7wVZmrUA
	/eZOPKxFG2n3YJhVI3MNkVG2+sH5fhETpvXVLPLvcJ4uL0k1zkg7io0lo2hkheJyjo/JbqoMGGZx1
	pQoYTw9iKzj2xLlT07RCKguAaq+IkQd2q01OmO/AR9DPZ1wX+MzBIgf6SDtCD/XsTmwxpO2KIRok8
	XuJjptQw==;
Received: from 2a02-8389-2341-5b80-08b8-afb4-7bb0-fe1c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8b8:afb4:7bb0:fe1c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TKc-00000006x24-3HkP;
	Wed, 09 Apr 2025 11:10:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: RFC: (almost) stop poking into bvec internals in btrfs
Date: Wed,  9 Apr 2025 13:10:34 +0200
Message-ID: <20250409111055.3640328-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Qu,

as you asked for patches to clean up the btrfs poking into bvec
internals, this series does an almost complete sweep.  The only bit
left is the page address in the decompression helper.  I though it
should be able to be replaced with logic based on bbio->file_offset,
but that leads to crashed and data corruption and I ran out of the
time I could allocate to this.

This passes a quick xfstests run with and without -o compress, but
otherwise should be taken as RFC quality code.  Maybe you can take
up the bits you like for your folios work?

Diffstat:
 bio.c         |    9 +-
 bio.h         |    3 
 btrfs_inode.h |    4 -
 compression.c |    9 +-
 disk-io.c     |    7 +-
 extent_io.c   |   60 ++++--------------
 inode.c       |   18 ++---
 raid56.c      |  193 ++++++++++++++++++++++------------------------------------
 scrub.c       |   80 +++++++-----------------
 9 files changed, 142 insertions(+), 241 deletions(-)

