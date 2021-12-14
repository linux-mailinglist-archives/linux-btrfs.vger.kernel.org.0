Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3C474558
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 15:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhLNOjp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 09:39:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48044 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbhLNOjl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 09:39:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3AB462114E;
        Tue, 14 Dec 2021 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639492780;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTQMZrromFxDQ04rTYZx9sNMtP1ECka4Qh1n6Df+ZQI=;
        b=gCQkJ8A6d3zvPAfXK+LxcbdDrma8JQ34v0uPrMYtqD0y43ML8HCk8c1Q4QpQmhdqB4WoBL
        Zk8ek1MEuZwbEoz/9BSLTG9Hdr6M3HOeXxMVQ29WLN0Cz3kyXb5WjBeEptGSglvYT0N9de
        RL5TrUXVh2EFbttu5N2TuochHOOg/vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639492780;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTQMZrromFxDQ04rTYZx9sNMtP1ECka4Qh1n6Df+ZQI=;
        b=CQlKVm1nPd9gZr16Er5H4eluW1RqaR0p+1LhUxFEf8EMcmVAySPL8sy5vpuYbekZxoXJ08
        98hH3mZaYp2UF/BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3369BA3B93;
        Tue, 14 Dec 2021 14:39:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 224F8DA781; Tue, 14 Dec 2021 15:39:22 +0100 (CET)
Date:   Tue, 14 Dec 2021 15:39:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fixes for an error path when creating a
 subvolume
Message-ID: <20211214143922.GV28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1639384875.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639384875.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 13, 2021 at 08:45:11AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patches fix an error path when creating a subvolume, exposed
> by generic/475.
> 
> Filipe Manana (3):
>   btrfs: fix invalid delayed ref after subvolume creation failure
>   btrfs: fix warning when freeing leaf after subvolume creation failure
>   btrfs: skip transaction commit after failure to create subvolume

Added to misc-next, thanks.
