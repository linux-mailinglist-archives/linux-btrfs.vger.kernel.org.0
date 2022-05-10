Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A307521483
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbiEJMEA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241490AbiEJMD5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 08:03:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA1246163
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 04:59:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F3931F8B4;
        Tue, 10 May 2022 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652183997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nox7EplIAAxIcBifVm923X9In02lnWshxnyjo0NdBCE=;
        b=vRJIBN0Meqjc2c48OzmZXwBd99whj4VUaI8pz7TMJk2twhi9BZwKRe+wKSmC2Y4K0dzuWM
        NBGjHg3YhHc4uqxF8Ad8GA2l0PUvMX/epTaJ9jcdj6N3OnZK5m028PUNRAXgq9FGGlqx9i
        Wd32GhCWj2FOGh+E0hg/vRQyhhDhF7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652183997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nox7EplIAAxIcBifVm923X9In02lnWshxnyjo0NdBCE=;
        b=k+v5Srb7Ls2gv63WflW0rrBWd+QU1e7HQpxuF01BGLGzae9hXrIFQws/ssFkDhdGjs/Lqs
        QfF9Z5+ulFDSkzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BC8A13AA5;
        Tue, 10 May 2022 11:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pHp6Fb1TemIBegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 May 2022 11:59:57 +0000
Date:   Tue, 10 May 2022 13:55:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: allow defrag to convert inline extents to
 regular extents
Message-ID: <20220510115542.GM18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <0606709d439b711a767ce1491f51f0113326d265.1652097509.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0606709d439b711a767ce1491f51f0113326d265.1652097509.git.wqu@suse.com>
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

On Mon, May 09, 2022 at 08:00:53PM +0800, Qu Wenruo wrote:
> Btrfs defaults to max_inline=2K to make small writes inlined into
> metadata.
> 
> The default value is always a win, as even DUP/RAID1/RAID10 doubles the
> metadata usage, it should still cause less physical space used compared
> to a 4K regular extents.
> 
> But since the introduce of RAID1C3 and RAID1C4 it's no longer the case,
> users may find inlined extents causing too much space wasted, and want
> to convert those inlined extents back to regular extents.
> 
> Unfortunately defrag will unconditionally skip all inline extents, no
> matter if the user is trying to converting them back to regular extents.
> 
> So this patch will add a small exception for defrag_collect_targets() to
> allow defragging inline extents, if and only if the inlined extents are
> larger than max_inline, allowing users to convert them to regular ones.
> 
> This also allows us to defrag extents like the following:
> 
> 	item 6 key (257 EXTENT_DATA 0) itemoff 15794 itemsize 69
> 		generation 7 type 0 (inline)
> 		inline extent data size 48 ram_bytes 4096 compression 1 (zlib)
> 	item 7 key (257 EXTENT_DATA 4096) itemoff 15741 itemsize 53
> 		generation 7 type 1 (regular)
> 		extent data disk byte 13631488 nr 4096
> 		extent data offset 0 nr 16384 ram 16384
> 		extent compression 1 (zlib)
> 
> Previously we're unable to do any defrag, since the first extent is
> inlined, and the second one has no extent to merge.
> 
> Now we can defrag it to just one single extent, saving 48 bytes metadata
> space.
> 
> 	item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
> 		generation 8 type 1 (regular)
> 		extent data disk byte 13635584 nr 4096
> 		extent data offset 0 nr 20480 ram 20480
> 		extent compression 1 (zlib)
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Re-phase why we add the inline extent without checking @next_mergeable
> 
> - Add some commit message on the new ability to handle mixed inline and
>   regular extents

Added to misc-next, with the updated comment, thanks.
