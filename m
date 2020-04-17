Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305D51AE0FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgDQPXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 11:23:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbgDQPXA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 11:23:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2EAD0AEEC;
        Fri, 17 Apr 2020 15:22:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DCE2CDA727; Fri, 17 Apr 2020 17:22:18 +0200 (CEST)
Date:   Fri, 17 Apr 2020 17:22:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Btrfs: fix memory leak of transaction when deleting
 unused block group
Message-ID: <20200417152218.GQ5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200417144012.9269-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417144012.9269-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 03:40:12PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When cleaning pinned extents right before deleting an unused block group,
> we check if there's still a previous transaction running and if so we
> increment its reference count before using it for cleaning pinned ranges
> in its pinned extents iotree. However we ended up never decrementing the
> reference count after using the transaction, resulting in a memory leak.
> 
> Fix it by decrementing the reference count.
> 
> Fixes: fe119a6eeb6705 ("btrfs: switch to per-transaction pinned extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
