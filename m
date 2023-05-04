Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D96F68D9
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjEDKJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjEDKJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 06:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA2B5273
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 03:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FF7763304
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 10:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDBFC4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683194946;
        bh=fieFdbPW5tiFJ0fklMhUzLZ+0/tvOo2lvLJxbURV/D4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=opfSnbpt9mga08H2ON1NWFxKPeZ5H4HTBrH0ryIE+9+uHNn18q77TqoqsX6GDJHU/
         UISsagK6BtCtTu1Mquljn561xXf4wdp88uluBjtKyP+uMObts4LoCJjyWSDZpYV+7e
         OeoCm/Wc8LWmcmyKcoFx+k7LypKRRn0q2t/i1kPe2HRSGIaRWe0VuYHp1w0RIAP17c
         xesFuEJGyE4Ih2kM0b+hyQphA0VJNZOm+PfpwWNLnaH0Pw8aewdVZ02xFB3/2vFXf+
         B+dtjOpfPwcGbNBqQDAE6+n0Eh23dolzAemyR41RI0eF4ZArOPPZQUoVq+3LxEHHhN
         HlK8mSY9Ktkog==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-38e27409542so201996b6e.0
        for <linux-btrfs@vger.kernel.org>; Thu, 04 May 2023 03:09:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDzZR5M3XhG8Z67fBJxNeLoUXh5K8f0hWbqQMXtdz+wmyM96G7jL
        vO9BlEpoY5ToJ7TOxq4xeCqvI6dL4GNIVWzt4JI=
X-Google-Smtp-Source: ACHHUZ7sM2OHrVWN3PyQ7EwIbbxorlGNA/LtvcBmko0y/SsXaUOXKSPOBp+5lh+UlfzphmY+Q3jVeiUMGsGFp1Q4E2E=
X-Received: by 2002:a05:6808:356:b0:392:6e33:28eb with SMTP id
 j22-20020a056808035600b003926e3328ebmr55763oie.13.1683194945644; Thu, 04 May
 2023 03:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
 <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com>
 <CAL3q7H7FyF6YYuMbz0GTBb9G3WYxy9Pr9xQ11rde7jR3zVXuwA@mail.gmail.com>
 <CAHhfkvzQaRtxBqSKodAj2Gy21TMRC_fOd0cq9ECcxnU4QeuV_w@mail.gmail.com>
 <CAL3q7H6255X42N1gMy78ViXuPw4GExyhv-fptOwi_K3yJvAk1Q@mail.gmail.com> <CAHhfkvwUiSD7EmkQ9WxO-r1ASqXOKEDmePKMvHRAbVdq3sSfAA@mail.gmail.com>
In-Reply-To: <CAHhfkvwUiSD7EmkQ9WxO-r1ASqXOKEDmePKMvHRAbVdq3sSfAA@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 4 May 2023 11:08:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H49fdTLE2sKMWXYGqtDOA4Qtwj22D2wBw4qFgAokT-J5g@mail.gmail.com>
Message-ID: <CAL3q7H49fdTLE2sKMWXYGqtDOA4Qtwj22D2wBw4qFgAokT-J5g@mail.gmail.com>
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

On Wed, May 3, 2023 at 10:33=E2=80=AFPM Vladimir Panteleev
<git@vladimir.panteleev.md> wrote:
>
> On Wed, 3 May 2023 at 13:06, Filipe Manana <fdmanana@kernel.org> wrote:
> > Ok, great.
> > I'll add a changelog and send it to the list.
> >
> > Thanks for the testing and report.
>
> Hi Filipe,
>
> I have done some more testing on my laptop's real filesystem. Good
> news: the patch is 85% correct!
>
> Unfortunately however, out of all randomly chosen logical addresses
> that previously returned non-zero inodes with
> BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET, about 15% still return zero
> inodes with the patch (for whatever reason, almost entirely confined
> to files in snapshots).
>
> This small change inspired by your patch gets it to 100% for me:

Yes, it's correct. I've integrated it into v2 of the patch (coming
soon), as well as
another update there.

Thanks!

>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 799668b35b3c..a59d854db372 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1604,8 +1604,7 @@ static int find_parent_nodes(struct
> btrfs_backref_walk_ctx *ctx,
>                  goto out;
>          }
>          if (ref->count && ref->parent) {
> -            if (!ctx->ignore_extent_item_pos && !ref->inode_list &&
> -                ref->level =3D=3D 0) {
> +            if (!ref->inode_list && ref->level =3D=3D 0) {
>                  struct btrfs_tree_parent_check check =3D { 0 };
>                  struct extent_buffer *eb;
>
> Hope this helps!
