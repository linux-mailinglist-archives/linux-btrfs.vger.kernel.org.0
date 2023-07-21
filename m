Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5375975BFDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGUHgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 03:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjGUHgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 03:36:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A5730E8
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JRQQVz2N7Y7gEgATU5qgaiwZPRUXTUPSLy7tPte5dTQ=; b=jKtOGNoauMtrjwMeGe4NUtQoZo
        Xh1wxy1oE8UlRDyvCPqhFCO92+UHv91sHE3t4XRT+mSJOL0FnBENNaOkvIKP6DF4TbvTCWqJCNyCd
        u/95V/zV69pwYiAVFKK4VoPXkbXbjjg5o/4fws34df5Q23S3Oi2LTp6lvKzGuv1RcyDpfgKK/e8jz
        Gm9/oIWvQItcyvql0XKTMBWyex0dnj7th0bSfBFQATyfeE5gCvgKmsDK2nO19XHKOFnl12qBVunYh
        WA/NrV/vMDxggX0ohhSFT+U9sxLkZoisbd175oJEkZVvfVo87e99AdA/LK+QQIig0/C/eXoE1MsLY
        PeG3VNuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMkgI-00DCbH-0U;
        Fri, 21 Jul 2023 07:36:06 +0000
Date:   Fri, 21 Jul 2023 00:36:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] btrfs: fix generic/475 hang
Message-ID: <ZLo1ZprHIIeBev4y@infradead.org>
References: <cover.1689883754.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689883754.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've tried to review some of this, but the code is way beyond my
pay grade.  But I can't reproduce the hangs with either all three
or just patches 1 and 2 applied.

