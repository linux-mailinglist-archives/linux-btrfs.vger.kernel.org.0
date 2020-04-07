Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053F61A0BAB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgDGKZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 06:25:35 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:38273 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgDGKZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Apr 2020 06:25:34 -0400
Received: by mail-ua1-f42.google.com with SMTP id g10so1082441uae.5;
        Tue, 07 Apr 2020 03:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yKK3YVn/8zz0KqCfbJQl64c90q4g0xNTq14ul3lnAo8=;
        b=Li4oV6AVipwC0gP0HIjbgvoaJ5Y6TNpZnE38jmmq8TwPPu65XuWLau3kOrt38mH/JV
         iYvn7ut6EcEbFp4jRYi45DGecGKUzvqcOfw0DNN8Sq/uO9hMZecf9RS02Z8PuUMREu45
         BFMlejGB5U1x0LNqI+nzyj2MqcDQoB+rTLrxE6JhIJBt19bGbWRAQPM0Te3/iJ1jx78l
         m2+3FIq1adiwQfS0gW+qsI1IZgFku8H2XwOPNUlyfhYWZluVrStMWysr01IiyT2ExurW
         lqDK0TWECaqdeFrAiyZbFdw/hQ414R/AVwII5i7KyaA6Ozqx9SmFGLzzEOzhQ4uYcEWM
         4nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yKK3YVn/8zz0KqCfbJQl64c90q4g0xNTq14ul3lnAo8=;
        b=etKOMQ5WIUVrageBoQFXHlTGRkPDLK+4xfZ6EnliIBKzHVlt13vI906OdXoR4+gSVx
         dJLu9pNq8f4e0fbLY2TZP28JTVetspR/LQxSn5+zWhSAbHNV4+t0t5zEk26VEW7FX8Qt
         WhbKH3B4ntvrZSJmJ9QaXq02O20YTRoiquETlm+Z65WGJUpCLpnvwnaV7WeYXiS9KFRu
         yOsEmd8MY38SyrbFfEdFMnPPvZaures9DlqHOxS8JSzVZqTK9jj0yCOcDmk1oVIlcMHB
         kFjD4lDq1qg91etb8orOdLxf/ZnAyXlOqX6Z1KkC4BpPSsQNHMIoEpu2XabRwQiRi7lt
         ngeg==
X-Gm-Message-State: AGi0PuZPamMNCjLrJhaMwlnPqcuV6K4Toc2bF5O7pPfxEER8r6L1xhKo
        5MkKe4N8I3ISDX878IfYa9/Pb9xZTihjd6rkJzk=
X-Google-Smtp-Source: APiQypKTTAK0LBSsIxSdtxgw02gTm+TqcEP/9sBn14rl8UN/CIBiuck4F/pC+Ol0kAk+3tn+pCrgJWBXWbYNx5HykPg=
X-Received: by 2002:ab0:5bcc:: with SMTP id z12mr1105063uae.135.1586255133114;
 Tue, 07 Apr 2020 03:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2wg3Sqw_a3dwjh6nQn8h-SsyM3v=43Oqce7Eq0U-Jcb7EaaA@mail.gmail.com>
In-Reply-To: <CAM2wg3Sqw_a3dwjh6nQn8h-SsyM3v=43Oqce7Eq0U-Jcb7EaaA@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 7 Apr 2020 11:25:22 +0100
Message-ID: <CAL3q7H5uq-ucGC5zMBkmtCBToHeiaJsqM=Nz0R_U5dTGjSnpkg@mail.gmail.com>
Subject: Re: Strange sync/fsync behavior in btrfs
To:     Arvind Raghavan <raghavan.arvind@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Jayashree Mohan <jayashree2912@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 6, 2020 at 8:47 PM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> Hi!
>
> I am Arvind Raghavan, an undergraduate student at the Unversity
> of Texas at Austin, working with Prof. Vijay Chidambaram. I've
> been working on the Crashmonkey [1] project, which is a test
> harness for file system crash consistency checks. Specifically,
> we've been working on making a fuzzer to find new bugs, and we
> discovered some weird behavior. Given the following workload:
>
> mkdir A
> mkdir B
> mkdir A/C
> creat B/foo
> sync (1)
> link B/foo A/C/foo
> fsync A (2)
> <crash>
>
> Running on Linux 5.5.2, upon recovering the filesystem, the hard
> linked file A/C/foo is not present.

Expected on btrfs at least. Nothing changed in directory A after the
'sync', so the fsync is a noop. Only directory C and the inode of file
B/foo had changes.
We don't go recursively checking if any sub-directories changed. That
would be very expensive, plus I don't think anyone expects that in
real use cases.
If you want A/C/foo persisted then fsync A/C or fsync AC/foo or fsync
B/foo (at least on btrfs this should work).

> However, if we replace (1)
> with "fsync B/foo", then upon recovery the link persists. This

Replacing the 'sync' with 'fsync B/foo' is different.
When that fsync is done the inode is logged in btrfs, and then the
"link B/foo A/C/foo" causes the log to be updated with the new dentry
because the inode was logged before.
It's the link creation that persist the new dentry, not the "fsync A".

> behavior seems strange, as intuitively it seems that sync should
> have at least as strong effect as fsync. In addition, it seems
> that Chris Mason's definition of fsync guarantees here [2] might
> require this workload to pass.
>
> It is important to note that even if we skip the final fsync (2),
> the result is the same. Thus, the behavior is coming only from
> the syncing operation at line (1). However, we were also curious
> to know whether an fsync of the directory A here (2) should
> persist the file A/C/foo. Chris mentions [2] that an fsync
> of a directory means that "all the files/subdirs will exist".

I don't think his definition includes recursion... nor that people
usually expect that.
I think he meant the sub-directory C and all other dentries of A will
exist, not that dentries of C or any other descendants will be
persisted.

Thanks.

> Should this apply to files created in subdirectories?
>
>
> Thanks!
> Arvind
>
> [1] https://www.github.com/utsaslab/crashmonkey
> [2] https://www.spinics.net/lists/linux-btrfs/msg77330.html



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
