Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB70D6196C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Nov 2022 14:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiKDNCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Nov 2022 09:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKDNCj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Nov 2022 09:02:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8C42E9C1
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Nov 2022 06:02:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5BF10219CA;
        Fri,  4 Nov 2022 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667566957;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCDfIRTmzLkEzjt/wG9qM16e5QlNVjr5+ozz5P+hhHQ=;
        b=v0TgA8YwvpYy+Vm9QNxeyfKVDFl1AzQRAfB690bMwDZDkL+LI0A9vmTZ6NYgA9jxGS9oFf
        YawEqusPH8QRYD3zGNfnvjNRbPC/yROeLvxUyDN+6pv9ph1CZ9CTzFlQay2qsgd15xRYT9
        DaDJhGJlzzfW6BsXf0gX41mxirqnfdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667566957;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCDfIRTmzLkEzjt/wG9qM16e5QlNVjr5+ozz5P+hhHQ=;
        b=XMcLXmOc8pNDHiD4CzU/hInwprFHlBSbmVVbqwKq+NfJWKSIB1VdjqhpPacxFfXZxMhTFX
        bN5SRRcTQa6z4nCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E7B913216;
        Fri,  4 Nov 2022 13:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AN1PDm0NZWN2egAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 04 Nov 2022 13:02:37 +0000
Date:   Fri, 4 Nov 2022 14:02:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: WARN_ON in __writeback_inodes_sb_nr when btrfs mounted with
 flushoncommit
Message-ID: <20221104130217.GQ5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221024041713.76aeff42@nvm>
 <20221024123746.7a9d9bfd@nvm>
 <20221024141629.GD5824@twin.jikos.cz>
 <20221025022343.4d979cb3@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025022343.4d979cb3@nvm>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 25, 2022 at 02:23:43AM +0500, Roman Mamedov wrote:
> On Mon, 24 Oct 2022 16:16:29 +0200
> David Sterba <dsterba@suse.cz> wrote:
> 
> > > But not backported to stable series, why not? Seems to be a small and simple
> > > fix.
> > 
> > 5.10 may still be a reasonable target for backport. It does not apply
> > cleanly and the 5.10 version tries to do some flushing of subvolume
> > trees, which was removed later on, there may be some dependencies too.
> 
> Sorry I meant the longterm series. The issue was reported starting with
> 4.15-rc1, so of these also 4.19 and 5.4 will be affected. Sure, those may or
> may not be as important or feasible for a backport, but at least 5.10
> hopefully is, as it is the current long-longterm supported until 2026 per the
> Releases page on kernel.org, 3 years further than 5.15.

Checking changes related to btrfs_start_delalloc_flush, 5.10 is doable,
there are correctness fixes that landed in 5.7 and there are like 2-3
patches that would have to be backported.
