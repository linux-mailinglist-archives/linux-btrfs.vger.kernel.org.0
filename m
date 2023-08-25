Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B556178866A
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 13:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbjHYLyR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 07:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244393AbjHYLx4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 07:53:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE12102
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 04:53:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 51D6222008;
        Fri, 25 Aug 2023 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692964432;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AhiF7NZlgMC/E9g2FpwWeGSvYkEP0n97Yzi1wTQTTxw=;
        b=vmFtnAk0ZoGtStRKBXDMeuOJ9yATd+voUkM99XfuCw76RU93QdOg2HpIfwOx+m15Tta6p4
        BLn+dVq3275ahb21jy51DKLN+KGtOVv4Je5kli79EnRYxaSyn4fVKE/RG33su6OdZPSZpv
        8gD5eIN4cGYdSZunIl++RG/DTWw12SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692964432;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AhiF7NZlgMC/E9g2FpwWeGSvYkEP0n97Yzi1wTQTTxw=;
        b=CdF5cr3aDVcJdioNfsSNIzcvcZ34EvtpMOkJ8aztj5Kx3uq9IPGxtKRFNEgPBp8c1754Iq
        inkG/YR4rPEYMmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30EB6138F9;
        Fri, 25 Aug 2023 11:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bvVSC1CW6GSJSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 25 Aug 2023 11:53:52 +0000
Date:   Fri, 25 Aug 2023 13:47:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Lee Trager <lee@trager.us>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Allow online resize to use "min" shortcut
Message-ID: <20230825114718.GN2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230825010542.4158944-1-lee@trager.us>
 <3127979c-8324-feda-4250-13c61117d0bf@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3127979c-8324-feda-4250-13c61117d0bf@trager.us>
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

On Thu, Aug 24, 2023 at 06:23:50PM -0700, Lee Trager wrote:
> > --- a/fs/btrfs/volumes.h
> > +++ b/fs/btrfs/volumes.h
> > @@ -636,7 +636,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
> >   		      struct btrfs_device *device, u64 new_size);
> >   struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
> >   				       const struct btrfs_dev_lookup_args *args);
> > -int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
> > +int btrfs_shrink_device(struct btrfs_device *device, u64 *new_size, bool to_min);
> >   int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
> >   int btrfs_balance(struct btrfs_fs_info *fs_info,
> >   		  struct btrfs_balance_control *bctl,
> > @@ -648,6 +648,7 @@ int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
> >   int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
> >   int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
> >   int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
> > +u64 btrfs_get_allocated_space(struct btrfs_fs_info *fs_info);
> >   int btrfs_uuid_scan_kthread(void *data);
> >   bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
> >   void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
> I plan on sending a follow up patch to optionally resize block groups to 
> the amount of space used by data and metadata. This will allow the 
> creation of small distributed btrfs OS images.

Can you create the images in userspace with such properties? Doing that
in kernel on a live filesystem would lead to a filesystem that does not
have any space left and can't be effectively used.
