Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98EE750E38
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGLQUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 12:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjGLQUC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 12:20:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091232D74
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 09:17:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47E5E21D25;
        Wed, 12 Jul 2023 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689178650;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0kiMISfx1ggOn1ocbNTI+YJzakczL5IDrJco9ltzjX8=;
        b=ppLuEEbVNOJqpsxQfn2bgrHW3bMwderuJvUUgP4X/d7fPP3lZeQFu66n6v74Ys0GXtQhl0
        I1Prz1+2eUqOYU1GoysPpeu2ZJSVtnPP8pg45s3dAEmHIjNRe6YWQo1ZLVkJcd6K2cOe16
        TeEYAWCNk0XUKEDSAYUTIsfXc6v+OXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689178650;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0kiMISfx1ggOn1ocbNTI+YJzakczL5IDrJco9ltzjX8=;
        b=TUuvXwDfmuxDWTrtlddR/Lf/4OaxxbxN18ByeemVV/aGoKWhHawizK8GP/QBLsFULnah2D
        OfBMxNOyojL+aNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23B7713336;
        Wed, 12 Jul 2023 16:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tXJOBxrSrmSYaAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 12 Jul 2023 16:17:30 +0000
Date:   Wed, 12 Jul 2023 18:10:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 8/8] btrfs: move btrfs_free_excluded_extents() into
 block-group.c
Message-ID: <20230712161054.GL30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cb507b1dbff5ee7f776d98a9ea1da0d40ddeacfc.1688137156.git.fdmanana@suse.com>
 <20230707221740.GH2565448@zen>
 <365b60d2-32f2-9b60-a326-d3959592cb67@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <365b60d2-32f2-9b60-a326-d3959592cb67@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 10, 2023 at 10:56:19AM +0100, Filipe Manana wrote:
> On 07/07/23 23:17, Boris Burkov wrote:
> > On Fri, Jun 30, 2023 at 04:03:51PM +0100, Filipe Manana wrote:
> >> The function btrfs_free_excluded_extents() is only used by block-group.c,
> >> so move it into block-group.c and make it static. Also removed unnecessary
> >> variables that are used only once.
> > 
> > Since you added the btrfs_ for the function that's exported in the
> > header earlier I think it would be nice to also drop it from this
> > one as it goes static in block_group.c.
> 
> I don't think we have a policy to make static function without the 
> "btrfs_" prefix mandatory. We have plenty of cases with and without the 
> prefix.
> 
> Personally I prefer to have the prefix, because when reading a function 
> call it makes it obvious that it's btrfs code and not generic code being 
> called.
> 
> However I'm not against dropping the prefix, if that's what everyone 
> prefers.

I think we don't have a strict policy here, exported functions should
have the btrfs_ prefix unless there's some other common prefix or
historical reasons. For static helper it's nice to have to make the
functions obvious in stack traces but some simple helpers don't need it.
More prefixes or naming unifications are probably better in the long run.
