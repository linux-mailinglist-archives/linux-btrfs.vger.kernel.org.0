Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9D66E207
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jan 2023 16:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjAQPZW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 10:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjAQPZD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 10:25:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8114B41B63
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 07:24:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4265B222A6;
        Tue, 17 Jan 2023 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673969059;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1brWK4SIhRTDl2o7WIvpHxK3T/GTVQV7+qk9JNn4FtQ=;
        b=z0dsLF0BhpPw7c10Z7RsphiYqVBQ38MoVnieFdN1KPrRoqTNntpu+fGDrXMbLyuGLX5qJJ
        q+2xDFR7USXmBveoeTJbJPV4H5dbfVXIKXm0eAkmQNtE46rjSjFdGcB07t4L2r8zdLHRO+
        pTYgN6XMkGhKPbwXIgSxjNkvAW7f4GQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673969059;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1brWK4SIhRTDl2o7WIvpHxK3T/GTVQV7+qk9JNn4FtQ=;
        b=jY1Lrq0B6eIhAaHgZZVylReTjM+3/xACipW2ER2WlazxNkmKIaUoamT5zKUJ1nI+BJ7zxS
        1ZqPkXB7XH6snkAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F0701390C;
        Tue, 17 Jan 2023 15:24:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oB6eBqO9xmOTSgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Jan 2023 15:24:19 +0000
Date:   Tue, 17 Jan 2023 16:18:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: check blkid version
Message-ID: <20230117151840.GZ11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230116030853.3606361-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116030853.3606361-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 16, 2023 at 12:08:53PM +0900, Naohiro Aota wrote:
> Prior to libblkid-2.38, it fails to detect zoned mode's superblock location
> and cause "blkid" to fail to detect btrfs properly. This patch suggets to
> upgrade libblkid if it detects <libblkid-2.38.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to devel, changelog replaced by Damien's text, thanks.
