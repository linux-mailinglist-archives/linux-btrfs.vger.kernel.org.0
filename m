Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D947D519BAF
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiEDJbV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347308AbiEDJbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 05:31:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354D425EA2
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 02:27:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E95311F750
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651656449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qv29KCOFh1qAfvI4oO2GEMBgOsyZagVAqJmn+iydmTU=;
        b=XFOJU+8EztC5yv9f/rXtCed2HcP1Y3kc0TFypdi8YwQcWGvqcL00UdBbbpgXxvV4L2QqnS
        enR82cMKL2XYc5y5yfmvcYlX1+Q6THYCrj1VbhdjllejJB8yneatMHnRJR5QqpVJK8NZZn
        MHrjOG725l2eLKOlYmUEySnp0RZYixA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB3CE131BD
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 09:27:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /gDxLgFHcmK1CAAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 04 May 2022 09:27:29 +0000
Message-ID: <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
Date:   Wed, 4 May 2022 12:27:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Debian Bullseye install btrfs raid1
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220504112315.71b41977e071f43db945687c@lucassen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.05.22 г. 12:23 ч., richard lucassen wrote:
> Hello list,
> 
> Still new to btrfs, I try to set up a system that is capable of booting
> even if one of the two disks is removed or broken. The BIOS supports this.
> 
> As the Debian installer is not capable of installing btrfs raid1, I
> installed Bullseye using /dev/md0 for /boot (ext2) and a / btrfs on /dev/sda3.
> This works of course. After install I added /dev/sdb3 to the / fs: OK.
> Reboot: works. Proof/pudding/eating: I stopped the system, removed one of the
> disks and started again. It boots, but it refuses to mount the / fs, either
> without sda or sdb.
> 
> Question: is this newbie trying to set up an impossible config or have I
> missed something crucial somewhere?

That's the default behavior, the reasoning is if you are missing one 
device of a raid1 your data is at-risk in case the 2nd device fails. You 
can override this behavior by mounting in degraded mode, that is
mount -odegraded

> 
> R.
> 
> Begin: Running /scripts/init-premount ... done.
> Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
> Begin: Running /scripts/local-premount ... [    6.809309] Btrfs loaded, crc32c=crc32c-generic
> Scanning for Btrfs filesystems
> [    6.849966] random: fast init done
> [    6.884290] BTRFS: device label data devid 1 transid 50 /dev/sda6 scanned by btrfs (171)
> [    6.892822] BTRFS: device fsid 1739f989-05e0-48d8-b99a-67f91c18c892 devid 1 transid 23 /dev/sda5 scanned by btrfs (171)
> [    6.903959] BTRFS: device fsid f9cf579f-d3d9-49b2-ab0d-ba258e9df3d8 devid 1 transid 3971 /dev/sda3 scanned by btrfs (171)
> Begin: Waiting for suspend/resume device ... Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... [   27.015660] md/raid1:md0: active with 1 out of 2 mirrors
> [   27.021181] md0: detected capacity change from 0 to 262078464
> [   27.036555] md/raid1:md1: active with 1 out of 2 mirrors
> [   27.042062] md1: detected capacity change from 0 to 4294901760
> done.
> done.
> done.
> Warning: fsck not present, so skipping root file system
> [   27.235880] BTRFS info (device sda3): flagging fs with big metadata feature
> [   27.242984] BTRFS info (device sda3): disk space caching is enabled
> [   27.249314] BTRFS info (device sda3): has skinny extents
> [   27.258259] BTRFS error (device sda3): devid 2 uuid 5b50e238-ae76-426f-bae3-deee5999adbc is missing
> [   27.267448] BTRFS error (device sda3): failed to read the system array: -2
> [   27.275696] BTRFS error (device sda3): open_ctree failed
> mount: mounting /dev/sda3 on /root failed: Invalid argument
> Failed to mount /dev/sda3 as root file system.
> 
> 
> BusyBox v1.30.1 (Debian 1:1.30.1-6+b3) built-in shell (ash)
> Enter 'help' for a list of built-in commands.
> 
> (initramfs)
> 
> 
