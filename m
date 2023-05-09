Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE86FD2C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 00:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjEIWgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 18:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEIWgf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 18:36:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFCD6189
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 15:36:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FE18219F8;
        Tue,  9 May 2023 22:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683671759;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RFrbfHP9U6qg5HPtNfRcfct4XAR6ZoEj1rIjEu7Z0cE=;
        b=2UE74StmGiPm06+ZhLGp/mDuA8GMp0cfPuzc6aqaK3//z5Lss0vSEBA/JTTeWGCW/rfpn2
        ZTs1LaKYlK1P4D5mpmctJXsmGKObjWzUelbAMMXcI6eaRBUD77V1wuhOu1J597TKzc/Ewj
        chJjg7yW5tn+iQFpPkdGFHxNTXFANcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683671759;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RFrbfHP9U6qg5HPtNfRcfct4XAR6ZoEj1rIjEu7Z0cE=;
        b=4SVnRQz5Gdxbln/3m4zzDwjxPkJ5XiGsov5Ck2te5JpyxclY+i+TnvY1TwTQiIH1K6ouHU
        NCSZ1LRjwfFBY5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F027913581;
        Tue,  9 May 2023 22:35:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iMLuOc7KWmQSdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 22:35:58 +0000
Date:   Wed, 10 May 2023 00:29:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, 'Qu Wenruo ' <wqu@suse.com>
Subject: Re: [PATCH RFC] btrfs: fix qgroup rsv leak in subvol create
Message-ID: <20230509222959.GJ32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c98e812cb4e190828dd3cdcbd8814c251233e5ca.1682723191.git.boris@bur.io>
 <23f9b436-223c-918c-a3fd-290c3ac3bd7e@gmx.com>
 <20230501170930.GB3094799@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501170930.GB3094799@zen>
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

On Mon, May 01, 2023 at 10:09:30AM -0700, Boris Burkov wrote:
> On Sat, Apr 29, 2023 at 03:18:26PM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2023/4/29 07:08, Boris Burkov wrote:
> > > While working on testing my quota work, I tried running all fstests
> > > while passing mkfs -R quota. That shook out a failure in btrfs/042.
> > > 
> > > The failure is a reservation leak detected at umount, and the cause is a
> > > subtle difficulty with the qgroup rsv release accounting for inode
> > > creation.
> > 
> > Mind to give an example of the leakage kernel error message?
> > As such message would include the type of the rsv.
> 
> Sorry, missed this question in my first reply. The leaked rsv is the
[...]

There's a lot of useful information in your reply, can you please update
the changelog and resend? Thanks.
