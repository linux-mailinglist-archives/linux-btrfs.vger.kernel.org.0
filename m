Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668955892C8
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbiHCT3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 15:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbiHCT3c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 15:29:32 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135385B798;
        Wed,  3 Aug 2022 12:28:43 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u12so13434176qtk.0;
        Wed, 03 Aug 2022 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=j6ua6sSOMR01Px12y7LQZ7sRXPuWjo+RHnWucuaPxno=;
        b=nFavfSVf4GaJ45pNBa9bpH1I0dEul2AoNgoS13aXm0cw3J1IxW3XneSEKO50iU6gLm
         vHp4LOsHMcUKGSckeiHJ0xUW1XG6tdXTb9YvHA/bc5ZThulmvQgUSzSsrnZyIkye2WNf
         Gd+2kZaE9opkD31v/NFditb0gS4/TSv4tYTFzcyHPIQQNnBWgyRBTEECim2q+smDEffS
         5EGy2EeXXALA03Q5io8L0M0jxbcwRr/U7e/bDcSgqmYwXvfacsYVY9v6yLgKUsr4ZZ3/
         MRN9aoatDVS7+GSYyT9YQGYObw3wa+pqhu5srDsRx+jBuBYXpDvMdjpO8JTjRLTIolPI
         4XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=j6ua6sSOMR01Px12y7LQZ7sRXPuWjo+RHnWucuaPxno=;
        b=V3YINXf4Iz/nyEk5zREIduvMDc4iKABLBz9Nk7B0QZo/DGMeWwBtg9H185Rr5sS7bq
         EuD1/eqmmU/0guIWK3UzAPn/8u4VID74iZW1TkKK9a1c92sL6GVrQLBYyDR2pkq+G0Es
         k6muTCUaQe9HLQq4NWKB8AZLZ+7KdDz/8N/qvgkR0IAs6uWWxwXFJKVS51ntk4ocDjQ1
         WBY8RWBu2K2wqqZLtYTgyy+iY7IDx948QI2o6oD1BGcz+M5gQyGdAge/EB+MfBdfqaQe
         iHF1X7lAxrybcwu1seXw0/fwnRtppXW+874QLQBUjWZjkLiTjV1wTXJey8GnusAEvxC2
         B/uQ==
X-Gm-Message-State: AJIora+G7oZfLm7EextXOudxF0IJQD2bOuZCWfM5NxpvX48gYChZIReY
        CuKFFW6Ml+bSnWK5srxvlo5QUtY/nNkIX8fDgFI=
X-Google-Smtp-Source: AGRyM1sKsNtOmA0uxL5XpZY/qqHfTGj5qb1aIPlGf97a4nzpeDMDnxOUU7vl0oK8CDue6thIYHzB0UU5X3wkc9Vl6uw=
X-Received: by 2002:ac8:5fd1:0:b0:31f:31a6:55c0 with SMTP id
 k17-20020ac85fd1000000b0031f31a655c0mr23480147qta.506.1659554922083; Wed, 03
 Aug 2022 12:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
In-Reply-To: <20220726164250.GE13489@twin.jikos.cz>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 4 Aug 2022 00:28:31 +0500
Message-ID: <CABXGCsMNF_SKns-av1kAWtR5Yd7u6sjwsFT9er8tSebfuLG8VQ@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
To:     dsterba@suse.cz, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 9:47 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
> > Hi guys.
> > Always with intensive writing on a btrfs volume, the message "BUG:
> > MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
>
> Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
> tends to work.

I confirm that after bumping LOCKDEP_CHAINS_BITS to 18 several days of
continuous writing on the BTRFS partition with different files with a
total size of 10Tb I didn't see this kernel bug message again.
Tetsuo, I saw your commit 5dc33592e95534dc8455ce3e9baaaf3dae0fff82 [1]
set for LOCKDEP_CHAINS_BITS default value 16.
Why not increase LOCKDEP_CHAINS_BITS to 18 by default?
Thanks.


[1] https://github.com/torvalds/linux/blame/master/lib/Kconfig.debug#L1387

-- 
Best Regards,
Mike Gavrilov.
