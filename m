Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390AA53692A
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 01:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355168AbiE0X0L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 19:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiE0X0L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 19:26:11 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C146B020
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 16:26:06 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nujLI-0007PU-AP by authid <merlin>; Fri, 27 May 2022 16:26:04 -0700
Date:   Fri, 27 May 2022 16:26:04 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220527232604.GA22722@merlins.org>
References: <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
 <20220526173119.GC1751747@merlins.org>
 <CAEzrpqemPU_=VTxGEQS2WtGiaGbHy+ssnj5MKyh=8JC36uyZ6Q@mail.gmail.com>
 <20220526181246.GA28329@merlins.org>
 <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
 <20220526191512.GE28329@merlins.org>
 <CAEzrpqetTskf-UtyfXHBajpJBci4vxdSaBXwDTm5cRs2QtNRkw@mail.gmail.com>
 <20220526213924.GB2414966@merlins.org>
 <20220527011622.GA24951@merlins.org>
 <CAEzrpqdbuQGwwuCfYyVdiDtGDsPb=3FWmKrTEA5Xukk1ex514g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdbuQGwwuCfYyVdiDtGDsPb=3FWmKrTEA5Xukk1ex514g@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 27, 2022 at 02:35:05PM -0400, Josef Bacik wrote:
> I'm augmenting my tree-recover tool to go and find any missing chunks
> and add them in, which is what the chunk recover thing was supposed to
> do.  This is going to take a bit, but should be the last piece.

And by that you mean you're working on it and will tell me when it's
ready to pull, or did you forget git push?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
