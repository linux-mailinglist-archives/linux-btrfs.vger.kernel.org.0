Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512FF597A6D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 02:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbiHQX75 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 19:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbiHQX74 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 19:59:56 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3AD94EF0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 16:59:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f21so183666pjt.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 16:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=qSyM7uAF7pnjjUUNNHKm3ICGe3FL/ZMrfljPeAh+iac=;
        b=GNmYgDe7vFY1xy/rYrUI/hAzjDjDfqBN05JKzkD9pKtoAb5kbZuwysQDa64F/V//fW
         0XNj5rwgasCWsblMofoOwcf05dM3HmI+2cCHu1y+h7LtErEB6JQNcudq1IvPtm8EWXcV
         HH/9wJSJjY9z0DeIw/Y3rDr7uUzbjUY6mHm6BmE05hHZ9z4/J3WACatC284O489KCJvY
         UBoPzyub7HGBZXWJ0PT4xnBmfmgbBO5229U1Ky9QTNRGmKVUNgpPvLkE1CcLUlGaBLuu
         opQqE9KWQfpSjy1675UaRMJPlJLl87exzY/657DWAZ6NLA+f3WbLmjW8o0AfrAaE4csC
         1P6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qSyM7uAF7pnjjUUNNHKm3ICGe3FL/ZMrfljPeAh+iac=;
        b=MMuLN8lfTgayEXWQQaHrfyq3Mf6+78lPHgdKi19RHRQr5xT4JorTtXs6qUVa9nz/jU
         i9dkN3w9AynFW1L0vrEp/1geDM5V1LDAcX2Mw3VNJnMVpooyg6AovezKdjDs9AJKrLv+
         Z3MHEOlYDa9r1UKjGdPhkB5hditeGjh6IkELZvsP9pTOsZV8cfNX9qLzBgresew4LoM4
         iDPmQY7UlvQxkAPaTENITZyBZcZLaMVC9Nct7otvn9Ja5dejmAO4MSGQqS881abdSy4e
         SGmzPl62x7eMzmyMLIImDJFG5DZqwW9uohIgswk90Pf8o1iA9X108oxIy5SycBKvswbc
         RsBA==
X-Gm-Message-State: ACgBeo2KOMCYU7Qj3GbokwZf2dNBwRm6TqckZR30+vf64LnONGfEkrUa
        au2X8wSNnsw3j8mD5veVym/1LOjqX1LA1g==
X-Google-Smtp-Source: AA6agR5LSlaPnd/EgTVUSZ7I510gAyRn73wavch4i5kuvaBK2nPpMReytVFbvic/CoZZZEKfU8dffA==
X-Received: by 2002:a17:90b:1b48:b0:1f4:f4e5:c189 with SMTP id nv8-20020a17090b1b4800b001f4f4e5c189mr5808683pjb.226.1660780795058;
        Wed, 17 Aug 2022 16:59:55 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:8ab0])
        by smtp.gmail.com with ESMTPSA id y6-20020a655a06000000b0040ced958e8fsm36662pgs.80.2022.08.17.16.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:59:54 -0700 (PDT)
Date:   Wed, 17 Aug 2022 16:59:52 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>,
        Andrea Gelmini <andrea.gelmini@gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
Message-ID: <Yv2A+Du6J7BWWWih@relinquished.localdomain>
References: <cover.1660690698.git.osandov@fb.com>
 <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
 <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
 <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 17, 2022 at 06:53:56PM +0200, Christoph Anton Mitterer wrote:
> Hey.
> 
> 
> It would be indeed quite helpful if there was some more usable
> information for end-users on how to detect any possible corruptions
> from that issue.

I'm working on a tool that can be run on a mounted filesystem to detect
most of the corruptions that could result from this bug. I'll share that
in the next couple of days.

> From how I'd understand the commit message there are at least some ways
> where one would not be able to notice that, and so the corruptions are
> actually possibly silent?
> 
> 
> 
> Are there perhaps at least some usage patters that were not prone to 
> the issue?
> I have e.g. numerous filesystems were regular files were only ever
> added, but never deleted (just moved perhaps within the filesystem).

From what I've found, it's much more likely to happen if you delete a
lot of data soon after boot with space_cache=v2/nospace_cache and
discard/discard=sync. I can't say that it'd never happen outside of
those conditions, but I suspect that it's much harder to hit otherwise.

> Are there any recommendations for people what they should do once the
> have the fix? Like invalidating the free space cache with btrfs check?

I'll try to have the check tool I'm working on print some
recommendations. We'll probably be able to avoid invalidating the free
space cache in the happy case that no corruption is detected.

> Is this going to be submitted to the stable kernels?

Yes.

> Also, I think, there should be some better means of communicating data
> corruption issues, especially silent ones, to the users.
> In the past there were several of them (like the issues with holes and
> compression) that - just like this one now - people only ever noticed
> merely by chance.
> 
> This however easily crushes any chances for people to actively search
> for corrupted data (e.g. by manually comparing with backups) and
> retrieving still good copies of damaged files (which possibly will
> eventually be rotated out of existence).

That's a fair point. We'll need to figure out a good way to do this. Do
you have any suggestions?

Thanks,
Omar
