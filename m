Return-Path: <linux-btrfs+bounces-12834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAADA7D3E5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 08:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C244188C107
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 06:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0E224883;
	Mon,  7 Apr 2025 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a/JgDZEg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868A33CA
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006709; cv=none; b=A7U7s0haWXyLcdn6sVHcZfuCKez7R07JyRNYv0iM3TltVm0C+kmhvXSev4ZFB6ifEMxUL2veWkeVyez+opeXkecDYBOUwlPJb55b+pzyc1ohLldzdHy9GcbGoDv9R6AINCJ5I5OXEeS53HeX7BCc5Ks+E+qpgOBlE9Blry0bqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006709; c=relaxed/simple;
	bh=pjQmEHBw+iV3MaNz29toGJADi3vnwgjMp8m98fIo6Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5g4vVqT9eJyxrxdozFjR0WfrjgrqKvt5pxhjJeo3dSYK3hZaSODo9GDJD0FJ85gKiTfnY9iSeTTYP/KXWFkbmzeKX8jQRg2dNP8FakxsaEm4x/tVhbc7/8EYpF8l8b8F+YkiPopaUSi5DBgQpykAZIGfsaGi333qgXIlW9Zs+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a/JgDZEg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5ePdJBEBBkEd3jkXD6+OeRVAdtVAr4Y9TCB7PP1c3iY=; b=a/JgDZEg0g7Q1Y3krlcEK5sVzG
	JorRuw8fv2dZMXGRt0R8sDZ8Bn5Gwb+NW8Q3I/Mo4wUiI/PU4q8UEf9CbPKNhjM1Lt0qeK+YzbBNl
	orB3vaYgTt5Wl6a048wyLrzG2jvhWhauxQEEzA5lp+NrSr3iWub/+jTUard2StZ9sBfrKt4C9rAfP
	cTD8cVGawdp0yQOg6Cjf/7yiVtDiOIdS9LrNBMKT/LqpgOduA552dohmzTBSCJt29XbQ8iPAefdQI
	5jHNYD8SIYEfWnxtKpDLCI7bW8f0YoiD8JY7Ur/EOEnbGAHKUbfIJUxbMr0Jtr+xy7MHgDk5g19qf
	n79GorOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1foN-0000000GY4N-0EKj;
	Mon, 07 Apr 2025 06:18:23 +0000
Date: Sun, 6 Apr 2025 23:18:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 8/9] btrfs: prepare btrfs_end_repair_bio() for larger
 data folios
Message-ID: <Z_NuL8Ucl0FCZ64A@infradead.org>
References: <cover.1742195085.git.wqu@suse.com>
 <8203647f525da730826857afe87cd673f1e42074.1742195085.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8203647f525da730826857afe87cd673f1e42074.1742195085.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 17, 2025 at 05:40:53PM +1030, Qu Wenruo wrote:
> In above case, the real folio should be folio_b, and offset inside that
> folio should be:
> 
>   bv_offset - ((&folio_b->page - &folio_a->page) << PAGE_SHIFT).
> 
> With these changes, now btrfs_end_repair_bio() is able to handle larger
> folios properly.

Please stop messing with internals like bv_offset and bv_page entirely
if you can, as that makes the pending conversion of the bio_vec to store
a physical address much harder.

Looking at the code the best way to handle this would be to simply
split btrfs_repair_io_failure so that there is a helper for the code
before the bio_init call.  btrfs_repair_eb_io_failure (or a new helper
called by it) then open codes the existing logic using bio_add_folio
(it could in fact use bio_add_folio_nofail instead), while
btrfs_end_repair_bio should just copy the existing bio_vec over
using an assignment or mempcy.


