Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E384639F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 16:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbhK3P1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Nov 2021 10:27:24 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:36726 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243181AbhK3P0u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Nov 2021 10:26:50 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id F3999A6282; Tue, 30 Nov 2021 10:23:30 -0500 (EST)
Date:   Tue, 30 Nov 2021 10:23:30 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: 'btrfs replace' hangs at end of replacing a device (v5.10.82)
Message-ID: <20211130152330.GI17148@hungrycats.org>
References: <20211129214647.GH17148@hungrycats.org>
 <2b99db41-11ef-db6f-99f3-2a1aa950292d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b99db41-11ef-db6f-99f3-2a1aa950292d@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 30, 2021 at 02:36:38PM +0200, Nikolay Borisov wrote:
> 
> 
> On 29.11.21 г. 23:46, Zygo Blaxell wrote:
> > Not a new bug, but it's still there.  btrfs replace ends in a transaction
> > deadlock.
> > 
> 
> 
> Please provide the output of
> 
> grep PREEMPT /path/to/running/kernel/kconfig

	# CONFIG_PREEMPT_NONE is not set
	CONFIG_PREEMPT_VOLUNTARY=y
	# CONFIG_PREEMPT is not set
	CONFIG_PREEMPT_COUNT=y
	CONFIG_PREEMPT_NOTIFIERS=y
	CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
	CONFIG_PREEMPTIRQ_TRACEPOINTS=y
	CONFIG_PREEMPTIRQ_DELAY_TEST=m

