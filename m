Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F453D710
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jun 2022 15:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiFDNs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jun 2022 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiFDNs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jun 2022 09:48:27 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC06031392
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Jun 2022 06:48:24 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nxU8d-00042j-Lo by authid <merlin>; Sat, 04 Jun 2022 06:48:23 -0700
Date:   Sat, 4 Jun 2022 06:48:23 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220604134823.GB22722@merlins.org>
References: <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
 <20220602203224.GV22722@merlins.org>
 <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
 <20220603144732.GG1745079@merlins.org>
 <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
 <20220603164252.GH1745079@merlins.org>
 <20220603170700.GX22722@merlins.org>
 <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com>
 <20220603183927.GZ22722@merlins.org>
 <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
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

On Sat, Jun 04, 2022 at 08:49:44AM -0400, Josef Bacik wrote:
> Ok we're finding the corrupt blocks and scanning, but for some reason
> we're not getting the updated root?
> 
> I've pushed a debug patch, can you re-run tree-recover and capture the
> output?  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x5570a7eb6bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x5570a7eb6bc0
Checking root 2 bytenr 15645019668480
Checking root 4 bytenr 15645019078656
Checking root 5 bytenr 15645018161152
Checking root 7 bytenr 15645019488256
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
Checking root 164624 bytenr 15645018718208
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
scanning, best has 0 found 0 bad
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
checking block 15645018718208 generation 2588157 fs info generation 2588157
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
trying bytenr 15645018718208 got 96 blocks 1 bad
checking block 15645019684864 generation 2588156 fs info generation 2588157
trying bytenr 15645019684864 got 145 blocks 0 bad
checking block 15645502210048 generation 1601068 fs info generation 2588157
trying bytenr 15645502210048 got 146 blocks 0 bad
checking block 15645019471872 generation 2588157 fs info generation 2588157
scan for best root 164624 wants to use 15645502210048 as the root bytenr
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
Repairing root 164624 bad_blocks 0 update 1
setting root 164624 to bytenr 15645502210048
Checking root 164629 bytenr 15645485137920
Checking root 164631 bytenr 15645496983552
Checking root 164633 bytenr 15645526884352
Checking root 164823 bytenr 15645999005696
Tree recovery finished, you can run check now

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
