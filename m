Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF82797F97
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 02:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjIHAV3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 20:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjIHAV3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 20:21:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C596D19BD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 17:21:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 237571F461;
        Fri,  8 Sep 2023 00:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694132483;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+x6KzcyNQPjFlR8H1xB06F0zxi0+5ueFV8BlZAduIck=;
        b=2hjOf8n1K+44f6m6LMvZJNYik1t02l2aEXYYw8HZT5GofszZNk6SoPDBDzEu6ooY05bmaZ
        XzgdfHFp0SRbDP719261WbB8/xMKNef8T5QMAZfj0shibEJ08XlOEVvKLtT9CLvxUsiX/8
        1YfjJenClxLvJe6n8/ezpm0oqfxf9vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694132483;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+x6KzcyNQPjFlR8H1xB06F0zxi0+5ueFV8BlZAduIck=;
        b=tvv/gmLb7xMKRKFPb1JtEob663zxhn4YC+doSYqe/zuPsLS8Pt5bE1BPrBgnFZAR2VENQy
        V1MQLV1J/uJipUBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06D47134AF;
        Fri,  8 Sep 2023 00:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1c7aAANp+mTVZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Sep 2023 00:21:23 +0000
Date:   Fri, 8 Sep 2023 02:14:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/10] btrfs: reformat remaining kdoc style comments
Message-ID: <20230908001450.GS3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694126893.git.dsterba@suse.com>
 <6f4732200ecc2a0722323f68c91549c10c858c22.1694126893.git.dsterba@suse.com>
 <d7d73c93-1565-4cf5-8710-48e61e79d466@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d73c93-1565-4cf5-8710-48e61e79d466@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 07:51:01AM +0800, Qu Wenruo wrote:
> On 2023/9/8 07:09, David Sterba wrote:
> > Function name in the comment does not bring much value to code not
> > exposed as API and we don't stick to the kdoc format anymore. Update
> > formatting of parameter descriptions.
> 
> Mind to share which tool did you use to expose those comments?

vim in a loop on *.c, the comments really stand out and with the
foldmethod=syntax it's easy to page through the files.
