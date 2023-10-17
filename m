Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EAD7CD04E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Oct 2023 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQXSX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQXSW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 19:18:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7338B98
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 16:18:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F0FA91F8D7;
        Tue, 17 Oct 2023 23:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697584698;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6aOtzOP+jqF8V3NFDXXKQ2g1iXwHGnvP+6Tvb9Zo4MY=;
        b=r0eKgRe3tWNO4XvE/1MitdVAdOjcQ7IVV8mdD/dLt/pUSEsLkpJcgKaUWpI27PBAuePTdB
        ilexmQib9iz27qVq9OU1XdGhVLOTWKM5uBLyo5Zov3ht6OXYVgjGwtDjs1wnUXXPpCsQKr
        nLQl4TM5w5JtGLSqPmaCIyiQ83L/x4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697584698;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6aOtzOP+jqF8V3NFDXXKQ2g1iXwHGnvP+6Tvb9Zo4MY=;
        b=kuUoFDU7yAkuVFAOHWcuJudxoJoROqus6piY9x4gZMyRLatL9+7+7iiCJ3+AjkxiWzUjY0
        Xfu4XhtfrvVcXIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C807E13584;
        Tue, 17 Oct 2023 23:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nBwuMDoWL2XuFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Oct 2023 23:18:18 +0000
Date:   Wed, 18 Oct 2023 01:11:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/6] btrfs-progs: use a unified btrfs_make_subvol()
 implementation
Message-ID: <20231017231128.GA26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1697430866.git.wqu@suse.com>
 <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
 <20231017134929.GA2350212@perftesting>
 <3df53251-41f6-4655-a0fe-a7baecb2a66d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df53251-41f6-4655-a0fe-a7baecb2a66d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         FREEMAIL_ENVRCPT(0.00)[gmx.com];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FREEMAIL_TO(0.00)[gmx.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 18, 2023 at 06:44:22AM +1030, Qu Wenruo wrote:
> On 2023/10/18 00:19, Josef Bacik wrote:
> > On Mon, Oct 16, 2023 at 03:08:50PM +1030, Qu Wenruo wrote:
> >> --- a/kernel-shared/ctree.h
> >> +++ b/kernel-shared/ctree.h
> >> @@ -1134,6 +1134,10 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
> >>   		      *item);
> >>   int btrfs_find_last_root(struct btrfs_root *root, u64 objectid, struct
> >>   			 btrfs_root_item *item, struct btrfs_key *key);
> >> +int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
> >> +			struct btrfs_root *root, u64 objectid);
> >> +struct btrfs_root *btrfs_create_subvol(struct btrfs_trans_handle *trans,
> >> +				       u64 objectid);
> >>   /* dir-item.c */
> >>   int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, struct btrfs_root
> >>   			  *root, const char *name, int name_len, u64 dir,
> >> diff --git a/kernel-shared/root-tree.c b/kernel-shared/root-tree.c
> >> index 33f9e4697b18..1fe7d535fdc7 100644
> >> --- a/kernel-shared/root-tree.c
> >> +++ b/kernel-shared/root-tree.c
> >
> > We're moving towards a world where kernel-shared will be an exact-ish copy of
> > the kernel code.  Please put helpers like this in common/, I did this for
> > several of the extent tree related helpers we need for fsck, this is a good fit
> > for that.  Thanks,
> 
> Sure, and this also reminds me to copy whatever we can from kernel.

I do syncs from kernel before a release but all the low hanging fruit is
probably gone so it needs targeted updates.
