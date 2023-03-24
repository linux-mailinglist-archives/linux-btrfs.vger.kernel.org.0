Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DD86C748D
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 01:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCXAYo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 20:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCXAYj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 20:24:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924882D161
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 17:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qSsptxBIxp/4z0TAz6RYyoY93wwhCHMvE6UrcA9IOj0=; b=j8ejHJgIMrQqdCglQXckjGD091
        t7CmdjnSiVi4WgXM8wVIXuHySG0lxU91WEsVAzqyfPKUn/N2Vo3WZoKxFxS/ZMdLGVZfqtjQrmQ4J
        mhxM471GuG7/A7swVRFn1PmJ7EqSDUuj4os+G7I0eEfxNcqIAZBFO2J6HmVdZ1esKGx3SVpl3O1Ek
        NetzZGbOwMfDKQRYXOoavEyqLV8b2581gsdx71+/NGojF4RYQ31OMjxk0BR9lUU86HOY/6OEL5/Wh
        SS4SY8HdYiZpOLkQe7rQ5PjGn6M3y1n3IbHjl2RBkkMA+QCI9OECsy+Sd3HyS5DmNXNm+RPPio6ox
        bos+xn/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfVEB-003FHZ-1r;
        Fri, 24 Mar 2023 00:24:19 +0000
Date:   Thu, 23 Mar 2023 17:24:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 3/5] btrfs: return ordered_extent splits from bio
 extraction
Message-ID: <ZBzts0qVMkvissQZ@infradead.org>
References: <cover.1679512207.git.boris@bur.io>
 <cf69fdbd608338aaa7916736ac50e2cfdc3d4338.1679512207.git.boris@bur.io>
 <ZBwSIGXZipuob/61@infradead.org>
 <20230323161529.GA8070@zen>
 <20230323170006.GA28317@zen>
 <ZBzEw4gy8lhNYgo7@infradead.org>
 <20230323224336.GA29323@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323224336.GA29323@zen>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 03:43:36PM -0700, Boris Burkov wrote:
> In finish_ordered_io, we call unpin_extent_cache, which blows up on
> em->start != oe->file_offset. I believe the rationale is we are creating
> a new em which is PINNED when we allocate the extent in
> btrfs_new_extent_direct (via the call to btrfs_reserve_extent), so we
> need to unpin it and allow it to be merged, etc... For nocow, we don't
> allocate that new extent, so we don't need to split/unpin the existing
> extent_map which we are just reusing.

Yeah, I actually just ran into that when testing my idea :)
