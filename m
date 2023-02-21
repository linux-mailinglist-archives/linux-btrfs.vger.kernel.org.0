Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA669E9AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 22:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjBUVpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 16:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjBUVpQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 16:45:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7852B2FCEB
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 13:45:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE39A34ACD;
        Tue, 21 Feb 2023 21:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677015911;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqK9CIJ7L20cOKFyQs7faEK8yuIWv46LqgKvQjoDiHQ=;
        b=acDPuSANG0O9PEEBueBln54PlL0GuxsulKWOkS5vD7Zf90zEoHsMyHzZ9f6Pqd/lnaGmlX
        EZYMXpF1j6Hh92WtAs44YySgSVZmPubREl6s0/vagD1i4CoAoOppBX50QZSdP1LuCtkfkR
        QUHlErEiEjiRM0vMG2IfTNMS7pdbjrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677015911;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqK9CIJ7L20cOKFyQs7faEK8yuIWv46LqgKvQjoDiHQ=;
        b=WJrO3A/dP31yPQGdmVQ7Z0rkv3+DWxD+qbE7wUdTkjqJs6eAco1aFg2pKTRz27tkWUxnLx
        0YdTy8KRCa12a0DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F74813223;
        Tue, 21 Feb 2023 21:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4p0cImc79WNDMgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Feb 2023 21:45:11 +0000
Date:   Tue, 21 Feb 2023 22:39:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH v2 0/2] btrfs-progs: read device fsid from the sysfs
Message-ID: <20230221213915.GO10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676124188.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676124188.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 13, 2023 at 05:37:40PM +0800, Anand Jain wrote:
> v2:
>  Almost a resend; no code was altered, except for the change log.
> 
> The following test scenario (as in fstests btrfs/249) shows an issue
> where the "usage" subcommand fails to retrieve the fsid from the
> superblock for a missing device.
> 
> Create a raid1 seed device while one of its device missing.
>    $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2
>    $ btrfstune -S 1 $DEV1
>    $ wipefs -a $DEV2
> 
> Mount the seed device
>    $ btrfs device scan --forget
>    $ mount -o degraded $DEV1 /btrfs
> 
> Add a sprout device
>    $ btrfs device add $DEV3 /btrfs -f
> 
> The usage subommand fails because we try to read superblock for the missing
> device
>    $ btrfs filesystem usage /btrfs
>      ERROR: unexpected number of devices: 1 >= 1
>      ERROR: if seed device is used, try running this command as root
> 
> The commit a26d60dedf9a ("btrfs: sysfs: add devinfo/fsid to retrieve
> actual fsid from the device") introduced a sysfs interface for
> retrieving the fsid of a device. This change allows for the reading of the
> device fsid through the sysfs interface in the kernel, while retaining the
> old method of reading the superblock from the disk for backward
> compatibility during normal, non-missing device conditions.
> 
> Anand Jain (2):
>   btrfs-progs: prepare helper device_is_seed
>   btrfs-progs: read fsid from the sysfs in device_is_seed

Added to devel with some fixups, thanks.
