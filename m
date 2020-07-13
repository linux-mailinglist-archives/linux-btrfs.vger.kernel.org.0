Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF0C21D2A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 11:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgGMJOX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 05:14:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:38618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgGMJOW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 05:14:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28378ACAF;
        Mon, 13 Jul 2020 09:14:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1348DA809; Mon, 13 Jul 2020 11:13:58 +0200 (CEST)
Date:   Mon, 13 Jul 2020 11:13:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Ken D'Ambrosio <ken@jots.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs default on Fedora?
Message-ID: <20200713091358.GC3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Andrei Borzenkov <arvidjaar@gmail.com>,
        Chris Murphy <lists@colorremedies.com>,
        Ken D'Ambrosio <ken@jots.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <933824829995390cef16f757cab1ddbc@jots.org>
 <CAJCQCtSbBCJjKcwuNB9b2ZZQWjkwxvBQpC0C7UWVsAjBAN6BgA@mail.gmail.com>
 <d81cea36-bb02-88a4-e65e-3070f0dc76d9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d81cea36-bb02-88a4-e65e-3070f0dc76d9@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 12, 2020 at 08:28:32AM +0300, Andrei Borzenkov wrote:
> 12.07.2020 00:18, Chris Murphy пишет:
> > On Sat, Jul 11, 2020 at 12:44 PM Ken D'Ambrosio <ken@jots.org> wrote:
> > 
> >> * Swap files.  At least last time I checked, it was a PITA to take a
> >> snapshot of a volume that had a swapfile on it -- I wound up writing a
> >> wrapper that goes, does a swapoff, removes the file, creates the
> >> snapshot, and then re-creates the file.   Is this still "a thing"?  Or
> >> is there a way to work around that that isn't kludgey?
> > 
> > Put the swapfile in its own subvolume and don't snapshot it. One way
> > is to create a (nested) subvolume named "swap" inside of the "root"
> > subvolume created at installation time; use chattr +C on it; now
> > create the swapfile per 'man 5 btrfs'.
> > 
> > Since btrfs snapshots aren't recursive, making a snapshot of 'root'
> > will not cause a snapshot to be taken of 'swap' or its swapfiles.
> 
> swap file requires calculation of absolute disk offset (that is what
> kernel works with) and this is not supported on btrfs with by systemd:

When the swapfile is not used for suspend/resume, the offsets don't
matter. The reads and writes build on generic DIO infrastructure, in the
same way swap-over-NFS works that also does not have any physical
offsets in general.

> https://github.com/systemd/systemd/blob/d67b1d18fcda2c8c5aacfc50f9591c8dc7a4a8a1/src/shared/sleep-config.c#L240
> 
> I believe with current systemd if you manually compute and provide
> resume=btrfs-partition and resume_offset=absolute-offset-of-swapfile it
> should take it, but using resume=file-on-btrfs will fail.

Yeah, that's where the swapfile is not accessed through the filesystem,
so the block offsets need to be calculated externally.
