Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1AB740A09
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjF1H42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 03:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjF1Hyk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361651FE4
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 00:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CnqO/jvyGcJAtqWfFo8TlP3gFI5IB5AUQ2SRPQwdAVs=; b=Xx6TcWic4Tbptmk6cS+gtNeQOI
        SI3rFaOXq08oz3tagSi4qI8j+iFMi6c8uB7muK1HhxRpFX+jKCnCFuD/Y902cQozUMpSKj0tZpgHJ
        YoT36/oq0FJYmRLL/T8n/lGsfLTL9PrJiJuVvWzqRy/kfzUlz30NzLxzE1uslDcZt/2q6TB0TqcMO
        DYV06QhAL0Dn0dR6pmDj2mmMxHVEigq+vAxbjKSj7AlcHqO8GLgIWiNc0glkyqVqZEpRMOoMp20JT
        JZLhGmWn+KJM5YC/vsBh2Lemto8AdvxWWINmia/Dg9YhypLR/7DCCIzNSiOH18jEvznObbctFPHln
        Hv45fd9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qENHN-00EpsO-0G;
        Wed, 28 Jun 2023 04:59:45 +0000
Date:   Tue, 27 Jun 2023 21:59:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add comments for btrfs_map_block()
Message-ID: <ZJu+QbMPrvoqZpij@infradead.org>
References: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
 <ZJsJRMQx3oNSaEOk@infradead.org>
 <286ad810-f239-5fd8-92e3-fbf5f7c387a2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286ad810-f239-5fd8-92e3-fbf5f7c387a2@gmx.com>
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

On Wed, Jun 28, 2023 at 06:00:56AM +0800, Qu Wenruo wrote:
> Really it's btrfsic_map_block() the only exception.
> 
> >  Maybe add a follow on patch to just
> > remove the paramter and waste the little bit of extra effort to build
> > the raid map for btrfsic_map_block?
> > 
> 
> Well, I'd prefer to remove btrfsic_map_block() and the check_int thing
> completely.

I'm perfectly fine with removing it.  But I don't see why that needs
to delay dropping the raid_map argument.

