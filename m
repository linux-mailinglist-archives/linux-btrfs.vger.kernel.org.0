Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE434F6BD5
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 22:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiDFU5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 16:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiDFU4n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 16:56:43 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D93EE4CA
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 12:16:36 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1ncB8u-0002tS-2f by authid <merlin>; Wed, 06 Apr 2022 12:16:36 -0700
Date:   Wed, 6 Apr 2022 12:16:36 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220406191636.GD14804@merlins.org>
References: <20220405225808.GJ28707@merlins.org>
 <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
 <20220406003521.GM28707@merlins.org>
 <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
 <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
 <20220406031255.GO28707@merlins.org>
 <20220406033404.GQ28707@merlins.org>
 <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com>
 <20220406185431.GB14804@merlins.org>
 <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
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

On Wed, Apr 06, 2022 at 02:57:03PM -0400, Josef Bacik wrote:
> Yeah lets go for that, I saw some errors on your fs tree's earlier, I
> may need to adapt this to fix that tree, or if it's a snapshot we can
> just delete it.  We can burn that bridge when we get to it, thanks,

Sounds good. Is mode=lowmem a thing of the past by the way?
(I remember that the old regular repair would eat up my 32GB of RAM and
take the machine down)

The current one failed quickly though

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --repair /dev/mapper/dshelf1a 
enabling repair mode
WARNING:

	Do not use --repair unless you are advised to do so by a developer
	or an experienced user, and then only after having accepted that no
	fsck can successfully repair all types of filesystem corruption. Eg.
	some software or hardware bugs can fatally damage a volume.
	The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x55e2e75defc0
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
Couldn't find the last root for 8
checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
parent transid verify failed on 15645261971456 wanted 1602297 found 1600989
checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
bad tree block 15645261971456, bad level, 127 > 8
ERROR: failed to read block groups: Input/output error
FS_INFO AFTER IS 0x55e2e75defc0
Checking filesystem on /dev/mapper/dshelf1a
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
[1/7] checking root items
checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
parent transid verify failed on 15645261971456 wanted 1602297 found 1600989
checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
bad tree block 15645261971456, bad level, 127 > 8
ERROR: failed to repair root items: Input/output error


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
