Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0E6015DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 20:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiJQSAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 14:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiJQSAH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 14:00:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7159051A25
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 11:00:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 32815205BB;
        Mon, 17 Oct 2022 18:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666029601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGB7q3Nm88AezOanKUtmHJPTxw+THfge/x0PT0YYYZY=;
        b=w+pAZvpaHqEQQIUdY9ItilX1MY5EPvFbPdJtmwI5SpMfJxhLA+U4me+K999YayoGCK+U4B
        5nsUGrQtUVrw1sG6Nb8tLMK43iUAaSao4ZtB1VxTfGGcqWCrcPRwJhYiFeM8z6pby6PjnD
        lK15GXC3d5oC/IOf7L9CH8m/coCILsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666029601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGB7q3Nm88AezOanKUtmHJPTxw+THfge/x0PT0YYYZY=;
        b=nIQe9Sb82nYBYNUTxB5w+IMQzEyh6FTedC79wFOrkFQciKrWFWOVB0MdRF1HhJPndbHdLc
        O10t6BWWCms4IbAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F44E13ABE;
        Mon, 17 Oct 2022 18:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5bHhASGYTWNTbgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Oct 2022 18:00:01 +0000
Date:   Mon, 17 Oct 2022 19:59:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add helper to exit_btrfs_fs
Message-ID: <20221017175950.GR13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a1e9999846422fc971c5bb5f79d517de6530a55a.1665745675.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e9999846422fc971c5bb5f79d517de6530a55a.1665745675.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 14, 2022 at 08:17:26PM +0800, Anand Jain wrote:
> The module exit function exit_btrfs_fs() is duplicating a section of code
> in init_btrfs_fs(). So add a helper function to remove the duplicate code.
> Also, remove the comment about the function's .text section, which
> doesn't make sense.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> David,
>  This patch is on top of Qu's patch on the mailing list.
>    btrfs: make btrfs module init/exit match their sequence
> 
>  This patch passed, make mrproper, compile with defconfig and Oracle Linux config.
>  and, Module load/unload.
>  I suggested this change in the review comment, but it wasn't going anywhere.
>  Instead, I found sending a patch is more productive. Please, keep my SOB.

So there's the for() { } duplication but we need to be careful about the
sections. Can we rather use some inlining tricks to force the common
code to be inlined and avoid dealing with the sections explicitly? Eg.
using __always_inline.
