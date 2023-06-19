Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D988E735C93
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjFSRAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjFSRAD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 13:00:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E549283
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 10:00:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E5DF1F889;
        Mon, 19 Jun 2023 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687194001;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qFPS6R+wQrRI0vsn88AWhOwN9V9jWOBC+MpkflG6ntM=;
        b=OajryNx7K5ZCGNEM8mGT/d8EoK+HL/gqionWdEZK5cowLYyS11abOlO24iIljqYty63QDy
        4Iq/XkoZPZYAKdvUdTIR+YZiV0V9sQuXxhHec/AN+xu3cBJwwnxa2G3M0ldDUvAccU+OXH
        waE7OYohGsam+xdwZqiHEmbnc2/hA9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687194001;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qFPS6R+wQrRI0vsn88AWhOwN9V9jWOBC+MpkflG6ntM=;
        b=rb1rF2WUexU2N5qh+2cwwAS1L16i8EkQVHB9vfb3ba4cpkDyejYuQLXDpFtEo8ZjL7n5zX
        AVxn3ysfhPQhc/BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40B6E139C2;
        Mon, 19 Jun 2023 17:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qErfDZGJkGRlagAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 19 Jun 2023 17:00:01 +0000
Date:   Mon, 19 Jun 2023 18:53:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: add trace events for bio split at storage layer
Message-ID: <20230619165338.GC16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ea5134ee9965fbfe870b4fb62054de92adb94ced.1687152779.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea5134ee9965fbfe870b4fb62054de92adb94ced.1687152779.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 19, 2023 at 01:33:39PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> David recently reported some weird RAID56 errors where huge btrfs bio
> (tens of MiBs) is directly passed to RAID56 path, without proper bio
> split.
> 
> To my surprise, there is no trace events around the bio split code of
> storage layer.
> 
> [NEW TRACE EVENTS]
> This patch would add 3 new trace events:
> 
> - trace_initial_bbio()
> - trace_before_split_bbio()
> - trace_after_split_bbio()

We need a better naming scheme, btrfs_ prefix and then the type of
object the tracepoint describes.

Otherwise ok.
