Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B616F5807
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjECMhs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 08:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjECMhr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 08:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC210F3
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 05:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43D0D62C6B
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 12:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BEFC433EF
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 12:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683117465;
        bh=OVLLqAQ4ve08pRLPGM8vg5Cs0cKqubgPUyHGl85q5fk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cTIdQzZq+Jk2h/9/BtjrJoVZe8KMPRAoK/SGCRM45JivaM1zDjW94xK+tu2+dGalh
         QcqLGE8pqX1iEnd+aPsVc2/s5egoomM3NaaMgKl8lrChpQ7umd5LqwFdR7GDzBnHc+
         JoFJXG1vpVlISpJYQYO2F9nwpNjZ4nEfHlJ4Nr50q1ItNYgbDxnxXJIWcmFBO+2WhY
         im5arnNerRHMr04vuBBVpBRiXktqjX4cF8fwb4pFr1P+jdtRn3asJOfDA4Td8ODJDD
         22KbvbiQun5KXFfR1PmV9o/CwDohyu2NUb3qM1FvkTnnOOkb43WIScrqg7xWv8nZvW
         82aMMqotiwh1w==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6a5e905e15aso1832785a34.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 05:37:45 -0700 (PDT)
X-Gm-Message-State: AC+VfDxNxCg/pSmiceWtTRuEU2tQCJ2ZoxR4dfSbw9/8hlrzL/MuxzrP
        06xRaiqRsgiPQhEncamX7lfWnVsvmFK2W7KkJi4=
X-Google-Smtp-Source: ACHHUZ6O5WGEz/fjIIDnTjilvngW0VUPanaFGl/ZJ70SFCZ09E8WbUK1vyb8k7d3QhZpyHyS9reh6cus9N/2M7LImes=
X-Received: by 2002:a05:6808:4288:b0:387:2e2e:7b2 with SMTP id
 dq8-20020a056808428800b003872e2e07b2mr9206960oib.26.1683117464823; Wed, 03
 May 2023 05:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
In-Reply-To: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 3 May 2023 13:37:08 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com>
Message-ID: <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com>
Subject: Re: 6.2 regression: BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET broken
To:     Vladimir Panteleev <git@vladimir.panteleev.md>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 3, 2023 at 1:33=E2=80=AFPM Vladimir Panteleev
<git@vladimir.panteleev.md> wrote:
>
> Hi,
>
> Commit 6ce6ba534418132f4c727d5707fe2794c797299c appears to have broken
> the BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET flag to
> BTRFS_IOC_LOGICAL_INO_V2. The ioctl now always seems to return zero
> inodes with the flag, if the same happened without the flag, thus
> making it not very useful.
>
> Context: I maintain btdu, a disk usage profiler for btrfs. It uses
> BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET to help users estimate the amount
> of space wasted by bookend extents, and identify files / applications
> / IO patterns which create excessive amounts of them.

Are you able to apply and test a kernel patch?

If so, try the following one (also at:
https://gist.github.com/fdmanana/9ae7f6c62779aacf4bfd3b155d175792)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e54f0884802a..c4c5784e897a 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -45,7 +45,8 @@ static int check_extent_in_eb(struct
btrfs_backref_walk_ctx *ctx,
        int root_count;
        bool cached;

-       if (!btrfs_file_extent_compression(eb, fi) &&
+       if (!ctx->ignore_extent_item_pos &&
+           !btrfs_file_extent_compression(eb, fi) &&
            !btrfs_file_extent_encryption(eb, fi) &&
            !btrfs_file_extent_other_encoding(eb, fi)) {
                u64 data_offset;
@@ -552,13 +553,10 @@ static int add_all_parents(struct
btrfs_backref_walk_ctx *ctx,
                                count++;
                        else
                                goto next;
-                       if (!ctx->ignore_extent_item_pos) {
-                               ret =3D check_extent_in_eb(ctx, &key,
eb, fi, &eie);
-                               if (ret =3D=3D BTRFS_ITERATE_EXTENT_INODES_=
STOP ||
-                                   ret < 0)
-                                       break;
-                       }
-                       if (ret > 0)
+                       ret =3D check_extent_in_eb(ctx, &key, eb, fi, &eie)=
;
+                       if (ret =3D=3D BTRFS_ITERATE_EXTENT_INODES_STOP || =
ret < 0)
+                               break;
+                       else if (ret > 0)
                                goto next;
                        ret =3D ulist_add_merge_ptr(parents, eb->start,
                                                  eie, (void **)&old, GFP_N=
OFS);

Thanks.
>
> Thanks!
