Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD9E79F04E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjIMRT3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 13:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjIMRT2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 13:19:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A433A98
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 10:19:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6676921887;
        Wed, 13 Sep 2023 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694625563;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2v/HSaTMmX7dlZmA4TbvYUQ4U8Z5+QjQ443k8/vtZs=;
        b=hX4dKSAB6e9HZz/cUVypIZ5nwwECOBGfK3f0XUZ73J6VfEy+S7EtGz2CIp0B8qkeGHc1z6
        8QA5/7IYeR+BUCO18gCTqrJBGGWYtuZwUxRy59Ty/9mgpbSm6dZyaR+gpVZITiRU97at3E
        m7PQZ4mEGvaMn16zhdsk+5TbOfvA7pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694625563;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2v/HSaTMmX7dlZmA4TbvYUQ4U8Z5+QjQ443k8/vtZs=;
        b=Kbbl9wlLBFsIVh4H/Mkfut+rbmiaNFG4IQNH10eIZuY/33t8wFw9bpJ/hKwMahfeotVxVQ
        JBUDiigQROQiRNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 403D113440;
        Wed, 13 Sep 2023 17:19:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DU73DhvvAWWjNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 17:19:23 +0000
Date:   Wed, 13 Sep 2023 19:19:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Lee Trager <lee@trager.us>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        lennart@poettering.net, daan.j.demeyer@gmail.com
Subject: Re: [PATCH] btrfs: Allow online resize to use "min" shortcut
Message-ID: <20230913171921.GU20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230825010542.4158944-1-lee@trager.us>
 <3127979c-8324-feda-4250-13c61117d0bf@trager.us>
 <20230825114718.GN2420@twin.jikos.cz>
 <20230825115040.GO2420@twin.jikos.cz>
 <0f1c3625-8ab8-d455-46ed-04b6a17b5f28@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f1c3625-8ab8-d455-46ed-04b6a17b5f28@trager.us>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 25, 2023 at 01:27:42PM -0700, Lee Trager wrote:
> 
> On 8/25/23 4:50 AM, David Sterba wrote:
> > On Fri, Aug 25, 2023 at 01:47:18PM +0200, David Sterba wrote:
> >> On Thu, Aug 24, 2023 at 06:23:50PM -0700, Lee Trager wrote:
> >>>> --- a/fs/btrfs/volumes.h
> >>>> +++ b/fs/btrfs/volumes.h
> >>>> @@ -636,7 +636,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
> >>>>    		      struct btrfs_device *device, u64 new_size);
> >>>>    struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
> >>>>    				       const struct btrfs_dev_lookup_args *args);
> >>>> -int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
> >>>> +int btrfs_shrink_device(struct btrfs_device *device, u64 *new_size, bool to_min);
> >>>>    int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
> >>>>    int btrfs_balance(struct btrfs_fs_info *fs_info,
> >>>>    		  struct btrfs_balance_control *bctl,
> >>>> @@ -648,6 +648,7 @@ int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
> >>>>    int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
> >>>>    int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
> >>>>    int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
> >>>> +u64 btrfs_get_allocated_space(struct btrfs_fs_info *fs_info);
> >>>>    int btrfs_uuid_scan_kthread(void *data);
> >>>>    bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
> >>>>    void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
> >>> I plan on sending a follow up patch to optionally resize block groups to
> >>> the amount of space used by data and metadata. This will allow the
> >>> creation of small distributed btrfs OS images.
> >> Can you create the images in userspace with such properties?
> > Also we have that already as "mkfs.btrfs --shrink".
> 
> mkfs.btrfs --rootdir foo --shrink doesn't support many btrfs features 
> such as subvolumes and compression. To use those features you must mount 
> the filesystem and make those modifications. Once those modifications 
> are made the filesystem must be shrunk. systemd has its own logic to 
> figure out how to shrink the filesystem after these operations are 
> complete using a bisect algorithm[1]. This patch allows users such as 
> systemd to minimize the filesystem with one command which uses internal 
> data to quickly get the right size.
> 
> [1] 
> https://github.com/systemd/systemd/blob/main/src/home/homework-luks.c#L2957

Thanks. Ideally we would have full feature parity between kernel and
user space but that's harder to achieve than adding the 'min' specifier
and minimize anything that kernel is capable of.
