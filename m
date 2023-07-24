Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2870675F971
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjGXOK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGXOKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:10:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D43E53;
        Mon, 24 Jul 2023 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t2f7OxCnIhgexboHEIgwS4S5Rsyc2tEzMFa7uxmIk3Q=; b=AiI+ZNKSyvPMV2uy88kWb5ScMM
        TBPZTLKbQ6xVXTP4ry0gWDXt/be9Pn8Aijz4J/Lyttd0H4QyJO3ca6rqnW/9SIU5BbYD06Kozcz16
        6EEx63VwJn+vJJGT80XCN7YfjFv2pTBi6SswP9pwKctOojaGaZOQtMq17BTh1jMFV+blMLuZQHaAC
        F4dRA8udV7f238ixz1JZGHCLKG4fAeBaZQhbIvkOoFrP2ySSV7d7syhY+pl1YPlTIBeIxeU0xA1mE
        Fh8lAtNE7ISKWPOb3JtIa9hPk30ug0D6WF3Tqgce8kFlY877q9Lap6S+4p9hq5U1J0bSOGcTO9May
        DkcGgs1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwGx-004ZDj-09;
        Mon, 24 Jul 2023 14:10:51 +0000
Date:   Mon, 24 Jul 2023 07:10:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/294: reject zoned devices for now
Message-ID: <ZL6Ga9zRjBmAEmA/@infradead.org>
References: <20230724030423.92390-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724030423.92390-1-wqu@suse.com>
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

On Mon, Jul 24, 2023 at 11:04:23AM +0800, Qu Wenruo wrote:
> The test case itself is utilizing RAID5/6, which is not yet supported on
> zoned device.
> 
> In the future we would use raid-stripe-tree (RST) feature, but for now
> just reject zoned devices completely.
> 
> And since we're here, also update the _fixed_by_kernel_commit lines, as
> the proper fix is already merged upstream.

Hmm, instead of spreading these checks, shouldn't we check that the
RAID level is supported, and have one single nob for that based off
it, similar to _btrfs_get_profile_configs()?

