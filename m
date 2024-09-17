Return-Path: <linux-btrfs+bounces-8081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3734E97B0BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 15:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5151F242D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF571741C9;
	Tue, 17 Sep 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XuQEjgU9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E54C66
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579636; cv=none; b=kyaZbzz1UqD17nHKlwU056trRl/jpyBTYKXcLXBgAfbXn60hih0sJStTSQbjHygGyKCFR+gzpN0SnizCCGb2LoVkZvkcRi4FQRjRAMN2KKoRzIrRV+qP3WdJA+Ua14C1CtwDGLcSpP7M2n+EguT3ca3XqVGefIEXb+t91p8yoig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579636; c=relaxed/simple;
	bh=ZhmMNCm6yVvR1EpftpZI/atOcw0JgqkYhgHwdBlLcl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYA9+v5XBV4iJrfdYm3T43szVDkksJ02vR0lY+cHRqUOlF/6ZPurR9eGPKip/n+hwjMfbYDF6e12aP6T+asvTFCf2r6cApn1ZwUbIjszGJC263mVPcsqG3sMZ6zJwx5/n6MG1QkcylOnpGJSfx2ppLmfj6hHgfSffRc4/A/SFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XuQEjgU9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1o3YEa0y/ax2JdRioHvfEXPpDoMkbUHecb9n8ZkP4/c=; b=XuQEjgU9AMsAE5qZgPBZk/2/rT
	sRXSR8q9Qg4G0G4TU0wQ1qifNt49VJEdEXtsMhzk1fbeHZtujZlp4MlpEEQMSXX/fGGh1PHN4jcg3
	lsy+pp+EyVDIfH5Ll4tNboeGuhCooXpJRulj+ONt4LW/TjyQaGm4ajn9WdIWBMB+/sw1YPQB3HKVe
	cJm+Ikq8Fulcw2Baiy6XmNH85hCT0kq0F+VtZM1MzSWJ7pXA340IDVAF9vJjN3pa1wGLg9WlWqEws
	OQ6JgSNCNE9wYgNnzuB/Vg0R8IyUxHN4Fo/5GzoklUhXQDGwu/ghVGLsUnUvR8jk5oa0wfUmHPvOT
	aKNjBjwg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqYEb-00000003BL2-2Tgm;
	Tue, 17 Sep 2024 13:27:13 +0000
Date: Tue, 17 Sep 2024 14:27:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: end_bbio_data_read is strange
Message-ID: <ZumDsRGoCTE-rTEN@casper.infradead.org>
References: <ZuiaPA7SaU2Pj75_@casper.infradead.org>
 <872a799c-0ac1-4ef0-bedd-1b0f6f0403cc@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <872a799c-0ac1-4ef0-bedd-1b0f6f0403cc@gmx.com>

On Tue, Sep 17, 2024 at 07:14:57AM +0930, Qu Wenruo wrote:
> 在 2024/9/17 06:21, Matthew Wilcox 写道:
> > I was looking at usage of folio_index() in filesystems (none should need
> > it) and I started looking at end_bbio_data_read().
> 
> I thought folio_index() is no different than folio_pos(), or it has
> something we should know but didn't?

I put a lot of effort into writing documentation.  Why do you not read
it?  This isn't the first time you've insisted on a personal explanation
of something that I'd previously documented, and I don't appreciate it.


