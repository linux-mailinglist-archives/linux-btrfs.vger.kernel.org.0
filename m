Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7964D7DFB98
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 21:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbjKBUeA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 16:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345100AbjKBUd7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 16:33:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD2181
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 13:33:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 263611FD66;
        Thu,  2 Nov 2023 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698957232;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ODG32S+l0s1ZtZ7o0IX+AhqlO2ZYD2bZQRLxlys3Nkc=;
        b=fVfjQJ4qSxuEu259EKF+sMkYielB2xOqK1PimtcFwIaCZEgfM4pM7avekYodX/LsrUAPrS
        DHCOUBrSdNpB7+hb8L7nrXEO3Lm9NKbuBsHh6jStGYeLFolwRJHRSfr6UtYwHymKs+Sc0w
        ZAN6PEl/hsFRBpEHwVgEra5lgmStKUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698957232;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ODG32S+l0s1ZtZ7o0IX+AhqlO2ZYD2bZQRLxlys3Nkc=;
        b=AvNws5+hNF+yjuEI14GCeEckJwMVUXdw+aPvgVL+K+bDcWhGA9C+WpJhKxO2ZGbQ2ye3Fh
        GnE5F2tP6c35LNAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E81DB138EC;
        Thu,  2 Nov 2023 20:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XiHFN68HRGVQOwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 02 Nov 2023 20:33:51 +0000
Date:   Thu, 2 Nov 2023 21:26:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Message-ID: <20231102202652.GK11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 02, 2023 at 07:10:48PM +0800, Anand Jain wrote:
> In a non-single-device Btrfs filesystem, if Btrfs is already mounted and
> if you run the command 'mount -a,' it will fail and the command
> 'umount <device>' also fails. As below:
> 
> ----------------
> $ cat /etc/fstab | grep btrfs
> UUID=12345678-1234-1234-1234-123456789abc /btrfs btrfs defaults,nofail 0 0
> 
> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1
> $ mount --verbose -a
> /                        : ignored
> /btrfs                   : successfully mounted
> 
> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
> lrwxrwxrwx 1 root root 10 Nov  2 17:43 12345678-1234-1234-1234-123456789abc -> ../../sda1
> 
> $ cat /proc/self/mounts | grep btrfs
> /dev/sda2 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
> 
> $ findmnt --df /btrfs
> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
> /dev/sda2 btrfs    2G  5.8M  1.8G   0% /btrfs
> 
> $ mount --verbose -a
> /                        : ignored
> mount: /btrfs: /dev/sda1 already mounted or mount point busy.
> $echo $?
> 32
> 
> $ umount /dev/sda1
> umount: /dev/sda1: not mounted.
> $ echo $?
> 32
> ----------------
> 
> I assume (RFC) this is because '/dev/disk/by-uuid,' '/proc/self/mounts,'
> and 'findmnt' do not all reference the same device, resulting in the
> 'mount -a' and 'umount' failures. However, an empirically found solution
> is to align them using a rule, such as the disk with the lowest 'devt,'
> for a multi-device Btrfs filesystem.
> 
> I'm not yet sure (RFC) how to create a udev rule to point to the disk with
> the lowest 'devt,' as this kernel patch does, and I believe it is
> possible.
> 
> And this would ensure that '/proc/self/mounts,' 'findmnt,' and
> '/dev/disk/by-uuid' all reference the same device.
> 
> After applying this patch, the above test passes. Unfortunately,
> /dev/disk/by-uuid also points to the lowest 'devt' by chance, even though
> no rule has been set as of now. As shown below.

Does this mean the devid of the device shown in /proc/self/mount won't
be the lowest? Here the devid is the logical device number, while devt
is some internal identifier or at least not something I'd consider a
good identifier from user perspective.

The lowest devid has been there for a long time so I'd consider this as
behaviour change which can potentially break things.
