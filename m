Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80104A0077
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 19:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbiA1SyT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 13:54:19 -0500
Received: from rin.romanrm.net ([51.158.148.128]:43748 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbiA1SyS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 13:54:18 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jan 2022 13:54:18 EST
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 15D7466A;
        Fri, 28 Jan 2022 18:44:30 +0000 (UTC)
Date:   Fri, 28 Jan 2022 23:44:30 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Kai Krakow <hurikhan77+btrfs@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
Message-ID: <20220128234430.63f67d20@nvm>
In-Reply-To: <19bf3e06-3156-99b4-4656-6ac794ad1ca8@georgianit.com>
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
        <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
        <5e8303e3-64bf-f19a-6d42-e18ae62fd721@georgianit.com>
        <CAMthOuOnYUn_szauqRbx2yy_U+2Zrs5WUWmwKHLC5k3x13qKpA@mail.gmail.com>
        <a7e60083-7bbb-bc75-2916-7396e223463b@georgianit.com>
        <CAMthOuPa5nmao1cvKf62CXOF5GZvGC84p650S947-YqaRe6i5Q@mail.gmail.com>
        <19bf3e06-3156-99b4-4656-6ac794ad1ca8@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 28 Jan 2022 13:29:22 -0500
Remi Gauvin <remi@georgianit.com> wrote:

> MDraid, and any hardware raid I'm aware of, will resynchronize the 2
> copies whenever there is an unclean shutdown.  which copy becomes the
> new master is arbitrary, but both will be the same.

I believe mdraid writes event count to each device, and the device with the
highest event count (which has seen completed writes as late in time prior to
shutdown as possible) will be used as the source for synchronizing the other
ones.

Secondly, it has a write intent bitmap, to only resync the areas that are
different on that chosen device compared to the others.

-- 
With respect,
Roman
