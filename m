Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939346F84BE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjEEOUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjEEOUj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 10:20:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18834AB;
        Fri,  5 May 2023 07:20:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA52E22601;
        Fri,  5 May 2023 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683296437;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2U9Zoa3t3ahMmcgPfeGBAyyqFHKBknbXX4D537R3tLo=;
        b=fcoiVH2qUZrT9/1s0aUxK7oPri6YnjSBEhGkPE5Sz2936ST075aIFRL5Ag2gnGN9z/u9sM
        SUyC6wRASTYn6x4/NhpzI+nSpc0PamXrMTIbLtUbT8NEZYArq0etVn8YFBHjXROwrBQZXi
        y/ihMPHyNBxrBqdvXajomLAiX727ILo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683296437;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2U9Zoa3t3ahMmcgPfeGBAyyqFHKBknbXX4D537R3tLo=;
        b=tOFv6tivTUWU3wiG9pduegFASMUZsZS2gWVlciXG7pY/pl2n/akC5/2yAoHmhN4PHoEBnN
        CJtJnQX5bjahE8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F52C13513;
        Fri,  5 May 2023 14:20:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E4zNJbUQVWRfcAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 14:20:37 +0000
Date:   Fri, 5 May 2023 16:14:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tom Rix <trix@redhat.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace else-statement with initialization
Message-ID: <20230505141440.GQ6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230502145129.2927253-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502145129.2927253-1-trix@redhat.com>
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

On Tue, May 02, 2023 at 10:51:29AM -0400, Tom Rix wrote:
> A small optimization
> Move the default value of transid to its initialization
> and remove the else-statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Added to misc-next with minor updates, thanks.
