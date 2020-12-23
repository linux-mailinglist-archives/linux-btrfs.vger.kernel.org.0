Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E675C2E19E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Dec 2020 09:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgLWIUa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Dec 2020 03:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgLWIUa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Dec 2020 03:20:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855DC0613D3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Dec 2020 00:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QCwaO+8Rvm7bPyJCTudSy8vTcD5s35ExvVV9XlschDI=; b=Wj6zfp2JYdOWi1Mssexel6beCe
        51SSQUNFJce6pdb0eFdITJQKl+wUM9LszRqijURGN7TGFsWrhDsDnQPQI10DATV80HcPXMPyCSIHN
        k5MKn4bnstAYU/C3Thlo3HY3Fne9YyGEjpWiH/gX3fRWzz9Iq0Feyq2hrkEtTU4UPZ2NxPlABq/Vr
        P3OSnPwKgTcVCpzbLJggEJvZRinfXgNoebPYKfE11MB4EFOXS3NIMoUH1UliXgXO4P9Q56xj5OaLp
        kZj/QBtWHHEdftnO8eFR9cyDdh3KWJceDj6ILxRO1zT3R9xvRHdbmIedrcmeg0k+uRx3u5isgoaNd
        YNVHnBag==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krzN5-0006Gz-LF; Wed, 23 Dec 2020 08:19:47 +0000
Date:   Wed, 23 Dec 2020 08:19:47 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Introduce a mmap sem to deal with some mmap issues
Message-ID: <20201223081947.GA23449@infradead.org>
References: <cover.1607969636.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607969636.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 14, 2020 at 01:19:37PM -0500, Josef Bacik wrote:
> These issues exist for remap and fallocate, so add an i_mmap_sem to allow us to
> disallow mmap in these cases.  I'm still waiting on xfstests to finish with
> this, but 2 hours in and no lockdep or deadlocks.  Thanks,

Any chance you could look into lifting it to the VFS and also convert
ext4 and XFS to the common scheme?
