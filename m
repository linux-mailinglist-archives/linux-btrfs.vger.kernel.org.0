Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00EA1F4663
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgFIShh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgFIShh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Jun 2020 14:37:37 -0400
X-Greylist: delayed 2617 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Jun 2020 11:37:36 PDT
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E63C05BD1E
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Jun 2020 11:37:36 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1jiiRX-0000tU-R9; Tue, 09 Jun 2020 19:53:47 +0200
Date:   Tue, 9 Jun 2020 19:53:47 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     "Ellis H. Wilson III" <ellisw@panasas.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS File Delete Speed Scales With File Size?
Message-ID: <20200609175347.GA1139@angband.pl>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 09, 2020 at 11:31:41AM -0400, Ellis H. Wilson III wrote:
> We have a few engineers looking through BTRFS code presently for answers to
> this, but I was interested to get input from the experts in parallel to
> hopefully understand this issue quickly.
> 
> We find that removes of large amounts of data can take a significant amount
> of time in BTRFS on HDDs -- in fact it appears to scale linearly with the
> size of the file.  I'd like to better understand the mechanics underpinning
> that behavior.
> 
> See the attached graph for a quick experiment that demonstrates this
> behavior.  In this experiment I use 40 threads to perform deletions of
> previous written data in parallel.  10,000 files in every case and I scale
> files by powers of two from 16MB to 16GB.  Thus, the raw amount of data
> deleted also expands by 2x every step.  Frankly I expected deletion of a
> file to be predominantly a metadata operation and not scale with the size of
> the file, but perhaps I'm misunderstanding that.

The size of metadata is, after a small constant bit, proportional to the
number of extents.  Which in turn depends on file size.  With compression
off, extents may be as big as 1GB (which would make their number
negligible), but that's clearly not happening in your case.

There are tools which can show extent layout. I'd recommend python3-btrfs,
which includes /usr/share/doc/python3-btrfs/examples/show_file.py that
prints everything available about the list of extents.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
⠈⠳⣄⠀⠀⠀⠀
