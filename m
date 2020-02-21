Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C1A166F3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 06:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgBUFiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 00:38:16 -0500
Received: from magic.merlins.org ([209.81.13.136]:54784 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgBUFiP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 00:38:15 -0500
Received: from svh-gw.merlins.org ([173.11.111.145]:49938 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1j510m-0007LG-KU; Thu, 20 Feb 2020 21:38:10 -0800
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1j510m-0002Nr-3N; Thu, 20 Feb 2020 21:38:04 -0800
Date:   Thu, 20 Feb 2020 21:38:04 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Roman Mamedov <rm@romanrm.net>
Message-ID: <20200221053804.GA7869@merlins.org>
References: <2656316.bop9uDDU3N@merkaba>
 <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org>
 <20200220214649.GD26873@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220214649.GD26873@merlins.org>
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
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 20, 2020 at 01:46:49PM -0800, Marc MERLIN wrote:
> Well, turns out this was a more serious bug than we thought.
> With dm-thin overcommit, it causes this:
> [1324107.675334] BTRFS info (device dm-13): forced readonly
> [1324107.692909] BTRFS warning (device dm-13): Skipping commit of aborted transaction.
> [1324107.717141] BTRFS: error (device dm-13) in cleanup_transaction:1828: errno=-5 IO failure
> [1324107.743298] BTRFS info (device dm-13): delayed_refs has NO entry
> [1324107.817671] device-mapper: thin: 252:9: switching pool to write mode
> [1324108.662095] BTRFS error (device dm-13): bad tree block start, want 9050645626880 have 0
> [1324108.694286] BTRFS error (device dm-13): bad tree block start, want 9050645626880 have 0

I had a closer look, and even with 5.4.20, my whole lv is full now:
  LV Name                thinpool2
  Allocated pool data    99.99%
  Allocated metadata     59.88%

Sure enough, that broken ubuntu one (that really only needs 4GB or so),
is now taking 60% of the mapped size (i.e. everything that was left)
  LV Name                ubuntu
  Mapped size            60.26%

I'm now running this overnight, but any command on that filesystem, just
hangs for now:
gargamel:/mnt/btrfs_pool2/backup/ubuntu# fstrim -v .

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
