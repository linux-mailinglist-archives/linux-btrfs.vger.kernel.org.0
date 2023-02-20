Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D288469CB31
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 13:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBTMlS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 07:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjBTMlP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 07:41:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006718A87
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 04:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PdHA+/rR6uhpLPjQCxam5KltFohCe1v4TKDuIL5OOK0=; b=aZC+ifepZrUqDE7nVy8VptAduX
        W0M7sHw6Ko+mJq1Fmk6CyYUJerjpW/V4KA3f//42+LV4Po9RQYf0tuKaE4R4YEXya1E/9WFnTmgSQ
        vfwfmssowOmmB42LjF+i6wOvOyXpmJtoQI3YsAgygEzgwrj34mtfl81SvbkVGAhdcv9qAWSbfb27j
        ezj6EBiYJ0Gpe4M/2gWyUGA8XqiB7ET/Afi+AqQn0PnyThu1b9H423CT7YgMKZuoHRlgiNqtDZZQs
        p0Glbs59X+qY48fNJhfW9e2Yog0NTZgWNhPIc5n6IRdCr8rQAdYMpj0+1OzYjv71G5FB8/VZFA71f
        fLVaUy4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pU5Tm-0044Ep-1A; Mon, 20 Feb 2023 12:41:14 +0000
Date:   Mon, 20 Feb 2023 04:41:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 00/13] btrfs: introduce RAID stripe tree
Message-ID: <Y/NqajUZ0//iFnhR@infradead.org>
References: <cover.1676470614.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676470614.git.johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While I'm not enough of a btrfs expert to review the overall
architecture, the interaction with the storage layer in bio.c that
I recent rewrote looks sane, so:

Acked-by: Christoph Hellwig <hch@lst.de>

for those parts.
