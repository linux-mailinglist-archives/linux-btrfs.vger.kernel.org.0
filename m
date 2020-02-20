Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8B4166A0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 22:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgBTVq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 16:46:57 -0500
Received: from magic.merlins.org ([209.81.13.136]:50240 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgBTVq5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 16:46:57 -0500
Received: from [207.164.22.11] (port=44083 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1j4tel-00034a-NB by authid <merlins.org> with srv_auth_plain; Thu, 20 Feb 2020 13:46:51 -0800
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1j4tej-0007xY-QD; Thu, 20 Feb 2020 13:46:49 -0800
Date:   Thu, 20 Feb 2020 13:46:49 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Roman Mamedov <rm@romanrm.net>
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
Message-ID: <20200220214649.GD26873@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2656316.bop9uDDU3N@merkaba>
 <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-No-Run: Yes
X-Broken-Reverse-DNS: no host name for IP address 207.164.22.11
X-SA-Exim-Connect-IP: 207.164.22.11
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Well, turns out this was a more serious bug than we thought.
With dm-thin overcommit, it causes this:
[1324107.675334] BTRFS info (device dm-13): forced readonly
[1324107.692909] BTRFS warning (device dm-13): Skipping commit of aborted transaction.
[1324107.717141] BTRFS: error (device dm-13) in cleanup_transaction:1828: errno=-5 IO failure
[1324107.743298] BTRFS info (device dm-13): delayed_refs has NO entry
[1324107.817671] device-mapper: thin: 252:9: switching pool to write mode
[1324108.662095] BTRFS error (device dm-13): bad tree block start, want 9050645626880 have 0
[1324108.694286] BTRFS error (device dm-13): bad tree block start, want 9050645626880 have 0

In other words, this broke my filesystem. I didn't try to see if it's damaged or just read-only,
but obviously, this isn't good.

New kernel should stop this from happening hopefully.

VG/dm details if you care:
  VG Name               vgds2
  System ID             
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  88
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                8
  Open LV               7
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               14.55 TiB
  PE Size               4.00 MiB
  Total PE              3815316
  Alloc PE / Size       3801146 / 14.50 TiB
  Free  PE / Size       14170 / 55.35 GiB
  VG UUID               pc1cTH-kFo7-g0Kz-dELp-j51s-1yOO-v20WIV
   
  --- Logical volume ---
  LV Name                thinpool2
  VG Name                vgds2
  LV UUID                rxJCsT-ImNv-ibvM-zOS0-Xzqv-O8AU-1STUH9
  LV Write Access        read/write
  LV Creation host, time gargamel.svh.merlins.org, 2018-07-26 08:42:51 -0700
  LV Pool metadata       thinpool2_tmeta
  LV Pool data           thinpool2_tdata
  LV Status              available
  # open                 8
  LV Size                14.50 TiB
  Allocated pool data    99.99%
  Allocated metadata     59.88%
  Current LE             3801088
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           252:9

  LV Path                /dev/vgds2/ubuntu
  LV Name                ubuntu
  VG Name                vgds2
  LV UUID                y42AA8-5zfq-Vbmr-TNo9-g7rn-UbGf-KOnFrf
  LV Write Access        read/write
  LV Creation host, time gargamel.svh.merlins.org, 2018-07-26 23:22:18 -0700
  LV Pool name           thinpool2
  LV Status              available
  # open                 1
  LV Size                14.00 TiB
  Mapped size            60.26%
  Current LE             3670016
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           252:13


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
