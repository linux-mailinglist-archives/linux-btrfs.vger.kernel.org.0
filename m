Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC050A5C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiDUQeB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390595AbiDUQdS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 12:33:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD54968A
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 09:28:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB5C3210EB;
        Thu, 21 Apr 2022 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650558507;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3/TPYCc3DHZHs14kEBJd/klJltrEMhxCmS7zaO5qsQ=;
        b=CRy7ZsrSpOvQe6jFzuSRc9tKE0sMHq4p2lgwWSH/nGWHJmpDDJM6702NVuKTEwRYqhDPU2
        G3NvX1SXgGCaJ17LALrjvJa8JOQAOmQHcx9gsQjeJxOXXj5cOIB9eNcASvXZw9dnQCsNIJ
        UWQzS1ijB+ivDcuNYKjsj9fkGGx8x7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650558507;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3/TPYCc3DHZHs14kEBJd/klJltrEMhxCmS7zaO5qsQ=;
        b=DNJSzHYF8bnXGlu64e6VAz+juAtozokPulGuW1d1mW9rNv++xuw4++3JuDnL4WaB5AtLrL
        yf2NT+xVsUwhPTCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8714E13A84;
        Thu, 21 Apr 2022 16:28:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 41MIICuGYWLleAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 21 Apr 2022 16:28:27 +0000
Date:   Thu, 21 Apr 2022 18:24:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 07/17] btrfs: make rbio_add_io_page() subpage
 compatible
Message-ID: <20220421162422.GE18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
 <d2873b5f3a00e9bb966150b4dd0253f4db107c12.1649753690.git.wqu@suse.com>
 <20220413191456.GN15609@twin.jikos.cz>
 <5b296828-65fb-b684-dedc-6f018e5ece4e@gmx.com>
 <5b190bf5-892c-0856-e623-f6f716985b28@gmx.com>
 <20220414154341.GP15609@twin.jikos.cz>
 <20220414175122.GR15609@twin.jikos.cz>
 <ec6b3ca4-87bc-64a3-075e-a2e2dcf6461a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec6b3ca4-87bc-64a3-075e-a2e2dcf6461a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 15, 2022 at 06:28:35AM +0800, Qu Wenruo wrote:
> > I should have done that, there are way more code changes that I missed
> > when going through the patch difference manually. I'll try to port it
> > again but uh.
> 
> Mind me to do the rebase?
> 
> Just base all the changes to the last commit just before the branch.
> 
> As doing manually diff check would also give me a deeper impression on
> what I should do in the first place to reduce your workload.

I don't push all the topic branches but they appear in for-next so you
can extract it from there, otherwise I can always push it on request so
we can sort it out.

Anyway, the branch is now merged to misc-next, and regarding the
problems I think there were a few factors that struck at the same time.
Checking diff of my changes against your branch is a safety check that
I should have done. We want to get branches for testing but patch
revisions also happen, so they can diverge and that we all stick to the
same coding style and formatting preferences is a noble goal but
practicaly not 100% achievable, there's always something left.
