Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F669634022
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Nov 2022 16:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiKVP0Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Nov 2022 10:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKVP0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Nov 2022 10:26:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9ED5DBB1;
        Tue, 22 Nov 2022 07:26:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4883021F44;
        Tue, 22 Nov 2022 15:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669130780;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5GGE7FC0VbB9ME+IIY26UDo8Q/8t4dYyVs/bf50QXJc=;
        b=I3aeFRqRUnN2wMgV/xasqgLeSP1x8Z/ulzGWShP9nINc4tcJ0wrjhcx7zVdEqbx1+g1z9U
        Gwq6r15krk/L2NExIG94NJArgapusYM9anBKsutrGCO1bQXt7FBxjy+s4SJuArwZsDzZox
        Lcfe2p1csPxuJvr2F9ma226d1L59wVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669130780;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5GGE7FC0VbB9ME+IIY26UDo8Q/8t4dYyVs/bf50QXJc=;
        b=vHgDAT6ikewgH9hIhpgb8W7bSpmJwdgE8gXx+8dQyTzYAqqIsY93TfRROcSSpx+twIj3dr
        lZAannsW11a9kSDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 161AE13B01;
        Tue, 22 Nov 2022 15:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7SExBBzqfGOXFgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 22 Nov 2022 15:26:20 +0000
Date:   Tue, 22 Nov 2022 16:25:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: normalize the error handling branch in
 btrfs_init_sysfs()
Message-ID: <20221122152550.GF5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221122115002.1831-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122115002.1831-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 22, 2022 at 07:50:02PM +0800, Zhen Lei wrote:
> Although kset_unregister() can eventually remove all attribute files,
> explicitly rolling back with the matching function makes the code logic
> look clearer.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Added to misc-next, thanks.
