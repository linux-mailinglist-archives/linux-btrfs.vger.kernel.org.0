Return-Path: <linux-btrfs+bounces-15735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F556B1495A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 09:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAFB3A3783
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E4266B72;
	Tue, 29 Jul 2025 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rinE9vv6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612D263F4A;
	Tue, 29 Jul 2025 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775203; cv=none; b=fjK8E+rC5xoroz8PCX8b2+A+JxNuXy0y6MGy08KElEW4Jq4+qXihCf26stZ2Ylw9khONJijh9zCkioZlr8M2c5igDP9NdOod77OIld+y8rmZ2z2947AU2tuwKzCd7evvUGgfgOi0Z0S0UVjgiiV/f3UZIDwxbGOmoLcqQHZC8+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775203; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYbu6Cm7tow6tUOpqV8KwIj1FIVXrQfnApy+0K+wL0OgVSld2CHef5EUrOS8Sgpf0RSxD1/cNYBSFclWN8UOWxenCHEP0hqBVrf1Lu9sJGA6d1+7pWeHjxRfBKCsg5R5hciT/ibThmCaS1UQbm7Beg9ayOLp9XeFdeXOW+Fslt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rinE9vv6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=rinE9vv6jMIYGVe97zFJtk9TV6
	LYO5sTUqYo4FDhYDWATzAfZcNfoIGPm3IRj1U0uY/aOVZIiTQyRRew9NyhQEZL6SWgz99v/Hm0zAH
	BB4/BQB9+ItKHaoTF3xkn0YZShMPscDwTXlbWvy8Svxmsr91ROQUHeGhxIJc55QFvkf578vvHQD67
	X7PjaV0eEPmqcNgxhV4ihgc3V6SSdAagxRZLS9al1g92zkDUTxHcZGCjwkIA/r4YgM+MC70r2z+jQ
	8uZhw69TapGIrUADeS3kP4ZMvGtK7GkOwP46YyyqSr14LepR3PPw2iJPZ1TNFCd/Dw9oOfBWlMks7
	aOo8uUng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugf2o-0000000GAIJ-0oFk;
	Tue, 29 Jul 2025 07:46:42 +0000
Date: Tue, 29 Jul 2025 00:46:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] generic/211: verify if the filesystem being tested
 supports in place writes
Message-ID: <aIh8Yq1HV2jJAWwG@infradead.org>
References: <7ba7d315e60388593ccef0353cff58c4b5795615.1753272216.git.fdmanana@suse.com>
 <16f6bbbb4422cdb2b5ff0b29dc5d7d45ebff5dcf.1753358594.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f6bbbb4422cdb2b5ff0b29dc5d7d45ebff5dcf.1753358594.git.fdmanana@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


