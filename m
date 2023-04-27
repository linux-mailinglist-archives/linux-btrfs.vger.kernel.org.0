Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED736F09EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbjD0Qfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 12:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbjD0Qfh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 12:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F86A46BE
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 09:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD5A263E49
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 16:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E887C433EF
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682613335;
        bh=qGEid1uoYVkfmq5csKnUcLPXcBw3TEWFDMvSLBBTO60=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lKlHX8ihS9l9lieX/VP/xc5OfsOsjWRV2vq/dxWWpNhbRjqtDpP64pIOnJTxZJmNm
         fS73nhLswdhBGeIEamXxIJUkN+MjFZKzYas+eScB5UrSUt6AOHG6AQ2w1z9Ac2pa7U
         uiWsHTLJMKnFHAYLq1MEeXzk2V+IMH1YDWmpgrjd6RTyRY2ztQ8F7uNan7mKV1bWvH
         zA1adt8uBBTDeA5Pwy4YbbJsFBJ1xmJZ4YR5mRgKuVtt/vLr3gzX8b5FqVB5UMx3Uo
         cp4Qwo86Se1jwcF65WLj0L9U7V01ZhL6Ym4JMq3IUhVVzHsuMP+NNHSfprhlIa+XMD
         4HCmRXF8Mgm+Q==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-187ba2311b7so7012279fac.1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 09:35:35 -0700 (PDT)
X-Gm-Message-State: AC+VfDyi7i0MDc8NNkgEWT/1Ddl6NnUbpuxRHMPjyiUDCK8qjn9BF32R
        oFVIGaOuOe6carEQW8JIvnm+Uo7JXXh2HF7JKiA=
X-Google-Smtp-Source: ACHHUZ7d8m688Q9wrXZGJ9+dGWg/HTopDxtcXzc6aovY2hybn5BXC17XD/4p1K0J52YdMPs7d8dq4yXjzRr5vCZX3OM=
X-Received: by 2002:a05:6870:955b:b0:187:aeb3:81a6 with SMTP id
 v27-20020a056870955b00b00187aeb381a6mr1017345oal.6.1682613334384; Thu, 27 Apr
 2023 09:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682528751.git.fdmanana@suse.com> <e695f292be17c831e6024a743365737372a7a7aa.1682528751.git.fdmanana@suse.com>
 <043226b3-3543-0430-c479-7a1824be5fa6@oracle.com>
In-Reply-To: <043226b3-3543-0430-c479-7a1824be5fa6@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 27 Apr 2023 17:34:58 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Xh9_Farxym2+a16TLNuSk+P5qJaoCZ4UcuV08PAo88w@mail.gmail.com>
Message-ID: <CAL3q7H6Xh9_Farxym2+a16TLNuSk+P5qJaoCZ4UcuV08PAo88w@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix leak of source device allocation state
 after device replace
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 27, 2023 at 4:16=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> On 27/04/2023 01:13, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When a device replace finishes, the source device is freed by calling
> > btrfs_free_device() at btrfs_rm_dev_replace_free_srcdev(), but the
> > allocation state, tracked in the device's alloc_state io tree, is never
> > freed.
> >
> > This is a regression recently introduced by commit f0bb5474cff0 ("btrfs=
:
> > remove redundant release of btrfs_device::alloc_state"), which removed =
a
> > call to extent_io_tree_release() from btrfs_free_device(), with the
> > rationale that btrfs_close_one_device() already releases the allocation
> > state from a device and btrfs_close_one_device() is always called befor=
e
> > a device is freed with btrfs_free_device(). However that is not true fo=
r
> > the device replace case, as btrfs_free_device() is called without any
> > previous call to btrfs_close_one_device().
> >
> > The issue is trivial to reproduce, for example, by running test btrfs/0=
27
> > from fstests:
> >
> >    $ ./check btrfs/027
> >    $ rmmod btrfs
>
> Ah, module reload is a useful way to verify. I have now enabled
> it in the fstests by setting TEST_FS_MODULE_RELOAD=3D1, and I am
> able to reproduce the issue.
>
> >    $ dmesg
> >    (...)
> >    [84519.395485] BTRFS info (device sdc): dev_replace from <missing di=
sk> (devid 2) to /dev/sdg started
> >    [84519.466224] BTRFS info (device sdc): dev_replace from <missing di=
sk> (devid 2) to /dev/sdg finished
> >    [84519.552251] BTRFS info (device sdc): scrub: started on devid 1
> >    [84519.552277] BTRFS info (device sdc): scrub: started on devid 2
> >    [84519.552332] BTRFS info (device sdc): scrub: started on devid 3
> >    [84519.552705] BTRFS info (device sdc): scrub: started on devid 4
> >    [84519.604261] BTRFS info (device sdc): scrub: finished on devid 4 w=
ith status: 0
> >    [84519.609374] BTRFS info (device sdc): scrub: finished on devid 3 w=
ith status: 0
> >    [84519.610818] BTRFS info (device sdc): scrub: finished on devid 1 w=
ith status: 0
> >    [84519.610927] BTRFS info (device sdc): scrub: finished on devid 2 w=
ith status: 0
> >    [84559.503795] BTRFS: state leak: start 1048576 end 1351614463 state=
 1 in tree 1 refs 1
> >    [84559.506764] BTRFS: state leak: start 1048576 end 1347420159 state=
 1 in tree 1 refs 1
> >    [84559.510294] BTRFS: state leak: start 1048576 end 1351614463 state=
 1 in tree 1 refs 1
> >
> > So fix this by adding back the call to extent_io_tree_release() at
> > btrfs_free_device().
> >
> > Fixes: f0bb5474cff0 ("btrfs: remove redundant release of btrfs_device::=
alloc_state")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/volumes.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 03f52e4a20aa..841e799dece5 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -395,6 +395,7 @@ void btrfs_free_device(struct btrfs_device *device)
> >   {
> >       WARN_ON(!list_empty(&device->post_commit_list));
> >       rcu_string_free(device->name);
> > +     extent_io_tree_release(&device->alloc_state);
> >       btrfs_destroy_dev_zone_info(device);
> >       kfree(device);
> >   }
>
>
> Hmm. Is this fix incomplete? It does not address the concern raised in
> f0bb5474cff0. Why don't we also do this...

What's the concern exactly?
One extra call to extent_io_tree_release() that's actually needed?

>
> -----
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 40ef429d10a5..e8c26856426e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1133,7 +1133,6 @@ static void btrfs_close_one_device(struct
> btrfs_device *device)
>
>          device->fs_info =3D NULL;
>          atomic_set(&device->dev_stats_ccnt, 0);
> -       extent_io_tree_release(&device->alloc_state);

This will change semantics a bit.
Removing this, will make us hold on to more memory for a longer period
when fs_devices->opened > 1, so btrfs_free_device() /
free_fs_devices() will be called potentially much later.

I'd rather keep the behaviour we had unless there's a stronger reason
other than removing 1 line of code.

Thanks.



>
>          /*
>           * Reset the flush error record. We might have a transient
> flush error
> -----
>
> Thanks, Anand
>
>
