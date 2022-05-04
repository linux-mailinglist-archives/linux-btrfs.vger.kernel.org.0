Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286CE51A5DB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353611AbiEDQtq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353618AbiEDQtn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 12:49:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A0318E35
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 09:46:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AFAF01F37F;
        Wed,  4 May 2022 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651682764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oxBRjKi+92oYqcr59yFETtSsO1fSfa4TU7Erv5kQ1V8=;
        b=JveDbvAkUk52HTDpJPYZPrzo1dwOa0MzXS+m92s4kkrbPrXnm4ZdFN8pMt0fmx3D/gPVc+
        oEzksVZ5I4Ftda0zzgO1jG9LQ5kE9jv527UERpW8z5khOR04encpHYYIGllmBHjB8lxjWo
        U0NSHBXrLax4BDRgpA20oI+o04NMxfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651682764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oxBRjKi+92oYqcr59yFETtSsO1fSfa4TU7Erv5kQ1V8=;
        b=ChKXzQhZxZfN7cnaGcVqmLtb7kIdrw8JXBdbEiwmdexDNdUpKqK6M19tZZ3o3wtJoSaOel
        RUJaYpPCXiqRO6Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F856131BD;
        Wed,  4 May 2022 16:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DoE2HsytcmIyUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 04 May 2022 16:46:04 +0000
Date:   Wed, 4 May 2022 18:41:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: Turn fs_roots_radix in btrfs_fs_info into an
 XArray
Message-ID: <20220504164153.GR18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <20220503104443.24758-1-gniebler@suse.com>
 <b6c63093-9e5f-b8a0-39a3-3ba9af46005f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c63093-9e5f-b8a0-39a3-3ba9af46005f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 04, 2022 at 11:11:11AM +0300, Nikolay Borisov wrote:
> > +	spin_unlock(&fs_info->fs_roots_lock);
> >   	btrfs_free_log_root_tree(NULL, fs_info);
> >   }
> >   
> 
> nit: The xa_find/xa_for_each_start as used in this loop are really open-coded xa_extract.
> So the code could be simplified even further:
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 56d4d4db976b..cb1ccebfc48c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4875,23 +4875,18 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
>   static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
>   {
>          unsigned long index = 0;
> +       int grabbed = 0;
> +       struct btrfs_root *roots[8];
>   
>          spin_lock(&fs_info->fs_roots_lock);
> -       while (xa_find(&fs_info->fs_roots, &index, ULONG_MAX, XA_PRESENT)) {
> -               struct btrfs_root *root;
> -               struct btrfs_root *roots[8];
> -               int i;
> -               int grabbed = 0;
> +       while ((grabbed = xa_extract(&fs_info->fs_roots, (void **)roots, index,
> +                                    ULONG_MAX, 8, XA_PRESENT))) {
>   
> -               xa_for_each_start(&fs_info->fs_roots, index, root, index) {
> -                       roots[grabbed] = btrfs_grab_root(root);
> -                       grabbed++;
> -                       if (grabbed >= ARRAY_SIZE(roots))
> -                               break;
> -               }
> +               for (int i = 0; i < grabbed; i++)
> +                       roots[i] = btrfs_grab_root(roots[i]);
>                  spin_unlock(&fs_info->fs_roots_lock);
>   
> -               for (i = 0; i < grabbed; i++) {
> +               for (int i = 0; i < grabbed; i++) {
>                          if (!roots[i])
>                                  continue;

Folded to the patch, thanks.
