Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09031DE35B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgEVJkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 05:40:45 -0400
Received: from bezitopo.org ([45.55.162.231]:37724 "EHLO marozi.bezitopo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbgEVJkp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 05:40:45 -0400
Received: from bezitopo.org (unknown [IPv6:2001:5b0:211f:ee48:4e72:b9ff:fe7b:8dbf])
        by marozi.bezitopo.org (Postfix) with ESMTPSA id 1A7F95FAD3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 May 2020 05:40:43 -0400 (EDT)
Received: from puma.localnet (localhost [127.0.0.1])
        by bezitopo.org (Postfix) with ESMTP id 6097930E93
        for <linux-btrfs@vger.kernel.org>; Fri, 22 May 2020 05:40:36 -0400 (EDT)
From:   Pierre Abbat <phma@bezitopo.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Trying to mount hangs
Date:   Fri, 22 May 2020 05:40:36 -0400
Message-ID: <2582603.WkyslYimHe@puma>
In-Reply-To: <290f9ee7-1aed-2a92-bdba-063d238bd5bc@gmx.com>
References: <2549429.Qys7a5ZjRC@puma> <7541432.rVhWMRgfCE@puma> <290f9ee7-1aed-2a92-bdba-063d238bd5bc@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thursday, May 21, 2020 9:32:54 PM EDT Qu Wenruo wrote:
> Considering your btrfs check reports no serious problem, the hang looks
> strange.
> 
> The remaining possibility is the log tree.
> 
> You could try to boot using any liveCD with new enough kernel, then
> btrfs ins dump-super <device> | grep log_root

I can do that booted normally from the M.2. The output is
log_root                862339072
log_root_transid        0
log_root_level          0

> If the result is not 0, then try btrfs rescue zero-log, then try mount
> again.

You seem to be misunderstanding me. I'm not trying to fix the broken filesystem; 
I already recovered the files to a new drive. I'm trying to give you enough 
information to reproduce the hang in mount, so that you can fix the bug. If I 
have to copy the entire filesystem to an external drive and ship it, I'll do 
that, but I'm hoping that some smaller amount of data that I can upload in a 
few hours would be sufficient.

When I write a function that reads a file of a certain format, unless it's a 
static file like a list of all primes less than 65536 with associated data, I 
fuzz it so that, if it's given a file that's not exactly in that format, it 
won't hang or crash.

Pierre
-- 
li fi'u vu'u fi'u fi'u du li pa



