Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38085220BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347146AbiEJQKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347142AbiEJQKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 12:10:24 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A925A2D8
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 09:06:02 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58508 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1noSN6-0004lB-SB by authid <merlins.org> with srv_auth_plain; Tue, 10 May 2022 09:06:01 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1noSN6-00169G-Lo; Tue, 10 May 2022 09:06:00 -0700
Date:   Tue, 10 May 2022 09:06:00 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220510160600.GG12542@merlins.org>
References: <20220509171929.GY12542@merlins.org>
 <CAEzrpqft5yq1cMFC_zdHDpOyHc0POQTNkKyW2rKhyHuoN+av6Q@mail.gmail.com>
 <20220510010826.GG29107@merlins.org>
 <CAEzrpqfePZhBvRy_G2kpo=oRPqoJx=F3Xmh7YF5m6pjMjGJ=Fg@mail.gmail.com>
 <20220510013201.GH29107@merlins.org>
 <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
 <20220510021916.GB12542@merlins.org>
 <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
 <20220510143739.GC12542@merlins.org>
 <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
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

On Tue, May 10, 2022 at 11:20:51AM -0400, Josef Bacik wrote:
> > looking for this?
> > processed 49152 of 0 possible bytes, 0%adding a bytenr that overlaps our thing, dumping paths for [4075, 108, 0]
> > Couldn't find any paths for this inode
> >
> 
> Yup that was it, now it makes sense, I've fixed it hopefully.  Thanks,

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
processed 108249088 of 108756992 possible bytes, 99%
Found an overlapping extent orig [10467701948416 10467702210560] current [10467695652864 10467704328192]
I'm going to give you 10 seconds to bail if that doesn't look right, I'll only ask 5 times before I just assume I didn't break anything1
2
3
4
5
6
7
8
9
10
The original extent is older, deleting it
Couldn't find any paths for this inode
Deleting [4075, 108, 0] root 15645018177536 path top 15645018177536 top slot 3 leaf 6781245898752 slot 66

searching 165198 for bad extents
processed 108249088 of 108756992 possible bytes, 99%
Found an overlapping extent orig [10467701948416 10467702210560] current [10467695652864 10467704328192]
I'm going to give you 10 seconds to bail if that doesn't look right, I'll only ask 5 times before I just assume I didn't break anything1
2
3
4
5
6
7
8
9
10
The original extent is older, deleting it
Couldn't find any paths for this inode
ERROR: error searching for key?? -2

wtf
it failed?? -2
ERROR: failed to clear bad extents
doing close???
ERROR: commit_root already set when starting transaction
WARNING: reserved space leaked, flag=0x4 bytes_reserved=32768
extent buffer leak: start 15645018177536 len 16384
extent buffer leak: start 15645018783744 len 16384
extent buffer leak: start 15645018783744 len 16384
WARNING: dirty eb leak (aborted trans): start 15645018783744 len 16384
extent buffer leak: start 6781245915136 len 16384
extent buffer leak: start 6781245915136 len 16384
WARNING: dirty eb leak (aborted trans): start 6781245915136 len 16384
Init extent tree failed
[Inferior 1 (process 2234) exited with code 0376]

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
