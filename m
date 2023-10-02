Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5804E7B53B3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 15:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbjJBNH0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBNHZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 09:07:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56CDAD
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 06:07:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 796791F460;
        Mon,  2 Oct 2023 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696252041;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jF+xvrd+mnJ8H+7QZeQfIL0m3laVZRMjvhEAW+rojLk=;
        b=TYyn2oP/kDSUM0BA0H4ayax/UdD5h3ckOl7DLP32cJzNfeuSwdoTg6JOa6aUffEBhfpfHW
        zo9pxiocKjwg9Xz2re5pND3moCXQ66IY5L47xfki6HLtvPWsXBBi5RuzJfldhFunZE8BKF
        4AZsTb+Z9ITI2QagKa9QWI65wmhef5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696252041;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jF+xvrd+mnJ8H+7QZeQfIL0m3laVZRMjvhEAW+rojLk=;
        b=RQ41HDTxh7WJOeDHxYSuO6TQ09CTMJ5kqCrnzBGvVVdhwT2jcdjkcFljq/6OCt5QYAhvCU
        fB3Nq4jBF5CwYNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4438D13456;
        Mon,  2 Oct 2023 13:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KNjHD4nAGmXROwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 13:07:21 +0000
Date:   Mon, 2 Oct 2023 15:00:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/2] btrfs: support cloned-device mount capability
Message-ID: <20231002130040.GO13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695826320.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695826320.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 09:09:45AM +0800, Anand Jain wrote:
> Guilherme's previous work [1] aimed at the mounting of cloned devices
> using a superblock flag SINGLE_DEV during mkfs.
>  [1] https://lore.kernel.org/linux-btrfs/20230831001544.3379273-1-gpiccoli@igalia.com/
> 
> Building upon this work, here is in-memory only approach. As it mounts
> we determine if the same fsid is already mounted if then we generate a
> random temp fsid which shall be used the mount, in-memory only not
> written to the disk. We distinguish device by devt.
> 
> Mount option / superblock flag:
> -------------------------------
>  These patches show we don't have to limit the single-device / temp_fsid
> capability with a mount option or a superblock flag from the btrfs
> internals pov. However, if necessary from the user's perspective,
> we can add them later on top of this patch. I've prepared a mount option
> -o temp_fsid patch, but I'm not included at this time. As most of the
> tests was without it.
> 
> Compatible with other features that may be affected:
> ----------------------------------------------------
>  Multi device:
>     A btrfs filesytem on a single device can be copied using dd and
>     mounted simlutaneously. However, a multi device btrfs copied using
>     dd and trying to mount simlutaneously is forced to fail:
> 
>       mount: /btrfs1: mount(2) system call failed: File exists.
> 
>  Send and receive:
>     Quick tests shows send and receive between two single devices with
>     the same fsid mounted on the _same_ host works!.

Does it depend if the filesystem remains mounted for the whole
time? So if there's an unmount, mount again with a temp-fsid, will
the receive still work?

>     (Also, the receive-mnt can receive from multiple senders as long as
>     conflits are managed externally. ;-).)
> 
>  Replace: 
>      Works fine.
> 
> btrfs-progs:
> ------------
>  btrfs-progs needs to be updated to support the commands such as
> 
> 	btrfs filesystem show
> 
>  when devices are not mounted. So the device list is not based on
>  the fisd any more.
> 
> Testing:
> -------
>  This patch has been under testing for some time. The challenge is to get
>  the fstests to test this reasonably well.
> 
>  As of now, this patch runs fine on a large set of fstests test cases
>  using a custom-built mkfs.btrfs with the -U option and a new -P option
>  to copy the device FSID and UUID from the TEST_DEV to the SCRATCH_DEV
>  at the scratch_mkfs time. For example:
> 
>   Config file:
> 
>      config_fsid=$(btrfs in dump-super $TEST_DEV | grep -E ^fsid | \
> 							awk '{print $2}')
>      config_uuid=$(btrfs in dump-super $TEST_DEV | \
> 				grep -E ^dev_item.uuid | awk '{print $2}')
>      MKFS_OPTIONS="-U $config_fsid -P $config_uuid"
> 
>  This configuration option ensures that both TEST_DEV and SCRATCH_DEV will
>  have the same FSID and device UUID while still applying test-specific
>  scratch mkfs options.
> 
> Mkfs.btrfs:
> -----------
>  mkfs.btrfs needs to be updated to support the -P option for testing only.
> 
>    btrfs-progs: allow duplicate fsid for single device
>    btrfs-progs: add mkfs -P option for dev_uuid
> 
> Anand Jain (2):
>   btrfs: add helper function find_fsid_by_disk
>   btrfs: support cloned-device mount capability

Added to misc-next, thanks.
