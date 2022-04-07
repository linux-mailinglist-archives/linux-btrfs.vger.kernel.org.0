Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B4B4F7546
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 07:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbiDGFWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 01:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbiDGFWW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 01:22:22 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA97DEBAA
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 22:20:23 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1ncKZC-0004BB-2T by authid <merlin>; Wed, 06 Apr 2022 22:20:22 -0700
Date:   Wed, 6 Apr 2022 22:20:22 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220407052022.GC25669@merlins.org>
References: <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
 <20220406191636.GD14804@merlins.org>
 <CAEzrpqf0Vz=6nn-iMeyFsB0qLX+X48zO26Ero-3R6FLCqnzivg@mail.gmail.com>
 <20220406203445.GE14804@merlins.org>
 <CAEzrpqdW-Kf7agSfTy_EK6UYUt2Wkf53j-WTzKjSPXWYgEUNkw@mail.gmail.com>
 <20220406205621.GF3307770@merlins.org>
 <CAEzrpqekB7GZ7wytx-Q2D7AnidBwVK2P5sc-NcBww0J666M5oA@mail.gmail.com>
 <20220407010819.GG14804@merlins.org>
 <CAEzrpqcFRaq9vrfLi_VcxWi9ZQGj+LgpXr5xwzw-2vWYHM6vJg@mail.gmail.com>
 <20220407043717.GA25669@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407043717.GA25669@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 06, 2022 at 09:37:17PM -0700, Marc MERLIN wrote:
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /dev/mapper/dshelf1a 2>&1 |tee /tmp/outo

there may have been something else that ate all my memory.
I killed shinobi and re-ran your code overnight while dumping
memory. I'll have a memory trace running this time while it re-runs
overnight.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
