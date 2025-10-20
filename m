Return-Path: <linux-btrfs+bounces-18026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E32BEF85C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 08:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBCB189B0B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 06:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C032DA762;
	Mon, 20 Oct 2025 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mpbs9/HX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6019F464
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943205; cv=none; b=hyAFFJPdzxnuArZgJyGg9FeB9wNlsxE4AUpVJW3K5iAxQWJQSHtwQC33NB7Kc25lIkoZlL1MZOzbEHdbao/9+XUygXSI/e1Jz1eM6p8ZWEqMZF74Z2ACaMeTZG/uNTbA2yBv1WSXNNhbb7aSdCZboCcMj8/Vl9wnJ6FcvHJDHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943205; c=relaxed/simple;
	bh=riGPSYpnHjbgDhq/7kR0wu3eYDCuTajXkaiCE92fHfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFA2145G4O3Y+4CvVYA3AfOqxb66oR2ZsQYYdfvzLWPThYYM0EJeQUrxFQVm84yycEWHIGsrXd2nbalViWQf+CvgQS9YVpiFvcBgk902ZA66A2l9U5Y2XVkc30irAllatZvx/1qYpCE07AJHAQeYrUmG7cQ2oAKTB9sapRL+Ryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mpbs9/HX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ut8SGcGArPd2pj7kcA3HFoanQUUq1wau0S0f3/DZTQw=; b=mpbs9/HX8ggjRYd49Iu228J9x0
	UlUrjoWFEI+bSpq7l8gecDO7NSupH6LpyEeEP4PVkojjCzs+tsH1GgKbm3qzaBt4i3FCQEqA/NPjh
	b9y6glZ6pQ9h95L9xchr/jhM429Y3yRki76q/uNMXm+kNBz91Q2zl9F4l+cfotlzR092c5qCpwt7C
	ZZsVE7IiUJWg+RCHzOn38NG3o9J5shi0UyKZPW1QbMKHVXHqQlubwJw/9GzmEgM4hTPpc5dUuLC47
	xTVxxlstkSQzIZWUynGIIBWcqlxYo5ec4lprv3fg6Avsv3x8lhA3oHEfAFbl75oAm5Jqp6fo0/MV6
	DtR17h1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAjlh-0000000C5zM-2run;
	Mon, 20 Oct 2025 06:53:21 +0000
Date: Sun, 19 Oct 2025 23:53:21 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Message-ID: <aPXcYQPPYtA98MBM@infradead.org>
References: <aOSxbkdrEFMSMn5O@infradead.org>
 <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
 <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
 <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
 <aPCXz7ktsyE8BLeG@infradead.org>
 <f141df1c-1d91-40f8-853a-f423ea4a452f@wdc.com>
 <aPXa9gR4l3WnI8kh@infradead.org>
 <506e7292-d795-4a78-9c0d-8442cb3b7a15@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <506e7292-d795-4a78-9c0d-8442cb3b7a15@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 06:52:04AM +0000, Johannes Thumshirn wrote:
> OK, maybe I tested wrong. Does it also hang if you only run zbd/009 or 
> do you need to run the other zbd tests before?

Just running zbd/009 is fine.

Also make sure to try to use my kvm script as-is as it gets, given
the bisected commit I might be sensitive to the open zone limits or
zone append size or something like that.


