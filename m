Return-Path: <linux-btrfs+bounces-9311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A78A9BAC82
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 07:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF831C20F03
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 06:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027CD18D62D;
	Mon,  4 Nov 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vVDWu8Bw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52318C012;
	Mon,  4 Nov 2024 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701615; cv=none; b=ARQB3t7jBt9lMHhO6Ky3aqIWvatrf+xKp16qsVU/AQyCjFZCNZuod4CBSrmAoDnWdxQjqPBF7noYVimHhaMXUdRLsAYplKrSAiydmzOA4SjI6mnqjdESvPYc+1XSBFZ13cDIZIKsveCmM+p5jhZpMVpX/9NFFIL1J/BrSUXGBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701615; c=relaxed/simple;
	bh=uB6Tb68/YkQdGS+WetAS61Ae4STLJG3fbVfKT0Scgno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+mHkIYYPaHwudjb8Q9EyPzsVV9SeXwfa0qMQs1RR9GlKrB9CNKO7vwVFhgfT/V/l+tQ3Ovk9qhIJ6ntUClKGyVzXUdBKw+mvHG3xMDbZVjf9T4GxxEjnCFa7HJkHOa+GqRtsMabs4ukZgrkKzVRlGQC+dfHulXyRNKS0XG3Pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vVDWu8Bw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=uB6Tb68/YkQdGS+WetAS61Ae4STLJG3fbVfKT0Scgno=; b=vVDWu8BwCr+OcOncXTLJupvqDB
	3mygsA7yPNlwOIfHNwlK3u7LCS+FO0B0qXVQhFdtlNfpGJAwKZejswj+dxgE5azMWKOpG6faM93N9
	hZyWPmjux/6cIUsDY1NI3/unYbtQBoYec+t6aYuZOj3aYwD+ulWQ9Yfj1x9m2s/+naYHbV0aVA34q
	GmMHutYe2wA67HEtFbqZ0Gtnx7rWomB2e3ATB5ehI4KX1maLvGMh2Qfa51E2m0cyDyLHwR9Qgyv6E
	fs18vDQsJNEQhDzvnTwuoLP5/S1cC0x9PXPAzc4fCbJMKqsOOesF6E7RrRLbOJQalK1DNEzIHz93Z
	SGICL+pQ==;
Received: from 2a02-8389-2341-5b80-c843-e027-3367-36ce.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c843:e027:3367:36ce] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7qY5-0000000Cl21-3UAB;
	Mon, 04 Nov 2024 06:26:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: fix a few zoned append issues v2 (now with Ccs)
Date: Mon,  4 Nov 2024 07:26:28 +0100
Message-ID: <20241104062647.91160-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens, hi Damien, hi btrfs maintainers,

(sorry for the third resend, I finally debugged why git-send-email dropped
the Cc to the lists)

this fixes a few issues found with zoned xfs testing that affect block
layer interfaces used by file systems, and the btrfs code making use
of them.

Changes since v1:
 - don't apply the zone_write_boundary to reads
 - add another patch to fix write_zeroes

