Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCBEC8953
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 15:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfJBNKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 09:10:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:58052 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfJBNKo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 09:10:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45189AEC4;
        Wed,  2 Oct 2019 13:10:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE817DA88C; Wed,  2 Oct 2019 15:11:00 +0200 (CEST)
Date:   Wed, 2 Oct 2019 15:11:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: transaction: Add comment for btrfs
 transaction lifespan
Message-ID: <20191002131100.GO2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190822072500.22730-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822072500.22730-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 22, 2019 at 03:24:59PM +0800, Qu Wenruo wrote:
> Just a overview of the basic btrfs transaction lifespan, including the
> following states:
> - No transaction states
> - Transaction N [[TRANS_STATE_RUNNING]]
> - Transaction N [[TRANS_STATE_COMMIT_START]]
> - Transaction N [[TRANS_STATE_COMMIT_DOING]]
> - Transaction N [[TRANS_STATE_UNBLOCKED]]
> - Transaction N [[TRANS_STATE_COMPLETED]]
> 
> For each states, the comment will include:
> - Basic explaination about current state
> - How to go next stage
> - What will happen if we call variant start_transaction() functions
> - Relationship to transaction N+1
> 
> This doesn't provide much tech details, but just a cheat sheet for
> reader to get into the code a little easier.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Great, thanks.

Reviewed-by: David Sterba <dsterba@suse.com>
