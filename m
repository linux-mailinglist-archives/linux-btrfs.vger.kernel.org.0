Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CAA1F6C24
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFKQ0T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 12:26:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:47076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgFKQ0T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 12:26:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9E87AF5B;
        Thu, 11 Jun 2020 16:26:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9344DDA82A; Thu, 11 Jun 2020 18:26:11 +0200 (CEST)
Date:   Thu, 11 Jun 2020 18:26:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] Btrfs: use btrfs_alloc_data_chunk_ondemand() when
 allocating space for relocation
Message-ID: <20200611162611.GS27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200609101942.29509-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609101942.29509-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 09, 2020 at 11:19:42AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We currently use btrfs_check_data_free_space() when allocating space for
> relocating data extents, but that is not necessary because that function
> combines btrfs_alloc_data_chunk_ondemand(), which does the actual space
> reservation, and btrfs_qgroup_reserve_data().
> 
> We can use btrfs_alloc_data_chunk_ondemand() directly because we know we
> do not need to reserve qgroup space since we are dealing with a relocation
> tree, which can never have qgroups (btrfs_qgroup_reserve_data() does
> nothing as is_fstree() returns false for a relocation tree).
> 
> Conversely we can use btrfs_free_reserved_data_space_noquota() directly
> instead of btrfs_free_reserved_data_space(), since we had no qgroup
> reservation when allocating space.
> 
> This change is preparatory work for another patch in this series that
> makes relocation reserve the exact amount of space it needs to relocate
> a data block group.  The function btrfs_check_data_free_space() has
> the incovenient of requiring a start offset argument and we will want to
> be able to allocate space for multiple ranges, which are not consecutive,
> at once.

Patches 1 and 2 are ok, 3/3 is supposed to be dropped so I'll add only
the two. Thanks.
