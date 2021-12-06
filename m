Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B9A46A37B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 18:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345069AbhLFR4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 12:56:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35054 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbhLFR4b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 12:56:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9C76E212C1;
        Mon,  6 Dec 2021 17:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638813181;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vX9STzTgHR2Z/STS1HPkJvke1Uads3ZfS/ZlA3ikAlU=;
        b=n3lKvKy9K6EUhZhhIup+xoZ+7T9h0pIM9V3JXwPWhCErVopqIQ33zSRlAOFhQI1Yz7QG+V
        3LTWOzrAm7RacKVGOlM8C6yuFd8uGKS5+U1Eh2Z6CngkIsjMkho5P8LYT8CfyyIGpguy7w
        t5Ux3bPQqZtYEKtX2WuqYU6UbkXr2TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638813181;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vX9STzTgHR2Z/STS1HPkJvke1Uads3ZfS/ZlA3ikAlU=;
        b=2ADoNyeEqf9c1af0L78zjIUHBvZEvMpA1G2vVMYfP1O0z+x5wqedLszTv4vhB7BVkZYhIr
        kKR/mpEajMzjfpDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 95D97A3B88;
        Mon,  6 Dec 2021 17:53:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 845A5DA799; Mon,  6 Dec 2021 18:52:47 +0100 (CET)
Date:   Mon, 6 Dec 2021 18:52:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: fix a failure when looking for data
 backrefs after relocation
Message-ID: <20211206175247.GP28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <829076d580be74f270e740f8dded6fda45390311.1638440202.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829076d580be74f270e740f8dded6fda45390311.1638440202.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 10:21:43AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During a send, when trying to find roots from which to clone data extents,
> if the leaf of our file extent item was obtained before relocation for a
> data block group finished, we can end up trying to lookup for backrefs
> for an extent location (file extent item's disk_bytenr) that is not in
> use anymore. That is, the extent was reallocated and the transaction used
> for the relocation was committed. This makes the backref lookup not find
> anything and we fail at find_extent_clone() with -EIO and log an error
> message like the following:
> 
>   [ 7642.897365] BTRFS error (device sdc): did not find backref in send_root. inode=881, offset=2592768, disk_byte=1292025856 found extent=1292025856
> 
> This is because we are checking if relocation happened after we check if
> we found the backref for the file extent item we are processing. We should
> do it before, and in case relocation happened, do not attempt to clone and
> instead fallback to issuing write commands, which will read the correct
> data from the new extent location. The current check is being done too
> late, so fix this by moving it to right after we do the backref lookup and
> before checking if we found our own backref.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> David, this can be squashed into the patch:
> 
>    "btrfs: make send work with concurrent block group relocation"

Squashed, thanks.
