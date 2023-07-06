Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB5A749EFF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 16:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjGFOap (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 10:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjGFOam (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 10:30:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA51726
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GOmw/nAG2Z1vd+TXS/EGbzqOvK
        WZJH4U6n3L5elwQCbOtj50X/KDsEDSZy7NeKWLkU/52nB6XtGm21bPhDxiOsD/y9N3f0sSXerFC2A
        b35qHpHCGnwBiGzNssdMpG6rq9ldv5+eKnpD3at3kIO677kjrNRBOCstR+PZ83LdC3snC51qlKbPW
        aEq4hyfEZllavrYs7f67j1i1W3ODRkK1MYGiTZGFEpSZkmy8EqtMHnEuzYU3nj2Gqdq1Vh/Suas5n
        QiSak2GTNooXIyLsKg0hQzOH2H/o0XZoGgcJonKm7zST0vqXdcaID35qTDe8PFSsRtEKjuwMisoOV
        xLoQHj5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQ0G-001sQD-2g;
        Thu, 06 Jul 2023 14:30:40 +0000
Date:   Thu, 6 Jul 2023 07:30:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs-progs: print out the correct minimum size for
 zoned file systems
Message-ID: <ZKbQEMvvGJOAXd/Q@infradead.org>
References: <cover.1688648758.git.josef@toxicpanda.com>
 <8acbb798193016e630019e29212c2343e2920e84.1688648758.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8acbb798193016e630019e29212c2343e2920e84.1688648758.git.josef@toxicpanda.com>
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
