Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7A372D44D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 00:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjFLWTn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 18:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjFLWTl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 18:19:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE78102
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 15:19:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D7E351F45F;
        Mon, 12 Jun 2023 22:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686608378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HNyVeAx2u+08/5aLjWn/YhmSNioAohIeTXqmnMh3TPk=;
        b=j5ZHI6dgtHx46ObkoojHXMyHNK2T0/B7iUU1e7htb/PLAp5mjS57KoDuis4Ic5/N/IHygw
        amHQiUHk+2TDrWvYePmNw69qoJji0xB8o1+3ne1uTYT85GX/9nFCNC0GpEgGuoymetCtGB
        Y3xkkOHJCgPIWaEThaQhexx8gwjyfSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686608378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HNyVeAx2u+08/5aLjWn/YhmSNioAohIeTXqmnMh3TPk=;
        b=vl77JwypaYPkHYMmfKUC+7aZr1ga1vMJr8zLSEz/UQbcQvuyDhLGudwrh6rPm0T8V6wyen
        d50gxJ3B/8cY1tAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF979138EC;
        Mon, 12 Jun 2023 22:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6jr+KfqZh2R+WAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Jun 2023 22:19:38 +0000
Date:   Tue, 13 Jun 2023 00:13:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: do not BUG_ON() on unexpected symlink data
 extent
Message-ID: <20230612221319.GH13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f3c6cadc84e001f786b82ef540cf39e9e8ce859e.1686566191.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c6cadc84e001f786b82ef540cf39e9e8ce859e.1686566191.git.fdmanana@suse.com>
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

On Mon, Jun 12, 2023 at 11:40:59AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's really no need to BUG_ON() if we find a symlink with an extent
> that is not inline or is compressed. We can just make send fail with
> an error (-EUCLEAN) and log an informative error message, so just do
> that instead of BUG_ON().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
