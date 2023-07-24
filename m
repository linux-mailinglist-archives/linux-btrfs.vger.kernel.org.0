Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5205575F976
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGXOMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjGXOMN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:12:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB48BA3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AP3DPtk0TAWbL9ANTS0E0HcqiZ6GKfqWPjBEgIuttIo=; b=4wD7kCf+qIA5wErylNYrDeJJ91
        Zz3hREbGkoNzuODAjQGwekbyhyCHOxvFmcDIDiT1eFVCGT2BgX6zHh8V/vYNcDBu/1MbJo1LIQgeZ
        DvRghbI/FDxEBv0HxuMvqZ8O9TMRMPoNso+A/7g6hea8TTVxIu2J0B+vTbGH0xzIeK1iTU/u8bhPk
        +zn+vADR5fK5ZNBt+MODJpu1m0f4lTc1kkDEZBQFKmEvgZwVnKhWz23TNgfyPEfbZZrtBuQw9fu/C
        txnt1e5c0te96DAV8vOZ421qZBdtYKMKCqS5A/xzyfTfmRr5uB4stUBNQl0gr4DGYiqL1hSSt9mQF
        LcPOIjBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwIG-004ZKX-2F;
        Mon, 24 Jul 2023 14:12:12 +0000
Date:   Mon, 24 Jul 2023 07:12:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: warn on tree blocks which are not nodesize aligned
Message-ID: <ZL6GvIvyaX7CzT0N@infradead.org>
References: <fee2c7df3d0a2e91e9b5e07a04242fcf28ade6bf.1690178924.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee2c7df3d0a2e91e9b5e07a04242fcf28ade6bf.1690178924.git.wqu@suse.com>
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

A _warn level printk seems pretty excessive for something that was
perfectly legal and created by earlier implementations.

