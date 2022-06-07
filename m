Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2BB542685
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381658AbiFHA3L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 20:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391519AbiFGW4f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 18:56:35 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3E30D919
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 12:58:11 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyfKi-0002gN-Ff by authid <merlin>; Tue, 07 Jun 2022 12:57:44 -0700
Date:   Tue, 7 Jun 2022 12:57:44 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220607195744.GV22722@merlins.org>
References: <20220607023740.GQ22722@merlins.org>
 <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
 <20220607032240.GS22722@merlins.org>
 <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
 <20220607151829.GQ1745079@merlins.org>
 <CAEzrpqftCCPw1J-jA-MTgoBDG6fNVJ-bJoXCh7NAbCeDptiwag@mail.gmail.com>
 <20220607153257.GR1745079@merlins.org>
 <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
 <20220607182737.GU1745079@merlins.org>
 <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
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

On Tue, Jun 07, 2022 at 03:46:12PM -0400, Josef Bacik wrote:
> 
> Perfect, this isn't in our list, so we definitely don't have it.  I've
> added some debugging to recover-chunks, can you run btrfs rescue
> recover-chunks and capture it's output?  We may not find this chunk
> and in that case it needs to just delete stuff, but I'd like to try a
> little harder before we give up.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
FS_INFO IS 0x560392adcbc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x560392adcbc0
Walking all our trees and pinning down the currently accessible blocks
No missing chunks, we're all done
doing close???
Recover chunks succeeded, you can run check now

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
FS_INFO IS 0x5621bb7a7bc0
Couldn't find the last root for 8
FS_INFO AFTER IS 0x5621bb7a7bc0
Checking root 2 bytenr 15645019504640
Checking root 4 bytenr 15645019078656
Checking root 5 bytenr 15645018161152
Checking root 7 bytenr 15645019439104
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
Checking root 164624 bytenr 15645018226688
Checking root 164629 bytenr 15645485137920
Checking root 164631 bytenr 15645496983552
Checking root 164633 bytenr 15645526884352
Checking root 164823 bytenr 15645999005696
Tree recovery finished, you can run check now
gargamel:/var/local/src/btrfs-progs-josefbacik# 

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
