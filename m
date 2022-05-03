Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C27E5187EA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiECPLE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbiECPKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 11:10:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BC13969F
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 08:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5FcyXeefoHiSY2r3J/KNvg3elKyzvMaEiMBbd1JzTu4=; b=hn+aTUxB495jSrcKWvoCfwjoBl
        7RmVhFEtGu2/qUu/igJF9016RJffuYBvq8QUFKMILF3nt6W0nKmE669R8repK73Vxvpbji/KZ9VHM
        JNxzTrcCp8McXpauCqrx877Uid7VN1qU/H6WfNR5Jma7XDfjQVVGioiSwK3cnNSJf/HYSatJ6TLEo
        4tQGn3zAC/YiLDsazR18SOwn8dfYqtBmI+qxZFeMZTbIcgnto+n3THJEap0sgc0dPKaK+XA9cV41f
        vnnYNQ34AMMVfwVMIwMEsBHN8iGk21P6c9cBL2clmA7eCMGhCOh/4k+E7DhIQoduui4HqFj/kxdfu
        +NFpV7nA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlu7Q-006PVA-9Q; Tue, 03 May 2022 15:07:16 +0000
Date:   Tue, 3 May 2022 08:07:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/13] btrfs: add a helper to queue a corrupted sector
 for read repair
Message-ID: <YnFFJGbbs4+MgKY1@infradead.org>
References: <cover.1651559986.git.wqu@suse.com>
 <2cfd9d2766824ddce727b06068de24d7a4be9637.1651559986.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cfd9d2766824ddce727b06068de24d7a4be9637.1651559986.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds an ununused static function and thus doesn't even compile.
