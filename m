Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC7354D52A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 01:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbiFOXVr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346114AbiFOXVp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 19:21:45 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0616F107
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 16:21:44 -0700 (PDT)
Received: from [76.132.34.178] (port=59326 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o1bc6-0003O6-TI by authid <merlins.org> with srv_auth_plain; Wed, 15 Jun 2022 16:21:42 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o1cKT-00Ghrg-UN; Wed, 15 Jun 2022 16:21:41 -0700
Date:   Wed, 15 Jun 2022 16:21:41 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220615232141.GX1664812@merlins.org>
References: <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org>
 <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220615142929.GP22722@merlins.org>
 <20220615145547.GQ22722@merlins.org>
 <CAEzrpqdRn9mO0pDOogf37qWH07GryACqidHDbZcpoe7t73GDeQ@mail.gmail.com>
 <20220615215314.GW1664812@merlins.org>
 <CAEzrpqfZMA=NjqAaS1XKZgguD5L73kc7zKFL+cVHnMGxdK6rXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfZMA=NjqAaS1XKZgguD5L73kc7zKFL+cVHnMGxdK6rXw@mail.gmail.com>
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

On Wed, Jun 15, 2022 at 07:16:52PM -0400, Josef Bacik wrote:
> > Up to you, happy to continue if it helps your efforts, but it looks like
> > my data is mostly gone.
> > I do remember one command along this thread that had over 100,000 lines
> > of inodes that were cleared once that bit got automated.
> >
> 
> Yeah I'm going to go rip that code out.  I should have paid more
> attention to what was happening instead of just assuming we had a few
> corrupt extents that needed to be removed.
 
No worries. I knew this was working on live data and that it was
untested code that couuld damage it further :)

> I think we've gotten plenty out of this exercise, sorry I ended up
> nuking all of your data.  I know what I need to change to fix these
> tools to be more useful later on, and I'll just make a bunch of test
> images to validate the work.  Thanks,

Cool, that was the main goal.

Sorry to everyone else following along, hopefully it was somewhat
entertaining :)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
