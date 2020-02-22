Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6011168ABC
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 01:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgBVAIu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 19:08:50 -0500
Received: from magic.merlins.org ([209.81.13.136]:39618 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbgBVAIu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 19:08:50 -0500
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1j5ILe-00012S-EG by authid <merlin>; Fri, 21 Feb 2020 16:08:46 -0800
Date:   Fri, 21 Feb 2020 16:08:46 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Mamedov <rm@romanrm.net>, dsterba@suse.cz,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: How to roll back btrfs filesystem a few revisions?
Message-ID: <20200222000846.GE11482@merlins.org>
References: <2656316.bop9uDDU3N@merkaba>
 <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org>
 <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org>
 <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org>
 <20200221231738.GD11482@merlins.org>
 <5cb4781d-5580-0a8d-562b-c8bfa3def5b4@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb4781d-5580-0a8d-562b-c8bfa3def5b4@toxicpanda.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 06:47:26PM -0500, Josef Bacik wrote:
> Yeah you can try the backup roots, btrfs check -b and see if that works out?

So, I'm not super clear on how to do this.
the backup roots are not really a way to go back in time, they're just
the same data that maybe didn't get written, so you can maybe go to the
last revision if all the roots are not up to date, correct?

If so, is it best to get the last root since it's the one most likely to
be the oldest?

More generally do I do a check -b to see if that looks clean, and if so,
what's the command to replicate that root onto all the other roots?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
