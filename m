Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470A53EED55
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbhHQN1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 09:27:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60780 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbhHQN1t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 09:27:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B807E2001E;
        Tue, 17 Aug 2021 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629206835;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3Cm2vfWp95hgoU9nYamOMCxepuSSc7b0f3J2i8aEd4=;
        b=Paxd+j1LT795yYtH1eONZ53BpQHj3wzNPXMQo+9pdz8VSdV5fTmlUHh/PtHTQnA/m0EeuI
        WO+3Fvt83mKqKxOIjsWytFzOFJ9lAPHcmQnhg04S2Tj0/W/QpHPDNsRHiCnaV+zuZvQD+Y
        bE9MUlzKe3pobkP8/1SQGwYhabeNRyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629206835;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3Cm2vfWp95hgoU9nYamOMCxepuSSc7b0f3J2i8aEd4=;
        b=vpn0Rr2DjaVNRosO/9evloaHcWOLpZSugLGprVZrlY0bqd9f4Y+IFZw8rdOKpy/fkeyF5S
        bGrAT594Xg8rrZBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AFE1FA3B81;
        Tue, 17 Aug 2021 13:27:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82E9ADA72C; Tue, 17 Aug 2021 15:24:19 +0200 (CEST)
Date:   Tue, 17 Aug 2021 15:24:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
Message-ID: <20210817132419.GK5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210809182613.4466-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809182613.4466-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 09, 2021 at 03:26:13PM -0300, Marcos Paulo de Souza wrote:
> [PROBLEM]
> Our documentation says that a DATA block group can have up to 1G of
> size, or the at most 10% of the filesystem size. Currently, by default,
> mkfs.btrfs is creating an initial DATA block group of 8M of size,
> regardless of the filesystem size. It happens because we check for the
> ctl->type in init_alloc_chunk_ctl_policy_regular to be one of the
> BTRFS_BLOCK_GROUP_PROFILE_MASK bits, which is not the case for SINGLE
> (default) DATA block group:
> 
> $ mkfs.btrfs -f /storage/btrfs.disk
> btrfs-progs v4.19.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> Label:              (null)
> UUID:               39e3492f-41f2-4bd7-8c25-93032606b9fe
> Node size:          16384
> Sector size:        4096
> Filesystem size:    55.00GiB
> Block group profiles:
>   Data:             single            8.00MiB
>   Metadata:         DUP               1.00GiB
>   System:           DUP               8.00MiB
> SSD detected:       no
> Incompat features:  extref, skinny-metadata
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1    55.00GiB  /storage/btrfs.disk
> 
> In this case, for single data profile, it should create a data block
> group of 1G, since the filesystem if bigger than 50G.
> 
> [FIX]
> Remove the check for BTRFS_BLOCK_GROUP_PROFILE_MASK in
> init_alloc_chunk_ctl_policy_regular function. The ctl->stripe_size is
> later on assigned to ctl.num_bytes, which is used by
> btrfs_make_block_group to create the block group.
> 
> By removing the check we allow the code to always configure the correct
> stripe_size regardless of the PROFILE, looking on the block group TYPE.
> 
> With the fix applied, it now created the BG correctly:
> 
> $ ./mkfs.btrfs -f /storage/btrfs.disk
> btrfs-progs v5.10.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> Label:              (null)
> UUID:               5145e343-5639-462d-82ee-3eb75dc41c31
> Node size:          16384
> Sector size:        4096
> Filesystem size:    55.00GiB
> Block group profiles:
>   Data:             single            1.00GiB
>   Metadata:         DUP               1.00GiB
>   System:           DUP               8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, skinny-metadata
> Runtime features:
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1    55.00GiB  /storage/btrfs.disk
> 
> Using a disk >50G it creates a 1G single data block group. Another
> example:
> 
> $ ./mkfs.btrfs -f /storage/btrfs2.disk
> btrfs-progs v5.10.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> Label:              (null)
> UUID:               c0910857-e512-4e76-9efa-50a475aafc87
> Node size:          16384
> Sector size:        4096
> Filesystem size:    5.00GiB
> Block group profiles:
>   Data:             single          512.00MiB
>   Metadata:         DUP             256.00MiB
>   System:           DUP               8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, skinny-metadata
> Runtime features:
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1     5.00GiB  /storage/btrfs2.disk
> 
> The code now created a single data block group of 512M, which is exactly
> 10% of the size of the filesystem, which is 5G in this case.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> 
>  This change mimics what the kernel currently does, which is set the stripe_size
>  regardless of the profile. Any thoughts on it? Thanks!

Makes sense to unify that, it works well for the large sizes. Please
write tests that verify that the chunk sizes are correct after mkfs on
various device sizes. Patch added to devel, thanks.
