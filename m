Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD756A3CA
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 15:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiGGNgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiGGNgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 09:36:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A61EAEF
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 06:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kbMpQ669EYnqVaPHDTo73zzGSSiAmnSkGwKpRBasvPM=; b=m2PsY4l3rvyBdnJL6QF8g/h7NL
        9KNH0uv/Lb0pxVzQRF+iSrwWkn6b4dXOhWbMhdlFV5lsnR+nP88Jg3AAmOoOMTZ3cBsi7iOpMCA+U
        AcDvAIGACDd8nHUCUrjKU25Jxz6ut655+l8mYIEXlem6AEb857kVKzXI4HIoLoPjj8fpyEWLf5wgZ
        hUBmZhRJRr55qaLyanlqOpz05af8r8Ec9Bgq7Kd99cl7qAzbih7GXILM4j1Et602OuwX8P64ykhFp
        dLxr6dK9x5Gv273CdmeNJkIUGhFytI3Q4ocgzR+Mq/Z3bY0C/UX2ZjXT96SEvFZCgXWgkexK2TT47
        nL5h4xXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9RgU-00GHzZ-29; Thu, 07 Jul 2022 13:36:46 +0000
Date:   Thu, 7 Jul 2022 06:36:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
Message-ID: <YsbhbmA8ZfkP0uDi@infradead.org>
References: <cover.1657171615.git.wqu@suse.com>
 <YsZw9O8fRMYbuLHq@infradead.org>
 <ba4c42bf-cebd-72e2-d540-c3b16e5485e3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4c42bf-cebd-72e2-d540-c3b16e5485e3@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 07, 2022 at 01:48:11PM +0800, Qu Wenruo wrote:
> - It may not support RAID56 for metadata forever.
>   This may not be a big deal though.

Does parity raid for metadata make much sense to start with?

> - Not yet determined how RST to handle non-COW RAID56 writes

The whole point is that with parity raid you really do not ever want
to do non-COW writes, as that is what gets you the raid hole problem.
