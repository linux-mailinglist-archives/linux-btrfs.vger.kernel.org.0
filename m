Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3321D7547A3
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 11:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGOJKI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 05:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGOJKH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 05:10:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9C268B
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 02:10:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52165886aa3so1654999a12.3
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412203; x=1692004203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJAaEjc92XvP/UPLtBnPzEAjk08OF/fexYjreuH4O0A=;
        b=iA6/wXfKkYX8iypFGPAh33X+MNA1H16IBGaTQQm8sWN+S3ffwm4++6hsxx20kIu2xV
         O2ByTmX2W2FblJMe2z+W4btLsMcOGx1k2tYSIdmiElYQ3LMLKMk2ZkrwR8Qzp/4ol3sG
         pydN28rb0BtgBdYcDUfjMgRlQAaJm+qkSTwv2s+s1+UZaQWs57vSSFVNEwsQ8vH/hdO4
         ltuMgp/PnV+i8bSDsob8E5hOJCVh8mGWvc2L9DDEnQ17vzEfeMxT0Kn685rY3SWzw4tf
         hXTBZkY8/dSgWy4AyVnSl/5afC7OHiqH5+5XSzTPafhCmHdzUM21g2N8YvOHrDlRYug5
         tcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412203; x=1692004203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJAaEjc92XvP/UPLtBnPzEAjk08OF/fexYjreuH4O0A=;
        b=iOWGe4Nzj3/QIAvEqn+GoBfPWWCtxBQhtbpopvo5wuqtnucqP3u/37k3Erl608WbPa
         Kt/BFEzusvaFXRGwEmpL72Iumdig7jzvd2YLzvgvQyMtWNf7/2Ywsw3ZQiHEiTB+7qgU
         XhkBSrMgKuQpU9bYoBqm4eIQx4zaW7ltYYvm48qDn3XEzfK0RUwvwLEtM4bTeU/tZ4PD
         cfI60C8sGk1no3Ut/swCaXn1NNsMjCX5lKA7d/5sU96zij1OqY+7CfvR6rJm00LsV6f1
         dFzOQMUtBSazTGlGkxRv5biMCzMYFbGv56bsTPpRyIc7Mx6zt9YPDESYtwIsyXS0lX7s
         bK2A==
X-Gm-Message-State: ABy/qLY+SdiIlrbP50GuoytsmWQPHGxM6yhuxkIa9icWRTcs0Td0sBeZ
        LRGk+oEc5QteT+/dTSUQXOmj2hG1JJuGa+jS5xU=
X-Google-Smtp-Source: APBJJlEzAmjz75A1vwof1w9kd/yzkYl7Ky3tkSXH+6rtQQZ7ayjSNNXUlcGGs0McHN59hXAjG06gPl/UfsjODRFL4Fg=
X-Received: by 2002:aa7:c1cc:0:b0:51d:d568:fa4e with SMTP id
 d12-20020aa7c1cc000000b0051dd568fa4emr5533899edp.41.1689412203174; Sat, 15
 Jul 2023 02:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <87cz0w1bd0.fsf@oldenburg.str.redhat.com> <f393fcb9-2d8b-e21e-f0fb-d30cbbb1ed3b@libero.it>
In-Reply-To: <f393fcb9-2d8b-e21e-f0fb-d30cbbb1ed3b@libero.it>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sat, 15 Jul 2023 05:09:26 -0400
Message-ID: <CAEg-Je8EGjyX3CCcAywy7K2osGAj36T_Cbz5+VXfy4XbcemJ4g@mail.gmail.com>
Subject: Re: btrfs loses 32-bit application compatibility after a while
To:     kreijack@inwind.it
Cc:     Florian Weimer <fweimer@redhat.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 15, 2023 at 4:32=E2=80=AFAM Goffredo Baroncelli <kreijack@liber=
o.it> wrote:
>
> On 13/07/2023 10.09, Florian Weimer wrote:
> > As far as I can tell, btrfs assigns inode numbers sequentially using
> > this function:
> >
> > int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
> > {
> >       int ret;
> >       mutex_lock(&root->objectid_mutex);
> >
> >       if (unlikely(root->free_objectid >=3D BTRFS_LAST_FREE_OBJECTID)) =
{
> >               btrfs_warn(root->fs_info,
> >                          "the objectid of root %llu reaches its highest=
 value",
> >                          root->root_key.objectid);
> >               ret =3D -ENOSPC;
> >               goto out;
> >       }
> >
> >       *objectid =3D root->free_objectid++;
> >       ret =3D 0;
> > out:
> >       mutex_unlock(&root->objectid_mutex);
> >       return ret;
> > }
> >
> > Even after deletion of the object, inode numbers are never reused.
> >
> > This is a problem because after creating and deleting two billion files=
,
> > the 31-bit inode number space is exhausted.  (Not sure if negative inod=
e
> > numbers are a thing, so there could be one extra bit.)  From that point
> > onwards, future files will end up with an inode number that cannot be
> > represented with the non-LFS interfaces (stat, getdents, etc.), causing
> > system calls to fail with EOVERFLOW.
> >
> It is a know btrfs issue. On 32 bit some workloads may cause the
> exhaustion of the inode number.
>
> There was the inode_cache feature that it was supposed to permit to
> reuse of the inode. It was removed, below some more details
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/20200623185032.149=
83-1-dsterba@suse.com/
>
> It was deprecated in 5.9 and removed in 5.11 (see commit
> f5297199a8bca12b8b96afcbf2341605efb6005de)
>
> Despite the technical details, I am curious about how many 32 bit
> systems still uses btrfs.
>

It was somewhat common for Fedora users. A number of Fedora 32-bit ARM
variants used Btrfs until 32-bit ARM was discontinued in Fedora 37[1].
openSUSE still has 32-bit ARM and x86 support in Tumbleweed.

This issue is also possible on 64-bit x86 systems where 32-bit x86
applications run on it. That's what this report is about. We're
hitting it in Fedora because our 32-bit x86 builds in Fedora
infrastructure run on 64-bit x86 environments and triggered this[2].

[1]: https://fedoraproject.org/wiki/Changes/RetireARMv7
[2]: https://pagure.io/releng/issue/11531


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
