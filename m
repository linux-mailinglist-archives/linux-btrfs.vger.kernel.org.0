Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0527D752B98
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 22:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjGMUZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 16:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGMUZ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 16:25:28 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1155E2120
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:25:24 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so998101276.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689279923; x=1691871923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CU+CW2YGl7VPILK+s6BPy8gl17pQgJnlcLizGx0gxI=;
        b=Ca2ba1/l2f9aBzgxx573Q7SAt14EKRqXAn5BrRX5vWKjIKuYedVRN0yHxd/FV6V3X1
         WTBlTsFgnnqd1TR9PcUxWMGHGIEf664jSir/SstlSXplQ/WBvMQhpTwRqQAXEjhy42uf
         LCMx6IT3y4wpe5xVkABUoyzPyN33NjdKQMzaE3aGb05ekVSEWPXX7ApOkQT5Kd1KTLhB
         8E50TwgGrHOuFecshnboX65MuEPu6AGOEmSReZ7UOAv0i0zzaYzQ/B6MNnTtxJMw0uMM
         QNRfEDn95cOHAq252ObfXDvAoLq6E8C+5vWeJ+o/GPNDIC4ukLCoYxGZUQJFR6ft81lg
         rHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279923; x=1691871923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CU+CW2YGl7VPILK+s6BPy8gl17pQgJnlcLizGx0gxI=;
        b=Mz6U/y4SGrbSAc7YpR/8WlA+nL7QWwYpcukxzVFhAguyyIlys8bddVHlMHoM9O2BGk
         bPrO5ZWBfMrGkb/Y2pzpKv14dCHX/DIHRepRKwuZcRgXJwrwx7MIOqOStsRiJ3CbnXhS
         l6KkqDZPgdgKU9G2aLRMpL1xUxjkrOU6OmaJRwNTOOX//TqJVN8QxG39+1Nx9ojKA6TW
         Dvnr0phdRKYtuMbWdnF8KtNYWjlsSpMglK4hcgtMnOBYnxFMXUVQtGVScMz0/gznnv3v
         wzu/xGZY5SvA5r9/SUur0AB1RmSsA+Yh5D/9zNYaccQYuhJQBRYtkSGTdBY4qK+pqZWF
         D0lw==
X-Gm-Message-State: ABy/qLZHBHxikF1lLCx0r3zEY2fEOyg0IUiJrzHlWoULVHuT3jJTPj7V
        KnGdM6MPyEVmjgpJtfVrp+1afw==
X-Google-Smtp-Source: APBJJlEoCveyHmhvh8Dli+H/lSODdrwwPXEXHrURuAs5LP4pFvocm3ecc8ErPpOVhKyCTmDjTSCvqA==
X-Received: by 2002:a25:ca57:0:b0:c40:f090:98bf with SMTP id a84-20020a25ca57000000b00c40f09098bfmr2534051ybg.28.1689279923141;
        Thu, 13 Jul 2023 13:25:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b5-20020a056902030500b00c389676f3a2sm1481410ybs.40.2023.07.13.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:25:22 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:25:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/8] btrfs-progs: simple quotas btrfstune
Message-ID: <20230713202521.GX207541@perftesting>
References: <cover.1688599734.git.boris@bur.io>
 <97a649f080eef409746d4a4cd59f4c27e0bbb287.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a649f080eef409746d4a4cd59f4c27e0bbb287.1688599734.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:36:25PM -0700, Boris Burkov wrote:
> Add the ability to enable simple quotas on an existing file system at
> rest with btrfstune.
> 
> This is similar to the functionality in mkfs, except it must also find
> all the roots for which it must create qgroups. Note that this *does
> not* retroactively compute usage for existing extents as that is
> impossible for data. This is consistent with the behavior of the live
> enable ioctl.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
