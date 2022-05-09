Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D251FC72
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 14:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiEIMTG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiEIMTF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 08:19:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D3E1A15FB;
        Mon,  9 May 2022 05:15:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A75FE1FA27;
        Mon,  9 May 2022 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652098510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZLAPJKcbDVRaqwiPA0oK3gia0xcoJgXTboinEMlZexw=;
        b=ZbfxaMEzrQw1w58uHht3ATBfiQraq7t1qVtfy8Y9CmF/40vusbF3zfvK8Qvu1OIgowP5pd
        dvnwoOVXdgFcmxNR33nO2/Ya9mnKUUlekoXq6POxy4ORHdDM5wMcT15XoR8XbGPdC0I+HO
        DLLhY0q01go/cwtUukmGsGY+ZdDjsXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652098510;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZLAPJKcbDVRaqwiPA0oK3gia0xcoJgXTboinEMlZexw=;
        b=cFus7nqBe/wZPtucGaoVvfB46Nfutjv6igfymRMdjnvaFVWkHThQzQyxYkihlGkbGLTZ7Z
        N8HyRDmDivO8N8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A77E132C0;
        Mon,  9 May 2022 12:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZHedHM4FeWLyOwAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 09 May 2022 12:15:10 +0000
Date:   Mon, 9 May 2022 14:15:08 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        zlang@kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [Resend PATCH] generic: test fsync of directory with renamed
 symlink
Message-ID: <20220509141508.6647bc5f@suse.de>
In-Reply-To: <8f06924cda35f9a5e22c1c188eb46205dd50491f.1651573756.git.fdmanana@suse.com>
References: <8f06924cda35f9a5e22c1c188eb46205dd50491f.1651573756.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue,  3 May 2022 11:57:49 +0100, fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we fsync a directory, create a symlink inside it, rename
> the symlink, fsync again the directory and then power fail, after the
> filesystem is mounted again, the symlink exists with the new name and
> it has the correct content.
> 
> This currently fails on btrfs, because the symlink ends up empty (which
> is illegal on Linux), but it is fixed by kernel commit:
> 
>     d0e64a981fd841 ("btrfs: always log symlinks in full mode")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

This looks fine and works for me.
Reviewed-by: David Disseldorp <ddiss@suse.de>

...
> +mkdir $SCRATCH_MNT/testdir

nit: It's worth quoting the variable here (and elsewhere). That said, I
highly doubt anyone is using a SCRATCH_MNT with a space in it, so it
should be okay as is.

Cheers, David
