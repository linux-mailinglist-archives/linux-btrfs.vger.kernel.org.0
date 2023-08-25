Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63984788674
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 13:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbjHYL52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244476AbjHYL5R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 07:57:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412010FF
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 04:57:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 08BF11F74B;
        Fri, 25 Aug 2023 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692964634;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53rFO2qPEx99o8j0W6CHBet5rJXWJV/hyao4x7UWwQ4=;
        b=ssQ/5Ru6skTceaMX6Tji6seA2VzuBofkJMilvHucrpE3lbF3OgqS27iYt6et0lNpmcTBw/
        kgNm2suq5vrtLylmCsxTyh7luJDhJAE6gdPYAapgqNx69O5ZzGscxuIMNppSVD646+MWuk
        /X8hrT7jF41E3FHjCX1RydnQT++IzbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692964634;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53rFO2qPEx99o8j0W6CHBet5rJXWJV/hyao4x7UWwQ4=;
        b=BsQQtbSVUdHdc6zPR33nagcAZoFTk5VABjF2oIvR/hugtVegdtKP/2CVnHKksvuEW1y1cw
        gUxjaIcWaiBSiqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D76D6138F9;
        Fri, 25 Aug 2023 11:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5nzaMxmX6GRoSgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 25 Aug 2023 11:57:13 +0000
Date:   Fri, 25 Aug 2023 13:50:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Lee Trager <lee@trager.us>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Allow online resize to use "min" shortcut
Message-ID: <20230825115040.GO2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230825010542.4158944-1-lee@trager.us>
 <3127979c-8324-feda-4250-13c61117d0bf@trager.us>
 <20230825114718.GN2420@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825114718.GN2420@twin.jikos.cz>
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

On Fri, Aug 25, 2023 at 01:47:18PM +0200, David Sterba wrote:
> On Thu, Aug 24, 2023 at 06:23:50PM -0700, Lee Trager wrote:
> > > --- a/fs/btrfs/volumes.h
> > > +++ b/fs/btrfs/volumes.h
> > > @@ -636,7 +636,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
> > >   		      struct btrfs_device *device, u64 new_size);
> > >   struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
> > >   				       const struct btrfs_dev_lookup_args *args);
> > > -int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
> > > +int btrfs_shrink_device(struct btrfs_device *device, u64 *new_size, bool to_min);
> > >   int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
> > >   int btrfs_balance(struct btrfs_fs_info *fs_info,
> > >   		  struct btrfs_balance_control *bctl,
> > > @@ -648,6 +648,7 @@ int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
> > >   int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
> > >   int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
> > >   int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
> > > +u64 btrfs_get_allocated_space(struct btrfs_fs_info *fs_info);
> > >   int btrfs_uuid_scan_kthread(void *data);
> > >   bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
> > >   void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
> > I plan on sending a follow up patch to optionally resize block groups to 
> > the amount of space used by data and metadata. This will allow the 
> > creation of small distributed btrfs OS images.
> 
> Can you create the images in userspace with such properties?

Also we have that already as "mkfs.btrfs --shrink".
