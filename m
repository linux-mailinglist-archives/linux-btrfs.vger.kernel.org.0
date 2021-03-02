Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17632B294
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbhCCB6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:56358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236573AbhCBSYf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Mar 2021 13:24:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ABE86AAC5;
        Tue,  2 Mar 2021 17:24:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 033A0DA8BB; Tue,  2 Mar 2021 18:22:14 +0100 (CET)
Date:   Tue, 2 Mar 2021 18:22:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove unused variable ret
Message-ID: <20210302172214.GJ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1613715538-90761-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613715538-90761-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 02:18:58PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./fs/btrfs/disk-io.c:4403:5-8: Unneeded variable: "ret". Return "0" on
> line 4411.

That maybe stops the check to report the warning but it's not the right
way to fix the code. The callees do not properly handle and propagate
errors so that needs to be fixed, and the return value propagated from
btrfs_destroy_delayed_refs.
