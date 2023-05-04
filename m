Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F496F6D73
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjEDOD0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjEDODZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 10:03:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6108A7EEE
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q83i71OpIsMY9us3yqJR5zBHEAAr1XVSuRjtOHuvQYo=; b=bHFAlJVdPhIB73cbQejgSI1v4v
        npqpLylWULhzH/PTE/ZP/QNVHgu6TodEV1swKVD76eqZPKhV1dD1sDvLmycOg/UaPeNqHONLIFe4q
        yu7Kxw0bFo8/DyrgPGF6H6fKs9mncJ7lpX2d+VfltKw+l9rFpPErbu6tDZQfo1QiPX5uuTy5JuN0B
        9Vq3m0/QUeOiEwMpSTQ2jAuY5AgGedn7d08kS4FvRPi5tnoxZCDTzL8rGKZmzOnaSYSABaOoeasr2
        bh6DPjVqL2Kb+84BTZ9KGLjJv4CoXvS8il8kIgJtO1iEtb1Lt1osaz8AaCvMY69LDuscF2l5F+MKf
        Y9JfSSTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1puZYF-00825J-1H;
        Thu, 04 May 2023 14:03:19 +0000
Date:   Thu, 4 May 2023 07:03:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        syzbot+d8941552e21eac774778@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: don't BUG_ON on allocation failure in
 btrfs_csum_one_bio
Message-ID: <ZFO7JxdXMGYu8CZb@infradead.org>
References: <20230504115813.15424-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504115813.15424-1-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 04, 2023 at 01:58:13PM +0200, Johannes Thumshirn wrote:
> Since f8a53bb58ec7 ("btrfs: handle checksum generation in the storage
> layer") the failures of btrfs_csum_one_bio() are handled via
> bio_end_io().
> 
> This means, we can return BLK_STS_RESOURCE from btrfs_csum_one_bio() in
> case the allocation of the ordered sums fails.
> 
> This also fixes a syzkaller report, where injecting a failure into the
> kvzalloc() call results in a BUG_ON().

Not BUG()ing here is an obvious improvement, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But if this allocation can actually fail, this just means this failure
now means writeback under memory pressure can't make progress and the
inode is now toast.  So we really need to look into something like a
mempool here in the longer run.
