Return-Path: <linux-btrfs+bounces-17373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DFBB6317
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97728344853
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE7824A06D;
	Fri,  3 Oct 2025 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R+A7V21m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B49168BD
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759477489; cv=none; b=A928rdxawxJ9YyxvOnac8U/fZmmx8v5nHEbw6DdmZqe8Rg7Vy1trh5wsXObvQmBFBXxTMoFdIUct0ZZu4wX5GBEN5/fNS9Vy03UA3gKrwvgpTLnT0W9/Lk8ZHntQTdp4lV6xu9h9BMO5x/DIKUvdMBpK+xvIdCBFX+zAzMRpYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759477489; c=relaxed/simple;
	bh=zqKwVg4TyJQ0VPSRdYLvYYEPcaTseRKiw01RzpN1HWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBYxjJVcTmCMBYYyzi+w7oYaF4rqGQGPzrMewvASCIl3xfIPO61U2hUy5Y/z93OCyp/kkMaQKtV6C2jGAA/5Qv70Wgezw71z9lxgOqoUBjTWI4i3QFQXvW/Sy8b5Scq0BRM/IPjWU2r4wbuaqrqmlxW3IbxMm85C8Mlp8VYIvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R+A7V21m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mlC2HfUdpw7RLVWO6Riy+j8Rit5Id5O1aXFoYUcuHho=; b=R+A7V21mQB8j/Vm5K+iIhtXJ/j
	I0+i12fT71A6bKwYAPVsn3i9K2GqK9fE+2N8bCppJI/0Sq3yUzLXB6/JBvW6nEYI2PkEYExQsDbnF
	GxL+aFtF5zvIzPTIcVnuQtPxr2Qbu6Db4NzoU2I596uusw7uuLagGGr2ewpKtbwjWJEbUHC1HdkPW
	D/lJvVNm/6ZxBrByiaXlvpj9E/jEwqxVPqdlWzFJUpVPS5+MgrdYR68MgF2NW6znnsoBo/VLWu/+5
	tWtUpXA4w94hblFQEJZ/WEtMrg/4eaJ8dyHEKZvwCkhDHa/phIU+B9Ud8VIXuwwfl6RJa/ArNmS7E
	q7XvccdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aT9-0000000BpwS-325H;
	Fri, 03 Oct 2025 07:44:47 +0000
Date: Fri, 3 Oct 2025 00:44:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chris Laprise <tasket@posteo.net>, linux-btrfs@vger.kernel.org
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
Message-ID: <aN9-7wrgxqew1qRI@infradead.org>
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <aNF9xH30pAEq5y4r@infradead.org>
 <38f350b0-9a71-4627-9d36-57bf2f85e67a@gmail.com>
 <aNGFdxq6Xqduoj6w@infradead.org>
 <d14d26ce-3176-4cd4-989e-cdbda30be98e@posteo.net>
 <aNpIKB7cc7lCUy7j@infradead.org>
 <693793db-3431-48b3-8913-aadb86bc4ebc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693793db-3431-48b3-8913-aadb86bc4ebc@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 29, 2025 at 07:55:22PM -0400, Demi Marie Obenour wrote:
> Can two extents have the same offset on disk but different logical contents?
> For XFS that seems impossible unless a realtime device is involved, which
> is not the case here.

Only with the RT device.  But again that is insider knowledge and not an
API exposed to applications.  More importantly the offset can change
underneath without any notice to the application.

> Is it easier if one requires the filesystem to be read-only?  Taking a
> device-mapper snapshot (thin or CoW) before the backup is not too onerous,
> at least if the filesystem is already on an LVM LV.

At least that locks out other changes.  But it is a rather opaque setup.


