Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C665FA62E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 22:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJJU3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 16:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiJJU3S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 16:29:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97477F0B0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 13:27:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0209F22B29;
        Mon, 10 Oct 2022 20:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665433156;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyiJ2jv/6VZiHJ68C+wsoIDgeJLCrZxBFPEI6glNgpQ=;
        b=QTlyXsmmZnqQLn9UzV6moLCSN6gzud/bBcw4h4NYzZvMD6Na43KdiH7ymlDxidee21NB/P
        g+SACW/bbH9pYLamRIzzOM7xM+wd48eOLxGI0XDWrRVetfjKS8VY4m74sASXBZO+h5Ddum
        sTbUMKVDOV/ciJ04xmJK2XpAiaeofjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665433156;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyiJ2jv/6VZiHJ68C+wsoIDgeJLCrZxBFPEI6glNgpQ=;
        b=VM4Wywn/JmKqObRaMPpH00bshU8t3ZulpqUNfi2G8F5icy8n+5xY/Z+DyOgZtSaVNBAcm/
        FZuX8tHwos0StNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFD4313ACA;
        Mon, 10 Oct 2022 20:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FZrNLUN+RGPjJgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 10 Oct 2022 20:19:15 +0000
Date:   Mon, 10 Oct 2022 22:19:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: add extent-tree-v2 support to dump-super
Message-ID: <20221010201910.GH13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <78ebe492ca09e716ca5ca2b6fabec0934aaa0370.1665219233.git.anand.jain@oracle.com>
 <764d5754-62bf-232a-a6c2-67724111a72b@gmx.com>
 <af541998-3980-85c3-e3c3-dd0cf09f52cf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af541998-3980-85c3-e3c3-dd0cf09f52cf@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 10, 2022 at 03:43:51PM +0800, Anand Jain wrote:
> On 10/9/22 07:13, Qu Wenruo wrote:
> > On 2022/10/8 17:02, Anand Jain wrote:
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>   kernel-shared/print-tree.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> >> index 5c3d14298b58..6b5fd37ab2bc 100644
> >> --- a/kernel-shared/print-tree.c
> >> +++ b/kernel-shared/print-tree.c
> >> @@ -1689,6 +1689,9 @@ static struct readable_flag_entry 
> >> incompat_flags_array[] = {
> >>       DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
> >>       DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
> >>       DEF_INCOMPAT_FLAG_ENTRY(ZONED),
> >> +#if EXPERIMENTAL
> >> +    DEF_INCOMPAT_FLAG_ENTRY(EXTENT_TREE_V2),
> >> +#endif
> > 
> > That's in fact one solution I want to go.
> > 
> > But later I found that, we can enhance __print_readable_flag() to
> > iterate the incompat_flags_array[] with extra check on @supported_flags,
> > so we can skip the EXPERIMENTAL macro inside the array.
> > 
> > By that, we can reduce the number of EXPERIMENTAL macros, which I
> > believe is already causing burdens for testing.
> 
> Yeah, possible. However, it is a cleanup; I wouldn't mix that in the bug 
> fix, here.

I'll apply your patch as it's a hotfix, what Qu suggests can be done as
consolidation later, though I agree that the number of EXPERIMENTAL
ifdefs should be kept reasonable.
