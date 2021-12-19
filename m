Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7907047A103
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Dec 2021 15:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhLSOqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Dec 2021 09:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhLSOqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Dec 2021 09:46:18 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC480C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Dec 2021 06:46:17 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id o63so1003172uao.5
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Dec 2021 06:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uqzXm0Fse7t5/GKsWisIqXtQBabIA80CiOZUPAu0FEA=;
        b=Y03a9PVmjoZDaOJZxv+GOSBIjYqmEZLSIoqsj5NLHWqhQSpuuVVzAIR0exzcEcNzLj
         Y/V6q8SsSv1QkKhpES/9d9CW6IuKM2/IJUAxrewwGQVYa1WIUZUEnf/UYtcpLeo25fnP
         7+6I9sP/QsNclATIWKq84ZidjXnAhIslKE9Qx0fWG3Nr348HaEpoKdJ3lr72WZpIEafs
         wP1esokmvxn0+Z74ELz9y6eBRAKe3zRzoiunfYUnroH9q4xSBL/vB7HVdIl7fCcM1cX3
         V0AZE7Krr0u5FTwLTtun2UirKy3w3AkEsO3WXY+410W+9is5Wz8uK1ahp1Lvt96q+tHS
         BXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uqzXm0Fse7t5/GKsWisIqXtQBabIA80CiOZUPAu0FEA=;
        b=nH5KtsmYjLBeBIgCZwNSB2d5qMnIr/iIp8q/Rol/+g7MbhVLpo1hSpJFJx0sn8JTNv
         Ig6qCAewsuotFCj4jzy3izvAA+6p06fAJTJgjXEh4jya4ztsAPF9OTusupJ5NRBc1VyE
         Db6+htQON8Txs7O0rXwJq8Av0TmOICUTQs2dQT8YgOXban82M4Wyj8yw7enYAfIEtpfH
         VrfHxgh0LWUl6MzyRa7VWo1dXJrj89IySJNoR1OxDgctS3AbV66VIzZ4CBJKsopVgVBr
         0u/lz1BIIv4a73IlqYaULNoGwJMeODdueHtKij6v2LcX4Pl22YbNnsjQXjohbkM+hOU0
         LxUA==
X-Gm-Message-State: AOAM533Q236+2UID27FZrq6gIbob5oAK/RSeVRZqf8VvK1Ot0JPZf/Zq
        ecuJsC4UTVH4TzGFE2HT/kY9DA22kPafcyfRvF5vZlRr
X-Google-Smtp-Source: ABdhPJwvM50vUo65Tn1owefkA2TR8onLXJ1+O/6l1e+LsRTr2EhzsdGwnkogMuYWb86YNTxSTx/WNHpO09Egcz0Ndug=
X-Received: by 2002:a05:6102:10a:: with SMTP id z10mr491755vsq.20.1639925176660;
 Sun, 19 Dec 2021 06:46:16 -0800 (PST)
MIME-Version: 1.0
References: <CAHzMYBQ5zMw=dUMRqn-_qYoAjYKadj6qio=5t3nudiOftTaqOQ@mail.gmail.com>
 <57e198c.2779e098.17dd30e4224@tnonline.net>
In-Reply-To: <57e198c.2779e098.17dd30e4224@tnonline.net>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Sun, 19 Dec 2021 14:46:06 +0000
Message-ID: <CAHzMYBT_8=PUWeiR2eX4tTnYdAami1QompcvOnNdfUe7TMFCwA@mail.gmail.com>
Subject: Re: Balance metadata
To:     Forza <forza@tnonline.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 19, 2021 at 2:17 PM Forza <forza@tnonline.net> wrote:
>
> You might benefit from a general data balance too because balancing is re=
ally a free space defragmentation.

Thanks for the reply, yeah, it probably would, but it would take a
long time and I'm trying to avoid it for now.

>
> Space_cache=3Dv2 mount option can help because it is more performant with=
 free space fragmentation.
>

Already using v2.

> Another option is to defragment the metadata and extent trees.
>
> Example :
> # btrfs fi defrag -v /media/backup/
> WARNING: directory specified but recursive mode not requested: /media/bac=
kup WARNING: a directory passed to the defrag ioctl will not process the fi=
les recursively but will defragment the subvolume tree and the extent tree.=
 If this is not intended, please use option -r .
>
> You would have to do this for each subvolume. It can't be done for read-o=
nly snapshots though.
>

Filesystem only has read-only snapshots, so Iguess it won't help here.

Best,
Jorge Bastos
