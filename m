Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358623A1916
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbhFIPTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 11:19:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbhFIPTE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 11:19:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8C1201FD62;
        Wed,  9 Jun 2021 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623251828;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2E76Axm2P/Q+gpkJ1vBfr5a6vL6qL/4uTsjHo/0dzOM=;
        b=UHakXyEpWQJMLllBjXm+m0xRX8FLYvO4S9/+r9jx/RAXgBbEwdQX7lRKK1zIz3Vu5vzRiv
        O3Ui6JrDewbeZxPrfpDYAdXOVbm+M8uR+fbwJ6IKSldekJ9A3WrvtM5hP6urKj/fBmo9mo
        rBQsa/O6pwR2b6TO3dg606CuBjp9deg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623251828;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2E76Axm2P/Q+gpkJ1vBfr5a6vL6qL/4uTsjHo/0dzOM=;
        b=NVW40s2XzYCw3Y8oeAUL4R0ePOiTDPJPzWWAXA/oeYJuheWaGFQQTHici3kVpzYRM7eBCH
        TNsFB/K95awvemDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 83483A3B9F;
        Wed,  9 Jun 2021 15:17:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 73209DA908; Wed,  9 Jun 2021 17:14:24 +0200 (CEST)
Date:   Wed, 9 Jun 2021 17:14:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <20210609151424.GA27283@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210604132058.11334-1-dsterba@suse.com>
 <5aeca0cd-c6b2-939a-6f83-7ea5722076dc@oracle.com>
 <20210604142105.GD31483@twin.jikos.cz>
 <77708664-a7db-50e0-aa44-6cbb3fb90070@oracle.com>
 <20210607185556.GL31483@twin.jikos.cz>
 <8e255fb8-9dc2-57cf-f6e8-d1c23aa43563@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e255fb8-9dc2-57cf-f6e8-d1c23aa43563@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 09, 2021 at 03:43:44PM +0800, Anand Jain wrote:
> > I'm more inclined to follow what
> > /proc/ stats do. It's more convenient to monitor stats in one file read
> > than having to do 'cat error_stats/*' or with filenames as 'grep ^
> > error_stats/*'.
> 
>   Agreed. I prefer one file from the convenience pov. Also, block dev has
>   one file, the reason to represent it invariably at a given time [1]
>     [1] https://www.kernel.org/doc/Documentation/block/stat.txt
>   IMO the same applies to btrfs too.

Ah nice, same reason for us to use the file then. I'd argue that having
the names of the values is more convenient than just an array of raw
numbers though.
