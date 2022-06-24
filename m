Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FEE559E8A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiFXQ0E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiFXQZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 12:25:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DB66802F
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 09:25:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E576721A92;
        Fri, 24 Jun 2022 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656087940;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ifdyk4t9iCHmnKJsO+bIDHsij/xKxr/8k6EfPQ7usvg=;
        b=kNoVdaxWHZGKLC2orEloLDgIVywdW2h/iwZIpQhDVOtkkY4FhlqWQeq85PFgSVWcABtzvn
        hucF+A/I0oOGdp4bTQjacQ2uDXXNiYQTkZ7vT0iBcYX5CdDULttWMgRQ1QdQBZsLZXqVV3
        TCqlgkH/8W00gwrl/3A0/fMr1m/0lkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656087940;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ifdyk4t9iCHmnKJsO+bIDHsij/xKxr/8k6EfPQ7usvg=;
        b=035b5jZFvWNKhembcXQyqlLVwLBexlSncX8B1MqQh89niDV7WogEX3HATdNYkDb2z8P67x
        VFPMpxYSxJNQsmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB56D13ACA;
        Fri, 24 Jun 2022 16:25:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mkC7MITltWKcVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 24 Jun 2022 16:25:40 +0000
Date:   Fri, 24 Jun 2022 18:21:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove skinny extent verbose message
Message-ID: <20220624162101.GY20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220623080858.1433010-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623080858.1433010-1-nborisov@suse.com>
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

On Thu, Jun 23, 2022 at 11:08:58AM +0300, Nikolay Borisov wrote:
> Skinny extents have been a default mkfs feature since version 3.18 i
> (introduced in btrfs-progs commit 6715de04d9a7 ("btrfs-progs: mkfs:
> make skinny-metadata default") ). It really doesn't bring any value to
> users to simply remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---

Added to misc-next, thanks.
