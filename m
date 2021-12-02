Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0304466D89
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 00:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357444AbhLBXTx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 18:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356945AbhLBXTx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 18:19:53 -0500
X-Greylist: delayed 2430 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Dec 2021 15:16:30 PST
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4610EC06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 15:16:30 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1msud2-0003LX-K6; Thu, 02 Dec 2021 22:32:36 +0000
Date:   Thu, 2 Dec 2021 22:32:36 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Charlie Lin <CLIN@Rollins.edu>
Cc:     "rm@romanrm.net" <rm@romanrm.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Message-ID: <20211202223236.GC3478@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Charlie Lin <CLIN@Rollins.edu>, "rm@romanrm.net" <rm@romanrm.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <DM8P220MB0342912966C295206FF80725C1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8P220MB0342912966C295206FF80725C1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 10:25:53PM +0000, Charlie Lin wrote:
> 
> I'm actually dual-booting both systems on my laptop ie (Funtoo's kernel and initramfs are on the same EFI system partition that Windows uses)
> 
> Admittedly, I configured Windows to mount those Btrfs partitions at startup, and for both OSes to be able to hibernate, so that I can access the affected partition by hibernating one OS then resuming on the other. This worked well for about three weeks.

   This is approximately equal to mounting the FS on both machines at
the same time. Honestly, I'm surprised it lasted as long as three
weeks. I'd have said three minutes would be nearer the expected
lifetime. When you hibernate/suspend a machine, it stores its current
kernel state (including memory relating to things like filesystems),
and then restores that state when it resumes. If, in the meantime,
something else (like another OS) modifies the FS, you're effectively
injecting changes into the on-disk data that the hibernated OS doesn't
know about on resume.

> Anyway, are there commands to try to recover /dev/nvme0n1p{6,8}?

   The phrase "masssive filesystem metadata corruption" springs to
mind here, with a follow up of "it's dead, Jim". You might get
something out of it with btrfs restore, although restoring from your
backups is probably going to be much easier. The FS itself needs to be
rebuilt with mkfs.

   Hugo.

-- 
Hugo Mills             | Two things came out of Berkeley in the 1960s: LSD
hugo@... carfax.org.uk | and Unix. This is not a coincidence.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
