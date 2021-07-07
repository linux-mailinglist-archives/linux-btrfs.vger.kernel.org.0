Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE473BEA67
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhGGPLm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 11:11:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59244 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhGGPLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 11:11:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6E2AB200B4;
        Wed,  7 Jul 2021 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625670540;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=alPfmuXblRsHjbU++YBWcXUoC5Ck+NXWce/JREmJI9s=;
        b=dtK7KNtiFjwoRDe7TgDJTY67gqK9+MLTWBgcQP5ARVCIEZxQwPf4L98uiybzheUVoVthiN
        g92fg1NkAI+4lfSxSycN6Dzfku/Dmtqy6DsjFhnH8MltEZS5BcsXyWhNeBtmWLMEzkHbw2
        +rA6SS7HqBfDO76cAfv5y2LKIK1mfpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625670540;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=alPfmuXblRsHjbU++YBWcXUoC5Ck+NXWce/JREmJI9s=;
        b=6S0aMLuU9uI4wGp6A6QGEEGZkt3sPvwdYA2Bdc8R7Z2tE6rWm64y3Q4Me4c0N+x2J2AWxK
        r4JuoRMnOwTtDwBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6711AA3B98;
        Wed,  7 Jul 2021 15:09:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE344DA6FD; Wed,  7 Jul 2021 17:06:26 +0200 (CEST)
Date:   Wed, 7 Jul 2021 17:06:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: cleanup fs_devices pointer usage in
 btrfs_trim_fs
Message-ID: <20210707150626.GM2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1625237377.git.anand.jain@oracle.com>
 <f2c9215ef5edac3b142c78043249e69600f2c557.1625237377.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2c9215ef5edac3b142c78043249e69600f2c557.1625237377.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 04, 2021 at 08:04:57PM +0800, Anand Jain wrote:
> Drop variable
>   struct list_head *devices
> and add new variable
>   struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> 
> so that fs_devices is used at two locations within btrfs_trim_fs() function
> and also helps to access fs_devices->devices.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
