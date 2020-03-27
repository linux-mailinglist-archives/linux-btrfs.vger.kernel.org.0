Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0B1952A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 09:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgC0IKZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 04:10:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgC0IKZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 04:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RxHv9kYc/4ftbGH13qfOO4Yug8p1pMMg7j9QR/DQN08=; b=Rw0Ww4UYt0tIR5VtBuID+OESHr
        sOiX39A7ReHAnwkSDxWOixkJGt6P1p5zNYcQDkDj6ccJoJ+/bitewYe40rNbPMLktXjfLL9/XRJAw
        MGgJkYnXtZ2zS714hzJb/OEiNbP5TS6Aa4tb4dFts3jrDEKTDKMM6RywxX4Vn/V6gJgg5dYxzgIyU
        nIS61BpbFf7jRvibtk3zgflBPPxwuOVmgi4tDImudZYgRylEJM3O/ajTh179C+L8ehwfL2dUQi+f0
        JdaBd8WU0Pp49NP1FDOhJhDjiUHJsm+1kDe/zIkzAoVOSpvZClZM1SyYLQGRlEqYVwclvho3rOAnJ
        QUsZldxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHk4O-00080S-Ia; Fri, 27 Mar 2020 08:10:24 +0000
Date:   Fri, 27 Mar 2020 01:10:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200327081024.GA24827@infradead.org>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
 <20200326210254.17647-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326210254.17647-5-rgoldwyn@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 04:02:49PM -0500, Goldwyn Rodrigues wrote:
> BTRFS direct I/O is now done under i_rwsem, shared in case of
> reads and exclusive in case of writes. This guards against simultaneous
> truncates.

Btw, you really want to add the optimization of only taking it shared
for all the easy write cases similar to what XFS has done for ages
and what ext4 picked up now.  Without that performance on someworkloads
is going to be horrible.  That could be a patch on top of this one,
though.

> +/*
> + * btrfs_direct_IO - perform direct I/O
> + * inode->i_rwsem must be locked before calling this function, shared or exclusive.
> + * @iocb - kernel iocb
> + * @iter - iter to/from data is copied

This adds a way too long line.  Also kerneldoc comments go below the
arguments.  Last but not least a lockdep_assert_held is much more useful
than comments trying to document locking patterns..
