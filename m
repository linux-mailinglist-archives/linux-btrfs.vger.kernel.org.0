Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD872491C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 18:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjFFQ3m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbjFFQ3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 12:29:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC1510D7
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 09:29:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 96E962193C;
        Tue,  6 Jun 2023 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686068978;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5jIE8mlmsyKDESfiszEur30GRYjKV/n4mIHP1BayNE=;
        b=A8umOS9CIXjNRLjt3CEQ7lBTIb9vurPx1GgQvDaLESLAwFpqoL3aa7XSrgKRydbrFeEi4J
        cpxAQQBfW14tl4ZAAPMKJ9MKvoduyNvknlc5xeV7FW7wA6iZG0DOj0sudfj9fdA/lIDj3i
        JQze+n+Q1YWIpQTfbx94JBt1hai49hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686068978;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5jIE8mlmsyKDESfiszEur30GRYjKV/n4mIHP1BayNE=;
        b=syaMLGUj27FBF5KsxLnZPKSGiMoeusW5aN2e2v6sqq8xRByESC38OJymJavgUlMySebCBM
        2h++jWAjtwqar8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73AF013519;
        Tue,  6 Jun 2023 16:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 96J1G/Jef2RBPgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Jun 2023 16:29:38 +0000
Date:   Tue, 6 Jun 2023 18:23:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Naohiro Aota <naota@elisp.net>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 4/4] btrfs: reinsert BGs failed to reclaim
Message-ID: <20230606162323.GJ25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1686028197.git.naohiro.aota@wdc.com>
 <e8acfcfefeb3156e11e60ea97dcd2c6ecf984101.1686028197.git.naohiro.aota@wdc.com>
 <CAL3q7H5=dxzeGELzge_wJQJuRF8gzd_1SAm3O6QxcMB7HpSJkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5=dxzeGELzge_wJQJuRF8gzd_1SAm3O6QxcMB7HpSJkw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 06, 2023 at 11:25:23AM +0100, Filipe Manana wrote:
> On Tue, Jun 6, 2023 at 7:04 AM Naohiro Aota <naota@elisp.net> wrote:
> > +                       spin_lock(&fs_info->unused_bgs_lock);
> > +                       if (list_empty(&bg->bg_list))
> > +                               list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
> > +                       else
> > +                               btrfs_put_block_group(bg);
> > +                       spin_unlock(&fs_info->unused_bgs_lock);
> > +                       spin_unlock(&bg->lock);
> > +               }
> 
> Also, this is very similar to btrfs_mark_bg_to_reclaim(), so we should
> use that, and simply have:
> 
> btrfs_mark_bg_to_reclaim();
> btrfs_put_block_group(bg);

I can fold the diff below if you agree

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1833,18 +1833,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
                }
 
 next:
-               if (!ret) {
-                       btrfs_put_block_group(bg);
-               } else {
-                       spin_lock(&bg->lock);
-                       spin_lock(&fs_info->unused_bgs_lock);
-                       if (list_empty(&bg->bg_list))
-                               list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
-                       else
-                               btrfs_put_block_group(bg);
-                       spin_unlock(&fs_info->unused_bgs_lock);
-                       spin_unlock(&bg->lock);
-               }
+               if (!ret)
+                       btrfs_mark_bg_to_reclaim(bg);
+               btrfs_put_block_group(bg);
 
                mutex_unlock(&fs_info->reclaim_bgs_lock);
                /*
---
