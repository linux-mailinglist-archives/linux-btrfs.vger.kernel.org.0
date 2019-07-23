Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3FEF716D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 13:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfGWLVl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 07:21:41 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42265 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfGWLVk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 07:21:40 -0400
Received: by mail-vs1-f65.google.com with SMTP id 190so28538047vsf.9
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2019 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7lil/dkQO5cgpYUggDCk++wNipbuXpnFGUHcU4Jkojc=;
        b=CU6sCumI5CeJPqeUBAXY3sdcmWMGtyD1vvBUYP6RsjUBJgDT0nAPp9jzUWmrxDDwBa
         thAoWiKeyo1eRM6AQhxSxwg5MFlJ97qeSxxNC8m/QFxQoP0JImaiYfTvq+pMIIw0JEWB
         1Q4kBF5s2OzGG2Tjv8+iIvPGg3R6XGzQ0arnnFo1va2e1YaSaLu4CGuzRxwxxN/QG7ia
         CzEIOAifq10aO4CzNkshRZH3mwjMOhCpJP+pLltVFa0CPox03F1pS/DTNIbUT3BEdyo7
         41kbRNvTJMqYlRzOpTDH99RYsRCVID6emgp8rWZxda5u1w1joWhtFP6A5Edb58f/610k
         RrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7lil/dkQO5cgpYUggDCk++wNipbuXpnFGUHcU4Jkojc=;
        b=G86HmCPMggSTSaQRbAwvVRNKKRi2+CWUfcMJN6qBxtnOoeo5S2GhC+fFqQp/pw+UBB
         cNq1OK7hsfUvHy8VBDdv+I+nkLmv2iYaE+zCtnDouTcYwLp/YZKG49T/kcJbIY3cNuWH
         Jx6/K2XN6roxYf+0L9D548uHySvWjx29imjIDlqAMD8wqfg8T5lGC08Yzhw+YzjIBqOs
         4FSOSkIAF0h/PdFuY8Q7pefB5JRNchgy6nSp6g+rVfK0nnMsonSsG/kRvxc4X1ezk9uz
         CYd9f65HrK4woEqij8jdOg6TY+XQd0wCANet44yIC1ZyD0vrWonIn/cfbAnwhrxb7y0s
         JbCw==
X-Gm-Message-State: APjAAAU1GyjhAgdQeX8V5U/gpDAix+XGvgYqtMa+1vQH0DWhhQZOU/4r
        lQwpu2M4qUFhAE0D5wCLW5+A1NHOqbCunUJNfI0f0JFC
X-Google-Smtp-Source: APXvYqylh9ef37HH9GGWhsUlbv8SjnLXwoELPq5Ng6240eULw7Ycfw7LhB6XEmQIKCIE/DLaUbv+txmGRxSa07Ly/98=
X-Received: by 2002:a67:7087:: with SMTP id l129mr46765825vsc.206.1563880899857;
 Tue, 23 Jul 2019 04:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563822638.git.osandov@fb.com> <45fa864ecb8805596dd7a1052f9e68509e79447b.1563822638.git.osandov@fb.com>
In-Reply-To: <45fa864ecb8805596dd7a1052f9e68509e79447b.1563822638.git.osandov@fb.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 23 Jul 2019 12:21:29 +0100
Message-ID: <CAL3q7H4MRkUfZaaCg1hOnGsPyCdD18ndg0knqG=oaUeGVTEpug@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] btrfs-progs: tests: add test for receiving clone
 from duplicate subvolume
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 23, 2019 at 3:25 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> This test case is the reproducer for the previous fix.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks!

> ---
>  .../test.sh                                   | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100755 tests/misc-tests/038-receive-clone-from-current-subvo=
lume/test.sh
>
> diff --git a/tests/misc-tests/038-receive-clone-from-current-subvolume/te=
st.sh b/tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh
> new file mode 100755
> index 00000000..be648605
> --- /dev/null
> +++ b/tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh
> @@ -0,0 +1,34 @@
> +#!/bin/bash
> +# Test that when receiving a subvolume whose received UUID already exist=
s in
> +# the filesystem, we clone from the correct source (the subvolume that w=
e are
> +# receiving, not the existing subvolume). This is a regression test for
> +# "btrfs-progs: receive: don't lookup clone root for received subvolume"=
.
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq btrfs
> +check_prereq mkfs.btrfs
> +
> +setup_root_helper
> +
> +rm -f disk
> +run_check truncate -s 1G disk
> +chmod a+w disk
> +run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f disk
> +run_check $SUDO_HELPER mount -o loop disk "$TEST_MNT"
> +
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subvol"
> +run_check $SUDO_HELPER dd if=3D/dev/urandom of=3D"$TEST_MNT/subvol/foo" =
\
> +       bs=3D1M count=3D1 status=3Dnone
> +run_check $SUDO_HELPER cp --reflink "$TEST_MNT/subvol/foo" "$TEST_MNT/su=
bvol/bar"
> +run_check $SUDO_HELPER mkdir "$TEST_MNT/subvol/dir"
> +run_check $SUDO_HELPER mv "$TEST_MNT/subvol/foo" "$TEST_MNT/subvol/dir"
> +run_check $SUDO_HELPER "$TOP/btrfs" property set "$TEST_MNT/subvol" ro t=
rue
> +run_check $SUDO_HELPER "$TOP/btrfs" send -f send.data "$TEST_MNT/subvol"
> +
> +run_check $SUDO_HELPER mkdir "$TEST_MNT/first" "$TEST_MNT/second"
> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "$TEST_MNT/firs=
t"
> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "$TEST_MNT/seco=
nd"
> +
> +run_check $SUDO_HELPER umount "$TEST_MNT"
> +rm -f disk send.data
> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
