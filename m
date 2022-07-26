Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8B581992
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 20:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbiGZSS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbiGZSS4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 14:18:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6041032443
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 11:18:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 176BD37A3B;
        Tue, 26 Jul 2022 18:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658859531;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACNLkosggPPI8Enx/ZdI6ApakYwwtUtpXgr5MUlVLk8=;
        b=s4E5KpnQMJISvwyD0gZ7Pe7AC90bfHwtlsV5oF7o0k2EHDQ0QBZNTzGyn8TanCMoNl9rC4
        HDE9JFw/nzbY4550txaMPVa0zTsOLlmnAGMHajOry6JftHfLjqj+Yk/71gv7jM85pQdMWm
        DI7XBUmvGWWBn+v5SIIBPbwS1kKXrog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658859531;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACNLkosggPPI8Enx/ZdI6ApakYwwtUtpXgr5MUlVLk8=;
        b=blMRL+f7WysQlNkS+jDjwY5QnVENWeNSQkUiG1mYconBvQ3NjpgbpqeIfzDfYsqz7idWJv
        2LnH4app2f5DNsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF2AA13A7C;
        Tue, 26 Jul 2022 18:18:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bm1vNQow4GLdFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 18:18:50 +0000
Date:   Tue, 26 Jul 2022 20:13:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/4] btrfs: make __btrfs_dump_space_info() output
 better formatted
Message-ID: <20220726181353.GJ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
 <a5321725-1667-fd6f-2bfd-8ddb7b78d038@dorminy.me>
 <20220719213804.GT13489@twin.jikos.cz>
 <3cfc9569-ff22-c04d-f7d0-fea1396ba4b5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cfc9569-ff22-c04d-f7d0-fea1396ba4b5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 20, 2022 at 06:58:16AM +0800, Qu Wenruo wrote:
> >>> +	btrfs_info(fs_info, "  reserved:      %llu", info->bytes_reserved);
> >>> +	btrfs_info(fs_info, "  may_use:       %llu", info->bytes_may_use);
> >>> +	btrfs_info(fs_info, "  read_only:     %llu", info->bytes_readonly);
> >>> +	if (btrfs_is_zoned(fs_info))
> >>> +		btrfs_info(fs_info,
> >>> +			    "  zone_unusable: %llu", info->bytes_zone_unusable);
> >>
> >> I'm (perhaps needlessly) worried about splitting this up into six/seven
> >> messages, because of the ratelimiting rolled into btrfs_printk. The
> >> ratelimit is 100 messages per 5 * HZ, and it seems like it would be
> >> unfortunate if it kicked in during the middle of this dump and prevented
> >> later info from being dumped.
> >>
> >> Maybe we should add a btrfs_dump_printk() helper that doesn't have a
> >> ratelimit built in, for exceptional cases like this where we really,
> >> really don't want anything ratelimited?
> >
> > Splitting the message is IMHO wrong thing, there are other subysystems
> > writing to the log so the lines can become scattered or interleaved with
> > the same message from other threads.
> 
> But that one line output is really hard to read for human beings.
> 
> Or do you mean that, as long as it's debug info, we should not care
> about readability at all?

Yes we shold care about readability but kernel printk output lines can
be interleaved, single line is much easier to grep for and all the
values are from one event. The format where it's a series of "key=value"
is common and I think we're used to it from tracepoints too. There are
lines that do not put "=" between keys and values we could unify that
eventually.
