Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D964527AD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 01:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiEOXBy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 19:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiEOXBx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 19:01:53 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117A8186D4
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 16:01:48 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:50634 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nqNFE-00047h-35 by authid <merlins.org> with srv_auth_plain; Sun, 15 May 2022 16:01:48 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nqNFD-002YwV-Qh; Sun, 15 May 2022 16:01:47 -0700
Date:   Sun, 15 May 2022 16:01:47 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220515230147.GD13006@merlins.org>
References: <CAEzrpqfYg=Zf_GYjyvc+WZsnoCjiPTAS-08C_rB=gey74DGUqA@mail.gmail.com>
 <20220515025703.GA13006@merlins.org>
 <CAEzrpqfpXVBoWdAzXEYG+RdhOMZFUbWBf6GKcQ6AwL77Mtzjgg@mail.gmail.com>
 <20220515144145.GB13006@merlins.org>
 <CAEzrpqcVRJFS6HN4L7=tu0Z8SA+E2GsLJzWEADRK3iJvdVy4EA@mail.gmail.com>
 <20220515153347.GA8056@merlins.org>
 <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
 <20220515154122.GB8056@merlins.org>
 <CAEzrpqc6MyW0t1H9ue_GQL-1AhgpWfumBfj3MK0eGstwJ3R1aw@mail.gmail.com>
 <20220515212951.GC13006@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515212951.GC13006@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 15, 2022 at 02:29:51PM -0700, Marc MERLIN wrote:
> Now check --repair will be running for while, will report back...
 
It wasn't as bad as I thought.
It fixed a bunch of things (long output, I have it saved if needed),
mostly orphanned stuff.
and finished with
root 165299 inode 95698 errors 1000, some csum missing
root 165299 inode 95699 errors 1000, some csum missing
root 165299 inode 95700 errors 1000, some csum missing
root 165299 inode 95701 errors 1000, some csum missing
root 165299 inode 95702 errors 1000, some csum missing
root 165299 inode 95703 errors 1000, some csum missing
root 165299 inode 95704 errors 1000, some csum missing
root 165299 inode 95705 errors 1000, some csum missing
ERROR: errors found in fs roots
found 56720129146880 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 8334311424
total fs tree bytes: 7565082624
total extent tree bytes: 752779264
btree space waste bytes: 1336306596
file data blocks allocated: 59257396740096
 referenced 59313065607168

But I still can't mount the FS:
[1802750.985454] BTRFS info (device dm-1): disk space caching is enabled
[1802751.039629] BTRFS info (device dm-1): has skinny extents
[1802751.401992] BTRFS error (device dm-1): dev extent physical offset 941709328384 on devid 1 doesn't have corresponding chunk
[1802751.437568] BTRFS error (device dm-1): failed to verify dev extents against chunks: -117
[1802751.482104] BTRFS error (device dm-1): open_ctree failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
