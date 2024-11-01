Return-Path: <linux-btrfs+bounces-9280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8779B8A5F
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4671F2299A
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D78149DF7;
	Fri,  1 Nov 2024 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZubWK61t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176329CA;
	Fri,  1 Nov 2024 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730438538; cv=none; b=W+the6dYPlh0dnYfNjRV3T4PyGCfkQfj/4vxaOpptBIMx4Wy1kS2fGzKhiAvJgUnI2HXNpGCnyTsAUNmyexc3Vy+FQry/b3Fmyx430gMgtvnbHET7VEDO0sZzdv9p3uHecH9r/rjzS2omFFDAIFzCJOYcD5fHuGFh7FUyA+ensY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730438538; c=relaxed/simple;
	bh=V+eFzDKq9RKGR/ZXdPb5tuI4SL75F6O6c6HS6dY+Olg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VN7Elj4sOtXcpflxsTXXWJR+XqZjooOLSDi/8YyEnjCtKycx1FkOS1Vmh/Tj5TQ2VhETOXMME51LhSbqomM/1EbmKQ3tH/KODrPR+rywUv+sicBOqOh7co2N1fH8Rxq11xfMhlv0BluIqK1cXd7GmxmEoigMkkS/aE3qQugPQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZubWK61t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=V+eFzDKq9RKGR/ZXdPb5tuI4SL75F6O6c6HS6dY+Olg=; b=ZubWK61tcIpEP1byOGU3OZHrHc
	UpDz0lTYhsdxaSOKm1VxgIZz8xZeHIwTpSH8WRElAqzlVO39x7Q3diNzoaC80anMB21Ufkr0Jm74M
	SYj7V2gWAKm+bBHuZc7Xxg0T5YNUlNQVax+WrV/vZENr+tZsbeUqFSgh8JgtJ8Gr6QcslVQzU/2Nq
	gRwlUUzb7AMpfbVRqgyOrqGC/uZ/LnDO/XQRYOhIabQvftbpPuX4t91/ztg+hvu2Qf3H4+mQbeZoA
	3xacItvNXrGItaxAEA60Q15HvrgyM+PyDRyN7/tqrONGkP/Ta41qLFBmJydLgPAQPc7xw5kE9XOt5
	D9ZnIzCg==;
Received: from 2a02-8389-2341-5b80-5ae8-ad80-e9c6-3f1e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ae8:ad80:e9c6:3f1e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6k6q-00000005pGX-2eV7;
	Fri, 01 Nov 2024 05:22:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: fix a few zoned append issues
Date: Fri,  1 Nov 2024 06:21:43 +0100
Message-ID: <20241101052206.437530-1-hch@lst.de>
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

this fixes a few issues found with zoned xfs testing that affect block
layer interfaces used by file systems, and the btrfs code making use
of them.

