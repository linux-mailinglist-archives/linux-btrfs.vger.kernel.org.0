Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF864F542B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbiDFEjx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442508AbiDFDdi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 23:33:38 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC561F6346
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 17:08:45 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbtE4-0004Eq-7U by authid <merlin>; Tue, 05 Apr 2022 17:08:44 -0700
Date:   Tue, 5 Apr 2022 17:08:44 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220406000844.GK28707@merlins.org>
References: <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
 <20220405181108.GA28707@merlins.org>
 <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org>
 <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org>
 <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org>
 <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkzWAZtf7rcY/d+7@hungrycats.org>
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

On Tue, Apr 05, 2022 at 07:51:29PM -0400, Zygo Blaxell wrote:
> Other possibilites include irreproducible reads coming from the bcache
> layer if that's still active (e.g. if it was on mdadm raid1, and the

bcache is still active, correct.
mdadm5 array is running with 4 drives out of 5.

I'm not sure if I full understand the tree root issue we've been having.

We know from the dump that we have these backups
backup_tree_root:       13577814573056  gen: 1602089    level: 1
backup_tree_root:       13577775284224  gen: 1602086    level: 1
backup_tree_root:       13577821667328  gen: 1602087    level: 1
backup_tree_root:       13577779511296  gen: 1602088    level: 1

but they didn't seem to work, or are we sure that none of them don't?

Then we did a custom scan, but it found one of the 4 backup_tree_root we
already had, so that doesn't help, correct?
Found tree root at 13577814573056 gen 1602089 level 1

Was the expectation that there are more backup_tree_root hiding
somewhere and we've been trying to find them?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
