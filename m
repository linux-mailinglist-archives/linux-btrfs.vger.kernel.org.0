Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBFD625E86
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 16:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiKKPkz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 10:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiKKPky (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 10:40:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24356EC0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 07:40:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E89A20202;
        Fri, 11 Nov 2022 15:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668181249;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=90rOxNu0TC6zY6DYyD5XRdbtx9gOrfkof1N54BG4dos=;
        b=INs7Gz7l8yLjuokA/7qy6+Zp/A1MZhCcS1nP7SpAadK/G7xNe39X5oj6H4uKJ+ZV5lAEUJ
        XZCctGsseigaG6l16OydsvU4blS4oIhDotqc2vH+CxTSSX1ut36h0b1mppJf9zLCNoIxUg
        Ig/0twuo/EQ7lSw6Iav/dKPQobWZyw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668181249;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=90rOxNu0TC6zY6DYyD5XRdbtx9gOrfkof1N54BG4dos=;
        b=8ch7HH297QfLZS29UNAGEy6YoiCXeG3EW4ccsRL8/wwVntxwcWjGioEtIaVPwXfh9GG9pV
        SauqZauG/1xWEGDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F30C13273;
        Fri, 11 Nov 2022 15:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R0pAFgFtbmOBOQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 15:40:49 +0000
Date:   Fri, 11 Nov 2022 16:40:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/40] Parameter and type changes to btrfs_inode
Message-ID: <20221111154025.GQ5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667331828.git.dsterba@suse.com>
 <83f9021b-df26-a725-e0bf-4f255dd2ddff@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f9021b-df26-a725-e0bf-4f255dd2ddff@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 03, 2022 at 10:45:11PM +0800, Anand Jain wrote:
> On 02/11/2022 04:11, David Sterba wrote:
>   For the series.
> 
>   Just a note, the naming convention for the local variables... as inode
>   represents struct btrfs_inode, we shouldn't use the same name for
>   struct inode. Instead, vfs_inode is better. And binode is gone.

Yeah the naming could be done like that. Some functions interact only
with inode so I won't mind using that name but in case there are both it
would be better to use the vfs_ prefix.
