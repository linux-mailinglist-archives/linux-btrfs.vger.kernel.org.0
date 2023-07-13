Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F68752104
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 14:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjGMMQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 08:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjGMMQl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 08:16:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B955D2698
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 05:16:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 882C01FDAF;
        Thu, 13 Jul 2023 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689250571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eyy3sZ0N0uyAwcc6Kf6r5uY1E/1zndvsM7V/mwxcd70=;
        b=28/Xv95sJ8WBMp1u1pqgMiPz1JstIKxwomt6jVlBODr6/9EfkqkgYGpSg3PJlOXv5qiZbQ
        k7ozu1wfu07ueRzmb6usrLgqWbaM4oyD1dx5W1QmF1KqCzySI4Ajp+9PYYrHq3tbJjeMvn
        bmCA+xjM50zcTukjvYj0mbTTnGDAd1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689250571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eyy3sZ0N0uyAwcc6Kf6r5uY1E/1zndvsM7V/mwxcd70=;
        b=FMC2DdK+OFlGRzGBqJunsHkf6d7KBm4QUQcBDzm6sXjhfYTS6CrooUzw5fJ5xy/OXSbPtY
        kVcjl9jyyGoqqnBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60858133D6;
        Thu, 13 Jul 2023 12:16:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mjnbFgvrr2QYJgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 12:16:11 +0000
Date:   Thu, 13 Jul 2023 14:09:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Message-ID: <20230713120935.GU30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689143654.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689143654.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 12, 2023 at 02:37:40PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Define write_extent_buffer_fsid/chunk_tree_uuid() as inline helpers
> 
> [BACKGROUND]
> 
> Recently I'm checking on the feasibility on converting metadata handling
> to go a folio based solution.
> 
> The best part of using a single folio for metadata is, we can get rid of
> the complexity of cross-page handling, everything would be just a single
> memory operation on a continuous memory range.
> 
> [PITFALLS]
> 
> One of the biggest problem for metadata folio conversion is, we still
> need the current page based solution (or folios with order 0) as a
> fallback solution when we can not get a high order folio.
> 
> In that case, there would be a hell to handle the four different
> combinations (folio/folio, folio/page, page/folio, page/page) for extent
> buffer helpers involving two extent buffers.
> 
> Although there are some new ideas on how to handle metadata memory (e.g.
> go full vmallocated memory), reducing the open-coded memory handling for
> metadata should always be a good start point.
> 
> [OBJECTIVE]
> 
> So this patchset is the preparation to reduce direct page operations for
> metadata.
> 
> The patchset would do this mostly by concentrating the operations to use
> the common helper, write_extent_buffer() and read_extent_buffer().
> 
> For bitmap operations it's much complex, thus this patchset refactor it
> completely to go a 3 part solution:
> 
> - Handle the first byte
> - Handle the byte aligned ranges
> - Handle the last byte
> 
> This needs more complex testing (which I failed several times during
> development) to prevent regression.
> 
> Finally there is only one function which can not be properly migrated,
> memmove_extent_buffer(), which has to use memmove() calls, thus must go
> per-page mapping handling.
> 
> Thankfully if we go folio in the end, the folio based handling would
> just be a single memmove(), thus it won't be too much burden.
> 
> 
> Qu Wenruo (6):
>   btrfs: tests: enhance extent buffer bitmap tests
>   btrfs: refactor extent buffer bitmaps operations
>   btrfs: use write_extent_buffer() to implement
>     write_extent_buffer_*id()
>   btrfs: refactor memcpy_extent_buffer()
>   btrfs: refactor copy_extent_buffer_full()
>   btrfs: call copy_extent_buffer_full() inside
>     btrfs_clone_extent_buffer()

Added to misc-next, with some fixups, thanks. How far we'll get with the
folio conversions or other page contiguous improvements depends but this
patchset is fairly independent.
