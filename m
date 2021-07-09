Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9CD3C1F8A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 08:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhGIGtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 02:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhGIGtM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 02:49:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4108EC0613DD
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jul 2021 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EfwgfPFv2bsxCm6/g8v31sKydc517GJY8FceUAm+cAs=; b=n0LD5rqTZ1OdrSejwq6FtN/Y+p
        ljlo/sZo3NGv9ZySEUBFWes7cfmazJO0D+Gi0cMCQziI/uwb1g34oEdSM1yncU5fi8Kl1ak2YeND2
        p2eWnD167MCfmESR4e6AMuoqagCMx/JNIGOjhtwcI1/2DUMLaT93u+re4ZtZ2uowWCdQloVzSdRTD
        AosLq/P51qLMIK7UQ0gtKzyLkohrePmSWYrYX7BnTw3r0L7m/25MCBn1WJ+t5hYyilZz/qHEvcVMj
        zrmOomgF+I38/EsXFxt1nGoxkyW5DfoaC4TvWkgNjMmlKw5fty8uT2gidRfzvAinsDQGZLwDMrtya
        cRS65S3Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1kHB-00EEXQ-24; Fri, 09 Jul 2021 06:46:19 +0000
Date:   Fri, 9 Jul 2021 07:46:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Neal Gompa <ngompa13@gmail.com>, David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
Message-ID: <YOfwuQPtXScmFULF@infradead.org>
References: <cover.1625043706.git.dsterba@suse.com>
 <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
 <e6a4b354-879b-a767-3f21-2535e38e8571@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6a4b354-879b-a767-3f21-2535e38e8571@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 09, 2021 at 07:53:39AM +0800, Qu Wenruo wrote:
> Sorry, I can't see the reason why it would cause performance drop or
> higher memory usage.
> 
> The point of HIGHMEM is to work on archs where system can only access
> memory below 4G reliably, any memory above 4G must be manually mapped
> into the 4G range before access.
> 
> AFAIK it's only x86 using PAE needs this, and none of the ARM SoC uses
> such feature.

Arm calls it LPAE, but otherwise it is the same.
