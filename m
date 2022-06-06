Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A57053EAE5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiFFOjX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 10:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbiFFOjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 10:39:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A221DFD37E
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 07:39:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B21F21A1E;
        Mon,  6 Jun 2022 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654526357;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3mhOs5XOk7tBhrJx8LL1ji+cpKSbRdjmGLlS9UaqT0=;
        b=FXpzppBoxrwUShWww4YIUMqwiLAn8NQ8UPoiM+xlGG8xdPl80iGrvTP3Z93bAz6TwYR6zD
        NT1nddhfOG1QlTUD2jzUS46QB2X9xPw946DFVtbeSfAE/+VeFckLYV3x3Vy9NOP8g9RUN5
        Z6IHt6RtyTE74ssH9N/7PcZ4UrxujLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654526357;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3mhOs5XOk7tBhrJx8LL1ji+cpKSbRdjmGLlS9UaqT0=;
        b=ChBbyjWhJ+kNk3gm5ZbBCPfNK0uW5Xo7Aynl7Yk/DIWqpJ3xYTpEv2o2YrYHzYCwF+AtFb
        4zoHkugtM9oye0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39C91139F5;
        Mon,  6 Jun 2022 14:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UVLODJURnmJEZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Jun 2022 14:39:17 +0000
Date:   Mon, 6 Jun 2022 16:34:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     =?iso-8859-1?Q?Torbj=F6rn?= Jansson <torbjorn@jansson.tech>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs-convert aborts with an assert
Message-ID: <20220606143448.GC20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?iso-8859-1?Q?Torbj=F6rn?= Jansson <torbjorn@jansson.tech>,
        linux-btrfs@vger.kernel.org
References: <023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 06, 2022 at 04:03:33PM +0200, Torbjörn Jansson wrote:
> Hello
> 
> i tried to do a btrfs-convert of a ext4 filesystem and after a short while 
> after starting it i was greeted with:
> 
> # btrfs-convert /dev/xxxx
> btrfs-convert from btrfs-progs v5.16.2
> 
> convert/main.c:1162: do_convert: Assertion `cctx.total_bytes != 0` failed, value 0
> btrfs-convert(+0xffb0)[0x557defdabfb0]
> btrfs-convert(main+0x6c5)[0x557defdaa125]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f66e1f8bd0a]
> btrfs-convert(_start+0x2a)[0x557defdab52a]
> Aborted

Please open an issue on github, thanks.

> Any idea whats going on?
> Is it a known bug?
> Is the btrfs-progs that come with my dist too old?

Two versions back is not that old, but there are bugfixes in each
release, so it's better to stay up to date.

> FYI the ext4 filesystem is a bit large ~10tb of used data on it.

This looks similar to another issue that caused weird checksum errors
(but no problems during conversion).
https://github.com/kdave/btrfs-progs/issues/349 the common point here is
thatt it's 2TB and a multiple in your case.

> I assume the convert didn't even start in this case and nothing was modified on 
> the ext4 filesystem, correct? or?

Yeah, until the conversion is completely finished without errors, the
old ext4 is left intact and the new partial btrfs structures are not
recognized as a valid filesystem.
