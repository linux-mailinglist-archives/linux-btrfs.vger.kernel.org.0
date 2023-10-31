Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5507DCCB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 13:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjJaMOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjJaMOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 08:14:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCB391
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 05:14:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340FEC433C8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698754453;
        bh=aV9Qv0TestdllnH2WhfHJd4+W/7BN9Ltl9L0TNxD6Tg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tU7JsQEK2qo4bzbRyrgbL69beoSiym63yDTasQs6j8kyL+qRtwbsdLTdQZ1SFw1jV
         xOspM84TMYq+3lONO+m9/gkNXpSbYZ/0LCT4nLCycieVmUVtL8nB+FCcv9qPmieQ2+
         0aTCYJUVvm1MXdojzCo88KAM9W3ytEgxOelMQU9+RMwvp5IvjuM8Tznw9gUNl6G/9Z
         EHGKfCEH5pIHPH4vp9LwZrONcE3PBnW7QbGKY8z2QBhWAQD3D+4K2sXrSCc+HEUpdM
         neMDQMnKEYOt8bWbIYD6D2Ix5bN/y6VkqETvmM7brFoTkb3NAFPB1uIUyN2TJM6o2G
         or6q6C9rm1bmg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso9077895a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 05:14:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YzMgE5phnS27F110L87mmSaa05GTMaUQE1Lzgs0Fdp++DW33ScO
        ocx48VigQJs3CKL1Ei7bhxomVYmT2bj45CZ6T68=
X-Google-Smtp-Source: AGHT+IEsFQ1p3UkNW/nzx+PPAteJkiLHZ8km2bmLZoggT/nPhb/WT4OJoGisEMzIHBlqMSG8qel6siCQSWdf8C+Zcvo=
X-Received: by 2002:a17:906:eece:b0:9ce:96db:c83e with SMTP id
 wu14-20020a170906eece00b009ce96dbc83emr12055112ejb.42.1698754451619; Tue, 31
 Oct 2023 05:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <86c522f5e01e438b4a9cc16a0bda87a207d744e6.1698666319.git.fdmanana@suse.com>
 <90389e48-1ce6-478d-8cb9-ec365fbea9d1@oracle.com>
In-Reply-To: <90389e48-1ce6-478d-8cb9-ec365fbea9d1@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 31 Oct 2023 12:13:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H72s8V6X-LkzmukdceHA3T3Z2W-rpSo5hgceWHFu5-+JA@mail.gmail.com>
Message-ID: <CAL3q7H72s8V6X-LkzmukdceHA3T3Z2W-rpSo5hgceWHFu5-+JA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix error pointer dereference after failure to
 allocate fs devices
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 31, 2023 at 1:12=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> On 10/30/23 19:54, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > At device_list_add() we allocate a btrfs_fs_devices structure and then
> > before checking if the allocation failed (pointer is ERR_PTR(-ENOMEM)),
> > we dereference the error pointer in a memcpy() argument if the feature
> > BTRFS_FEATURE_INCOMPAT_METADATA_UUID is enabled.
> > Fix this by checking for an allocation error before trying the memcpy()=
.
> >
> > Fixes: f7361d8c3fc3 ("btrfs: sipmlify uuid parameters of alloc_fs_devic=
es()")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/volumes.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 1fdfa9153e30..dd279241f78c 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -746,13 +746,13 @@ static noinline struct btrfs_device *device_list_=
add(const char *path,
> >
> >       if (!fs_devices) {
> >               fs_devices =3D alloc_fs_devices(disk_super->fsid);
> > +             if (IS_ERR(fs_devices))
> > +                     return ERR_CAST(fs_devices);
> > +
> >               if (has_metadata_uuid)
> >                       memcpy(fs_devices->metadata_uuid,
> >                              disk_super->metadata_uuid, BTRFS_FSID_SIZE=
);
> >
> > -             if (IS_ERR(fs_devices))
> > -                     return ERR_CAST(fs_devices);
> > -
>
> Aiyo!
>
> Thank you for the fix. How were you able to identify this issue?

By reading code while working on a large change in volumes.c...

>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
>
>
> >               if (same_fsid_diff_dev) {
> >                       generate_random_uuid(fs_devices->fsid);
> >                       fs_devices->temp_fsid =3D true;
>
