Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE776C3D97
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 23:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCUWSg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 18:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCUWSf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 18:18:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4F47683
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 15:18:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 538BC2058F;
        Tue, 21 Mar 2023 22:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679437113;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SexwtN9z8vT7MHoKl/lGSP8eIagrhd4Z9kEpwq+nnGI=;
        b=SuACwKPtNGQTZuQfhj4pc0TtxTm1npjeCoRT894+ZJlyrJq/XoEk6ASk4pk5sn3nrDcCLD
        ezmUfREBWWdyp0kVUlRF7/wLAs3JyKkFccUrh6jB73DhN2WK3/M/2V27JBNzVh7eka7KVS
        cPWXSoXurFqcN6t0DoA4NevTQM3E0Yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679437113;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SexwtN9z8vT7MHoKl/lGSP8eIagrhd4Z9kEpwq+nnGI=;
        b=g7mjew6ah9eXD19qfofdVDiBNYOVyX8CjILugUGp5TVdFDL/DvgvYJBQ4FrrbX1USkpy9u
        1LwHzS/fw+71/bDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A46513440;
        Tue, 21 Mar 2023 22:18:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pF9CCTktGmRwLwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 22:18:33 +0000
Date:   Tue, 21 Mar 2023 23:12:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 01/12] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Message-ID: <20230321221222.GS10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679278088.git.wqu@suse.com>
 <94803d18b1c4ce208b6a93e37998718e61ea37d5.1679278088.git.wqu@suse.com>
 <a70957b6-e9df-c50f-0b76-8524a56f64a1@oracle.com>
 <16b37d65-8b90-f5b1-0f30-41cf392689a5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16b37d65-8b90-f5b1-0f30-41cf392689a5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 21, 2023 at 03:25:18PM +0800, Qu Wenruo wrote:
> >> +    if (!page)
> >> +        return -ENOMEM;
> >> +
> > 
> >   Over allocation for PAGESIZE>4K is unoptimized for SB, which is
> >   acceptable. Add a comment to clarify.
> 
> For this, I'm not sure if it's that unoptimized.
> 
> The "alternative" is to just allocate 4K memory, but bio needs a page 
> pointer, not a memory pointer (it can be converted, but not simple if 
> not aligned).
> 
> The PAGESIZE > 4K one is only not ideal for memory usage, which I'd say 
> doesn't worthy a full comment.

It's a one time allocation and short lived so some ineffectivity is
tollerable.

> At most an ASSERT() like "ASSERT(PAGE_SIZE >= BTRFS_SUPER_INFO_SIZE);".

Yeah that's possible, but all current architectures have page size at
least 4K, I doubt the assert makes sense.
