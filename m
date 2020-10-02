Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C04280DB0
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 08:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgJBGzA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 02:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBGzA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Oct 2020 02:55:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA833C0613D0;
        Thu,  1 Oct 2020 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wsszzdNdt8/s5qmse2DtQE9T6ptZdmllS5Ln6Q6wU9w=; b=dPcWs/vek1tL6i1nQlvOrE1uA7
        8xNJ8Oje5kX7lSLWTZyOtzuVqtVFyeYSK1k+YIC4hGdDMAVJix1JWLikC5X5IMWqei9i4rHgZwVGd
        SD0S05U3c/JiwtVUkoPuwiYZEYROVD9jo7aNA0uZo8FMJLUmj6UXjrCS4I45G+y+s0isM6bwvh7dP
        Mb6tKl+tTbGqe6MJsL9Z5CDppphb88mIwyztnvEAI6ZVtZ3QFkMZaFBUXwFdYq3zWn+lXU7X1M9Hz
        qUm9iN54MuQJB97nh2XBZhPFT665ncwJylT4Br6ojvvNBQiuEsWumjLPjZeirdZDZIV/cZjn1eiSn
        472YLMnw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOExy-0007q1-6R; Fri, 02 Oct 2020 06:54:54 +0000
Date:   Fri, 2 Oct 2020 07:54:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/9] Update to zstd-1.4.6
Message-ID: <20201002065454.GA29993@infradead.org>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
 <20200930065336.GA13656@infradead.org>
 <8743398B-0BBB-424E-A6A7-9D8AE4EFE8ED@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8743398B-0BBB-424E-A6A7-9D8AE4EFE8ED@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 30, 2020 at 08:05:45PM +0000, Nick Terrell wrote:
> 
> 
> > On Sep 29, 2020, at 11:53 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > As you keep resend this I keep retelling you that should not do it.
> > Please provide a proper Linux API, and switch to that.  Versioned APIs
> > have absolutely no business in the Linux kernel.
> 
> The API is not versioned. We provide a stable ABI for a large section of our API,
> and the parts that aren???t ABI stable don???t change in semantics, and undergo long
> deprecation periods before being removed.
> 
> The change of callers is a one-time change to transition from the existing API
> in the kernel, which was never upstream's API, to upstream's API.

Again, please transition it to a sane kernel API.  We don't have an
"upstream" in this case.
