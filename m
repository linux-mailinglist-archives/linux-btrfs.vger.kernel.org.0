Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E707A226A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjIOPby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjIOPbq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 11:31:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B3898
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 08:31:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4406D1FD73;
        Fri, 15 Sep 2023 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694791900;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRsfG+yXR4Xwvv687bxpWWvhwE4MPiekgyu7sAXIOv4=;
        b=g7zU/9QbFjmkkRyFAKwNrXFiPAhBPdcsHohQe6qlN35iAdALOqht1SP1z5AxXk1eZEAuiO
        zx0uSE7ixQBzJoif2xVqVZrN7zOwJDWdUbImFcafCqvwaGInvVqRoxStugOJjtrXdJoYGy
        nVjptFpWBY+LDPTiMmqTTaTCpyn8264=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694791900;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRsfG+yXR4Xwvv687bxpWWvhwE4MPiekgyu7sAXIOv4=;
        b=x+4Y/rI7mG9DTqUhKpejef0U+ezg0VlsNK9HpII64zaiD+25yXoqZFgUt6ZwlCfLcK5pET
        j8LL6QXRjY8+P9Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 221381358A;
        Fri, 15 Sep 2023 15:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cMNqB9x4BGUrHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 15 Sep 2023 15:31:40 +0000
Date:   Fri, 15 Sep 2023 17:25:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] btrfs: fix 64bit division in
 btrfs_insert_striped_mirrored_raid_extents
Message-ID: <20230915152506.GE2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d1aa8b4fdead6f1e470f22b3986c1001abf33caf.1694773341.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1aa8b4fdead6f1e470f22b3986c1001abf33caf.1694773341.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 15, 2023 at 03:23:11AM -0700, Johannes Thumshirn wrote:
> Fix modpost error due to 64bit division on 32bit systems in
> btrfs_insert_striped_mirrored_raid_extents.
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Folded to the patch, thanks.
