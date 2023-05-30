Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A15715520
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 07:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjE3FoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 01:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjE3Fnt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 01:43:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D90170F
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 22:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rczbLzYHMBRuD3S0Of91YYeMTOnmEBCf0ovOkd1t8f8=; b=gFd0p1YEK43+PBee/AuaE0Gcwy
        35mZO9iG2aTjLkvMeb98y4KXm6viErwb52hdLBVFxVftuH7O/nr1IqfWWj6HSzs5ML8gzn6wd0oyg
        MhKQk3I9AZhjADsab3TIHL3PYRxNECocicZwHZONXGwGM/AEdu0k9W/N8Z/N44A2ShIm+GrojDBb0
        xC25RnLuyNg8E3ixSaxXmCMEgI7Kwm9I722cSED7UWs7rVo5WEK/sehL2IKFpPxzVTPQ8j6aYoTWp
        +qzBqu48ReT1IBBXBPXXLfYUu79JHd/3fgU7bTkH48ZlZbvM1qfhf6L8Ldhgj4o/x/AS2zqJfhA/X
        YzlhZtdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q3s8L-00CUyf-0B;
        Tue, 30 May 2023 05:43:01 +0000
Date:   Mon, 29 May 2023 22:43:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs: remove processed_extent infrastructure
Message-ID: <ZHWM5U754Na8KyCi@infradead.org>
References: <cover.1685411033.git.wqu@suse.com>
 <5b3edb0ed26aa790fa92d0319739adfd71b3b2f5.1685411033.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3edb0ed26aa790fa92d0319739adfd71b3b2f5.1685411033.git.wqu@suse.com>
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

I recently posted an equivalent patch:

https://www.spinics.net/lists/linux-btrfs/msg134188.html

but it turns out this actually breaks with compression enabled, where
due to the ompression we can get gaps in the logical addresses.  IIRC
you had to do an auto run with -o compress to catch it.

