Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2AF676515
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jan 2023 09:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjAUIIc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Jan 2023 03:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjAUIIb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Jan 2023 03:08:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399295925D
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 00:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=fV6xWtzWxtR/9kkMQqKmnj3pKO
        k+DbX7D2eEm7lP08b/IL/eYeOcRXIMZFn6fSyamrfy7gfpNmI2vVZB1Ue8cL2P7LQ9HLBpJQwcAcf
        M85R/Pj4toRQ3qcX+kbMdhHMMnLLpl7yh5ubJsV8fVFRdchDC0AsQQBpqFA675E4QHUxJO4TKF5+c
        YiS23KWXVZXtMfj+Xkh4WGXODrbBoLFKd258IFF0Au95fdrUAf0QBOgmAs/ML9oR/+8TvvfD5BUgi
        Y1Iko+G0IeqGNF/FthnJcyiuKVEZENJlDuIx90sDcdvYcSIwAFUHHuTrhdKkaW2h7zcA5nvtfWN+N
        3YV0pmww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ8vO-00DZwc-Mi; Sat, 21 Jan 2023 08:08:30 +0000
Date:   Sat, 21 Jan 2023 00:08:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: raid56: reduce the overhead to calculate
 the bio length
Message-ID: <Y8udftfx2pASXsT7@infradead.org>
References: <cover.1674285037.git.wqu@suse.com>
 <416ad3d25cbb930a03056bdfb5cdddc6addda12e.1674285037.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416ad3d25cbb930a03056bdfb5cdddc6addda12e.1674285037.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
