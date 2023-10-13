Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D807C8C9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 19:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjJMRyp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 13:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMRyo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 13:54:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E58783
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 10:54:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 36EEA21998;
        Fri, 13 Oct 2023 17:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697219681;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GoBcoaqM7puhNKqwpojcngNxCMSsNnF9fRIRdRoblYQ=;
        b=0m+EmG8Q1gEgcrV+z86PmBtA8InCP/+IE9XJfUNWazjJjUu2DdmhZCZjBMNbMZVeTUH4xD
        msk3zPXeCLV2PW/7MKxJ3gjyTpaxgrjCk32gMSCeZaThzVH6y4QBKLTXQE/jDMV/vIzIkx
        2COnvzJcQHCZPX1jkgCeoNWhym5A5iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697219681;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GoBcoaqM7puhNKqwpojcngNxCMSsNnF9fRIRdRoblYQ=;
        b=9qDXjbAaD0tRUWckK3kTskGacPf5wp9VUx8Rlk1Pczi9bBrL8vBRhsIwP61ZzX3nboZrZO
        3vNzATKKL7qgU1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC881138EF;
        Fri, 13 Oct 2023 17:54:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ucTXMmCEKWVTEQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Oct 2023 17:54:40 +0000
Date:   Fri, 13 Oct 2023 19:47:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs-progs: cmds: add "btrfs tune set" subcommand
 group
Message-ID: <20231013174752.GT2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693900169.git.wqu@suse.com>
 <1c294f739f028da499cf7f57deb334f419979097.1693900169.git.wqu@suse.com>
 <2adb8c79-d1d2-dffa-dd6b-5254d75c9c86@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2adb8c79-d1d2-dffa-dd6b-5254d75c9c86@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.48
X-Spamd-Result: default: False [-4.48 / 50.00];
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
         BAYES_HAM(-0.68)[83.04%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 08:53:11AM +0800, Anand Jain wrote:
> On 05/09/2023 15:51, Qu Wenruo wrote:
> > As the first step to convert btrfstune into "btrfs tune" subcommand
> > group, this patch would add the following subcommand group:
> > 
> >   btrfs tune set <feature> [<device>]
> > 
> > For now the following features are supported:
> > 
> > - extref
> > - skinny-metadata
> > - no-holes
> >    All those are simple super block flags toggle.
> > 
> > - list-all
> >    This acts the same way as "mkfs.btrfs -O list-all", the difference is
> >    it would only list the supported features.
> >    (In the future, there will be "btrfs tune clear" subcommand, which
> >     would support a different set of features).
> > 
> 
> With this patchset, the syntax is structured as follows:
> 
> 
>     $ btrfs tune --help
>     usage: btrfs tune <command> <args>
> 
>        btrfs tune set <feature> [<device>]
>            Set/enable specified feature for the unmounted filesystem
>        btrfs tune clear <feature> [<device>]
>            Clear/disable specified feature for the unmounted filesystem
> 
>     change various btrfs features
> 
> 
> 
> However, for consistency, I suggest the following syntax:

Consistency with what? If it's with btrfstune then no, the reason why
the command is split into subcommands is because the command line
parameters became unwieldy and what you suggest below copies that.

> 
>    set:
>     $ btrfs tune <feature> /dev/sda
> 
>    clear:
>     $ btrfs tune <feature> --clear /dev/sda
> 
>    list:
>     $ btrfs tune --list-all
> 
> This syntax aligns with the:
> 
>     $ btrfs device scan --forget

The difference is that scan won't be extended much if ever. The 'tune'
interface grows over time so we need properly structure that so we don't
end in command line option mess.

As an anti-pattern I can mention the 'mdadm' utility, that comes from
times when the commands were not without the initial "--" like we know
from git etc, so the main commands like assemble are specified by -A or
--assemble. What I find confusing is that it's just another option but
means a main action. The command groups logically and visually
encapsulate one action and can be possibly fine tuned by parameters
without affecting other commands.
