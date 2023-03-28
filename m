Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735666CB2CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 02:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjC1AZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 20:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjC1AZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 20:25:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9497A1FC1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kbymmg6RcqzrLWBP5v4wtL0Cyh8ASdpsTr/KhiVCtto=; b=IJR/Ef8Fsr7EE++XQWXw9Dj8oJ
        DcJ/gDfNNvdLv3yf0zb/S6zNWI3sHEZZ/d9vR25sOBJ2uKJ3N6t0TaZ1XQ/8Kou02ZZLGyBOz9jBC
        slPNYKZq1yTKQwPIuoDWKBDO4NnRlacYJpq/Z/Z+Fmx4av24XWpFHk6EClqGR2bUI1wSMKVNyqLoL
        yz/McmAC9QacLCbeO4air+ZUbLwsco4BgQTwVu5gKjBL1c4M5QQINk2qtIbRQe3tyiGPtu9I98yvM
        LQfg8Q8UucXMUXjzSwDljxLmRvstXMurh8LKspxaxqf7I9l2zKkWe6/hnGJAUIvR6CluMCeJmUbt5
        EpHddZmA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgx9p-00CiTT-10;
        Tue, 28 Mar 2023 00:25:49 +0000
Date:   Mon, 27 Mar 2023 17:25:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5 03/13] btrfs: introduce a new helper to submit read
 bio for scrub
Message-ID: <ZCI0DXvc+h7DoZvB@infradead.org>
References: <cover.1679959770.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1679959770.git.wqu@suse.com>
 <ZCIoQLysbLrQW0pX@infradead.org>
 <cd8a91ee-2e30-9829-b50d-599fab3fb490@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8a91ee-2e30-9829-b50d-599fab3fb490@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 08:16:38AM +0800, Qu Wenruo wrote:
> For read part, as long as we skip all the csum verification and csum search,
> it can go the generic helper.

Yes, and we can just check for bbio->inode to decide that, like you did
in the earliest versions of the series.

> But in the future, mostly for the ZNS RST patches, we need special handling
> for the garbage range.
> 
> Johannes is already testing his RST branches upon this series, and he is
> hitting the ASSERT() on the mapped length due to RST changes.
> In that case, we need to skip certain ranges, and that's specific to scrub
> usage.

Can you explain what the issue is here?

> The btrfs_submit_bio() would duplicate the writes to all mirrors, which is
> exactly what I want to avoid for scrub usage.
> Thus the scrub specific write helper would always map the write to a single
> stripe, even for RAID56 writes.

That's basically what btrfs_repair_io_failure does.  Any chance we
could share the code for those instead of going to back to creating
multiple code paths for I/O submission?
