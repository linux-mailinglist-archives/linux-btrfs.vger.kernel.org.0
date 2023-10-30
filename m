Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE9A7DBB7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 15:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjJ3ONs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjJ3ONr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 10:13:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737EEC0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 07:13:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 357F71FE71;
        Mon, 30 Oct 2023 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698675224;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qlf9Gc9Dz5lT47B6WXyZc+j5287dKUOZMxo3VvySM4g=;
        b=sm1yRXpG2ChigiMdBHeFMbt9jmGMm6GdOzC2v16NO8jr+3h54MnXt2/MCoi2OA/a0qUAXo
        CxDXVtMBkiV9qyIpdP2+tdc+mAmH1ZsZlAj1IZ7GPiQx02ddCKubPyv49M8MIkYbYtHy6/
        hRONf7iUPSuhaBXRlruAApoiMr8PU+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698675224;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qlf9Gc9Dz5lT47B6WXyZc+j5287dKUOZMxo3VvySM4g=;
        b=h1P6k+EQrYRsBJaSFzJMwwmzB8jCoAVCv7p+1Ej1uq7vthp3xeh1jyUXXFjVIuFoX3ylff
        qaERTRfg64CsUkAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EA12138F8;
        Mon, 30 Oct 2023 14:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dFe7Ahi6P2WcNwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 30 Oct 2023 14:13:44 +0000
Date:   Mon, 30 Oct 2023 15:06:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: remove unused functions
Message-ID: <20231030140646.GB21328@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d4d0bb2c6fb0ad0a3666e9e0a78e432634f58a0d.1698452036.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d0bb2c6fb0ad0a3666e9e0a78e432634f58a0d.1698452036.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 28, 2023 at 10:43:59AM +1030, Qu Wenruo wrote:
> When compiling with clang 16.0.6, there are the following unused
> functions get reported.
> 
> - memmove_leaf_data()
> - copy_leaf_data()
> - memmove_leaf_items()
> - copy_leaf_items()
>   Those are replaced by memmove/memcopy_extent_buffer().
>   Thus they can be removed safely.

The files in kernel-shared directory could have unused functions due to
the file-to-file sync, so as long as the function exists in kernel then
it should say in progs too. I was looking for some linker tricks to
remove them from the final binary, but the resulting binaries increased
the size (it's either function sections with garbage collection or LTO).

The warnings could be suppressed on a case by case basis by some
function attribute like __maybe_unused eventually.

> - btrfs_inode_combine_flags()
>   This is only utilized by kernel for vfs inode structure, meanwhile
>   it's totally unused in progs as we don't have inode structure at all.
>   Thus it can be removed safely.

Yeah same, if it's in kernel then it should stay.

> - LOADU64() from blake2b-avx2.c
>   This is only utilized by the fallback implementation of
>   DECLARE_MESSAGE_WORD().
>   We can move it it just before the fallback implementation.

Ok.
