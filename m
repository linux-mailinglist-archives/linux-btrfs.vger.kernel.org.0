Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FBC602EB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJROnl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJROnj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:43:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33BE659E2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:43:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DC8533DF3;
        Tue, 18 Oct 2022 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666104216;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpFUKwgWFR733ZqOe4s+vO2l63UNN+HjQoTJ5ucPZh8=;
        b=TUU2xNFLJBYXVcanU9kLZvxmSG3IZzzzad1lzqOnD2iQFgxCoJQJhrJ9BkEi/TFm073yx9
        TtjRUAkZWbfXGLpxuSOLpZ2r0DEQx3X0o0pCQJzNtzbJCJWXsUu0Tg5Aksd3uAiygYiaeb
        cF1ObMDEHIH6tRmeMW/wTpvTFQQ5Jiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666104216;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpFUKwgWFR733ZqOe4s+vO2l63UNN+HjQoTJ5ucPZh8=;
        b=07vb0uV6jCUaUKNmWM+od4WfrmJRPYWUNEhhGcAmnXCu5ypv1H+eEut9MuXoGPpfS+9riy
        GPsyYzd0DCb6B0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 786CE13480;
        Tue, 18 Oct 2022 14:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id datsHJi7TmPXSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Oct 2022 14:43:36 +0000
Date:   Tue, 18 Oct 2022 16:43:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 07/16] btrfs: convert incompat and compat flag test
 helpers to defines
Message-ID: <20221018144326.GA13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666033501.git.josef@toxicpanda.com>
 <b0865d613f9bf886670806b3d2487d149b770745.1666033501.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0865d613f9bf886670806b3d2487d149b770745.1666033501.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 03:09:04PM -0400, Josef Bacik wrote:
> These helpers use functions not defined in fs.h, they're simply
> accessors of the super block in fs_info, convert them to define's so
> that we don't have a weird dependency between fs.h and accessor.h.

Right, we can switch inlines to macros to avoid that, though with
inlines there's type checking but we'd notice if there's a wrong type
that wouldn't have ->super_copy.
