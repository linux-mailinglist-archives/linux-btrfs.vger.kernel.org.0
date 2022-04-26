Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF151060C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 19:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349439AbiDZR7r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 13:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiDZR7m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 13:59:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E939F46B05
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 10:56:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A5DE2210EC;
        Tue, 26 Apr 2022 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650995792;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qP4u/gh5+NM1VuluxrS+d7xovWy5jdJ3/Wn2MKzyxA=;
        b=NtWryOj8wPfIGzcWnufmdupQCpt5kBLmob07/IjxJDKdBIF/aVcNj/o6Hp2zKFKeREnjG8
        Q4GmexgmAFS/EfiS6lbbQr9K/AsinnfZr2e9DSV5H+PTcyDMqoUoixVx32qlgIEKW49Oky
        zqGnaejNk8tqrd7mO4FUrmY6MBtWlkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650995792;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qP4u/gh5+NM1VuluxrS+d7xovWy5jdJ3/Wn2MKzyxA=;
        b=9PbUkuJnLmqaW4LrbOHrRfLSqFI3iR3y5YvTHohCc9iXcGndCx5vEKKi/R0Dp/rWFn+A6B
        BkKICBLVCsfYFoBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 805F313AD5;
        Tue, 26 Apr 2022 17:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lJVUHlAyaGKoJAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Apr 2022 17:56:32 +0000
Date:   Tue, 26 Apr 2022 19:52:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH v5] btrfs: Turn delayed_nodes_tree into an XArray
Message-ID: <20220426175225.GX18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <20220419155721.6702-1-gniebler@suse.com>
 <9a8d4a62-8ca9-9ee3-2d94-8094428dd182@suse.com>
 <70c5e257-55d7-ff0a-8b6b-1051734aa1d5@suse.com>
 <c1cfd599-b730-c96a-c4f3-06de77c2c1bf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1cfd599-b730-c96a-c4f3-06de77c2c1bf@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 26, 2022 at 10:40:39AM +0300, Nikolay Borisov wrote:
> 2. The kernel now moved to using -std=gnu11 (starting with e8c07082a810 
> ("Kbuild: move to -std=gnu11"))  meaning variables can now be defined 
> inside for() loop bodies like:
> 
> for (int i = 0; i < n; i++)
> 
> IMO it would be good if we gradually start moving code to using this.

OK, I'm not aware of any problems we'd run into, the minimum compiler
version is old enough for all who care and fixups to change it back to
pre-C11 is easy.

We'd have to select a subset of the allowed features as not all of them
are free of controversy. The variable definition inside for() is OK.
