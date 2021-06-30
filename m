Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19643B88C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 20:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhF3Sxw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 14:53:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46880 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhF3Sxv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 14:53:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8FC94225BA;
        Wed, 30 Jun 2021 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625079081;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lqexrI93nDEbU92EaWMsWYB1UlpILlaUhcp0qQQ7C18=;
        b=P57QuBqExOhJLxGa4VfMy3RKOt8fyNbMnHWUeOgyZx6uK8gxkmlrr5hev/BGhAzXYgjByA
        ZKZk3Ykgvh6m0dzTBUsKexGLALXq4SKklLEceTXUIyUysCO5kaf6ies7oQZzqMQ0MKgL7J
        /D8hbxYZH6dMAFqdUL7db/4UAesPUQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625079081;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lqexrI93nDEbU92EaWMsWYB1UlpILlaUhcp0qQQ7C18=;
        b=M4Ncsnllfjrbaejs6xymgSTox+UkNYPlGggh9sCHOS7f3qz/fkfDJBU5+h0eJ+z0uPM/tF
        7t8BwqGpa7UxIlBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5F9E3A3B94;
        Wed, 30 Jun 2021 18:51:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 468C0DA7A2; Wed, 30 Jun 2021 20:48:51 +0200 (CEST)
Date:   Wed, 30 Jun 2021 20:48:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Message-ID: <20210630184851.GR2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
References: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 29, 2021 at 03:36:45AM +0900, Johannes Thumshirn wrote:
> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v1:
> - also remove the local max_zone_append_size variable in
>   btrfs_check_zoned_mode() (Anand)

And what about btrfs_zoned_device_info::max_zone_append_size, should it
also be removed? In case you don't have plans with it I'll remove it, no
need to resend, it's just a few more lines but want to know if it's
accidental or intentional.
