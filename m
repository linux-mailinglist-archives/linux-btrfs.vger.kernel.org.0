Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13104137377
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 17:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAJQWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 11:22:48 -0500
Received: from magic.merlins.org ([209.81.13.136]:52836 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgAJQWr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 11:22:47 -0500
Received: from [161.30.203.8] (port=58232 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1ipx3c-0007Ty-Cq by authid <merlins.org> with srv_auth_plain; Fri, 10 Jan 2020 08:22:45 -0800
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1ipx3R-0001iX-Bm; Fri, 10 Jan 2020 08:22:33 -0800
Date:   Fri, 10 Jan 2020 08:22:33 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: 5.4.8: WARNING: errors detected during scrubbing, corrected
Message-ID: <20200110162233.GJ4510@merlins.org>
References: <20200109162839.GA29989@merlins.org>
 <5b11d0a5-b1be-decb-bc74-5b28866637ee@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b11d0a5-b1be-decb-bc74-5b28866637ee@toxicpanda.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-No-Run: Yes
X-Broken-Reverse-DNS: no host name for IP address 161.30.203.8
X-SA-Exim-Connect-IP: 161.30.203.8
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 10, 2020 at 10:03:57AM -0500, Josef Bacik wrote:
> On 1/9/20 11:28 AM, Marc MERLIN wrote:
> > Howdy,
> > 
> > I have 6 btrfs pools on my laptop on 3 different SSDs.
> > After a few years, one of them is now very slow to scrub
> > and hands my laptop while it runs.
> > This started under 5.3.8, but upgrading to 5.4.8 didn't fix it.
> 
> What the hell kind of laptop are you running that has 3 different SSDs?
> That thing has got to weight a ton.
 
Eheh :)
Thinkpad P70, one M2 drive (room for one mor) and 2x 2.5" SSDs

> Can you run the bcc tool offcputime
> 
> https://github.com/iovisor/bcc/blob/master/tools/offcputime.py
> 
> while scrub is running to get a few stack traces of where we're spending all
> of our time?  It'll help narrow down who is to blame.  Thanks,

Will do and report back, thanks.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
