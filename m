Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484D55B2264
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiIHPel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 11:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiIHPek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 11:34:40 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2BD15733
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 08:34:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id cr9so13139015qtb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Sep 2022 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=M9mp5RPM12XDhhRu14vVho9tWn0NW34tsCB2pNM0tv8=;
        b=x0Rly/TVdNo5IpdF+IOEFkzOgSkbc+0ACnN7ibSE3VSiTpQudVfYczVOORRMxxQMEd
         BvUfSEwr0JJmcpvqQru1U0Ym2iaNihxe4t6x75YB/cuMzuq6KyBQH4I8zmgFfHoW04kL
         VthT9vUbtXNzOHCyXcNVwRT8Bi4J6USCbCMjk0HNnpK+2WOMgjmpqD1kyguvch0oMTIk
         YA5ZWZ6l4c9sBZS86VP4HCxmu45AikwzFdtsxXgIvi0typqaIBY7aXzoxwgdhgnrRj/C
         6gDnJE42IooaNi+Zj0+WTzVHRAP53dlkt5LCO5Yvr5+BS82JtmHMM7iTK87jsX+U35S1
         jiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=M9mp5RPM12XDhhRu14vVho9tWn0NW34tsCB2pNM0tv8=;
        b=SYYQ0188f/dwjfWynDI3foTDeD8gMbuPtQJFr+HAtSjrjq/e5MI4vafKbNzeekpdEc
         F2dvOIX4oK3z5K6WKs+65dl8ueZ0mZYo0II8Wv3/6RzcveoXyPhRG7Ci/3BVQT5rBo0l
         BPnWVg8RsRzQr4hKqGIAmw5KreuJksFtocHyWbc5ET3eaoUq42/SFTosnwxWP6kP7Mjs
         I5y57qOaNdIpkrb3yFxRES0UUp8VD3Rad0Wn5+YItMuiZt/tVqVYV7EuRkuax1bnJp4X
         Pr6l3eruKxyFZRzMM/8lPc2UJAlx/vsMmTsn8M5l/REYfUr4hOk9S9YyrAcpcnM/Q22u
         cbwQ==
X-Gm-Message-State: ACgBeo0SenZvE26o6JNSxbKJW/CluuRsVGZmH/A4svfExgKtemEuGtZo
        iRNQTo2BJnsham8s5bGnFZ36YA==
X-Google-Smtp-Source: AA6agR69QYQhongc3rAz9i4Fwm1J8bPei+4Q6BpklyZ54OLP+9fR2bzBf8TJq9iNWHuIqWRFTL0QaQ==
X-Received: by 2002:a05:622a:1209:b0:344:92e0:71c5 with SMTP id y9-20020a05622a120900b0034492e071c5mr8216903qtx.606.1662651278092;
        Thu, 08 Sep 2022 08:34:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b006bbb07ebd83sm17243543qkn.108.2022.09.08.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:34:37 -0700 (PDT)
Date:   Thu, 8 Sep 2022 11:34:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 06/20] fscrypt: document btrfs' fscrypt quirks.
Message-ID: <YxoLjHYVoHLNN1eg@localhost.localdomain>
References: <cover.1662420176.git.sweettea-kernel@dorminy.me>
 <162ee6895a7d5060d1cd1ce9b2cff885eec9a062.1662420176.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162ee6895a7d5060d1cd1ce9b2cff885eec9a062.1662420176.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 05, 2022 at 08:35:21PM -0400, Sweet Tea Dorminy wrote:
> As btrfs has a couple of quirks in its encryption compared to other filesystems, they
> should be documented like ext4's quirks. Additionally, extent-based
> contents encryption, being wholly new, deserves its own section to
> compare against file-based contents encryption.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Idk, I did :set spell

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
