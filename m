Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F6159C37F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiHVPvN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiHVPvJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 11:51:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040FD140ED
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 08:51:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A98861F8D7;
        Mon, 22 Aug 2022 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661183465;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HIe1EsM6c+e1qdnaVEmqoRiwn0X8canummHojmmZqCQ=;
        b=lO37jaF7D3iE+iWrHEE+k2t3tS13aV7vXMrClTIWvAVZXtFNjnIla7HdmCHSJLOZ7NmUlx
        +Ay/ezaBbzhRz11eYZrBQmnZMGNTB46FeOkU0eW6d7I0AqYsq3mAoGIH8nMpBu77LibLi0
        JqrBCkB6BnWL69fDwm1Wo68hGfN9TyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661183465;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HIe1EsM6c+e1qdnaVEmqoRiwn0X8canummHojmmZqCQ=;
        b=Mbk6m8tOvXBmUwqsZ4kb1R18sln98hcQwHesGM/fHwk+ni7nA3aTgFp8BtxK2Uot+M77Wy
        QOS/1/+iH9ZVILDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F4461332D;
        Mon, 22 Aug 2022 15:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q2L9IemlA2OjIQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 15:51:05 +0000
Date:   Mon, 22 Aug 2022 17:45:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/15] btrfs: some updates to delayed items and inode
 logging
Message-ID: <20220822154551.GZ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1660735024.git.fdmanana@suse.com>
 <cover.1661165149.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661165149.git.fdmanana@suse.com>
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

On Mon, Aug 22, 2022 at 11:51:29AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset brings some optimizations to inode logging, especially for
> logging directories, but also when logging a regular file that happens to
> have the name of another file that was previously deleted in the current
> transaction (triggered very often by the workloads simulated by dbench).
> It brings along some cleanups to delated items and logging in general too.
> More details in the changelogs of the patches. Thanks.
> 
> V2: Updated patch 10/15, added some comments and removed some code made
>     obsolete by it.
>     Updated patch 15/15 to make sure recursion of btrfs_log_inode() is
>     bounded to happen at most once when we have new subdirectories.

Meanwhile I moved the patches to misc-next, so patches 10 and 15 got
replaced, plus the change of the enum from :1 to :8, where patch 15
fills the hole.
