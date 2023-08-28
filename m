Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ADD78B48E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjH1Pf4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjH1Pf1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 11:35:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAACEE1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:35:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 76DE31F383;
        Mon, 28 Aug 2023 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693236922;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=teI8Q5tUmmxCcQK76P9lASMeqdiJ00qE+hdjrAoy29Y=;
        b=xUPb8teyOFc4gUvbSj5AWN4xyMLiWoYSF+Iz58cgjuJnxELlx0PhqtgaN4ztGX8CYF3bQ7
        BOAJjJebR9Wx9SlS2UUqsHsRBdw6LvCdp6Gz0WVnbHtaIN5GCwbd5R8dAmuRGtszleLNOH
        JVzJsguYenPEGbCbvGp69KVWe3wLz+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693236922;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=teI8Q5tUmmxCcQK76P9lASMeqdiJ00qE+hdjrAoy29Y=;
        b=hpva6brUiOPv5BUl/h6ZPijMGZhMZr9pwclCgQr1HfCrblgtt3zh4zMsBkH6WKBtd2HIeZ
        tZ9Jk+/Wx3JK+/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5906C13A11;
        Mon, 28 Aug 2023 15:35:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 614KFbq+7GR8CAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Aug 2023 15:35:22 +0000
Date:   Mon, 28 Aug 2023 17:28:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 1/5] btrfs-progs: cleanup duplicate check metadata_uuid
 flag
Message-ID: <20230828152847.GC14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692963810.git.anand.jain@oracle.com>
 <cd4366f46e9ffef7538ec385587d5fe2d0743038.1692963810.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd4366f46e9ffef7538ec385587d5fe2d0743038.1692963810.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 25, 2023 at 10:47:47PM +0800, Anand Jain wrote:
> The active_metadata_uuid already holds the value of the metadata_uuid
> flag. Remove the check for the same flag from the super_copy, which
> below patch forgot.
> 
>      btrfs-progs: Track active metadata_uuid per fs_devices
> 
> This patch should be rolled into it.

Folded to the patch, thanks.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
