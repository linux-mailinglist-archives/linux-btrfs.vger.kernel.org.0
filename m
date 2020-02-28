Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB5173CBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgB1QUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 11:20:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:41432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1QUi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 11:20:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 04F85B331;
        Fri, 28 Feb 2020 16:20:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A2E3EDA79B; Fri, 28 Feb 2020 17:20:16 +0100 (CET)
Date:   Fri, 28 Feb 2020 17:20:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix crash during unmount due to race with delayed
 inode workers
Message-ID: <20200228162016.GP2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200228130436.26128-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228130436.26128-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 28, 2020 at 01:04:36PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During unmount we can have a job from the delayed inode items work queue
> still running, that can lead to at least two bad things_
> 
> 1) A crash, because the worker can try to create a transaction just
>    after the fs roots were freed;
> 
> 2) A transaction leak, because the worker can create a transaction
>    before the fs roots are freed and just after we committed the last
>    transaction and after we stopped the transaction kthread.
...
> +		 * This is a very rare case.

Added to misc-next, thanks. I'll tag it for stable but will not put to
5.6-rc queue given that it's very rare, unless requested.
