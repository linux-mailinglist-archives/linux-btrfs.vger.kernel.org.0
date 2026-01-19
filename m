Return-Path: <linux-btrfs+bounces-20678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C28D39EED
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 07:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A408306BC76
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 06:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DFA2144C7;
	Mon, 19 Jan 2026 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C/XHMotP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8D25F96B;
	Mon, 19 Jan 2026 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805098; cv=none; b=J9No3sBFomBYLtTLtpC3UHD9lm0Bsa0+nbrZvnC90aflbAhc70zt+zL8zjIn5L7JuDLvTqRfuAkYLamD4OC9MuqdWkTbhJlvFDrZilKRPJRekWleHXUCbFCEDX9DH+pG+/kESDujYDSN6hfDaVYhEpnOjdum9e9l31fkaWF43F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805098; c=relaxed/simple;
	bh=i83w381DJI7OyIje0qWX/N5lnPwBbyUByUE29KRkvbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdIgJ599R8Po5rSynReYWhAWM3KTFAlaK0VycyIKk8cf72vhckO25hly+RjqOXG0xiJhXtnMBcHFgPgeY4dbF7U/vMv9VQoYbTGBBSFkbFZp/ry3RybuvGIW3YDMSq4jmzvaC3LWTBXGyMBPh/T2luY9RvlF0TTgWZCXbfY9AUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C/XHMotP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LlpuEetXb9tgRwfsLAI0P1xDQfug/dQe45Y3sAs1AgY=; b=C/XHMotPCEUWyx0n3uWB0j8Cn+
	jDvG/j+KKnSDcQu/FL+unO5bAhDcvjX1hkb0v5iQmJTyjvDlH+7YWmawNOycaXGkfTQ+iEJ/CWqCv
	jKkrfpzsZvRlIQh03glpmclXA6goL42hldsj4A5dWWm1LetHsP82o/2LyzyPDsGA28A+fh1BdkPWP
	+J9fEr/6KazKSXqMerPE3ltjLb0WLSosnjo/+yFTeINKj4BBzZlL+NuUSOsWOgvI/Yk28djCd2ya3
	rHoluzGsxfhSqDJAN4XhcoSuYXztCrVyV7O/E9ebpnaBzGvyp3jWgE/SBSWB6F9TasUNxzLXQTGi7
	aanIYKGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhj0S-00000001Qie-1Fgb;
	Mon, 19 Jan 2026 06:44:56 +0000
Date: Sun, 18 Jan 2026 22:44:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v3] btrfs: do not strictly require dirty metadata
 threshold for metadata writepages
Message-ID: <aW3S6NUkcBTcFXBa@infradead.org>
References: <ada6a7cf8dbb1f4ee78343402c73b078c65a7ff7.1768623845.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada6a7cf8dbb1f4ee78343402c73b078c65a7ff7.1768623845.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jan 17, 2026 at 02:54:12PM +1030, Qu Wenruo wrote:
>  static const struct address_space_operations btree_aops = {
> -	.writepages	= btree_writepages,
> +	.writepages	= btree_write_cache_pages,

Please rename btree_write_cache_pages to btree_writepages, having
instance names not match the method name is a real PITA.


