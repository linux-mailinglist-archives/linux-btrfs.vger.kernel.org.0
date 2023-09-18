Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B77A55EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 00:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjIRWvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 18:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIRWvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 18:51:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CF991
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 15:51:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67CE122313;
        Mon, 18 Sep 2023 22:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695077463;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZbNskK7JLB0BclP2+lm5vjoHWkke5n1hbWC1m68JDg=;
        b=DYQVaCLhzVunvGyXAls2UnirckNGFoq9tvChjL79cd0HZyXPGuVs5HHHQ7pAWAEjZZ42W/
        ZIFlS0GWNvwc83jl0+6R+p2DqV4Upy5FDxz9rHBOttDqTT+jB9noCQxlLLcN/NHqp18WwO
        4DwJ1q6xphaBpZ/H8Mgw+9rGlWVnCYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695077463;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZbNskK7JLB0BclP2+lm5vjoHWkke5n1hbWC1m68JDg=;
        b=3V/SZdFXBh1E59A8DhPxdUq5TE7MYqHACy/GcBvATO05dzw0FbIAv4ACAUtUvvGU7hAZx/
        D0CwRf9YeCpP4XDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 328E813480;
        Mon, 18 Sep 2023 22:51:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UOJ9ClfUCGXWGwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 22:51:03 +0000
Date:   Tue, 19 Sep 2023 00:44:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject device with CHANGING_FSID_V2
Message-ID: <20230918224427.GS2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> 
> With this patch, now devices with the CHANGING_FSID_V2 flag are rejected.
> And its partner will fail to mount with the extra -o degraded option.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Moreover, a btrfs-progs patch (below) has eliminated the use of the
> CHANGING_FSID_V2 flag entirely:
> 
>    [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
> 
> And we solve the compatability concerns as below:
> 
>   New-kernel new-progs - has no CHANGING_FSID_V2 flag.
>   Old-kernel new-progs - has no CHANGING_FSID_V2 flag, kernel code unused.
>   Old-kernel old-progs - bug may occur.
>   New-kernel old-progs - Should use host with the newer btrfs-progs to fix.
> 
> For legacy systems to help fix such a condition in the userspace instead
> we have the below patchset which ports of kernel's CHANGING_FSID_V2 code.
> 
>    [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
> 
> And if it couldn't fix in some cases, users can use manually reunite,
> with the patchset:
> 
>    [PATCH 00/10] btrfs-progs: check and tune: add device and noscan options
> 
>  fs/btrfs/disk-io.c |  10 ---
>  fs/btrfs/volumes.c | 166 ++++-----------------------------------------
>  fs/btrfs/volumes.h |   1 -
>  3 files changed, 13 insertions(+), 164 deletions(-)

Please split the kernel patch in two, one rejecting the CHANGING_FSID_V2
bit and then removing the unused code. I think the scanning code still
has to recognize the bit and skip the device, I haven't checked if
remains like that after this patch.
