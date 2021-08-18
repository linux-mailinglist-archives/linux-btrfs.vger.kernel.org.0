Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCFE3F01EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhHRKnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 06:43:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52468 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhHRKnm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 06:43:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 65C8022052;
        Wed, 18 Aug 2021 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629283385;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SpqTyoOkopl6h2UBi91HUBl0QQLPIOyZuL/fR77Vh9g=;
        b=wqSze1tBLj4bYWyEebIhpil0PQTCjVW1UJidyKFPdX6GTcQ3M5CVfTjn4jWytAAmNQMNOK
        rem0Dn8PgFZ8PAyoa/2HV8wedA8ZQpXP+TwfsJIhj5PE4pR3wBu/Ngv+cZzE6KAWbq89AU
        4EzrO57R9bCgF0frYNpCouzf/M7qfpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629283385;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SpqTyoOkopl6h2UBi91HUBl0QQLPIOyZuL/fR77Vh9g=;
        b=trXxZNzKJ6vaLxL+ftM0tlpQz0eAJVNbnBIOxSTciPTIsu142rbj+Q9uEiaVu1N2ETjHJ/
        MwBP+aI9trgiUtBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5D152A3B96;
        Wed, 18 Aug 2021 10:43:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9E6DDA72C; Wed, 18 Aug 2021 12:40:08 +0200 (CEST)
Date:   Wed, 18 Aug 2021 12:40:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        nborisov@suse.com, linux-btrfs@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
Message-ID: <20210818104008.GS5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>,
        nborisov@suse.com, linux-btrfs@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
References: <20210809182613.4466-1-mpdesouza@suse.com>
 <20210817132419.GK5047@twin.jikos.cz>
 <fd59564a-7841-f6e1-8b58-4e831996e35d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd59564a-7841-f6e1-8b58-4e831996e35d@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 12:02:45PM +0800, Anand Jain wrote:
> On 17/08/2021 21:24, David Sterba wrote:
> > On Mon, Aug 09, 2021 at 03:26:13PM -0300, Marcos Paulo de Souza wrote:
> >> [PROBLEM]
> >> Our documentation says that a DATA block group can have up to 1G of
> >> size, or the at most 10% of the filesystem size. Currently, by default,
> >> mkfs.btrfs is creating an initial DATA block group of 8M of size,
> >> regardless of the filesystem size. It happens because we check for the
> >> ctl->type in init_alloc_chunk_ctl_policy_regular to be one of the
> >> BTRFS_BLOCK_GROUP_PROFILE_MASK bits, which is not the case for SINGLE
> >> (default) DATA block group:
> >>
> >> $ mkfs.btrfs -f /storage/btrfs.disk
> >> btrfs-progs v4.19.1
> >> See http://btrfs.wiki.kernel.org for more information.
> >>
> >> Label:              (null)
> >> UUID:               39e3492f-41f2-4bd7-8c25-93032606b9fe
> >> Node size:          16384
> >> Sector size:        4096
> >> Filesystem size:    55.00GiB
> >> Block group profiles:
> >>    Data:             single            8.00MiB
> >>    Metadata:         DUP               1.00GiB
> >>    System:           DUP               8.00MiB
> >> SSD detected:       no
> >> Incompat features:  extref, skinny-metadata
> >> Number of devices:  1
> >> Devices:
> >>     ID        SIZE  PATH
> >>      1    55.00GiB  /storage/btrfs.disk
> >>
> >> In this case, for single data profile, it should create a data block
> >> group of 1G, since the filesystem if bigger than 50G.
> >>
> >> [FIX]
> >> Remove the check for BTRFS_BLOCK_GROUP_PROFILE_MASK in
> >> init_alloc_chunk_ctl_policy_regular function. The ctl->stripe_size is
> >> later on assigned to ctl.num_bytes, which is used by
> >> btrfs_make_block_group to create the block group.
> >>
> >> By removing the check we allow the code to always configure the correct
> >> stripe_size regardless of the PROFILE, looking on the block group TYPE.
> >>
> >> With the fix applied, it now created the BG correctly:
> >>
> >> $ ./mkfs.btrfs -f /storage/btrfs.disk
> >> btrfs-progs v5.10.1
> >> See http://btrfs.wiki.kernel.org for more information.
> >>
> >> Label:              (null)
> >> UUID:               5145e343-5639-462d-82ee-3eb75dc41c31
> >> Node size:          16384
> >> Sector size:        4096
> >> Filesystem size:    55.00GiB
> >> Block group profiles:
> >>    Data:             single            1.00GiB
> >>    Metadata:         DUP               1.00GiB
> >>    System:           DUP               8.00MiB
> >> SSD detected:       no
> >> Zoned device:       no
> >> Incompat features:  extref, skinny-metadata
> >> Runtime features:
> >> Checksum:           crc32c
> >> Number of devices:  1
> >> Devices:
> >>     ID        SIZE  PATH
> >>      1    55.00GiB  /storage/btrfs.disk
> >>
> >> Using a disk >50G it creates a 1G single data block group. Another
> >> example:
> >>
> >> $ ./mkfs.btrfs -f /storage/btrfs2.disk
> >> btrfs-progs v5.10.1
> >> See http://btrfs.wiki.kernel.org for more information.
> >>
> >> Label:              (null)
> >> UUID:               c0910857-e512-4e76-9efa-50a475aafc87
> >> Node size:          16384
> >> Sector size:        4096
> >> Filesystem size:    5.00GiB
> >> Block group profiles:
> >>    Data:             single          512.00MiB
> >>    Metadata:         DUP             256.00MiB
> >>    System:           DUP               8.00MiB
> >> SSD detected:       no
> >> Zoned device:       no
> >> Incompat features:  extref, skinny-metadata
> >> Runtime features:
> >> Checksum:           crc32c
> >> Number of devices:  1
> >> Devices:
> >>     ID        SIZE  PATH
> >>      1     5.00GiB  /storage/btrfs2.disk
> >>
> >> The code now created a single data block group of 512M, which is exactly
> >> 10% of the size of the filesystem, which is 5G in this case.
> >>
> >> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> >> ---
> >>
> >>   This change mimics what the kernel currently does, which is set the stripe_size
> >>   regardless of the profile. Any thoughts on it? Thanks!
> > 
> 
> 
> > Makes sense to unify that,
> 
>   Patch [1] also said the same thing 1.5years back.
>   Probably in a wrong context and timing? ;-)

The way it was implemented was not the same, but the idea is right.
Current code does the same allocation like kernel, while previously you
just tweaked some constant.
