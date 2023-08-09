Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20F97766FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 20:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjHISLO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHISLO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 14:11:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5164610F5
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 11:11:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E87C21872;
        Wed,  9 Aug 2023 18:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691604672;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6FerE1TVUL21RX9xjCNRuNyKnLtMUJWSiuRPDR8JesM=;
        b=ud7fsJQ5pJXNuGHt82sFYLlrBdGMjh6o9Sd/4W78u+KGiaCr8GaPncrudQbCOkFlf6TLTL
        rBenY0UE1NVPRnSJm1xr2+ib4TD38Y0xoxnGW1KOrzWxbsk2QlQLXsOsK4JiWnTNezTLz5
        S3fmp4jk/AwOHodgVvH0HEHER5zTZq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691604672;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6FerE1TVUL21RX9xjCNRuNyKnLtMUJWSiuRPDR8JesM=;
        b=gQUIetpDFoX6b/zarBYmmTVNYhOSQG4GyZvmljjOQHUoCRTbrve4ZYzH+jSTIflS3YjdD9
        tQ+A3YfEVQ/1mkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1B2313251;
        Wed,  9 Aug 2023 18:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RKs9Nr/W02ReEgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 18:11:11 +0000
Date:   Wed, 9 Aug 2023 20:11:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH -next] btrfs: Use LIST_HEAD to initialize splice
Message-ID: <ZNPWvqM-VtmYKdba@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ruan Jinjie <ruanjinjie@huawei.com>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <20230809075711.1570163-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809075711.1570163-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 09, 2023 at 03:57:11PM +0800, Ruan Jinjie wrote:
> Use LIST_HEAD() to initialize splice instead of open-coding it.

Have you checked that there are no remainig conversions? I found 2 more
in btrfs_log_changed_extents() and btrfs_wait_ordered_roots(). Please
add them and resend, thanks.
