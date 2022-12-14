Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9364CDED
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 17:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbiLNQXs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 11:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiLNQXr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 11:23:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE79116E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 08:23:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84A2421E51;
        Wed, 14 Dec 2022 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671035025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGLUfETt3SdrwoE21ajjtHe08G54tg2w+ADTCc1tPSM=;
        b=ykcmek2lj6kiyYy6T2BAVkJMC0ydTLSX4oScnsHRE/cpflhyElhM3A7HwEhPt+o+ejxNgn
        qsgaUhqZgxwmrOXYcHYwsXF4fwUtZT6I/6iGjFwNr1o8yLvLPJYHr9qzrjkP3nzp6OWpQ2
        ID7ABBsewu3WEPthKrvsTCqGDpqLIQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671035025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGLUfETt3SdrwoE21ajjtHe08G54tg2w+ADTCc1tPSM=;
        b=CI5PkUDhIcVXHm0fbWbVhB+hpwuZ3k7TjXejxhJx/pMk1ok7iabSMOOnk7e09bKJJF6/Hn
        KF9pi3J1AoYPeDAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58112138F6;
        Wed, 14 Dec 2022 16:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T5GNFJH4mWMjaQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Dec 2022 16:23:45 +0000
Date:   Wed, 14 Dec 2022 17:23:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix event name typo for FLUSH_DELAYED_REFS
Message-ID: <20221214162302.GD10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3e38a3af59c41e8533803e5a4baba5eef3028da3.1670983501.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e38a3af59c41e8533803e5a4baba5eef3028da3.1670983501.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 14, 2022 at 11:06:07AM +0900, Naohiro Aota wrote:
> Fix a typo of printing FLUSH_DELAYED_REFS event in flush_space() as
> FLUSH_ELAYED_REFS.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
