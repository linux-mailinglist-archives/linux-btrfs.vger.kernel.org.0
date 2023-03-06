Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003CD6ACD7F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Mar 2023 20:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCFTE6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 14:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCFTEp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 14:04:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193EB20570
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 11:04:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC39221C6D;
        Mon,  6 Mar 2023 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678129464;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/pWFLFTVFQee1Uw8DONhn+dm5PlhzA7rmDQoMVdYiU=;
        b=MBQwuQ6pApSS99kb9IixHTIIO+fdWcWtDw4OTtSYNyEkk9HXeodW1oz6iN3mbvipu+TxE2
        6o4Za7oxt379QP5UxwN2ELME4ytfTCEVTMF3waIrxQ/28DeTv/1ShKOeMIsMVs4iqcpZQU
        lvDzZIS3GyROs1QAxzhh1yN0usDytvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678129464;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/pWFLFTVFQee1Uw8DONhn+dm5PlhzA7rmDQoMVdYiU=;
        b=0c8LtaPZAK2B/8x8L1eccibLM+MNzlBOf5C14HDqrmYobFOdZop7lVN2t5Kp95BehiqUs8
        wFPPy1qjpz1yoVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D3B313A66;
        Mon,  6 Mar 2023 19:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5GNOJTg5BmQ1JgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Mar 2023 19:04:24 +0000
Date:   Mon, 6 Mar 2023 19:58:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove redundant clear NODISCARD
Message-ID: <20230306185822.GF10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <73233a37a2e5ce11f8eff689c9f2eef4d8fcbee0.1677745385.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73233a37a2e5ce11f8eff689c9f2eef4d8fcbee0.1677745385.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 09:30:48PM +0800, Anand Jain wrote:
> If no discard mount option is specified, including the NODISCARD option,
> we make the async discard the default option then we don't have to call
> the clear_opt again to clear the NODISCARD flag.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

This is maybe 3rd time somebody points out the redundant clearing of the
discard flags so I'll apply the patch. Thanks.
