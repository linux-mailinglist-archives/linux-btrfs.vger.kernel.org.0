Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4370ED6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 07:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbjEXF4i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 01:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjEXF4h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 01:56:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E407189
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 22:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XkbrP+pjGemAcc/qNGB4FQ2xFvgbYPHax2S5L1llELM=; b=nD8ZM5LGSaXwnIg5dFhzs5criT
        AM8uL/zcJuuYB/XsrAYr5dxtek0GyucbcYV+bT2PpA8NXkI2QL4wAVk++4BkZ9GXXs0Bpatv9NkhN
        CnGaVAZ3ZStC7rxbwfEjsMC5o61M6Me1c/jaNZlGCepG5VMz6kBVFeoG97ehpxKvz4q0yf+3Gwix5
        4L8PjH2Z0DeM4tKSC+2r3EUYckZ5VxUCsMq+Xn0Onef3YN/rtBHNm+qMIZ+GqrAtfrPIE7zxytwxt
        l7eIDhOxxsxfZh4GpkR/4w461wYz+CZlhKJLJiXkk4ikobvLicV1MM2n0bGta81VXyaUnqm1+I3SC
        6GsXc9og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1hUA-00CRgC-06;
        Wed, 24 May 2023 05:56:34 +0000
Date:   Tue, 23 May 2023 22:56:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/9] btrfs: reduce struct btrfs_fs_devices size relocate
 fsid_change
Message-ID: <ZG2nEuHvkGJ+qNhD@infradead.org>
References: <cover.1684826246.git.anand.jain@oracle.com>
 <844fa765ab173b8dd24549f145534f41d412d3ea.1684826247.git.anand.jain@oracle.com>
 <ZGzpgG8o5pv5+hNL@infradead.org>
 <20230523205917.GC32559@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523205917.GC32559@twin.jikos.cz>
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

On Tue, May 23, 2023 at 10:59:17PM +0200, David Sterba wrote:
> On Tue, May 23, 2023 at 09:27:44AM -0700, Christoph Hellwig wrote:
> > On Tue, May 23, 2023 at 06:03:15PM +0800, Anand Jain wrote:
> > > By relocating the bool fsid_change near other bool declarations in the
> > > struct btrfs_fs_devices, approximately 6 bytes is saved.
> > > 
> > >    before: 512 bytes
> > >    after: 496 bytes
> > > 
> > > Furthermore, adding comments.
> > 
> > I like the better backing.  But what looks access to fsid_change
> > and the other bools?  For sub-word members atomicy guarantees are
> > very limited, so they'd better all use the same lock.
> 
> Do you have an example where the reordered structure would become
> problematic? The fs_devices locking is non-standard, the structures are
> accessed from module context or from filesystem context. There's the
> uuid_mutex as a big lock for fs_devices, and for access of the
> individual devices is device_list_mutex.

No, I'm mostly asking for Anand to document the rationale why this
is fine.  If there is an issue, it's probably pre-existing.
