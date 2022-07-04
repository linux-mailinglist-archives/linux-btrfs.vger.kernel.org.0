Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8C56542C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 13:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiGDLyt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 07:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiGDLyr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 07:54:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DE7E0C5
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F0hmNwh6YNHfMa2rk36CEl1k52TpLyiMYrMzcHG6zy0=; b=TUaq+tKwLXouD3eJ7pnsImsDdb
        m6ca6qsy8wW8loEHGeORxHJY2FtbieOGrgvJFpoksfYgYQW4HcAWJb0Pl242nTTS188f4VLSpcdZO
        HLYf944nRzuFqLP0oQUp9oMF0cmHz6sl85M3nzJR4hTi2tAXIRYT6VpFONkTVMvwcOE730qFWU6n0
        vrWrubZevKOlIAmqeuIiRsxwYZmH3txB/cs2zvaeJoiyJ/jZn76bHX4O2kFoC1o9uMh4XDd4Hu6pb
        zBzvRzvGKQX3ovd987/PeUZ0/osW7sbjGv0C7TxIYZyU6qMUN1XLvDv3s46rAU0YSnoB2QIU12slx
        t8sf37eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Kf6-008C90-Un; Mon, 04 Jul 2022 11:54:44 +0000
Date:   Mon, 4 Jul 2022 04:54:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Message-ID: <YsLVBP/a3B50sl3t@infradead.org>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <687ec8ab8c61a9972d6936cdf189dc5756299051.1656909695.git.naohiro.aota@wdc.com>
 <SA0PR04MB7418687C061CAD8104CDE8BF9BBE9@SA0PR04MB7418.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR04MB7418687C061CAD8104CDE8BF9BBE9@SA0PR04MB7418.namprd04.prod.outlook.com>
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

On Mon, Jul 04, 2022 at 09:33:32AM +0000, Johannes Thumshirn wrote:
> > @@ -723,6 +732,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
> >  	}
> >  
> >  	fs_info->zone_size = zone_size;
> > +	fs_info->max_zone_append_size = max_zone_append_size;
> >  	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
> >  
> >  	/*
> 
> Thinking a bit more of this, this need to be the min() of all 
> max_zone_append_size values of the underlying devices, because even as of now
> zoned btrfs supports multiple devices on a single FS.

Yes.
