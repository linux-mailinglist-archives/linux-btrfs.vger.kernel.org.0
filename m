Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104B3517965
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 23:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379908AbiEBVws (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 17:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245442AbiEBVwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 17:52:47 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FBE65D0
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 14:49:17 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nlduu-00007Q-QJ by authid <merlin>; Mon, 02 May 2022 14:49:16 -0700
Date:   Mon, 2 May 2022 14:49:16 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220502214916.GB29107@merlins.org>
References: <20220501045456.GL12542@merlins.org>
 <CAEzrpqe-92ZV-YqL8v9z1TV4wnqbVUjroTMsvC86z6Vws3Rb6A@mail.gmail.com>
 <20220501152231.GM12542@merlins.org>
 <CAEzrpqeiWrW6NbWLmUiWwE96sVNb+H0bEXmaij1K-HJQ38vL7w@mail.gmail.com>
 <20220502012528.GA29107@merlins.org>
 <CAEzrpqdWyOivUQ3ZtE2DS-ME7=Fs_UJN=nzA_VhosS5o3bZ+Uw@mail.gmail.com>
 <20220502173459.GP12542@merlins.org>
 <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
 <20220502200848.GR12542@merlins.org>
 <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
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

On Mon, May 02, 2022 at 05:03:40PM -0400, Josef Bacik wrote:
> Ok I've fixed it to yell about what file has this weird extent so you
> can delete it and we can carry on.  Thanks,

That worked.  How do I delete this one?

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
Recording extents for root 11223
processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819130,108,0 on root 11223
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0027_2020.1_0602_1208.xz
cmds/rescue-init-extent-tree.c:654: process_eb: BUG_ON `1` triggered, value 1
./btrfs(+0x8b9fc)[0x5575fbec99fc]
./btrfs(+0x8c0df)[0x5575fbeca0df]
./btrfs(+0x8c22d)[0x5575fbeca22d]
./btrfs(+0x8c22d)[0x5575fbeca22d]
./btrfs(+0x8c49b)[0x5575fbeca49b]
./btrfs(btrfs_init_extent_tree+0xe03)[0x5575fbecb37b]
./btrfs(+0x83b7d)[0x5575fbec1b7d]
./btrfs(handle_command_group+0x49)[0x5575fbe5617b]
./btrfs(main+0x94)[0x5575fbe56275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7fa2455a77fd]
./btrfs(_start+0x2a)[0x5575fbe55e1a]
Aborted


Thanks
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
