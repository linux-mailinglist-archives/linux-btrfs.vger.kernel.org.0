Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46A5330538
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 00:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhCGXvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 18:51:53 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:48078 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhCGXvY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 18:51:24 -0500
X-Greylist: delayed 2153 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Mar 2021 18:51:23 EST
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94)
        (envelope-from <kilobyte@angband.pl>)
        id 1lJ2aL-00F6Xi-Ko; Mon, 08 Mar 2021 00:13:17 +0100
Date:   Mon, 8 Mar 2021 00:13:17 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 5.11
Message-ID: <YEVeDaWCZR41n4Kg@angband.pl>
References: <20210305133605.13263-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210305133605.13263-1-dsterba@suse.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 05, 2021 at 02:36:05PM +0100, David Sterba wrote:
> btrfs-progs version 5.11 have been released.

W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-centos-7-x86_64/docker-build -> /home/dsterba/labs/btrfs-progs/ci/images/docker-build
W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-centos-7-x86_64/docker-run -> /home/dsterba/labs/btrfs-progs/ci/images/docker-run
W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-centos-8-x86_64/docker-build -> /home/dsterba/labs/btrfs-progs/ci/images/docker-build
W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-centos-8-x86_64/docker-run -> /home/dsterba/labs/btrfs-progs/ci/images/docker-run
W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-openSUSE-Leap-15.2-x86_64/docker-build -> /home/dsterba/labs/btrfs-progs/ci/images/docker-build
W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-openSUSE-Leap-15.2-x86_64/docker-run -> /home/dsterba/labs/btrfs-progs/ci/images/docker-run
W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-openSUSE-tumbleweed-x86_64/docker-build -> /home/dsterba/labs/btrfs-progs/ci/images/docker-build
W: btrfs-progs source: absolute-symbolic-link-target-in-source ci/images/ci-openSUSE-tumbleweed-x86_64/docker-run -> /home/dsterba/labs/btrfs-progs/ci/images/docker-run

Somehow, I can't find /home/dsterba/ on my machine :þ


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Vat kind uf sufficiently advanced technology iz dis!?
⢿⡄⠘⠷⠚⠋⠀                                 -- Genghis Ht'rok'din
⠈⠳⣄⠀⠀⠀⠀
