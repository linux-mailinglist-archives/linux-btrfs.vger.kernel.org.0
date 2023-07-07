Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2874AFF5
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 13:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjGGLiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 07:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjGGLiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 07:38:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BF3170C
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BdNY6LgeONj9jqmE8ID+qDtwp+8iTAKHNQVS3N2c4c0=; b=h9M8CJ5G2q9sS/Tji5UaLB2J/z
        lvmB5dZJAfHaAik+gtjD4ZRgOJq2SovxQFojFuubJbuuvF2Rwc412jv8kQZ+H2bjV19k5xdk1ETHf
        vnv8vhCoEqjal0udrndN+Pyq44oXbRr25jInEOEtP+zk/GtGT386817mC+SlWUHIDedGxqS9Iu1K3
        GMlErWS4weSOsCKtv3KPaDkshCEULEIgPA5mbh8hPCtnr60UoE9P+cFxNfpiH7O+8wR+MopJaReFH
        Ymrop96Sek/JoV4SKKH2yaCP89PU6Q4hP+B323Fd4cwQWHQa5mqqi9QM4D6rt4x/AhgFD6GiWCfL4
        zec0ajhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHjms-004Wy4-10;
        Fri, 07 Jul 2023 11:38:10 +0000
Date:   Fri, 7 Jul 2023 04:38:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs-progs: set the proper minimum size for a
 zoned file system
Message-ID: <ZKf5IjoGAAdkrz1I@infradead.org>
References: <cover.1688658745.git.josef@toxicpanda.com>
 <c1cfe98ea6c2610373d11d4df7c8855e6e98d3dc.1688658745.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1cfe98ea6c2610373d11d4df7c8855e6e98d3dc.1688658745.git.josef@toxicpanda.com>
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

On Thu, Jul 06, 2023 at 11:54:00AM -0400, Josef Bacik wrote:
> We currently limit the size of the file system to 5 * the zone size,
> however we actually want to limit it to 7 * the zone size.  Fix up the
> comment and the math to match our actual minimum zoned file system size.

Hmm.  IS this actually correct?  Don't we also need at least a second
metadata and system block group in case the first one fills up and
metadata needs to go somewhere else to be able to reset the previous
ones?

Sorry, should have noticed that last time around.
