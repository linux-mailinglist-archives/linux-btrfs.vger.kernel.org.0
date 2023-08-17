Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EAE77F5CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 13:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347765AbjHQL7R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 07:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350571AbjHQL7A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 07:59:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D493213F
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 04:58:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F4A221877;
        Thu, 17 Aug 2023 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692273538;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kmMDem0nGZoyBWolmbkZ6GzMojdOSQ7v4VDyjHQ0J68=;
        b=FVU+iAWVuqbxE+TtZCJN/jY7gHycEu3JoQ82eHv4DDU0/8fiYMHvK1q3/J6I+Y9//PNnQe
        SUgt8ojGkkUGcig6UWPvZzS7R/BJ0W9YKvgUXp6/NnLlhZ5/g5aVrg2eA7Kjk3cdQuX9g3
        B1dPi4gkmbM2bev3swVLvnKWRQYRlHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692273538;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kmMDem0nGZoyBWolmbkZ6GzMojdOSQ7v4VDyjHQ0J68=;
        b=kNNJC07a0UgdTwYMNI9xyCu6iXPWyTnvzQ2+xhr0l5frWVvVSJj7umVmdLcd0U/BAWHSEc
        7nsiSar2fxqPyABw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC50B1358B;
        Thu, 17 Aug 2023 11:58:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nSmwNIEL3mSXTQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 11:58:57 +0000
Date:   Thu, 17 Aug 2023 13:52:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
Message-ID: <20230817115229.GJ2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <12b53ab9683c805873d26a4881308137e0bd324e.1692097274.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b53ab9683c805873d26a4881308137e0bd324e.1692097274.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 15, 2023 at 08:53:24PM +0800, Anand Jain wrote:
> The btrfstune -m|M operation changes the fsid and preserves the original
> fsid in the metadata_uuid.
> 
> Changing the fsid happens in two commits in the function
> set_metadata_uuid()
> - Stage 1 commits the superblock with the CHANGING_FSID_V2 flag.
> - Stage 2 updates the fsid in fs_info->super_copy (local memory),
>   resets the CHANGING_FSID_V2 flag (local memory),
>   and then calls commit.
> 
> The two-stage operation with the CHANGING_FSID flag makes sense for
> btrfstune -u|U, where the fsid is changed on each and every tree block,
> involving many commits. The CHANGING_FSID flag helps to identify the
> transient incomplete operation.
> 
> However, for btrfstune -m|M, we don't need the CHANGING_FSID_V2 flag, and
> a single commit would have been sufficient. The original git commit that
> added it, 493dfc9d1fc4 ("btrfs-progs: btrfstune: Add support for changing
> the metadata uuid"), provides no reasoning or did I miss something?
> (So marking this patch as RFC).

I remember discussions with Nikolay about the corner cases that could
happen due to interrupted conversion and there was a document explaining
that. Part of that ended up in kernel in the logic to detect partially
enabled metadata_uuid.  So there was reason to do it in two phases but
I'd have to look it up in mails or if I still have a link or copy of the
document.
