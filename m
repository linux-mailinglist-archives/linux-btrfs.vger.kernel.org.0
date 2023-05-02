Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0E06F4B7D
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 22:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjEBUlE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 16:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEBUlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 16:41:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381AA10D9
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 13:41:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1E2D41F88B;
        Tue,  2 May 2023 20:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683060060;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=joBZIAMxoO3HoK2K4hbe6PUtrUYmQjzQDkVT6OIglss=;
        b=m6gKXm75K0dCoyZPGojlNNgqR2Vf+QYorkM2Ps3KUCdwj0YVBccm2cVPBvo1IgLU5Qk4ls
        a6NWCL5i502j05mt1fb5h+8Xfc1Yxb8m0VISNjgTTJ1Fuqyb+vISmbOdeBu5/R7iKkf45N
        /aSMHGQ5zk2go3g+D0vRJa0uHgGnryc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683060060;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=joBZIAMxoO3HoK2K4hbe6PUtrUYmQjzQDkVT6OIglss=;
        b=Bkw+AgzgIoyv+Xx6RoNuhjv5M56Z5BCiWcwSjJIysAYlxoUvHYxJJIikIrp2f/qO3N7Wz8
        RpSeA4E6UZMHZbCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3183134FB;
        Tue,  2 May 2023 20:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 73x1Olt1UWR1NgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 20:40:59 +0000
Date:   Tue, 2 May 2023 22:35:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 06/11] btrfs-progs: remove the _on() related message
 helpers
Message-ID: <20230502203504.GN8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681938648.git.josef@toxicpanda.com>
 <e9c06678e0b87678c9b753358c5bfe9667c07008.1681938648.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c06678e0b87678c9b753358c5bfe9667c07008.1681938648.git.josef@toxicpanda.com>
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

On Wed, Apr 19, 2023 at 05:13:48PM -0400, Josef Bacik wrote:
>  #define error_on(cond, fmt, ...)					\
>  	do {								\
> -		if ((cond))						\
> +		if ((cond)) {						\
>  			PRINT_TRACE_ON_ERROR;				\
> -		if ((cond))						\
>  			PRINT_VERBOSE_ERROR;				\
> -		__btrfs_error_on((cond), (fmt), ##__VA_ARGS__);		\
> -		if ((cond))						\
> -			DO_ABORT_ON_ERROR;				\

The DO_ABORT_ON_ERROR got accidentally dropped, it should be there as
it's how 'make D=abort' is implemented.

> +			__btrfs_error((fmt), ##__VA_ARGS__);		\
> +		}							\
>  	} while (0)
