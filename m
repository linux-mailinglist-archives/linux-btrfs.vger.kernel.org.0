Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4DA736954
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 12:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjFTKb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFTKbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 06:31:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF36E3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 03:31:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5EC571F37C;
        Tue, 20 Jun 2023 10:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687257083;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEZ46lzeSBoSiFtLU0rhEytYYF3QCZvsHI7Ekb/4Evk=;
        b=m5HMIYdD3H1Qd+Sdama3KpnnayOwIQXJoLQsAR/uL9yC2eJuDy9Kbtj3Gg8Ovoresr3+Cs
        ubJ43OHiwmGLJlShL7AMzK8UpzU3BSFVuR2cy+4pw8P5XEeVNFOjQGyFIBsbnTlh7ePWPU
        igJvp27kH/nggNPmTtxdPBd/Lj2LOKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687257083;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEZ46lzeSBoSiFtLU0rhEytYYF3QCZvsHI7Ekb/4Evk=;
        b=LKAGMTpPCakLGflqbo5+sC1TZTPqR0qWI9g7HEmIgmFGJuMHlgn2bKc1TsnI5uTVggBsR3
        3jwOxXgQ1DS+/LCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42AC11346D;
        Tue, 20 Jun 2023 10:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CY1QD/t/kWQ1XAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Jun 2023 10:31:23 +0000
Date:   Tue, 20 Jun 2023 12:25:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: display ACL support
Message-ID: <20230620102500.GH16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <df5dfa3a329e7418519a5881311d776a50a118a2.1687250430.git.anand.jain@oracle.com>
 <1d62fb411a289807d8d12d6a76bdca867a56b591.1687248417.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d62fb411a289807d8d12d6a76bdca867a56b591.1687248417.git.anand.jain@oracle.com>
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

On Tue, Jun 20, 2023 at 04:55:09PM +0800, Anand Jain wrote:
> ACL support is dependent on the compile-time configuration option
> CONFIG_BTRFS_FS_POSIX_ACL. Prior to mounting a btrfs filesystem, it is not
> possible to determine whether ACL support has been compiled in. To address
> this, add a sysfs interface, /sys/fs/btrfs/features/acl, and check for ACL
> support in the system's btrfs.

For completeness we could add it there but how many systems are there
that don't compile in ACLs? Typically this is for embedded environments
and it's probably global, not just for btrfs.

We can't drop CONFIG_BTRFS_FS_POSIX_ACL to make it unconditional as it
depends on the VFS interface but at least we could somehow use 
CONFIG_FS_POSIX_ACL directly.
