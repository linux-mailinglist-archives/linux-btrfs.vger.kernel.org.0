Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10646FB7C5
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 21:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjEHTxS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjEHTxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 15:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC03F172D;
        Mon,  8 May 2023 12:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A63564252;
        Mon,  8 May 2023 19:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AD2C4339C;
        Mon,  8 May 2023 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683575503;
        bh=QjmoM9cJcJUOUhVADxIvA3E8it/o3wjIyJUrKe75UYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OaAQuqq74uDsxLLtTftA+EN8/d/vBaoIP+/hS+QWofVRyYPo2jQJy0UDEuFe1Okky
         FmHxsBlDR41j/bNfiqLlRWn2p2HF0u6UPvqvqHqZJslwN1XBRmH/Qp9eMYOMeIiKW+
         wk58Xgbqf7u5JcLYPpw+9y9+1fgi+sNBzPQMG3IwI1pCSl7oZJLyx44Vtsh4j4BqM2
         j6amClolR14vENa2ZTmRci6449DZw0+hDz7tb4Q47riDWM7p2Gzy9kRWWqbFxsN7RZ
         1KvhvMnN34YwFDVAj/vhQGacPuhhUvmCYJ6puMv0YAEJpJDoSzfLksO0E9E29G6Kqf
         sfiAKz+oaR17A==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1929d8c009cso3965013fac.2;
        Mon, 08 May 2023 12:51:43 -0700 (PDT)
X-Gm-Message-State: AC+VfDyq14jjrWAYNSrJZaFZ0oekHtI5R3pxGu/qqhdZrd3Gt1SOiJ8R
        W7PGFzdie90n/785xIwHDpC6UQ2CY2msytSVMDY=
X-Google-Smtp-Source: ACHHUZ6S4qiGMUFHdIt/I9G18KTGRmuDc2NDsff3O01FpiNZJtkscOijx0DfStXHb0GdsBHvtZO7FtcdmLSVq16S97w=
X-Received: by 2002:a05:6870:2201:b0:18e:9101:733b with SMTP id
 i1-20020a056870220100b0018e9101733bmr5398106oaf.14.1683575502823; Mon, 08 May
 2023 12:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <77994dd9ede2084d45dd0a36938c67de70d8e859.1683123587.git.fdmanana@suse.com>
 <b04cbeb31e221edea8afa75679e4a55633748af7.1683194376.git.fdmanana@suse.com> <20230505100301.GJ6373@twin.jikos.cz>
In-Reply-To: <20230505100301.GJ6373@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 8 May 2023 20:51:06 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5mBWMRnOMfHQBJ6icLEn4-saN7nsdFJfnSV_4_SZR5jA@mail.gmail.com>
Message-ID: <CAL3q7H5mBWMRnOMfHQBJ6icLEn4-saN7nsdFJfnSV_4_SZR5jA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix backref walking not returning all inode refs
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, git@vladimir.panteleev.md,
        Filipe Manana <fdmanana@suse.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 5, 2023 at 11:09=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Thu, May 04, 2023 at 11:12:03AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When using the logical to ino ioctl v2, if the flag to ignore offsets o=
f
> > file extent items (BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET) is given, the
> > backref walking code ends up not returning references for all file offs=
ets
> > of an inode that point to the given logical bytenr. This happens since
> > kernel 6.2, commit 6ce6ba534418 ("btrfs: use a single argument for exte=
nt
> > offset in backref walking functions"), as it mistakenly skipped the sea=
rch
> > for file extent items in a leaf that point to the target extent if that
> > flag is given. Instead it should only skip the filtering done by
> > check_extent_in_eb() - that is, it should not avoid the calls to that
> > function (or find_extent_in_eb(), which uses it).
> >
> > So fix this by always calling check_extent_in_eb() and find_extent_in_e=
b()
> > and have check_extent_in_eb() do the filtering only if the flag to igno=
re
> > offsets is set.
> >
> > Fixes: 6ce6ba534418 ("btrfs: use a single argument for extent offset in=
 backref walking functions")
> > Reported-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> > Link: https://lore.kernel.org/linux-btrfs/CAHhfkvwo=3DnmzrJSqZ2qMfF-rZB=
-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com/
> > Tested-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> > CC: stable@vger.kernel.org # 6.2+
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >
> > V2: Remove wrong check for a non-zero extent item offset.
> >     Apply the same logic at find_parent_nodes(), that is, search for fi=
le
> >     extent items on a leaf if the ignore flag is given - the filtering
> >     will be done later at check_extent_in_eb(). Spotted by Vladimir Pan=
teleev
> >     in the thread mentioned above.
>
> Replaced in misc-next, thanks for the quick fix.

Can you please remove it in the meanwhile?
I noticed this isn't quite right and there's still two cases not
working as they should be.
I'll send a v3 after finishing some more tests, probably tomorrow if
everything goes fine.

Thanks.
