Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B378B537
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjH1QRm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjH1QRc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 12:17:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3212B12A
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 09:17:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA36321A87;
        Mon, 28 Aug 2023 16:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693239447;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uokl0o6z39tGCftqqn5KrSPCPGTMRXTau0J//REoKY4=;
        b=mPTeNUiGf8WlrxbyW96MJLvggQ1h7/etvU018wFzZSe/i47R0G5KDl3wQJidYyiBU0cNNR
        if6jqTZ93cTR/RRW4ICg6FCehugqSV40tGZigMpTVfWUvqnWFrcMD4KVAlfaYjqPcFQ3vq
        iDvdWc2GayA8suMKduEkzb1qJCeGEMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693239447;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uokl0o6z39tGCftqqn5KrSPCPGTMRXTau0J//REoKY4=;
        b=vtjszJc3UtFqGO0J/00M9tGgZ5PSP2VKv/3WzEeRb21zM+S0s5yd+2KocPWTqLhBlcJKjz
        NPt86dTiH6XzStAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4A68139CC;
        Mon, 28 Aug 2023 16:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tX1EL5fI7GSdHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Aug 2023 16:17:27 +0000
Date:   Mon, 28 Aug 2023 18:10:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: rely on "btrfstune --csum" to replace
 "btrfs check --init-csum-tree"
Message-ID: <20230828161052.GH14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692688214.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692688214.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 22, 2023 at 03:15:16PM +0800, Qu Wenruo wrote:
> We had a report that "btrfs check --init-csum-tree" corrupted a
> seemingly fine btrfs (which can originally pass "btrfs check
> --readonly").
> 
> The root cause is in how we rebuild the csum tree, in the btrfs check
> code, we screw up the csum tree root, then rely on the extent tree
> repair code to finish the damage we introduced.
> 
> This can lead to unexpected corner cases, if the fs is already fine,
> there is no need for such risky move.
> 
> Considering there are valid ways to cause data csum mismatch (mostly
> O_DIRECT and modifying the buffer when it's still under writeback), some
> users expect to use "btrfs check --init-csum-tree" to fix the csum
> mismatch, which can lead to the same corruption.
> 
> Instead this patchset would recommend the end users to go "btrfstune
> --csum", as it is way less risky by its design, and no more damage to
> the fs caused by ourselves.
> 
> I hope we can completely go that direction when the "btrfstune --csum"
> option is moved out of experimental features.
> 
> Qu Wenruo (2):
>   btrfs-progs: tune: allow --csum to rebuild csum tree
>   btrfs-progs: check: add advice to avoid --init-csum-tree

We can go farther and label the option as dangerous in a more visible
way, currently there's no warning and it's marked as dangerous only in
documentation and not even in the help text. I'd like to deprecate the
option and remove it from 'check' completely.

Adding support to btrfstune --csum to rebuild the checksum tree is OK.
