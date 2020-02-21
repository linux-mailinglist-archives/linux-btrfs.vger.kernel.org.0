Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C23166F50
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 06:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgBUFpr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 00:45:47 -0500
Received: from len.romanrm.net ([91.121.86.59]:60346 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgBUFpr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 00:45:47 -0500
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 581B140653;
        Fri, 21 Feb 2020 05:45:45 +0000 (UTC)
Date:   Fri, 21 Feb 2020 10:45:45 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
Message-ID: <20200221104545.6335cbd1@natsu>
In-Reply-To: <20200221053804.GA7869@merlins.org>
References: <2656316.bop9uDDU3N@merkaba>
        <20200219225051.39ca1082@natsu>
        <20200219153652.GA26873@merlins.org>
        <20200220214649.GD26873@merlins.org>
        <20200221053804.GA7869@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 20 Feb 2020 21:38:04 -0800
Marc MERLIN <marc@merlins.org> wrote:

> I had a closer look, and even with 5.4.20, my whole lv is full now:
>   LV Name                thinpool2
>   Allocated pool data    99.99%
>   Allocated metadata     59.88%

Oversubscribing thin storage should be done carefully and only with a very
good reason, and when you run out of something you didn't have in the first
place, seems hard to blame Btrfs or anyone else for it.

> Sure enough, that broken ubuntu one (that really only needs 4GB or so),
> is now taking 60% of the mapped size (i.e. everything that was left)
>   LV Name                ubuntu
>   Mapped size            60.26%

Provide full output of lvdisplay -m, not snippets of it. As is, "omg 60%"
tells nothing to anyone, who knows maybe this LV is maybe 6 GB in size, and at
60% used, it comes out to 4GB exactly.

> I'm now running this overnight, but any command on that filesystem, just
> hangs for now:
> gargamel:/mnt/btrfs_pool2/backup/ubuntu# fstrim -v .

At this point "Data%" in `lvs` output should be decreasing steadily. (if not,
check your dmesg for some kind of a hang or deadlock).

-- 
With respect,
Roman
