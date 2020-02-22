Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F618168F69
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgBVOvn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 09:51:43 -0500
Received: from magic.merlins.org ([209.81.13.136]:50338 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgBVOvm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 09:51:42 -0500
Received: from svh-gw.merlins.org ([173.11.111.145]:58258 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1j5W7y-0001ed-SM; Sat, 22 Feb 2020 06:51:37 -0800
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1j5W7y-00022P-AW; Sat, 22 Feb 2020 06:51:34 -0800
Date:   Sat, 22 Feb 2020 06:51:34 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Mamedov <rm@romanrm.net>, dsterba@suse.cz,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <20200222145134.GV19481@merlins.org>
References: <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org>
 <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org>
 <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org>
 <3e94351d-6f32-1036-ab24-0dc1b843c969@toxicpanda.com>
 <20200222000142.GA31491@merlins.org>
 <20200222010637.GB31491@merlins.org>
 <20200222012312.GC31491@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222012312.GC31491@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 173.11.111.145
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Checker-Version: SpamAssassin 3.4.4-rc1-mmrules_20121111 (2020-01-18)
        on magic.merlins.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=7.0 tests=KHOP_HELO_FCRDNS,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4-rc1-mmrules_20121111
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: merlins.org]
        *  1.0 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
Subject: Re: btrfs filled up dm-thin and df%: shows 8.4TB of data used when
 I'm only using 10% of that.
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 05:23:12PM -0800, Marc MERLIN wrote:
> On Fri, Feb 21, 2020 at 05:06:37PM -0800, Marc MERLIN wrote:
> > You asked for a check, it's running but may take a while:
> > gargamel:~# btrfs check /dev/mapper/vgds2-ubuntu
> > Checking filesystem on /dev/mapper/vgds2-ubuntu
> > UUID: 905c90db-8081-4071-9c79-57328b8ac0d5
> > checking extents
> > checking free space cache
> > checking fs roots
> > checking only csum items (without verifying data)
> > 
> > I'll paste the completion when it's done.
>  
> Ok, faster than I thought. btrfs check came back clean
> I added spaces for readability.
> So this claims I'm using 9TB?
> 
> Is it possible that I'm hitting this problem
> 1) I did really fill the filesystem (well not to the filesystem size but
> to the size that dm-thin was not able to give blocks anymore)
> 2) I deleted/freed up the space
> 3) btrfs needs space to free up the space, and there is no space left,
> so it's unable to mark the free blocks, as free, and I'm therefore
> stuck?
> 
> found 9 255 703 285 760 bytes used, no error found
> total csum bytes: 9 019 442 564
> total tree bytes: 17 533 894 656
> total fs tree bytes: 7 411 073 024
> total extent tree bytes: 379 928 576
> btree space waste bytes: 1 769 834 145
> file data blocks allocated: 9267682025472
>  referenced 9272533270528

Ok, last call before I delete this filesystem and recover my system to a
working state. I don't need the filesystem fixed, it's fairly quick for
me restore it, but obviously if there is any useful state in it for
improving the code, that will be lost.

I understand it's the weekend, if someone thinks I should wait until
monday to give some other folks the chance to see/reply, let me know,
and I'll keep my system down until monday.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
