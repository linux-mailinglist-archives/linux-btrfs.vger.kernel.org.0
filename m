Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A04D574ED6
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 15:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbiGNNTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 09:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbiGNNTJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 09:19:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AF75B045
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 06:19:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 037931FA98;
        Thu, 14 Jul 2022 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657804715;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsZcyajPTzVgYQr/p2IdSy8Afb2I3F90NeYBc11z6EQ=;
        b=1lkB4jRo95jDUs2PnxXuxUAxytZWLRFw8tPVwIJY1PKPWbuMdq+dYtL1wdNXzUAvMZO2Jm
        4UHWI2umfAbqV+w1bYuhwR0Q76fxZxg/3ca9fwUAEAuMZuq42slbhZkT6qk0kA3Nb/da3o
        etQWygXALnvK+a1Jg6Lqn+JjxEhcMU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657804715;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsZcyajPTzVgYQr/p2IdSy8Afb2I3F90NeYBc11z6EQ=;
        b=OmkXShN5aO6Qy8pCTAmou4+9+r5ZkiZCB4LxQE4fdsutr8GpXhe27FQ86opgFXCcMBgpBO
        pd3RE6EXVBUDqmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D056D13A61;
        Thu, 14 Jul 2022 13:18:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NrnfMaoX0GIjFQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Jul 2022 13:18:34 +0000
Date:   Thu, 14 Jul 2022 15:13:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Message-ID: <20220714131344.GL15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220708200829.3682503-1-iangelak@fb.com>
 <20220708200829.3682503-2-iangelak@fb.com>
 <698582cc-00b2-7cca-f5a2-e8e238de053c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698582cc-00b2-7cca-f5a2-e8e238de053c@suse.com>
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

On Mon, Jul 11, 2022 at 04:04:01PM +0300, Nikolay Borisov wrote:
> > +	rwsem_release(&b->lock##_map, _THIS_IP_)
> > +
> >   static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
> >   {
> >   	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 76835394a61b..4061886024de 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3029,6 +3029,8 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
> >   
> >   void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
> >   {
> > +	static struct lock_class_key btrfs_trans_num_writers_key;
> 
> Shouldn't this variable and its initialization be defined in one of 
> the__init functions (i.e init_btrfs_fs() )for the btrfs' kernel module? 
> As it stands this would be called on every mount of any instance of a 
> btrfs filesystem?

Yeah I think it should be initialized once for the whole module, however
a static variable in __init function is not safe as the whole section
gets removed from memory once all functions get called (module vs
built-in), either an __initdata annotation or a static variable outside
of a function (eg. like fs_uuids in super.c).
