Return-Path: <linux-btrfs+bounces-8072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CCA97A86E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 22:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8CD1C222AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 20:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EE015C15B;
	Mon, 16 Sep 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IZhTH0NO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155C101EE
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519874; cv=none; b=fVUhcl6LPK7CHaGyIaLoSSsTFxMrdLkKH88Z6lR7PvjlB4ipMizPeLoKlXCArW9IPeknuZyrTiCRaZmi98eI0XCYBHdcHugwpwZavZMK+QXqRyGaW0GDw4gV5OY4pk79fH9/vs2HHF5/TMXz+86/Ol/K88spq6MOjnoqtD20TtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519874; c=relaxed/simple;
	bh=NTrqURj+HlUDp/pZQs03QYGzU8qWKmM2whyjSqxlF5A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kVwDX9rxuKLZhju3yTbtQRyCPpX1v9Nbmisebqi/sAwdeM+L0hvOcJBpJjhOZ/IoIbu5Cu+xPSz9rpWvdDrCFsYL96G5thB1rp+/oOOMdJI9vOzw9Pmka+20EEWI8r0Txdq38PA+YcqlbsgP0Ai9r+zJ4JshL37rQNbGYO3ox9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IZhTH0NO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=6JOBOU1UIYgoNGSAUtO+ptEHb5NWMzc8ICV1CKEPDRs=; b=IZhTH0NOeWQQ98id0ls9p7ayb3
	DHI9bZSO4BES59BWOlXoRxPjnsTvUHgTPFcrTcWS1dqoXe2Ofz5wZZYrBaUUXTe/4ED76q8nUJJ0W
	SpeUGsXU/hT9kHkU2cI6ecaLla15PQO/NRbv6QMe0lLE/DwIgENsWZj9VyN+EhSU7rjbu6xyYGbyy
	PhWigLbqCXLWJDydLV+ikCgbNX2cdiAWTFtaxUv1L2tbXYWhHKyB6aeO28p3yUDKGKdzaik40xAEQ
	cG6O9idPsCTxgY4RTUDXwasRyva3MWL0bmJZ4YxmXAn++dPLScPfvSJqkPljxAbXtULgthw0f6/IL
	hzPFF1Xw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqIge-00000002Mw5-31Os
	for linux-btrfs@vger.kernel.org;
	Mon, 16 Sep 2024 20:51:08 +0000
Date: Mon, 16 Sep 2024 21:51:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-btrfs@vger.kernel.org
Subject: end_bbio_data_read is strange
Message-ID: <ZuiaPA7SaU2Pj75_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was looking at usage of folio_index() in filesystems (none should need
it) and I started looking at end_bbio_data_read().  This function has
some things which don't make sense to me, and I think it's an artefact
of the "block size is page size" code being converted to support multiple
blocks per page without, perhaps, a larger rethink.

The biggest thing that strikes me as strange is the zeroing of the part
of the folio past the EOF.  Most filesystems do this at I/O submission
time when we're still in process context.  btrfs is choosing to do this
at I/O completion time which might well be in hard or soft interrupt
context (and so we're robbing some other process of its timeslice and
possibly hot cache).

There are other things that don't make sense to me, but it may just be
unfamiliarity with how btrfs handles block size < PAGE_SIZE.  This one
seems like a genuine problem that should be fixed by someone with a
greater understanding of the btrfs code base than me.

