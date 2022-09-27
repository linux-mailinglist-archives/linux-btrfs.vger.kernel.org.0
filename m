Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3435EC771
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Sep 2022 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiI0PTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Sep 2022 11:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiI0PTa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Sep 2022 11:19:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3397C14A7BD
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Sep 2022 08:19:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D663F1F896;
        Tue, 27 Sep 2022 15:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664291966;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/20HeCaJXPo7EFtwqAvCDELQnCm3GvtHg/J7cBiE2E=;
        b=SyY1FsDBwZPRFMCWECcMo7hN1hGvepSkl75GUTwRCag9kHu+5cC0DmME9dHCQgAE7kZ6vQ
        JUkx+e5EHVytmQf/TZ+XzjptR1xGhXRTAZVzm2Q7d3SIEtr11xDnUXsNWuxdqoaDPnrjwx
        XI/RUdt+BOJOfc4MSi6QDTyAD1GoPFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664291966;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/20HeCaJXPo7EFtwqAvCDELQnCm3GvtHg/J7cBiE2E=;
        b=D2i0qBNxMtp/a62MtC89MYKEob4tAMPXkCodGDKU1eG5IWdwc8UzmxmZzgFstInaGHQkXs
        c3eO8WQ1dIXQ1kBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DA37139BE;
        Tue, 27 Sep 2022 15:19:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id slb3JH4UM2NeVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 27 Sep 2022 15:19:26 +0000
Date:   Tue, 27 Sep 2022 17:13:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: enhance error handling for metadata
 writeback
Message-ID: <20220927151351.GD13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663934243.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663934243.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 07:59:43PM +0800, Qu Wenruo wrote:
> Christoph Anton Mitterer reported a crash if we try to call "btrfs check
> --clear-space-cache v2" on a block device which is set read-only by
> "blockdev --setro".
> 
> For such blockdevice, open() with O_RDWR won't report error immediately,
> but only return error when we write to do any writes.
> 
> So what we can do is to enhance the error handling of metadata writeback
> during transaction commit.
> 
> The first 2 patches are cleanups/fixes I exposed during the development.
> The last one is the main disk for the fix.
> 
> Qu Wenruo (3):
>   btrfs-progs: remove unused function extent_io_tree_init_cache_max()
>   btrfs-progs: remove duplicated leakde extent buffer reporst
>   btrfs-progs: properly handle write error when writing back tree blocks

Added to devel, thanks.
