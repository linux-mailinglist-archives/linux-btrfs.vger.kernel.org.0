Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A8246C336
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 19:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbhLGS76 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 13:59:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32828 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhLGS75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 13:59:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A4DD21FDFE;
        Tue,  7 Dec 2021 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638903386;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XP2/df4md9b/bbC7iejopZhj6GHhs0oIAYRw5cNn3U=;
        b=cac6n7vhlUbY7+I80boYWcQGzFGjKWiloGxrxejIVfg1UGl/m9QpHq/xNl2m6KFyFvsoWe
        WmO0VbiFzFcW+ES32+BUQZvdJm79GMOK8yjyarvKbBqEt0qbgB5UxRfenWPl1FqaIVNbm8
        I90r3E/1u1220RI70mMo6A8ZVSbkDGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638903386;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XP2/df4md9b/bbC7iejopZhj6GHhs0oIAYRw5cNn3U=;
        b=J2OBxoLvmOcMbqbotJeDCLf8peRM1jOu+ayPi8c5WElZsuEuhfIv7r3HhEl4RY39eE2xA8
        v8Dd0fFZe+JpnGDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9D50BA3B89;
        Tue,  7 Dec 2021 18:56:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1ABE8DA799; Tue,  7 Dec 2021 19:56:12 +0100 (CET)
Date:   Tue, 7 Dec 2021 19:56:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 2/2] btrfs: sysfs add devinfo/fsid to retrieve fsid
 from the device
Message-ID: <20211207185611.GA28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <cover.1634829757.git.anand.jain@oracle.com>
 <33e179f8b9341c88754df639b77dafaa1ffec0d1.1634829757.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33e179f8b9341c88754df639b77dafaa1ffec0d1.1634829757.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 11:31:17PM +0800, Anand Jain wrote:
> In the case of the seed device, the fsid can be different from the mounted
> sprout fsid.  The userland has to read the device superblock to know the
> fsid but, that idea fails if the device is missing. So add a sysfs
> interface devinfo/<devid>/fsid to show the fsid of the device.
> 
> For example:
>  $ cd /sys/fs/btrfs/b10b02a5-f9de-4276-b9e8-2bfd09a578a8
> 
>  $ cat devinfo/1/fsid
>  c44d771f-639d-4df3-99ec-5bc7ad2af93b
>  $ cat  devinfo/3/fsid
>  b10b02a5-f9de-4276-b9e8-2bfd09a578a8
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
