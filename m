Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15150716400
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjE3O0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 10:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjE3O0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 10:26:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5AF11C
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 07:25:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4445468B05; Tue, 30 May 2023 16:24:45 +0200 (CEST)
Date:   Tue, 30 May 2023 16:24:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/16] btrfs: stop setting PageError in the data I/O
 path
Message-ID: <20230530142445.GB9014@lst.de>
References: <20230523081322.331337-1-hch@lst.de> <20230523081322.331337-9-hch@lst.de> <20230530132311.GQ575@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530132311.GQ575@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 03:23:11PM +0200, David Sterba wrote:
> On Tue, May 23, 2023 at 10:13:14AM +0200, Christoph Hellwig wrote:
> > Note that the error propagation for superblock writes still uses
> > PageError for now.
> 
> This patchset cleans up all the other Error bits so for super block we
> can first switch to another flag like PageChecked, reworking the
> separate page for superblock I tired some time ago still had problems.

Yes.  But the superblock writing all works based on the block devices
page cache, so it doesn't interact with the per-normal file pagecache
touched here, or the magic btree inode page cache touched in the
previous series.  I was planning to take a closer look at the
superblock handling when I find some time.
