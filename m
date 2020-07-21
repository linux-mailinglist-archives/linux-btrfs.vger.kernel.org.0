Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3668F228B04
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 23:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgGUVU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 17:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbgGUVU0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 17:20:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7270EC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 14:20:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so38wme.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfT8DKumIieTJwjJOhmBi0JVM+k+KAR2a2J2OhK5k0w=;
        b=Y65JsRDMP1ABTsYvbD/c86X73oRMtt3P2kHQPFdbzsmVpJIrGvJJKE/rMJ7O5BI8FF
         FmAg4g3LO0z2mhSXEusZhud97VO/wfdjPFyrQLJHF3Hmx0VYao5gSHirFLsHtTncBnK3
         0FLolZWgYWDQcIhPPkWp38g/LuDeubX6Fy7nlPJYnWXXh1h8sZKL5n/DpU5kuqfqX1dk
         KFwuIndT6ZYoHXt6aa3WTrSKN0CdgNvLxWOiZWzrAR3LLwUNxw49Axm/PWFRHcFdjnou
         FZNJ9gDKvMEOUYNkvWq8iB+aSO9iFvMX9MmkOWKq2xboj0LD5j4QvkrEFuvzw7BRWaks
         wMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfT8DKumIieTJwjJOhmBi0JVM+k+KAR2a2J2OhK5k0w=;
        b=XBq0g5kSi/FW01NWLtA7YherwNXTf0CGsEN7zTLVvoLWsIsPDM5Qzik6hKmCl8/B6h
         6kgvprFrKiea/bL3Yj5fv1emAjECFxIgycfwumr3X/cUAAXSxLugW/5anYPQpuZVce3E
         yghEaDFQoK00FnwUrqsaqfQiDcIm3WDJA9xiS5KI7VwkOc6Yqim/6U5vx1+6wUm7iMEe
         gs0RpB/KUMwLghMLKiE5aJDJseDslpwYXi88j49loC/S/9plUrCaVocFGkrirpG/6NQP
         MHK4/GStSU/o4+fMdCci7GLOOuHsUfTf+y6r3nfV62Ew/auq+4nWImR71ZfTdKQ+dEPC
         cbtQ==
X-Gm-Message-State: AOAM53097xz+fx23B3OSWT1XdylDAp+SZGm+ttEUyD0qe7eqwWUjU69N
        pmjqk5VHNmvROw1ECEPBb2m2blFm395YNSRW7Y/aKQ==
X-Google-Smtp-Source: ABdhPJyxAljnFOSSqKESi3jDbjRdc+aDOHStAxk5rKCXES5uy8Xf3WrfY+U24xFJPmYFG0XNphqpJxHP+1QBTsKmTzI=
X-Received: by 2002:a1c:a756:: with SMTP id q83mr996991wme.168.1595366425218;
 Tue, 21 Jul 2020 14:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200721151057.9325-1-josef@toxicpanda.com> <69cf9558-5390-8d14-21b2-51f4c82eeed7@cobb.uk.net>
 <20200721171626.GP3703@twin.jikos.cz> <c2a212c0-3828-5860-2a3e-c190303aabaa@toxicpanda.com>
In-Reply-To: <c2a212c0-3828-5860-2a3e-c190303aabaa@toxicpanda.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 21 Jul 2020 15:20:09 -0600
Message-ID: <CAJCQCtQST05swrgU303LWEtNev-Mcif3JT4+x66OjBctFms+nQ@mail.gmail.com>
Subject: Re: [PATCH][v2] btrfs: introduce rescue=onlyfs
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.cz>, Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 11:25 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 7/21/20 1:16 PM, David Sterba wrote:

> > No, you're not the only one. Changelog points to 'skipbg' as poor naming
> > choice but 'onlyfs' is IMHO just as bad because it's supposed to be used
> > by users so the naming need to take that into account.
>
> I'm not married to the name, I think its awful but I had no better ideas nor
> suggestions from the last time I posted, tho I'm partial to
> rescue=allthefuckingthings.  However I'm fine with rescue=max also, is that
> everybody's favorite?  Thanks,

Or just rescue?

And then rescue= to specifically list the trees that are to be
ignored? Separated by comma or colon or whatever?


-- 
Chris Murphy
