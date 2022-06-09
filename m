Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677BB544C05
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 14:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbiFIMbK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiFIMbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 08:31:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BA51A05D
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 05:31:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D9AF71FE56;
        Thu,  9 Jun 2022 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654777860;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+w/mt0S6/j391Ai+nEguT4DIk0kenYSiPadSiVldWBM=;
        b=buS9GfbCNgJRT1zB/d0rSKEfM6eFWW3agbgwPpp7ZWtzeDm7jWq8kJRJyccOiw5EGzs/lv
        2kgN0cbR9Da1QSFt6NWVS8zYFo0JLnAVCQINny9/J8pZcVq2y88OqTe+1U+TLh0VevzyGt
        R2kMW7wy0sZPIqHSJumDqjllN1nKD2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654777860;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+w/mt0S6/j391Ai+nEguT4DIk0kenYSiPadSiVldWBM=;
        b=GVSe3IAP3nkY6JIDJU0tuZ+w/4NnWNfBiLJhd2KXY88q/yuXRt97opjsFLykQh8iSWF1r0
        sB/7JYe1CibuOJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A57B013A8C;
        Thu,  9 Jun 2022 12:31:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MhQhJwTooWLFPQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Jun 2022 12:31:00 +0000
Date:   Thu, 9 Jun 2022 14:26:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] btrfs: use preallocated page for super block write
Message-ID: <20220609122630.GS20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        willy@infradead.org
References: <20220607154229.9164-1-dsterba@suse.com>
 <1c8faef3-6ccb-6eb8-6f42-d52faf8f74e1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c8faef3-6ccb-6eb8-6f42-d52faf8f74e1@suse.com>
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

On Thu, Jun 09, 2022 at 10:30:06AM +0300, Nikolay Borisov wrote:
> 
> 
> On 7.06.22 г. 18:42 ч., David Sterba wrote:
> > Currently the super block page is from the mapping of the block device,
> > this is result of direct conversion from the previous buffer_head to bio
> > conversion.  We don't use the page cache or the mapping anywhere else,
> > the page is a temporary space for the associated bio.
> > 
> > Allocate the page at device allocation time, also to avoid any later
> > allocation problems when writing the super block. This simplifies the
> > page reference tracking, but the page lock is still used as waiting
> > mechanism for the write and write error is tracked in the page.
> > 
> > This was inspired by Matthew's question
> > https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> 
> nit: I think it's important to remark in the changelog that with this 

If you say it's important, it's not a 'nit'

> change sb writing becomes sequential as opposed to parallel with the old 
> code. This also means that wait_dev_supers can be simplified because the 
> max_mirror's loop is not needed, at least for waiting, since for each 
> device we at most need to wait for the last write to it, as all previous 
> ones have been serialized by the pagelock.

Though it works that way, the serialization was not intentional and I
did not realize that.  find_get_page always provides a different page
and bio was allocated each time.

Either we keep it that way at the cost of slower superblock write or it
needs to be reworked, basically preallocating 3 pages. The write is
paralellized over all devices, I'm not sure how much the per-device
serialization would hurt but on rotational devices it could be
noticeable as the offsets are far and the seek penalty would add up.
