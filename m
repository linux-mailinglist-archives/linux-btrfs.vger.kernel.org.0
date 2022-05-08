Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD27D51F0DD
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 May 2022 21:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiEHTty (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 May 2022 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiEHTtu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 May 2022 15:49:50 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484FBF42
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 12:45:59 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58460 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nnmqr-0002L1-Tw by authid <merlins.org> with srv_auth_plain; Sun, 08 May 2022 12:45:57 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nnmqr-00EQ9N-N0; Sun, 08 May 2022 12:45:57 -0700
Date:   Sun, 8 May 2022 12:45:57 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220508194557.GP12542@merlins.org>
References: <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
 <20220503172425.GA12542@merlins.org>
 <20220505150821.GB1020265@merlins.org>
 <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com>
 <20220506031910.GH12542@merlins.org>
 <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
 <CAEzrpqdzdimQvXyhpDomvPgDXx5Dn9QCEKQMiXofTFb3WvWUJQ@mail.gmail.com>
 <20220507153921.GG1020265@merlins.org>
 <CAEzrpqcRT6CqJJPYqW5AH+x0XvUCMd-EMEq-=SwtTL-Fn4pcvQ@mail.gmail.com>
 <20220507193628.GO12542@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507193628.GO12542@merlins.org>
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

On Sat, May 07, 2022 at 12:36:28PM -0700, Marc MERLIN wrote:
> On Sat, May 07, 2022 at 02:58:38PM -0400, Josef Bacik wrote:
> > Did any of the previous ones succeed?  I hope so and we just have one
> > misbehaving thing.  I've pushed more debugging, maybe it's a large
> > file that has a lot of broken extents, in either case it'll tell us
> > what's going on so I can narrow down the problem.  Thanks,
> 
> Ok, the debugging helps, now I can see that it's deleting different
> blocks for the same filename.
> Before I couldn't quite tell if it was making progress, but now I see
> it's deleting new locations. 
> Looks like I have 100s of deletions coming up, thanks for automating
> this.
> 
> Will report back, it looks like it may run for a few hours
> 
> Afer that just do a 
> check --repair
> or some other command options?

Ok, so I got 33GB of output, so glad the tool is automated and the tool
died eventually.
I'll re-run under gdb, at least it did a lot of work.

searching 165298 for bad extents
processed 108707840 of 108756992 possible bytes, 99%
Found an extent we don't have a block group for in the file
inode ref info failed???
History/Clubbing/20220318_Pure_Markus_Schulz.mp4
Deleting [76600, 108, 111673344] root 13576824389632 path top 13576824389632 top slot 24 leaf 11821927333888 slot 52

searching 165298 for bad extents
processed 108707840 of 108756992 possible bytes, 99%
Found an extent we don't have a block group for in the file
inode ref info failed???
History/Clubbing/20220318_Pure_Markus_Schulz.mp4
Deleting [76600, 108, 228950016] root 13576824406016 path top 13576824406016 top slot 24 leaf 11821927350272 slot 52

searching 165298 for bad extents
processed 108756992 of 108756992 possible bytes, 100%
searching 165299 for bad extents
processed 75792384 of 75792384 possible bytes, 100%
searching 18446744073709551607 for bad extents
processed 16384 of 16384 possible bytes, 100%
Recording extents for root 3
Floating point exception

I'll re-run and hopefully it will finish without dying or I'll get a backtrace.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
