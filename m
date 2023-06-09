Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994D472A137
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjFIR0f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 13:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFIR0e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 13:26:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E521A6
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 10:26:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9FFD721A8C;
        Fri,  9 Jun 2023 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686331591;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMAXfyIrE+3wGUuzBSzPGJbwBKw4Rtu8f6gLNMOJUDM=;
        b=QTsrkXceoQr1pgZRmwwhAeBEI7jXRC5TWw/UOT82feovkfsu5Xyvs2B1JTp00y8Q2ljFin
        vFOqca5A5lGAjrlnMYRTtIbmJpYJgHryIqUAC61AKZdo+Qo1HNvKeq/fd9Ic5XO2sHxMfW
        x088nIDuNbm5NdKgPAB3fZhO8M7OvJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686331591;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMAXfyIrE+3wGUuzBSzPGJbwBKw4Rtu8f6gLNMOJUDM=;
        b=U5FA/9DgDXodpu2vFVpcypDdg/tjDQp6JGLoob6Svd8vNuRXoYrPM0xuz3nyrTVuCEjwsv
        auu8HyJzOWYCVcDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 924AA2C142;
        Fri,  9 Jun 2023 17:26:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB4B0DA85A; Fri,  9 Jun 2023 19:20:15 +0200 (CEST)
Date:   Fri, 9 Jun 2023 19:20:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/13] btrfs: some fixes and updates around handling
 errors for tree mod log operations
Message-ID: <20230609172015.GC12828@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1686219923.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 08, 2023 at 11:27:36AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This mostly helps avoid some unnecessary enomem failures when logging
> tree mod log operations and replace some BUG_ON()'s when dealing with
> such failures. There's also 2 bug fixes (the first two patches) and
> some cleanups. More details on the changelogs.

The net effect of this patchset (+ the split_item fix) is -12 BUG_ONs,
that's great. Lost of them have been there for a long time. There are
still a few more remaining in ctree.c, some of them look like assertions
but verifying the conditions besides assertions would be good too. That
can be decided case by case.
