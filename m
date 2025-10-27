Return-Path: <linux-btrfs+bounces-18356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5BCC0C163
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 08:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033AE18A18C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 07:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A59C2DAFA8;
	Mon, 27 Oct 2025 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kgL/6KBF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791DF5C96;
	Mon, 27 Oct 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549580; cv=none; b=Kyx9+KiXO2O3OcM0WpwMUNk4kL7UvY2r3cAga3FB2JbR53RJrpryHQnzstnWCZNztwF1fZUqE5CxwFaTOA88sUDA99ihhd30HXJ9e/XSVolybK+KM6MLffsXSIgEPNUiQJcEmbWBGlQI4vZMmj21AmgqgAxbyGsKo/8f+S6DEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549580; c=relaxed/simple;
	bh=aaJCDSML3FZ+MH9deasVl4DlO3quoQIcstqOFYS0cL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2yPjsXdmRWdXPTU+JbPUKd897fV2bUxlo0ZvGB80r16//2U2RmeAFig+HqQfT2VzfvVJb6BEY+yQCKxT1r8lyHk5LmEs0+rXxf/X4HpqK/8SIU5OHTqcXPtL3LraBUOBMCoKeM3qgAFuyCm2YgB8g7xb0dufE22+HWzlzK6WLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kgL/6KBF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=obBfXq/4PFU+KpTi0KZjQ7Er/5WIK1rjxPy7aLZfp6M=; b=kgL/6KBFneORiiXMhDoYe++1gC
	7nqoLH1pDgCk6A0jXdJmkhv01SVEgLAjcrc8RD3r7SqEhdkMtoaBL3tmdafEoGbq78rNv2zgUZJi7
	f5uu6uirsLGH9Wuvggz4ssqZu2k6H+2SLKegh+FK6g9VQwCLi8kcqqTmhgzr8hHKC5TyEY+DZppXb
	3se2bHNv8o9neovrxOvv0Cnk86fvWAiAiNQtsHRMyLnJvwOiquuBftROck1ksFKi58yZvOhXG0MUq
	ogi5Uc73BOeV89nOz1Y8MUh3lOZgUHXywsE3L/jpzaa1T8f67zg9UXGmiTl3PnVzg1hHfY62gdfNB
	TiTfXdYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHVs-0000000DGdW-2xY4;
	Mon, 27 Oct 2025 07:19:32 +0000
Date: Mon, 27 Oct 2025 00:19:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>, clm@fb.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Directory is not persisted after writing to the file within
 directory if system crashes
Message-ID: <aP8dBBlWgpGB4OCQ@infradead.org>
References: <03c5d7ec-5b3d-49d1-95bc-8970a7f82d87@gmail.com>
 <CAL3q7H5ggWXdptoGH9Bmk-hc2CMBLz-YmC1A8U-hx9q=ZZ0BHw@mail.gmail.com>
 <d039a3c8-c4f7-487c-a848-2a26ea26f77d@gmail.com>
 <CAL3q7H5ewZROWz0384L_pLvqWrjNK8mX=-kQb26ZDmpAbBUQ4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5ewZROWz0384L_pLvqWrjNK8mX=-kQb26ZDmpAbBUQ4A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Oct 26, 2025 at 09:04:13AM +0000, Filipe Manana wrote:
> >
> > The test itself is quite weird (why would `dir` be gone after seemingly
> > unrelated operation?), any detail can matter.
> 
> "dir" should be persisted as well as "dir/file2", according to the
> SOMC (Strictly Ordered Metadata Consistency) that Dave Chinner
> discussed many times in the past in fstests and btrfs mailing lists.
> 
> You should also reach the xfs mailing list and mention that
> "dir/file2" is not persisted.

No.  The fsync is on the root directory.  So the only thing that is
needed to per persisted is transactions touching that.  The transaction
to created dir is persisted because it is an entry in the root directly.
creating and writing to file2 has nothing to do with the root directly
and absolutely should not be effected by an fsync on an unrelated inode.


