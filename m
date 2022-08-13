Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE9591904
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 08:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiHMGTI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 02:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiHMGTH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 02:19:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8866D8284D
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 23:19:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 113A168AA6; Sat, 13 Aug 2022 08:19:02 +0200 (CEST)
Date:   Sat, 13 Aug 2022 08:19:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Revert "btrfs: fix repair of compressed extents" and
 "btrfs: pass a btrfs_bio to btrfs_repair_one_sector"
Message-ID: <20220813061901.GA10401@lst.de>
References: <09b666a5e355472749a243946a9199ce2d6cef77.1660370422.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b666a5e355472749a243946a9199ce2d6cef77.1660370422.git.wqu@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 13, 2022 at 02:00:25PM +0800, Qu Wenruo wrote:
> To fix the problem, we need to revert commit 7aa51232e204 ("btrfs: pass
> a btrfs_bio to btrfs_repair_one_sector"), but unfortunately later commit
> 81bd9328ab9f ("btrfs: fix repair of compressed extents") has a
> dependency on that commit.

Let's try to sort this out properly intead of doing a blind revert before
-rc1.  I'll cook up a patch to pass an explicit offset ASAP as the quick
fix, but for the longer run:  is there such a huge benefit of having
these logically non-contigous bios?  They are so different from the
I/O stack in any other file systems that I think we'll keep running into
problems again an again.
