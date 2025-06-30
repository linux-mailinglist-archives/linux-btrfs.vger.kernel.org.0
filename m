Return-Path: <linux-btrfs+bounces-15109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93834AEDFBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 15:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3603179841
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591A28B7C7;
	Mon, 30 Jun 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oR+HyGaQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC16286D70
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291842; cv=none; b=LKxKc8rQmBH1ewVjxK+6IFHjaA2+Pt+i5x4Zh58jAMwYxNbHJ06rQk0eYwYacj2zwJdFRz6vK8h4PIBpDMOVTzWxHuGNH3XwvaMrjDxkADKhbT78bbAokG7QLPV2x6aOd+oH09FwJTd1ie6Du79k7ke/nJV+SeZ/y0PKJCT3Y80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291842; c=relaxed/simple;
	bh=HLZLPft7i9xPhZ77hHlDJEGcvqwuTVriMQuEZRpqkyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1MzfDF42B3UVYU6MVRH5cEWEXYr0SsMrSg5EFecx0bqfxN7KDgEsrbxHbFkW0RovwAA8f+vveIC/KYmsYIM/wv8YI9MxPtVMpHzcE3n6Pd8Rw9aLl92kZM9zFlAP2kUPo/uci8u7UKGbulBSawHAi6f+eZvU9Z1a5KALUQuWF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oR+HyGaQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h3gbbuOgJEHgEmYnImCOmBJG4jeDCyJls3ESX5/PpeY=; b=oR+HyGaQILkcqaHCT5XwAlvhcE
	h/WQQxfCvHkVuniP82tzYHmOfvvQDTxGWSci8sOJ9RD4u0pPvSl6lJWpNOirDLCI0ndkmVvguWkF1
	59j1sW0PNfRgJiFbHtoQLem1ugUdHNzx7tcUN67BZUp5bVB3FhOcrGszTATl7SBlclhyjV7jpiGCj
	tUJDS3M/qYooE0vmNnAegq2pFwhYwA6szkTuwwqO1S4lttDzLiWaYnnRUXYFguVVGOqn7eMgM8fuy
	C3UJP0Xt3GSvYNT7mJmw0ynR/uYycLxj8xpJJRHJSMqkOPz3dQIzS+0c+15JGGRrxprB3fHi2VRs0
	X3w9dEug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWF0a-00000002SWR-0qqm;
	Mon, 30 Jun 2025 13:57:20 +0000
Date: Mon, 30 Jun 2025 06:57:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mark Harmstone <mark@harmstone.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
	framstag@rus.uni-stuttgart.de
Subject: Re: restic backup with btrfs /
Message-ID: <aGKXwNaNgWM24KHh@infradead.org>
References: <20250628173308.GB847325@tik.uni-stuttgart.de>
 <82b6ddab-0eef-47b8-8010-9b09fcb70444@harmstone.com>
 <aGKT8dcPQjhyWu8m@infradead.org>
 <5b928de3-579a-402d-bb75-e93b473de929@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b928de3-579a-402d-bb75-e93b473de929@harmstone.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 30, 2025 at 02:53:23PM +0100, Mark Harmstone wrote:
> > .. because it isn't.  btrfs is the buggy one here breaking the old
> > Unix tradition also (somewhat vaguely) encoded in Posix that st_dev must
> > not changed except at a mount point.
> 
> I know. But if POSIX assumes that every inode has a unique combination of
> st_dev and st_ino, and that both are 64 bits, that's incompatible with the
> design of btrfs.

I know, we had a few discussions on that.

