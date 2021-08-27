Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6401A3FA005
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 21:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhH0TcT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 15:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhH0TcS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 15:32:18 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E5BC061757
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 12:31:29 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t32so6213178qtc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Mad1W2YgzIPolrRocr0j9OeNxFAquqVz5PuuU5kR62s=;
        b=RNupgSd9+I02h8MLirf3J0eGlB8oCZQYN1rmz/MP0V1MMAaQwy6btTU1zkd2orV5R7
         HE+ptJH06qUKbo6YrtwTcF9GKJ/0kj2Y0BN3ZrtK1PRne+bamRde9C32ICgQwyet+kyt
         Trnn/7DXNx16sy1IAfCqTmDr52ML1AmQJhMN8VImLHqP2qaWBycU9X+49WcgCzTVVtgH
         dXnSEVZrbbLy0PVWQsuZVBQZh8fNFPg1VdmQXvxFarLFZAyrCDuRqsh2Wv6iQwKiI1mZ
         SHjpd7C89vxDq3kn0ilXeVSJf7gftftDX9sJ7um7JxN37zY9VBttvsdE2FjLYeKkaM1/
         B+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Mad1W2YgzIPolrRocr0j9OeNxFAquqVz5PuuU5kR62s=;
        b=G5E/uIqJaIO+9yNIeuRD5LlVcaAhSl0Z55b4xbb/d4l9GS+oNchmSYJVisVPtLDwZv
         I5G8STJ1XHwDwtITbPiuL2Pj3fVkGcHvANuuW9kWFRtRv/U0OryOl2Tgf7zLiOMnIsKe
         7pomb5GsiprFg48MENrjVy9gpJu5WRXoyuVHw0zDE7gAngV7LoQfodiMBgubxRz9vdzd
         4SpHA5ssWxemcvY33M2wTmjphtqdCFmM2Aawuu89DXGOHbMUEgn2Bpf0GQO/p1Aysd8U
         UVRtS3I4a0DtVQ4yhTqPRITtteC7wzmjVPrb1tHWUOWZGDFDMReH4z5nRwtoMc04KsTU
         wU5w==
X-Gm-Message-State: AOAM530/kbchA8Rad2D/Pa41c9TXS2jGKu6kXLecvDskijDMXm6NN/9N
        rZiV5fLlv6WGvwWNbRtxZHI6y9hpKbqMgUYFRvFe+emZCac=
X-Google-Smtp-Source: ABdhPJwA+m9xRP1E4NiAvSrvjfhyiXnBp0i8Y/IglpDWyZrwEuasOEqg+UGZOlikWMyV5E2kT8Srvt6OQRUAZ0f/uns=
X-Received: by 2002:a05:622a:5d4:: with SMTP id d20mr9931076qtb.376.1630092688922;
 Fri, 27 Aug 2021 12:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com> <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
In-Reply-To: <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 27 Aug 2021 20:31:17 +0100
Message-ID: <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 27, 2021 at 7:01 PM Darrell Enns <darrell@darrellenns.com> wrot=
e:
>
> I tried it with the patch and it still failed. Here's the verbose output:
>
> offset=3D79101952 length=3D32768
> clone home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> source=3Dhome/denns/.mozilla/firefox/dtfto95g.default/places.sqlite
> source offset=3D79134720 offset=3D79134720 length=3D4751360
> ERROR: failed to clone extents to
> home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite: Invalid
> argument
>
> Snapshot IDs are 881 and 977. The compressed tree dumps are still a
> bit big for email (166MB total), so here is a download link:
> https://mega.nz/file/wF5EHSCZ#P0E9S3291NOO4chjPbj7IbSCJ_9LplpKagGE431jzIQ
>
> I'll leave the link up for a few days. Dumps were created with
> --hide-names. I did it with the filesystem mounted, but tried to avoid
> any significant write activity and also made sure firefox was not
> running (so nothing would write to the affected file).

Ok, got it.
And what's the inode number of
"home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite"?
Just paste the output of 'stat' against it, it should be the same
number in both snapshots (please verify it is so, just in case the
file was renamed between snapshots and a new one created with the same
name).

I need that to locate the extents of the file in tree dumps.

Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
