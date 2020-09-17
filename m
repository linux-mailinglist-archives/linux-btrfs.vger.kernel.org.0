Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC71626D85A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 12:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgIQKFc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 06:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgIQKFY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 06:05:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85913C06174A;
        Thu, 17 Sep 2020 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=etDu0solC5EHZ0a6cTnafdPGtZwvbpt/Q8uDwacTzb0=; b=T6E1hto/3ToiS8tEe7XA6ZOPy9
        yaNF0YLLVxqLa0YJWuGC9geGUEt8Hy4qoH4Pp52NSuKJyxc9jtFzsMsCaP5q3u8w+Lgjq+NYS1pig
        uyOaqV36xtAolloyVQruPOXo+likgIAY9YgMNVRVuKech2GAFb0zBapdM+74nUPJJUKKpNqO0UfSS
        ZndZBx0Y/nPQG6s1N9rvUGUHnAJ13mbDBbWl7qu/X3ozlNMnm1qkI0m3Vz/BRt8n+gN2WzZzPhW0Q
        GP9v3fCEozhHXdvVXwV8b2HrAxL+BWnTpz4UE0ZwfxqLmHj8nGf85YleQo6QTcXR9dKJuUol8RLPI
        /Pb6boJw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIqmg-0007Lt-NG; Thu, 17 Sep 2020 10:04:58 +0000
Date:   Thu, 17 Sep 2020 11:04:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Nick Terrell <terrelln@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Petr Malat <oss@malat.biz>,
        Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Subject: Re: [PATCH 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
Message-ID: <20200917100458.GA28031@infradead.org>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-7-nickrterrell@gmail.com>
 <20200916084958.GC31608@infradead.org>
 <CCDAB4AB-DE8D-4ADE-9221-02AE732CBAE2@fb.com>
 <20200916143046.GA13543@infradead.org>
 <1CAB33F1-95DB-4BC5-9023-35DD2E4E0C20@fb.com>
 <20200916144618.GB16392@infradead.org>
 <4D04D534-75BD-4B13-81B9-31B9687A6B64@fb.com>
 <b1eec667d42849f757bbd55f014739509498a59d.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1eec667d42849f757bbd55f014739509498a59d.camel@surriel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 16, 2020 at 09:35:51PM -0400, Rik van Riel wrote:
> > One possibility is to have a kernel wrapper on top of the zstd API to
> > make it
> > more ergonomic. I personally don???t really see the value in it, since
> > it adds
> > another layer of indirection between zstd and the caller, but it
> > could be done.
> 
> Zstd would not be the first part of the kernel to
> come from somewhere else, and have wrappers when
> it gets integrated into the kernel. There certainly
> is precedence there.
> 
> It would be interesting to know what Christoph's
> preference is.

Yes, I think kernel wrappers would be a pretty sensible step forward.
That also avoid the need to do strange upgrades to a new version,
and instead we can just change APIs on a as-needed basis.
