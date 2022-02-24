Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5927B4C3198
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 17:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiBXQh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 11:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiBXQhG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 11:37:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AEA29CB1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 08:36:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AC830212B6;
        Thu, 24 Feb 2022 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645719141;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V9sbkytfWwKYP7qCYfQZA/KIdzr6OHe9/CvmMIOAkiA=;
        b=2GV1pcJvE94ChNXUB3//l4xbXwIk0xlcpLuKZspzjsNO5Xld1TQrUnwntSQEhjeHHwA0/h
        NPHOanm5LFKn5f+YN1mNaV0spYvxx8sLWbHTChY0C3P77Fes67DYUHQRLfkVEOBJZaML2W
        BkdrhJz504YBuBoI8cBA0Yxm5qGLTVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645719141;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V9sbkytfWwKYP7qCYfQZA/KIdzr6OHe9/CvmMIOAkiA=;
        b=PpxuH1LekMOWUVkQWk2TKX6pDc5//+YVwFUCTy4jFolWM13OnVhP8BRvGbJDTSD7bhL3OL
        cVaAyqgA7zdT0kCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A3703A3B84;
        Thu, 24 Feb 2022 16:12:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A21DEDA818; Thu, 24 Feb 2022 17:08:32 +0100 (CET)
Date:   Thu, 24 Feb 2022 17:08:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix UAF in btrfs_drop_snapshot
Message-ID: <20220224160832.GX12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <ae224a6030d984c20e09093e6f93a0f33e757cd3.1645717258.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae224a6030d984c20e09093e6f93a0f33e757cd3.1645717258.git.josef@toxicpanda.com>
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

On Thu, Feb 24, 2022 at 10:41:06AM -0500, Josef Bacik wrote:
> This is for the KASAN report for my in progress snapshot drop fix, this
> should apply cleanly to the existing patch.  At this point root could
> have been free'd, so we need to check if we're an unfinished drop before
> we start the drop and use that variable to see if we need to wake
> anybody up.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Folded to the patch, thanks.
