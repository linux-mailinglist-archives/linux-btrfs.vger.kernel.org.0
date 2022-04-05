Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CED14F4782
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiDEVML (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573265AbiDESik (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 14:38:40 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF51F167E3
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 11:36:41 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z6so265562iot.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJvrU/lISZybCDehjwHI8v1+SSk5FfiYY/+rNxIlB4U=;
        b=gu7ho6/DluoaFC14tiYnV5Z4nhWe0WInxuAeLQ+tQZQtd/JdscxDkPTWT4oug6eYmg
         lJEXF0dXxezwjkwWoirrDPTOodfglQb33Yooy4Dc+2fvdE+rf6MG4egtdCRKyYBTKw1+
         CTux1kilEo6m5zQPG/KmnI+SachYniq19euuF25pf+KTNYzCn6lY1xju+i6ZqJJ0/0xB
         g0jdZpvDK6F5rmoJnrPF29Y9LfNzt7ezoOLBKjzykkGLMZwOWfV+D0iu83UxlFum25ex
         q1u9rrWdH/++dEauvPhHYX6Dn+W67Ema+rW5FIlEWgx5gmXtcVywaB7IccPFOUmgbImU
         Sdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJvrU/lISZybCDehjwHI8v1+SSk5FfiYY/+rNxIlB4U=;
        b=nLeGlCM4saUO2a9dzYEhcG/3sEts9nFkgWcYCii+RPkPYnMAyIuXKRy5gAqF6UY26k
         kyDFqWwUYqdpPVOqEqZFvlLvW08avNhKYnO8WaX6DPpO5TrBpd1f3KtCmZC+/qwqAYkV
         rmKrmUXeBGPGPW5p8qQTXBOGLZi16j43v06W05KiADUegP3oj8HsMdA1XYrSEOI8qcSz
         PNOck1yhSdCs3gxUfJPiFv94EGZLMECZM9BTixkCCalKLO9XKswZmMEeomFJVwHZvXah
         7dPzdfd7dBoTN+TXy5qxDj9csNFLTK3ABt3VFM1ms5CdSDGmVhFOJsT258MCWDQWRbKM
         RtFA==
X-Gm-Message-State: AOAM53258XTdBGQLknb8Nj3Ccm4myht/6W7cyOi2b8vsnQ62Pc5Q/F1V
        NIcSeYnj5QtFBIgYlVfVwnXCyRQZR3fq6p+z//8ijvCiTVY=
X-Google-Smtp-Source: ABdhPJyRNaDx+C0PuFnFUtuVKOQq/E9yX5zJKvFugRGIEjQArXGoRezJuB+DPJXSITk1nlBjhwZeUReG+x7aKPgE7zI=
X-Received: by 2002:a02:6010:0:b0:31a:6d4f:d9ca with SMTP id
 i16-20020a026010000000b0031a6d4fd9camr2637572jac.46.1649183801034; Tue, 05
 Apr 2022 11:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
 <20220405011559.GF5566@merlins.org> <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
 <20220405014259.GG5566@merlins.org> <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
 <20220405020729.GH5566@merlins.org> <CAEzrpqd6kePW6eiMB-R4DvMRvU=AK-jKpkBNUvSjttsSEsCwpA@mail.gmail.com>
 <20220405155311.GJ5566@merlins.org> <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
 <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com> <20220405181108.GA28707@merlins.org>
In-Reply-To: <20220405181108.GA28707@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 14:36:29 -0400
Message-ID: <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 5, 2022 at 2:11 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 01:41:10PM -0400, Josef Bacik wrote:
> > Ok I think I'm going to do a humpty-dumpty thing where I scan for the
> > best possible copies of blocks and stitch them into the tree root.
> > I've wired something up to find out how many bad slots we're working
> > with so I've got an idea of how careful I need to be, can you pull
> > your branch again, rebuild, and run
> >
> > ./btrfs-find-root -o 1 /dev/whatever
> >
> > and send me the output?  I'm working on the tool right now, hoping it
> > takes me a couple of hours at most (mostly because I have meetings
> > sporadically throughout today).  Thanks,
>
> Cool. there you go
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1
> /dev/mapper/dshelf1a
> Couldn't read chunk tree
> WTF???
> ERROR: open ctree failed
>

That's new, the chunk tree wasn't failing before right?  Anyway I
pushed a change, it should work now, thanks,

Josef
