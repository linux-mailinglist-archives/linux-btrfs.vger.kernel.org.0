Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDA4FBF64
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 16:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347348AbiDKOnR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 10:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347454AbiDKOmk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 10:42:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378FE13D27
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 07:40:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E151D1F38D;
        Mon, 11 Apr 2022 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649688024;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYlFAHKtePZw85s8PaaVoZvhsouWSvJtb/xXCGeIej8=;
        b=00o45ktw5R4c8Mfa0z+8U0RLOYYOvsVcj0sd1NU3dL7cSUt/C8KyUprDFF22LbwcelX1Kb
        KZ+scIB9LF18ewWBlJGI0uTqKcf9jpzKfIvVoJ2oARPneNnpyEqMQac/xVKuN7qL8kvSUu
        2Nbmpq4sQXT8WSYcPw+Q8t/QJ23oDt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649688024;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYlFAHKtePZw85s8PaaVoZvhsouWSvJtb/xXCGeIej8=;
        b=tUcxnAFIm3BrqcNB5ZYBf8y9PetMWKz5+1cas2tZDppMAx/4EbgO8PpzmeYvtAXLHsWS6r
        b7nfDzAL1OnfL3DA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D8887A3B82;
        Mon, 11 Apr 2022 14:40:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 921C8DA7DA; Mon, 11 Apr 2022 16:36:20 +0200 (CEST)
Date:   Mon, 11 Apr 2022 16:36:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/16] btrfs: make finish_parity_scrub() subpage
 compatible
Message-ID: <20220411143620.GN15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1648807440.git.wqu@suse.com>
 <d0a5f106303ee83daba01f65d6671b011791289a.1648807440.git.wqu@suse.com>
 <20220408170434.GX15609@twin.jikos.cz>
 <3ecd3692-4974-8dcb-e678-7ff45fd3438a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ecd3692-4974-8dcb-e678-7ff45fd3438a@gmx.com>
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

On Sat, Apr 09, 2022 at 06:59:37AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/4/9 01:04, David Sterba wrote:
> > On Fri, Apr 01, 2022 at 07:23:22PM +0800, Qu Wenruo wrote:
> >> The core is to convert direct page usage into sector_ptr usage, and
> >> use memcpy() to replace copy_page().
> >>
> >> For pointers usage, we need to convert it to kmap_local_page() +
> >> sector->pgoff.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/raid56.c | 56 +++++++++++++++++++++++++++--------------------
> >>   1 file changed, 32 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> >> index 07d0b26024dd..bd01e64ea4fc 100644
> >> --- a/fs/btrfs/raid56.c
> >> +++ b/fs/btrfs/raid56.c
> >> @@ -2492,14 +2492,15 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
> >>   					 int need_check)
> >>   {
> >>   	struct btrfs_io_context *bioc = rbio->bioc;
> >> +	const u32 sectorsize = bioc->fs_info->sectorsize;
> >>   	void **pointers = rbio->finish_pointers;
> >>   	unsigned long *pbitmap = rbio->finish_pbitmap;
> >>   	int nr_data = rbio->nr_data;
> >>   	int stripe;
> >>   	int sectornr;
> >>   	bool has_qstripe;
> >> -	struct page *p_page = NULL;
> >> -	struct page *q_page = NULL;
> >> +	struct sector_ptr p_sector = {};
> >> +	struct sector_ptr q_sector = {};
> >
> > This should be { 0 }
> 
> That's not what you said before.
> 
> You said that { 0 } conversion is not going to be merged and {} is fine.

Let me check, I could have misremembered that.
