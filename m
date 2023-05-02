Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174786F4BE9
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 23:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjEBVNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 17:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBVNo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 17:13:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B2172E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 14:13:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9E5021F97;
        Tue,  2 May 2023 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683062018;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MmBrPwz8EQ9vGi2G2f1w57m5iT52s3/THikTxdTRrg=;
        b=wgq8Ap/5ItMTy+a8VnY0nD3UcEa2j99t//KcuoDLgnWLvIBFCi2YXzNvqt6Yv269R7i56M
        1SCaDtzS8cA+GNLvr0A9K5MEY330UV4PwqBsb5r4nQyPtFjgQNSB3vA7jFdFKtlUjh0t0v
        iZ4ui4v5j3qOWagkaYMGy46YXOGSf5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683062018;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MmBrPwz8EQ9vGi2G2f1w57m5iT52s3/THikTxdTRrg=;
        b=v9IYNDe37smv3PEBveG0iwBorvVWY/EwemeEFcv9InGucc4rtWqP8bolZzDOPgHCyHZADb
        dz815mU1LMQhCkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 244B3139C3;
        Tue,  2 May 2023 21:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GBLMBwJ9UWRURAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 21:13:38 +0000
Date:   Tue, 2 May 2023 23:07:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/8] btrfs-progs: sync uapi/btrfs.h into btrfs-progs
Message-ID: <20230502210742.GP8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681938911.git.josef@toxicpanda.com>
 <93f8af4b6a6164504f0aeb1221d57c59673f6df5.1681938911.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93f8af4b6a6164504f0aeb1221d57c59673f6df5.1681938911.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 19, 2023 at 05:17:12PM -0400, Josef Bacik wrote:
> We want to keep this file locally as we want to be uptodate with
> upstream, so we can build btrfs-progs regardless of which kernel is
> currently installed.  Sync this with the upstream version and put it in
> kernel-shared/uapi to maintain some semblance of where this file comes
> from.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> --- a/btrfs-fragments.c
> +++ b/btrfs-fragments.c
> @@ -31,7 +31,7 @@
>  #include <gd.h>
>  #include "kernel-shared/ctree.h"
>  #include "common/utils.h"
> -#include "ioctl.h"
> +#include "kernel-shared/uapi/btrfs.h"

The includes are now sorted in sections so I moved the uapi header to
the beginning of kernel-shared/ .

>  
> --- a/include/kerncompat.h
> +++ b/include/kerncompat.h
> @@ -576,5 +576,6 @@ typedef struct wait_queue_head_s {
>  
>  #define __init
>  #define __cold
> +#define __user

I got a compilation error

In file included from common/send-stream.c:24:
./kernel-shared/uapi/btrfs.h:141:60: error: expected ‘:’, ‘,’, ‘;’, ‘}’ or ‘__attribute__’ before ‘*’ token
  141 |                         struct btrfs_qgroup_inherit __user *qgroup_inherit;
      |                                                            ^

I did a hotfix to conditionally define __user in uapi.h so the whole
kerncompat.h is not included.
