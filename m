Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4A50A3AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389870AbiDUPMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 11:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiDUPMA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 11:12:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C218E0F
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 08:09:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5EEB21107;
        Thu, 21 Apr 2022 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650553748;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YXcqTJE0Rw85A5c9ulVuFU3bHUARp9rO3Sj8GlC4Zeo=;
        b=OjCiSiOjyzlDbE8h/7TtEnnUOERmWvvCzmdjybYiBUo+4Qx5UxBQ8ye2/YnyKdjAPpLG/D
        tmLIMHt5nJMn5Y0Npuwv2E9YYbnr4gpD8zNoPZ8VA6erSOWmu8ABKNidyex9pem5849rwi
        +mjA8Khto4Fo0n8uVrd4h1IZsaf2Xc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650553748;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YXcqTJE0Rw85A5c9ulVuFU3bHUARp9rO3Sj8GlC4Zeo=;
        b=5Fno4ipxeiSlJh0mzuEQm7ovdeD5v3xhwZu+CPN+GcmMKJjegthyNPadHEMRONDqYRKClI
        HXm00Mb3G3pI3iCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA4DE13A84;
        Thu, 21 Apr 2022 15:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CR52MJRzYWJOXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 21 Apr 2022 15:09:08 +0000
Date:   Thu, 21 Apr 2022 17:05:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not BUG_ON() on failure to update inode when
 setting xattr
Message-ID: <20220421150504.GC18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <bf2fb575bc7b960b925693b9d64a802f4c477fc3.1650535321.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2fb575bc7b960b925693b9d64a802f4c477fc3.1650535321.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 21, 2022 at 11:03:09AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are doing a BUG_ON() if we fail to update an inode after setting (or
> clearing) a xattr, but there's really no reason to not instead simply
> abort the transaction and return the error to the caller. This should be
> a rare error because we have previously reserved enough metadata space to
> update the inode and the delayed inode should have already been setup, so
> an -ENOSPC or -ENOMEM, which are the possible errors, are very unlikely to
> happen.
> 
> So replace the BUG_ON()s with a transaction abort.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
