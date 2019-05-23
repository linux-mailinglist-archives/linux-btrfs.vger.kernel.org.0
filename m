Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E268283CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfEWQe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 12:34:58 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:38784 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfEWQe4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 12:34:56 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1hTqg8-00034n-7w; Thu, 23 May 2019 18:34:52 +0200
Date:   Thu, 23 May 2019 18:34:52 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Citation Needed: BTRFS Failure Resistance
Message-ID: <20190523163452.GB10771@angband.pl>
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
 <8ccec20a-04b1-4a84-6739-afd35b4ab02e@gmail.com>
 <CAJCQCtTp5d+VxsQmVv68VdmCsxSVpi-_c6LJjS_T=xx3GXz9Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJCQCtTp5d+VxsQmVv68VdmCsxSVpi-_c6LJjS_T=xx3GXz9Fg@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 23, 2019 at 10:24:28AM -0600, Chris Murphy wrote:
> On Thu, May 23, 2019 at 5:19 AM Austin S. Hemmelgarn
> > BTRFS explicitly requests write barriers to prevent that type of
> > reordering of writes from happening, and it's actually pretty unusual on
> > modern hardware for those write barriers to not be honored unless the
> > user is doing something stupid (like mounting with 'nobarrier' or using
> > LVM with write barrier support disabled).
> 
> 'man xfs'
> 
>        barrier|nobarrier
>               Note: This option has been deprecated as of kernel
> v4.10; in that version, integrity operations are always performed and
> the mount option is ignored.  These mount options will be removed no
> earlier than kernel v4.15.
> 
> Since they're getting rid of it, I wonder if it's sane for most any
> sane file system use case.

A volatile filesystem: one that you're willing to rebuild from scratch (or
backups) on power loss.  This includes any filesystem in a volatile VM.

Example use case: a build machine, where the build filesystem wants btrfs
for snapshots (the build environment several minutes to recreate), yet with
the environment recreated weekly, a crash can be considered an additional
start of a week. :)

Or, some clusters consider a crashed node to be dead and needing rebuild;
the filesystem's contents will be cloned from a master anyway.

In all of these cases, fsyncs can be ignored as well.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢰⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ At least spammers get it right: "Hello beautiful!".
⠈⠳⣄⠀⠀⠀⠀
