Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5188E6525EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 19:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiLTSED (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 13:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiLTSDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 13:03:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E99183A6
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 10:03:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 733724D60D;
        Tue, 20 Dec 2022 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671559431;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5f+GV/5CsLJE/MAEFTwucev+FNuvYRbsQgE+NrLHHgQ=;
        b=S/J1ZyW2MePfAE2+O8lK0P5o0tkErLxIc6pXizNowOshcKaFT9TLvpKxJjEHSgNH2E4/qQ
        9QfgBOImUGQgp0Ai+5Q5J5onR+dZZiQmqI6xUmUFqkwr31wsJbHB3u991ELnVzRKBs+Nly
        sfZBmqcIFbvYHjUl6ziCBvZTVBWdcqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671559431;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5f+GV/5CsLJE/MAEFTwucev+FNuvYRbsQgE+NrLHHgQ=;
        b=DJLUlIPHYd122ybGdq6GJeLyOhUhtUxo4VWpwxMRtgulM1qMVMB0l3CsXuii7JpnPy7Cll
        KBvwVhGlM01OPRBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41ED51390E;
        Tue, 20 Dec 2022 18:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5pp+Dgf5oWMPGwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Dec 2022 18:03:51 +0000
Date:   Tue, 20 Dec 2022 19:03:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix uninitialized return value in raid56 scrub
 code
Message-ID: <20221220180305.GL10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <df5b246d7aa5c8eb382b1e06c7bcf7a7f2fd9d59.1671209272.git.josef@toxicpanda.com>
 <4b75ddb6-b53f-810f-3b59-347a91fa96f2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b75ddb6-b53f-810f-3b59-347a91fa96f2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 17, 2022 at 07:51:10AM +0800, Qu Wenruo wrote:
> Maybe something config or toolchain setup is setting all stack values to 
> zero here?

This is a sanitization that the compiler might do but it would still warn
about the uninitialized variable.
