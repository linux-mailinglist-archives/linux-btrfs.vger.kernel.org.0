Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0254353CDBF
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbiFCRHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiFCRHF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 13:07:05 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8EB6324
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 10:07:04 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nxAlK-0007Mo-6u by authid <merlin>; Fri, 03 Jun 2022 10:07:02 -0700
Date:   Fri, 3 Jun 2022 10:07:02 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220603170700.GX22722@merlins.org>
References: <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
 <20220602195134.GT22722@merlins.org>
 <CAEzrpqciXfV0NZMTJoMjX_E_TzQ-j5sEpsACnEhnJdAXzbVOEg@mail.gmail.com>
 <20220602195623.GU22722@merlins.org>
 <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
 <20220602203224.GV22722@merlins.org>
 <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
 <20220603144732.GG1745079@merlins.org>
 <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
 <20220603164252.GH1745079@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603164252.GH1745079@merlins.org>
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

On Fri, Jun 03, 2022 at 09:42:52AM -0700, Marc MERLIN wrote:
> searching 1 for bad extents
> processed 81920 of 18446744073709518848 possible bytes, 0%
> Found an extent we don't have a block group for in the file
> Couldn't find any paths for this inode
> Deleting [4483, 108, 0] root 15645018226688 path top 15645018226688 top slot 5 leaf 15645018243072 slot 11
> 
> searching 1 for bad extents
> processed 81920 of 18446744073709518848 possible bytes, 0%
> Found an extent we don't have a block group for in the file
> Couldn't find any paths for this inode
> Deleting [4484, 108, 0] root 15645018161152 path top 15645018161152 top slot 5 leaf 15645018177536 slot 12

finished with

searching 164623 for bad extents
processed 278528 of 63193088 possible bytes, 0%
Found an extent we don't have a block group for in the file
ref to path failed
Couldn't find any paths for this inode
Deleting [72784, 108, 0] root 15645019226112 path top 15645019226112 top slot 17 leaf 11160502550528 slot 12

searching 164623 for bad extents
processed 311296 of 63193088 possible bytes, 0%
searching 164624 for bad extents

Found an extent we don't have a block group for in the file
Couldn't find any paths for this inode
corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
Deleting [3740, 108, 267370496] root 15645019176960 path top 15645019176960 top slot 0 leaf 15645019553792 slot 0

searching 164624 for bad extents

Found an extent we don't have a block group for in the file
corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
Couldn't find any paths for this inode
corrupt node: root=164624 block=15645019439104 physical=15054973140992 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
ERROR: error searching for key?? -1

wtf
it failed?? -1
ERROR: failed to clear bad extents
doing close???
ERROR: attempt to start transaction over already running one
WARNING: reserved space leaked, flag=0x4 bytes_reserved=32768
extent buffer leak: start 15645019406336 len 16384
extent buffer leak: start 15645019406336 len 16384
WARNING: dirty eb leak (aborted trans): start 15645019406336 len 16384
extent buffer leak: start 15645019439104 len 16384
extent buffer leak: start 15645019439104 len 16384
WARNING: dirty eb leak (aborted trans): start 15645019439104 len 16384
Init extent tree failed

needs further fixing?
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
