Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA162124AA
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgGBN3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:29:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:34070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbgGBN3C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:29:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D104BA17;
        Thu,  2 Jul 2020 13:28:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7447FDA781; Thu,  2 Jul 2020 15:22:17 +0200 (CEST)
Date:   Thu, 2 Jul 2020 15:22:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: qgroup: Fix the long existing regression of
 btrfs/153
Message-ID: <20200702132217.GL27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702001434.7745-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 08:14:31AM +0800, Qu Wenruo wrote:
> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have to"),
> btrfs/153 always fails with early EDQUOT.
> 
> This is caused by the fact that:
> - We always reserved data space for even NODATACOW buffered write
>   This is mostly to improve performance, and not pratical to revert.
> 
> - Btrfs qgroup data and meta reserved space share the same limit
>   So it's not ensured to return EDQUOT just for that data reservation,
>   metadata reservation can also get EDQUOT, means we can't go the same
>   solution as that commit.
> 
> This patchset will solve it by doing extra qgroup space flushing when
> EDQUOT is hit.
> 
> This is a little like what we do in ticketing space reservation system,
> but since there are very limited ways for qgroup to reclaim space,
> currently it's still handled in qgroup realm, not reusing the ticketing
> system yet.
> 
> By this, this patch could solve the btrfs/153 problem, while still keep
> btrfs qgroup space usage under the limit.
> 
> The only cost is, when we're near qgroup limit, we will cause more dirty
> inodes flush and transaction commit, much like what we do when the
> metadata space is near exhausted.
> So the cost should be still acceptable.

This sounds like a reasonable solution to me. Making the behaviour
closer to ticket reservations would probably make it easier to switch
some day.
