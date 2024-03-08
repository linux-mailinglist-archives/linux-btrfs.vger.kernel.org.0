Return-Path: <linux-btrfs+bounces-3124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08C88769CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 18:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC6C283A04
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26542381D4;
	Fri,  8 Mar 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yoEU1rwB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77840861;
	Fri,  8 Mar 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918634; cv=none; b=tIT7f8XLvTebYVeBXSt/BHlyKPsuj5s7QAzkAPLHqTmc/YB6YdF5iNhAhvfsna+p3NNc9H/tOTCWI9xBAdebfmYQI/H/1WBy7BwdvjOEIcsqwzIvyr/SS9Xuwr5B+6TyVIH9U03pVFGKkLIF17WmE4oTMBJV+nlwl1TnfZmwGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918634; c=relaxed/simple;
	bh=JdhC2lc9HrS1dcjMT+E2Ue8bjLpIuTMFAeGj12xwZLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrhSpWsyE3ykqHFCGxQ62uUsdrAYJgqyqi44kj6qrD4VkJlzuhxU4EALd4HJO2HClOy7o6ZGzHTD0IxD13tdn2G6yp/MUo4exUj5Ki+egz/kHyvsy366LL2RrBfvqo4ei6Zq2Pc7O4JdVXfeLXR7M52MoqCmcGb0E9IdcxVA4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yoEU1rwB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h3hF6RNjd/OEL9wHy1dbF2LdOLelVx+45qSHoPQalzc=; b=yoEU1rwBug2LfydZImJYIUpvbi
	AUE4rfCNzywlInAXqiJvjLoaof5qrFMuDuq8ltcVtHqeE5FEei/g2cQxJ6FTWrYqS64r1gsMaEpD8
	Z4xP/kZnWyOIiP7ugyxqVFqZnsDHCUCLVwMc6B1UJqYhJ0Lcqpv+Q5pJS3rOE7Wb2VIDeSmn0LPzi
	ciQpheoO6p3RlGHYOVNfNTpCcit+SuvvvUXt7IyQ8j6++K0sMRckgF4rLQQ86lr/2BPq4oTnkHWVI
	9qVDYfThQixqZaJ7INs2ZBBjp+UwSXjD0h+SuOYtIQRasgGR1Fwty4NmtCyEdwMgNIa6FEh+b/N+d
	wlmDlY4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridwm-0000000AUVy-0yWT;
	Fri, 08 Mar 2024 17:23:52 +0000
Date: Fri, 8 Mar 2024 09:23:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, boris@bur.io, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Message-ID: <ZetJqJH-K-fC-pC-@infradead.org>
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
 <ZeszQwa8721XnZsY@infradead.org>
 <be3571d7-2bfe-4bad-b2c6-84a0bf121140@oracle.com>
 <Zes4i3qvFk2nWjyY@infradead.org>
 <9a59cfac-2ab4-4c6c-933a-70dcd3e3d80b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a59cfac-2ab4-4c6c-933a-70dcd3e3d80b@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 08, 2024 at 09:53:07PM +0530, Anand Jain wrote:
> It's a bit complex, as Boris discovered and has provided a testcase
> for here:
> 
> https://lore.kernel.org/fstests/f40e347d5a4b4b28201b1a088d38a3c75dd10ebd.1709251328.git.boris@bur.io/
> 
> In essence:
> 
>  - Create two devices, d1 and d2.
>  - Both devices will be scanned into the kernel by Mfks.
>  - Use an external method to alter the devt of the d2 device.
>  - Mount using d1.
>  - You end up with a 2 devices Btrfs with an incorrect device->devt.
>  - Delete d1.
>  - Now you have a single-device Btrfs on d2 with a stale device->devt.

But how do you get mismatching devices in this exact place?

  - bdev->bd_dev is immutable and never updated
  - device->devt can be changed by device_list_add, but if that happens
    underneath us here between btrfs_get_bdev_and_sb and the code a few
    lines below the call to it in btrfs_open_one_device there is a huge
    synchronization problem


