Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098AC3D8E1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 14:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhG1MoX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 08:44:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40074 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbhG1MoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 08:44:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3963C1FF95;
        Wed, 28 Jul 2021 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627476260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76ZghQazHqgPnjtZ6jv32vw8OyulqjmhmMCMQfHyAcY=;
        b=mqyJxXTUDGyd8qYi2dqPXUUiIfzQInv6II4CQG7LSnK8VkeV9zs2Q71mADzj4o1G1ZYEBO
        BnOshlsZJiPEhVkK8ncz5jnVamNaZ8+lBOGtKCa5UkV2CqjjgRAvT7OeEt7O2iiM4MW93y
        FxZW1gHX4o7e4gZjHeb9mChij70clcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627476260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76ZghQazHqgPnjtZ6jv32vw8OyulqjmhmMCMQfHyAcY=;
        b=Bd9SsyggGrza90pCE33fcnHHYSU4GJ9OqkzL+1iN9vVkdRbKc6sDM30tNrRDtZy2TcqpAS
        KNuJ1C+HqNvsYoCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 326AEA3B85;
        Wed, 28 Jul 2021 12:44:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 15B39DA8A7; Wed, 28 Jul 2021 14:41:34 +0200 (CEST)
Date:   Wed, 28 Jul 2021 14:41:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fsync changes, a bug fix and a couple
 improvements
Message-ID: <20210728124134.GB5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1627379796.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627379796.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 11:24:42AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The first patch in the series fixes a bug where a directory fsync, following
> by inode eviction, followed by renaming a file and syncing the log results
> in losing a file if a power failure happens and the log is replayed.
> 
> The remaining two changes are independent, and are about avoiding unnecessary
> work during operations that need to check or modify the log (renames, adding
> a hard link, unlinks) and making renames hold log commits for a shorter
> period.

Added to misc-next, thanks.
