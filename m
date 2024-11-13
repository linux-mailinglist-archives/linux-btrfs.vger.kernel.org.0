Return-Path: <linux-btrfs+bounces-9577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED3B9C6ACB
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 09:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B46285ADA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C034518B497;
	Wed, 13 Nov 2024 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="edEYqKRg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F215696E;
	Wed, 13 Nov 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487553; cv=none; b=r9GxBJMU8iaB+SONxjt+EDmDIXTZa7ADRiQqC/P2rg0AArQtVfR7VECwoiwZt7f7+8dNCTk1e7QQnOlao4mq7VSjLTwxzT4OWpbOU57BwmPh/R/a44t0uCn047D1BDq1QwsSEXCd1SfNCGus/S2XiFI6inbYYyJCb2arym9+cW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487553; c=relaxed/simple;
	bh=LmxLWAkfRShq37/ab2kHA+R5KsyGF7S3vU7xZLo/9ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=db9Cp0fOuwGHi7GWNMspp4U5Pnm/qODUQ1if+DjPjTcqPZ4VDcu85n/InUj7TroEFD3wLWXyIc7JualZ4CGqvbqEU/nrQ57LjcTsGx3+CPxK4zQehT/bY//smNwy7Oqj0FiuisoHCeR1XAwypzZSJQ9ApDwPkLh3D8xdyIOC9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=edEYqKRg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JQmaQ5uAYuQ4/rhwogiet0BbFytWiXBv4CzEK5teRpU=; b=edEYqKRgJzaMdYHjHpkxDbKBav
	EZCHuArRrYt1SdOJuNwM4rYMr0LjltqFopREIkLn3DcAFi+ICM+s80FYAUfKGQnlf8RxeJvaQW0DE
	a9NDa1LzJ0GUpFK1PpHOF+yQe1DIGmivol5jTHLNacyz+6CZpWCZEYfEq6ImNnWn44BEzxKaOLOA8
	fNpbuiJlA3SJ5kiY/2vhFMclGolzLJpbZg6KyFd4FLDIYA7r2VNKnI5BwzHFwWI/sZq6ISBUubeeX
	/4LXuBRmBszmCY57rZt/hbCabPmiyyoLSmeGhIy1l/zBYXmfU8bZR6KPI7ZzU0aUqZDQmDtxiTIH/
	TFv0I6yQ==;
Received: from 2a02-8389-2341-5b80-9e61-c6cf-2f07-a796.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9e61:c6cf:2f07:a796] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tB90T-000000068gg-2Q9E;
	Wed, 13 Nov 2024 08:45:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: validate queue limits in btrfs
Date: Wed, 13 Nov 2024 09:45:34 +0100
Message-ID: <20241113084541.34315-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens, hi btrfs maintainers,

a recent patch from me exposed the fact that btrfs did call the helper
to validate the queue limits, which is also used to fill in precalculated
values.  This series fixes that and is needed to fix a blktests regression
in the current block tree.   I'd thus recommend to merge it through the
block tree ASAP.

