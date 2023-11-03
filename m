Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570787E03E7
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 14:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjKCNpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 09:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCNpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 09:45:53 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FFA1A8
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 06:45:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7789923612dso121067485a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Nov 2023 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699019149; x=1699623949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4oMWI3wpq8N6urQpVjTQbiZmLHQleLwQl3GNkjeBKMs=;
        b=lOzkPzEMOyl2Ggq1zygxl1Lwv/0NofodZ/eduZrpPB1EYEFBxXw0GWkkwEsFUfXdvB
         WfONyzqfc+HfQu9MzBm0QSeobD0N6B/nFJ9VeF9dn5O06avfQ+gRbHWfiNwlHqAPMDgh
         VkCGN4bUjk6laoFB5tjyE4z3vjQ9pUye7SrDhci29dmg0by7qBKEEMZM19JE0SJgppkA
         Qu9hFyq01XF24LbNC4SFkx5NHggiPRiZPrVOnfVyPA3gYaZmfpDStAuUGuFUOO/tfVID
         K7P4v917/tbkIp5WL0a+pVpeyOZj1ttlSVAyc+s3q1nDDGQ1EYF87iPfCTwycgXDMHhm
         xvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699019149; x=1699623949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oMWI3wpq8N6urQpVjTQbiZmLHQleLwQl3GNkjeBKMs=;
        b=neE4QupEXwEYJcQIwJZkrDbx6xLUIlEgbVhMt1VCcGKeYimIG+ugbxrEnYYPLrHZIr
         Ofl26C/i8X1Mf6wJ29HI0ITrdo3gjmsnV0JhyQBRNEeKuE5WyVaPEAMf29vj1grSYjJ5
         OIDIyhJkaUI7sE5MTYFTl7X3rCULTPCJ4TIWPHVg/FNwO/RzxmlxDlb9g71sEnbOAFrF
         txjgCHWKS6XIfJUDgxQS9Jg3mZN0vHOnGRRtDKqEkOhTXy3nDQxTFooBlhtDaGF7r3e5
         nwt8k8InI1jdxnbR8uJuVlutG8eSByaRh3MphNthq6c1I/xD/yaz3bBJxO8hXQadfXcd
         eqsg==
X-Gm-Message-State: AOJu0Yw1y+QT4BkEWI/3zad6mDeBC5xCN8f8ykm9rav5HgFinoUR4FNq
        oMhy7ooplHk3uF9ckeFMl+TtPA==
X-Google-Smtp-Source: AGHT+IFzVbEdZB3FeQE4CGYFY/zz532q2QsH3vSHCUkpgcgKrKJ08KVwZyfe68ezUQ5+G9/vcFURIw==
X-Received: by 2002:a05:620a:2b90:b0:773:c792:bdda with SMTP id dz16-20020a05620a2b9000b00773c792bddamr21817858qkb.53.1699019149045;
        Fri, 03 Nov 2023 06:45:49 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a099600b007743382121esm732279qkx.84.2023.11.03.06.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:45:48 -0700 (PDT)
Date:   Fri, 3 Nov 2023 09:45:47 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <20231103134547.GA3548732@perftesting>
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102203640.GB3465621@perftesting>
 <196ebcda-afff-45bc-a32a-bc313369e405@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196ebcda-afff-45bc-a32a-bc313369e405@gmx.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 03, 2023 at 07:19:41AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/3 07:06, Josef Bacik wrote:
> > On Tue, Oct 24, 2023 at 12:41:11PM +1030, Qu Wenruo wrote:
> > > [BUG]
> > > There is a bug report that ntfs2btrfs had a bug that it can lead to
> > > transaction abort and the filesystem flips to read-only.
> > > 
> > > [CAUSE]
> > > For inline backref items, kernel has a strict requirement for their
> > > ordered, they must follow the following rules:
> > > 
> > > - All btrfs_extent_inline_ref::type should be in an ascending order
> > > 
> > > - Within the same type, the items should follow a descending order by
> > >    their sequence number
> > > 
> > >    For EXTENT_DATA_REF type, the sequence number is result from
> > >    hash_extent_data_ref().
> > >    For other types, their sequence numbers are
> > >    btrfs_extent_inline_ref::offset.
> > > 
> > > Thus if there is any code not following above rules, the resulted
> > > inline backrefs can prevent the kernel to locate the needed inline
> > > backref and lead to transaction abort.
> > > 
> > > [FIX]
> > > Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added the
> > > ability to detect such problems.
> > > 
> > > For kernel, let's be more noisy and be more specific about the order, so
> > > that the next time kernel hits such problem we would reject it in the
> > > first place, without leading to transaction abort.
> > > 
> > > Link: https://github.com/kdave/btrfs-progs/pull/622
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > This broke squotas and I didn't notice it until I was running the CI for my
> > mount api changes.
> > 
> > Lets try to use the CI for most things, even if you send it at the same time you
> > submit a job, it'll keep this sort of thing from happening.  Thanks,
> 
> My bad, didn't utilize CI at all.
> 
> Any quick guides/docs on the CI system?
> 

I'll put something in the developers docs, but just push your branch to github,
and submit a PR against btrfs/linux, the 'ci' branch, and it'll automatically
kick it off for you.  Thanks,

Josef
