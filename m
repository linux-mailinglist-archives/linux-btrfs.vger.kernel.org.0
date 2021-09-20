Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C174110EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 10:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhITI2U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 04:28:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53738 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhITI2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 04:28:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 020361FE48;
        Mon, 20 Sep 2021 08:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632126410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xep0nn3yHpBQhe1JKlskz0zmjc+SsF8mH+FcmWXHCM0=;
        b=oZZj0F0dnLDiofAr2iS2OlNBvenZzwQqxYXK8z1l7xmUFCF1zR7/1pMd0GIb/v7QlypX75
        oxnm5aLXb/w4koqPD7vh0gnYN/qo8369axckpGyLDQw94mCvcDG7JAnPh6BNBp/6/FvZit
        iJzBlFqj2/HzZvA89IzEsmlCRxQS+Jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632126410;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xep0nn3yHpBQhe1JKlskz0zmjc+SsF8mH+FcmWXHCM0=;
        b=VC9BRJC/CUNdmgAP3a/Aj0ih2p0t/qZU92eG8FMBdxUNw5vAwnREkfnOu8KWW6R230coGV
        rhXigH9VIGnzvLBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EC32EA3B87;
        Mon, 20 Sep 2021 08:26:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE50EDA781; Mon, 20 Sep 2021 10:26:38 +0200 (CEST)
Date:   Mon, 20 Sep 2021 10:26:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
Message-ID: <20210920082638.GY9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
 <17f703ef-81b2-2a28-6ad7-b94e2944be0b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f703ef-81b2-2a28-6ad7-b94e2944be0b@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 03:45:14PM +0800, Anand Jain wrote:
> 
> This patch is causing btrfs/225 to fail [here].
> 
> ------
> static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
> {
>          struct btrfs_device *device, *tmp;
> 
>          lockdep_assert_held(&uuid_mutex);  <--- here
> -------
> 
> as this patch removed mutex_lock(&uuid_mutex) in btrfs_rm_device().
> 
> 
> commit 425c6ed6486f (btrfs: do not hold device_list_mutex when closing
> devices) added lockdep_assert_held(&uuid_mutex) in close_fs_devices().
> 
> 
> But mutex_lock(&uuid_mutex) in btrfs_rm_device() is not essential as we
> discussed/proved earlier.
> 
> Remove lockdep_assert_held(&uuid_mutex) in close_fs_devices() is a 
> better choice.

This is the other patch that's still not in misc-next. I merged the
branch partially and in a different order so that causes the lockdep
warning. I can remove the patch "btrfs: do not take the uuid_mutex in
btrfs_rm_device" from misc-next for now and merge the whole series in
the order as sent but there were comments so I'm waiting for an update.
