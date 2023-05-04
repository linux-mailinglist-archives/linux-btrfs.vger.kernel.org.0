Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62F16F78CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 00:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjEDWLI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 18:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDWLH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 18:11:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B2412497
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 15:11:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDDF11F8AA;
        Thu,  4 May 2023 22:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683238264;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZovWutM4y/ONY4dX9oLyEg4KJp25os0z5G9pyc27+ro=;
        b=yx94ytYDaOhJY5xfuiEIl9eAq4lSUj22kdzj0hp4uj8QxvnoMTavFBS/ZH50oAYS9vVB/+
        yiifkZ+mW5Wa76aEuUDzYxlYZFqK/cwL4IeKMORR5Ocx6m5zgzkc8GpYpzs7ZME2fZFcOy
        ShZsUsTE+jdR4pFKDgvpIYMSWtNqmKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683238264;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZovWutM4y/ONY4dX9oLyEg4KJp25os0z5G9pyc27+ro=;
        b=16a6WN6t/wR8/ILm9Z76+m12n+tL7mPk62cq1I6CDjOKB5OReryinXbGbsqAUOF7i0amsw
        IFfcpacyZajq36AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 926A713444;
        Thu,  4 May 2023 22:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QOPhIngtVGRTUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 May 2023 22:11:04 +0000
Date:   Fri, 5 May 2023 00:05:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/7] btrfs-progs: crypto/blake2: remove blake2 simple
 API
Message-ID: <20230504220508.GH6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1683093416.git.wqu@suse.com>
 <6f15cfedf228f6e8d855fcdcf125b678273534d6.1683093416.git.wqu@suse.com>
 <f84102d0-29ec-11a5-2777-9dd27c3b4123@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f84102d0-29ec-11a5-2777-9dd27c3b4123@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 04, 2023 at 05:08:44PM +0800, Anand Jain wrote:
> On 03/05/2023 14:03, Qu Wenruo wrote:
> > We never utilize such simple API, just remove it.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> 
> 
> 
> > ---
> >   crypto/blake2b-ref.c | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/crypto/blake2b-ref.c b/crypto/blake2b-ref.c
> > index eac4cf0c48da..f28dce3ae2a8 100644
> > --- a/crypto/blake2b-ref.c
> > +++ b/crypto/blake2b-ref.c
> > @@ -326,10 +326,6 @@ int blake2b( void *out, size_t outlen, const void *in, size_t inlen, const void
> >     return 0;
> >   }
> >   
> > -int blake2( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen ) {
> > -  return blake2b(out, outlen, in, inlen, key, keylen);
> > -}
> > -
> 
> It came from the ref implementation. With minimum changes. Maybe needed 
> it for future sync? No?

It's not needed anymore, the code sync can be done from any incremental git
commits, blake2 upstream isn't changing much.
