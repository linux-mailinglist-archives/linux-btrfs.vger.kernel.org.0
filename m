Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA754323E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 18:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhJRQgM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 12:36:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41788 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhJRQgM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 12:36:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D7B1621961;
        Mon, 18 Oct 2021 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634574839;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CRj3BV9VL0MbfDbu/rfLLLdeuVxcpq+qB3z1KZN/VmI=;
        b=w0rJeg92DrdShl0fywJ3hNicEcHmAy47ILx1FFGPDL1iGYVqjzTN4p1grdZos6E38sF3ME
        llqRI8ihSCw/gruqEmY+2G4hiTi9m0oqIH2a0pLaVPIfuei20X3BYh6+Lt2/t4AatZ2stI
        yfGV3+zd8GbnanTnkw9GnKB8KJ7BJdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634574839;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CRj3BV9VL0MbfDbu/rfLLLdeuVxcpq+qB3z1KZN/VmI=;
        b=3JtNzLManpwtw6hYxstRAnZllfEYnZeNciZpX4Hm+n1Lyaw4Zitx1rlx11/1zEtA2ykNyP
        1XQzmkGXODRPTfBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D1AF8A3B83;
        Mon, 18 Oct 2021 16:33:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2800DA7A3; Mon, 18 Oct 2021 18:33:32 +0200 (CEST)
Date:   Mon, 18 Oct 2021 18:33:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: fix a deadlock between chunk allocation
 and chunk tree modifications
Message-ID: <20211018163332.GP30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1633604360.git.fdmanana@suse.com>
 <cover.1634115580.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634115580.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 10:12:48AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This fixes a deadlock between a task allocating a metadata or data chunk
> and a task that is modifying the chunk btree and it's not in a chunk
> allocation or removal context. The first patch is the fix, the second one
> just updates a couple comments and it's independent of the fix.
> 
> v2: Updated stale comment after the fix (patch 1/2).
> 
> v3: Moved the logic to reserve chunk space out of btrfs_search_slot() into
>     every path that modifies the chunk btree (which are the cases listed in
>     the change log of patch 1/2) and updated two more comments in patch 1/2.

Added to misc-next, thanks.
