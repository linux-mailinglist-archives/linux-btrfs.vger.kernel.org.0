Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6BC7DCF65
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 15:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjJaO3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 10:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjJaO3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 10:29:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1610CDA
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 07:29:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6DF221863;
        Tue, 31 Oct 2023 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698762587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8Bm8TJRbT3afNtbGCs3DwquCMoIkGjzzZPYsrTd3eY=;
        b=R9t0+3jaaK2oFH7YJtUpFiT+03yY0qUVUaeW9RvmgD5YABkOAwJwdgLAvtuK71Z5pSB6vg
        uPBn9jr/EizBrzatZiG06H3CKIhWZWgQ8j8U5KngOkSWkNI2/jX0+i5Nd3eFf7TNmgdTxr
        1lPLNEbyO3vNmaGGZ82sQDNiDUTO1G8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698762587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8Bm8TJRbT3afNtbGCs3DwquCMoIkGjzzZPYsrTd3eY=;
        b=n226ugX7A6ZeXNSR+mPmzU2ldQfQMEJ6Rcr3CME8gwqplC6pHq38qmXIF7tdTvIZ//chVD
        uOWL55gSRMlcRVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADC3B1391B;
        Tue, 31 Oct 2023 14:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id psd1KVsPQWVWEwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 31 Oct 2023 14:29:47 +0000
Date:   Tue, 31 Oct 2023 15:22:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix error pointer dereference after failure to
 allocate fs devices
Message-ID: <20231031142249.GD11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <86c522f5e01e438b4a9cc16a0bda87a207d744e6.1698666319.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c522f5e01e438b4a9cc16a0bda87a207d744e6.1698666319.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 30, 2023 at 11:54:23AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At device_list_add() we allocate a btrfs_fs_devices structure and then
> before checking if the allocation failed (pointer is ERR_PTR(-ENOMEM)),
> we dereference the error pointer in a memcpy() argument if the feature
> BTRFS_FEATURE_INCOMPAT_METADATA_UUID is enabled.
> Fix this by checking for an allocation error before trying the memcpy().
> 
> Fixes: f7361d8c3fc3 ("btrfs: sipmlify uuid parameters of alloc_fs_devices()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
