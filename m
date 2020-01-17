Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD8140D2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 16:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgAQPA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 10:00:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:43406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgAQPA5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 10:00:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 281FABC78;
        Fri, 17 Jan 2020 15:00:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6DF1DA871; Fri, 17 Jan 2020 16:00:41 +0100 (CET)
Date:   Fri, 17 Jan 2020 16:00:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs: drop log root for dropped roots
Message-ID: <20200117150041.GI3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200117141245.42971-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117141245.42971-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 09:12:45AM -0500, Josef Bacik wrote:
> If we fsync on a subvolume and create a log root for that volume, and
> then later delete that subvolume we'll never clean up its log root.  Fix
> this by making switch_commit_roots free the log for any dropped roots we
> encounter.  The extra churn is because we need a btrfs_trans_handle, not
> the btrfs_transaction.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Update commit message to indicate we need the trans_handle instead of the
>   transaciton.

Thanks, added to misc-next.
