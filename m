Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40CD2F51
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfJJRLn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 13:11:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42021 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJRLm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 13:11:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so9740903qto.9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FzU0MmF047RefOw0G9S9hSUSkdozDNkJ8vE2RPLcoeg=;
        b=axdpcj74j1XKbxqdf+5azTorCNEwoExjxibUZZ+JMMyszzkG5f0VloUDg32RRp8v7i
         u7z8+4OzQ8ZcT3lOw/aba65ZX+Qg5al37rFFXwKYE68ntk/N8Gate7Y7qP/ogS4e0rdo
         DOu4V+4hdAXhgKzFyyCHMXymn/9ZMJAKnxxUzP40jtrMdvIyndeQ7Fk0XWF1e3+ziruB
         kpkooPby+RYqvUXgqCZ/365IVcrmjfmQ3MygvctPN+S8XJq+93nBCDv8aMvODwgc+cO8
         70XKwJoefwg7mt1m4BVlFUB2eq9nyHSeCVM071foySv7yAGHRnpyRKOpBvzIDuf22xTE
         0UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FzU0MmF047RefOw0G9S9hSUSkdozDNkJ8vE2RPLcoeg=;
        b=aVasjxYwPsi0aYHwWybbQX9pBHtaMZGQmStlMXsHE8qmP3WIYROnOyXli4R5DL+c7S
         pdJrKZm6X3SfBaAu++lS7HhkYC+4xUjYPSeKHIN6X+YQlU9/tg4ds8Vm23AuKlazvEYg
         90mrBdfRScF/jhZSLi1r0I5WwqtxW+zLKvvXJ1QQo1G8VNSBoXkLEr9EAZPzeJZKzQV2
         4UXNP/yOlwX8pQkgw4CPxnIIK5eVqg+GJz0/+hw7tlltl5LuAEoic6QGNw4FBG+LaQ7M
         +1iX2aYj6uIK3F7aqQKVaVdvaPVrRVDMJJBu3DK3gu2KaQxAr0j/2AEmkavJ+CbFOhRA
         EVHg==
X-Gm-Message-State: APjAAAVd5SRXVzaNC5mXzoQ7qVC53KRrv6ah2ycmT/olhPIbeMvfylbS
        +npIbJpFzdnym2UnD++cs5TmNg==
X-Google-Smtp-Source: APXvYqzPnbmHg9fWXEwYSqXdnQCHNtYZiKQvxvO1Kk3W8bYcXR9SHHGYmTp9+3URqpDEmE4aEO6ivA==
X-Received: by 2002:a0c:f8c2:: with SMTP id h2mr11358530qvo.234.1570727500217;
        Thu, 10 Oct 2019 10:11:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id k17sm3976197qtk.7.2019.10.10.10.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:11:39 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:11:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/19] btrfs: load block_groups into discard_list on mount
Message-ID: <20191010171137.xxuhjvmqzgifuixd@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <31ce602fac88f25567a0b3e89037693ec962c1c7.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ce602fac88f25567a0b3e89037693ec962c1c7.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:46PM -0400, Dennis Zhou wrote:
> Async discard doesn't remember the discard state of a block_group when
> unmounting or when we crash. So, any block_group that is not fully used
> may have undiscarded regions. However, free space caches are read in on
> demand. Let the discard worker read in the free space cache so we can
> proceed with discarding rather than wait for the block_group to be used.
> This prevents us from indefinitely deferring discards until that
> particular block_group is reused.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

What if we did completely discard the last time, now we're going back and
discarding again?  I think by default we just assume we discarded everything.
If we didn't then the user can always initiate a fitrim later.  Drop this one.
Thanks,

Josef
