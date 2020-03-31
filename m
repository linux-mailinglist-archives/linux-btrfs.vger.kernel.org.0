Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF142198B1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 06:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCaEUv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 31 Mar 2020 00:20:51 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38522 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCaEUv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 00:20:51 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 97C00642C4B; Tue, 31 Mar 2020 00:20:50 -0400 (EDT)
Date:   Tue, 31 Mar 2020 00:20:50 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Brad Templeton <4brad@templetons.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs-transacti hangs system for several seconds every few
 minutes
Message-ID: <20200331042050.GE13306@hungrycats.org>
References: <94d08f2b57dd2df746436a0d6bb5f51e@wpkg.org>
 <8703e779-d31b-37c1-672b-dea482e8a491@gmail.com>
 <b71b10f8-6410-4d32-f89c-9b3f20d9b2f2@templetons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b71b10f8-6410-4d32-f89c-9b3f20d9b2f2@templetons.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 30, 2020 at 01:11:41AM -0700, Brad Templeton wrote:
> Also, isn't it 4 debs -- image, modules, headers and architecture
> independent headers?
> 
> Still, I am surprised that the ubuntu team, with a data corruption
> issue, would not make a priority to install a fixed kernel or at least
> backport btrfs modules into the current kernel.

It probably hasn't been reported to them.  Distro vendors are kind of
on their own for long-term kernel bug fixes, especially for non-LTS
kernels like 5.3.  kernel.org support ended last year, just before the
bug was identified.

> On 3/29/20 10:56 PM, Andrei Borzenkov wrote:
> > 30.03.2020 05:29, Tomasz Chmielewski пишет:
> >>> I wonder why they put 5.3.0 as the standard advanced Kernel in Ubuntu
> >>> LTS if it has a data corruption bug.   I don't know if I've seen any
> >>> release of 5.4.14 in a PPA yet -- manual kernel install is such a pain
> >>> the few times I have done it.
> >>
> >> You have all kernels compiled as packages here (for Ubuntu):
> >>
> >> https://kernel.ubuntu.com/~kernel-ppa/mainline/
> >>
> >> So just download two deb packages, dpkg -i, and done.
> >>
> > 
> > Beware that it is not exactly the same as distribution kernel (both in
> > terms of included patches and enabled configuration options). Also
> > matching linux-tools is not provided which means perf, cpupower,
> > turbostat and some other tools stop working.
> > 
