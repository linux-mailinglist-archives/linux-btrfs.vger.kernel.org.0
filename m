Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DAD4E7920
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 17:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbiCYQot (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 12:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358713AbiCYQos (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 12:44:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003885FA4
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uaQYTfkLb4ZEgye6A7UL/Wp/OZclGXyxPcxXaPYAdPg=; b=MlSZVntpD0yA5hu41mvEXo5ut1
        Uz5pA/89vcSwvmb2SNaot+qeO6zreKTVYTrsEc126moWCM7/4fYIzHc11bhyTyl+YfMtXL+kVqF9x
        2RYAm9saQiJ3qzbNR6Ejko8abXdqcp8x3hCqZVuYIgVlCe8MbzY3XtS5jibqe/m6jdd1K7wzIShTB
        rNMZid36gM3pO8cxYEuQ1JUi6vioZ6AUVUJn2lSjyOSQgt5qHpxAJTDULR8FB5PI6wO7/8ZR43emO
        DLVQ8+4N+tZad8WZneuC8fd8WLEe+y+W020OjfPpF0IPWXhNsQAPPqteZdMhjj0/rjq+oWOSdTo1+
        rv8mPdfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXn1p-002dJy-BS; Fri, 25 Mar 2022 16:43:09 +0000
Date:   Fri, 25 Mar 2022 09:43:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] btrfs: do data read repair in synchronous mode
Message-ID: <Yj3xHarLow3FRMRR@infradead.org>
References: <cover.1648201268.git.wqu@suse.com>
 <1b796a483efa008ba5e2090621161684b3c4109b.1648201268.git.wqu@suse.com>
 <Yj2ZALUKtblRSaxP@infradead.org>
 <dd03a779-f996-4e45-e06e-f75acea97ff7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd03a779-f996-4e45-e06e-f75acea97ff7@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 25, 2022 at 06:53:31PM +0800, Qu Wenruo wrote:
> > I'd suggest to at least submit all I/O in parallel.  Just put
> > a structure with an atomic_t and completion on the stack.  Start with
> > a recount of one, inc for each submit, and then dec after all
> > submissions and for each completion and only wake on the final dec.
> > That will make sure there is only one wait instead of one per copy.
> > 
> > Extra benefits for also doing this for all sectors, but that might be
> > a little more work.
> 
> Exactly the same plan B in my head.
> 
> A small problem is related to how to record all these corrupted sectors.
> 
> Using a on-stack bitmap would be the best, and it's feasible for x86_64
> at least.
> (256 bvecs = 256x4K pages = 256 sectors = 256bits).
> But not that sure for larger page size.
> As the same 256 bvecs can go 256x64K pages = 256 * 16 sectors, way too
> large for on-stack bitmap.
> 
> 
> If we go list, we need extra memory allocation, which can be feasible
> but less simple.

Just chunk it up so that only up to a reasonable bitmap size worth of
I/O is done at a time.
