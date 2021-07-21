Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5C3D123D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbhGUOnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbhGUOnV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:43:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D6DC061575;
        Wed, 21 Jul 2021 08:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Ic8dHTQ1wbk1NLQgZhh+4q7L2K
        XBSOfUNi7GRDJZvfXnRNbXntV+a1b/zqpdL75yyeUDIY+/t+uSmb+7K5LcVQ5tvi5QPikVePG5p4/
        U9ihVBohfeBtXQatXG4C4Gfdc4vZ5IBWt/2kksGGlY6CunCEkNBABnW+vDqEI4wQdpY+r097owd9h
        qZt0o01dc99s6MbxSVUS5/syRPOZyCpx3Ep8J7/D2pAkEcR3mPel31qnGsgX44DMwr1bqs2f0k/QG
        yTS8Dg74SYHoXpBFX6QpxM+9U76JFrQ+e+C73ljOX5dqr9KfHVsWvB49hQD/oUXnABENYAdgRjPlv
        GYI8H5Sw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6E4T-009KV5-E3; Wed, 21 Jul 2021 15:23:46 +0000
Date:   Wed, 21 Jul 2021 16:23:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v3 2/3] btrfs: fix argument type of
 btrfs_bio_clone_partial()
Message-ID: <YPg7/Q8Adx0Evy84@infradead.org>
References: <cover.1626871138.git.naohiro.aota@wdc.com>
 <54a957c10f01437a4e28ca9381388745244fb427.1626871138.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54a957c10f01437a4e28ca9381388745244fb427.1626871138.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
