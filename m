Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D5D6CB2E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 02:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjC1Ax3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 20:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjC1Ax2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 20:53:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAAD10D7
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pFk0IoBPsyHoW++1E9N1Ww3O088dPN0gvuupMCz8I1g=; b=S5jR79bKWCHStqJNHNWCYr3jK0
        vAHqTMZXSSsHHTGWcn6Sb2LPJuJRhnlVN1RwzSuTcks1iry33t50onkOLbqUFvIwtmV2yblpiv5qI
        nRZISypsKoWQD/y7rBz0AcXJt7xKJVH0BnoLVqqG1poMeqMyTJHchfwNJ/8zLj7sdWmH6z7WRtLBY
        mNzQvze1D2GNcU9DTxHlv28amlFUkRhA7UwVX6rc/MRh2M1zk6LSq9f8DD5ojw5r4ytbBuF4On1pO
        21KTI1NJcrquG2FtSspZmB7oalutHPye/+L0ELZM+A4wnFG32c+nSOKGxCIntNfDUEe/qXFUPKl0c
        aP7XOYGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgxaW-00CkDx-2w;
        Tue, 28 Mar 2023 00:53:24 +0000
Date:   Mon, 27 Mar 2023 17:53:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5 03/13] btrfs: introduce a new helper to submit read
 bio for scrub
Message-ID: <ZCI6hOjU+yrQ9SCE@infradead.org>
References: <cover.1679959770.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1679959770.git.wqu@suse.com>
 <ZCIoQLysbLrQW0pX@infradead.org>
 <cd8a91ee-2e30-9829-b50d-599fab3fb490@suse.com>
 <ZCI0DXvc+h7DoZvB@infradead.org>
 <7ec722e8-d685-004c-6c24-6bdac7982e0b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ec722e8-d685-004c-6c24-6bdac7982e0b@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 08:48:29AM +0800, Qu Wenruo wrote:
> The new behavior itself reduces IOPS, thus it should be an overall win.
> And for regular devices or non-RST zoned devices, we just read out some
> garbage, and scrub verification code would skip them.
> 
> But for RST cases, there would be no mapping for the garbage range, thus we
> need to skip those garbage for RST cases.
> 
> The dedicated read helper would provide the location for us to handle this
> RST scrub specific case.

Well, if did just call btrfs_submit_chunk, the RST lookup would ensure
you only get the length of the RST mapping, and you get the behavior
you want without duplication.  We'd need to make it non-static (and
document it), but I'd still be much happier about that than yet another
I/O submission interface.

> 
> The core shares the same idea, only the support code is different.
> 
> I'm fine merging the core logic, although I believe we still need different
> entrance functions.
> (e.g repair is only done for one sector, requires inode/file offset, and is
> done synchronously.)

Well, the inode number and start is only used for a debug printk,
so we can easily move that into the caller.  As for the single sectors
vs not, what we really should do is to move the bio allocation
to the caller, which means the caller cna decided how large the bio
is.  Together with moving the printk that also makes the interface
much simpler as we'll need a lot less arguments.
