Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374F0613BB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 17:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiJaQtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 12:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiJaQs5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 12:48:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D01C1A4
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 09:48:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 21AD022303;
        Mon, 31 Oct 2022 16:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667234935;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5TIbWdnlvhKNWszE1iAHAmag1B91buOeOorGDO55Es=;
        b=Vyo7HKDYtmZNa6smznrVDhfFXHrE2/sBJIZCPBdI9fkor1tyHVeMVLqWk7oHZZSFSmkled
        1c9VnDUH9l9RKSABSjRNw/VpvKJIZ1FJ0o/R/qSrSPxWRzAoVo82qRJvqYIVuW/Xcq+NL/
        bcrH3ZaBI9waiCshYbFwT47L9sW9Tyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667234935;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5TIbWdnlvhKNWszE1iAHAmag1B91buOeOorGDO55Es=;
        b=LKHNZyq4aKmTCV4ZIcM1hdE+lTc7BoDZfyzbHFx6SG0kWCI3/QPPZnb6pkaHvgBrw6+hVq
        2g1iGBBIUZR/opDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6CB013451;
        Mon, 31 Oct 2022 16:48:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dp2kNnb8X2PJRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 31 Oct 2022 16:48:54 +0000
Date:   Mon, 31 Oct 2022 17:48:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 8/8] btrfs: raid56: switch to the new run_one_write_rbio()
Message-ID: <20221031164837.GE5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666760699.git.wqu@suse.com>
 <7dca624de976e872abb869885b009713eddca061.1666760699.git.wqu@suse.com>
 <19e98ab7-949d-3c19-15c3-7b83ac428967@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e98ab7-949d-3c19-15c3-7b83ac428967@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 31, 2022 at 09:07:03AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/10/26 13:06, Qu Wenruo wrote:
> > This includes:
> > 
> > - Remove the functions only utilized by the old interface
> > 
> > - Make unlock_stripe() to queue run_one_write_rbio_work_lock()
> >    As at unlock_stripe(), the next rbio is the one holding the full
> >    stripe lock, thus it can not use the existing
> >    run_one_write_rbio_work(), or the rbio may not be executed forever.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >   fs/btrfs/raid56.c | 351 ++++------------------------------------------
> >   fs/btrfs/raid56.h |   1 -
> >   2 files changed, 27 insertions(+), 325 deletions(-)
> > 
> [...]
> > @@ -3284,16 +2987,16 @@ static void raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
> >   				free_raid_bio(cur);
> >   				continue;
> >   			}
> > -			queue_write_rbio(cur);
> > +			queue_write_rbio(last);
> >   		}
> >   		last = cur;
> >   	}
> >   	if (last)
> > -		queue_write_rbio(cur);
> > +		queue_write_rbio(last);
> >   	kfree(plug);
> >   }
> 
> This part is in fact a bug fix which should go into previous patch, or 
> it can break bisection.
> 
> This is already fix in my github repo, will update the series with some 
> extra polish, like remove the raid56_parity_write_v2() definition, and 
> make recovery path to follow the same idea.

Ok, I'll use the github branch for for-next if needed.
