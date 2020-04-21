Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B611B251A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 13:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDULbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 07:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726403AbgDULbj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 07:31:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B182C061A0F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Apr 2020 04:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CgqcGxPInDSFcgdoCAAP5Bh6MEYPySyK8wkY8/QpzaI=; b=mxwJMRUWfCttQKr+J3f1N8s3Es
        wB7hSLhhRAhGPuZaOUVIFcdr5hp/ZAf8+nYzqyXodqrFcVS0JvlNCPI/fN3ZPaB6aCRsK2a+ACoGu
        ymT2LrHoEvzglAFNGTub4Uk1rY5YtGnVrYIDb9KkyF0rySqYV1kYM4FO3BvwxCBp0VGB9s0a+q5Wl
        NGUQHMsjoi2lkQxQhvATXO0dzbYHtTb/CtKobG/8qxoD/4PSGdBsfFvUsIdwC+BOI1uEs/SFdbcpX
        LkOY0OgryyXbKw4dqSbJ8KZh+Ud1AojHv6ktEDYa0gg6CVIMs38JBG19bLUWT2izptAxMVYIuMDF5
        qry76uvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQr7q-0005TD-85; Tue, 21 Apr 2020 11:31:38 +0000
Date:   Tue, 21 Apr 2020 04:31:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 1/2] btrfs: Move on-disk structure definition to
 btrfs_tree.h
Message-ID: <20200421113138.GA10447@infradead.org>
References: <20200415084113.64378-1-wqu@suse.com>
 <20200415084113.64378-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415084113.64378-2-wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 15, 2020 at 04:41:12PM +0800, Qu Wenruo wrote:
> These structures all are on-disk format. Move them to btrfs_tree.h
> 
> This allows us to sync the header to different projects, who need to
> read btrfs filesystem, like U-boot, grub.

Please use a separate header for that.  btrfs_tree.h is a UAPI header
with strict ABI guarantees.  Just add a fs/btrfs/btrfs_format.h that
can be copied into the projects where is needed.
