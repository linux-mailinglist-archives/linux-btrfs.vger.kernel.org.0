Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4C96A756F
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 21:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCAUfe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 15:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCAUfb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 15:35:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732604DE1A
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 12:35:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 120AE1FE4D;
        Wed,  1 Mar 2023 20:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677702926;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzQ5vkPppVWv5RX0TFze8TWW1jP3EOgI7Fka+LpNce0=;
        b=D4QbA//c0oAwQ5Tg0+DHeFsT+mxymEj+Pg/sAr5n1rmj+w4TzCZ18oqkCG61DHBRU6TD94
        +ezDkRAtLnaRpUqMjvBFouFBMBH0idITHjJeYCmfmSQHpiNA865OH0tg8N85YFmMyznEJA
        si6/7CfW1jNR48fQLsuvCrryrKjhnmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677702926;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzQ5vkPppVWv5RX0TFze8TWW1jP3EOgI7Fka+LpNce0=;
        b=t84YpsdcAsn+e94HWF0Isbs8doioT2IBGUMwZRsaPckSEU5fuqGNwfIq3uYivPXt4HvMya
        OCujbGx9iLB+NIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA39D13A3E;
        Wed,  1 Mar 2023 20:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fIw3OA23/2NEdwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Mar 2023 20:35:25 +0000
Date:   Wed, 1 Mar 2023 21:29:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/11] btrfs: remove @root and @csum_root arguments from
 scrub_simple_mirror()
Message-ID: <20230301202926.GC10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1673851704.git.wqu@suse.com>
 <6f42e541530e6b887fa4c3503b43a0909064d59a.1673851704.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f42e541530e6b887fa4c3503b43a0909064d59a.1673851704.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 16, 2023 at 03:04:13PM +0800, Qu Wenruo wrote:
> Grabbing extent/csum root for extent tree v2 is not that a huge
> workload, it's just a rb tree search.
> 
> Thus there is really not much need to pre-fetch it and pass it all the
> way from scrub_stripe().
> 
> And we already have more than enough arguments in scrub_simple_mirror()
> and scrub_simple_stripe(), it's better to remove them and only grab
> those roots in scrub_simple_mirror().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This one also applies and is an independent cleanup, added to misc-next.
