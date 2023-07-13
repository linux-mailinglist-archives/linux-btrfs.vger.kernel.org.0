Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF64A752A1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGMSCZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 14:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGMSCY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 14:02:24 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232502722
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 11:02:23 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-579e212668fso14119887b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689271342; x=1691863342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/vz4OpEYiK/2C83/5ihqMFBEvJTgMxBb2lIeeuVizI=;
        b=awzvPhztZ+CxXrHGUI9p4RrcgvddJTJiBGMhFTfd3btXKD8WCzAy1aBlyOGOvIXMmj
         ZlxmBdGJcGVsYge7qCUaarQjVIBnLbbv3AaADL0JdPTqdSSNRFm3+8a8ZdH5fr4pLxfr
         2KsTjQC+4qur3HsifqSAUcUxD9krffBlCAhvd3HXKSWUPaD6qED5mQj3yYcGvFCV7i6t
         GuceFbcMZfW2TAVXT6dZDqFx6A1LiwNKm0QBYgNk4nXvHYmDWBbywz0iRVS4ty6tFV3P
         3STI/XOxJeK7ovX94eQwYBx2NKUru+xlJmkf1wa9WRRGwit8Ki+ksgx8EpW2BH23YaxN
         BBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271342; x=1691863342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/vz4OpEYiK/2C83/5ihqMFBEvJTgMxBb2lIeeuVizI=;
        b=WiJQXabsN/JIRew+dCbgjM5NRLrbOeHMPnbWz7Pa9ciAMXN0DLDZFb4tI7u/OeD86a
         78LYT13JmU1hoKwR7KoA/zKl+dj2hz1IcGBJUrMQ6SvpqD+k1ewkTl9wsccRA5LZdRev
         HFsnDYO5uXYWgfOIAPay/6/JGspg7ihin/C/Imr964C7V54PvsTXNRxfz6fbHhpQY6y0
         yf8Fxcxv9m9GN8CkVBV6Xk/NjCUZqH1p1JRzgW4fiznzF4pj8SiCew9I92StLd7OVT6J
         J5zjOyoidk5sqDerg8KVWwiVq5kb89laOqZTitUzOd4ixhoO+W9N6/O8el+DyBa1tOIA
         MDhg==
X-Gm-Message-State: ABy/qLZ8LN2zRK6sMlywkCCPqPg907ezAWNs7+k+zYpn0RYPOaf6J1FH
        nbthhFHNMVqTJFSiONyhqj7OHA==
X-Google-Smtp-Source: APBJJlEFVYZve8zmpKYa7TR+VK8nga2kP741zf7ehn+tH80lukt6l9tRK7BFqOfLWwOCtCzaw/c76Q==
X-Received: by 2002:a0d:d78d:0:b0:56f:f0db:759a with SMTP id z135-20020a0dd78d000000b0056ff0db759amr479290ywd.13.1689271342118;
        Thu, 13 Jul 2023 11:02:22 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q64-20020a0de743000000b0054bfc94a10dsm1881671ywe.47.2023.07.13.11.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:02:21 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:02:20 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/8] btrfs-progs: document squotas
Message-ID: <20230713180220.GS207541@perftesting>
References: <cover.1688599734.git.boris@bur.io>
 <8f44931fc285453f18956cc6601568816d7dcf69.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f44931fc285453f18956cc6601568816d7dcf69.1688599734.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:36:20PM -0700, Boris Burkov wrote:
> Document the new options in btrfs quota and mkfs.btrfs. Also, add a
> section to the long form qgroups document about squotas.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  Documentation/btrfs-quota.rst    |  7 +++-
>  Documentation/ch-quota-intro.rst | 59 ++++++++++++++++++++++++++++++++
>  Documentation/mkfs.btrfs.rst     |  6 ++++
>  3 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/btrfs-quota.rst b/Documentation/btrfs-quota.rst
> index 830e9059a..d5e08330e 100644
> --- a/Documentation/btrfs-quota.rst
> +++ b/Documentation/btrfs-quota.rst
> @@ -47,9 +47,14 @@ SUBCOMMAND
>  disable <path>
>          Disable subvolume quota support for a filesystem.
>  
> -enable <path>
> +enable [options] <path>
>          Enable subvolume quota support for a filesystem.
>  
> +        ``Options``
> +
> +	-s|--simple
> +		use simple quotas (squotas) instead of qgroups
> +
>  rescan [options] <path>
>          Trash all qgroup numbers and scan the metadata again with the current config.
>  
> diff --git a/Documentation/ch-quota-intro.rst b/Documentation/ch-quota-intro.rst
> index 351772d10..a69e35c8a 100644
> --- a/Documentation/ch-quota-intro.rst
> +++ b/Documentation/ch-quota-intro.rst
> @@ -194,3 +194,62 @@ but some snapshots for backup purposes are being created by the system.  The
>  user's snapshots should be accounted to the user, not the system.  The solution
>  is similar to the one from section 'Accounting snapshots to the user', but do
>  not assign system snapshots to user's qgroup.
> +
> +Simple Quotas (squotas)
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +As detailed in this document, qgroups can handle many complex extent sharing
> +and unsharing scenarios while maintaining an accurate count of exclusive and
> +shared usage. However, this flexibility comes at a cost: many of the
> +computations are global, in the sense that we must count up the number of trees
> +referring to an extent after its references change. This can slow down
> +transaction commits and lead to unacceptable latencies, especially in cases
> +where snapshots scale up.
> +
> +To work around this limitation of qgroups, btrfs also supports a second set of
> +quota semantics: simple quotas or squotas. Squotas fully share the qgroups API
> +and hierarchical model, but do not track shared vs. exclusive usage. Instead,
> +they account all extents to the subvolume that first allocated it. With a bit
> +of new bookkeeping, this allows all accounting decisions to be local to the
> +allocation or freeing operation that deals with the extents themselves, and
> +fully avoids the complex and costly back-reference resolutions.
> +
> +``Example``
> +
> +To illustrate the difference between squotas and qgroups, consider the following
> +basic example assuming a nodesize of 16KiB.
> +
> +1. create subvolume 256
> +1. rack up 1GiB of data and metadata usage in 256

Mis-numbered.  Thanks,

Josef

