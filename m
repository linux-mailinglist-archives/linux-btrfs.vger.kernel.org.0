Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262F0234950
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 18:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgGaQnU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgGaQnU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 12:43:20 -0400
X-Greylist: delayed 1809 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Jul 2020 09:43:20 PDT
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7A0C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 09:43:20 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1k1Xed-0008BW-Fz; Fri, 31 Jul 2020 18:13:07 +0200
Date:   Fri, 31 Jul 2020 18:13:07 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Eric Wong <e@80x24.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: raid1 with several old drives and a big new one
Message-ID: <20200731161307.GA31148@angband.pl>
References: <20200731001652.GA28434@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200731001652.GA28434@dcvr>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 31, 2020 at 12:16:52AM +0000, Eric Wong wrote:
> Say I have three ancient 2TB HDDs and one new 6TB HDD, is there
> a way I can ensure one raid1 copy of the data stays on the new
> 6TB HDD?
> 
> I expect the 2TB HDDs to fail sooner than the 6TB HDD given
> their age (>5 years).

While there's no good way to do so in general, in your case, there's no way
for any new block group to be allocated without the big disk.

Btrfs' allocation algorithm is: always pick the disk with most free space
left.  Besides being simple, this guarantees optimally utilizing available
space.

And, for 2+2+2+6, no scheme that doesn't waste space could possibly place
raid1 copies without having one on the biggest disk.

Thus, all you need is to balance once.

> The devid balance filter only affects data which already exists
> on the device, so that isn't suitable for this, right?

Yeah, balance affects existing data, but doesn't have a lingering effect on
new allocations.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ It's time to migrate your Imaginary Protocol from version 4i to 6i.
⠈⠳⣄⠀⠀⠀⠀
