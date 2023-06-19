Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D90A734B35
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 07:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjFSFA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 01:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjFSFA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 01:00:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEED2E49;
        Sun, 18 Jun 2023 22:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QsmVgB5mBahPejpiZ5iEkjgIlFHi/whHeShlc7B3SOk=; b=r2FWf4W/Bv6VI7qVRl6e7aZ1Tq
        QuFEhU9w68SnTqBKRCfC6lhMDUarO6vBzCl8WaogptlSmK3+h3VaKmHupOitQQlfQ7NbJkxLXFoEA
        V02mxEYt/8tcKP2ui2L8nP0T11Z8tHoCeQKZjXmFIwOw+bnPUmTRFkbKvastkPOWSzmq6YgNsGSza
        h7Sd9itlYRqcD7+DdZm1Z014jlywzK6R5oSEaHnbUb7y3WGy6W/Z/IvXd73/f3sTeN8tE+RDxy387
        Z/cFQxpcq/GFn/+LLAh7Hg4B9ni6MrXEy9oYT1KiG9tiqQP5RgKwHakzwRJcL1T2AiQbhIjQBpPkd
        533oIQEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qB70X-007Riw-2i;
        Mon, 19 Jun 2023 05:00:53 +0000
Date:   Sun, 18 Jun 2023 22:00:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, clm@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: make btrfs_compressed_bioset static
Message-ID: <ZI/hBdEdSvEirz/C@infradead.org>
References: <20230616172443.87681-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616172443.87681-1-ben.dooks@codethink.co.uk>
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

On Fri, Jun 16, 2023 at 06:24:43PM +0100, Ben Dooks wrote:
> The 'btrfs_compressed_bioset' struct isn't exported outside of the
> fs/btrfs/compression.c file, so make it static to fix the following
> sparse warning:
> 
> fs/btrfs/compression.c:40:16: warning: symbol 'btrfs_compressed_bioset' was not declared. Should it be static?
> 

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
