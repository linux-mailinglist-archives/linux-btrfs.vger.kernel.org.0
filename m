Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338E777F61B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 14:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbjHQMLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 08:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350749AbjHQMLH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 08:11:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF35330C8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 05:10:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9111A21872;
        Thu, 17 Aug 2023 12:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692274253;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4wvl9mfC/bSQzTmyQEIOOkPbLE111PZwYew9TVR8rSo=;
        b=aEJj5mHueGlIApUvnMcnrcjI0lRAxv6EiRdlnfHd9CoGkreOYLYaU65NUC3Xg+Ta/pYMJz
        G1+UdL5rKhL01KDkztRf0awVq7L2VVZuX2K7gSJhK/RwGwcve8B1sYOe6H4m4Vk0938U98
        A2uQY6JXj1ld27VH/g0RmkP8FvebvH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692274253;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4wvl9mfC/bSQzTmyQEIOOkPbLE111PZwYew9TVR8rSo=;
        b=owKXEa51fnF8He6Szk3Qvy/CQE4s2qbmJ6XIh0ddRehP9UJjSFFR8a0CW8scG4QLHfD5QS
        UPUNUaWsXi1WuaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B0BF1358B;
        Thu, 17 Aug 2023 12:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1vpWGU0O3mRsVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 12:10:53 +0000
Date:   Thu, 17 Aug 2023 14:04:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject device with CHANGING_FSID_V2
Message-ID: <20230817120424.GK2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 16, 2023 at 08:30:40PM +0800, Anand Jain wrote:
> The BTRFS_SUPER_FLAG_CHANGING_FSID_V2 flag indicates a transient state
> where the device in the userspace btrfstune -m|-M operation failed to
> complete changing the fsid.
> 
> This flag makes the kernel to automatically determine the other
> partner devices to which a given device can be associated, based on the
> fsid, metadata_uuid and generation values.
> 
> btrfstune -m|M feature is especially useful in virtual cloud setups, where
> compute instances (disk images) are quickly copied, fsid changed, and
> launched. Given numerous disk images with the same metadata_uuid but
> different fsid, there's no clear way a device can be correctly assembled
> with the proper partners when the CHANGING_FSID_V2 flag is set. So, the
> disk could be assembled incorrectly, as in the example below:
> 
> Before this patch:
> 
> Consider the following two filesystems:
>    /dev/loop[2-3] are raw copies of /dev/loop[0-1] and the btrsftune -m
> operation fails.
> 
> In this scenario, as the /dev/loop0's fsid change is interrupted, and the
> CHANGING_FSID_V2 flag is set as shown below.
> 
>   $ p="device|devid|^metadata_uuid|^fsid|^incom|^generation|^flags"
> 
>   $ btrfs inspect dump-super /dev/loop0 | egrep '$p'
>   superblock: bytenr=65536, device=/dev/loop0
>   flags			0x1000000001
>   fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>   metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>   generation		9
>   num_devices		2
>   incompat_flags	0x741
>   dev_item.devid	1
> 
>   $ btrfs inspect dump-super /dev/loop1 | egrep '$p'
>   superblock: bytenr=65536, device=/dev/loop1
>   flags			0x1
>   fsid			11d2af4d-1b71-45a9-83f6-f2100766939d
>   metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>   generation		10
>   num_devices		2
>   incompat_flags	0x741
>   dev_item.devid	2
> 
>   $ btrfs inspect dump-super /dev/loop2 | egrep '$p'
>   superblock: bytenr=65536, device=/dev/loop2
>   flags			0x1
>   fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>   metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>   generation		8
>   num_devices		2
>   incompat_flags	0x741
>   dev_item.devid	1
> 
>   $ btrfs inspect dump-super /dev/loop3 | egrep '$p'
>   superblock: bytenr=65536, device=/dev/loop3
>   flags			0x1
>   fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>   metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>   generation		8
>   num_devices		2
>   incompat_flags	0x741
>   dev_item.devid	2
> 
> 
> It is normal that some devices aren't instantly discovered during
> system boot or iSCSI discovery. The controlled scan below demonstrates
> this.
> 
>   $ btrfs device scan --forget
>   $ btrfs device scan /dev/loop0
>   Scanning for btrfs filesystems on '/dev/loop0'
>   $ mount /dev/loop3 /btrfs
>   $ btrfs filesystem show -m
>   Label: none  uuid: 7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
> 	Total devices 2 FS bytes used 144.00KiB
> 	devid    1 size 300.00MiB used 48.00MiB path /dev/loop0
> 	devid    2 size 300.00MiB used 40.00MiB path /dev/loop3
> 
> /dev/loop0 and /dev/loop3 are incorrectly partnered.
> 
> This kernel patch removes functions and code connected to the
> CHANGING_FSID_V2 flag.

I didn't have a closer look but it seems you're removing all the logic
to make the metadata uuid robust and usable in case of interrupted
conversion, while finding another case where it does not work as you
expect. With this it would be change in behaviour, we need to check
the original use case. IIRC as the metadata uuid change is lightweight
we want to try harder to deal with the easy errors instead of rejecting
the filesystem mount.
