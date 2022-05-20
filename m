Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBAD52ED5D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 15:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbiETNmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 09:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbiETNmu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 09:42:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B2C633BA
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 06:42:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A9161F9B5;
        Fri, 20 May 2022 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653054167;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icFp3WdT/5wHDbx0wsOaJb8t5cVU1gOgxUh9LeBRShQ=;
        b=zu/3EsQxeJvCPfd2v96pyLaO1VB68tKmYUe2yVgLawtTCeFf3Rfg7hou/9RwwNy6F0Su2w
        8a8f1cT+lQrqbsB6bWiEZqUPr/GPDMyqlbiAoVXXjO31XicxY7wgjnP9fXyT7oyMFUIr/1
        hqsqaJepBeQG+iVBlim4hZvXdgneSYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653054167;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icFp3WdT/5wHDbx0wsOaJb8t5cVU1gOgxUh9LeBRShQ=;
        b=6iazBMozT85TROyk864kmh3p7pVAwiEqc62aOx9DVDgECOf6ZdyHhO+ca82m8Zea23jbR1
        o/XAuKjODKsZynAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30CE013A5F;
        Fri, 20 May 2022 13:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ojvLCteah2J/agAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 20 May 2022 13:42:47 +0000
Date:   Fri, 20 May 2022 15:38:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: do not abuse btrfs_commit_transaction()
 just to update super blocks
Message-ID: <20220520133827.GO18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <4ee1030eb7d24d13ffa1bda98364de07258ca079.1652872975.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee1030eb7d24d13ffa1bda98364de07258ca079.1652872975.git.wqu@suse.com>
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

On Wed, May 18, 2022 at 07:23:00PM +0800, Qu Wenruo wrote:
> There are several call sites utilizing btrfs_commit_transaction() just
> to update members in super blocks, without any metadata update.
> 
> This can be problematic for some simple call sites, like zero_log_tree()
> or check_and_repair_super_num_devs().
> 
> If we have big problems preventing the fs to be mounted in the first
> place, and need to clear the log or super block size, but by some other
> problems in extent tree, we're unable to allocate new blocks.
> 
> Then we fall into a deadlock that, we need to mount (even
> ro,rescue=all) to collect extra info, but btrfs-progs can not do any
> super block updates.
> 
> Fix the problem by allowing the following super blocks only operations
> to be done without using btrfs_commit_transaction():
> 
> - btrfs_fix_super_size()
> - check_and_repair_super_num_devs()
> - zero_log_tree().
> 
> There are some exceptions in btrfstune.c, related to the csum type
> conversion and seed flags.
> 
> In those btrfstune cases, we in fact wants to proper error report in
> btrfs_commit_transaction(), as those operations are not mount critical,
> and any early error can be helpful to expose any problems in the fs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
