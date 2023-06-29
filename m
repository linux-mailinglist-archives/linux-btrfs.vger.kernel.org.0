Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6227E742B15
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjF2RRV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2RRU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 13:17:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999F3595
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 10:17:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D3EC1F74C;
        Thu, 29 Jun 2023 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688059038;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0hJIKGbg64iX7iAgYiX0hc2MzFIp6mvTf6Ku0gIJyE=;
        b=wuAreWbPhem22Sks+Qdwi6M3X6S68FQzcXcLx4U6PHDYpksUAZn93gUrruwdS3vzbGyRcN
        oDXIDQfty2+uGHnZm+xD4//+wc2lNrL+0TVnsWBic0qVmnqWVabepXAuF4CNZ65guYknuZ
        EGkUSeCgK0sM+Fdmv4hdxHHygKynxVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688059038;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0hJIKGbg64iX7iAgYiX0hc2MzFIp6mvTf6Ku0gIJyE=;
        b=OXLVci2avDFEY8k0x/W31zM7ehTfX7CJKQ1qv986+ugo7XxieCmqh57Ni3EqoJDVYD7gEb
        ze0KAPCmXDnOAwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15BC613905;
        Thu, 29 Jun 2023 17:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dgZ5BJ68nWS6agAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 17:17:18 +0000
Date:   Thu, 29 Jun 2023 19:10:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: raid56: simplify the trace events
Message-ID: <20230629171049.GT16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e4b532ed0249d996d86446f41fe7f6bce46462d6.1687244580.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b532ed0249d996d86446f41fe7f6bce46462d6.1687244580.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 20, 2023 at 03:06:05PM +0800, Qu Wenruo wrote:
> After commit 6bfd0133bee2 ("btrfs: raid56: switch scrub path to use a
> single function"), the raid56 implementation no longer uses different
> endio functions for rmw/recover/scrub.
> 
> All read operations end in submit_read_wait_bio_list(), while all write
> operations end in submit_write_bios().
> 
> This means quite some trace events are out-of-date and no longer
> utilized.
> 
> This patch would unify the trace events into just two:
> 
> - trace_raid56_read()
>   Replaces trace_raid56_read_partial(), trace_raid56_scrub_read() and
>   trace_raid56_scrub_read_recover().
> 
> - trace_raid56_write()
>   Replaces trace_raid56_write_stripe() and
>   trace_raid56_scrub_write_stripe().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
