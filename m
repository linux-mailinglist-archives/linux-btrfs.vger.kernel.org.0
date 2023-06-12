Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B472B8EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 09:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjFLHmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjFLHmj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 03:42:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E96C0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=oZPjI3e67L3RI3zaeoUNq70jfe
        i9kBl1tmv07UOqAeVgR+si930AQrVM3086GfHxekW51OSu9LYucGHoF/lAFF1rzVnl4j3ALJJP9yp
        olqE/8qMV9REY1MvnbC0pkFra3x2uluWCCfPqZgyR1ofnPCL58pQxhV7sJmwcd/Ttz0CVrdHxXAVs
        E1XyTiXOzvlbDOvmcn+yFnUzKHqFGRxV8Ygq7AZ+1ru1vtSqQuSCDYPsFCQjZ5ZlMMJLOPNqSZ+2Q
        9oP2SvbYAAjK8AeB9bQle6aUTHr1XzUgikh5RwXShSMXNW2kju9fwSytF1+GVeaobVpxmzT+wb205
        P9QA0FlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8cAQ-002wVU-1z;
        Mon, 12 Jun 2023 07:40:46 +0000
Date:   Mon, 12 Jun 2023 00:40:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: remove
 btrfs_fs_info::scrub_wr_completion_workers
Message-ID: <ZIbL/mvnKwhw4BcW@infradead.org>
References: <6e0ace5a15c44d7264a2261597c66a975f214a21.1686554551.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0ace5a15c44d7264a2261597c66a975f214a21.1686554551.git.wqu@suse.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
