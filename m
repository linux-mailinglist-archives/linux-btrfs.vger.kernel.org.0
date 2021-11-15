Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8F7450991
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhKOQ05 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 11:26:57 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37822 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhKOQ0z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 11:26:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 45FE821979;
        Mon, 15 Nov 2021 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636993438;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5E1AfqYBh4zLavladXrEyYh+uKXL0uW0j3lEZrSPTQ=;
        b=zMsAK8xb5Mr+yY3SIDYy8NPYFHniYkmWo2DIFiomnIVUporLbQNF4elEIsd/iVQFlFQ6+5
        8POlcINA8zI2YBS0ZiLED+2ZV+TDshntvaTloVCJmjRIgwLPMdoeXrgi3YPZ8TAjYCyANv
        ITR8WQuYds7YsqJX5MQESgYigLgE3to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636993438;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5E1AfqYBh4zLavladXrEyYh+uKXL0uW0j3lEZrSPTQ=;
        b=3KcJfyMMHjAwzWaLvacg6XWWpPfX2Vk6vgoQyo3HnHdzO8O4jOLEJ3UcksuiENZSJrZKyX
        wkn0j/LOwFGdiRBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3F505A3B81;
        Mon, 15 Nov 2021 16:23:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C22C6DA781; Mon, 15 Nov 2021 17:23:54 +0100 (CET)
Date:   Mon, 15 Nov 2021 17:23:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: fix discard support check
Message-ID: <20211115162354.GJ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org
References: <20211113224320.31415-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113224320.31415-1-wangyugui@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 14, 2021 at 06:43:20AM +0800, Wang Yugui wrote:
> [BUG]
> mkfs.btrfs(v5.15) output a message even if the disk is a HDD without
> TRIM/DISCARD support.
>   Performing full device TRIM /dev/sdc2 (326.03GiB) ...
> 
> [CAUSE]
> mkfs.btrfs check TRIM/DISCARD support through the content of
> queue/discard_granularity, but compare it against a wrong value.
> 
> When HDD without TRIM/DISCARD support, the content of
> queue/discard_granularity is '0' '\n' '\0', rather than '0' '\0'.
> 
> [FIX]
> - compare the value based on atoi() to provide more robustness
> - delete unnecessary '\n' in pr_verbose()
> 
> Fixes: c50c448518bb ("btrfs-progs: do sysfs detection of device discard capability")
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

Added to devel, thanks.
