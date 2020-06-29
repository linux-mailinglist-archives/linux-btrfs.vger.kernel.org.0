Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC92A20E13D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jun 2020 23:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgF2Ux1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jun 2020 16:53:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387791AbgF2UxN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 16:53:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12378ACB8;
        Mon, 29 Jun 2020 20:53:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4AEFEDA791; Mon, 29 Jun 2020 22:52:56 +0200 (CEST)
Date:   Mon, 29 Jun 2020 22:52:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Fix enum values print in tracepoints
Message-ID: <20200629205255.GN27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200619122451.31162-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619122451.31162-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 19, 2020 at 03:24:45PM +0300, Nikolay Borisov wrote:
> While looking at tracepoint dumps with trace-cmd report I observed that
> tracepoints that should have printed text instead of raw values weren't
> doing so:
> 
> 13 kworker/u8:1-61    [000]    66.299527: btrfs_flush_space:    5302ee13-c65e-45bb-98ef-8fe3835bd943: state=3(0x3) flags=4(METADATA) num_bytes=2621440 ret=0
> 
> In the above line instead of (0x3) BTRFS_RESERVE_FLUSH_ALL should be printed. I.e
> the correct output should be:
> 
> 6 fio-370   [002]    56.762402: btrfs_trigger_flush:  d04cd7ac-38e2-452f-a7f5-8157529fd5f0: preempt: flush=3(BTRFS_RESERVE_FLUSH_ALL) flags=4(METADATA) bytes=655360
> 
> Investigating this turned out to be caused  because enum values weren't exported
> to user space via TRACE_DEFINE_ENUM. This is required in order for user space
> tools to correctly map the raw binary values to their textual representation.
> More information can be found in commit 190f0b76ca49 ("mm: tracing: Export enums in tracepoints to user space")
> 
> This series follows the approach taken by 190f0b76ca49 in defining the various
> enum mapping structures.
> 
> Nikolay Borisov (6):
>   btrfs: tracepoints: Fix btrfs_trigger_flush printout
>   btrfs: tracepoints: Fix extent type symbolic name print
>   btrfs: tracepoints: Move FLUSH_ACTIONS define
>   btrfs: tracepoints: Fix qgroup reservation type printing
>   btrfs: tracepoints: Switch extent_io_tree_owner to using EM macro
>   btrfs: tracepoints: Convert flush states to using EM macros

Whitespace fixed and series added to misc-next, thanks.
