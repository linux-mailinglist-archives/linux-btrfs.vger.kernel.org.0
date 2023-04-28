Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DDF6F1CE2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345577AbjD1QuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjD1QuU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 12:50:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA7C1BE1;
        Fri, 28 Apr 2023 09:50:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7971921FB3;
        Fri, 28 Apr 2023 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682700618;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IeIGn4WxBnNBbmVboH01Cjg65KbsCoqzWQcho11oAOg=;
        b=nora5UqNFYrHfWmxHpb7yk2er9k8uD30AU3Qb4NEqqf3hl3ovtOH0MbwpMCv52oAEwh9QO
        Kc7CSki2ZO2GqqGLKe8hAxlwXJ/vCrDUx3DUKdW1O+qdYaTsC2fSNaoN8s49hRAW/akAQ5
        iCwJhj74FgU05HhmNXdwTQCAWxo+3fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682700618;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IeIGn4WxBnNBbmVboH01Cjg65KbsCoqzWQcho11oAOg=;
        b=NnPAiUBn1USuwMWaAUosLNELLm1gIs7crZLtq5JniyJgO7UDU/+t2WHyFZB8rAq3fItaCl
        uH6bW4Qddd7d51CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 403451390E;
        Fri, 28 Apr 2023 16:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CvPcDkr5S2R1BgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 28 Apr 2023 16:50:18 +0000
Date:   Fri, 28 Apr 2023 18:44:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     =?utf-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCR0LXQu9C+0LLQsA==?= 
        <abelova@astralinux.ru>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] btrfs: parent bytenr must be aligned to sector size
Message-ID: <20230428164425.GD2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230426115323.9455-1-abelova@astralinux.ru>
 <8fb6638f-1e99-a1c1-3fa1-f814d08d2659@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fb6638f-1e99-a1c1-3fa1-f814d08d2659@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 26, 2023 at 08:25:14PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/4/26 19:53, Анастасия Белова wrote:
> > From: Anastasia Belova <abelova@astralinux.ru>
> > 
> > Change nodesize to sectorsize in alignment check
> > in print_extent_item. Change requirement in comment.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: ea57788eb76d ("btrfs: require only sector size alignment for parent eb bytenr")
> > Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> A little surprised that a static checker can even find such hidden problem.

I've seen in Coverity a fuzzy report like "there are 8 cases that do
thing X and this one does not, is it expected?" which is basically just
pattern matching but can be caused by copy&paste mistakes.
