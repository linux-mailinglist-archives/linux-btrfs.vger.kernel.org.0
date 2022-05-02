Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6393D51769D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386922AbiEBSjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386977AbiEBSjD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 14:39:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4265EB
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 11:35:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E6F2210E7;
        Mon,  2 May 2022 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651516532;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmvM5JZOR3v387fUfhmrH6HA/JE6fHDG/FZabcLSkY0=;
        b=X1xKvJqOGU4Vr7suLek/9kzTZNzgTtUyV5LWM8jDH/KKlfordTaa7vbvbd4sg97Rbchpvx
        9F4sTDFUkz/WwBE2CzGGgk5TEcEin4JI52D5z+27CagpZxC+LV7uHUd93IqcCmHRtKDzH/
        X5EZuyPnVIVjrQH6NdXgC/BF3j8Q8xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651516532;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmvM5JZOR3v387fUfhmrH6HA/JE6fHDG/FZabcLSkY0=;
        b=dbNGcaE7/2l73IQwnEUq/VFwPlewpRqePrE8Thd7jPc/6A97OEe+5vh4nj/+IMRGW5Kf/G
        +owhd8NaKGNEL/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2247213491;
        Mon,  2 May 2022 18:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q2RlB3QkcGJcHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 May 2022 18:35:32 +0000
Date:   Mon, 2 May 2022 20:31:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] btrfs: improve error reporting in
 lookup_inline_extent_backref
Message-ID: <20220502183121.GM18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220429141734.866132-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429141734.866132-1-nborisov@suse.com>
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

On Fri, Apr 29, 2022 at 05:17:34PM +0300, Nikolay Borisov wrote:
> When iterating the backrefs in an extent item if the ptr to the
> 'current' backref record goes beyond the extent item a warning is
> generated and -ENOENT is returned. However what's more appropriate to
> debug such cases would be to return EUCLEAN and also print identifying
> information about the performed search as well as the current content of
> the leaf containing the possibly corrupted extent item.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> V5:
>  * Stop printing the key we are searching for as it was both wrong and redundant,
>  since we have the slot number printed anyway. (Filipe)

Added to misc-next, thanks.
