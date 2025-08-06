Return-Path: <linux-btrfs+bounces-15899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1351DB1C735
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 16:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A0816255A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3583628CF5E;
	Wed,  6 Aug 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M6VTS/V8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D7273D94;
	Wed,  6 Aug 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488854; cv=none; b=m+AWXUNbOCVT4DJ1zn39ztOTTLl3p9ykQpsn4G9DoP+HH06HCTmb9QqDKt3DcaVa5/mIM4mU15/fcOVv2aJV+LuxGs3bIW813gBkHsCaS07rZ+6++7xKZvb0q03DUPZrV5cwpf+RcMaWxg6gEGbqZbPPYtFQNKmMNscqKYpNfhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488854; c=relaxed/simple;
	bh=sdQgZJM+W5YwTItfxEdhYONqK1C3bHZoCec0PbPIrw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vlgi7BcAul4Fyah0MB0T4jRswHznAVjBkmZWS7rxZsjp03BeRDlpPU7RDkwJOJzRw5+Lp2e5Vpmm9gVXY3v+aJ7WnC6ko8+mvPeD/gK+BJNAiQGLKCt3rQgATJIpsnlegxumVCwM06qsliXhuR0uC3wS81qCooJzXaSlN458q+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M6VTS/V8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gJG7zAGLSVwqJGykShuO6NkkFKjBxNy6E8kx/Jr5iwM=; b=M6VTS/V8KVgVyoVW6zqS9EDX/e
	s/CA9feoJMEx0U8MeLWVWg+Vbxf9IoyClXtX/A86NjqSQbvQQkk3ULuHXNVIs4mN8Cr6dLK2Oc2eb
	SHQSLALX1rpszN38CE029vFlzoeZOGXUFSjCaE8lv8mtNCude3p7ID/skmE5eg6vsWX3iN5vNQJFl
	Q8ehjh4lrReDHmMKMnX8Z7DdpVnxGt2OWbyYi9IPnEnqoQJ7Le8dX/JLYDUk0drnEzuVElvvvpVtX
	jrczSPjUA4HR/yOO+pAb3YWVQW3A46zGWOnk3dNq0wpHiydQyWaIEMEB5XSs94B/jCc+u2G4CfJ6o
	ycApP/xw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujeh9-00000005C1c-1rkK;
	Wed, 06 Aug 2025 14:00:43 +0000
Date: Wed, 6 Aug 2025 15:00:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
	shakeel.butt@linux.dev, hch@infradead.org, wqu@suse.com
Subject: Re: [PATCH 0/3] filemap_add_folio_nocharge()
Message-ID: <aJNgC7f9RVr_rh47@casper.infradead.org>
References: <cover.1754438418.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754438418.git.boris@bur.io>

On Tue, Aug 05, 2025 at 05:11:46PM -0700, Boris Burkov wrote:
> I would like to revisit Qu's proposal to not charge btrfs extent_buffer
> allocations to the user's cgroup.
> 
> https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/

I prefer Qu's suggestion to add a flag to the address_space.  This really
is a property of the address_space, not a property of the call-site.


