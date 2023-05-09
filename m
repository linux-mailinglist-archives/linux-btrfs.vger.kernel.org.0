Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E96FD302
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 01:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEIXUD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 19:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEIXUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 19:20:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA79F3C03
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 16:20:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8549D21AF4;
        Tue,  9 May 2023 23:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683674399;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+m0CbGB9srcO+m7zJb4dOujPVZ7n8Sy+xMDz9RPzExU=;
        b=oPu3qcrMisGV4H3TCMDIo2ok8qxbcPAQ5zbTn3IrIQbtGhHA6LUBmjlHT3O+CVfQSW63Wk
        jLM0ybapJVRMeIs38fxBH4pWOGRs5Oy3AiNOlDAcnWAAnXNDzf6Ed1sp0JIuhmgh931a10
        HjbXqMoKEsAbvN2ZyIT3CtsBxFCHbiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683674399;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+m0CbGB9srcO+m7zJb4dOujPVZ7n8Sy+xMDz9RPzExU=;
        b=aI2cPEkj8W8QkfvMWPsmmLtm2KJjD6mkmBsFJd4Ev7JtCB/9/l+M+aoLHBHNSWlyfMdGi1
        choJ/dQRsMXgfWCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B8EC139B3;
        Tue,  9 May 2023 23:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fGetER/VWmQwCAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 23:19:59 +0000
Date:   Wed, 10 May 2023 01:14:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH RFC] btrfs: fix qgroup rsv leak in subvol create
Message-ID: <20230509231400.GM32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c98e812cb4e190828dd3cdcbd8814c251233e5ca.1682723191.git.boris@bur.io>
 <23f9b436-223c-918c-a3fd-290c3ac3bd7e@gmx.com>
 <20230501170930.GB3094799@zen>
 <20230509222959.GJ32559@twin.jikos.cz>
 <1c9a0f23-e94e-a7cd-f3d2-3675566fc40a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c9a0f23-e94e-a7cd-f3d2-3675566fc40a@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 10, 2023 at 07:05:19AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/5/10 06:29, David Sterba wrote:
> > On Mon, May 01, 2023 at 10:09:30AM -0700, Boris Burkov wrote:
> >> On Sat, Apr 29, 2023 at 03:18:26PM +0800, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2023/4/29 07:08, Boris Burkov wrote:
> >>>> While working on testing my quota work, I tried running all fstests
> >>>> while passing mkfs -R quota. That shook out a failure in btrfs/042.
> >>>>
> >>>> The failure is a reservation leak detected at umount, and the cause is a
> >>>> subtle difficulty with the qgroup rsv release accounting for inode
> >>>> creation.
> >>>
> >>> Mind to give an example of the leakage kernel error message?
> >>> As such message would include the type of the rsv.
> >>
> >> Sorry, missed this question in my first reply. The leaked rsv is the
> > [...]
> > 
> > There's a lot of useful information in your reply, can you please update
> > the changelog and resend? Thanks.
> 
> The proper fix is sent from Josef:
> 
> https://patchwork.kernel.org/project/linux-btrfs/patch/e65d1d3fd413623f9d0c58614a296f0ab5422a05.1683057598.git.josef@toxicpanda.com/

Ok, thanks for the pointer I did not realize it's for the same bug. The
patch has been merged to master.
