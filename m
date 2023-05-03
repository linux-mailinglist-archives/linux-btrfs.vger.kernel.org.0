Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430906F56BC
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjECLBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 07:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjECLBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 07:01:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DE25269
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 04:00:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D5892266E;
        Wed,  3 May 2023 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683111649;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+J2gLFNc0QXuc/sW0eL6jcy8hYgjxZoCenJHggr5+HY=;
        b=0gSh6ZeogBYpwrDBkN4kbW98hY2eHq49wg4SK+48LY7t2J32fIsHsxzxE1AHh6zcR77vGq
        EuPaxUbGI9tMfEqGyVSNn9ZdBwSLxch3z/hHqHm3JkBo8NR1QtTjauUwHMNm5rWYqI4vIu
        xV4UbgpHhU2DYjtHemNFkVPpsqB36yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683111649;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+J2gLFNc0QXuc/sW0eL6jcy8hYgjxZoCenJHggr5+HY=;
        b=9z83PiXAJd8X+tRr5QIGagU3XaIKpQj/XgE+D++6D1sMmH+XlhAO2un1lrvctx6Ec65Jlq
        jRhOycLFXh4/lgCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8ADB13584;
        Wed,  3 May 2023 11:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C8TwN+A+UmTySQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 May 2023 11:00:48 +0000
Date:   Wed, 3 May 2023 12:54:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/8] btrfs-progs: sync uapi/btrfs.h into btrfs-progs
Message-ID: <20230503105453.GA6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681938911.git.josef@toxicpanda.com>
 <93f8af4b6a6164504f0aeb1221d57c59673f6df5.1681938911.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f8af4b6a6164504f0aeb1221d57c59673f6df5.1681938911.git.josef@toxicpanda.com>
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

On Wed, Apr 19, 2023 at 05:17:12PM -0400, Josef Bacik wrote:
> -#include <stddef.h>
> -
> -#ifndef __user
> -#define __user
> -#endif
> -
> -/* We don't want to include entire kerncompat.h */
> -#ifndef BUILD_ASSERT
> -#define BUILD_ASSERT(x)
> -#endif
> +#include <linux/fs.h>
>  
>  #define BTRFS_IOCTL_MAGIC 0x94
>  #define BTRFS_VOL_NAME_MAX 255
> +#define BTRFS_LABEL_SIZE 256
>  
>  /* this should be 4k */
>  #define BTRFS_PATH_NAME_MAX 4087
> @@ -45,18 +38,20 @@ struct btrfs_ioctl_vol_args {
>  	__s64 fd;
>  	char name[BTRFS_PATH_NAME_MAX + 1];
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);

> -BUILD_ASSERT(sizeof(struct btrfs_qgroup_limit) == 40);

> -BUILD_ASSERT(sizeof(struct btrfs_qgroup_inherit) == 72);

You removed all the BUILD_ASSERTS, I vaguely remember that this was
mentined in some previous iteration of the uapi sync that this should
stay and be synced back to kernel rather than removed.

I'll keep the commit as-is for now, there are probably more lost changes
like that, for later.
