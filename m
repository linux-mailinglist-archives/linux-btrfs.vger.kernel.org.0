Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162956D6CFB
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjDDTKs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 15:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjDDTKr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 15:10:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EA6268B;
        Tue,  4 Apr 2023 12:10:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BAD7521DCD;
        Tue,  4 Apr 2023 19:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680635444;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXseAj3MmRo3pp2E5Fqzpezipbv+z3RR3Q1pT5b2PZI=;
        b=2mnRt/8vDXOhvMowfUb4Pzb+sFZCmozzZB38R1sRjJMkbcK1ZI50ioHBUXYwp47R2McD6U
        tzGHCIC1v1N253EvnAyHUMNnN7G1hAPZWFkhF8QDezSLOYb97gRsdJ2DrCj+QzjujzsEg4
        goJd7nuWGYnn0KS3DpXUup7TuU6z1VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680635444;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXseAj3MmRo3pp2E5Fqzpezipbv+z3RR3Q1pT5b2PZI=;
        b=lbB/Y8S5tCnY3bb0L0Pb0oXlhSG7nB5o0BaY1GrextSLBO7yKgmu1W/rXUllIb8Tbbm0aw
        Zb8D5plizfNxP2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EE971391A;
        Tue,  4 Apr 2023 19:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ouL5ITR2LGQqbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 04 Apr 2023 19:10:44 +0000
Date:   Tue, 4 Apr 2023 21:10:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     xiaoshoukui <xiaoshoukui@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: ioctl: fix inaccurate determination of
 exclusive_operation
Message-ID: <20230404191042.GE19619@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230403093757.120178-1-xiaoshoukui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403093757.120178-1-xiaoshoukui@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 03, 2023 at 05:37:57AM -0400, xiaoshoukui wrote:
> > Yeah I think the assertion should also check for NONE status. The paused
> > balance makes the state tracking harder but in user-started (manual or
> > scripted) commands it's typically not racing.
> 
> An assertion failure means that the code may not have taken careful consideration.
> After I patched the BTRFS_EXCLOP_NONE to the assertion, regression tests shows that
> another scenario I missed.
> 
> With started state == BTRFS_EXCLOP_BALANCE_PAUSED, cocurrently adding multiple devices
> to the same mount point and btrfs_exclop_balance executed finish before the latter
> thread execute assertion in btrfs_exclop_balance, exclusive_operation will changed to 
> BTRFS_EXCLOP_BALANCE_PAUSED state. 
> 
> I also added btrfs_info before ASSERT to help troubleshooting:
> > btrfs_info(fs_info, "fs_info exclusive_operation: %d",
> >        fs_info->exclusive_operation);
> > ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
> >        fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD ||
> >        fs_info->exclusive_operation == BTRFS_EXCLOP_NONE);

> I think the assertion should also check for BTRFS_EXCLOP_BALANCE_PAUSED status.

Agreed and this looks like the complete set of the compatible
operations. I hope this does not enable some combination that should not
be allowed but the enabling side does the try lock and allows only the
paused + dev_add combination.

Please send a fix with the analysis you dit and add the relevant parts
of stack traces. The reproducer would be good to have in fstests, for
the changelog please describe the conditions that could trigger the
assertion, the reproducer itself is too long. Thanks.
