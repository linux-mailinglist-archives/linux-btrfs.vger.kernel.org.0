Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB202168FBD
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 16:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBVPYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 10:24:51 -0500
Received: from magic.merlins.org ([209.81.13.136]:50800 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBVPYv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 10:24:51 -0500
Received: from svh-gw.merlins.org ([173.11.111.145]:38898 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1j5Wdy-00046V-1z; Sat, 22 Feb 2020 07:24:41 -0800
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1j5Wdx-0005YB-ON; Sat, 22 Feb 2020 07:24:37 -0800
Date:   Sat, 22 Feb 2020 07:24:37 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Mamedov <rm@romanrm.net>, dsterba@suse.cz,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <20200222152437.GW19481@merlins.org>
References: <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org>
 <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org>
 <3e94351d-6f32-1036-ab24-0dc1b843c969@toxicpanda.com>
 <20200222000142.GA31491@merlins.org>
 <20200222010637.GB31491@merlins.org>
 <20200222012312.GC31491@merlins.org>
 <20200222145134.GV19481@merlins.org>
 <71dc4b69-cab4-596c-530e-c7059a19f998@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71dc4b69-cab4-596c-530e-c7059a19f998@toxicpanda.com>
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

On Sat, Feb 22, 2020 at 09:52:56AM -0500, Josef Bacik wrote:
> Go ahead and blow it away, and I'll add "dm-thinp failure mode" to my list
> of things to look into.  Sorry Marc,

No worries, I got lucky that it hit a filesystem that's easy to
recreate, so it's not a huge deal.

Thanks for the replies.
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
