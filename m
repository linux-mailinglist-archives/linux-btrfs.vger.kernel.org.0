Return-Path: <linux-btrfs+bounces-13823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B5FAAF355
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 08:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A97E7B4561
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E61202980;
	Thu,  8 May 2025 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VV2kA55A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0E8C1E
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746684404; cv=none; b=b71BLNgVG66p+dzQ4E1owsROMtFkVV+pXZc6GK0zGAsvEQ99cK1SDwB9VmcNMkU/qFNTdSeVB37yyFbrMAXxyYmluCwetEQWJnXdj5PjNvpEa3k3MFl7Gvd+ILQyQWV7cBkIRluzMp0sKxcekGYXPQOoGOUFLRGq8jNm/uMoSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746684404; c=relaxed/simple;
	bh=t0MjqSYY9gKyyPZJWQQP8IE+M9Cw9afFYW2lmLnWcS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gxEy/uZq4O68ULlfj8IAILpTjF4sqyEWYtwcRnKGDCBL7plQ0DmpaB5PN+fNV0DAwaIcsT3uN/R3zIjDj9859DAHZlKmEYzXeqzsIRK1LeAFZFoaPL9C6GGNN9DUvPNRIJjxlO06j/snYGI48fbOzmQ/WPh0G5A8vFcFVZLQVZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VV2kA55A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=l4SSn4rl9nTY8u1Bl53VbD5p9y903Sc2iTntwD6tkHQ=; b=VV2kA55AUJ08ab0aPvxPBlw4NA
	hkRmBgCDiFOVzrpKe/2BtVQvgcJRW/G+0IecVyEpSicd5dwihCIQ/mxT7b9KeQOUyxn4V6HVBsuH3
	maJN4hEYkrX3DVgtusBGfpmQDR0ZTXNGJNr0bVb/H/GkyjhPb6OKvuxivuspV5RzXEI3hstOvSYmo
	ZokT4Fc4o4mrpl8EsY/3YHLDLOPCz4v7j5g/1MuebuNyFsNVMuNdn531ZlFx9T5b5Oc4zv+PKlzrT
	QttCIVhS2v6mQ01dpSOVIOKA/L7abB88z4V+Z3j/grZmjBFlSeTRENfsToghvi7wQ97US+BBTBM2Y
	d2nwukDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCuP4-0000000HQcA-1Bzg;
	Thu, 08 May 2025 06:06:42 +0000
Date: Wed, 7 May 2025 23:06:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chris Mason <clm@fb.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-mm@kvack.org
Subject: What is the point of the wbc->for_kupdate check in btree_writepages
Message-ID: <aBxJ8uBi5Cgz-CPu@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Chris,

you added a wbc->for_kupdate check to btree_writepages that skips the
write in this case in commit 448d640b668d ("Btrfs: Fine tune the btree
writeback exclusion some more") which is not associated without any
information but the subject line.

Do you by any chance remember why it was doing that just for kupdate
and not any other background writeback?  I'm asking because it is one
of only two checks for this in file system code, and the other one
in nfs at least checks for all background writeback and thus makes
some sense to me.



