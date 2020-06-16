Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC511FB152
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgFPM5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 08:57:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgFPM50 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 08:57:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB908AF82;
        Tue, 16 Jun 2020 12:57:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 38F22DA7C3; Tue, 16 Jun 2020 14:57:14 +0200 (CEST)
Date:   Tue, 16 Jun 2020 14:57:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] Btrfs: remove no longer used trans_list member of
 struct btrfs_ordered_extent
Message-ID: <20200616125713.GA27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200615093658.287160-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615093658.287160-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 15, 2020 at 10:36:58AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The 'trans_list' member of an ordered extent was used to keep track of the
> ordered extents for which a transaction commit had to wait. These were
> ordered extents that were started and logged by an fsync. However we don't
> do that anymore and before we stopped doing it we changed the approach to
> wait for the ordered extents in commit 161c3549b45aee ("Btrfs: change how
> we wait for pending ordered extents"), which stopped using that list and
> therefore the 'trans_list' member is not used anymore since that commit.
> So just remove it since it's doing nothing and making each ordered extent
> structure waste memory (2 pointers).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
