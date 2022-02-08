Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7564ADF10
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 18:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiBHROt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 12:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383389AbiBHQ1Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 11:27:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B98FC06174F
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 08:27:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5B0281F388;
        Tue,  8 Feb 2022 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644337642;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5wKPk9X3qWgb8IbnlDkjTJKDAaoi5ZNgvaSu1tu6R4=;
        b=ZSW5hLk+6R+VnwLJLVEEmtXLXwYtANN5K69KQptUQg9eMldgRlRrmBZKnUkiLXIE88BQBf
        BVExSjKim/20q0PvudYuASHdS7WsB9QHUzTJl20FOwg6SPIRfiFMjttv/VQjs36dqMzVc8
        rQudI6SQa85drCSrNSmABpw0EnwHmdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644337642;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5wKPk9X3qWgb8IbnlDkjTJKDAaoi5ZNgvaSu1tu6R4=;
        b=dbcaDBCRa+m5EBiMaMEQuAG4RIhRYTBxfV3qJYZWrM+LzWJUB5OYZY/VRHl6P39oX+/AUi
        gR5tchfgs6aO6uDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5240CA3B94;
        Tue,  8 Feb 2022 16:27:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DF47FDAB3F; Tue,  8 Feb 2022 17:23:41 +0100 (CET)
Date:   Tue, 8 Feb 2022 17:23:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix missing log mutex unlock after failure to log
 inode
Message-ID: <20220208162341.GC12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <b98e09dd2c88d71e92ebcfd083dc5687d53b9006.1644244472.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b98e09dd2c88d71e92ebcfd083dc5687d53b9006.1644244472.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 07, 2022 at 02:39:00PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Before starting to log an inode, we check if the inode was logged before
> by calling inode_logged(). If we get an error from that call, we jump
> to the 'out' label, which results in returning from btrfs_log_inode()
> without unlocking the inode's log mutex. Fix that by jumping to the
> 'out_unlock' label instead.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> This is meant to be applied on top of:
> "btrfs: avoid inode logging during rename and link when possible", which
> is only on misc-next, not on Linus' tree yet.
> 
> David, can you fold it into that patch? Or I can send a new version
> of the series. Thanks.

Folded, thanks.
