Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BDE4EA2CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 00:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiC1WN2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 18:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiC1WN0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 18:13:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDAB13E42E;
        Mon, 28 Mar 2022 15:02:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DED2E1FDA9;
        Mon, 28 Mar 2022 22:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648504940;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rYFGS9AYzxVsx9knDBb4jcUDE3645z2CTIc2cXxxBpM=;
        b=0soT1ko22OO/7z4QLN0QnF8+IKnrsF+Q8yRaz++XBb+qqIXDWjmrjUzZlmY1nR4o9B8VCT
        g8LoEDjuYZqXWXAVrUS7pWYDCBpMpgQ5dgFiKE2JVHTcwZDZIYHmw60DTHhPPZhNDegNQz
        aRthzkd57oYYo/684UBnFlh4HZOJumY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648504940;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rYFGS9AYzxVsx9knDBb4jcUDE3645z2CTIc2cXxxBpM=;
        b=tZBEhRKftWDILuZsN9gHgfpd2FAfOGHdKlv3I5ZVGNuvwAnQRItPQXCKb5G8KdXdtdTgQw
        ADB02uAof+v3rACA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D0E53A3B87;
        Mon, 28 Mar 2022 22:02:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 937FBDA7F3; Mon, 28 Mar 2022 23:58:23 +0200 (CEST)
Date:   Mon, 28 Mar 2022 23:58:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: Allocate page arrays more efficiently.
Message-ID: <20220328215823.GV2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1648496453.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648496453.git.sweettea-kernel@dorminy.me>
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

On Mon, Mar 28, 2022 at 04:14:26PM -0400, Sweet Tea Dorminy wrote:
> In several places, btrfs allocates an array of pages, one at a time.  In
> addition to duplicating code, the mm subsystem provides a helper to
> allocate multiple pages at once into an array which is suited for our
> usecase. In the fast path, the batching can result in better allocation
> decisions and less locking. This changeset first adjusts the users to
> call a common array-of-pages allocation function, then adjusts that
> common function to use the batch page allocator.

Makes sense, the allocator internal knowledge can improve things. Though
after some time the memory often is fragmented and the bulk allocator
could fall back to single page allocation, it won't be worse than what
we already have.

I have some coding style comments, will reply under the patches,
otherwise the series looks good.
