Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F8F4EB2D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 19:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbiC2Rmr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 13:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbiC2Rmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 13:42:44 -0400
X-Greylist: delayed 1359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 10:41:01 PDT
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F1C2A24C
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 10:41:01 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:48628 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nZFU3-0005oi-4n by authid <merlins.org> with srv_auth_plain; Tue, 29 Mar 2022 10:18:19 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nZFU2-003NgG-Iy; Tue, 29 Mar 2022 10:18:18 -0700
Date:   Tue, 29 Mar 2022 10:18:18 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20220329171818.GD1314726@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718002451.GF10237@merlins.org>
 <20200524213059.GI23519@merlins.org>
 <20200525203916.GB19850@merlins.org>
 <20200707035530.GP30660@merlins.org>
 <20200707172523.GQ30660@merlins.org>
 <20200708041041.GN1552@merlins.org>
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

Howdy,

This is the followup I was hoping I'd never have to send.

kernel was 5.7 (long uptime, just upgraded to 5.16).

One raid5 drive failed, and as I was replacing it, another one went
offline, but not in a way that the md5 array was taken down.
I shut the the system down, replaced the bad drive, the 2nd drive that
went down wasn't really down, so I broght back the array with a drive
missing.

mdadm --assemble --run --force /dev/md7 /dev/sd[gijk]1
cryptsetup luksOpen /dev/bcache3 dshelf1a
btrfs device scan --all-devices
mount /dev/mapper/dshelf1a /mnt/btrfs_pool1/

BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
BTRFS error (device dm-17): failed to read chunk tree: -5
BTRFS error (device dm-17): open_ctree failed

It's a pretty massive array that will take a *long* time to recover from
backup. If there is a reaosnable way to bring it back up, I'd be
appreciative.

gargamel:~# mount -o ro,recovery /dev/mapper/dshelf1a /mnt/btrfs_pool1/
BTRFS info (device dm-17): flagging fs with big metadata feature
BTRFS warning (device dm-17): 'recovery' is deprecated, use 'rescue=usebackuproot' instead
BTRFS info (device dm-17): trying to use backup root at mount time
BTRFS info (device dm-17): disk space caching is enabled
BTRFS info (device dm-17): has skinny extents
BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
BTRFS error (device dm-17): failed to read chunk tree: -5
BTRFS error (device dm-17): open_ctree failed

Worst case, if it's dead, I'm still happy to try btrfs check lowmem to
see if it has gotten better.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
