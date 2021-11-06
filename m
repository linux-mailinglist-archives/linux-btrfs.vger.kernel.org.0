Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BBB447063
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 21:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhKFUUd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Nov 2021 16:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhKFUUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Nov 2021 16:20:32 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFEFC061570
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Nov 2021 13:17:50 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id i13so9458023qvm.1
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Nov 2021 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jw1syH9tNRN1tfz665DX4FqNn7v9MyIoNjOgKFf3iHE=;
        b=07aGpuBzE8lZL918KQnlnRHxuCdYjoVhyXTyflRZVWOWGFskiVe0zXxIJAXXJNQHgb
         22brYTYmOc6Ez1J1nZl5TvIcSr4wdOr+AcCtus/qkxwAom7pEwMOayGmFHrp0wP4udEq
         qDftz+dSO3reJI3WDbFMkIfD8UhdvgYFvyXo7rGbeEirIkG1awYICit5o+A1yiLVrKnS
         FqdCUBvlnhsS/v4Wcar+E9O2LE/d9Op6NbIB4sENscuxDaa1DhZsgU2NLIEMErFSa04E
         QP9hpfmxPmR1MWOt+vQ8JXong2wCFroKQbB8bCSQZryspG3AhwUNeFqFnHqr/JQoRNEO
         e+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jw1syH9tNRN1tfz665DX4FqNn7v9MyIoNjOgKFf3iHE=;
        b=Y5qiM6gyks9Ha/MAHjZOTUBULR9NRM3ZnKsHIgysHzudQKyIX/gMSmJ90IpIRK6fCj
         US8erqPn01eXLR3TDkw+2lvk+QNVOgwEpZ1UwksRJULArfdzWq6Bn6cQvLi5fpdXu+4q
         Ch4JoR86HOQO+z/E0dS3ay2IyUDrMb+3rOo86mqtohlbzcj6+6hFN2sUTpR+griUFv2/
         ZykeAxszX8dbwd/W4g9RR0LL5vHEXoXRSEI6SiH1JhyLClYAzQ6PwU88gSv3IbLxYVEC
         W1ax5PKDSlDKa/sNBFMsUkWr1QkBwUpdtq3XdChEiqukRjLeT8FzyAhcVhWZpo7y0usS
         4MoQ==
X-Gm-Message-State: AOAM533x74alWq2IEN1DZufwFv420KoKPHevpB+cH3Slv4cFsA2+cN5X
        Tn98fdvUwWz+fpDLP6iuA2dNkw==
X-Google-Smtp-Source: ABdhPJwUfODAX33vxBq4Vel4o9yU6h5i9BFl0lSwGYUdKxpnued9xjRdgy9kFhWsbcxuiGkIG2QvUw==
X-Received: by 2002:a05:6214:f09:: with SMTP id gw9mr32152996qvb.36.1636229869866;
        Sat, 06 Nov 2021 13:17:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d11sm8832106qtx.81.2021.11.06.13.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 13:17:49 -0700 (PDT)
Date:   Sat, 6 Nov 2021 16:17:47 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/20] btrfs-progs: extent tree v2 global root support
 prep work
Message-ID: <YYbi6xeChFo8/vKV@localhost.localdomain>
References: <cover.1636143924.git.josef@toxicpanda.com>
 <80f4c9f3-91dd-5afe-efd7-d60c5d4bcdcf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f4c9f3-91dd-5afe-efd7-d60c5d4bcdcf@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 06, 2021 at 08:55:21AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/6 04:28, Josef Bacik wrote:
> > Hello,
> > 
> > This is a series of patches to do all the prep work needed to support extent
> > tree v2.  These patches are independent of the actual extent tree v2 support,
> > some of them are fixes,
> 
> First half are mostly good, as they are really fixes and independent
> refactors.
> 
> > some of them are purely to pave the way for the global
> > root support.  These patches are mostly around stopping direct access of
> > ->extent_root/->csum_root/->free_space_root, putting these roots into a rb_tree,
> > and changing the code to look up the roots in the rb_tree instead of accessing
> > them directly.  There are a variety of fixes to help make this easier, mostly
> > removing access to these roots that are strictly necessary.  Thanks,
> 
> But the later part for indirect access to previously global trees are
> somewhat questionable.
> 
> The idea of rb-tree caching these trees are no problem, but the callers
> are still passing place holder values to these helpers.
> 
> For current extent-tree, we can pass whatever values and get the root we
> want, but that also means, we need another round of patches to fix all
> the place holders to make them really extent-tree-v2 compatible.
> 
> Thus I'd prefer to see these helpers are called in a proper way in one
> go, which is not really feasible to test in current preparation form.
> 
> Maybe it would be better to put these patches with the real
> extent-tree-v2 code?
>

There's simply too much.  Basically anywhere btrfs_extent_root(fs_info, 0) needs
to be looked at to make sure it's compatible, and trust me I have a loooooot of
patches fixing up the different things that require special handling, and each
of them are beefy by themselves.

It makes it easier for reviewers to grok this way, there's no change for the
!extent_tree_v2 case, and then as the extent tree v2 stuff gets added I make the
necessary changes so they can be properly checked, because lord knows we
probalby fucked some of them up.  Thanks,

Josef 
