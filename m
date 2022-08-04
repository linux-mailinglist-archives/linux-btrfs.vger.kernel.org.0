Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D1589C56
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 15:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiHDNL5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 09:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbiHDNLj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 09:11:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905BF25C6D
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 06:11:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A730206B4;
        Thu,  4 Aug 2022 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659618684;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3oGNDd1oHdKmIYeWjVSaymO8rkAe7Bf3svkukPkPv+E=;
        b=jrMOlfh62ERuAHbCy2Degc9jzWy9dbv1xaNLPnP+jdztfvOiRFmT3EOj82gdLZtMrB1maB
        A/x2KtAmqdu8aV6u6lwBGAjJ/lptAyKE6bN2nC4uRqXY5MPPCBNlyMFEIaCg00/2YRNYU2
        UIkS9Zu0aAkahJrVvRQ9MDGmsg0hTjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659618684;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3oGNDd1oHdKmIYeWjVSaymO8rkAe7Bf3svkukPkPv+E=;
        b=Ro2wMtbSLegYYCn+Nlo8VRjzYKqvyojnXGuNhi89Qpk8REIyCKFEGQ3E3uh6vpP8msxSeB
        tx1IXw37eTVL8NCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1747513A94;
        Thu,  4 Aug 2022 13:11:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cyCwBHzF62KoVQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 Aug 2022 13:11:24 +0000
Date:   Thu, 4 Aug 2022 15:06:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: scrub: try to fix super block errors
Message-ID: <20220804130621.GM13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1659423009.git.wqu@suse.com>
 <9f95c1c4437371d8ad1b51042e5dc82a5e42449f.1659423009.git.wqu@suse.com>
 <20220803125513.GC13489@twin.jikos.cz>
 <52323456-6820-ce55-101a-8aecc3e73539@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52323456-6820-ce55-101a-8aecc3e73539@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 04, 2022 at 05:49:20AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/8/3 20:55, David Sterba wrote:
> > On Tue, Aug 02, 2022 at 02:53:03PM +0800, Qu Wenruo wrote:
> >> @@ -4231,6 +4248,26 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
> >>   	scrub_workers_put(fs_info);
> >>   	scrub_put_ctx(sctx);
> >>
> >> +	/*
> >> +	 * We found some super block errors before, now try to force a
> >> +	 * transaction commit, as all scrub has finished, we're safe to
> >> +	 * commit a transaction.
> >> +	 */
> >
> > Scrub can be started in read-only mode, which is basicaly report-only
> > mode, so forcing the transaction commit should be also skipped. It would
> > fail with -EROFS right at the beginning of transaction start.
> 
> It's already checked in the code:
> 
> +		if (sctx->stat.super_errors > old_super_errors && !sctx->readonly)
> +			need_commit = true;

Great, I overlooked it and searched only for BTRFS_SCRUB_READONLY.
