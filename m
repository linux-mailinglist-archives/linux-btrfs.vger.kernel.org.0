Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27221521D79
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345572AbiEJPJL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 11:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345605AbiEJPIv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 11:08:51 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E494626AED
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 07:37:40 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58498 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1noQzc-0001vF-02 by authid <merlins.org> with srv_auth_plain; Tue, 10 May 2022 07:37:40 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1noQzb-000xLN-P5; Tue, 10 May 2022 07:37:39 -0700
Date:   Tue, 10 May 2022 07:37:39 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220510143739.GC12542@merlins.org>
References: <20220509170054.GW12542@merlins.org>
 <CAEzrpqccXWAEELYsY0NQ+ZzecQygJFasipt3yE=0L1KA3GgzYg@mail.gmail.com>
 <20220509171929.GY12542@merlins.org>
 <CAEzrpqft5yq1cMFC_zdHDpOyHc0POQTNkKyW2rKhyHuoN+av6Q@mail.gmail.com>
 <20220510010826.GG29107@merlins.org>
 <CAEzrpqfePZhBvRy_G2kpo=oRPqoJx=F3Xmh7YF5m6pjMjGJ=Fg@mail.gmail.com>
 <20220510013201.GH29107@merlins.org>
 <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
 <20220510021916.GB12542@merlins.org>
 <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 10, 2022 at 09:21:33AM -0400, Josef Bacik wrote:
> On Mon, May 9, 2022 at 10:19 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Mon, May 09, 2022 at 10:03:27PM -0400, Josef Bacik wrote:
> > > On Mon, May 9, 2022 at 9:32 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > On Mon, May 09, 2022 at 09:18:32PM -0400, Josef Bacik wrote:
> > > > > On Mon, May 9, 2022 at 9:08 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > > >
> > > > > > On Mon, May 09, 2022 at 09:04:36PM -0400, Josef Bacik wrote:
> > > > > > > On Mon, May 9, 2022 at 1:19 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, May 09, 2022 at 01:09:37PM -0400, Josef Bacik wrote:
> > > > > > > > > Ugh shit, I had an off by one error, that's not great.  I've fixed
> > > > > > > > > that up and adjusted the debugging, lets see how that goes.  Thanks,
> > > > > > > >
> > > > > > >
> > > > > > > Sorry my laptop battery died while I was at the dealership, and of
> > > > > > > course that took allllll day.  Anyway pushed some debugging, am
> > > > > > > confused, hopefully won't be confused long.  Thanks,
> > > > > >
> > > > > > Sorry :-/
> > > > > > Yeah, I bring my power supply in such cases :)
> > > > > >
> > > > > > Did you upload?
> > > > > > sauron:/var/local/src/btrfs-progs-josefbacik# git pull
> > > > > > Already up to date.
> > > > >
> > > > > Sorry, long day, try it again.  Thanks,
> > > >
> > > > processed 49152 of 75792384 possible bytes, 0%
> > > > Recording extents for root 165098
> > > > processed 1015808 of 108756992 possible bytes, 0%
> > > > Recording extents for root 165100
> > > > processed 16384 of 49479680 possible bytes, 0%
> > > > Recording extents for root 165198
> > > > processed 491520 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
> > > > misc/add0/new/file
> > > > Failed to find [10467695652864, 168, 8675328]
> > >
> > > Ugh such a pain, lets try this again,
> >
> >
> > Looks the same?
> 
> There's no other debug printing before this?  Can I get the full
> output from the run?  If there isn't something really wonky is going
> on and I'm confused.  Thanks,

looking for this?
processed 49152 of 0 possible bytes, 0%adding a bytenr that overlaps our thing, dumping paths for [4075, 108, 0]
Couldn't find any paths for this inode

