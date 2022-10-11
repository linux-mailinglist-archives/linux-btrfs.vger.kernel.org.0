Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248635FB19D
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 13:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJKLhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJKLhx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 07:37:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C180E7DF5D
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 04:37:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DD4C227BB;
        Tue, 11 Oct 2022 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665488271;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AC9Edt2r/thvOvhK57Wm6TgzVs7n2+m2Lqbtf2UgM14=;
        b=QoB0JO02+mAVLMcVjzxH7sWm2e6FrVEkpapB7DzXH2weRaWNbk5u7TuiapEUEgbJyRKT5c
        PQ+DZzrAbNyxCrDXp5FhI3WrtRu1M+Qg3VI8zBfXgx8+WPU4JNogkINA8lVxLoaNPgYz45
        LG3kfZm0bQsmUCfS6kYewDQKbJGqVyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665488271;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AC9Edt2r/thvOvhK57Wm6TgzVs7n2+m2Lqbtf2UgM14=;
        b=7tizcevgdkCriikHbxg5yx0TWfAPZ8yKpGo4lCICVnZEs4yNIdk3a5SYle8IlwR+iL75+k
        m9pYFjwiozzPw5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 403EA13AAC;
        Tue, 11 Oct 2022 11:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /SouDo9VRWNIOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 11:37:51 +0000
Date:   Tue, 11 Oct 2022 13:37:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 15/16] btrfs: move btrfs_map_token to item-accessors
Message-ID: <20221011113745.GP13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663175597.git.josef@toxicpanda.com>
 <980fa7926d0aa651c42a4ff4e58c0d644d712b7e.1663175597.git.josef@toxicpanda.com>
 <20221011103907.GN13389@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011103907.GN13389@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 12:39:07PM +0200, David Sterba wrote:
> On Wed, Sep 14, 2022 at 01:18:20PM -0400, Josef Bacik wrote:
> > +void btrfs_init_map_token(struct btrfs_map_token *token,
> > +			  struct extent_buffer *eb)
> > +{
> > +	token->eb = eb;
> > +	token->kaddr = page_address(eb->pages[0]);
> > +	token->offset = 0;
> 
> This is prooobably ok to be uninlined, it's called once when used and
> all call sites typically do lot of work using the token but still a
> function call for three simple assignments does not look optimal.

It looks simple in C but in asm it's about 27 instructions due to
page_address that does some masking and and check. Overall, uninlining
seems ok.
