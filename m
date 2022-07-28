Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB9583D85
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 13:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiG1Lez (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 07:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiG1Lex (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 07:34:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0476E4A827
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 04:34:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B346B20C56;
        Thu, 28 Jul 2022 11:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659008091;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1F7oX4yYYaOvKaW7WDxmdHkLcuDAfk/pQ+0hBvrclw8=;
        b=Sfryyt9mRfqy5+MgDGzEKlnrj+veM2+mPOHJrkV0p8qd/kJHaHAfTWPta9iWCsPdCZvqbU
        TjpI8xobZnBuCfkhNbdaxRADYe1R8j62wLPHJqcjcTaS7c+wAzRW2Nrovnn72L9+vC9ifO
        L6JtK5R3Ljx/kfODnUCX4L9T98GWyJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659008091;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1F7oX4yYYaOvKaW7WDxmdHkLcuDAfk/pQ+0hBvrclw8=;
        b=bvPaaPGZgbdBhk2CV/YVkgy8YMIodfmXxj/WHDgZ3ExNQueji4R6poZztpLsoGtHsggTZc
        y6RuiQ4APC5M7sCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91F1513427;
        Thu, 28 Jul 2022 11:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7Z3GIlt04mKWCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 28 Jul 2022 11:34:51 +0000
Date:   Thu, 28 Jul 2022 13:29:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: show discard stats and tunables in
 non-debug build
Message-ID: <20220728112952.GA13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220727175659.16661-1-dsterba@suse.com>
 <f4321664-18cd-1153-4380-d5a9bff64111@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4321664-18cd-1153-4380-d5a9bff64111@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 28, 2022 at 12:50:03PM +0800, Anand Jain wrote:
> 
> 
> 
> 
> > @@ -1102,7 +1103,6 @@ struct btrfs_fs_info {
> >   
> >   #ifdef CONFIG_BTRFS_DEBUG
> >   	struct kobject *debug_kobj;
> 
> debug_kobj is defined inside the CONFIG_BTRFS_DEBUG;;
> 
> > -	struct kobject *discard_debug_kobj;
> >   	struct list_head allocated_roots;
> >   
> >   	spinlock_t eb_leak_lock;
> 
> 
> > -#ifdef CONFIG_BTRFS_DEBUG
> > -	if (fs_info->discard_debug_kobj) {
> > -		sysfs_remove_files(fs_info->discard_debug_kobj,
> > -				   discard_debug_attrs);
> > -		kobject_del(fs_info->discard_debug_kobj);
> > -		kobject_put(fs_info->discard_debug_kobj);
> > +	if (fs_info->discard_kobj) {
> > +		sysfs_remove_files(fs_info->discard_kobj, discard_attrs);
> > +		kobject_del(fs_info->discard_kobj);
> > +		kobject_put(fs_info->discard_kobj);
> >   	} >   	if (fs_info->debug_kobj) {
> 
> but here it got accessed outside of CONFIG_BTRFS_DEBUG define.
> 
> >   		sysfs_remove_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
> >   		kobject_del(fs_info->debug_kobj);
> >   		kobject_put(fs_info->debug_kobj);
> >   	}
> > -#endif
> > +
> 
> 
> I wonder if compile will fail? or if diff showing it wrongly?
> Sorry I didn't try compile the patch without CONFIG_BTRFS_DEBUG defined.

Yes it fails, now fixed, thanks.
