Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB287625E77
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 16:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiKKPgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 10:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKKPgo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 10:36:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8B063BA4
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 07:36:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 51304223AC;
        Fri, 11 Nov 2022 15:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668181001;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xotoeSSLrNtSiurtWHn4H9EgRnOeW0bVz351wiVWBKg=;
        b=0lv1vtNwoZ9vsVIely1TsroSKmsPWfbuItj0eQoJ2IWMI/XnmTkapL+Wh0ulG9zeG59t/e
        /Zx9Q4TzSF58RbTnJMnW6X8eoEL2O6Qqbzg5DP9ZdGH6kk70z4QmHAjSGK0NizeF1mFqSC
        erotq2G7D1cgPSKIFRS/LRP101n0Iio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668181001;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xotoeSSLrNtSiurtWHn4H9EgRnOeW0bVz351wiVWBKg=;
        b=JHrod39wNuojU0KCtgaK/qSNI6AqB5v44dinYceDbsT3Yls0JxM9wlCL8r9QoWgLJPdnfr
        5JtcoCgCbJzf7KBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3622613273;
        Fri, 11 Nov 2022 15:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G/UODAlsbmNGNwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 15:36:41 +0000
Date:   Fri, 11 Nov 2022 16:36:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: receive: address setattr failures
Message-ID: <20221111153617.GP5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667494221.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667494221.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 03, 2022 at 04:53:25PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> I was writing a test case for fstests with fsstress and send v2 streams
> and it turns out that receive will always fail if we have a fileattr
> command in the stream. It fails for two different reasons, described in
> the changelog.
> 
> We actually had a report today of a receiver failing on a send stream v2
> because of the reason addressed in the first patch. However fixing that
> alone, will still cause the receiver to fail, just for a different reason
> (patch 2).
> 
> For now I'll hold the test case for fstests since it fails very frequently
> (almost always actually).
> 
> Filipe Manana (2):
>   btrfs-progs: receive: fix parsing of attributes field from the fileattr command
>   btrfs-progs: receive: work around failure of fileattr commands

Added to devel, thanks.
