Return-Path: <linux-btrfs+bounces-10186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E719EA935
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 08:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A345618828CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 07:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC79222CBC0;
	Tue, 10 Dec 2024 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aSoBr4Xv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745B9474;
	Tue, 10 Dec 2024 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814201; cv=none; b=Otzcc5DjzKa8FMbmr1USq3DdKnvMLBerCasDdWwbslZqky7/apClM8t9XulPxp+hqQ5kPO6D87Hm18uYzEronNwYlGoSrTyZEsGW03oZ46pyZ8MEO9rHfedbyqpC2DWkzTvH8OF9CUL9OevmSjW6wk2FFPulKr2Vcwd+SiTwuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814201; c=relaxed/simple;
	bh=uaOGly2rVxr+CxihlsfxnAkIl3fZw8yGFS0G8l94cfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B79LEnWH7+VUfroSCzGeKUpq2A4bL8yo9QkHArAxnRZU+DNGSwHFsx2OP582YhsrF1L89z75GUxw4GDx4JQnv5nfffu+dolfTsIXac1TKOrwSKL0RDedMDODItgOoDOao9WMfaiK+87xpiyamskKcpalGRSYPigEY2dmg19KwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aSoBr4Xv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=emWtIo8rib+6VR77iHamATUv3kFYtaYefTxA20NVTt4=; b=aSoBr4Xv1ZzNSYYPvS6F1Rx/9f
	X6HNId6bu6iMJWz4FKeCn6FYo9IHnNXOYU5mLzHWMXfloa39r1gRmYqVEKTOXUlor5X4JapewCJms
	5L6nn7LFWT2ynf4wl4aXb5pn9a/0+lHnb40iKBk2HHrpgnM9nuBhfn+FeI2OLeKL0D79yJR5k1xjz
	BpZpFsWD1wYRI1av2/26+avoqoqEVJ8RI7koCnpfAfVoi6AdMNGr+0gtYL/HdGxMJxKU/iu9kPj3+
	kMvpjJi+uSKHJzQWLZD5P/FeffldcW6ALiNYmZ1xV/HCn3XceKzwArdonGilhX8Vxm7kzYgCgyxbQ
	W228N7Aw==;
Received: from 2a02-8389-2341-5b80-e2a6-542f-4e27-82ec.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e2a6:542f:4e27:82ec] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuH6-0000000AUtP-3YwZ;
	Tue, 10 Dec 2024 07:03:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: run loop device based tests on zoned devices
Date: Tue, 10 Dec 2024 08:03:10 +0100
Message-ID: <20241210070314.1235636-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

currently _require_loop skips zoned devices, which is a bit odd as
loop devices run perfectly fine any file systems.  There is one test
that runs a loop device on top of a block device, so that is excluded
for zoned devices specifically instead.

Note that with this zoned btrfs this now fails btrfs/199, which is a
bit odd as the test only operates on a loopback file that shouldn't
be affected by using a zoned file systems.  It would be great if the
btrfs folks could try to help me to understand why and either skip it
for zoned file systems with a good explanation or skip it.


