Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C885153EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380118AbiD2St0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380121AbiD2StY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:49:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EBCB53D5
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:46:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECADB21872;
        Fri, 29 Apr 2022 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651257964;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kt7pL09O/npK+jChRK1ZnrK71cHDRAGcbFHqvvcjP9g=;
        b=EUq1EL5IdjNRCS2cOIy0x5K4Qge9qB9N+q3dZUasGl2VH7PSoQF6P6KeDq1y1JWLQSLc33
        d4SKABVfLp1hJzuWd+1840sUAlU1N2csMXE5vcce8D8nv+ARZPweaj+tvsTBgPP2Xe6bWy
        d/6IY1pjGDEcRcK4S7oFzjRxgiquzDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651257964;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kt7pL09O/npK+jChRK1ZnrK71cHDRAGcbFHqvvcjP9g=;
        b=2RyeR4vth44bN1xormb8HCN6DrrIIqPFE963boXDTlKaGmUckUVyIEqs4Dx+4inqZ0EJF2
        hHQzYSjTpwtO6ICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE08413AE0;
        Fri, 29 Apr 2022 18:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id glwQLWwybGJddQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 29 Apr 2022 18:46:04 +0000
Date:   Fri, 29 Apr 2022 20:41:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: zoned: consolidate zone finish function
Message-ID: <20220429184155.GG18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1651157034.git.naohiro.aota@wdc.com>
 <4d5e42d343318979a254f7dbdd96aa1c48908ed8.1651157034.git.naohiro.aota@wdc.com>
 <20220428161103.GD18596@twin.jikos.cz>
 <20220429045632.jlt2fn6chxubycbp@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429045632.jlt2fn6chxubycbp@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 04:56:33AM +0000, Naohiro Aota wrote:
> On Thu, Apr 28, 2022 at 06:11:03PM +0200, David Sterba wrote:
> > On Fri, Apr 29, 2022 at 12:02:15AM +0900, Naohiro Aota wrote:
> > >  1 file changed, 54 insertions(+), 73 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > > index 997a96d7a3d5..9cddafe78fb1 100644
> > > --- a/fs/btrfs/zoned.c
> > > +++ b/fs/btrfs/zoned.c
> > > @@ -1879,20 +1879,14 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
> > >  	return ret;
> > >  }
> > >  
> > > -int btrfs_zone_finish(struct btrfs_block_group *block_group)
> > > +static int __btrfs_zone_finish(struct btrfs_block_group *block_group, bool nowait)
> > 
> > Can you please avoid using __ for functions? Eg. the main function can
> > be btrfs_zone_finish(taking 2 parameters) and the exported one being
> > btrfs_zone_finish_nowait reflecting the preset parameter and also making
> > the 'nowait' semantics clear.
> 
> But, we exports both btrfs_zone_finish() (the waiting variant) and
> btrfs_zone_finish_endio() (the nowait variant + checking the left space
> after write). How about "do_zone_finish(block_group, bool nowait)" as a
> main function and "btrfs_zone_finish(block_group)" and
> "btrfs_zone_finish_endio(block_group)" ?

Yeah, do_zone_finish works as well.
