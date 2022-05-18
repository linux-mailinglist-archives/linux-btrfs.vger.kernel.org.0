Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7B452C315
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbiERTMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 15:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiERTMo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 15:12:44 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ABFFD347
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 12:12:42 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:50770 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nrP6A-0001W5-1S by authid <merlins.org> with srv_auth_plain; Wed, 18 May 2022 12:12:42 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nrP69-007TuY-RC; Wed, 18 May 2022 12:12:41 -0700
Date:   Wed, 18 May 2022 12:12:41 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220518191241.GI13006@merlins.org>
References: <CAEzrpqfMbB-sGLZUjGHjxHt1Gga+uULGkoZTqjXHwKnzsjP5aA@mail.gmail.com>
 <20220516151653.GF13006@merlins.org>
 <20220516153651.GG13006@merlins.org>
 <20220516165327.GD8056@merlins.org>
 <CAEzrpqfShQhaCVv1GY=JTTCO_T44ggidHFtbSABrcPCSNzY9hA@mail.gmail.com>
 <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com>
 <20220517202756.GK8056@merlins.org>
 <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
 <20220517212223.GL8056@merlins.org>
 <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
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

On Wed, May 18, 2022 at 02:26:36PM -0400, Josef Bacik wrote:
> Hrm crud, I've fixed this, but you may have to re-run the init's.  Start with
> 
> btrfs check --repair <device>
> 
> and then see if it works.  If not do
 
Block group[15360476577792, 1073741824] (flags = 1) didn't find the relative chunk.
Block group[15361550319616, 1073741824] (flags = 1) didn't find the relative chunk.
Block group[15362624061440, 1073741824] (flags = 1) didn't find the relative chunk.
Block group[15363697803264, 1073741824] (flags = 1) didn't find the relative chunk.
Block group[15364771545088, 1073741824] (flags = 1) didn't find the relative chunk.
Block group[15365845286912, 1073741824] (flags = 1) didn't find the relative chunk.
Block group[15366919028736, 1073741824] (flags = 1) didn't find the relative chunk.
failed to repair damaged filesystem, aborting

Starting repair.
Opening filesystem to check...
JOSEF: root 9
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e

> btrfs rescue init-extent-tree <device>

Whatever we did may have caused a bunch of new files to be invalid and have to be deleted.

searching 159785 for bad extents
processed 11304960 of 108429312 possible bytes, 10%
Found an extent we don't have a block group for in the file
file
Deleting [11142, 108, 1020231680] root 6781246029824 path top 6781246029824 top slot 2 leaf 3861741830144 slot 109

searching 159785 for bad extents
processed 11304960 of 108429312 possible bytes, 10%
Found an extent we don't have a block group for in the file
file
Deleting [11142, 108, 1020280832] root 6781246046208 path top 6781246046208 top slot 2 leaf 3861741846528 slot 109

searching 159785 for bad extents
processed 11304960 of 108429312 possible bytes, 10%
Found an extent we don't have a block group for in the file
file
Deleting [11142, 108, 1154498560] root 6781246029824 path top 6781246029824 top slot 2 leaf 3861741830144 slot 109

searching 159785 for bad extents
processed 11304960 of 108429312 possible bytes, 10%
Found an extent we don't have a block group for in the file
file
Deleting [11142, 108, 1288716288] root 6781246046208 path top 6781246046208 top slot 2 leaf 3861741846528 slot 10

Mmmh, it's deleted 2500 files already, I just stopped it
gargamel:~# grep -c Deleting /mnt/btrfs_space/ri1
2507

Safe to continue?

> btrfs rescue init-csum-tree <device>
> btrfs check <device>

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
