Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1731305800
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314338AbhAZXFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:05:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:57570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393578AbhAZRxu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 12:53:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BF76ACE1;
        Tue, 26 Jan 2021 17:53:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1C6D1DA7D2; Tue, 26 Jan 2021 18:51:22 +0100 (CET)
Date:   Tue, 26 Jan 2021 18:51:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 0/8] A variety of lock contention fixes
Message-ID: <20210126175121.GS1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608319304.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608319304.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 18, 2020 at 02:24:18PM -0500, Josef Bacik wrote:
> v4->v5:
> - Added "btrfs: remove bogus BUG_ON in alloc_reserved_tree_block", as Nikolay
>   pointed out I needed to explain why we no longer needed one of the delayed ref
>   flushes, which led me down the rabbit hole of trying to understand why it
>   wasn't a problem anymore.  Turned out the BUG_ON() is bogus.
> - Added "btrfs: move delayed ref flushing for qgroup into qgroup helper",
>   instead of removing the flushing for qgroups completely, we still sort of need
>   it, even though it's actually still broken, so I've moved it into the qgroup
>   helper.
> - Added Nikolay's rb for the last patch.

Moved from topic branch to misc-next, thanks.
