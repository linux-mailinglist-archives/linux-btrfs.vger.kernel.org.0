Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E15F434C99
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 15:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJTNuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 09:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTNus (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 09:50:48 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402F7C06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 06:48:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c28so2997904qtv.11
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RkSnhRd2cBpHnErXayBOt8GCeTJXiCXyplcar6ShZa8=;
        b=TBJ9UaUDA4o++0BkA6gk2W9lYpCJX30nseOKbTu8Pzy60ZIuevzrWAva1pRbZro1Uf
         TP9XrL7O6ocof1mBpxfOidtGNGARY8lfsJHkN/ba/rVcTSDgGrZVU+3lf8YTNk4X4sQC
         B0N3zHue40qqzdx3MDA9H2QsV1r8IyrAHK/SdRvxVQraEllQ/d9ZKLAGbavpTvrIc+sL
         s4yOG7IpPi+4Tpgfq1WNwAsy5XgKC0NwdKfXu0zoDLzi/eUs4MmYB/KqdHVe8xeyeZsV
         MEg9+XhdgYU5F7KjVSyo+YcxsmvND9lcHgas8VeFO8YCAqTl7aNMZAY2U6FgCd3bfwWL
         qBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RkSnhRd2cBpHnErXayBOt8GCeTJXiCXyplcar6ShZa8=;
        b=w+BBDMAd1WiaVhwfI86ALqc5u9e5OFJIt4r0qSVlxvtPNjn4DUsY0qt87luY6UCg1D
         kDw4McWalJ+ZswEDXCNx17Og5iBJwtxzuvYIXYPCwlpTDb4cx1yWWUXCj84ws911xueP
         KrMFNvjQ5cF4grhbW5EgV/aovsVqq7gsnl/XRH9Y131udvWWzy3h6iIMuN94RMXb1RhP
         GGvgljGHLlEG6YU4VqasDwPVgS51Z9QBhQ2XGggxTbtzWxjkYa/8sGNa7xwXuUZyH67/
         XyyXYaw0f1uP6UJoYgW8ogqPktfB1MD2+j19d6IXKUqh2YNSWlxQ6X91qorGAsjXXZj3
         ACog==
X-Gm-Message-State: AOAM5310fBD7HzjgVHVZEUuIiE1ORxgbfU69RzEE0QW+Gw/WQOj9CyvB
        xMps8wzwospefrCie+L1hX5gEQ==
X-Google-Smtp-Source: ABdhPJxDsZxAWan9A04syUuZ04R/b+GmbW44sf5S5JFxJkeQl4VjMVbgeL/E8CGTK3FKAu1EIFnWOA==
X-Received: by 2002:ac8:5794:: with SMTP id v20mr7033388qta.243.1634737713301;
        Wed, 20 Oct 2021 06:48:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b2sm958408qtg.88.2021.10.20.06.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:48:32 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:48:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs-progs: use btrfs_pwrite in place of pwrite
Message-ID: <YXAeMGm91GaV+Vl8@localhost.localdomain>
References: <20211020065701.375186-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020065701.375186-1-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 03:57:01PM +0900, Naohiro Aota wrote:
> We need to use btrfs_pwrite instead of pwrite to ensure the writing to
> O_DIRECT file works.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
