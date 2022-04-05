Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FB64F477D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiDEVLs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573184AbiDESNL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 14:13:11 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1547DA9E
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 11:11:10 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbne0-0002DD-NY by authid <merlin>; Tue, 05 Apr 2022 11:11:08 -0700
Date:   Tue, 5 Apr 2022 11:11:08 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405181108.GA28707@merlins.org>
References: <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
 <20220405011559.GF5566@merlins.org>
 <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
 <20220405014259.GG5566@merlins.org>
 <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
 <20220405020729.GH5566@merlins.org>
 <CAEzrpqd6kePW6eiMB-R4DvMRvU=AK-jKpkBNUvSjttsSEsCwpA@mail.gmail.com>
 <20220405155311.GJ5566@merlins.org>
 <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
 <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
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

On Tue, Apr 05, 2022 at 01:41:10PM -0400, Josef Bacik wrote:
> Ok I think I'm going to do a humpty-dumpty thing where I scan for the
> best possible copies of blocks and stitch them into the tree root.
> I've wired something up to find out how many bad slots we're working
> with so I've got an idea of how careful I need to be, can you pull
> your branch again, rebuild, and run
> 
> ./btrfs-find-root -o 1 /dev/whatever
> 
> and send me the output?  I'm working on the tool right now, hoping it
> takes me a couple of hours at most (mostly because I have meetings
> sporadically throughout today).  Thanks,

Cool. there you go

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1
/dev/mapper/dshelf1a
Couldn't read chunk tree
WTF???
ERROR: open ctree failed

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
