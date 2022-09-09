Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F365B36A8
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiIILr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiIILr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 07:47:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A35A131EDC
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 04:47:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9855E1F8E8;
        Fri,  9 Sep 2022 11:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662724045;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6jQc9RtoOYNGB35tBeM6NaJJnQVyNWwTyaGkP1QjqMA=;
        b=DYU3rIQ35C8WipjyDNj38KTHe+A5Tfz/smn1xvxYuA6NGbVMBb1287QnmYZOAfO9qX/Co3
        Ve1q65mbLGCUFa4EthNiMcAIOjKoyMabRFahMaB9bh1jSoj2UUNjuMVbLePnSJnbfHVoTt
        mQKTqKTbQHQm7qBPN39OZzteON+cNKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662724045;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6jQc9RtoOYNGB35tBeM6NaJJnQVyNWwTyaGkP1QjqMA=;
        b=AXd5xFIbrdxh4VSVQr+bgr2/ATHTAoA59LCITuUkItmQ9KVejkBGfb3qWw/yf2MHI3Wa1g
        wzngDu0tLt2fVIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A57013A93;
        Fri,  9 Sep 2022 11:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UuL9HM0nG2M8GgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 09 Sep 2022 11:47:25 +0000
Date:   Fri, 9 Sep 2022 13:42:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/6] btrfs-progs: interpret encrypted file extents.
Message-ID: <20220909114201.GV32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662417859.git.sweettea-kernel@dorminy.me>
 <c8ab87232868695aa4e9947c7cea20feea1463c3.1662417859.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8ab87232868695aa4e9947c7cea20feea1463c3.1662417859.git.sweettea-kernel@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 05, 2022 at 08:01:04PM -0400, Sweet Tea Dorminy wrote:
> -
> +	/*
> +	 * Fscrypt extent encryption context. Only present if extent is
> +	 * encrypted (stored in the encryption field).
> +	 */
> +	__u8 fscrypt_context[0];
>  } __attribute__ ((__packed__));
>  
>  struct btrfs_dev_stats_item {
> @@ -2449,6 +2454,23 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
>  		   encryption, 8);
>  BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
>  		   other_encoding, 16);
> +static inline u8
> +btrfs_file_extent_encryption_ctxsize(const struct extent_buffer *eb,
> +				     struct btrfs_file_extent_item *e)

Please use same coding style as in kernel

> --- /dev/null
> +++ b/kernel-shared/fscrypt.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BTRFS_FSCRYPT_H
> +#define BTRFS_FSCRYPT_H
> +
> +#define BTRFS_ENCRYPTION_POLICY_MASK 0x03
> +#define BTRFS_ENCRYPTION_CTXSIZE_MASK 0xfc

The definitions should match what's in kernel, the file will be
problably 1:1 so it can be synced once kernel side is finalized.
