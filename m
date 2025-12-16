Return-Path: <linux-btrfs+bounces-19785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 363D9CC2003
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 11:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8D91302EFDE
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F2833B967;
	Tue, 16 Dec 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0jYJRbVu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277527A12B;
	Tue, 16 Dec 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881859; cv=none; b=rRlJZZx4xUitBEfp7FbcFeZwvcpskKFquEBzBV3lzYmn2l4JfhzzDpR6HmouAyoVJg1r4C+YsKyBN+EUC9umzHXZAVUBQ5U/Av5OPLubc+C2FHQXVkHcwKDTeLqH/iTpOKjZKJ53bcxEXzPkAu8HY0hrBFhrDm/7Gzh183GX2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881859; c=relaxed/simple;
	bh=baYLgCJ+0CucYQLubnyOZLEdi2gVWoY8FpdUBoUiHSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jp2lCGxsVDsfvSuWmRXuOaJx7MEalACM5DRGO2dVFFVyH/ZTrRduUnfq/n4uN52l6IXsvnuKBnJPw8YCz/RwCemwwLQhgGs32/wMbC80aTyLLlJdwr2wVbYtBXNF108NeIuRQCmHKuR55dvoq7PYu6SjYj0uTUNTcZF5QNG3f4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0jYJRbVu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yz/8i+uO12ijhpCgnQOcrEoWKqxjPYd2nX8w83LPsZ8=; b=0jYJRbVunW79QpRxd0klUZpa5d
	6bVnTLjh1wrVqJk9NkezIII2QZB6YlYoc9mzeIP6+PRDGwV7WS5iGaOi8ZcQ0WMJIfBl86YEg9bTZ
	N6/62oJnCMzTORaI8IXEXQMtnEu9O17mqGiWGraHEzkT7TrKdrhf9vWYcYAuIi3SR8NOOFmHOLTwz
	FjbWm6FZb4gDZOylczHcuhw52jJn0BBefnQecviazrQZOhIayxZeAlVYlp1s3HaD9hZq1tOBYH6on
	1jAQWQFqECXnXYMyURnf116G9VZ+bKODk24g4eZ+HkuwUBAlWvD1Zsg0efod66csQCzW5FUIPdjRU
	wkH9oUMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVSXO-000000053Y7-1UXo;
	Tue, 16 Dec 2025 10:44:14 +0000
Date: Tue, 16 Dec 2025 02:44:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 06/12] bio: don't check target->bi_status on error
Message-ID: <aUE3_ubz172iThdl@infradead.org>
References: <20251208121020.1780402-1-agruenba@redhat.com>
 <20251208121020.1780402-7-agruenba@redhat.com>
 <aUERRp7S1A5YXCm4@infradead.org>
 <CAHc6FU6QCfqTM9zCREdp3o0UzFX99q2QqXgOiNkN8OtnhWYZVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU6QCfqTM9zCREdp3o0UzFX99q2QqXgOiNkN8OtnhWYZVQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 16, 2025 at 09:41:49AM +0100, Andreas Gruenbacher wrote:
> On Tue, Dec 16, 2025 at 8:59 AM Christoph Hellwig <hch@infradead.org> wrote:
> > On Mon, Dec 08, 2025 at 12:10:13PM +0000, Andreas Gruenbacher wrote:
> > > In a few places, target->bi_status is set to source->bi_status only if
> > > source->bi_status is not 0 and target->bi_status is (still) 0.  Here,
> > > checking the value of target->bi_status before setting it is an
> > > unnecessary micro optimization because we are already on an error path.
> >
> > What is source and target here?  I have a hard time trying to follow
> > what this is trying to do.
> 
> Not sure, what would you suggest instead?

I still don't understand what you're saying here at all, or what this is
trying to fix or optimize.


