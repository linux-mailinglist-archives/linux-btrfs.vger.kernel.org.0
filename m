Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8175174D8
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386423AbiEBQsk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 12:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386499AbiEBQs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 12:48:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8DA1116C
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xYf8sAZ25wKx58aVaLqYSIDg2C43B787FMYZsdvjRVc=; b=TvR1zJ8XIXxfJuC4JIDkkCsbAG
        Au068ecgzj9HpN0b0KDjHV+Fn4dKsDVV6HYsB1IgwBsJjadhrHclbDN3fufvlKEzk4qfi0Z0zoPzb
        UvxzGd5yeW5VY9bKIJDzHzBAh/Fg6l1bGZRiaWpGorlMMNtK+/IrA/++2lQYRsDxrEP1VL7fDenFe
        pDIkseMnsjuXCKaVAgClI1QoXX/ePUIX3xRbH5h48CHQWcZTZdH63KIOOgJhPJU+O0OTEpGI0umTd
        F0NZHHI8QFJwioiJpcvOrVkdJV/wfvGhF26yWqJimxgwKau/Tt1NLUmpX8Up3wnvXrx/JxB1mlGVo
        sgrC/RSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlZ9t-001l1K-K3; Mon, 02 May 2022 16:44:25 +0000
Date:   Mon, 2 May 2022 09:44:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/10] btrfs: defer I/O completion based on the
 btrfs_raid_bio
Message-ID: <YnAKabMjPr6oFAGR@infradead.org>
References: <20220429143040.106889-1-hch@lst.de>
 <20220429143040.106889-6-hch@lst.de>
 <4e93a857-43f2-9e67-9ef8-4db00edd2f6c@gmx.com>
 <6dba9162-c64d-2d27-12eb-d48ac6a4ac8a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dba9162-c64d-2d27-12eb-d48ac6a4ac8a@gmx.com>
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

On Sun, May 01, 2022 at 12:53:00PM +0800, Qu Wenruo wrote:
> > It looks like this patch is causing test failure in btrfs/027, at least
> > for subapge (64K page size, 4K sectorsize) cases.
> 
> Also confirmed the same hang on the same commit on x86_64 (4K page size
> 4K sectorsize).
> 
> Also 100% reproducible.

I'll take a look.  It turns out I never actually run that test as it
doesn't run without at least 5 devices in the scratch pool, and my btrfs
config uses 4.
