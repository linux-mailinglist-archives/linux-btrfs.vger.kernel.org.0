Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139C47840BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjHVM11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 08:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjHVM10 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 08:27:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4AB196
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 05:27:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43D4122C44;
        Tue, 22 Aug 2023 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692707243;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ey2M66ffFUvUxDIyZJYo6DJOlmMoBd8WDHMe9bN36uw=;
        b=oGGmB5/EwSmgmI9Vy2apP//t+t3K5TxPE5PCwzQ1EnfdIkVFbSrTKwnehgQ1GPSlMwbUhP
        nWZumpwCE+XEvNmEedZTrp0uqdQIDuZ92nhkdnAlw5SCKmVjWTLMMHEBdTrAA2BuvvZ7K0
        gmHMvdprpIFT20TqX2SuVwGwa9yRZzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692707243;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ey2M66ffFUvUxDIyZJYo6DJOlmMoBd8WDHMe9bN36uw=;
        b=7MNm+ZAImb+04MbohVLmMBZRreF/wNxeSqEl5qn519WeJoRWQ3P0SQ8fNdnoPQxzIpOBGj
        jor58B+JKGJUy+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D12A13919;
        Tue, 22 Aug 2023 12:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6V1UAqup5GQpZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 22 Aug 2023 12:27:23 +0000
Date:   Tue, 22 Aug 2023 14:20:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: skip splitting and logical rewriting on
 pre-alloc write
Message-ID: <20230822122051.GE2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b9fec5bebe9d5be20c51bf0934a95609830d04d4.1692375606.git.naohiro.aota@wdc.com>
 <20230821141856.GB2420@twin.jikos.cz>
 <k3uzcmog2awcj5lc4lyecifjfsznofiymyfkfiscg4gxvr2srn@fro5ludqr7u5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k3uzcmog2awcj5lc4lyecifjfsznofiymyfkfiscg4gxvr2srn@fro5ludqr7u5>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 22, 2023 at 01:48:52AM +0000, Naohiro Aota wrote:
> On Mon, Aug 21, 2023 at 04:18:56PM +0200, David Sterba wrote:
> > On Sat, Aug 19, 2023 at 01:26:07AM +0900, Naohiro Aota wrote:
> > > +
> > > +	/*
> > > +	 * Write to pre-allocated region is for the data relocation, and so
> > > +	 * it should use WRITE operation. No split/rewrite are necessary.
> > > +	 */
> > > +	if (ordered->flags & (1 << BTRFS_ORDERED_PREALLOC))
> > 
> > Please use unsigned types for shifts, 1U << ...
> 
> Oops. BTW, we should use "test_bit(BTRFS_ORDERED_PREALLOC,
> &ordered_extent->flags)" instead, here?

Right, for consistency with other places, updated.
