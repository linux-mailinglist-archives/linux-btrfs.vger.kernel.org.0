Return-Path: <linux-btrfs+bounces-3503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179C6886299
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 22:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFF1B223DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 21:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2F136655;
	Thu, 21 Mar 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mTOWqbyf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A34A2F;
	Thu, 21 Mar 2024 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057065; cv=none; b=vCw3fd0Y4U+0Cg5fUImanWZ1TeUs9hRGJlSkrS25SZyRzHVPFJt8dQCSQRDZ3vDkRMxdI+ajuWJ8lum2McUYh2o4muZDV96rAVJS6ZFWd+9tP9gDplN/Ti4q7JwStTbZdClwZZcB4M6Afl5isHi5v6EQz/IYFULT9+KQMJqPS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057065; c=relaxed/simple;
	bh=qxdfQprs5xezD6bjFfqzCG4G8LKGmZWmBMHKNYk5V00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4iZDrj2RNKEAZwB/FpvDybw/Q4nYhTO93BwJBn39KcGrK5Vf54yM7a7KMP6aCFndLmEerrMyIaMy1AiexoYAr9vFcGEsrQJPzwdurTAvAintalxfZ0tIAXef5P8UmI3KcFSksHL999SdnRO+DM35kCxOiR0fC4DMkLQ6n2jmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mTOWqbyf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3lxb60Hk9sPzxHoyjJvV7k1kUYMB4iCZEVnxRNB7dnk=; b=mTOWqbyfYXaUffUxIhrCf4KrRc
	QS/axlLxubKFr2w4Bp7eDaGCwd5r06cTUuA99WZL7xrHMUweiECEx/UD+XftMa1tH0DjcRdBXuOTD
	/EJZRz3q4AXlJj/zDEGCBgUAzewop9wpTfuIuc9gHmmEdoCbl4gIj1tobFJfiq5sUS+ue6NHIDOHB
	bJbjQSQ92cwP5nO+pyH1dbHTdhosx1li5rz+Zdm22zJB66h4AYYKlcWppE/bl6JZRC3BoQVtUYnaT
	OvUd374HupWljHbR8SaetImDPvK9YbITYS+6boI/SARvS7IQXlV9JcpZXxMYXT8dzQGDVLsFZIdut
	TbGysS6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnQ6Y-00000004knI-1pmg;
	Thu, 21 Mar 2024 21:37:42 +0000
Date: Thu, 21 Mar 2024 14:37:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/3] fstests: check btrfs profile configs before allowing
 raid56
Message-ID: <Zfyopg6JY9-M7AFA@infradead.org>
References: <cover.1710867187.git.josef@toxicpanda.com>
 <65177ca9d943c043f88d8ea034d1e625af3d0e58.1710867187.git.josef@toxicpanda.com>
 <Zfn8n5jmpTAdzBkK@infradead.org>
 <20240320144019.GB3014929@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320144019.GB3014929@perftesting>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 20, 2024 at 10:40:19AM -0400, Josef Bacik wrote:
> The tests that use this are testing them both.  I could make them optionally
> test one or the other depending on the profile you had set, but I don't think
> this is particularly useful.  If you have strong feelings about it I could
> alternatively add a helper that is
> 
> _require_raid_profile "profile name"
> 
> and then add those to the different tests to be more fine grained about it,
> since technically this helper is about checking if a specific kernel feature is
> available.  Thanks,

That seems a bit more useful, but it looks like others have even
better idea here in the thread, so I'll shut up.


