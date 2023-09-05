Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F9E792CBD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbjIERvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbjIERuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 13:50:35 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8E1080D
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 10:34:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-412989e3b7bso18613961cf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1693935200; x=1694540000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhVyYyhnkV6xf8sOqK4YgIYEfgThVB5ep8tTtgcxT/o=;
        b=LywcW6+WJDqF+68BOhCqz3BTQg/0UowdNob97RYRbIsraplpVitsZeDR6H4EJanG3e
         Y81daQLLn32r3+gYfjOgsSslxYaU6nFHa2y1vN2qWoxwwY5LHwXlH6Gz9O7SVi9KMOZ/
         3COO7ilPUNuPkB4TOELuiNgcYt9nYOLwO3On+Leljb5wo5qjXNU0HyM7lI8BAxBQj5tz
         R3OPqch2iao/WwxqZD5e36pvjVPzptQGxdIv3HZMBmhQsIaROyKYe2h7VwODh06UurnC
         NoPnuUgxy1/duFslRDgsVuLQP+N8Sfk9w7rii+96Xn+KngVucjbeS9BRnbeB4kRYDLnR
         OzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693935200; x=1694540000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhVyYyhnkV6xf8sOqK4YgIYEfgThVB5ep8tTtgcxT/o=;
        b=T8KQHR3Fe5S4XPpJAqDKCaS18FZ9tRsq02WNX8zdclOwSQA3OSamnPf39HIuS8j/Xy
         xIihljwZl8L6sShYOVyUR4pKIIcIZnfGef+Ln5GD38XzKJbubIir5Yki1KomEOe0Udwv
         0YZb11m7ctutaALBi3JYUymfiZrCDdUaASVn3l9KktNq1wVNFdpO83fQuFcZcvGgU2uo
         Ui0TexAE1p7ht6qyFFsHwBGNCf0V15HP4fxxgC4njKyJVA4pr3NsVtemicaevW+q5Xfd
         jYn1AKfPSdGo0bknqzk0fzjrPNH4rZ3BcUAqCHq3vpEFRXyxzfsOihFra4bsqPBtkUOu
         IgoA==
X-Gm-Message-State: AOJu0YzhRy57QDOFw1weynY6yGluwGUqeQLFgLw019Sd5OjrpHQASQ5d
        iRtc3qZnWiJKHVRVR2NiFrNfED1+V+duEAmIED4=
X-Google-Smtp-Source: AGHT+IHoC+f41O5N5PptqoeyvPhwdxGzWHM/2723fFAW8BRKe0D9fUW6UrRfh2NpNAWsqupuLcJzEg==
X-Received: by 2002:ac8:5c04:0:b0:410:a39d:767e with SMTP id i4-20020ac85c04000000b00410a39d767emr17819928qti.25.1693935200372;
        Tue, 05 Sep 2023 10:33:20 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f2-20020a05620a12e200b0076ef7810f27sm4202383qkl.58.2023.09.05.10.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 10:33:20 -0700 (PDT)
Date:   Tue, 5 Sep 2023 13:33:19 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@meta.com,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org, ngompa13@gmail.com
Subject: Re: [RFC PATCH 00/13] fscrypt: add extent encryption
Message-ID: <20230905173319.GA1222577@perftesting>
References: <cover.1693630890.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693630890.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 02, 2023 at 01:54:18AM -0400, Sweet Tea Dorminy wrote:
> This is a replacement for the former changeset (previously v3). This
> doesn't reflect all the smaller feedback on v3: it's an attempt to address
> the major points of giving extents and inodes different objects, and to
> clearly define lightweight and heavyweight extent contexts. Currently,
> with minor changes to the btrfs patchset building on it, it passes
> tests.
> 
> Hopefully I understood the proposed alternate design and this is indeed
> more elegant, reviewable, and maintainable. 
> 
> This applies atop [3], which itself is based on kdave/misc-next.
> 
> Changelog:
> RFC:
>  - Split fscrypt_info into a general fscrypt_common_info, an
>    inode-specific fscrypt_info, and an extent-specific
>    fscrypt_extent_info. All external interfaces use either an inode or
>    extent specific structure; most internal functions handle the common
>    structure.
>  - Tried to fix up more places to refer to infos instead of inodes and
>    files.
>  - Changed to use lightweight extent contexts containing just a nonce,
>    and then a following change to do heavyweight extent contexts
>    identical to inode contexts, so they're easily comparable.
>  - Dropped factoring lock_master_key() and adding super block pointer to
>    fscrypt_info changes, as they didn't seem necessary.
>  - Temporarily dropped optimization where leaf inodes with extents don't
>    have on-disk fscrypt_contexts. It's a convenient optimization and
>    affects btrfs disk format, but it's not very big and not strictly
>    needed to check whether the new structural arrangement is better.

I've gone through this, does seem a bit cleaner, and the uses of ->ci_type are
limited to the soft deletion part, so the overlapping thing that Eric was
worried about seems to be very contained.

Eric, I asked Sweet Tea to do a rough run at this to see if this was more in
your liking, I specifically told him to get it down and get it out so apologies
for the rough edges.  What I'm looking for is wether or not this is an
acceptable approach, and if there's any other big changes you want to see.  If
this looks good then Sweet Tea can clean it up and we can hopefully start making
progress on the other things.  Thanks,

Josef
