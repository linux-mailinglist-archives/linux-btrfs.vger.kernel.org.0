Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D134F8258
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 17:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiDGPEb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiDGPEa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 11:04:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB0EF;
        Thu,  7 Apr 2022 08:02:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A282F1F85A;
        Thu,  7 Apr 2022 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649343384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3qh5xwVPZT7wT/DloFg4q605++F7zyY0qU0ewsIYY8=;
        b=LkQDTv5SVqvod518dmlEkVzKTgtsgaw0IarJjKqmWTPNA86Q+EMb6Yfjl42sFUP/K0VWHH
        uv64L11+oKs0i3fcT1p0V9Tk+MViwOLUHdRDL1OTX5ld9ZYMAwq+EnSo9rY9Q4jecoGIc8
        dgghUbNDzjryQSeclkEmHsmR1DO9TDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649343384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3qh5xwVPZT7wT/DloFg4q605++F7zyY0qU0ewsIYY8=;
        b=96QySFT8C7XlCIKIyg098bGKDMV7nOxhCy8h0EE9Qwl68xSc0Oaqaac4X0J64YFu6POivq
        di47mHEWAmSJq8BA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 690C6A3B88;
        Thu,  7 Apr 2022 14:56:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B7EBDA80E; Thu,  7 Apr 2022 16:52:22 +0200 (CEST)
Date:   Thu, 7 Apr 2022 16:52:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: wait between incomplete batch allocations
Message-ID: <20220407145221.GF15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <07d6dbf34243b562287e953c44a70cbb6fca15a1.1649268923.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d6dbf34243b562287e953c44a70cbb6fca15a1.1649268923.git.sweettea-kernel@dorminy.me>
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

On Wed, Apr 06, 2022 at 02:24:18PM -0400, Sweet Tea Dorminy wrote:
> When allocating memory in a loop, each iteration should call
> memalloc_retry_wait() in order to prevent starving memory-freeing
> processes (and to mark where allcoation loops are). ext4, f2fs, and xfs
> all use this function at present for their allocation loops; btrfs ought
> also.
> 
> The bulk page allocation is the only place in btrfs with an allocation
> retry loop, so add an appropriate call to it.
> 
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Added to misc-next, thanks.
