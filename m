Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA787AB971
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjIVSme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 14:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjIVSmd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 14:42:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23413A9
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 11:42:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9317321A8B;
        Fri, 22 Sep 2023 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695408145;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRruffVoKCnhnytBlUZUfmqeH6f6Mk2iSP8WSoXkgF8=;
        b=GGnUirEzKmyLsYz1FMRYwe21bjnAAsY8Ny/CGG5inxpln4TCX0+uGTrU5LVmr1dKMKIFPy
        Ot38q6oxEV9+97EWTlPOlJxAyTb6obZ2qC4bT+Q2JORD3smI2Z2IvLE1ecg9CHw6e+SclF
        jfz3+jOv9vs1vgrGkCelWb2ACse7MZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695408145;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRruffVoKCnhnytBlUZUfmqeH6f6Mk2iSP8WSoXkgF8=;
        b=zl6cssRoz3PGvR9PE+W+px2xZ4AJONGxiJDOjFL2VI9eKhqQ81cljou794M0P5PnaHqx2X
        /5CwJQuS6POLCKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78EAB13478;
        Fri, 22 Sep 2023 18:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yLK3HBHgDWXRdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Sep 2023 18:42:25 +0000
Date:   Fri, 22 Sep 2023 20:35:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/8] btrfs: relocation: return bool from
 btrfs_should_ignore_reloc_root
Message-ID: <20230922183550.GH13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695380646.git.dsterba@suse.com>
 <54a6cbc4c91d872ec7eb9d1f7c1240d137fcfe5b.1695380646.git.dsterba@suse.com>
 <45290b63-f1e8-4588-8d26-c6bf21951348@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45290b63-f1e8-4588-8d26-c6bf21951348@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 12:36:31PM +0000, Johannes Thumshirn wrote:
> On 22.09.23 13:14, David Sterba wrote:
> > btrfs_should_ignore_reloc_root() is a predicate so it should return
> > bool.
> 
> Btw both callsites also check for btrfs_backref_cache::is_reloc, so 
> maybe that check can be merged into btrfs_should_ignore_reloc_root() as 
> well?

The helper is related to the root, for the is_reloc it would also have
to take the cache which looks like a separate thing. I think it would
obscure the condition.
