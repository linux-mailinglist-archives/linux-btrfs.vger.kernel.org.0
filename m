Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0374D6841
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 19:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbiCKSFu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 13:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiCKSFt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 13:05:49 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3FF1B0BC0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 10:04:45 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 5FDAB80785;
        Fri, 11 Mar 2022 13:04:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1647021885; bh=pxAwO1X82Xcjvhg5DA7R+yqMBgzLG3xU3yuslYXzVGo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H1lEvk4yWNEyY2E/S8oqJN0ujCXMUBjQ9qwnkcXUg+TlsPCVN0vtSnlFfjU/WOlPL
         54T3Gz75H2lk3C2zm2Inq6/vMNF/dsJ0D9aU+EwlMVNXKW3LJvMcJwEEF6c8fIG8+2
         FWwUY5Hh3Vn1Qrsp/7B5elHbn9KNcBb+/XfXxSukn/2NJOWOPGvts0evMl/+Ooqpvz
         IeBd0Zzq1kLwtUKE35xPySjPEDWY97hPmyTxqJb139qv1xbUtlI/J+3Wjys96bWjEB
         hiyhaxmNpYM6KRWCF7TgzbdngO5GdJhz+n/2rT0mQyHJ4KWh7l7oHfhe52idwwTL7s
         Y4fp6wjAtnVYA==
Message-ID: <aa489834-bc4e-c33e-90c3-bb4456e09700@dorminy.me>
Date:   Fri, 11 Mar 2022 13:04:44 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2 16/16] btrfs: move common inode creation code into
 btrfs_create_new_inode()
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1646875648.git.osandov@fb.com>
 <6218b380a71e669de4489fdb32d3ac4b05a61e18.1646875648.git.osandov@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <6218b380a71e669de4489fdb32d3ac4b05a61e18.1646875648.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 3/9/22 20:31, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> All of our inode creation code paths duplicate the calls to
> btrfs_init_inode_security() and btrfs_add_link(). Subvolume creation
> additionally duplicates property inheritance and the call to
> btrfs_set_inode_index(). Fix this by moving the common code into
> btrfs_create_new_inode(). This accomplishes a few things at once:
>
> 1. It reduces code duplication.
> 2. It allows us to set up the inode completely before inserting the
>     inode item, removing calls to btrfs_update_inode().
> 3. It fixes a leak of an inode on disk in some error cases. For example,
>     in btrfs_create(), if btrfs_new_inode() succeeds, then we have
>     inserted an inode item and its inode ref. However, if something after
>     that fails (e.g., btrfs_init_inode_security()), then we end the
>     transaction and then decrement the link count on the inode. If the
>     transaction is committed and the system crashes before the failed
>     inode is deleted, then we leak that inode on disk. Instead, this
>     refactoring aborts the transaction when we can't recover more
>     gracefully.
> 4. It exposes various ways that subvolume creation diverges from mkdir
>     in terms of inheriting flags, properties, permissions, and POSIX
>     ACLs, a lot of which appears to be accidental. This patch explicitly
>     does _not_ change the existing non-standard behavior, but it makes
>     those differences more clear in the code and documents them so that
>     we can discuss whether they should be changed.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
