Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1821168A4C
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 00:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgBUXRp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 18:17:45 -0500
Received: from magic.merlins.org ([209.81.13.136]:39142 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgBUXRp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 18:17:45 -0500
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1j5HYA-0005ml-KG by authid <merlin>; Fri, 21 Feb 2020 15:17:38 -0800
Date:   Fri, 21 Feb 2020 15:17:38 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: How to roll back btrfs filesystem a few revisions?
Message-ID: <20200221231738.GD11482@merlins.org>
References: <2656316.bop9uDDU3N@merkaba>
 <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org>
 <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org>
 <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221230740.GQ19481@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 03:07:40PM -0800, Marc MERLIN wrote:
> And now for extra points, this also damaged a 2nd of my filesystems on the same VG :(
> [64723.601630] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
> [64723.628708] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
> [64897.028176] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001
> [64897.080355] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001

While I'm going to destroy and recreate one of the two filesystems, the
other one has lots of of btrfs relationships I really don't want to lose
and have to re-create.

I'm sure it got in a bad state because it got write denied when trying
to write.
I don't care about last data written, is there a clean way to open the
filesystem and revert it a few revisions?
Basically I want
git reset --hard HEAD^ or HEAD^^

I'm ok with data loss, I just want to get back to a previous good known
consistent state. If I've not disabled COW (which I have not), this
should be possible, correct?

If so, how to I proceed?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
