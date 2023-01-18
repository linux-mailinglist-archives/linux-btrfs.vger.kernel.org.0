Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCA672916
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jan 2023 21:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjARUMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Jan 2023 15:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjARUMo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Jan 2023 15:12:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326AA4CE70
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jan 2023 12:12:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCCC633FC7;
        Wed, 18 Jan 2023 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674072759;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPo1VXwSZWTnp1c09MHnUh+FR64zxWamwIElhcwGQT4=;
        b=E60SPWQ3j7aJ6PCPv8fx3fUJzgxARbXbi5r58bo4Fi7aClWqAyYmcug06H0qQGq8YtoLw9
        OYPjD5n6pNgLy8pZWqk+xfqxO9eFpe1nEhtVt2bfXwooEc6ofJHnTF8SdO15j3ud/cyNeH
        zVvXCItlc6qhLV/4T6x99MbBgB4uSEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674072759;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPo1VXwSZWTnp1c09MHnUh+FR64zxWamwIElhcwGQT4=;
        b=PYmZzSfvU4aGXQMHCPkqXyRpHHeYecYK4fLX/rFO3XDqLph43O060LaJu54kfq9qS+WwXF
        Hq85PbZfiLQJiPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B16F6138FE;
        Wed, 18 Jan 2023 20:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9WU9KrdSyGMEFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 18 Jan 2023 20:12:39 +0000
Date:   Wed, 18 Jan 2023 21:07:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: docs: add entries to sysfs documentation
Message-ID: <20230118200701.GF11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230118074458.2985005-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118074458.2985005-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 18, 2023 at 04:44:55PM +0900, Naohiro Aota wrote:
> This series adds a description for per-space_info bg_reclaim_threshold
> and chunk_size. It also fixes a subtle typo.
> 
> Naohiro Aota (3):
>   btrfs-progs: docs: add per-space_info bg_reclaim_threshold entry
>   btrfs-progs: docs: fix nodesize typo
>   btrfs-progs: docs: add chunk_size description

Added to devel, thanks. For the bg_reclaim I've added that it can be
used for regular devices too.
