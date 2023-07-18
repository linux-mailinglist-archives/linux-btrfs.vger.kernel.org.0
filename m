Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497727581B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 18:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGRQIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jul 2023 12:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjGRQIO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jul 2023 12:08:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257F1710
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 09:07:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BCCC1F88F;
        Tue, 18 Jul 2023 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689696468;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TvErfcC4AyzeJSLRnHSxqNt3r2jzTpGeD1pu5jNpgFo=;
        b=T/WWvchMlS4cE32DKlJIJ2CLBaIHmZDBCiR56DcGDXpT7fUrtFqMd3mKSdDmscaGoOVKrZ
        xrNAp00KKGIZUFTYVpzveYTaIK/kXuELJirYLZ4CUbGSFHYhgoxLyHbW/LFLx3IVkK4STq
        rokdD6yX1OH3Ww18+UY0pclMVi8B9eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689696468;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TvErfcC4AyzeJSLRnHSxqNt3r2jzTpGeD1pu5jNpgFo=;
        b=v8kG/FoYTH4FfC59whqAx3O7a3GLCkEkm1V/nrjFgAXEA0m4Wq5lM9aGizkBLWVa/3pGyc
        KdOPVBQCMthtJNAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 238F013494;
        Tue, 18 Jul 2023 16:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DxfKB9S4tmTfPwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Jul 2023 16:07:48 +0000
Date:   Tue, 18 Jul 2023 18:01:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/8] btrfs: preparation patches for the incoming
 metadata folio conversion
Message-ID: <20230718160108.GQ20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689418958.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689418958.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 15, 2023 at 07:08:26PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Define write_extent_buffer_fsid/chunk_tree_uuid() as inline helpers
> 
> v3:
> - Fix an undefined behavior bug in memcpy_extent_buffer()
>   Unlike the name, memcpy_extent_buffer() needs to handle overlapping
>   ranges, thus it calls copy_pages() which do overlap checks and switch
>   to memmove() when needed.
> 
>   Here we introduce __write_extent_buffer() which allows us to switch
>   to go memmove() if needed.
> 
> - Also refactor memmove_extent_buffer()
>   Since we have __write_extent_buffer() which can go memmove(), it's
>   not hard to refactor memmove_extent_buffer().
> 
>   But there is still a pitfall that we have to handle double page
>   boundaries as the old behavior, explained in the last patch.
> 
> - Add selftests on extent buffer memory operations 
>   I have failed too many times refactoring memmove_extent_buffer(), the
>   wasted time should be a memorial for my stupidity.

Seems that v3 has proceeded up to btrfs/143 that prints a lot test
output errors and following tests fails too. It's on top of misc-next so
it could be caused by some other recent patch. I'll do another round, if
this patchset turns out to be ok I'll add it to misc-next.