fuller output:
inserting block group 15831849238528
inserting block group 15832922980352
inserting block group 15833996722176
inserting block group 15835070464000
inserting block group 15836144205824
inserting block group 15837217947648
inserting block group 15838291689472
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
searching 4 for bad extents
processed 1032192 of 1064960 possible bytes, 96%
searching 5 for bad extents
processed 10960896 of 10977280 possible bytes, 99%
searching 7 for bad extents
processed 16384 of 16545742848 possible bytes, 0%
searching 9 for bad extents
processed 16384 of 16384 possible bytes, 100%
searching 11221 for bad extents
processed 16384 of 255983616 possible bytes, 0%
searching 11222 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 11223 for bad extents
prIgnoring transid failure35549184 possible bytes, 99%
processed 1635319808 of 1635549184 possible bytes, 99%
searching 11224 for bad extents
processed 75792384 of 75792384 possible bytes, 100%
searching 159785 for bad extents
processed 108429312 of 108429312 possible bytes, 100%
searching 159787 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 160494 for bad extents
processed 108560384 of 108560384 possible bytes, 100%
searching 160496 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 161197 for bad extents
processed 108544000 of 108544000 possible bytes, 100%
searching 161199 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 162628 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 162632 for bad extents
processed 108691456 of 108691456 possible bytes, 100%
searching 162645 for bad extents
processed 75792384 of 75792384 possible bytes, 100%
searching 163298 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 163302 for bad extents
processed 108691456 of 108691456 possible bytes, 100%
searching 163303 for bad extents
processed 71745536 of 75792384 possible bytes, 94%
searching 163316 for bad extents
processed 108691456 of 108691456 possible bytes, 100%
searching 163318 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 163916 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 163920 for bad extents
processed 108691456 of 108691456 possible bytes, 100%
searching 163921 for bad extents
processed 75792384 of 75792384 possible bytes, 100%
searching 164620 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 164624 for bad extents
processed 102318080 of 109445120 possible bytes, 93%
searching 164633 for bad extents
processed 75792384 of 75792384 possible bytes, 100%
searching 165098 for bad extents
processed 108756992 of 108756992 possible bytes, 100%
searching 165100 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 165198 for bad extents
processed 108756992 of 108756992 possible bytes, 100%
searching 165200 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 165294 for bad extents
processed 49479680 of 49479680 possible bytes, 100%
searching 165298 for bad extents
processed 108756992 of 108756992 possible bytes, 100%
searching 165299 for bad extents
processed 75792384 of 75792384 possible bytes, 100%
searching 18446744073709551607 for bad extents
processed 16384 of 16384 possible bytes, 100%
Recording extents for root 3
processed 1556480 of 0 possible bytes, 0%
Recording extents for root 1
processed 49152 of 0 possible bytes, 0%adding a bytenr that overlaps our thing, dumping paths for [4075, 108, 0]
Couldn't find any paths for this inode
doing an insert that overlaps our bytenr 10467701948416 262144
processed 1474560 of 0 possible bytes, 0%
doing roots
Recording extents for root 4
processed 1032192 of 1064960 possible bytes, 96%
Recording extents for root 5
processed 10960896 of 10977280 possible bytes, 99%
Recording extents for root 7
processed 16384 of 16545742848 possible bytes, 0%
Recording extents for root 9
processed 16384 of 16384 possible bytes, 100%
Recording extents for root 11221
processed 16384 of 255983616 possible bytes, 0%
Recording extents for root 11222
processed 49479680 of 49479680 possible bytes, 100%
Recording extents for root 11223
processed 1619902464 of 1635549184 possible bytes, 99%Ignoring transid failure
processed 1635319808 of 1635549184 possible bytes, 99%
Recording extents for root 11224
processed 75792384 of 75792384 possible bytes, 100%
Recording extents for root 159785
processed 108429312 of 108429312 possible bytes, 100%
Recording extents for root 159787
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 160494
processed 1425408 of 108560384 possible bytes, 1%
Recording extents for root 160496
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 161197
processed 770048 of 108544000 possible bytes, 0%
Recording extents for root 161199
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 162628
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 162632
processed 2441216 of 108691456 possible bytes, 2%
Recording extents for root 162645
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 163298
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 163302
processed 966656 of 108691456 possible bytes, 0%
Recording extents for root 163303
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 163316
processed 933888 of 108691456 possible bytes, 0%
Recording extents for root 163318
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 163916
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 163920
processed 966656 of 108691456 possible bytes, 0%
Recording extents for root 163921
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 164620
processed 49152 of 49479680 possible bytes, 0%
Recording extents for root 164624
processed 98304 of 109445120 possible bytes, 0%
Recording extents for root 164633
processed 49152 of 75792384 possible bytes, 0%
Recording extents for root 165098
processed 1015808 of 108756992 possible bytes, 0%
Recording extents for root 165100
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 165198
processed 491520 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467
695652864 8675328
misc/file
Failed to find [10467695652864, 168, 8675328]
Program received signal SIGSEGV, Segmentation fault.

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
