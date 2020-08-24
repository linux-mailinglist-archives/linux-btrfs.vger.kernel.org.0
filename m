Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF9250B95
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 00:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHXWXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 18:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHXWXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 18:23:12 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11310C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 15:23:11 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1kAKrq-0007Hd-Ra
        for linux-btrfs@vger.kernel.org; Tue, 25 Aug 2020 00:23:06 +0200
Date:   Tue, 25 Aug 2020 00:23:06 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Link count for directories
Message-ID: <20200824222306.GA26736@angband.pl>
References: <trinity-57be0daf-2aa0-4480-a962-7a62e302cfde-1598031619031@3c-app-gmx-bap35>
 <e592fd12-1662-49f3-75bd-94609e660517@suse.com>
 <trinity-963db523-ba60-48b5-997f-59b55ee6b92b-1598305830919@3c-app-gmx-bap63>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-963db523-ba60-48b5-997f-59b55ee6b92b-1598305830919@3c-app-gmx-bap63>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 24, 2020 at 11:50:30PM +0200, Steve Keller wrote:
> Nikolay Borisov <nborisov@suse.com> wrote:
> > I have implemented it so it's not that big of a deal. However turns out
> > it has pretty steep requirements for backport because so far btrfs
> > always kept the link count of dirs to 1.

> > So how effective is such an optimisation to the software using it ?
> 
> It's not only optimization like in find(1).  As an old and long-time Unix
> user I'd also like that traditional behavior.  It just feels more correct
> since if you do mkdir ./a ./b ./c ./d, you will actually see the 4 links
> to the current dir if you do ls -ai a b c d and the two links from . itself
> and from ..

It's just an implementation detail of sysvfs, and a case of
bug-compatibility.  The link count of a directory is always 1 as btrfs,
ext4, xfs, etc -- none of them support directory hardlinks, unlike sysvfs.

So the proper value, as documented, is 1.  Copying sysvfs behaviour is also
costly as you need to know the count of contents while statting parent.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ It's time to migrate your Imaginary Protocol from version 4i to 6i.
⠈⠳⣄⠀⠀⠀⠀
