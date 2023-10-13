Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C07C8CB0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 20:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjJMSCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 14:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMSCc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 14:02:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C0EBE
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 11:02:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 421812186F;
        Fri, 13 Oct 2023 18:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697220150;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NaXJg5DxPvtzGhmWq1Pms8Z4aNNKlymgAijGnbt5J98=;
        b=DT+uolvBI/lNDtttO+nwxHPqaaqKuzpJsQHqE5KazcBYVEpTLWhxlaV1y8f4g976WT0BZf
        veZ27h52ILEMJalsuujk+jTIET+K1BOtRnPmU8gIKBulurnmckVL4Ssy3lmQhw7GGnJRmS
        9C/Y6nanpbtK/7Vh2qAXIuGsroYfIkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697220150;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NaXJg5DxPvtzGhmWq1Pms8Z4aNNKlymgAijGnbt5J98=;
        b=MuMZ5RXCM9K0a4Ubd0/HMQJanSjjJ+/x6CVwHOFKZw05zzuBYP8EtWHICwh0RrmK8etUOp
        RL9JScSgMJTogQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 012FC138EF;
        Fri, 13 Oct 2023 18:02:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R3brOTWGKWWmFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Oct 2023 18:02:29 +0000
Date:   Fri, 13 Oct 2023 19:55:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs-progs: cmds/tune: add set/clear features
Message-ID: <20231013175542.GU2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693900169.git.wqu@suse.com>
 <81c4792e-b7d9-73ab-452b-d840917ebbee@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c4792e-b7d9-73ab-452b-d840917ebbee@dirtcellar.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[27.34%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 12:33:04AM +0200, waxhead wrote:
> Qu Wenruo wrote:
> > This is the first step to convert btrfstune functionality to "btrfs
> > tune" subcommand group.
> > 
> > For now only binary features, aka set and clear, is supported,
> > thus uuid and csum change is not yet implemented.
> > (Both need their own subcommand groups other than set/clear groups)
> > 
> > And even for set/clear, there is some changes to btrfstune:
> > 
> > - Merge seed feature into set/clear
> >    To enable seeding, just go "btrfs tune set seed <device>".
> > 
> > - All supported features can be checked by "list-all" feature
> >    Please note that, "btrfs tune set list-all" and
> >    "btrfs tune clear list-all" will have different output.
> > 
> As just a regular BTRFS user I would like to please ask you to consider 
> having functions that may have consequences e.g. "dangerous" functions 
> disabled until enabled.
> 
> In other words much like you need to arm a missile or flip a safety 
> cover on a toggle switch
> 
> So if btrfs on every mount set a bit that disabled access to dangerous 
> functions (such as the tune functionality you would have to explicitly 
> enable it to be able to do scary stuff).
> 
> btrfs tune enable
> btrfs tune whatever_needs_tuning=123
> btrfs tune disable (manually disable scary functions)
> 
> And yes, I am aware that root users have powers to do scary stuff, but 
> sometimes even root users need to be protected against free will.
> 
> Please consider something like the above...

We can print a warning, add a delay, require a magic parameter. What you
suggest above with the enable/disable commands would require to store
the state somewhere so the next call 'tune whatever_needs_tuning' would
work (but not another such command run from another terminal).

Not all tune actions are dangerous or irreversible but I agree that
there's a lot of potential for damage in case someobody does not read
the documentation or understand the consequences. The actions are meant
to be one-time and with long term effects, like converting to new
structures. Comparable to mkfs, there are checks against accidental
overwrite of an existing filesystem, so at minimum we might require
--force for each command.
