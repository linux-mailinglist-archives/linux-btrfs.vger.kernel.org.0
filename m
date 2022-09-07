Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9821D5B06D9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIGOct (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiIGOcD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 10:32:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEBC2F393
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 07:32:00 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h21so10524370qta.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GJ5VKA2x+Nd9nu8HD4Frr5ogzjEeMbC9k47mipdL0ww=;
        b=c2qBD3aBWcAd8j5mSUv0w0RN5aN6Khd4m/dU3EO1IBu70V84Q06MXct93Gn3M5JAbf
         5KJOPdIOKFkQ1qs99OhTrx1SxPCcu3KKt80mqeljiyf5lFGZx9i4NczEbLVJJ8s9HtH8
         paYkAnglV5J8RG73CaMMj2vDJkTRizN7/DHW6LQh7ms0Gpr728H2LIaCvYGrHcsF+jbB
         e47blE0QZMhp3oqz3wPe6hVhLRl+8QLeOjnDmPmRM+tBvTTn6GgaQeXdKYPQsnW1cSav
         BiF0oZPNKeQ9Ree8Vh/VJgKRiHsPEZ0WfJ9dg5736o2KwfRWT6Oqyk4rQz3M6zEG4PMR
         DOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GJ5VKA2x+Nd9nu8HD4Frr5ogzjEeMbC9k47mipdL0ww=;
        b=8QUrnm1MwuGcud54S3wLucrv2SN8nQPECqKquZsmnYNfFsc+UgWGc1kNvgGm6YDDeE
         kAtLdYqgy3MCC1MeB4ukacB8eCtUQWmNVf5UotZxw13Ful7pQeoC9OhJy/Qg8WIYBBmT
         nuHYTVD6qhKTITuWjwI2+LfHdisv2q2gCiGiuUvl+R1AD5pgMEB6jjc1pyFqgBvNkTLa
         1aKZJrUgau6a8125TgGNu0lTnIndTCpMiejYlIqVRr6gqVKvj2SRC0uGmKdZdIYd3nex
         6BPIVdA5NBYXS2oR4exV1ZQ4lGTD+1RqWlKDGqSbt9MKou0r1ygqhBTr8S18RB+2gjkZ
         JV8A==
X-Gm-Message-State: ACgBeo1jlIhalWOQ7+oWtPA2jbYm1clQuZbBZA6NRh4KqezVSsz+86ky
        NHJlPlxtg2dfJ3/gexG0gHjTdB0mtphnavDa
X-Google-Smtp-Source: AA6agR6wahIYwrT/P5/pjg+leVcoRMWkBYbfZwdqZpUkRNZIu88FZT6HwE1BgnyU1omiajQHC4mJWg==
X-Received: by 2002:a05:622a:190b:b0:343:73d1:d697 with SMTP id w11-20020a05622a190b00b0034373d1d697mr3361222qtc.605.1662561119628;
        Wed, 07 Sep 2022 07:31:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y9-20020ac81289000000b003434e47515csm12226946qti.7.2022.09.07.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:31:59 -0700 (PDT)
Date:   Wed, 7 Sep 2022 10:31:58 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't update the block group item if used bytes
 are the same
Message-ID: <YxirXjl1Ur3VV3B6@localhost.localdomain>
References: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 11, 2022 at 02:37:52PM +0800, Qu Wenruo wrote:
> When committing a transaction, we will update block group items for all
> dirty block groups.
> 
> But in fact, dirty block groups don't always need to update their block
> group items.
> It's pretty common to have a metadata block group which experienced
> several CoW operations, but still have the same amount of used bytes.
> 
> In that case, we may unnecessarily CoW a tree block doing nothing.
> 
> This patch will introduce btrfs_block_group::commit_used member to
> remember the last used bytes, and use that new member to skip
> unnecessary block group item update.
> 
> This would be more common for large fs, which metadata block group can
> be as large as 1GiB, containing at most 64K metadata items.
> 
> In that case, if CoW added and the deleted one metadata item near the end
> of the block group, then it's completely possible we don't need to touch
> the block group item at all.
> 
> I don't have any benchmark to prove this, but this should not cause any
> hurt either.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I've been seeing random btrfs check failures on our overnight testing since this
patch was merged.  I can't blame it directly yet, I've mostly seen it on
TEST_DEV, and once while running generic/648.  I'm running it in a loop now to
reproduce and then fix it.

We can start updating block groups before we're in the critical section, so we
can update block_group->bytes_used while we're updating the block group item in
a different thread.  So if we set the block_group item to some value of
bytes_used, then update it in another thread, and then set ->commit_used to the
new value we'll fail to update the block group item with the correct value
later.

We need to wrap this bit in the block_group->lock to avoid this particular
problem.  Once I reproduce and validate the fix I'll send that, but I wanted to
reply in case that takes longer than I expect.  Thanks,

Josef
