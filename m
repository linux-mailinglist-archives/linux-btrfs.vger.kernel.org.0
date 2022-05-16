Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A565288AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 17:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245238AbiEPPXf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245342AbiEPPXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 11:23:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430823C71E
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 08:22:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E27A821FFD;
        Mon, 16 May 2022 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652714561;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QU9yqN7dfdZBHNrJTXelj6vbjBHVdlYLJd6tmwgUwgw=;
        b=eBsNGqBeEr9HzA5RC8fBiKPPdFpKm0l5PmWjLBph0Ml6svK0+5JTfKw1MY6GgAgQBmpxF/
        zDuW5aNBOmj53pM3aDINxJmzdw9ecDRuSSg8cKHRJ2FFWi3Zo51ztP9N5WsvlK1ZrCsyN4
        NevHEdD55ixkfunZ4mNreHQ/1Gn7SM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652714561;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QU9yqN7dfdZBHNrJTXelj6vbjBHVdlYLJd6tmwgUwgw=;
        b=sonGf3Hjl4R+4LwZlBwaK47TbmK5e9eJeS/B74c1voRz8bPDdNF2jSWSZHf792y/xczP+X
        wDx0DJRcO11EHqBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8AEE13ADC;
        Mon, 16 May 2022 15:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yUP2K0FsgmIEMgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 16 May 2022 15:22:41 +0000
Date:   Mon, 16 May 2022 17:18:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, gniebler@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: turn fs_roots_radix in btrfs_fs_info into an
 XArray
Message-ID: <20220516151824.GY18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, gniebler@suse.com,
        linux-btrfs@vger.kernel.org
References: <YoIFmTMuHork+zC2@kili>
 <beed78e9-ca59-636a-1503-cd10eca2b276@suse.com>
 <20220516110239.GH29930@kadam>
 <576a6039-5ee3-6b5e-aa3c-8caaeec956df@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <576a6039-5ee3-6b5e-aa3c-8caaeec956df@suse.com>
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

On Mon, May 16, 2022 at 02:45:57PM +0300, Nikolay Borisov wrote:
> On 16.05.22 г. 14:02 ч., Dan Carpenter wrote:
> > On Mon, May 16, 2022 at 01:39:52PM +0300, Nikolay Borisov wrote:
> >> On 16.05.22 г. 11:04 ч., Dan Carpenter wrote:
> >>>       4538                 xa_for_each_start(&fs_info->fs_roots, index, root, index) {
> >>>       4539                         /* Avoid grabbing roots in dead_roots */
> >>>       4540                         if (btrfs_root_refs(&root->root_item) > 0)
> >>>       4541                                 roots[grabbed++] = btrfs_grab_root(root);
> >>>       4542                         if (grabbed >= ARRAY_SIZE(roots))
> >>>       4543                                 break;
> > 
> > breaks out of xa_for_each_start() loop.
> 
> This is fine, as when we fill root[] then we'd process it in the 
> subsequent for loop.
> 
> > 
> >>>       4544                 }
> >>>       4545                 spin_unlock(&fs_info->fs_roots_lock);
> >>>       4546
> >>>       4547                 for (i = 0; i < grabbed; i++) {
> >>>       4548                         if (!roots[i])
> >>>       4549                                 continue;
> >>>       4550                         index = roots[i]->root_key.objectid;
> >>>       4551                         err = btrfs_orphan_cleanup(roots[i]);
> >>>       4552                         if (err)
> >>>       4553                                 break;
> > 
> > breaks out of for loop.
> 
> However, this is indeed a genuine bug, and the fix for it is:
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index fe309db9f5ff..f33093513360 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4549,12 +4549,13 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info 
> *fs_info)
>                          index = roots[i]->root_key.objectid;
>                          err = btrfs_orphan_cleanup(roots[i]);
>                          if (err)
> -                               break;
> +                               goto out;
>                          btrfs_put_root(roots[i]);
>                  }
>                  index++;
>          }
> 
> +out:
>          /* Release the roots that remain uncleaned due to error */
>          for (; i < grabbed; i++) {
>                  if (roots[i])

Thanks Dan for the report, fixup folded and pushed.
