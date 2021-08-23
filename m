Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D783F4F87
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 19:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhHWReJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 13:34:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43364 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhHWReI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 13:34:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 15A3922012;
        Mon, 23 Aug 2021 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629740005;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvuPH3FPSInSGU1pNJwdSZS6UaRlPLEdcgxMX9HBDhc=;
        b=klfKBkhDe4aoGovRBLHj8MLykrza3xPgupOgZpm9LEvPuOuqsP/jaGOVauE3Aikk3k57zl
        01Q67ALuGTElVaT2UswAQrI3gYiG5dXClXVaEjJOA+RVVB7Z/7lsuM0zsP+JdSr70BVV26
        dVmyHNuvaCE8pgIKwB7LQt2mzJYr09s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629740005;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvuPH3FPSInSGU1pNJwdSZS6UaRlPLEdcgxMX9HBDhc=;
        b=GIz9VgguVLgAorKfESMIEzJONcN0y6vK11Xult7Xb33EXahEJ9+8OZrL9WCVr2znXg6OU9
        hAoaGUXq07JrKZAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0F095A3BB0;
        Mon, 23 Aug 2021 17:33:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9CF56DA725; Mon, 23 Aug 2021 19:30:25 +0200 (CEST)
Date:   Mon, 23 Aug 2021 19:30:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] btrfs: qgroup: rescan enhancement related to
 INCONSISTENT flag
Message-ID: <20210823173025.GM5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210822070200.36953-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822070200.36953-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 22, 2021 at 03:01:56PM +0800, Qu Wenruo wrote:
> There is a long existing window that if we did some operations marking
> qgroup INCONSISTENT during a qgroup rescan, the INCONSISTENT bit will be
> cleared by rescan, leaving incorrect qgroup numbers unnoticed.
> 
> Furthermore, when we mark qgroup INCONSISTENT, we can in theory skip all
> qgroup accountings.
> Since the numbers are already crazy, we don't really need to waste time
> updating something that's already wrong.
> 
> So here we introduce two runtime flags:
> 
> - BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN
>   To inform any running rescan to exit immediately and don't clear
>   the INCONSISTENT bit on its exit.
> 
> - BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING
>   To inform qgroup code not to do any accounting for dirty extents.
> 
>   But still allow operations on qgroup relationship to be continued.
> 
> Both flags will be set when an operation marks the qgroup INCONSISTENT
> and only get cleared when a new rescan is started.
> 
> 
> With those flags, we can have the following enhancement:
> 
> - Prevent qgroup rescan to clear inconsistent flag which should be kept
>   If an operation marks qgroup inconsistent when a rescan is running,
>   qgroup rescan will clear the inconsistent flag while the qgroup
>   numbers are already wrong.
> 
> - Skip qgroup accountings while qgroup numbers are already inconsistent
> 
> - Skip huge subtree accounting when dropping subvolumes
>   With the obvious cost of marking qgroup inconsistent
> 
> 
> Reason for RFC:
> - If the runtime qgroup flags are acceptable

As long as it's internal I think it's ok.

> - If the behavior of marking qgroup inconsistent when dropping large
>   subvolumes

That could be a bit problematic because user never knows if the rescan
has been started or not.

> - If the lifespan of runtime qgroup flags are acceptable
>   They have longer than needed lifespan (from inconsistent time point to
>   next rescan), not sure if it's OK.

On first read I haven't found anything obviously problematic.
