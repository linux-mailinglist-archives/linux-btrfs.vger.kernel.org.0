Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B822F5DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgG0Qzc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 12:55:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:39952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgG0Qzb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 12:55:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B05DAC1D;
        Mon, 27 Jul 2020 16:55:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BCAACDA701; Mon, 27 Jul 2020 18:55:01 +0200 (CEST)
Date:   Mon, 27 Jul 2020 18:55:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not evaluate the expression with
 !CONFIG_BTRFS_ASSERT
Message-ID: <20200727165501.GQ3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200724164147.39925-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724164147.39925-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 24, 2020 at 12:41:47PM -0400, Josef Bacik wrote:
> While investigating a performance issue I noticed that turning off
> CONFIG_BTRFS_ASSERT had no effect in what I was seeing in perf,
> specifically check_setget_bounds() was around 5% for this workload.

Can you please share the perf profile and .config?  I find it hard to
believe that check_setget_bounds would be taking 5% overall. Also you
said that this was with integrity-checker compiled in so this kind of
invalidates any performance claims.

I've been watching perf top for various debugging and release builds for
some time and this one makes it to top 5 but never #1 or #2.

The function compiles to a few instructions and the hot path is
correctly predicted by compiler, so I'm really curious what's so special
about the workload that it needs to call it in 1/20th of overall time.

> Upon investigation I realized that I made a mistake when I added
> ASSERT(), I would still evaluate the expression, but simply ignore the
> result.

Vast majority of the assert expressions are simple expressions without
side effects, but compiler still generates the code. In most cases it's
a few no-op movs, so this leaves the impact on the function calls.

Making the assert a true no-op saves some asm code and gains some
performance, but I don't want to remove the check_setget_bounds calls as
it's another line of defence against random in-memory corruptions.

Given that it's called deep inside many functions, it would be
impractical to add checking of each call. Instead, we can set a bit and
do a delayed abort in case it's found. I have that as a prototype and
will post it later.

> This is useless, and has a marked impact on performance.  This
> microbenchmark is the watered down version of an application that is
> experiencing performance issues, and does renames and creates over and
> over again.  Doing these operations 200k times without this patch takes
> 13 seconds on my machine.  With this patch it takes 7 seconds.

Do you have that as a script?
