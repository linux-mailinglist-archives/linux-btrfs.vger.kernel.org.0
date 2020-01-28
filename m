Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5573114BD7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 17:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1QOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 11:14:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:47612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgA1QOQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 11:14:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43C17AC92;
        Tue, 28 Jan 2020 16:14:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E8CF1DA730; Tue, 28 Jan 2020 17:13:56 +0100 (CET)
Date:   Tue, 28 Jan 2020 17:13:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] Btrfs: don't iterate mod seq list when putting a
 tree mod seq
Message-ID: <20200128161356.GU3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200122122354.30132-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122122354.30132-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 22, 2020 at 12:23:54PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Each new element added to the mod seq list is always appended to the list,
> and each one gets a sequence number coming from a counter which gets
> incremented everytime a new element is added to the list (or a new node
> is added to the tree mod log rbtree). Therefore the element with the
> lowest sequence number is always the first element in the list.
> 
> So just remove the list iteration at btrfs_put_tree_mod_seq() that
> computes the minimum sequence number in the list and replace it with
> a check for the first element's sequence number.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
