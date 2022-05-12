Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA20525382
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 May 2022 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352651AbiELRYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 May 2022 13:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346170AbiELRYd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 May 2022 13:24:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9D58FF95
        for <linux-btrfs@vger.kernel.org>; Thu, 12 May 2022 10:24:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4A861F8EF;
        Thu, 12 May 2022 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652376271;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ruqoYTOrJP6u9flf0qJIWZegF0itQIRuxCfFf0lBnjU=;
        b=hMd6dfMJT/GQImnJC5roRJEt2i3AKw7uTEX0dWqtoGNcbs6NK1mjyn7D1DH6myrHkzqdct
        DiSXR0CH99AmXEeB8fboRqptjdyAPEZCtaORBs8C47GmsKaL8qXlkaHdmbpqJ0bN4kSwYj
        W4VcO28WQSxGDvMMPzG2ERWWsa6Qv1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652376271;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ruqoYTOrJP6u9flf0qJIWZegF0itQIRuxCfFf0lBnjU=;
        b=bRSO4p1aylFJRAvyedMvIrOS9F8WYWRSJbbIM3KNXciLcik2ipUhIeEtfuUcz+/S/8yMtA
        l5JtF9gHDeJ9DCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93B5A13ABE;
        Thu, 12 May 2022 17:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2+YMI89CfWJAJAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 May 2022 17:24:31 +0000
Date:   Thu, 12 May 2022 19:20:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/13] btrfs: add a helper to queue a corrupted sector
 for read repair
Message-ID: <20220512172015.GU18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1651559986.git.wqu@suse.com>
 <2cfd9d2766824ddce727b06068de24d7a4be9637.1651559986.git.wqu@suse.com>
 <YnFFJGbbs4+MgKY1@infradead.org>
 <22700bdb-7606-a00a-5075-574966737793@gmx.com>
 <YnKIXKqBpa7gU/DO@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnKIXKqBpa7gU/DO@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 04, 2022 at 07:06:20AM -0700, Christoph Hellwig wrote:
> On Wed, May 04, 2022 at 09:13:43AM +0800, Qu Wenruo wrote:
> > On 2022/5/3 23:07, Christoph Hellwig wrote:
> > > This adds an ununused static function and thus doesn't even compile.
> > 
> > It's just a warning and can pass the compile.
> > 
> > Or we have to have a patch with over 400 lines.
> 
> The latter is the only thing that makes sense.  Patches that are not
> self contained also can't be reviewed self contained.  A larger patch
> is much better than a random split.

We've been doing it the way where a complex function is in a separate
patch and its usage in another one. Yes there are different preferences
and opinions on that. It also depends how one does the review, either in
the mails or in the code. For me it's fine with the split as once I'm at
second patch the function exists in the file. In the mails it's "how
does it work" and "how it is used", so this can be seen as two different
things, thus in two patches. On exception a short function in the same
patch as it's use makes sense, for bigger ones I'm for patch split.
