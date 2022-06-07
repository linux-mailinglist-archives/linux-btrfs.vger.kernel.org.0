Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193AE53F46B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 05:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiFGDWq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 23:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiFGDWo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 23:22:44 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E4E5F8D4
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 20:22:40 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyPnk-0006jV-F9 by authid <merlin>; Mon, 06 Jun 2022 20:22:40 -0700
Date:   Mon, 6 Jun 2022 20:22:40 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220607032240.GS22722@merlins.org>
References: <20220606210855.GL22722@merlins.org>
 <CAEzrpqe1_vbZ=+3C5=YPDJOCJGLAX9e4cmO_a+F1P3sdg9ubwQ@mail.gmail.com>
 <20220606212301.GM22722@merlins.org>
 <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
 <20220606215013.GN22722@merlins.org>
 <CAEzrpqcn_BRL7p3gPmS5OVn5D-m8hMB-5JcAHwEHwKpxGxOMqw@mail.gmail.com>
 <20220606221755.GO22722@merlins.org>
 <CAEzrpqcr08tHCesiwS9ysxrRQaadAeHyjSTg3Qp+CorvGz6psQ@mail.gmail.com>
 <20220607023740.GQ22722@merlins.org>
 <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
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

On Mon, Jun 06, 2022 at 10:57:17PM -0400, Josef Bacik wrote:
> Ah my bad, added all the repair code but not the code to notice it was
> broken, try again please.  Thanks,

FS_INFO IS 0x5641505c3bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x5641505c3bc0
Checking root 2 bytenr 15645019553792
Checking root 4 bytenr 15645019078656
Checking root 5 bytenr 15645018161152
Checking root 7 bytenr 15645019521024
Checking root 9 bytenr 15645740367872
Checking root 161197 bytenr 15645018341376
Checking root 161199 bytenr 15645018652672
Checking root 161200 bytenr 15645018750976
Checking root 161889 bytenr 11160502124544
Checking root 162628 bytenr 15645018931200
Checking root 162632 bytenr 15645018210304
Checking root 163298 bytenr 15645019045888
Checking root 163302 bytenr 15645018685440
Checking root 163303 bytenr 15645019095040
Checking root 163316 bytenr 15645018996736
Checking root 163920 bytenr 15645019144192
Checking root 164620 bytenr 15645019275264
Checking root 164623 bytenr 15645019226112
Checking root 164624 bytenr 15645019602944
scanning, best has 0 found 0 bad
checking block 15645019602944 generation 2588164 fs info generation 2588170
trying bytenr 15645019602944 got 145 blocks 1 bad
checking block 15645502210048 generation 1601068 fs info generation 2588170
trying bytenr 15645502210048 got 146 blocks 1 bad
checking block 15645022208000 generation 1739020 fs info generation 2588170
scan for best root 164624 wants to use 15645502210048 as the root bytenr
Repairing root 164624 bad_blocks 1 update 1
Segmentation fault


again, under gdb
scanning, best has 0 found 0 bad
checking block 15645019602944 generation 2588164 fs info generation 2588170
trying bytenr 15645019602944 got 145 blocks 1 bad
checking block 15645502210048 generation 1601068 fs info generation 2588170
trying bytenr 15645502210048 got 122 blocks 0 bad
checking block 15645022208000 generation 1739020 fs info generation 2588170
scan for best root 164624 wants to use 15645019602944 as the root bytenr
Repairing root 164624 bad_blocks 1 update 1
we're pointing at an empty node, delete slot 1 in block 15645019602944

Program received signal SIGSEGV, Segmentation fault.
repair_tree (fs_info=fs_info@entry=0x555555651bc0, root_info=root_info@entry=0x7fffffffdc20, eb=eb@entry=0x55555574bfb0)
    at ./kernel-shared/ctree.h:2136
2136    BTRFS_SETGET_HEADER_FUNCS(header_generation, struct btrfs_header,

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
u
