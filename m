Return-Path: <linux-btrfs+bounces-3128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8247B876A1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 18:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330DD281C99
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2AD495CC;
	Fri,  8 Mar 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vGmnrzIa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46991E4A9;
	Fri,  8 Mar 2024 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919779; cv=none; b=E1Ne3wWotw3eR+9QLQpWI7iu9yuzuhF9DTnOTNfBN68fsaclXdU5+0hZ2NYfDagCeRsxMZx8dml+h5p3gJl7F0kK5AF0UHh/jiYcBAqn/rBGAW73CUsZZ7yeFwhrc3ThpV6nExDDogqIYWLdUTQHomU5RqffxQP3YzAzSMv3jUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919779; c=relaxed/simple;
	bh=aBCwEpuwDgzDtmAG8GGNUIRLN989kZSwsX5duKZdyQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWOy/saYG+HqHHexo7DvjjZutL0Alq4OLgoxDiclcafKhiqaFx4G5aMqGo/b/vP+PVehaIB7JDqznZfBzyouxwy0Le6pszemp2+4LPt0TfymGSXYByW+ZPfNw3KazOwY7GJWKx6Jmn3TmrqTBI0OMy5Ld3Vjiu3a5X05EsduuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vGmnrzIa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sWiXmKGaUixrOABw1n9rycgjMhAXptr7BVFT4ztRXOo=; b=vGmnrzIapDSUJ3F5x5iQnZO7+y
	cJJ52XovAGrELE7OFOVACnuXTi7r1YFSzl+lD0Yzbyq5YqsMe/lu97U4sgN1LfImRyFux1wfEH7Si
	rijJmxq7ItRJz9zjycDLMmLZ2BXFJwb6B5cZIeMpy5yp8g9hwp6YOmy/x+EYWLfLsI1x3ZW4hi6ub
	X/YQBh2+ebC+eOisAcWFlVrmhOld1QKVQLE0IOXXUp50etE9RyjhgOYA/xGLOVZ7xD56qkLq1WM9h
	tllaWDr+sHHD1QqkEq6j5tWCAQiRBaO328CyA0/ROxPwcfz0RD90iXBDYnFRjT2VZanb1St/sLb3m
	/BeG+65Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rieFF-0000000Aa8K-02JQ;
	Fri, 08 Mar 2024 17:42:57 +0000
Date: Fri, 8 Mar 2024 09:42:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Boris Burkov <boris@bur.io>
Cc: Christoph Hellwig <hch@infradead.org>,
	Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Message-ID: <ZetOIKNJRsdFNJ3A@infradead.org>
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
 <ZeszQwa8721XnZsY@infradead.org>
 <be3571d7-2bfe-4bad-b2c6-84a0bf121140@oracle.com>
 <Zes4i3qvFk2nWjyY@infradead.org>
 <9a59cfac-2ab4-4c6c-933a-70dcd3e3d80b@oracle.com>
 <ZetJqJH-K-fC-pC-@infradead.org>
 <20240308173254.GA2469063@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308173254.GA2469063@zen.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 08, 2024 at 09:32:54AM -0800, Boris Burkov wrote:
> You remove/add the device in a way that results in a new bd_dev while
> the filesystem is unmounted but btrfs is still caching the struct
> btrfs_device. When we unmount a multi-device fs, we don't clear the
> device cache, since we need it to remount with just one device name
> later.
> 
> The mechanism I used for getting a different bd_dev was partitioning two
> different devices in two different orders.

Ok, so we have a btrfs_device without a bdev around, which seems a bit
dangerous.  Also relying on the dev_t for any kind of device identify
seems very dangerous.  Aren't there per-device UUIDs or similar
identifiers that are actually reliabe and can be used instead of the
dev_t?


