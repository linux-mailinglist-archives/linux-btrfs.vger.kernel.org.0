Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB7E77922E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjHKOuC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 10:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKOuB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 10:50:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FF8273E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 07:50:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 33AC91F890;
        Fri, 11 Aug 2023 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691765400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vqyzRp/KOFm/1arZ+m63UoySsSNCJf9rg3X6ovTZx6A=;
        b=s9v26sJIkeV6Kliua5m3vwsOUJFOYF1avKqB4O8NDH9UdzRJsE700Ggh+G8nS7RaXKyEkd
        fVIPt4v07mySC6znIwCdzje0dYI0mphKGd/OKMhdv/C4HG9DPRrUCbO+iJ+iSYO27o+yM7
        Afp2SoVC8L5+8rt+DtPgXu+9mYdtXgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691765400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vqyzRp/KOFm/1arZ+m63UoySsSNCJf9rg3X6ovTZx6A=;
        b=Hm7OD08csza3vQU24i8qB51H8nDnnlYA4DvGYw0GMr50qrro0XMtN8sNbyoyDNs91mNWe2
        pHYGntOzW6VNdhCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BF63138E2;
        Fri, 11 Aug 2023 14:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9isEBphK1mRTJAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 14:50:00 +0000
Date:   Fri, 11 Aug 2023 16:43:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: remove v0 extent handling
Message-ID: <20230811144334.GO2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2c8a0319e27ae48e0c0a6cedfd412382a705780e.1691751710.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8a0319e27ae48e0c0a6cedfd412382a705780e.1691751710.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 11, 2023 at 07:02:11PM +0800, Qu Wenruo wrote:
> The v0 extent item has been deprecated for a long time, and we don't have
> any report from the community either.
> 
> So it's time to remove the v0 extent specific error handling, and just
> treat them as regular extent tree corruption.
> 
> This patch would remove the btrfs_print_v0_err() helper, and enhance the
> involved error handling to treat them just as any extent tree
> corruption.

We added the helper in 2018, so it's about 5 years ago, without any
reports so yeah let's remove it for good, thanks.

There are still remaining references to BTRFS_EXTENT_REF_V0_KEY in the
tracepoints and in ctree.h, at least the tracepiont should be deleted
but we may need to  keep the ctree.h defintion documented so we don't
reuse the key number yet. I can fix that in the commit.
