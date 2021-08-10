Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37953E5C27
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 15:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbhHJNuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 09:50:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56796 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbhHJNuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 09:50:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4CF1922062;
        Tue, 10 Aug 2021 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628603383;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r9Fm0skKeAOtWhFdWc8RxYnRpDiVL8yz9prsJXNKw2o=;
        b=pDNZlIJbjqkFk4S4ztQ5gfmKR78I/+pvW1Hv5N93qetpgU8eIBem9r3tHNU9bMabhg0pU1
        0Wdp/TnMGf5A3a97QLsswL13ip0Ew7oCy4dmwvsCxREnSvZPWFv7HHeBd/ikrECV3YbxQh
        ApNbmvwlbSRe96SLqPcY65M5p6S/ip0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628603383;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r9Fm0skKeAOtWhFdWc8RxYnRpDiVL8yz9prsJXNKw2o=;
        b=RQDT1Sih0OTivDOwc84D4iL1MjTZKEqcApfBmouSd3lz62wiC8ti+i8yfYhHD/plpmBtpl
        T72oGdCbvGykM6Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 44E09A3B92;
        Tue, 10 Aug 2021 13:49:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 11873DA880; Tue, 10 Aug 2021 15:46:50 +0200 (CEST)
Date:   Tue, 10 Aug 2021 15:46:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: allow disabling of zone auto relcaim
Message-ID: <20210810134650.GS5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
References: <56979ba90a8e850da85d2a246d6c10d8c45e8fa5.1628509211.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56979ba90a8e850da85d2a246d6c10d8c45e8fa5.1628509211.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 09, 2021 at 08:41:17PM +0900, Johannes Thumshirn wrote:
> Automatically reclaiming dirty zones might not always be desired for all
> workloads, especially as there are currently still some rough edges with
> the relocation code on zoned filesystems.
> 
> Allow disabling zone auto reclaim on a per filesystem basis.
> 
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v1:
>  - Use READ_ONCE/WRITE_ONCE

I've removed the message about disabling for now, we may add it later if
desired, perhaps consistenly with the rest of sysfs files.
