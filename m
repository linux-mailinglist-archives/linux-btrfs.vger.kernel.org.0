Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB657D5DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 23:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiGUVYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 17:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiGUVYa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 17:24:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683BC9284C
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 14:24:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D606933F20;
        Thu, 21 Jul 2022 21:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658438667;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/hPNCP2egFTQsYPned5ZnyhFD/+Axwh6B4YuiCRs6c=;
        b=GCOvQ0qeUprCQdVaQGqvfqF3hx8d4I6XHa4AwgXLI2SWEX1lEekEvCO9dTQQWbZPxk3Tvg
        vnrb+xuTNcdeuOXL+FssU2lVP7RGsHoO0StOQqLaAx/LscBvgfnly7+4SY4+Pss/LyWR4t
        T/5II2ctsAgwgFY8Zs3/UWAtzA77iyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658438667;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/hPNCP2egFTQsYPned5ZnyhFD/+Axwh6B4YuiCRs6c=;
        b=tPurRJrJFe8m0WtP+Hb6cq6yXsB64t5PBdvnG0uiFrW4miF0GPDYePH/t4CxQaudmgPVQD
        pYyNt2431ddKv7Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1F7E13A89;
        Thu, 21 Jul 2022 21:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b94kKgvE2WLvYAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 21 Jul 2022 21:24:27 +0000
Date:   Thu, 21 Jul 2022 23:19:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS online manual , search function is not working
Message-ID: <20220721211932.GW13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, waxhead <waxhead@dirtcellar.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <237fa9e9-af23-b71f-f3fa-3ef8375116b1@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <237fa9e9-af23-b71f-f3fa-3ef8375116b1@dirtcellar.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 21, 2022 at 09:42:34PM +0200, waxhead wrote:
> Howdy,
> 
> Searching for stuff on the manual pages on readthedocs.io does not work 
> on browsers based on older code such as SeaMonkey 2.53.13
> 
> Works fine in chromium so this must be some of the chromeifying things 
> that happens more and more across the web. This is a bit like the dark 
> ages when things required IE on a certain nasty  platform.
> 
> Perhaps another platform is better suited for manuals? After all it is 
> "only text" so why make it difficult?
> 
> https://btrfs.readthedocs.io/en/latest/search.html?q=compression&check_keywords=yes&area=default#

I'm using firefox and this works for me. I've installed seamonkey and
it does not find any pages. I think you'd need to direct this to the
readthedocs site, we could insert CSS or maybe javascript code but the
documentation engine is sphinx, limited options on the btrfs-progs side.

If you have tips for other sites that could publish the RST, I can do
that, automatically if it can pull from git or manually if needed.
