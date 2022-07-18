Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E6B578931
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 20:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiGRSGO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 14:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiGRSGO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 14:06:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13A2E9DC
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 11:06:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E3613206CB;
        Mon, 18 Jul 2022 18:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658167571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r82gwJWsd7qQ0kbiIn2hrpE1s+JcwfHC06Drlip8Jg4=;
        b=i1SuLRMkN6LxNc/nn2NpvqE1MSVaGysa4peyv7Z8fNtPnutJtFhFujoiaNYkE9GVaTK0Gn
        6orzEm3PscrF+RPNJ9wRjPqUe3VmIifjmlvmSx9ThQLtDRIu509Kur+TPbUyDGxWjD26Fx
        8nux4oMBWPwZNJqRFLtSiBiE5t7utkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658167571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r82gwJWsd7qQ0kbiIn2hrpE1s+JcwfHC06Drlip8Jg4=;
        b=u40JGXIe8M3BpkZ2f5QOopj9Q9/GjIg+LFBaNCcCXIRUblg5jXJvGwQNTXGXVCmC92lrPe
        ow3zL/T6nVIDUoBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBA8913754;
        Mon, 18 Jul 2022 18:06:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rhXNLBOh1WISIAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Jul 2022 18:06:11 +0000
Date:   Mon, 18 Jul 2022 20:01:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Helge Kreutzmann <debian@helgefjell.de>
Cc:     linux-btrfs@vger.kernel.org,
        Mario =?iso-8859-1?Q?Bl=E4ttermann?= 
        <mario.blaettermann@gmail.com>
Subject: Re: Issues in man pages of btrfs-progs
Message-ID: <20220718180118.GO13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Helge Kreutzmann <debian@helgefjell.de>,
        linux-btrfs@vger.kernel.org,
        Mario =?iso-8859-1?Q?Bl=E4ttermann?= <mario.blaettermann@gmail.com>
References: <20220718141447.GA24796@Debian-50-lenny-64-minimal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220718141447.GA24796@Debian-50-lenny-64-minimal>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Mon, Jul 18, 2022 at 04:14:47PM +0200, Helge Kreutzmann wrote:
> Dear btrfs-progs maintainer,
> the manpage-l10n project maintains a large number of translations of
> man pages both from a large variety of sources (including btrfs-progs) as
> well for a large variety of target languages.
> 
> During their work translators notice different possible issues in the
> original (english) man pages. Sometimes this is a straightforward
> typo, sometimes a hard to read sentence, sometimes this is a
> convention not held up and sometimes we simply do not understand the
> original.
> 
> We use several distributions as sources and update regularly (at
> least every 2 month). This means we are fairly recent (some
> distributions like archlinux also update frequently) but might miss
> the latest upstream version once in a while, so the error might be
> already fixed. We apologize and ask you to close the issue immediately
> if this should be the case, but given the huge volume of projects and
> the very limited number of volunteers we are not able to double check
> each and every issue.
> 
> Secondly we translators see the manpages in the neutral po format,
> i.e. converted and harmonized, but not the original source (be it man,
> groff, xml or other). So we cannot provide a true patch (where
> possible), but only an approximation which you need to convert into
> your source format.
> 
> Finally the issues I'm reporting have accumulated over time and are
> not always discovered by me, so sometimes my description of the
> problem my be a bit limited - do not hesitate to ask so we can clarify
> them.
> 
> I'm now reporting the errors for your project. If future reports
> should use another channel, please let me know.

I've opened an issue https://github.com/kdave/btrfs-progs/issues/495
please continue there. Sending reports by mail also works.

> Man page: btrfs.8
> Issue:    B<btrfs(5)> → B<btrfs>(5)

So all the issues are for the manual page references and placement of
the section. The manual pages written RST still lack references to many
other things (issue #476) but the manual page references are a bit
special so there's a separate issue for that. Also for you to follow up
and report anything else you find.

The idea is to use some macros so we don't have to format the references
manually, but I'm lacking the knowledge how to do that in RST.
