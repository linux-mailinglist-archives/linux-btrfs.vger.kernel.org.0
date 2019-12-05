Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF1D11486F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 22:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfLEVDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 16:03:12 -0500
Received: from savella.carfax.org.uk ([85.119.84.138]:52396 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbfLEVDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 16:03:11 -0500
X-Greylist: delayed 2301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 16:03:11 EST
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1icxg9-0001eW-Rz; Thu, 05 Dec 2019 20:24:49 +0000
Date:   Thu, 5 Dec 2019 20:24:49 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: is this the right place for a question on how to repair a broken
 btrfs file system?
Message-ID: <20191205202449.GH4760@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Christian Wimmer <telefonchris@icloud.com>,
        linux-btrfs@vger.kernel.org
References: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A01B0EC4-8E96-486B-A182-76B74AD0F97D@icloud.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 05:00:40PM -0300, Christian Wimmer wrote:
> Hi, my name is Chris, 
> 
> is this the right place for asking on support on how to repair a broken btrfs?
> 
> There is no hardware problem, just that the power went out and now I can not mount any more.

   What does dmesg say when you try to mount the FS?

> Who is the best specialist that could help here?
> 
> Of course I already scanned the WEB some hours and tried all not-destructive commands without success.

   "Non-destructive" is a fairly limited of things, and most of the
easily-findable advice on the web about fixing btrfs filesystems is at
best badly misguided, if not actively wrong. :(

   Can you also tell us exactly what you ran?

   Hugo.

-- 
Hugo Mills             | Is it true that "last known good" on Windows XP
hugo@... carfax.org.uk | boots into CP/M?
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                       Adrian Bridgett
