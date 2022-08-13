Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4553591914
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiHMG6i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 02:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMG6i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 02:58:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F5025EB7
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 23:58:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C709668AA6; Sat, 13 Aug 2022 08:58:33 +0200 (CEST)
Date:   Sat, 13 Aug 2022 08:58:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: [PATCH] Revert "btrfs: fix repair of compressed extents" and
 "btrfs: pass a btrfs_bio to btrfs_repair_one_sector"
Message-ID: <20220813065833.GA11075@lst.de>
References: <09b666a5e355472749a243946a9199ce2d6cef77.1660370422.git.wqu@suse.com> <20220813061901.GA10401@lst.de> <ff84cdb1-fb69-ca19-d82d-658c976c89da@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff84cdb1-fb69-ca19-d82d-658c976c89da@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 13, 2022 at 02:53:09PM +0800, Qu Wenruo wrote:
> But indeed, if we allow that, it would be a much simpler fix.
>
> Mind me to introduce a patch to add a new page offset contingous check
> to the related code path?

I had just started on passing the arguments again, but I'll switch
to this version.  It should be simpler, and will also allow to remove
quite a bit code related to this case later on.
