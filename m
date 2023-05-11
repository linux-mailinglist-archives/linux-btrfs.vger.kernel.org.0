Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D33E6FF10A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 14:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjEKMGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 08:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjEKMGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 08:06:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CEE1FDD
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 05:06:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 220DB1FE5D;
        Thu, 11 May 2023 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683806791;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQfZZGcWHxzzh/hIxu7NaJARTBpjFm/trf75vMfwqaY=;
        b=pevCjXrgGAdyNhWB4xSgw8yOUevo5CwNGwfhnoAfLjsyty9RHcwwqCIFDR2V0zUvmqLwKX
        B5IUk/8cmjrtO1VywU2tG865HPIQRJbiieYjl/a8SMwLgV/QwkNy/OA0nJN+u8ClktZsej
        AI/fGy0la7tZhh8Iw15etgNcFxmC5xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683806791;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQfZZGcWHxzzh/hIxu7NaJARTBpjFm/trf75vMfwqaY=;
        b=12etUjhs2BKuRExLUkVxTr/sqdb+5B3oiBfXizi2zLgogt6mKtRl7anfVUTNSYJoytrzgU
        ymDsNqo05yenkGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFA2A134B2;
        Thu, 11 May 2023 12:06:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nk8wOUbaXGSrdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 11 May 2023 12:06:30 +0000
Date:   Thu, 11 May 2023 14:00:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] btrfs: handle tree backref walk error properly
Message-ID: <20230511120030.GY32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7d7e05a0148476dbf7cd8f076de1c076da68948e.1683792063.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7e05a0148476dbf7cd8f076de1c076da68948e.1683792063.git.wqu@suse.com>
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

On Thu, May 11, 2023 at 04:01:44PM +0800, Qu Wenruo wrote:
> [BUG]
> Smatch reports the following errors related to commit 3093caaa4d16
> ("btrfs: output affected files when relocation fails"):

This patch is still in misc-next so the commit id is unstable so I could
update it in place but you're also fixing the original code and the
change description applies to both I'll apply the patch separately.
Thanks.
