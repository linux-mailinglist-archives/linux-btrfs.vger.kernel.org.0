Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCFD5B5BEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiILOIs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 10:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiILOIr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 10:08:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D013E32DBB
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8n+OWHwpsr2zZng9ARhgULB8bh9AFduEKWfcChpG134=; b=T0C4hXL53YL3B0/zrnzQ19dpkI
        9KKN2P4XBaJW9Hb4qgozGH/GeoiQx13znfE0+AjStPs62PfUoB0jRyF8GluNEJ/k/HGDDHMiLhCpC
        86XEz5iDgA+5h2ifMMCt/E1vOXsDbAnGvherz9L/qySR3sAgDJ1xYGEv1U6ogAFfbTSxeoiPQBPeu
        kEqTwRoVJbxjnXSSWCOB9zAIZyJSXf/VxzklV7ApwhIzLOG3lq0tHUpwPaGMD/3CDdfvBHZhl2Jat
        25VYkUQvEida2jskAivyjEODF+wIdMQxk4LJyv4p1pRDX28i5xZyvoNU/YG7lB90n4rBG1PQcTgfF
        KpJdG7yg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXk7C-00AVHf-AR; Mon, 12 Sep 2022 14:08:46 +0000
Date:   Mon, 12 Sep 2022 07:08:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 01/36] btrfs: rename clean_io_failure and remove
 extraneous args
Message-ID: <Yx89bhyk7wrrmWox@infradead.org>
References: <cover.1662760286.git.josef@toxicpanda.com>
 <f09c896c9cf29af6c9aab11a760fec372f77551e.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f09c896c9cf29af6c9aab11a760fec372f77551e.1662760286.git.josef@toxicpanda.com>
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

On Fri, Sep 09, 2022 at 05:53:14PM -0400, Josef Bacik wrote:
> This is exported, so rename it to btrfs_clean_io_failure.  Additionally
> we are passing in the io tree's and such from the inode, so instead of
> doing all that simply pass in the inode itself and get all the
> components we need directly inside of btrfs_clean_io_failure.

So this goes away entirely in my "consolidate btrfs checksumming, repair
and bio splitting", not sure if there is much point in renaming it in
the meantime.
