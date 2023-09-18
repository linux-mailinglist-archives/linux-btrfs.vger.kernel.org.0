Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15387A50A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjIRRKW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 13:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjIRRKR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 13:10:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405B8EA
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 10:10:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D00B20024;
        Mon, 18 Sep 2023 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695057008;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4N1otqulnhnxRCHs2hOWge3+tid/y3vpzaidxc8I2uE=;
        b=MjkWT6wZ95OUWbzz6gd3Z25QjfcDFV6wknEUoBTXSqSOw6HSLg0iuqC4dbIbuu73PeYngg
        qosmBdxfDiN581rV4dqRHhmbbD1bvIWVzpd2Hqpepi7hjOsXfR5Kqj8tjJ807DMozsQO0l
        9fy47IHtel3LKNRXM+2BatHfQQXRK/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695057008;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4N1otqulnhnxRCHs2hOWge3+tid/y3vpzaidxc8I2uE=;
        b=PuHmKITlO6EFepGryVe+ToG+aTWUM//NPag20nifsWzuVz16aaITLI55OvAivGwuxFg6uT
        UlrcUUtFAa9Xm3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84CBA1358A;
        Mon, 18 Sep 2023 17:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AsqyH3CECGVJEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 17:10:08 +0000
Date:   Mon, 18 Sep 2023 19:03:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove the need_raid_map parameter from
 btrfs_map_block()
Message-ID: <20230918170332.GL2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d62c0ce7de28645ae2a416153c67b4146ae36ba0.1694945159.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d62c0ce7de28645ae2a416153c67b4146ae36ba0.1694945159.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 17, 2023 at 07:36:21PM +0930, Qu Wenruo wrote:
> The parameter @need_raid_map is mostly a legacy from the old days where
> we don't yet have a solid definition on the @mirror_num, and only
> check-integrity is still using that parameter, while all other call sites
> just pass 1 for that parameter.
> 
> Now since we have removed check-integrity functionality, we can also
> remove the @need_raid_map parameter.
> 
> This change would also remove the ability to read P/Q stripe directly
> when passing 0 as @need_raid_map.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
