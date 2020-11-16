Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB52B4BAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 17:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbgKPQwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 11:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730612AbgKPQwi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 11:52:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AECC0613CF;
        Mon, 16 Nov 2020 08:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=58n1C0eF5U2Ce08w2RFY+aBzbpcHaYmfH6ddU03MxV8=; b=gHrMs+m4c5i43VOs6wLtvFKYRG
        hIV0TPWTqtDWpuJrTpZQKB+oCEMm5Ky8IhUC50h3NG48uWzVxVfc7TahHNVAJHMup37uN/yJ+XLG3
        Iveqb1Z6SH0J8WIsABBdYiZe3Z8EZQ0raI8cNQsIF4BJsmK6RMW/Zk3rH/+rDC7Oa4YhGMReuXkW0
        v/9k0FjKgBpKkpqd+TJS3dvuQWCdg5YQ4L71zeLRAbQibkCvCyRQuiv0kCYsd6eyqhOyakjtzky8y
        SM8VE2wCWtMToxcnlmSWzF+Wc7/wzZ5MUQZPiyiNwLVclaI+VDXsD1eQJkvz+MqsXYretJAZxdUbA
        gm1VNQdw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehjz-00062Z-Rv; Mon, 16 Nov 2020 16:52:31 +0000
Date:   Mon, 16 Nov 2020 16:52:31 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Petr Malat <oss@malat.biz>,
        Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/9] lib: zstd: Add zstd compatibility wrapper
Message-ID: <20201116165231.GA22834@infradead.org>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
 <20201103060535.8460-2-nickrterrell@gmail.com>
 <20201106183846.GA28005@infradead.org>
 <D9338FE4-1518-4C7B-8C23-DBDC542DAC35@fb.com>
 <20201110183953.GA10656@infradead.org>
 <4ED61269-0F19-46EB-ACE3-C6D81E0A9136@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ED61269-0F19-46EB-ACE3-C6D81E0A9136@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 10, 2020 at 02:24:35PM -0500, Chris Mason wrote:
> I think APIs change based on the needs of the project.  We do this all the
> time in the kernel, and we don???t think twice about updating users of the
> API as needed.

We update kernel APIs when:

 - we need additional functionality
 - thew new API is clearly better than the old one

None of that seems to be the case here.
