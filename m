Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090AF59192A
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 09:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiHMHMz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 03:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMHMy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 03:12:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1921459B1
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 00:12:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6460B68AA6; Sat, 13 Aug 2022 09:12:49 +0200 (CEST)
Date:   Sat, 13 Aug 2022 09:12:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: [PATCH] Revert "btrfs: fix repair of compressed extents" and
 "btrfs: pass a btrfs_bio to btrfs_repair_one_sector"
Message-ID: <20220813071249.GA11285@lst.de>
References: <09b666a5e355472749a243946a9199ce2d6cef77.1660370422.git.wqu@suse.com> <20220813061901.GA10401@lst.de> <ff84cdb1-fb69-ca19-d82d-658c976c89da@gmx.com> <8b8b669c-fe7b-70d7-df2a-d9f0339d6372@gmx.com> <20220813070249.GB11075@lst.de> <f9ccaa97-3616-8611-614b-4ea9f73a38a0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ccaa97-3616-8611-614b-4ea9f73a38a0@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 13, 2022 at 03:06:12PM +0800, Qu Wenruo wrote:
> But my question is, do this behavior has any perf benefit?
>
> IIRC block layer should be more clever than us?

It will slightly reduce memory usage as no other bio is allocated,
and it will save a small number of CPU cycles because there is no
need to perform the merge.  But compared to the complexity I doubt
it is worth it.
