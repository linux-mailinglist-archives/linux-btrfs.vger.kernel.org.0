Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A175FC3BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJLK31 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJLK30 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 06:29:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBA0A98E6;
        Wed, 12 Oct 2022 03:29:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8D918219F4;
        Wed, 12 Oct 2022 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665570563;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmipS7Jh1P8DxSYrMl4SBOWkdPREbcp1+Y21jMWS2K0=;
        b=ESRQn9ZoYJfBi3ursDEtPPM6TpP+SG5yRL/FcjdaUxKvYSFXrPni85ZaauH6y08pt04CKa
        WnDCdeKp8HvZQKkUlpRvDTK9A/I/jUwlizt1wpiTzMk200TKJy+XWD8s2kj4Ra+75InlFA
        stvCa4CnA3I2kSwIqDxgZgjC7McP3k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665570563;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmipS7Jh1P8DxSYrMl4SBOWkdPREbcp1+Y21jMWS2K0=;
        b=IvWmEP8uOIxqWd++iavXwYx1dagcXFanLqof7ODe7SU0J8MdF/Z+Fxd1ozYv5pEbjDz/sD
        lwChGh8NVB8IrDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5549C13ACD;
        Wed, 12 Oct 2022 10:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F8fhEwOXRmNKFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 12 Oct 2022 10:29:23 +0000
Date:   Wed, 12 Oct 2022 12:29:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update btrfs website links and files
Message-ID: <20221012102917.GV13389@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221011132256.333-1-dsterba@suse.com>
 <CAHk-=wiB9sHzsNcCRRkgeyXLu09hV-FgRLwvFHoA_uCpZRJJwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiB9sHzsNcCRRkgeyXLu09hV-FgRLwvFHoA_uCpZRJJwA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 03:48:55PM -0700, Linus Torvalds wrote:
> On Tue, Oct 11, 2022 at 6:23 AM David Sterba <dsterba@suse.com> wrote:
> >
> > We have the new documentation hosted on Read The Docs and content is
> > migrated there from the wiki. Also update http to https and add the
> > tracepoint definition header.
> 
> Hmm. Did you intend for me to apply this as a patch?
> 
> Since you normally just send pull requests, I'm a bit confused.
> 
> Is this a "it's outside the btrfs subdirectory, so I'm sending this as
> a patch"? Except I've seen you send stuff that has changes to mm/ for
> new exports etc, and in fact to MAINTAINERS too.

Yeah the reason was because it's out of my directory, the exports to mm/
or fs/ were necessary for code to work but the maintainers file is
plain text, I thought there was a different workflow.

> Or is this just an informational "let Linus know about this patch" email?
> 
> Anyway, if you actually want me to apply a patch directly because of
> some "I'm not going to send this as a pull request because there is
> nothing else pending" kind of issue or other reason, please do state
> that explicitly in the email.
> 
> Because as it is now, as explained above, I'm not sure why this patch
> was sent to me.

Sorry for confusion, you can ignore the patch. I'll add it to the pulled
branch, like last time which was not that long ago (mid 2021, commit
503d1acb01826b42e) but I forgot about that.
