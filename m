Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4975B280DBA
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 08:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJBG4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 02:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBG4b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Oct 2020 02:56:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBCEC0613D0;
        Thu,  1 Oct 2020 23:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7BVc1iS3g2oQv2YGmBM3HrMQTsBjA+89qcd8GM2sLng=; b=Bk5FHae+b+QyMOChRUDesucsC9
        cNTWeKMSdi5ShHkGtSxVNNyzCENJAEE35Iz/fjAI6csahpZBqru27BB0BdeIg+wZKiPU+u7arWZFX
        wUDUxJSFgkWpbxYD2LToCbQZzVPm9dmK/EQ7ELbEjXa10fJ0kX32auyOB8vZLGjd1JL+5vn3fQ450
        rKI+zNIp8Ujsbi+EM5CK7wDKELZNKTBcc6ZOIAvGhMRluSXr0SvlMchFfSIDNfXjRcRfsWgx8TUZ7
        gdyAHPb0PqBs33Mt2ScZ0zoZ+w7vda1l5MDpHdT7cFbO7p82agANNb/YKo65a5IYjG4pf51fZnHRt
        YFjCDKDw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOEzR-0007zp-Q5; Fri, 02 Oct 2020 06:56:25 +0000
Date:   Fri, 2 Oct 2020 07:56:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Terrell <terrelln@fb.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL][PATCH v4 0/9] Update to zstd-1.4.6
Message-ID: <20201002065625.GB29993@infradead.org>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
 <293CD1BC-DBED-4344-AC84-C85E0DD7914D@fb.com>
 <20201001101833.GT6756@twin.jikos.cz>
 <D369584C-5BA4-4C08-BFE9-8DB79A05CC31@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D369584C-5BA4-4C08-BFE9-8DB79A05CC31@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 01, 2020 at 06:35:34PM +0000, Nick Terrell wrote:
> I???m open to suggestions on how to get a zstd update done better. I don???t
> know of any way to break this patch up into smaller patches that all compile.
> The code is all generated directly from upstream and modified to work in the
> kernel by automated scripts.

Documentation/process/submitting-patches.rst:


"Separate your changes
---------------------

Separate each **logical change** into a separate patch.

For example, if your changes include both bug fixes and performance
enhancements for a single driver, separate those changes into two
or more patches.  If your changes include an API update, and a new
driver which uses that new API, separate those into two patches."

It's not that hard, is it?  Please do your very basic homework instead
of pretending to be a special snowflake and then come back.

