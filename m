Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8CA5EF87B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 17:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiI2PRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Sep 2022 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiI2PRN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Sep 2022 11:17:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9417314F2BB
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Sep 2022 08:17:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5D8D21C08;
        Thu, 29 Sep 2022 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664464629;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ns78DnHMUU/D9vCghHx0PUHvoivdxnBgVxHdlSZRlxo=;
        b=wE+KgcnwUDr4H3deWE0Ybk2COgT+K6c4CkXpfwNs2xnUnoCyCZ7DDeKC1kYCJGogbuhXPq
        QRW6DpclNzcfKHc8weG9ofHeIrTXicf2CqN0CztlbkBHWnR31tiwhEgSzwsGlt98zb5Wbq
        q0yOBlUWxxpvRaavTrJmUABqDbUlFKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664464629;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ns78DnHMUU/D9vCghHx0PUHvoivdxnBgVxHdlSZRlxo=;
        b=Uo0e9TAnhJBp/aUInCa/SSk9iG7+tGmEkStVA9rGMWb15+AUbysZ1QfNG2Mqx9sY387XIl
        cPPDsHROKdaIdgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C38B81348E;
        Thu, 29 Sep 2022 15:17:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PMDNLvW2NWOkWAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Sep 2022 15:17:09 +0000
Date:   Thu, 29 Sep 2022 17:11:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [bug report] btrfs: make can_nocow_extent nowait compatible
Message-ID: <20220929151133.GH13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <Yy3I2J2MxTZQQNjs@kili>
 <CAEzrpqdVs6O5yHwwMxjvMfvNUWLt2QN=7dYGDVu8Gy1PEf=vsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdVs6O5yHwwMxjvMfvNUWLt2QN=7dYGDVu8Gy1PEf=vsg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 11:22:39AM -0400, Josef Bacik wrote:
> On Fri, Sep 23, 2022 at 10:55 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Josef Bacik,
> >
> > The patch 9ec9594f6de7: "btrfs: make can_nocow_extent nowait
> > compatible" from Sep 12, 2022, leads to the following Smatch static
> > checker warning:
> >
> >         fs/btrfs/extent-tree.c:2225 check_delayed_ref()
> >         warn: refcount leak 'cur_trans->use_count.refs.counter': lines='2225'
> >
> > fs/btrfs/extent-tree.c
> >     2193 static noinline int check_delayed_ref(struct btrfs_root *root,
> >     2194                                       struct btrfs_path *path,
> >     2195                                       u64 objectid, u64 offset, u64 bytenr)
> >     2196 {
> >     2197         struct btrfs_delayed_ref_head *head;
> >     2198         struct btrfs_delayed_ref_node *ref;
> >     2199         struct btrfs_delayed_data_ref *data_ref;
> >     2200         struct btrfs_delayed_ref_root *delayed_refs;
> >     2201         struct btrfs_transaction *cur_trans;
> >     2202         struct rb_node *node;
> >     2203         int ret = 0;
> >     2204
> >     2205         spin_lock(&root->fs_info->trans_lock);
> >     2206         cur_trans = root->fs_info->running_transaction;
> >     2207         if (cur_trans)
> >     2208                 refcount_inc(&cur_trans->use_count);
> >     2209         spin_unlock(&root->fs_info->trans_lock);
> >     2210         if (!cur_trans)
> >     2211                 return 0;
> >     2212
> >     2213         delayed_refs = &cur_trans->delayed_refs;
> >     2214         spin_lock(&delayed_refs->lock);
> >     2215         head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
> >     2216         if (!head) {
> >     2217                 spin_unlock(&delayed_refs->lock);
> >     2218                 btrfs_put_transaction(cur_trans);
> >     2219                 return 0;
> >     2220         }
> >     2221
> >     2222         if (!mutex_trylock(&head->mutex)) {
> >     2223                 if (path->nowait) {
> >     2224                         spin_unlock(&delayed_refs->lock);
> > --> 2225                         return -EAGAIN;
> >
> > Call btrfs_put_transaction(cur_trans); before returning?
> 
> Ah well that's pretty fucking cool Dan, nice catch.  Thanks,

btrfs_put_transaction added after spin_lock to the patch, thanks.
