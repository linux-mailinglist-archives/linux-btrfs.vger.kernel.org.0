Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B574150AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 21:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhIVTtl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 15:49:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhIVTtl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 15:49:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 494E52217B;
        Wed, 22 Sep 2021 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632340090;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zIj4h1WrnEZc6NHz/35r6kwEhkboWnZX61zdPexC32M=;
        b=kO6Ap74P5jnI/5XAXMuqdoxLM/VyHZ4t8EQRQn+zgBzXP7I8IxyBDMGFjWTCq20LEk5UsA
        icAthD88KX5x14jFyXTN/Ty5unsPC8MFDRsr2K52ON8tHYaGk4OOihyVuhjnOZJ778TMqa
        2+YKKJzZAq8aExwkSMXVRbs0y3rgBBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632340090;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zIj4h1WrnEZc6NHz/35r6kwEhkboWnZX61zdPexC32M=;
        b=5+xr6555Zjncy1ShoiRhHWwf7uicXzcTu8316FixvMpm4xbfIxMmWRabTazfdvNLKIo4m6
        SvhJu2Iz07w/zxCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 17380A3B8E;
        Wed, 22 Sep 2021 19:48:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8CF85DA799; Wed, 22 Sep 2021 21:47:57 +0200 (CEST)
Date:   Wed, 22 Sep 2021 21:47:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/2] btrfs-progs: fixes for mkfs.btrfs on file with
 emulated zones
Message-ID: <20210922194757.GU9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210922075343.1160788-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922075343.1160788-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 22, 2021 at 04:53:41PM +0900, Naohiro Aota wrote:
> The following two errors occur when mkfs.btrfs is called on a regular file
> with emulated zones. These patches address the errors.
> 
> ERROR: zoned: failed to read size of /home/naota/tmp/btrfs.img: Inappropriate ioctl for device
> 
> ERROR: zoned: failed to reset device '/home/naota/tmp/btrfs.img' zones: Inappropriate ioctl for device
> 
> Naohiro Aota (2):
>   btrfs-progs: use btrfs_device_size() instead of
>     device_get_partition_size_fd()
>   btrfs-progs: do not zone reset on emulated zoned mode

Added to devel, thanks.
