Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E0C3F0E75
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 01:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhHRXEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 19:04:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhHRXEG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 19:04:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 16A9F20088;
        Wed, 18 Aug 2021 23:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629327810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ogbc0Ou+cdv7P2PQu8PCyFSa8Y+JE/8BXWQAPSJ+Sg=;
        b=B+jg6hWEcNBu4ptOHF3P9DmmUBIRHOqqM6wyGkw0c+3Ymf4b8Z+I4U9SFp2pdcVpwwixty
        HWYHSCWXCkdQQnEofplARF7Ao6sAaogUNdJmMzravY9XgmI4xHcp5U194ROwpMZwk4OxpC
        6b/+gDUqeHynx6agqOYI9feVSgcfOYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629327810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ogbc0Ou+cdv7P2PQu8PCyFSa8Y+JE/8BXWQAPSJ+Sg=;
        b=9v2kg2Gv467B2ywAMBwO0xvcTH9nt/E+kOblBfsOiOk7QLJLwVDIySeRUxgeN5o6+fLRLZ
        Gq5xb+aD/rLDbODQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0E8EFA3B98;
        Wed, 18 Aug 2021 23:03:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1391ADA72C; Thu, 19 Aug 2021 01:00:32 +0200 (CEST)
Date:   Thu, 19 Aug 2021 01:00:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
Message-ID: <20210818230032.GA5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210816235540.9475-1-wqu@suse.com>
 <8babcc1b-2456-8632-7b56-f9867d333a0d@suse.com>
 <ac42cd2a-82dd-1987-4e18-e9d27e127172@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac42cd2a-82dd-1987-4e18-e9d27e127172@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 17, 2021 at 04:10:43PM +0800, Qu Wenruo wrote:
> On 2021/8/17 下午3:55, Nikolay Borisov wrote:
> > On 17.08.21 г. 2:55, Qu Wenruo wrote:
> >> @@ -665,7 +665,18 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
> >>
> >>   		if (!ordered) {
> >>   			ordered = btrfs_lookup_ordered_extent(inode, offset);
> >> -			BUG_ON(!ordered); /* Logic error */
> >> +			/*
> >> +			 * The bio range is not covered by any ordered extent,
> >> +			 * must be a code logic error.
> >> +			 */
> >> +			if (unlikely(!ordered)) {
> >> +				WARN(1, KERN_WARNING
> >> +		"no ordered extent for root %llu ino %llu offset %llu\n",
> >> +				     inode->root->root_key.objectid,
> >> +				     btrfs_ino(inode), offset);
> >> +				kvfree(sums);
> >> +				return BLK_STS_IOERR;
> >> +			}
> >
> > nit: How about :
> >
> > if (WARN_ON(!ordered)  {
> 
> I still remember that if (WARN_ON()) usage is not recommended by David.
> 
> Is that still the case?

Quick grep shows there are many if (WARN_ON(...)) so as long as it's a
simple "if (WARN_ON(condition))" and the code is readable I won't
object.

The problematic one is "if (!WARN_ON(condition))", because it warns when
condition is true, but the if does not continue and that breaks the
reading flow. The acceptable pattern read like "if condition and warn
eventually and continue".
