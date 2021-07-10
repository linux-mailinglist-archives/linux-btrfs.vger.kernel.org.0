Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0403C344D
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jul 2021 13:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhGJLSM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jul 2021 07:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhGJLSL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jul 2021 07:18:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C927CC0613DD
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jul 2021 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wmQp8ube1jC3ArDlExYKIa2tEnq1e03Nr4DNTkCc14w=; b=kkaYFvw9H1ZEz4XLVuQadvOz+7
        fJvu0cZJwUqnYPV0x+IYCEELERci2WvEJRNRRxoeOo9wpzZwLWuzQfC68/u7zEAsuLPRwVIfztkne
        Vc0kZZWipyiI1TQ7v1EeVdNpsNQihpIF3nebzzfDwfg4H5cEFb83Zo+s2B3kOw9RAyb+NnK8tb7NA
        zatnezcuA4WzWMvfE1aqwpfWr7IqIyZYJ/tKErAIJRwxQESAyWHUHj0UbYjCV1q6hKiJUq7RP7HM8
        K8Ds4s/6QGiB7FmeXzzTeQbWpT9l47nU4sYHhxOXoxBZJsYa13k5VK4Fz9jtOXyFTQskMaAwXtkvm
        ulE2LEcA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2Awu-00FR6f-PB; Sat, 10 Jul 2021 11:15:10 +0000
Date:   Sat, 10 Jul 2021 12:15:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
Message-ID: <YOmBPOYfsuNtV1jK@infradead.org>
References: <cover.1625043706.git.dsterba@suse.com>
 <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
 <e6a4b354-879b-a767-3f21-2535e38e8571@gmx.com>
 <YOfwuQPtXScmFULF@infradead.org>
 <dbddba2c-9242-d8ab-3969-86e7b2974727@gmx.com>
 <CAEg-Je9ESQ+Qvq7uVvV_K3ZGgNrD-kYzJMJif=3e5cCe8p6aXg@mail.gmail.com>
 <95974239-b63e-75af-0720-7fdb10e9fbe5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95974239-b63e-75af-0720-7fdb10e9fbe5@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 10, 2021 at 05:50:47PM +0800, Qu Wenruo wrote:
> Don't forget that, our biggest memory usage, inode pages are all
> allocated without HIGHMEM, just like XFS.
> If it's causing problems, then it would have already caused more series
> performance impact.

What do you mean with "inode pages"?  The actual page cache data,
which should be the biggest users of memory in most file system
workloads is allocated using highmem for basicaly every file system.
