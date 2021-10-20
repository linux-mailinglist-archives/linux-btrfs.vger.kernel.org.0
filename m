Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E8E435355
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 21:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhJTTCO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 15:02:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhJTTCN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 15:02:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 732BB1FD39;
        Wed, 20 Oct 2021 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634756398;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6OicD7eCxpM4XPwQV14CpFvE1/XdzR9QLLRcHK1fI4=;
        b=1rk26wfu0KeXXY+rDmasiOPkFZD5lG5ehR9ybdxT3YvRXZ9nHs1rw+zNxlI97HJS5OmR1h
        Flryh++YFVD+kTnPNXdL77hc0ntuIOsM+ZXChh0V15NYp2mKBaNgBRLtrUVLBD4U9nDzqS
        4gkMMvnpMdp8KF4DHg9zkdlQTxm4YLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634756398;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6OicD7eCxpM4XPwQV14CpFvE1/XdzR9QLLRcHK1fI4=;
        b=MtyRiABI7wYw8K+nHex0veWGLERL9kFEYYWlddszsataFv6wvEplg1WjOXGxRCZ9txcXsj
        KjWHCYmJLGvbGMAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6BC05A3B81;
        Wed, 20 Oct 2021 18:59:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3DACADA7A3; Wed, 20 Oct 2021 20:59:30 +0200 (CEST)
Date:   Wed, 20 Oct 2021 20:59:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 2/2] btrfs: sysfs add devinfo/fsid to retrieve fsid from
 the device
Message-ID: <20211020185929.GC30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1634598572.git.anand.jain@oracle.com>
 <7df68f272490c55349b44a33dd7ac19ccf87560f.1634598572.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7df68f272490c55349b44a33dd7ac19ccf87560f.1634598572.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 08:22:10AM +0800, Anand Jain wrote:
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

How do you create such setup? I can't reproduce it.

The simplest seeding:

  mkfs.btrfs /dev/sdx
  btrfstune -S 1 /dev/sdx
  mount /dev/sdx mnt
  ... the device has the same FSID as is the sysfs directory name

With a new device and removed the seeding one:

  btrfs device add /dev/sdy mnt
  mount -o remount,rw mnt
  btrfs device delete /dev/sdx mnt
  ... both devices have the same fsid as well
