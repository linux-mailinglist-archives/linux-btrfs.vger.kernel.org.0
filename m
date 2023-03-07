Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3881C6AE7F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 18:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCGRKM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 12:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCGRJs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 12:09:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC35698849
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oZ5dcooyOPNgtX1t7n2EZ27kFb11B0JuiR/HOK6T/9Q=; b=vf8w2JKxL+Zofae/z58HULKlrs
        aG5X4sJ2YYE+O/z6phTH6BxEQxhx7kg2yms6sfxJyLLesZP8+EZp5L3djc3TLrIPxz4HVN18jZ1hq
        VisdFBzbpH8dDxMg1S/Z7LlNY0WE6hybNgqGLmNlFQ3lHDvgFshugzJfKht6BoUQFIiyvkHQVM1ZL
        OEi8F0wtWYUU2ou94OCbIPI0l1Z+l20KjNrLWttXWnuFwo6BwfI2YO8dp25MsdrcjaNG13dr7kl9g
        XXWSl30wRLfUfugMfLxR01Yi13qLaNAaWHGojCkB6hvsg6HCLInK1fdMPaI9M5by0LpsQF4fBhO/D
        /QeKP3Tw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZaj7-001jIg-OH; Tue, 07 Mar 2023 17:03:49 +0000
Date:   Tue, 7 Mar 2023 09:03:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 06/21] btrfs: wait ordered range before locking during
 truncate
Message-ID: <ZAdudW1SCWmnboOb@infradead.org>
References: <cover.1677793433.git.rgoldwyn@suse.com>
 <e9629218282f3e016517f1280b48c5d194fd7c40.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9629218282f3e016517f1280b48c5d194fd7c40.1677793433.git.rgoldwyn@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So, one thing I've been wondering about for a while is why btrfs even
does all these explicit waits for ordered extents.  The ordered_extent
is effectively a mechanism to describe a range of I/O.

So why can't we use the nornal mechanisms to wait for I/O, that is the
completion of writeback for buffered I/O (i.e. filemap_fdatawait*)
and inode_dio_wait for direct I/O?  I've been wanting to look deeper
into this for a while, so this might be a good time to bring it up.
