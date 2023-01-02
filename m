Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463B065B282
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 14:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjABNHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 08:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjABNHx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 08:07:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305103898
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Jan 2023 05:07:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B0B4C21E99;
        Mon,  2 Jan 2023 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672664871;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y2cN8JsXiYKzfkBy/c4+fC2rdD1H/Zd3fdMAMcog1dc=;
        b=b8e2beGlytQnMrviWBqq4Jfqt8KRdKeSr7kGi4xxkYk94tjzpo27hErM9JuvAZ5fIeqibr
        k8YMaXlezR7juN4gMXzI3Ao+EJtWAvKZ55pfRosMgMFTc1PcHEeCNDHcRPhQMezktfByt3
        pbfn7BAcZSocCOE0RHWIccT1WxcDFJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672664871;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y2cN8JsXiYKzfkBy/c4+fC2rdD1H/Zd3fdMAMcog1dc=;
        b=lFsilZmh/GbhUxuSDjPEHT2YAYbcxIZ3ecdY3/zHtAHHjgKtoDOez0XgYDmzLeMEC+dQ72
        BMafYrUc7PkEfwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96E3213427;
        Mon,  2 Jan 2023 13:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HFT1IyfXsmNLJAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 13:07:51 +0000
Date:   Mon, 2 Jan 2023 14:02:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: fix the uuid report in "btrfs subvolume
 list -u"
Message-ID: <20230102130221.GC11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1672120480.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1672120480.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 27, 2022 at 01:55:06PM +0800, Qu Wenruo wrote:
> There is a regression caused by commit d729048be6ef ("btrfs-progs: stop
> using btrfs_root_item_v0").
> 
> Just fix it and add a simple test case for it.
> 
> Qu Wenruo (2):
>   btrfs-progs: fix the wrong timestamp and UUID check for root items
>   btrfs-progs: misc-tests: add a test case to make sure uuid is
>     correctly  reported

Added to devel, thanks.
