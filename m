Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8065B3C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 16:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjABPGj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 10:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbjABPGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 10:06:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D85939B;
        Mon,  2 Jan 2023 07:06:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E858C33F11;
        Mon,  2 Jan 2023 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672671995;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8eTw1IUC/ETma8kLogKVxuZ+NxAMhSjPQwm8x886wgM=;
        b=3U59PTFYHi9XTvZTXcffkbdzL3MLf8wJb/ZJftMqeiFHnbTIMzlqhmGlSkTnIM8+ULJNY+
        39JrmwT1Id5SnAbjhpb+1jdqany6tVPeOjOc5vYjf9nZjICq9/n+MkysrGNw8s/t3ub4FG
        NiNgI/16EzBiWKy247CQmN36y8p9aZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672671995;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8eTw1IUC/ETma8kLogKVxuZ+NxAMhSjPQwm8x886wgM=;
        b=pLp0h5XLOdP++dl5utGFSdJnqgVOWINgpTiUmd4sM9hYkAS5sRQQDM3IclcKZia+OazF9y
        4HqYotDXmZW4QGAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AECD113427;
        Mon,  2 Jan 2023 15:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q/7hKPvysmOVXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 15:06:35 +0000
Date:   Mon, 2 Jan 2023 16:01:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Tanmay Bhushan <007047221b@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix ASSERT of em->len when getting extent
Message-ID: <20230102150105.GE11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221231150501.123205-1-007047221b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231150501.123205-1-007047221b@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 31, 2022 at 04:05:01PM +0100, Tanmay Bhushan wrote:
> em->len is incorrectly asserted which is leading to it's
> assignment to sectorsize instead of being check for it.
> 
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>

Added to misc-next, thanks.
