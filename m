Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1462263D641
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Nov 2022 14:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiK3NEh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Nov 2022 08:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiK3NEg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Nov 2022 08:04:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D176437
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Nov 2022 05:04:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BFC9721ACC;
        Wed, 30 Nov 2022 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669813473;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePwSJqxQ4NPB7zzbRqcWKUBzL+gUGu5Exy4mwOrpjnQ=;
        b=dKdDln9ZHNj5z8L+a2BPzkF1FG5jggFy/kBnHWnn9w8h6OLjHYLOuxfRE/0CgbQujvFUVU
        saJgtnodTTviC/66IdM0f+P7LWJ21lVrZaDUrf7KCay3Pj+vf5NXe8wr8HEqUcTI8Un90q
        yG0o3/AKEpp5JA/B58MtDPuLBS3g6dM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669813473;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePwSJqxQ4NPB7zzbRqcWKUBzL+gUGu5Exy4mwOrpjnQ=;
        b=salBpC2s0EOsoMtjziMj33L/aoQp8+6m29L1f8Y1kZDezVGHb0OMkNfKZLMlFNAbBW+LTk
        On1mc/JUTehnfaCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F7AF1331F;
        Wed, 30 Nov 2022 13:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ewz0JeFUh2MCUgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 30 Nov 2022 13:04:33 +0000
Date:   Wed, 30 Nov 2022 14:03:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: sync some cleanups from progs into uapi/btrfs.h
Message-ID: <20221130130358.GW5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a4476b6b3363587c1e9e3f81db9d2dc003d5724c.1669663591.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4476b6b3363587c1e9e3f81db9d2dc003d5724c.1669663591.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 28, 2022 at 02:26:38PM -0500, Josef Bacik wrote:
> When syncing this code into btrfs-progs Dave noticed there's some things
> we were losing in the sync that are needed.  This syncs those changes
> into the kernel, which include a few comments that weren't in the
> kernel, some whitespace changes, an attribute, and the cplusplus bit.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
