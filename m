Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36F336DE2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhD1RYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:24:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:55114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241618AbhD1RYA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:24:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F8E2ACF9;
        Wed, 28 Apr 2021 17:23:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70A66DA783; Wed, 28 Apr 2021 19:20:51 +0200 (CEST)
Date:   Wed, 28 Apr 2021 19:20:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not consider send context as valid when trying
 to flush qgroups
Message-ID: <20210428172051.GP7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <1020602e269415d91c713afdfb9a11921a3ceda6.1619087848.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1020602e269415d91c713afdfb9a11921a3ceda6.1619087848.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 22, 2021 at 12:09:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At qgroup.c:try_flush_qgroup() we are asserting that current->journal_info
> is either NULL or has the value BTRFS_SEND_TRANS_STUB.
> 
> However allowing for BTRFS_SEND_TRANS_STUB makes no sense because:
> 
> 1) It is misleading, because send operations are read-only and do not
>    ever need to reserve qgroup space;
> 
> 2) We already assert that current->journal_info != BTRFS_SEND_TRANS_STUB
>    at transaction.c:start_transaction();
> 
> 3) On a kernel without CONFIG_BTRFS_ASSERT=y set, it would result in
>    a crash if try_flush_qgroup() is ever called in a send context, because
>    at transaction.c:start_transaction we cast current->journal_info into
>    a struct btrfs_trans_handle pointer and then dereference it.
> 
> So just do allow a send context at try_flush_qgroup() and update the
> comment about it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
