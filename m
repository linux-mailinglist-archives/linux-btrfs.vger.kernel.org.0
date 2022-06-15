Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B66E54D3FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 23:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbiFOVxe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 17:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiFOVxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 17:53:17 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20732408F
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 14:53:16 -0700 (PDT)
Received: from [76.132.34.178] (port=59324 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o1aEV-0002h9-F6 by authid <merlins.org> with srv_auth_plain; Wed, 15 Jun 2022 14:53:14 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o1aws-00GbhW-GK; Wed, 15 Jun 2022 14:53:14 -0700
Date:   Wed, 15 Jun 2022 14:53:14 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220615215314.GW1664812@merlins.org>
References: <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org>
 <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220615142929.GP22722@merlins.org>
 <20220615145547.GQ22722@merlins.org>
 <CAEzrpqdRn9mO0pDOogf37qWH07GryACqidHDbZcpoe7t73GDeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdRn9mO0pDOogf37qWH07GryACqidHDbZcpoe7t73GDeQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 76.132.34.178
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 15, 2022 at 05:18:54PM -0400, Josef Bacik wrote:
> On Wed, Jun 15, 2022 at 10:55 AM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Wed, Jun 15, 2022 at 07:29:29AM -0700, Marc MERLIN wrote:
> > > gargamel:/mnt/mnt# btrfs scrub start -B .
> > > running that now, I expect it will take a while.
> >
> > Never mind, it was fast:
> > gargamel:/mnt/mnt# btrfs scrub start -B .
> > scrub done for 96539b8c-ccc9-47bf-9e6c-29305890941e
> > Scrub started:    Wed Jun 15 07:28:02 2022
> > Status:           finished
> > Duration:         0:03:33
> > Total to scrub:   111.00GiB
> 
> Hrm shit, this isn't good, don't you have a lot more data than 111gib?
 
Yep, it was closer to 14TB. Ok, so it's probably gone after the many 
commands we ran in the last 2 months.

> Oh oops, I must have missed this in the init-extent-tree.  Let me look
> into this and I'll let you know when you can run the code again.
 
Is there even a reasonable chance to get the data back at this point, or
are we spending effort in not as useful ways?

> Ok the rest of these are going to take some work to fix up.  I'll work
> on that as well.  Thanks,

Up to you, happy to continue if it helps your efforts, but it looks like
my data is mostly gone.
I do remember one command along this thread that had over 100,000 lines
of inodes that were cleared once that bit got automated.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
