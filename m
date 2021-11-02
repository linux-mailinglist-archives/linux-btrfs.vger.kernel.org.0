Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0084443285
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 17:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhKBQRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 12:17:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59186 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbhKBQLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 12:11:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 00B622190C;
        Tue,  2 Nov 2021 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635869346;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PyRHloFwzKkSdyVIW0CHOEEmfqUyHx1TseWjB2Ol88o=;
        b=jahhZglvzbmja1GKCWlGb5F9W3b1zOHXBfZZmRgIt+6JP+u3yiupquiQEYlBbClJzwEWC2
        nh19L9QesoiMDP/dMTuV1EN0Gfo8S1vsy9Hy+xhamBKFBHZWao3ErufsaiRXQKq4vbLdLD
        XQFB7Bv5pRmCZPOVaZflJL5X7emnLyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635869346;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PyRHloFwzKkSdyVIW0CHOEEmfqUyHx1TseWjB2Ol88o=;
        b=Zjvra2AlknUVV1Xwt9zenLIfGgVHLlLV19Rm5gj1h7P5/7Z4HjykkpLcHbJwqieYhdFEun
        IkE9MDNZdUCwxDBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EEEE7A3B89;
        Tue,  2 Nov 2021 16:09:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9BE4CDA7A9; Tue,  2 Nov 2021 17:08:29 +0100 (CET)
Date:   Tue, 2 Nov 2021 17:08:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Make "btrfs filesystem df" command to show
 upper case profile
Message-ID: <20211102160829.GM20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org
References: <20211102104758.39871-1-wqu@suse.com>
 <20211102202345.1D25.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102202345.1D25.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 08:23:45PM +0800, Wang Yugui wrote:
> Hi,
> 
> before Commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use
>  raid table") , 'single' is lower case. others, such as RAID1 , are
> upper case.
> 
> I don't know whether it is necessary to keep 'single' as lower case.

Looks like it's better to keep it as it was, which would mean lowercase
single and uppercase the rest, with some additional conditions.

> maybe we can change the array value directly?
> ./kernel-shared/volumes.c:62:   [BTRFS_RAID_RAID1C3] = {
> ./kernel-shared/volumes.c:71:           .raid_name      = "raid1c3",

Either making the table name the one we want to print with the right
case, or add another that is same as kernel has and another for
printing.
