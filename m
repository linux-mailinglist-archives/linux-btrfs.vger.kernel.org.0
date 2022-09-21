Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BED5BFFA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 16:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiIUOLs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIUOLr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 10:11:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D4F8C464
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 07:11:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5CB1721AAC;
        Wed, 21 Sep 2022 14:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663769503;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WsDbwD//yKGNlgnXrfkpkU7XmhPn6xriJeRCWMWOdOM=;
        b=laoRCCac0A30mhA/hzYshsBP63BlE7xFj6bx6AZ4ikJs6b3W3GtX9IZBQl0Es+Qy8Bizxh
        Yszs5XwzkEQOUflT3b5egpeMeiX8Rt0ZP1S5uKwmzV4heZh8/0yhJVi2JbSGpd3T/MVVSY
        DlU3QFYQixIEK455u3iwm9f63fWeRqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663769503;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WsDbwD//yKGNlgnXrfkpkU7XmhPn6xriJeRCWMWOdOM=;
        b=KMqWHxAvARop0Zyt9hZnhI+yvxoR2YCk84ias5a1CvvVRVa3iEA+4RGQ+nJQLki+uXkuay
        oxI5d29bLKjhcuDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3136113A00;
        Wed, 21 Sep 2022 14:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p7YMC58bK2MGTwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Sep 2022 14:11:43 +0000
Date:   Wed, 21 Sep 2022 16:06:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: hide block group tree behind experimental
 feature
Message-ID: <20220921140611.GG32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0b8f20ae26661e040dfcaae90928bbc1c6fff5cd.1662952308.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8f20ae26661e040dfcaae90928bbc1c6fff5cd.1662952308.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 12, 2022 at 11:12:01AM +0800, Qu Wenruo wrote:
> The block group tree doesn't yet have full bi-directional conversion
> support from btrfstune, and it seems we may want one or two release
> cycles to rule out some extra bugs before really releasing the progs
> support.
> 
> This patch will hide the block group tree feature behind experimental
> flag for the following tools:
> 
> - btrfstune
>   "-b" option to convert to bg tree.
> 
> - mkfs.btrfs
>   hide "block-group-tree" feature from both -O (the new default position
>   for all features) and -R (the old, soon to be deprecated one).

The block group tree is going to 6.1, so the progs support will be
experimental in 6.0 and enabled no later than 6.1. It might be enabled
earlier so we can use the normal build in testing.
