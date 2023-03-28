Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BC96CCA1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 20:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjC1SkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjC1SkK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 14:40:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B63212B
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 11:40:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42F89219DC;
        Tue, 28 Mar 2023 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680028806;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rijyeZGK5Dz28WmmO+UBWgJl33D/J4h0WS2p/K0cpvU=;
        b=nQwgTNxc5kpeglKbhaL2qnNM2iWw9N7KFMCkD5HPGHMfGIuy9F+BRv5iO6t8Jt1aPd1xoN
        qk7cyLmUnNfYJ5Ey2jlFOzo3kR+D00RKzA+3qqfy/bzZ1BTH3K2JWL8LZuHFWYU1pdODXu
        /NryKxk0xi61usFW6AquPG9//ZNv7Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680028806;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rijyeZGK5Dz28WmmO+UBWgJl33D/J4h0WS2p/K0cpvU=;
        b=Mo26bVfDl7mFcHLoZPJ2+syij0oMx6CqogqeOhuiEJckVpwyCNIHc//RDEBQvWFNTJcjFI
        IhjWWr5GKiGqCaDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B62E1390B;
        Tue, 28 Mar 2023 18:40:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EdDlBYY0I2SnegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 28 Mar 2023 18:40:06 +0000
Date:   Tue, 28 Mar 2023 20:33:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: use test_and_clear_bit() in wait_dev_flush()
Message-ID: <20230328183352.GP10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679910087.git.anand.jain@oracle.com>
 <7baf74b071f9d9002d2543cfc4f86bd3ddf7127f.1679910088.git.anand.jain@oracle.com>
 <20230327171427.GI10580@twin.jikos.cz>
 <4eba5d17-ba03-46b6-a936-1d9a9bc55960@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eba5d17-ba03-46b6-a936-1d9a9bc55960@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 01:05:12PM +0800, Anand Jain wrote:
> 
> 
> On 3/28/23 01:14, David Sterba wrote:
> > On Mon, Mar 27, 2023 at 05:53:10PM +0800, Anand Jain wrote:
> >> The function wait_dev_flush() tests for the BTRFS_DEV_STATE_FLUSH_SENT
> >> bit and then clears it separately. Instead, use test_and_clear_bit().
> > 
> > But why would we need to do it like that? The write and wait are
> > executed in one thread so we don't need atomic change to the status and
> > thus a separate set/test/clear bit are fine. If not, then please
> > explain. Thanks.
> 
> It's true that atomic test_and_clear_bit() isn't necessary in this case.
> Nonetheless, using it have benefits such as cleaner code and improved
> efficiency[1].
> 
>   [1]. I was curious, so I made wait_dev_flush() non-inline and checked
>   the ASM code for wait_dev_flush(). After the patch, there were 8 fewer
>   instructions.
> 
> I'm okay with dropping this patch if you prefer to maintain the correct
> usage of test_and_clear_bit().

Fewer instructions is a bonus here, but from the logic POV a test_bit in
a condition immediately followed by a clear_bit is not a common
pattern.  So even if we don't need the atomic semantics it's following a
common pattern which is good.
