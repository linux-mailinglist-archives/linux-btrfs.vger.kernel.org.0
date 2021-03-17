Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5233E678
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 02:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhCQBzI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 21:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhCQByx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 21:54:53 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F5EC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 18:54:53 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id q9so690002qvm.6
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 18:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aMhWPHCP/aOiTDf6oleEXvjDAuWzeq8ObiEXXcY91vo=;
        b=RBJsJQDPeOkOTl6k3SLZ3L8SWT0ZWeVthlmYitRv6iCFdFKSfwhh9fFsjvq0e6O0gM
         nkVGVx0pGKP/zRo2YwU/qzj4pJgHUCOwrRcu1OMFbsqRgjLX+R0tXMRyAre3lcf0DTTx
         b6Yv3V0iwawmE0r6ygI5LJESEBLE3ba5C3X3oBs5VCd7V+WcF4BVwY1U3RdKXu87Nbp1
         qxzvEPEagIpjETL/9prpSvSYTMpUm7qzp6vjdzRHuFiug4gDHX7qr9KlptUWJoYpH3QH
         daLhJ8lGI1pnB9ql/yYsgZMMeq6R+NjUjL/0Wljb59u3YbxTrZUE017OcZrG4kHemjFM
         ip7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aMhWPHCP/aOiTDf6oleEXvjDAuWzeq8ObiEXXcY91vo=;
        b=HJViFiwAo3R3YQpsAUpWaxSXd/hzHPnZy+uQIRlnKb/8pPxa+gyL1gYUPpatcuLCf7
         LPBvX2fAx2ASZ5/5C0DoqgMxR+wBScNqzsYgiEnBM05WYjdmRRHp21OgbAUkEN+dvNDr
         GwNgN7CI6p4xh/T4LtL3GgfZtOsZTVwhheuU0+TnzLFAPorZeI72WVuFbHbX/zfR7MDS
         Vp+QRxIKKMmsD0KvHhvdQsE/0W2NbWNrBm5zhALgFWNNHDhkBC3fca4E453OAWmv6m7P
         qXwm9LfLgmJrc/BlVCpbfW39uD5xImawgWboLCvHY6hMdl4k7qex399oE2qJirzrrydV
         sUSA==
X-Gm-Message-State: AOAM531guqWfXm3OhNH7RBCCORklXn8MGVexvkemlAg+4tKBgkkGZtM+
        ZaD/6U9g70m1dgTpeM6TeEgh5UNGaMuI3m8bni+StTTD3BjDuu+f
X-Google-Smtp-Source: ABdhPJweCKAPsrIKc458aofbBwafDAxfBXgned+78NHXcHlcrmD+J+ivBQH0eeTuaH4za4usF+cPR8UZbujXgUPfFGo=
X-Received: by 2002:ad4:45e4:: with SMTP id q4mr3023169qvu.11.1615946091156;
 Tue, 16 Mar 2021 18:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
In-Reply-To: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Wed, 17 Mar 2021 03:54:39 +0200
Message-ID: <CAOE4rSxJdEB+==k3RpOPScrh8RXQ-+Q0cpR8AKSbv3DV8L=FTw@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Sebastian Roller <sebastian.roller@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

otrd., 2021. g. 23. febr., plkst. 17:51 =E2=80=94 lietot=C4=81js Sebastian =
Roller
(<sebastian.roller@gmail.com>) rakst=C4=ABja:
>
[...]
>
> root@hikitty:~$ install/btrfs-progs-5.9/btrfs check --readonly /dev/sdi1
> Opening filesystem to check...
> checksum verify failed on 99593231630336 found 000000B6 wanted 00000000
> checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
> checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
> checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
> bad tree block 124762809384960, bytenr mismatch, want=3D124762809384960, =
have=3D0
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system

One possible reason could be that extent tree is corrupted. Right now
I'm dealing with such filesystem.
I wrote a patch that allows to read-only mount such filesystem
(assuming there's no other problems).

Currently none of btrfs tools work when extent tree is corrupted, but
for `btrfs check` this patch would allow it to go further. Only for
data recovery this isn't really that useful.

--- a/check/main.c
+++ b/check/main.c
@@ -10197,7 +10197,7 @@ static int cmd_check(const struct cmd_struct
*cmd, int argc, char **argv)
int qgroup_report =3D 0;
int qgroups_repaired =3D 0;
int qgroup_verify_ret;
-       unsigned ctree_flags =3D OPEN_CTREE_EXCLUSIVE;
+       unsigned ctree_flags =3D OPEN_CTREE_EXCLUSIVE |
OPEN_CTREE_NO_BLOCK_GROUPS;
int force =3D 0;

while(1) {
