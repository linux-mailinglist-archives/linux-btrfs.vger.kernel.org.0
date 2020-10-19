Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F33292BE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 18:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgJSQwv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 12:52:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgJSQwv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 12:52:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00A2EAE47;
        Mon, 19 Oct 2020 16:52:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C328DA8EA; Mon, 19 Oct 2020 18:51:20 +0200 (CEST)
Date:   Mon, 19 Oct 2020 18:51:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: some readhead fixes after removing or
 replacing a device
Message-ID: <20201019165120.GX6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1602499587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602499587.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 12, 2020 at 11:55:22AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset fixes use-after-free bugs and a hang after a device is removed
> or replaced. The hang only happens if a device replace happens while a scrub
> is running (on a device other then the source device of the replace operation),
> while the use-after-free bugs can happen without scrub involved.
> 
> The two first patches are the actual bug fixes, while the third patch just
> adds a lockdep assertion and the fourth and last patch just makes scrub not
> trigger readahead of the csums tree when it's not needed.
> 
> Filipe Manana (4):
>   btrfs: fix use-after-free on readahead extent after failure to create
>     it
>   btrfs: fix readahead hang and use-after-free after removing a device
>   btrfs: assert we are holding the reada_lock when releasing a readahead
>     zone
>   btrfs: do not start readahead for csum tree when scrubbing non-data
>     block groups

Thanks, added to misc-next.
