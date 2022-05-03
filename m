Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF8517BAC
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 03:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiECB3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 21:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiECB3i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 21:29:38 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4E0E015
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 18:26:04 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58382 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nlhIg-00032X-Tk by authid <merlins.org> with srv_auth_plain; Mon, 02 May 2022 18:26:02 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nlhIg-0009BL-N9; Mon, 02 May 2022 18:26:02 -0700
Date:   Mon, 2 May 2022 18:26:02 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220503012602.GT12542@merlins.org>
References: <20220502012528.GA29107@merlins.org>
 <CAEzrpqdWyOivUQ3ZtE2DS-ME7=Fs_UJN=nzA_VhosS5o3bZ+Uw@mail.gmail.com>
 <20220502173459.GP12542@merlins.org>
 <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
 <20220502200848.GR12542@merlins.org>
 <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
 <20220502214916.GB29107@merlins.org>
 <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
 <20220502234135.GC29107@merlins.org>
 <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
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

On Mon, May 02, 2022 at 09:06:50PM -0400, Josef Bacik wrote:
> It's a different inode number, 1819131 instead of 1819130.  This is
> going to be the frustrating delete shit until it works thing again.

Indeed, I missed that.

Now I'm stuck here:
Recording extents for root 11223
processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819133,108,0 on root 11223
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0410_2020.1_0602_1208.xz


gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819133,108,0" -r 11223 /dev/mapper/dshelf1
FS_INFO IS 0x55ca68c6d600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55ca68c6d600
parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
couldn't find root 11223

Mmmh, that's not great looking....

doing roots
Recording extents for root 4
processed 1032192 of 1064960 possible bytes
Recording extents for root 5
processed 10960896 of 10977280 possible bytes
Recording extents for root 7
processed 16384 of 16545742848 possible bytes
Recording extents for root 9
processed 16384 of 16384 possible bytes
Recording extents for root 11221
processed 16384 of 255983616 possible bytes
Recording extents for root 11222
processed 49479680 of 49479680 possible bytes
Ignoring transid failure
Recording extents for root 11223
processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819133,108,0 on root 11223
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0410_2020.1_0602_1208.xz


gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819133,108,0" -r 11223 /dev/mapper/dshelf1
FS_INFO IS 0x56267a388600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x56267a388600
parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
couldn't find root 11223

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
