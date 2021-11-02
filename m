Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2544344C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 18:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhKBRJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 13:09:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56960 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhKBRJP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 13:09:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BBB9D1FD29;
        Tue,  2 Nov 2021 17:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635872799;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GeprLL8tqNRCf545Km70qus0sk6CeJ95JYV60I7toOk=;
        b=ViMtlbSOP8ZS4KTVu1ZnAwwTXAPiQQevLZVK/SJ7KdHlUj1/IbybpAWNLLBmBXxKlUj0Yl
        EsTDNnlqgaXMlKJlkN8J16g+OhZ4XzIKRE5xJvWZ2GFb51UdoroQiAy09Wr0ur53UaZr8h
        8AUYUpLoNNN2fi9XtqM1OB7IK/43/pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635872799;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GeprLL8tqNRCf545Km70qus0sk6CeJ95JYV60I7toOk=;
        b=/vPczxxCvdD0yOboSDmPyW158kxEujJZQS4QvgK2nQEc53X65Hm14nfc+tST/ta/+GhDFi
        W7j5P3lwjaXUhlBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B5CEA2C144;
        Tue,  2 Nov 2021 17:06:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 53EFCDA7A9; Tue,  2 Nov 2021 18:06:04 +0100 (CET)
Date:   Tue, 2 Nov 2021 18:06:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix btrfs_group_profile_str regression
Message-ID: <20211102170604.GR20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org
References: <20211030143658.39136-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030143658.39136-1-wangyugui@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 30, 2021 at 10:36:58PM +0800, Wang Yugui wrote:
> dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use raid table")
> introduced a regression that raid profile of GlobalReserve will be output
> as 'unknown'.
> 
>  $ btrfs filesystem df /mnt/test
>  Data, single: total=5.02TiB, used=4.98TiB
>  System, single: total=4.00MiB, used=624.00KiB
>  Metadata, single: total=11.01GiB, used=6.94GiB
>  GlobalReserve, unknown: total=512.00MiB, used=0.00B
> 
> fix it by
> - add the process of BTRFS_BLOCK_GROUP_RESERVED
> - fix the define of BTRFS_BLOCK_GROUP_RESERVED too.
> 
> Fixes: dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use raid table")
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

Added to devel, thanks.
