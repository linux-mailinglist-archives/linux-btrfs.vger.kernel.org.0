Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879A874F8B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 22:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGKUGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 16:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGKUGQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 16:06:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B1411D
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 13:06:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20EEC21C17;
        Tue, 11 Jul 2023 20:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689105973;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vo9xfyBgMvmBFshjwRkGV4bIrD6V6mYIQptOYWOdqCs=;
        b=xEPOzeYldUXHgJb+vYa6fvtodXqIQJZm4NjwjMjBSGckDSE19NnuEgi+nYxKfhq7XrFDNy
        etXtWuE0MEgj6jWz9Dkn712LEuZ5+NUa315ttb59deEMLuQXptWRfspCIByoPf5U7X41sf
        y7m1YOqPKqAv9pN2EMauM2XlknlDdUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689105973;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vo9xfyBgMvmBFshjwRkGV4bIrD6V6mYIQptOYWOdqCs=;
        b=Pz/4r3LQBFFDLg0KKfOFgFOJvmY3bYXNWie7LKwMBLVZVA2DrTVCx2c0aE1sEeL4OZnDMa
        3VXeRnV+J3Ol2rAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03D171390F;
        Tue, 11 Jul 2023 20:06:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9QoKADW2rWTEGAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Jul 2023 20:06:12 +0000
Date:   Tue, 11 Jul 2023 21:59:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fix error paths of btrfs_orphan_cleanup()
Message-ID: <20230711195937.GD30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1688403622.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688403622.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 03, 2023 at 06:15:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These fix two issues with error paths of btrfs_orphan_cleanup(), a double
> iput() on an inode and an iput() against a ERR_PTR(-ENOENT) inode pointer,
> resulting in a crash. More details on the changelogs.
> 
> Filipe Manana (2):
>   btrfs: fix double iput() on inode after an error during orphan cleanup
>   btrfs: fix iput() on error pointer after error during orphan cleanup

Added to misc-next, thanks.
