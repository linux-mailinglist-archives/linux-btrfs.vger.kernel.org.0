Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131B2598A54
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344965AbiHRRVn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 13:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245653AbiHRRVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 13:21:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F0F5C362;
        Thu, 18 Aug 2022 10:19:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1BBF31F8C9;
        Thu, 18 Aug 2022 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660843166;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NRvraFGp4jiu+Zv6R16UajS2/oeIiXb+VaX74HP2TW4=;
        b=bjjh35Iv4gxwXIPmtG7SfCHHnPd5p5v80PuTaeTC3aPB99KurVwUZyewv9e3rE1Rx9P+Sp
        Qiun7yKw7BJPdYlrJ+EUFQr0fIJz6X3czrNu8a3j633IDs+EjDqYAuNXlS2pv5MA/UuZ3v
        tDvm9ImOJlrA0aN8rCow6nrdlhnt/vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660843166;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NRvraFGp4jiu+Zv6R16UajS2/oeIiXb+VaX74HP2TW4=;
        b=m9yyGEmSUbV95zuM+a0Lg/Fc1vmv/i81uHckjP11hrIxu3AExfAaEbKun/ESKLiEAUE0mb
        zPzQn78ne6R1VEDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2D10133B5;
        Thu, 18 Aug 2022 17:19:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5FVfNp10/mLmQAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 18 Aug 2022 17:19:25 +0000
Date:   Thu, 18 Aug 2022 19:14:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs/btrfs: Use atomic_try_cmpxchg in free_extent_buffer
Message-ID: <20220818171414.GM13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Uros Bizjak <ubizjak@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <20220809163633.8255-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809163633.8255-1-ubizjak@gmail.com>
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

On Tue, Aug 09, 2022 at 06:36:33PM +0200, Uros Bizjak wrote:
> Use `atomic_try_cmpxchg(ptr, &old, new)` instead of
> `atomic_cmpxchg(ptr, old, new) == old` in free_extent_buffer. This
> has two benefits:
> 
> - The x86 cmpxchg instruction returns success in the ZF flag, so this
>   change saves a compare after cmpxchg, as well as a related move
>   instruction in the front of cmpxchg.
> 
> - atomic_try_cmpxchg implicitly assigns the *ptr value to &old when
>   cmpxchg fails, enabling further code simplifications.
> 
> This patch has no functional change.
> 
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

It's not in a performance critical code but resulting code is slightly
more efficient. Added to misc-next, thanks.
