Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7E70FE9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 21:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjEXTjD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 15:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEXTjB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 15:39:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE46612F
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:38:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A944621D30;
        Wed, 24 May 2023 19:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684957129;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ewD/lduBJ5Me4QlIcDJNiai7BP9dwtEB6k/HVRBKkd8=;
        b=DBhIgqTTXWNihdqgxJOYxjnOAA5bmtSvdzkv0D9LQVVhRvvwKCgtB1gOywd1+0NON0PAGq
        kZZf2nHb1/yD/TxJ1RuUEkZ5ppapmKv5KP03itNmTfReoNoW1Q1v2COWQRv5u+1gltUmvh
        Q/0RjR6pe7AYyrpN0Qr7tJ9bH6sploI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684957129;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ewD/lduBJ5Me4QlIcDJNiai7BP9dwtEB6k/HVRBKkd8=;
        b=YpXUfx0cVno/tdc0OBQY30xkm/w8hajmaQEY8nZYnMJrDsonIBU3Tc0SI+F2luebhFO7AW
        SzhN7HcyMwHZWVDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 901A113425;
        Wed, 24 May 2023 19:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QZ4cIslnbmQgLAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 24 May 2023 19:38:49 +0000
Date:   Wed, 24 May 2023 21:32:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/7] btrfs-progs: libbtrfs: remove the support for fs
 without uuid tree
Message-ID: <20230524193241.GB30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1683093416.git.wqu@suse.com>
 <6e07c5dd154bc70f9f0a1f9c31cede88dd564bb3.1683093416.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e07c5dd154bc70f9f0a1f9c31cede88dd564bb3.1683093416.git.wqu@suse.com>
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

On Wed, May 03, 2023 at 02:03:38PM +0800, Qu Wenruo wrote:
> -#else
> -int subvol_uuid_search_init(int mnt_fd, struct subvol_uuid_search *s)
> -{
> -	s->mnt_fd = mnt_fd;
> -
> -	return 0;
> -}
> -
> -void subvol_uuid_search_finit(struct subvol_uuid_search *s)
> -{
> -}
> -#endif

This patch breaks 'make library-test', I haven't noticed until now. The
functions are exported in libbtrfs so can't be delted, only the first
part of the #ifdef.
