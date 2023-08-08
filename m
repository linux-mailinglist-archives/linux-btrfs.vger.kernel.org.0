Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E962D774260
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjHHRm4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 13:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjHHRm1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 13:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1CC420A
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691511453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EHTAm8tgK23T9lwlx7F15uMf05zmd6L8FbmonQcZyes=;
        b=PvOm5xc3ot7N9MzfqkrPcIIezoO3VocmT/tFzNhJr6cNGdxf7dlKkxqvhWHzR7z8lovudn
        DOLctv+ncveKGWPwjO8JXMGQug34VK8IvQovt+IzWGa02t2J9golSl4NLvJwMCV5fq68YU
        cXY11GSZzw8nUFk3xyToAJN7/QdUbHA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-jKNwgRu-MGW8qBLxFd_sZA-1; Tue, 08 Aug 2023 05:15:00 -0400
X-MC-Unique: jKNwgRu-MGW8qBLxFd_sZA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bb8caf7312so39844405ad.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Aug 2023 02:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691486099; x=1692090899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHTAm8tgK23T9lwlx7F15uMf05zmd6L8FbmonQcZyes=;
        b=bIbwT/EotnfvusKizCwi25BgfZjIZa1qyP3L08iodUT0hhqeSWj21/girB60W6kZUO
         ZDH9ljLSfWKsycRKLVW0RjJorkO97ClZRQMED21pjktlxha3Ywv7APHP4kys89d2ah2J
         SraGBKVg79D4TXy//hyLmywl5F9VMgqjn5i+sqNiGQLQCkSJgpZXFmGXCKjfXIiOTCxr
         I8tPiFbsbS3igxggwP1GQsV0cE6KuENiltYU7jj5SXsAWQodVRIck96pvtUAU0t0qmqr
         TvHynuW/TGGPMfWbGFxPxbEnSHNWgBDz47vYPljmYC9xhQd+B5GKYQwREgZTrQqFcHrH
         yDtg==
X-Gm-Message-State: AOJu0Yxy7CaG3gh5DgfFIprKG56OwxP+II9+Nfpt1fB7MXjLU+bfmQkQ
        h8nvw98KhPyQhocexLJAPJJdM+iy4m2fM++USzpvpq/j2Y2N+hv+W+acAHproKFtohZv4Sb2pcJ
        KcSsETctP4NEhTAZtKKqkyY0=
X-Received: by 2002:a17:902:f547:b0:1bc:4df5:8bfe with SMTP id h7-20020a170902f54700b001bc4df58bfemr10200246plf.20.1691486099068;
        Tue, 08 Aug 2023 02:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXxgLzgsbLhdis1yB1Trk8yO0aTqi7mrda/ZRDWXXZBlF/GWELIc0wDecY/HykAl3iK4p4rg==
X-Received: by 2002:a17:902:f547:b0:1bc:4df5:8bfe with SMTP id h7-20020a170902f54700b001bc4df58bfemr10200230plf.20.1691486098717;
        Tue, 08 Aug 2023 02:14:58 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w21-20020a170902a71500b001b558c37f91sm8431882plq.288.2023.08.08.02.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:14:58 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:14:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, linkinjeon@kernel.org,
        sj1557.seo@samsung.com, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] common/rc: drop '-f' parameter from fsck.exfat
Message-ID: <20230808091454.4skdyjnaxjqa7zyi@zlang-mailbox>
References: <20230807112850.9198-1-ddiss@suse.de>
 <20230807174835.moxyuvx4mp47pvky@zlang-mailbox>
 <20230808003449.760508f1@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808003449.760508f1@echidna.fritz.box>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 12:34:49AM +0200, David Disseldorp wrote:
> Thanks for the feedback, Zorro...
> 
> On Tue, 8 Aug 2023 01:48:35 +0800, Zorro Lang wrote:
> 
> > On Mon, Aug 07, 2023 at 01:28:50PM +0200, David Disseldorp wrote:
> > > fsck.exfat doesn't support the '-f' flag, so add a special case to
> > > _repair_test_fs().  
> > 
> > I'm wondering why _repair_scratch_fs() doesn't have the '-f', but the
> > _repair_test_fs() has it. Looks like the '-f' option was for extN fs
> > originally, it's not a fsck common option, but in fsck.ext4.
> > 
> > So I think the '-f' might not be a necessary option. As _repair_scratch_fs
> > works without it, can we just remove the '-f' from _repair_test_fs()?
> 
> The fsck.ext4 usage states:
>  -f    Force checking even if filesystem is marked clean
> 
> As _repair_test_fs() is only called on _check_test_fs() failure, I
> suppose '-f' removal should be fine. Still, to avoid any behavioural
> changes I could also just add an explicit ext case with '-f'.
> 
> There's also a question of what btrfs should do here, as calling the
> "fsck.btrfs" no-op script following btrfs check failure likely
> doesn't make much sense.

Hmm, I think you're right. I just checked the commit log, the code (check
calls _repair_test_fs if TEST_DEV is corrupted) is added by this commit:

commit c7d81cdecbefd5768163a195e8d5257279216a34
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Fri Apr 21 10:51:31 2023 -0700

    check: try to fix the test device if it gets corrupted

That commit cares about xfs and extN more, didn't think about other fs
likes btrfs. If btrfs would like to call btrfs-check, not fsck.btrfs,
we should do that.

And as the "-f" isn't a common option of fsck, so we'd better to not use
it in " *)" branch. If extN hope to use it, we'd better to have a "ext4)"
branch.

If btrfs would like to call btrfs-check in _repair_test_fs(), we need
to do the same thing in _repair_scratch_fs(). CC btrfs list to get more
review/suggestion about that.

Thanks,
Zorro

> 
> Cheers, David
> 

