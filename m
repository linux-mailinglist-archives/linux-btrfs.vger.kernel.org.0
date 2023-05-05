Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504FB6F84E0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjEEObF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjEEObC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 10:31:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFDE16359
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 07:30:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86D542186C;
        Fri,  5 May 2023 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683297053;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SpMY40f7bTTUeD1UlJHQdKmNbyqW5bWP4FRcbnJ6aw=;
        b=0BhwV91CdoSplCgJfkWBnyny7m1MtJeMDdArmdF+flWDFrc783V8bvidwz+uSRs5sXCUX8
        9Awix0gFSu4Ldhf3m4KCysTU0PeAQktf+PXVM8JuGTAN54WaTNwLAcSrqqoYdLNlsgUl2v
        sqrJTJw7EuXEZ8SJlAvu7aTtCSopd60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683297053;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SpMY40f7bTTUeD1UlJHQdKmNbyqW5bWP4FRcbnJ6aw=;
        b=0zmV37mKfiVhxw2JeLIc04gA7Q17DjBpDNuatyZS6lQjLZbStAosqiq2Q4IE6VT3n5WuF1
        dI6gjn8wBjqbGCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F03B13513;
        Fri,  5 May 2023 14:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NeJyFh0TVWTidAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 14:30:53 +0000
Date:   Fri, 5 May 2023 16:24:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: output affected files when relocation failed
Message-ID: <20230505142456.GR6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aa446804b679949a1bd77e653a205408af43048e.1681780522.git.wqu@suse.com>
 <20230502155410.GH8111@twin.jikos.cz>
 <b97abccc-435c-8994-2ab4-2c9ecb796f66@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b97abccc-435c-8994-2ab4-2c9ecb796f66@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 07:20:57AM +0800, Qu Wenruo wrote:
> > This seems ok, scrub already does that so it's adding the missing
> > information, though the filenames in syslog may not be wanted due to
> > security/privacy reasons.
> 
> Maybe it's the time for us to consider some alternative filesystem error 
> reporting infrastructure?
> Like the one EXT4 is using?

AFAICS it's a combination of a trace event and fsnotify event? Eg. in
__ext4_error_inode(). I'm not sure the trace events are the best
mechanism but it works. Alternatively this can be based on the uevents,
we have some prototypes for that, also I think this is a recurring
topic, https://lwn.net/Articles/752613/ "Fixing error reporting—again"
(2018).

So if there's something standardized as an API we can start using it.
