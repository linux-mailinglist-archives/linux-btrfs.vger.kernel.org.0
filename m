Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE603F518A
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhHWTuC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:50:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54478 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhHWTuB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:50:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 18A1A21FDE;
        Mon, 23 Aug 2021 19:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629748158;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkKhydEJH3IaXuK0G2r7KLWg70jID43dnPt0YXUZ99o=;
        b=uNULl0Bb1EUvkQblzuZAFRS9OEPXXPDnY5sqcNRtDdkL4wrQ/6rIt/ZQ/FJLdKPZxTTpAD
        pmBbYE8h4tbSo7piqPc8XdjxhzB7BDCzFvet+p+aEiaZVwDQF6Itgy/BONUeb5W+xGudZ0
        VWJBEm/DkYtBrcId70OkaPVrWZfAWYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629748158;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkKhydEJH3IaXuK0G2r7KLWg70jID43dnPt0YXUZ99o=;
        b=zIwvvQgi8NycTFo7dGaTH6shliern4QIVUIdn38iGu9pTdLwqO3T3IwMQ4t2Jim3/ChtDg
        jYlv9oEOukbkyiDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0EA6EA3BBA;
        Mon, 23 Aug 2021 19:49:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 97BB3DA725; Mon, 23 Aug 2021 21:46:18 +0200 (CEST)
Date:   Mon, 23 Aug 2021 21:46:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
Subject: Re: [PATCH v4 0/4] btrf_show_devname related fixes
Message-ID: <20210823194618.GT5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
References: <cover.1629458519.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 07:31:38PM +0800, Anand Jain wrote:
> These fixes are inspired by the bug report and its discussions in the
> mailing list subject
>  btrfs: traverse seed devices if fs_devices::devices is empty in show_devname
> 
> And depends on the patch
>  [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
> in the ML
> 
> v4:
>  Fix unrelated changes in 2/4
> v3:
>  Fix rcu_lock in the patch 3/4
> 
> Anand Jain (4):
>   btrfs: consolidate device_list_mutex in prepare_sprout to its parent
>   btrfs: save latest btrfs_device instead of its block_device in
>     fs_devices
>   btrfs: use latest_dev in btrfs_show_devname
>   btrfs: update latest_dev when we sprout

Patchset survived one round of fstests and I haven't seen the lockdep
warning in btrfs/020 that's caused by some unrelated work in loop device
driver. There's a series from Josef to fix it by shuffling locking, so
it would be interesting to see where's the difference.
