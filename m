Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E366C312C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjCUMCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCUMCt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:02:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F84BE95
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o79aCvWkawrOw8LtdXMrRFJ3PkfYkm4mw4OMpsLjU14=; b=NLGd0xAQgYK2GhFuZD+mra2huZ
        Mgb7VjfP9j/vS8MAWm30XJRSQnaq+16wHO8rozHwD5rAtTww00W6PfeGgxvnPjnqPac6lL1Qkuhla
        issAhaONCq0YOM39YHCsagU77aWiHEjNEmnSjkzy1KHK4VX87ptibVDlMzyghhp2K4a0KcZEO16iO
        4e/dA92K1ivXB/Pfs94JMRiMUHU4cdpOLBU3NKN23vLjAkLWEj9N1a0+2WsztGolZ78jOcRTgMa3w
        vDjD9NjLC2vNfoUhEMxMPtWbQQN/e+b9a/2Pi8KRc3O8WyAAnYo0nAlLzNCnjIqcFk24IXDaSAwvX
        5tm2bVjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peahJ-00CHEd-2H;
        Tue, 21 Mar 2023 12:02:37 +0000
Date:   Tue, 21 Mar 2023 05:02:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 02/12] btrfs: introduce a new helper to submit bio for
 scrub
Message-ID: <ZBmc3ZqDVzb/hVDD@infradead.org>
References: <cover.1679278088.git.wqu@suse.com>
 <b61263cba690fd894e21d75442556ae2f150f095.1679278088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b61263cba690fd894e21d75442556ae2f150f095.1679278088.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> @@ -39,6 +39,8 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
>  	bbio->end_io = end_io;
>  	bbio->private = private;
>  	atomic_set(&bbio->pending_ios, 1);
> +	if (inode)
> +		bbio->fs_info = inode->root->fs_info;
>  }

Please split modifications to the btrfs_bio infrastructure into
separate patches.  And we'll need a proper helper to allocate these
non-bio inodes that ensures fs_info is always set.

>  	struct btrfs_bio *bbio = btrfs_bio(bio);
>  	struct btrfs_device *dev = bio->bi_private;
> -	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
> +	struct btrfs_fs_info *fs_info = bbio->inode ?
> +		bbio->inode->root->fs_info : bbio->fs_info;

.. and all places that just need the fs_info need to just use
bbio->fs_info instead of these complicated constructs.

