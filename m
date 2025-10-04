Return-Path: <linux-btrfs+bounces-17428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E035EBB89AF
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 06:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F330A3B764F
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 04:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C4F157A6B;
	Sat,  4 Oct 2025 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1DxS1s5R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402F10F1
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 04:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759553467; cv=none; b=ThqFL+mAVKgJN0xYnx6ddRzyneLlt95NH2HHRNU7qK2Mn0YWPeGXjHKc7doEgKy7N4lYQWtBAh65sswcosa/d6y9nYqhVt7czMzp6qTaxbOrP3jgY7rBYWIML3y5PXSHMd8RFeaoVy1nvy6Cv7KjB76SFJyiB43Jj0xR78HTFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759553467; c=relaxed/simple;
	bh=POiPbzFlT6TwKRgYfWZ9HAeFGsKXHWRjQnBMqpivu4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru/cEGyYq+Y8rZEdgU+m4x21swJBSNi08ocAr3IIsxCoAgbl+zxq3xH8nQMsbLjPXncBLSlj5Ztsme37tmaYtpPkQy4HIk0vtoYPxqyorBGL7iiJ/8lLaWoDED2665wCpfzr/eS71h+kAhGtbGw69VuDipm78YrMXnidL2sxZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1DxS1s5R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+CoaINZ5gxaLZQlYEhdtQwK4i0SV9NJM7HFxmUxmoOY=; b=1DxS1s5R9NWPx90n8WI/XQZOI4
	AF0DIHiONbGoKDJUuMcYHI+pcRL64meBMAFHssfW1v9j6ufFUWc39kUPPA+///nlqCt9oyxGgtSxH
	HY1ItKzB32KJpI/bskhXNTY8C4/ou01JU/GLbtj271sifQl45ZXjssIrPwSPJmsM1ZabB5z56T7oi
	Els/nGqrG3valmHBUeoQYa0i4P/IBrbGZ28zebD6yrKTp/l8A50yu7wPmPcAP3tfPJv3U/ufj2BDT
	PY8IfuqfL4QThOgT76PjFOcnvhDs+Q21dw0X03XXSdL3SZ8Qnb2IuYuTTnCzdQvyJc7C+ZFJke2+P
	WXEkvt7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4uEY-0000000DSus-11pr;
	Sat, 04 Oct 2025 04:51:02 +0000
Date: Fri, 3 Oct 2025 21:51:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chris Laprise <tasket@posteo.net>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
Message-ID: <aOCntgRVT0wz5IJ9@infradead.org>
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <aNF9xH30pAEq5y4r@infradead.org>
 <38f350b0-9a71-4627-9d36-57bf2f85e67a@gmail.com>
 <aNGFdxq6Xqduoj6w@infradead.org>
 <d14d26ce-3176-4cd4-989e-cdbda30be98e@posteo.net>
 <aNpIKB7cc7lCUy7j@infradead.org>
 <c309381f-c39e-4362-a2b2-8d677346f4a6@posteo.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c309381f-c39e-4362-a2b2-8d677346f4a6@posteo.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Oct 04, 2025 at 01:43:32AM +0000, Chris Laprise wrote:
> > > I should clarify that in this application we are not interested in physical
> > > mappings, but the logical representation of data.
> > 
> > And that's not what FIEMAP provides.
> 
> Its actually what FIEMAP provides: the reported 'logical offsets' are
> intra-file offsets mapped to extent addresses which are labeled 'physical'
> (in FIEMAP only) as a historical holdover in Btrfs.  From the "BTRFS: The
> Linux B-Tree Filesystem" paper [1] and developer reference [2]:

FIEMAP is NOT an application tool but a provider out debug output.
The target is supposed to be physical addresses, but as you've
noticed the interpretation varies widely.

If you use it, you will eventually lose data.  DONT do it, and do not
blame the file systems if it eventually happens.  If you want to be
known for a backup tools that loses data, go ahead.  But don't blame it
on anyone else.

And please, don't give me a reading on FIEMAP.  I've been involved with
it from the very beginning.  Reading out the documentation feels rather
patronizing.


