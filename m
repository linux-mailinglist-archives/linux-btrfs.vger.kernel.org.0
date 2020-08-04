Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990F723B241
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 03:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgHDBZE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 21:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBZE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Aug 2020 21:25:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20EC06174A
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Aug 2020 18:25:04 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l17so40555039iok.7
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Aug 2020 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LXUEzGLYAYZJ8IPXVCfqiMwBDrgk/5aXGnx8jITLgBE=;
        b=FMn9lmvLOU8sdWDS5encnE9l4vJin8sCFhnlSid2bEWaXA5rvH4tatDFujqvXSvx0N
         0YOXPW5cyEpyjtj340D49uLTnRUJCB3oy1pbZelfITwYy1DhGSMkIPsJ8zSCrW1hsnJg
         GUdYmIkap52BvT2VdfqfcO6wIBTMKURCaZ2smkcWuQ+ong3CXDQWqvxz9b0ElOGxVwK8
         tehGPiIv7mdAiiDMhsQuQaFGBy6Pr/WBcbRxVVjRmZyJ7ZOJG41kspK5r4guIOukIRe5
         XrCjbfVUWOs/bmEbKlLmKQqR3wl2yonsXoSt2rJGr1swRM6dywTcuHzm+zRcqj4Dodwf
         5FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LXUEzGLYAYZJ8IPXVCfqiMwBDrgk/5aXGnx8jITLgBE=;
        b=fk501Xj9CBbeXvQbyg/6PsaG2Uk+acXgmzYNz0G91S8N9hZBEDf2bdnO84dd8NkAcm
         96Idl5kOrIAABvIQ/xznO9teseRYrVRVLiM2FjrSWkCc4k9GV+LPQ3KvMWHU9DJqvZ3I
         goVyNTzpOHsNdsTIJwGU/i6+r9zQ6/DRCDh01rDjA0szABy3tZAKxk1Vvjk8u7MLUtuJ
         LhCowZaLuYDPyuy3e9lQBfluY53Wf2nrm4aaZSNu4NcdDWBuVUSe/7iugN+YG7SKLiuz
         qKUn4XVNRjlMlovEtOJ0C7b4l3RLLygRyDa4ytbNyP2cq8tuD0NzJqif7H7aETyyhU7Z
         9uIg==
X-Gm-Message-State: AOAM532bhxvfG/zGoUp7AqrrTmH79USSc2eQ/IKrpU6eummzaiROlKFu
        GtPS1dvjiMs5g0giP3yQLtJ+/CxwsU5jgnJfiRtZnRbZ
X-Google-Smtp-Source: ABdhPJyRXspY5MMRt5kiNwnn78rHkzxyzc6DYC/81vxyc14LGydBgDwIreX3wPbF/TUGHaA/tG0aNtXNBdaMwGllUH4=
X-Received: by 2002:a05:6638:2692:: with SMTP id o18mr2891728jat.2.1596504303330;
 Mon, 03 Aug 2020 18:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200803042944.26465-1-marcos@mpdesouza.com>
In-Reply-To: <20200803042944.26465-1-marcos@mpdesouza.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 3 Aug 2020 21:24:27 -0400
Message-ID: <CAEg-Je8VCXVC=9z-cCtszKxKeVbRMUojEQzHAuYkgdv4jXm-oQ@mail.gmail.com>
Subject: Re: [PATCH btrfs-progs] Documentation: btrfs-man5: Remove nonexistent
 nousebackuproot option
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 3, 2020 at 1:05 AM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> Since it's inclusion in b3751c131 ("btrfs-progs: docs: update
> btrfs-man5"), this option was never available in kernel, we can only
> enable this option using usebackuproot.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  Documentation/btrfs-man5.asciidoc | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5=
.asciidoc
> index 064312ed..2edf721c 100644
> --- a/Documentation/btrfs-man5.asciidoc
> +++ b/Documentation/btrfs-man5.asciidoc
> @@ -471,7 +471,6 @@ The tree log could contain new files/directories, the=
se would not exist on
>  a mounted filesystem if the log is not replayed.
>
>  *usebackuproot*::
> -*nousebackuproot*::
>  (since: 4.6, default: off)
>  +
>  Enable autorecovery attempts if a bad tree root is found at mount time.
> --
> 2.27.0
>

Shouldn't this option be plumbed through instead?

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
