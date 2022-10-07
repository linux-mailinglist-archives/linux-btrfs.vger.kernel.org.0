Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5F5F7BD1
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJGQvc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJGQvb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 12:51:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F236198CAD
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 09:51:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A2BEE1F7AB;
        Fri,  7 Oct 2022 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665161489;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yPCyDrBebSC2R9Of45DPoVHmL23bbnQQYBVg/ro+FRQ=;
        b=NVhpgG+eIBI5w2Ua2xlf04tPhJPfD57bx8pDa24Ga6tL7EAY91bSm27h+P5DTRhlwstN2S
        Aeylpf3UFEPKCUkDQZkuTfYSh/9jeAkD/+n1Yse+kXsZ+IDfqmwc/XKMIRfR1MMgeZtv1O
        XFA3/pS/ukkeVLyh2SWW/t/lY55JQu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665161489;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yPCyDrBebSC2R9Of45DPoVHmL23bbnQQYBVg/ro+FRQ=;
        b=HzKxtgwaqL8y4Ldb2dJ7pX69/AmSDVQ1ff6RFamek+GHjO77LIkW4kdqSTcwa7eymAYW+w
        OliVy3bdmPfWDCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7199F13A3D;
        Fri,  7 Oct 2022 16:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A1bUGhFZQGNUTQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 16:51:29 +0000
Date:   Fri, 7 Oct 2022 18:51:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 01/17] btrfs: remove set/clear_pending_info helpers
Message-ID: <20221007165126.GV13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663167823.git.josef@toxicpanda.com>
 <1925067c136aec3e1a01af78dbee66b6b0ebcc26.1663167823.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1925067c136aec3e1a01af78dbee66b6b0ebcc26.1663167823.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 11:06:25AM -0400, Josef Bacik wrote:
> The last users of these helpers were removed in
> 
> 5297199a8bca ("btrfs: remove inode number cache feature")
> 
> so delete these helpers.

I've added a comment what was the purpose, basically for mount options
that must be applied during transaction commit, but we don't have any.
Patch can be reverted if needed.
