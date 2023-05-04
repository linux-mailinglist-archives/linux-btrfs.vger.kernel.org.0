Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECB26F77E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 23:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjEDVQ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 17:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEDVQ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 17:16:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36413840
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 14:16:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25C141F88D;
        Thu,  4 May 2023 21:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683235014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6XG5m+BFc/k7M8P9qRQeaCJ0Keim9DZoX5Mn13wezk=;
        b=sOj/mjz//VquiwBOeirDA11Wy0SDgGNJxBPLhpErKgBVnHrT2MVwWaTrktA8uo7+Kw66tY
        b/4VFJD3rBkeAwa15YVjqwOHROK9hrCH7rI4nQJ7YW3iGmbeznSKz0C1f70oIg4MeLTrC+
        m1RNrL+OYA45ClY6Yy7naL3Ak262teQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683235014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6XG5m+BFc/k7M8P9qRQeaCJ0Keim9DZoX5Mn13wezk=;
        b=X0mKig6mD3mAleXEG1QN/Oq3cCK44U+xHk8NKr9ge0W9Mu4SX+q3fmshMp7Vuo3sq9udng
        k5OfsbiUgN+kVZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA252133F7;
        Thu,  4 May 2023 21:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VzpgOMUgVGR/OwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 May 2023 21:16:53 +0000
Date:   Thu, 4 May 2023 23:10:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: fix static_assert for older gcc
Message-ID: <20230504211057.GG6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <85f3af8298a4d7b6e40045aa7c6873d7ae1bc311.1683206686.git.anand.jain@oracle.com>
 <20230504143321.GF6373@twin.jikos.cz>
 <e74a3f59-0ee5-b2f4-5377-cb48d9d170fe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e74a3f59-0ee5-b2f4-5377-cb48d9d170fe@oracle.com>
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

On Thu, May 04, 2023 at 10:56:18PM +0800, Anand Jain wrote:
> 
> 
> On 04/05/2023 22:33, David Sterba wrote:
> > On Thu, May 04, 2023 at 09:56:37PM +0800, Anand Jain wrote:
> >> Make is failing on gcc 8.5 with definition miss match error. It looks
> >> like the definition of static_assert has changed
> >>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>   fs/btrfs/accessors.h | 14 ++++++++------
> >>   1 file changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> >> index ceadfc5d6c66..c480205afac2 100644
> >> --- a/fs/btrfs/accessors.h
> >> +++ b/fs/btrfs/accessors.h
> >> @@ -58,29 +58,31 @@ DECLARE_BTRFS_SETGET_BITS(16)
> >>   DECLARE_BTRFS_SETGET_BITS(32)
> >>   DECLARE_BTRFS_SETGET_BITS(64)
> >>   
> >> +#define _static_assert(x)	static_assert(x, "")
> > 
> > So the problem is that the message is mandatory on older compilers?
> 
> 
> I couldn't confirm the GCC version and static_assert changes, but found 
> the kernel wrapper in ./tools/include/linux/build_bug.h.

This is in tools but there's same in linux/include/build_bug.h, without
the ifdef.

> /**
>   * static_assert - check integer constant expression at build time
>   *
>   * static_assert() is a wrapper for the C11 _Static_assert, with a
>   * little macro magic to make the message optional (defaulting to the
>   * stringification of the tested expression).
>   *
>   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
>   * scope, but requires the expression to be an integer constant
>   * expression (i.e., it is not enough that __builtin_constant_p() is
>   * true for expr).
>   *
>   * Also note that BUILD_BUG_ON() fails the build if the condition is
>   * true, while static_assert() fails the build if the expression is
>   * false.
>   */
> #ifndef static_assert
> #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> #endif // static_assert

The static_assert is defined by compiler so the first thing we see is
that one (I think) but kernel defines its own and that has the mesage
optional.

For the fix I added a _static_assert(expr) that does does not clash with
the existing static_assert and only expands the expression to the
message and then passes it to _Static_assert.
