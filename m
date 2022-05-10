Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81AC5213AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbiEJL3g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 07:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbiEJL3e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 07:29:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E38E2ABBF4
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 04:25:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A0E321B8A;
        Tue, 10 May 2022 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652181936;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edwmskmoNniZxsxVL3ebySCTMLcMRxOAsAv76SmD1bk=;
        b=kXodi+tfWDjUfa9qBwMkfljQsYBh4XxDFFUY+0zGeEWG8UbuAQqFIk5U3EXygthhkDiPMn
        diq1aQqyBxCoSiirZDDkh5/hkLFJSjZXbIxqldAJtBH60ElJJ1VNAdgk+TWce1gPljNebu
        lX/qw79kpekiI1S4vsowhsPkbQTLXWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652181936;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edwmskmoNniZxsxVL3ebySCTMLcMRxOAsAv76SmD1bk=;
        b=n999mBFZipHCNoVk38KcGe+H1LDul5Y1yjl6+VC3bOz+Y8DOqngLyeFtQlrd/j0heMxe+r
        ZiNQ/slTl/rvWxBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A55C13AA5;
        Tue, 10 May 2022 11:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jF2AAbBLemJfaQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 May 2022 11:25:36 +0000
Date:   Tue, 10 May 2022 13:21:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add "0x" prefix for unsupported optional features
Message-ID: <20220510112121.GJ18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <bc87beb85ce5b31157385eb2bc55a0bfacefc9d4.1652166589.git.wqu@suse.com>
 <40341642-2a12-0692-c3a9-61ed80ff1be6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40341642-2a12-0692-c3a9-61ed80ff1be6@suse.com>
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

On Tue, May 10, 2022 at 11:06:19AM +0300, Nikolay Borisov wrote:
> 
> 
> On 10.05.22 г. 10:10 ч., Qu Wenruo wrote:
> > The following error message lack the "0x" obviously:
> > 
> >    cannot mount because of unsupported optional features (4000)
> > 
> > Just add the prefix before any complains.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> Though it doesn't make the output any more readable for humans :)

We can't do much better here, if the feature would be known and have a
textual description it would be caught, so the raw value is at least
something that can be matched in the newer versions.
