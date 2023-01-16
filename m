Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611AB66CF16
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjAPSp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 13:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjAPSp1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 13:45:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9BD3A94;
        Mon, 16 Jan 2023 10:44:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29708339FC;
        Mon, 16 Jan 2023 18:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673894683;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuzXrboGb9Lh3VHatlRckTzXSNuP7dF8bfGulO0UsDA=;
        b=Qc3HIqwzn7Y8Rs2YfGOOZR/F0bPWoOQQBUxFsLiszmxaxG0qhHHThSVR/sXSwoi6jRqrhT
        DDfK8O3MaJ2eaJ5Jrd3XjoVL+ewy/oTn3G2lYgY+/MhMgW+0CYn8rrA1jx2Kp+ltKFGJ/3
        tTlOIJAlNkh4Eoj4oCOlR7whuyGJq8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673894683;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuzXrboGb9Lh3VHatlRckTzXSNuP7dF8bfGulO0UsDA=;
        b=7jMZPfo7gt4/CVrAO5/FMc8qluJYPU0PgJJrUG4lIGJ4/EByiFarjtrz2sTclun8XTfA34
        Gu/ZYiR0gmaBQgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E99B3138FE;
        Mon, 16 Jan 2023 18:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OgINOBqbxWMOegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 16 Jan 2023 18:44:42 +0000
Date:   Mon, 16 Jan 2023 19:39:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ye.xingchen@zte.com.cn
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] btrfs: remove duplicate included header files
Message-ID: <20230116183905.GY11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <202301161558444609146@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301161558444609146@zte.com.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 16, 2023 at 03:58:44PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> extent-tree.h is included more than once.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

I did not find any other case of duplication, so added to misc-next,
thanks.
