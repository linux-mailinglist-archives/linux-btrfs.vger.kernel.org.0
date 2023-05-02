Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A07A6F4C3B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 23:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjEBVbb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 17:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjEBVba (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 17:31:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D389B10EF
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 14:31:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8780621A2E;
        Tue,  2 May 2023 21:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683063088;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsc0XuPgXcG+0NQBONoqw5DIlgLOBooZCyv8A+ltpQg=;
        b=uvxtIdfY4UZF2r3XmmERZODeCKDtmBkwfnjXkEplWh6N88kl+3M3N+Hn64IRRpGTPoy7LY
        xcYBxzQtqY6ImMWyuAgyqw8u/6NyXZhFoK45mh38WUCrgygqWyEETRcZSA5AQKZUkuiwdK
        w2PYYevXnEqsE2XauVOG9nciZvLnEbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683063088;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsc0XuPgXcG+0NQBONoqw5DIlgLOBooZCyv8A+ltpQg=;
        b=0wr+C1Z143pZyAJwcPus3b9Q3qxkAM7t8TuDk7+gp2YW8+FlD3IGWAg7cuiyLAPcBjN88c
        6oK7cGfoTwB/kODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E118139C3;
        Tue,  2 May 2023 21:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id grs3GjCBUWTjSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 21:31:28 +0000
Date:   Tue, 2 May 2023 23:25:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/8] btrfs-progs: sync messages.* from the kernel
Message-ID: <20230502212533.GR8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681938911.git.josef@toxicpanda.com>
 <0a0542fd7abb9fed5f87148ac849cfb7e9577100.1681938911.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0542fd7abb9fed5f87148ac849cfb7e9577100.1681938911.git.josef@toxicpanda.com>
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

On Wed, Apr 19, 2023 at 05:17:14PM -0400, Josef Bacik wrote:
> --- a/kernel-shared/backref.c
> +++ b/kernel-shared/backref.c
> @@ -23,6 +23,7 @@
>  #include "kernel-shared/ulist.h"
>  #include "kernel-shared/transaction.h"
>  #include "common/internal.h"
> +#include "messages.h"

The includes should be specified by the path though there's the -Idir/
for the toplevel directories so it works. In case of messages.h we have
two, common/ and kernel-shared/ so this needs to be the kernel-shared
one. Updated.
