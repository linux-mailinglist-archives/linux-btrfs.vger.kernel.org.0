Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7326BFCB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgIPIuJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgIPIuB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 04:50:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0CC06174A;
        Wed, 16 Sep 2020 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HY5sSDf+1gYa2b3NXHBac5E/PqpXZ7sU5Qg7bTCCCV4=; b=hUxTXtIwup8HwXzRn4HnMIRdA5
        FPpltTYYiaSUM8IwPHrwFgbd1a9DADpv9bhUGqJLTh2LIDgW3qQoydHUySggdhzxU97zPROKeanBn
        2UGUonQzrkanDUmkWGawx1Kz3VDSPGdQOGCFC5/QmRQH/zLYeCQpTnchFIqk0K7Mj0WSP5YrWzQIG
        qQqg+11Uzy9xSKl9cSXBhYTJkQEMppsELiB9kas2wXnbt8/4LschRanwncC6AhwXNXZnpiBkPt5mJ
        F4UVmELqbY187ZKI+XMx7ALpwqvZfYhNMTim956FO9UZVhQYTuVHW4+YzCH41xaTf2tOfUoN8gp5Z
        hW2p2S9w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIT8Z-0008Nz-0U; Wed, 16 Sep 2020 08:49:59 +0000
Date:   Wed, 16 Sep 2020 09:49:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Subject: Re: [PATCH 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
Message-ID: <20200916084958.GC31608@infradead.org>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-7-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916034307.2092020-7-nickrterrell@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 15, 2020 at 08:42:59PM -0700, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Move away from the compatibility wrapper to the zstd-1.4.6 API. This
> code is functionally equivalent.

Again, please use sensible names  And no one gives a fuck if this bad
API is "zstd-1.4.6" as the Linux kernel uses its own APIs, not some
random mess from a badly written userspace package.
