Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5557DCDF8
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 14:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbjJaNgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 09:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344596AbjJaNgn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 09:36:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD18FD
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 06:36:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7BED61F749;
        Tue, 31 Oct 2023 13:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698759398;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQnqKWMV1mI38Lz0UTEhqKEvk8TKu/ynos9HHVxiA4w=;
        b=XoIFMTVLjLFraGoZDFY88tzarfkVnpK9VycwJJZVVGbrreJRIUBCjK6RtYpwQ1Xt/O1PiH
        fTg9HslKAZyHOtvKdRbOji70HQnJOuus1FqFPYI+bS4Fw/jMwG5V9OoGAZi+ryW/GTqq5v
        FZlSbX2+bH+1J1qugBHDXcCy7izSmcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698759398;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQnqKWMV1mI38Lz0UTEhqKEvk8TKu/ynos9HHVxiA4w=;
        b=2nAGeXhwCXRRZ5QLJrV4OXZ6QDErcivSf0oxqroG9KEkaZ+YS162fslxVdQJfGSJS0JSQm
        7gPuLPFlaEArwSBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5931613AA5;
        Tue, 31 Oct 2023 13:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z3sEFeYCQWVodQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 31 Oct 2023 13:36:38 +0000
Date:   Tue, 31 Oct 2023 14:29:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: remove unused functions
Message-ID: <20231031132940.GB11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d4d0bb2c6fb0ad0a3666e9e0a78e432634f58a0d.1698452036.git.wqu@suse.com>
 <20231030140646.GB21328@twin.jikos.cz>
 <61029842-ad3d-4561-9493-bc042f254809@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61029842-ad3d-4561-9493-bc042f254809@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 31, 2023 at 06:51:08AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/10/31 00:36, David Sterba wrote:
> > On Sat, Oct 28, 2023 at 10:43:59AM +1030, Qu Wenruo wrote:
> >> When compiling with clang 16.0.6, there are the following unused
> >> functions get reported.
> >>
> >> - memmove_leaf_data()
> >> - copy_leaf_data()
> >> - memmove_leaf_items()
> >> - copy_leaf_items()
> >>    Those are replaced by memmove/memcopy_extent_buffer().
> >>    Thus they can be removed safely.
> > 
> > The files in kernel-shared directory could have unused functions due to
> > the file-to-file sync, so as long as the function exists in kernel then
> > it should say in progs too. I was looking for some linker tricks to
> > remove them from the final binary, but the resulting binaries increased
> > the size (it's either function sections with garbage collection or LTO).
> > 
> > The warnings could be suppressed on a case by case basis by some
> > function attribute like __maybe_unused eventually.
> 
> Indeed, I forgot they can be synced from kernel.
> 
> But at the same time, I can also argue that, if they are not utilized at 
> all, there is no need to sync them at the moment.

Yeah, sort of. Files in kernel with a counterpart in progs should be
synced even with some unused functions. We can potentially add
__KERNEL__ ifdefs around bigger chunks of code if needed. Completely
unused files don't make much sense, I tried that last week and then
deleted the commits.
