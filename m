Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8187A26E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbjIOTHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbjIOTH2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 15:07:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C1B10E
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 12:07:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C55C51F895;
        Fri, 15 Sep 2023 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694804841;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6WyrHto4MnBScauVuM7uKzl0VHSyghtVybUUjYtx+Y=;
        b=CgIfGNvAn2lL2b5S31swhdWLDqoBoJhRYO05WMHj5yycC7u4BjO4Uuq7hxEBzLwviTm7M5
        3TTkQJ1q4lYNM92tgJcUoQswDiSWHxNAUeRJYSP74YAHs6byfToihms8PLO4L/BthKLyXV
        evTjmCIR29nwM8gbIElTLzxs2f2MiTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694804841;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6WyrHto4MnBScauVuM7uKzl0VHSyghtVybUUjYtx+Y=;
        b=ruYdvAi5BESP4Xr3VNqoAPXtlWayh60dEW1uz62ETrBdrFYqIA++c7ji7cKBuOQtDz4ch2
        3fUPIyfT/8y13tCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9815513251;
        Fri, 15 Sep 2023 19:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wttEJGmrBGX4dAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 15 Sep 2023 19:07:21 +0000
Date:   Fri, 15 Sep 2023 21:00:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: extent_io: do extra check for extent buffer
 read write functions
Message-ID: <20230915190047.GH2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b07914e7-137c-4549-97cb-2a0c3e757a04@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b07914e7-137c-4549-97cb-2a0c3e757a04@moroto.mountain>
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

On Fri, Sep 15, 2023 at 10:10:13AM +0300, Dan Carpenter wrote:
> Hello Qu Wenruo,
> 
> The patch f98b6215d7d1: "btrfs: extent_io: do extra check for extent
> buffer read write functions" from Aug 19, 2020 (linux-next), leads to
> the following Smatch static checker warning:
> 
> fs/btrfs/print-tree.c:186 print_uuid_item() error: uninitialized symbol 'subvol_id'.
> fs/btrfs/tests/extent-io-tests.c:338 check_eb_bitmap() error: uninitialized symbol 'has'.
> fs/btrfs/tests/extent-io-tests.c:353 check_eb_bitmap() error: uninitialized symbol 'has'.
> fs/btrfs/uuid-tree.c:203 btrfs_uuid_tree_remove() error: uninitialized symbol 'read_subid'.
> fs/btrfs/uuid-tree.c:353 btrfs_uuid_tree_iterate() error: uninitialized symbol 'subid_le'.
> fs/btrfs/uuid-tree.c:72 btrfs_uuid_tree_lookup() error: uninitialized symbol 'data'.
> fs/btrfs/volumes.c:7415 btrfs_dev_stats_value() error: uninitialized symbol 'val'.
> 
> fs/btrfs/extent_io.c
>   4096  void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
>   4097                          unsigned long start, unsigned long len)
>   4098  {
>   4099          void *eb_addr = btrfs_get_eb_addr(eb);
>   4100  
>   4101          if (check_eb_range(eb, start, len))
>   4102                  return;
>                         ^^^^^^^
> 
> Originally this used to memset dstv to zero but now it just returns.
> I can easily just mark that error path as impossible.  These days
> everyone with a brain zeros their stack variables anyway so it shouldn't
> affect anyone who doesn't deserve it.

Thanks, this explains the other errors reported on linux-next with
possibly uninitialized variables.
