Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA0D2DE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfJJPib (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 11:38:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45828 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJPib (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:38:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so9281182qtj.12
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Np1tZrnffSkafV6uzCi3g72ZSVqYCV5sqG94EcK263Y=;
        b=KIb78bHVdR+JONOYpMdvO6IREOQSXpDGeFSfrK4GlxmX2uL5rfIvVIMzLAzIi0y4Bm
         x6Swv6tR3TBb6Rbrsk4G1EdLUrx1VFCRszZ8mwHmHpCqTyAZqK2uBF0o6G7r4V9JlKvr
         EcTJ2AR6BSL+aocnaTLyAlyN/zLAjqVyurQJgvacM/HQcdANi8hO+bFoJfe70P1tYxki
         9a4oVGkfsMllGN5FqztTzWbYnLqOKABpV8fjkPTO9LJGoiyi8fsphMAPuOAeqtMg6R2y
         T/Omh7tZLzI3QjV4mDkotZ0h3ngOf6l9N5BTmrXCMXrqXY6ODwU3rOWfP+9AfQNOfk/s
         Fp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Np1tZrnffSkafV6uzCi3g72ZSVqYCV5sqG94EcK263Y=;
        b=H3yRVEFS+ETH8o6ofRLVaQvVbeXj9gkU9BDsvIj8q/PP7ODmQ4ZrniHPIz8q8jldH5
         shLMymmPKlWrO2L6BkgQjCBBQ9NeRodoTRgvnjoQrv6J81Rz9QSqiLM9D3NPN4Mtf+nn
         ZZ1to/tDy9sES8YygD4srxu8PjshvtDa7qqA9JlJhMvIa7c4IdtLTYCloep39b5Jwbkm
         QBW3ND7gqqKPcsnfbsgeI6LsLDZZhIPTghBo6a8UZS6qBBcR4MKswLJ/5dYzK2kj1PFW
         8sKgDVmlZ+vIDbCOWC0Wn1ANVXhpJa84Mjprtw0pi3vwpY/Kio54z0ixFvGwM1l8F+w0
         R3Zg==
X-Gm-Message-State: APjAAAUzw1lGge7wmXlKRbrOJ5J8ug8GdkBLFMHgolgap58z+mCW1hF6
        CIrbPs0klPuoQbAm6DIZlvAJ+Zvw1TquZg==
X-Google-Smtp-Source: APXvYqx2xZfIRdAeeqKHe3G7sDZipCLnqpycRjxlLsT34r3HZhKMyHknGTq7ilMt/AIBUWG6Yd4zPg==
X-Received: by 2002:ac8:2e61:: with SMTP id s30mr10535521qta.334.1570721910511;
        Thu, 10 Oct 2019 08:38:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id g10sm2621544qkm.38.2019.10.10.08.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 08:38:29 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:38:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/19] btrfs: keep track of discardable_bytes
Message-ID: <20191010153827.fzppscyjudawvncz@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <c098d2c774c93e30f782ca04f9e34461bdbb145c.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c098d2c774c93e30f782ca04f9e34461bdbb145c.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:40PM -0400, Dennis Zhou wrote:
> Keep track of this metric so that we can understand how ahead or behind
> we are in discarding rate.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Same comment as the discard_extents patch.  Thanks,

Josef
