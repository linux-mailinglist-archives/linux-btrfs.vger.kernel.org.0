Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A3752603C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiEMK6E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 06:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiEMK6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 06:58:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D0B296BED
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mhl3WtT5b39WrMoO6jsIMhe/QpmCE6xYGo/Nmv4Z1qA=; b=HqxPdASZ/PxY67IXf9bEPe8t79
        6W0BvoBN9NFB9Un/vdJdS2HH2OOXgQQkfKWn4CmLwg/ZD3S+K9MZx/+H4RLAA3uL8GyBDS6mki6ir
        B8DjXvo8GjpTLMqFnruNfNkwW0dU0m5AOUJ3uyGigAC+PKHOt2IsHRMQl+G9lggHVT3+ygDfd5JmL
        jMWK8QoQcy5n4vjlMbLVBjHWri90wYdoes86hcRttLTXlejukDpXWZEWu+XJmoYP5KteKqq9hlVEX
        Gj04+/JTp7fSQ7rAWrDnpr/g0hGpNgn6JHPl6ZkmM7BE8/vUJ9LoQzL+x8nuYDH3weNENbqNkO92B
        gdypFt9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npSze-00FfRo-3s; Fri, 13 May 2022 10:57:58 +0000
Date:   Fri, 13 May 2022 03:57:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Message-ID: <Yn45tomlUQ8mGyVs@infradead.org>
References: <cover.1651559986.git.wqu@suse.com>
 <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
 <YnFE62oGR5C/8UN2@infradead.org>
 <dac4707a-04f4-f143-342b-cd69e0ffcd80@gmx.com>
 <YnKIM/KBIJEqU/6b@infradead.org>
 <efb8bdf0-28f0-0db9-c2b0-a08ffbd22623@gmx.com>
 <20220512171629.GT18596@twin.jikos.cz>
 <Yn40Fkhz0jyef1ow@infradead.org>
 <5520df08-b998-a384-f1aa-16b301474cab@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5520df08-b998-a384-f1aa-16b301474cab@gmx.com>
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

On Fri, May 13, 2022 at 06:53:13PM +0800, Qu Wenruo wrote:
> Mind to share the overall idea?

Build up the repair read bio as large as possible, then submit it
synchronously, and then do the same for the repair writebck.  Basically
go back to synchronous I/O, but do nice large I/O wherever possible.

> I hope to get rid of both io_failure_tree the re-entry of endio.

Yes, it reuses this and various other bits from your series.
