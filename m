Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A779E514EFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 17:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378221AbiD2PRw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 11:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378285AbiD2PRn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 11:17:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F983D4CBE
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uhvvvFPZhKVFZt6NYQBwg93lo7sxpvenH/W9lZCqLUo=; b=vLvU0tJkkqLZwbtyx0XNE+YM5w
        3qa2XJtCGqQIWZOgijkvoSRwU/PnG8rg+dYPsWwXabXnVDVqvSbR7U3vSkxgK6jF/L0AoMtcLCCXH
        0LPo67LRoGJ2hnRT4UpPPuTKp/AQkDz5qeOOpXrnEMPrUZWubqJpApBkziOFbzjg4odHEFQvqT3lg
        d96X9M1Vbgd1y7bpJGnTawdfWx/TU/ubARkV5lynMkXUYfSvD/LGLtVoFn/hUieXWFsMBsR4qqFUs
        EvxNOgcK9SN/V1J1FFeUpmHPu69yq1z+N+3Sbrf10DPdaDZSsdozX+DhTE6i3sMDDsJzBHkEmMv7E
        ys7zDaJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkSK5-00BjKV-Va; Fri, 29 Apr 2022 15:14:22 +0000
Date:   Fri, 29 Apr 2022 08:14:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 05/12] btrfs: add a helper to queue a corrupted
 sector for read repair
Message-ID: <YmwAzU+UORfX92Te@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
 <2fd10883-5a4d-5cbd-d09f-7a30bb326a4a@suse.com>
 <YmqaOynJjWS2XB76@infradead.org>
 <4ac0c01f-73f6-e830-f3bc-6281bd79b7d2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ac0c01f-73f6-e830-f3bc-6281bd79b7d2@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 06:55:59AM +0800, Qu Wenruo wrote:
> Another consideration is, would it really dead lock?
> 
> We're only called for read path, not writeback path.
> IIRC it's easier to hit dead lock at writeback path, as writeback can be
> triggered by memory pressure.
> 
> But would the same problem happen just for read path?

System with sever memory pressure needs to page something in to get
something out.  The readpage uses the last available bio in the btrfs
bioset, but that read now needs a read repair, which needs to allocate
another bio from the bio_set -> deadlock.
