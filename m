Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A104F2137
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 06:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiDECkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 22:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiDECka (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 22:40:30 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE2C15404C
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 18:43:25 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbX3a-00084n-S8 by authid <merlin>; Mon, 04 Apr 2022 17:28:26 -0700
Date:   Mon, 4 Apr 2022 17:28:26 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405002826.GD5566@merlins.org>
References: <20220404224503.GA11442@merlins.org>
 <CAEzrpqfJ7-GQHZicxpn2x3D=aOY=tnKkt9XiPJ8O+_VZAgK7wg@mail.gmail.com>
 <20220404231838.GA1314726@merlins.org>
 <CAEzrpqd2kVY=mpttaP3+YJJ_1t1Z3crfXAdF-69pMU10aVe5OA@mail.gmail.com>
 <20220404234213.GA5566@merlins.org>
 <CAEzrpqft7WzRB+6+=_tTXYU4geBB_38navF1opr6cd9PXiWUGg@mail.gmail.com>
 <20220405001325.GB5566@merlins.org>
 <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
 <20220405001808.GC5566@merlins.org>
 <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
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

On Mon, Apr 04, 2022 at 08:24:55PM -0400, Josef Bacik wrote:
> > Binary identical after rebuild.
> 
> Sigh time for printf sanity checks, thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# git log | head -3 
commit 7839d7519ffb3b5d1d102536eb768c25a69c4c05
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Apr 4 20:24:18 2022 -0400
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a
btrfs-progs v5.16.2 
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
FS_INFO IS 0x55ea174c4830
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
Couldn't find the last root for 4
Couldn't setup device tree
FS_INFO AFTER IS 0x55ea174c4830
ERROR: unable to open /dev/mapper/dshelf1a

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
