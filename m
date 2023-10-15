Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977E47C97A1
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Oct 2023 04:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjJOCUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Oct 2023 22:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJOCUL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Oct 2023 22:20:11 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E62BD6;
        Sat, 14 Oct 2023 19:20:09 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a822f96aedso21883197b3.2;
        Sat, 14 Oct 2023 19:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697336409; x=1697941209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzmAztgi6ecB7UaqCGob459y4GhttsIKx/RrP9U9cpE=;
        b=muLhtTxhk+Y2RvpPMifgCc108FOFO0xKAmoccZQdrcXOZc6QkfYl4/Lg5q8/dm6Ts6
         VQbPLuNjxvTQUx+EKfpLvEP2Vd3oqq55lyuPWxJvb6KbqEZRSBwotvJfbai4fymo9ASY
         9RAHY/Xu5qE2aooPlS4slMTtT9pZFAXYPh263pw+85WDoZKxaL3uan8RecFkWoaG+4JK
         QPt41Aoq+j5trapeC3BsLpJoLiP/dN/B6u1kMNMYn2bElRXCZzqphQDfUekZMmILCfVR
         SJ0/F/dgOxDkni9wrevsgvsGkwiBVxgz7XbW3L8V+wZwU57bf14vBRXTKYufBe/w5/g/
         6PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697336409; x=1697941209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzmAztgi6ecB7UaqCGob459y4GhttsIKx/RrP9U9cpE=;
        b=kyqARCxAT+lUtf7xr1otVXZGS6SiRm2IxG/pquwh3WvvE4KBN1T8Yq4SNrQXwJVMEb
         JDXcnOx1/Ux1Gdz4BTe3vW+eqrx8vV6sBhS8YQCDur5M/D9g2OlQSDCieDj85ysEXDib
         +eMxB1U9x6//jP+bSejnQzazRCK8mjGetktZ7vxqJ2zzlQbxUODHmbwtPU48zlKtS5BJ
         JUOR9Ik1AljAVwpRIw94KKDULhT2sSl1KTuJYkeEGKkvDjTqOQ/DnLlYItRE10CKDtTR
         ok/OB2dpluU3/EACkzN+TNSIIDeEN+eOvK2YAcZ+DDMhy4QEBme9nAt/uIfAn0vwZ8y0
         dRdg==
X-Gm-Message-State: AOJu0YyQNht7LGA/dcBes4U9bUaDA5TQvVy0G9Z77uTD2D4N5d/Z9MB6
        xrC7pW2W5b9scDtBb7WDZp8=
X-Google-Smtp-Source: AGHT+IGkOEjO+bGWWFCarw0RLmOk68tVCv/6p3H378i9MP3Ve1TWkdNvsdbRXDgjuLQXDGyqdxhtJg==
X-Received: by 2002:a05:690c:257:b0:5a7:b51a:e176 with SMTP id ba23-20020a05690c025700b005a7b51ae176mr14718261ywb.12.1697336408657;
        Sat, 14 Oct 2023 19:20:08 -0700 (PDT)
Received: from localhost ([2607:fb90:3e2c:8023:e145:ae9d:cf98:1574])
        by smtp.gmail.com with ESMTPSA id z193-20020a0dd7ca000000b005a8073e2062sm1025954ywd.33.2023.10.14.19.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 19:20:08 -0700 (PDT)
Date:   Sat, 14 Oct 2023 19:20:07 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] bitmap: extend bitmap_{get,set}_value8() to
 bitmap_{get,set}_bits()
Message-ID: <ZStMV46v4EkoUHE8@yury-ThinkPad>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-10-aleksander.lobakin@intel.com>
 <ZSQq02A9mTireK71@yury-ThinkPad>
 <a28542e2-4a5b-4c29-9d4a-12a0d2ab5527@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28542e2-4a5b-4c29-9d4a-12a0d2ab5527@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 11, 2023 at 11:33:25AM +0200, Alexander Lobakin wrote:
> From: Yury Norov <yury.norov@gmail.com>
> Date: Mon, 9 Oct 2023 09:31:15 -0700
> 
> > + Alexander Potapenko <glider@google.com>
> > 
> > On Mon, Oct 09, 2023 at 05:10:21PM +0200, Alexander Lobakin wrote:
> >> Sometimes there's need to get a 8/16/...-bit piece of a bitmap at a
> >> particular offset. Currently, there are only bitmap_{get,set}_value8()
> >> to do that for 8 bits and that's it.
> > 
> > And also a series from Alexander Potapenko, which I really hope will
> > get into the -next really soon. It introduces bitmap_read/write which
> > can set up to BITS_PER_LONG at once, with no limitations on alignment
> > of position and length:
> > 
> > https://lore.kernel.org/linux-arm-kernel/ZRXbOoKHHafCWQCW@yury-ThinkPad/T/#mc311037494229647088b3a84b9f0d9b50bf227cb
> > 
> > Can you consider building your series on top of it?
> 
> Yeah, I mentioned in the cover letter that I'm aware of it and in fact
> it doesn't conflict much, as the functions I'm adding here get optimized
> as much as the original bitmap_{get,set}_value8(), while Alexander's
> generic helpers are heavier.
> I realize lots of calls will be optimized as well due to the offset and
> the width being compile-time constants, but not all of them. The idea of
> keeping two pairs of helpers initially came from Andy if I understood
> him correctly.
> What do you think? I can provide some bloat-o-meter stats after
> rebasing. And either way, I see no issue in basing this series on top of
> Alex' one.

You're right, let's try both and see what how worse is one comparing
to another wrt bloat-o-meter and overall code generation. If the
difference is not that terrible, I'd stick to universal and simpler
for users version.

If the difference is significant, we'd have to keep both. Maybe it's
worth to try merge the aligned case into generic one, but it's not the
purpose of your series, of course.

Thanks,
Yury
