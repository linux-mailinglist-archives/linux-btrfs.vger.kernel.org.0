Return-Path: <linux-btrfs+bounces-18032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157CEBEFAA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53073BB6C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D08C2DA779;
	Mon, 20 Oct 2025 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PZ7Y0jyZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A662D7DC1
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945232; cv=none; b=Hppad2D9bLh8z0/hTVkZpvpzz/DLbgzJtPCzJbobXpgWjYj0d6p2qxIILPajXnFu9GHAkIC2GaF6htQ9YJaWmaSgfh+xGJHgECI+N23R/VnGkzwdxLvhMQgr5Wr2UBOYpMESe5+hCX1pyn2hvdat3N2omTxwLYmwy49cfoPzhvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945232; c=relaxed/simple;
	bh=9eO1U4+aYSHYVFZbMiIJqNHIqSUW4BxjeRb8egJw/N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/Gr9kd3IqC8dy64jPV/tP+UGPSvBQWhu59+V4c7MFy5DbXFAKVxQG7g9gt7DSyhIXPuaAAi+GsMyN8U4Adl4OUJCZYYWvU6RTK/Xuh0gCS5/cTXLsYFK8FuOxCxZfoFCDYJro1CcuKpDFGtEkI7KpqqGgnGhPKZ8nCewRgVPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PZ7Y0jyZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yDhPqz0TXo+KAVaRLDitr1kmW4ih3BFrQLXjq3lcN0Q=; b=PZ7Y0jyZQd7uhleShcx3tL5jUX
	siNnkcZd4inTjLBugE3C4CMAAwG7mfsMCHvJlngSBKc8J1r35CfHfZi+T9r/vLBRLGir1bO3WUVbe
	gxVH2zMYfpiJvlkMqE4iZ8m86ESMYSymsnp2itK6220fE+kwF/ueMO+krVmxtT8uxZbsRXWt0qcOi
	1ghxR75fIs548IelutKHUiclg8vOyR0Mx+e7DTlkwfFUVLRu1Ho/u+Mhoz56kwwMLSMmVyhnjxKKF
	zK/dc0hDT5i3b31Xdt4VGFvKLLFXtd1kqdQNvUh1/FEGp4fRvi5Z27J5/xjXJW36QWnSzi2jLf4eE
	aGzKNYIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAkIQ-0000000CCVO-0qjs;
	Mon, 20 Oct 2025 07:27:10 +0000
Date: Mon, 20 Oct 2025 00:27:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: get rid of btrfs_dio_private
Message-ID: <aPXkTrGQ5DPnM5HT@infradead.org>
References: <c5f3f2c9e1d5a3754ff61b3569191b31d13b9bda.1760939793.git.wqu@suse.com>
 <d5b9e358-cb02-4f8f-b669-770a2014319b@wdc.com>
 <2912ce5f-fb54-4681-b001-112fa26b062d@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2912ce5f-fb54-4681-b001-112fa26b062d@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 05:46:23PM +1030, Qu Wenruo wrote:
> 
> It looks like the bbio->file_offset is not safe, as btrfs_split_bio() can
> modify the original file offset, causing some bio ranges not properly
> released during dio reads.
> 
> Please ignore the patchset for now, we really want some stable
> file_offset/size that will not change due to split.

You can't make them stable because they must change for splits.

You could do what XFS/iomapo do: split the ordered extents on bio
boundaries, and then in the completion handler merge them again
for more efficient handling if there are enough queued up.

