Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD3691157
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 20:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBITaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBIT37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 14:29:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BF1EE
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 11:29:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B046D37AA2;
        Thu,  9 Feb 2023 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675970997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GqGDZRJHN1GRA+VnoX3TbpKC3G0ke0jb8Uis0uGf0vw=;
        b=JHYdipS+bE+sdSNSP0ErCnDUe5ncuAVZYEgVMRlTewzxR9WN+UonNVUl11QmT/k9ZXgKUD
        nATeyx7lb9kxV3tG99kdz8AHd2/xWWKrsMjeLQikAe29M0ZbUUdb9drBhklvMxHDRQMxU1
        GO9d5xFuUu/hy3Yq5xGGcoT0XZw4KB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675970997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GqGDZRJHN1GRA+VnoX3TbpKC3G0ke0jb8Uis0uGf0vw=;
        b=upJ78h+RlETfUC7E5QqCjOzfbwkLOPgCVCmPoa1rL6YMddc3NkhnoHdFoPRJYetKwC0v3e
        C4ZhZn0TyamroTDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EAF6138E4;
        Thu,  9 Feb 2023 19:29:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tnhYHbVJ5WOUMgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Feb 2023 19:29:57 +0000
Date:   Thu, 9 Feb 2023 20:24:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/5] btrfs-progs: fix fallthrough cases with proper
 attributes
Message-ID: <20230209192407.GN28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1674797823.git.wqu@suse.com>
 <56794e8e6e0717c5fc981cfb3a96e4b1b5180818.1674797823.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56794e8e6e0717c5fc981cfb3a96e4b1b5180818.1674797823.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 27, 2023 at 01:41:16PM +0800, Qu Wenruo wrote:
> --- a/kerncompat.h
> +++ b/kerncompat.h
> @@ -227,6 +227,14 @@ static inline int mutex_is_locked(struct mutex *m)
>  #define __attribute_const__	__attribute__((__const__))
>  #endif
>  
> +/* To silent compilers like clang which doesn't understand comments. */
> +
> +#if __has_attribute(__fallthrough__)

The use of __has_attribute should be beihnd and ifdef
(https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005fattribute.html)
otherwise it fails, eg. on the reference Centos 7 build. Fixed.


> +# define fallthrough			__attribute__((__fallthrough__))
> +#else
> +# define fallthrough			do {} while (0)  /* fallthrough */
> +#endif
