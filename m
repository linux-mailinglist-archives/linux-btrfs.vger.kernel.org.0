Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114F1750E95
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGLQaa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 12:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGLQa2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 12:30:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2FF2696
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 09:29:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCB4521F94;
        Wed, 12 Jul 2023 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689179390;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FchJxe9/GQIrRTOflCCkrruNeX656vguRZpDJSoe9IE=;
        b=qPL35Nev8uOopDoZt1lWTkiCMOEvByZH+PfB9v13zspa1jXyFwYSkbk9KE8M5coJ8BFuUe
        h5CS5LxgihtNTCcxTSIV1zT9vOCmuB//OHwYcF7Ya2PxNJm+3urpBwg1qHU4wsaZX2gak3
        rJxEBZFW/DNTXKvwePFTZT7fijR/E1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689179390;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FchJxe9/GQIrRTOflCCkrruNeX656vguRZpDJSoe9IE=;
        b=q6jvz00XiQ58u0XYiIY/LyDpTkc7SApku83qPb0zGXYRMOePRJMiSB7PVHEME0QpDWbSi4
        b9/J+9E4DEtRP9Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7D1213336;
        Wed, 12 Jul 2023 16:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2oZKKP7UrmQ0cQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 12 Jul 2023 16:29:50 +0000
Date:   Wed, 12 Jul 2023 18:23:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: do not enable async discard
Message-ID: <20230712162314.GM30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e22f5f69d881de1ec0e381f1be6bfe61b822c064.1688027756.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22f5f69d881de1ec0e381f1be6bfe61b822c064.1688027756.git.naohiro.aota@wdc.com>
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

On Thu, Jun 29, 2023 at 05:37:31PM +0900, Naohiro Aota wrote:
> The zoned mode need to reset a zone before using it. We rely on btrfs's
> original discard functionality (discarding unused block group range) to do
> the resetting.
> 
> While the commit 63a7cb130718 ("btrfs: auto enable discard=async when
> possible") made the discard done in an async manner, a zoned reset do not
> need to be async, as it is fast enough.
> 
> Even worth, delaying zone rests prevents using those zones again. So, let's
> disable async discard on the zoned mode.
> 
> Fixes: 63a7cb130718 ("btrfs: auto enable discard=async when possible")
> CC: stable@vger.kernel.org # 6.3+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.

> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -805,6 +805,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
>  		return -EINVAL;
>  	}
>  
> +	if (btrfs_test_opt(info, DISCARD_ASYNC)) {
> +		btrfs_warn(info, "zoned: disabling async discard as it is not supported");
> +		btrfs_clear_opt(info->mount_opt, DISCARD_ASYNC);
> +	}

I agree with the comments that using 'ignored' is better here, if you
look to the other checks in the function, NOCOW or SPACE_CACHE are not
sukpported and also lead to an error. In case of async discard it's
implemented in a sligly different way but it's not an error. I've also
changed the error level to info, a warning needs attention, in this case
it's not that serious IMHO.
