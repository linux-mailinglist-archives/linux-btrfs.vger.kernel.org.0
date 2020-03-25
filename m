Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7099192D63
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 16:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCYPvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 11:51:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:48308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgCYPvE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 11:51:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A4806AE4D;
        Wed, 25 Mar 2020 15:51:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 716B6DA730; Wed, 25 Mar 2020 16:50:31 +0100 (CET)
Date:   Wed, 25 Mar 2020 16:50:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/5][v2] Deal with a few ENOSPC corner cases
Message-ID: <20200325155031.GE5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200313195809.141753-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313195809.141753-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 03:58:04PM -0400, Josef Bacik wrote:
> v1->v2:
> - Dropped "btrfs: only take normal tickets into account in
>   may_commit_transaction" because "btrfs: only check priority tickets for
>   priority flushing" should actually fix the problem, and Nikolay pointed out
>   that evict uses the priority list but is allowed to commit, so we need to take
>   into account priority tickets sometimes.
> - Added "btrfs: allow us to use up to 90% of the global rsv for" so that the
>   global rsv change was separate from the serialization patch.
> - Fixed up some changelogs.
> - Dropped an extra trace_printk that made it into v2.

The patchset seems to be based on some other, code I think it's the
tickets for data chunks. The compilation fails because
BTRFS_RESERVE_FLUSH_DATA is not defined, but it's mentioned in several
patches.

If the base patchset is a hard requirement then both would need to go in
at the same time, otherwise if it's possible to refresh this branch I
could add it to for-next now.
