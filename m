Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58C267757D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jan 2023 08:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjAWHR4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Jan 2023 02:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjAWHRy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Jan 2023 02:17:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1908F2D76
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 23:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=93BUyD0D9LY/HiIk7VCEhFqSxbiMSJtqBjEgimRNqR4=; b=VOuXnHNK3p/f30XiGThZs72sp7
        X3E53iM7RY91SL27RxRooJwUdlfzR+N+F8rdOw2EUXrootmq1vy4rdOCzBkyFEbHNgHqxZcokkL34
        1RliOjlIO5tNcGfTJXyOijC5hCDo+c3hSmOesJ1u7X9GRqzB8cITKuUGYHW9SDFdSPKAOJmoksuBF
        tb4gtmgAqeQiqJToCL6jcizDcpGEwRypIGIAt5uMrKv2snhXskp0fW/rB3nxCfbEkSx8p/jhaEGJl
        N14rVGEfRYt4UI0aYEemYEOlVZpNTM99aj5RQHSe/+/hx97mxzCUS75yjM/4VjTu1xZt19j/kggq/
        0+rqO0Jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJr5R-00GB20-Mw; Mon, 23 Jan 2023 07:17:49 +0000
Date:   Sun, 22 Jan 2023 23:17:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Will Btrfs have an official command to "uncow" existing files?
Message-ID: <Y840neK7y/u8Dpn2@infradead.org>
References: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 22, 2023 at 02:41:22PM +0300, Cerem Cem ASLAN wrote:
> Original post is here: https://www.spinics.net/lists/linux-btrfs/msg58055.html
> 
> The problem with the "chattr +C ..., move back and forth" approach is
> that the VM folder is about 300GB and I have ~100GB of free space,
> plus, I have multiple copies which will require that 300GB to
> re-transfer after deleting all previous snapshots (because there is no
> enough free space on those backup hard disks).
> 
> So, we really need to set the NoCow attribute for the existing files.
> 
> Should we currently use a separate partition for VMs and mount it with
> nodatacow option to avoid that issue?

So, Linux for a while now has the FALLOC_FL_UNSHARE_RANGE flag to
fallocate to unshare previously shared extents.  It still lacks an
implementation for btrfs, but it seems to be the interface that you
want.
