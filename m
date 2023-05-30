Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805AA716CFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjE3TAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjE3TAf (ORCPT
        <rfc822;Linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 15:00:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F7F9
        for <Linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 12:00:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58F741F37F;
        Tue, 30 May 2023 19:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685473222;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5HrlVUmLMQZ1CsQTWz6UONyoKiyskIFNWDhfgEp0zKQ=;
        b=HiISQldAYmdX32E8lrJti2ym4em2MLYC3VozGl02CdlRt68Xjwt0+AxhijUV/nvTfm96z5
        sO7nxVnUUypa32Ecw5/zU9mw5vNCCO1bvS/UDvi/jqfbApFfiNP5FXHkBpPZGxLruC0zL6
        Y8rMXXnOm9OHuCsdEO1nxQ8X2URqEqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685473222;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5HrlVUmLMQZ1CsQTWz6UONyoKiyskIFNWDhfgEp0zKQ=;
        b=pIe4KUgVvoZUdS7wL1ksXbsJI7OlkZWA6lEWoHRoboViExtmRO7GH5QpWl+tYqR4GgvnsC
        Z+aKTHvQmNWC5OCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DEEC13597;
        Tue, 30 May 2023 19:00:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0yJXDsZHdmQbewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 19:00:22 +0000
Date:   Tue, 30 May 2023 20:54:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Phillip Duncan <turtlekernelsanders@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tests: fix formatting in btrfs-tests
Message-ID: <20230530185411.GD32581@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ZHVLLpTHRvifOIHP@flip-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHVLLpTHRvifOIHP@flip-desktop>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 29, 2023 at 06:02:38PM -0700, Phillip Duncan wrote:
> checkpatch.pl had a couple of formatting suggestions:
> - #38: Don't use multiple blank lines
> - #42: Missing a blank line after declarations
> - #282: Alignment should match open parenthesis
> 
> Fixed these format suggestions, checkpatch.pl is a little cleaner now.

Please don't send such patches, or at least not to btrfs. A more
elaborate answer:

https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#how-not-to-start
