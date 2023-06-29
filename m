Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0B74288A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 16:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjF2Ogl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 10:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjF2Ogg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 10:36:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5D535A9;
        Thu, 29 Jun 2023 07:36:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC22D2185F;
        Thu, 29 Jun 2023 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688049393;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=04nmGvUSzed+RPQKn6uXEdcAH6zz7Jtopau6rGJZL1k=;
        b=Iq6dIclc7ejdPofm+LEOQzVdIwCxpSRlwc75ebbbiEtfMfPFYjXaXpXU/vDZO1se8KnBqy
        bpUJgRrBMXGnIsUzM5vMR6BYlownsDLgNmtNLnQCK8oTQwrK0BGvkLVdSN+7NiSC2lohLG
        GdbDXbUmIsRw0WJ+yST7BNMK6KDD/AY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688049393;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=04nmGvUSzed+RPQKn6uXEdcAH6zz7Jtopau6rGJZL1k=;
        b=gEATPY1wmD/1EbHlFSEY21Xl/mFaUerI5BNNhVmAgYvyKyGEIpDS37PDQiLyxX/9X0BuZH
        7LpdDHTWZcRU6kAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A01A113905;
        Thu, 29 Jun 2023 14:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q3ZQJvGWnWSQHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 14:36:33 +0000
Date:   Thu, 29 Jun 2023 16:30:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Chris Mason <clm@fb.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/26] btrfs: zoned: use array_size
Message-ID: <20230629143005.GJ16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-13-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623211457.102544-13-Julia.Lawall@inria.fr>
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

On Fri, Jun 23, 2023 at 11:14:43PM +0200, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>     size_t e1,e2;
>     expression COUNT;
>     identifier alloc = {vmalloc,vzalloc,kvmalloc,kvzalloc};
> @@
> 
> (
>       alloc(
> -           (e1) * (e2)
> +           array_size(e1, e2)
>       ,...)
> |
>       alloc(
> -           (e1) * (COUNT)
> +           array_size(COUNT, e1)
>       ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Added to misc-next with updated subject and changelog, thanks.
