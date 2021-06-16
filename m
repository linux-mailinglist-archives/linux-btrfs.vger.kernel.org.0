Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2823A90BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 06:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFPEoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 00:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhFPEoX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 00:44:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFDBC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 21:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r0x35Jl28I1SAtioj+6G7nfdWL88GFGlvGRhfogoufM=; b=ThKJ1inIDxtTCFIDOVEGxlRJxP
        IUJCcuMp7bC/8U17IWCDSaFxCHXleBwdCPmDxz0fxn98SglLHhjp1P/+gLTvl4eqNXl9kz/2BQHwT
        NEiG8X/iVfJfkN3pUPGCmFCQJViP0LNA1ydQKFR67yy6s60+7UXzMmkY0DtNzo+89C8IMy7PiSDTi
        Fmc85181Pet8tTWlMfe63xsU0MEZ6Nn0KAGXSgKe4vCYW+j9HXaQsyMjn9TaCPIqarmT0h8qdYxEy
        zX27tZeKd6hp+L3K0oo7fJtP8czHVKDj2XwIg3KpjuUai2dyjwbqDoKZrELH1VSzdlPdOAaURyHG1
        iTl0K0Ug==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltNN2-007b9E-Ih; Wed, 16 Jun 2021 04:41:47 +0000
Date:   Wed, 16 Jun 2021 05:41:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/4] fs: add a filemap_fdatawrite_wbc helper
Message-ID: <YMmBCL23eCLnROJx@infradead.org>
References: <cover.1623419155.git.josef@toxicpanda.com>
 <b7ce962335474c7b0e96849cd9fb650b1138cbb3.1623419155.git.josef@toxicpanda.com>
 <83038b23-71df-962c-167f-db0b21b83025@suse.com>
 <8c1d5edb-8149-f0e3-6170-2b25fdaa4e9f@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1d5edb-8149-f0e3-6170-2b25fdaa4e9f@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 15, 2021 at 09:37:33AM -0400, Josef Bacik wrote:
> Yeah I'd like to clean this up at some point, but that's outside the scope
> of this patch.  I want to get a helper in without needing to run it by
> everybody, we can take up cleaning this up at a later point with input from
> everybody else.  Thanks,

But you _do_ need to run a new core writeback function past "everybody".
Just posting it on the btrfs list like for this series is definitely
not enough.
