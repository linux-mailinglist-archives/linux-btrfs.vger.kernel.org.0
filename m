Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F1874004E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjF0QHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjF0QHd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 12:07:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603C2D7B
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/EL3zOULDbITd3p9nBcBV1EKUekiZ25/pUxLKi3OgpI=; b=X7W3x3OTkJmBNKxW1dRtFdDqXG
        sgjeMgfnubwMycX1hHaaf4/57H91+So1j+pbaWvvqNvYOlYtrSGBcxto2WnZfBBrD/sFCW80ZGgJ9
        4X+oefYs/+h5b6maItpV2KcTgDIu8l7FsPnhXqFNON7mrJTSes/Q9Bt3isn8bMkj18HyLJjg3e/T7
        ZVKFLAjAeQT6RQu8J9fPw6T4FV1yApLDoQ7CeKALwozxp3tkTCBuN3mnnao7mPa6HEbXonmWKtxu6
        Ww7fXtooshXX25BlpCYuI56NyvpDtCBFYibILsNFUARDulsFnmqcazHe5eKW1Xife38TWSShc5e9j
        VS2sdCdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEBE4-00Db3h-0m;
        Tue, 27 Jun 2023 16:07:32 +0000
Date:   Tue, 27 Jun 2023 09:07:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add comments for btrfs_map_block()
Message-ID: <ZJsJRMQx3oNSaEOk@infradead.org>
References: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
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

On Tue, Jun 27, 2023 at 03:34:31PM +0800, Qu Wenruo wrote:
> + * @mirror_num_ret:	(Mandatory) returned mirror number if the original
> + *			value is 0.

This one is optional.

> + *
> + * @need_raid_map:	(Deprecated) whether the map wants a full stripe map
> + *			(including all data and P/Q stripes) for RAID56.
> + *			Should always be 1 except for legacy call sites.
> + */

Saying deprecated for a paramter to function with just a few callers
feels weird.  For this patch I'd just stick to a functional description.

As far as I can tell need_raid_map just creates extra overhead when
used on a paritty RAID BG, but is othr wise harmless and only
btrfsic_map_block clears it to 0.  Maybe add a follow on patch to just
remove the paramter and waste the little bit of extra effort to build
the raid map for btrfsic_map_block?

