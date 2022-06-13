Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9185549DA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 21:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348822AbiFMT0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 15:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350372AbiFMT0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 15:26:10 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908CC213
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 10:46:55 -0700 (PDT)
Received: from rrcs-173-197-119-179.west.biz.rr.com ([173.197.119.179]:32409 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o0nQp-0004HE-6g by authid <merlins.org> with srv_auth_plain; Mon, 13 Jun 2022 10:46:42 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o0o9A-00CBZl-L2; Mon, 13 Jun 2022 10:46:40 -0700
Date:   Mon, 13 Jun 2022 10:46:40 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Andrea Gelmini <andrea.gelmini@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220613174640.GL1664812@merlins.org>
References: <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
 <20220611145259.GF1664812@merlins.org>
 <20220613022107.6eafbc1c@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613022107.6eafbc1c@nvm>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 173.197.119.179
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 13, 2022 at 02:21:07AM +0500, Roman Mamedov wrote:
> On Sat, 11 Jun 2022 07:52:59 -0700
> Marc MERLIN <marc@merlins.org> wrote:
> 
> > On Sat, Jun 11, 2022 at 02:30:33PM +0500, Roman Mamedov wrote:
> > > > 2) echo 0fb96f02-d8da-45ce-aba7-070a1a8420e3 >  /sys/block/bcache64/bcache/attach 
> > > >    gargamel:/dev# cat /sys/block/md7/bcache/cache_mode
> > > >    [writethrough] writeback writearound none
> > > 
> > > Maybe try LVM Cache this time?
> >  
> > Hard to know either way, trading one layer for another, and LVM has
> > always seemed heavier
> 
> I'd suggest to put the LUKS volume onto an LV still (in case you don't), so you
> can add and remove cache just to see how it works; unlike with bcache, an LVM
> cache can be added to an existing LV and then removed without a trace, all
> without having to displace 44 TB of data for that.

Thanks. I've always felt that LVM was heavyweight and required extra
steps and tools, so I've been avoiding it, but maybe that wasn't
rational.
bcache by the way, you can set it up without a backing device and then
use it normally without the cache layer. I think it's actually pretty
similar, but you have to set it up beforehand (just like LVM)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
