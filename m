Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3850CD5B
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 22:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiDWUPL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Apr 2022 16:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiDWUPK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Apr 2022 16:15:10 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54401A6B48
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Apr 2022 13:12:12 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:41112 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1niM6z-0004HC-MU by authid <merlins.org> with srv_auth_plain; Sat, 23 Apr 2022 13:12:10 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1niM7F-004Zgy-OU; Sat, 23 Apr 2022 13:12:25 -0700
Date:   Sat, 23 Apr 2022 13:12:25 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220423201225.GZ13115@merlins.org>
References: <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org>
 <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org>
 <20220406040913.GE3307770@merlins.org>
 <Yk3W88Eyh0pSm9mQ@hungrycats.org>
 <20220406191317.GC14804@merlins.org>
 <20220422184850.GX13115@merlins.org>
 <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
 <20220422200115.GV11868@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200115.GV11868@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 22, 2022 at 01:01:15PM -0700, Marc MERLIN wrote:
> > Now if we get to Monday and it's still running I can take a crack at
> > making it faster.  I was hoping it would only take a day or two, but
> > we're balancing me trying to make it better and possibly fucking it up
> > with letting it take the rest of our lives but be correct.  Thanks,
> 
> Makes sense. I don't need faster, and it may not be able to go faster
> anyway, it's a lot of data. Just wanted to make sure the output and
> relative slow results were expected. 

Looking at the output, is there any way I can figure out if it's at 5%
or 80% completion?

tree backref 238026752 parent 236814336 not found in extent tree
backpointer mismatch on [238026752 16384]
adding new tree backref on start 238026752 len 16384 parent 236814336 root 236814336
Repaired extent references for 238026752
ref mismatch on [238043136 16384] extent item 0, found 1
tree backref 238043136 parent 236814336 not found in extent tree
backpointer mismatch on [238043136 16384]
adding new tree backref on start 238043136 len 16384 parent 236814336 root 236814336
Repaired extent references for 238043136
ref mismatch on [238059520 16384] extent item 0, found 1
tree backref 238059520 parent 236814336 not found in extent tree
backpointer mismatch on [238059520 16384]
adding new tree backref on start 238059520 len 16384 parent 236814336 root 236814336

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
