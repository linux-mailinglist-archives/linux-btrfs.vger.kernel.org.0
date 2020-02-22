Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9366F168B8D
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 02:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBVBXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 20:23:17 -0500
Received: from magic.merlins.org ([209.81.13.136]:40884 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgBVBXR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 20:23:17 -0500
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1j5JVg-0002pA-Ed by authid <merlin>; Fri, 21 Feb 2020 17:23:12 -0800
Date:   Fri, 21 Feb 2020 17:23:12 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Mamedov <rm@romanrm.net>, dsterba@suse.cz,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: btrfs filled up dm-thin and df%: shows 8.4TB of data used when
 I'm only using 10% of that.
Message-ID: <20200222012312.GC31491@merlins.org>
References: <2656316.bop9uDDU3N@merkaba>
 <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org>
 <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org>
 <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org>
 <3e94351d-6f32-1036-ab24-0dc1b843c969@toxicpanda.com>
 <20200222000142.GA31491@merlins.org>
 <20200222010637.GB31491@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222010637.GB31491@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 05:06:37PM -0800, Marc MERLIN wrote:
> You asked for a check, it's running but may take a while:
> gargamel:~# btrfs check /dev/mapper/vgds2-ubuntu
> Checking filesystem on /dev/mapper/vgds2-ubuntu
> UUID: 905c90db-8081-4071-9c79-57328b8ac0d5
> checking extents
> checking free space cache
> checking fs roots
> checking only csum items (without verifying data)
> 
> I'll paste the completion when it's done.
 
Ok, faster than I thought. btrfs check came back clean
I added spaces for readability.
So this claims I'm using 9TB?

Is it possible that I'm hitting this problem
1) I did really fill the filesystem (well not to the filesystem size but
to the size that dm-thin was not able to give blocks anymore)
2) I deleted/freed up the space
3) btrfs needs space to free up the space, and there is no space left,
so it's unable to mark the free blocks, as free, and I'm therefore
stuck?

found 9 255 703 285 760 bytes used, no error found
total csum bytes: 9 019 442 564
total tree bytes: 17 533 894 656
total fs tree bytes: 7 411 073 024
total extent tree bytes: 379 928 576
btree space waste bytes: 1 769 834 145
file data blocks allocated: 9267682025472
 referenced 9272533270528


Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
