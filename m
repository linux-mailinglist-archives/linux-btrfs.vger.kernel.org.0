Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28A47659A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 19:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjG0RNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 13:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjG0RMw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 13:12:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F497F7
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 10:12:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 13571219E6;
        Thu, 27 Jul 2023 17:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690477964;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNABAFZb/tttLeaRqr1t2Q7amyKl1WUqpeB1o5FcaWs=;
        b=FbrCH77sR6q8SyEMR1UwfTYNZwjJVhkM50sBvLdFo97wjHDiZsAWqjeJKF+XwvgOChHBgN
        BZp/Im6XBzOoTrVW1iH+/Wne6aULyeROKsaaQJv3qQqP9DndKowflOWRmePhjaIoa6fOL2
        9u4Qb+17TqaUBiTreSH1qM9bKzX4G1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690477964;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNABAFZb/tttLeaRqr1t2Q7amyKl1WUqpeB1o5FcaWs=;
        b=JeDjWgAmFe5nHISO+eBxMFN/Oymb+iUgCbSBarOU7bFGNr/yz8Jvv49ysnfVZTDiEfiTwT
        FKYoOa3Nh2bl16BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7AE913902;
        Thu, 27 Jul 2023 17:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id noDoN4ulwmSaYQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Jul 2023 17:12:43 +0000
Date:   Thu, 27 Jul 2023 19:06:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: small writeback fixes v2
Message-ID: <20230727170622.GH17922@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230724132701.816771-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724132701.816771-1-hch@lst.de>
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

On Mon, Jul 24, 2023 at 06:26:52AM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> this series has various fixes for bugs found in inspect or only triggered
> with upcoming changes that are a fallout from my work on bound lifetimes
> for the ordered extent and better confirming to expectations from the
> common writeback code.

I've so far merged patches 1-3, the rest will be in for-next as it's
quite risky and I'd appreciate more reviews.
