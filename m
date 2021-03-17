Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7191333EECD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 11:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhCQKu5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 06:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhCQKux (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 06:50:53 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C0AC06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 03:50:53 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id w11so14657164iol.13
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 03:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CO/EsLsvgz6zoLwpN/vw9pmFPul1Qh/sx2jjHmanXEk=;
        b=dNHcc1F4V3xfO6QgzxZIUtUwi79jp7RypaJqO3ZVl0V+WaHDnnI8HhcXFVzhR7A3l8
         TrpyCMh8/nZzrS+ROmn57kj15Dbj5wIWbjQghp4e7HsqMFzASH4iA/xZUZEAttDW9IK+
         6oOKuZsR61wQsLj1zs6YtCBiDbf9OWdUnW37XoF2P0uh0nL5NsHjCFBlkS+th3T3OC4e
         M94CGKzMEdMNYJBiZRebGwggZzEWf3qCA9HtzsVh1eof4mBY195OA7jkNQ+EOLbSNxqG
         qk/7+k3IxKq0CgwH3zcTlASB5EI7DKejw+CUxgeK87rcGP8IpOm7fJa8zznBihmh7qhC
         nFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CO/EsLsvgz6zoLwpN/vw9pmFPul1Qh/sx2jjHmanXEk=;
        b=Q653dpSu2Ava/foK1bHoVoDVIKbte9B1zQxjpHgcLVPzyYLLVZvhWzWHjQlhIO69jH
         WUE4fjd582n9dyEGzulH2IsUgMFm9XbCUZgvDNF6nfSq151FAn+F704+uSoci9aGdD0A
         5zB91glYtBkG/Yf0M/OFOQ0H96aIYGP2lNoi0iebSBqXlRwdUBQj9p3afw/SsZ1NHE/Z
         S4E175+EycV4La3XSycrGossOrJPlFo9QWjTDeUJMOKZlxXKXndv8Our7BMA/EJYPV3y
         RlXRY2GNFyOLnNpKqBgnerlHM/UJXxdPbegCA1In4ZyUfaXyCgnaISutY5WbdWBL5naA
         PuVw==
X-Gm-Message-State: AOAM533DYZJZXqgABWNXdbpTrTt6dl7CNpi8nf4Ze1fyIENy7K6U8t0l
        Q0eQVvAPNAU1vKIzX0pdKdPw1G7ciylR2Vv7Qcg=
X-Google-Smtp-Source: ABdhPJwih9jfcMzgGrtpBNsLa4LzPOSVrHnM/NR8Sbi2+h96LP/qzT1W6PecaBmkR17OAlZrtvBIyL1noqGNzA118II=
X-Received: by 2002:a05:6602:2432:: with SMTP id g18mr6547372iob.86.1615978252925;
 Wed, 17 Mar 2021 03:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAOE4rSxJdEB+==k3RpOPScrh8RXQ-+Q0cpR8AKSbv3DV8L=FTw@mail.gmail.com>
In-Reply-To: <CAOE4rSxJdEB+==k3RpOPScrh8RXQ-+Q0cpR8AKSbv3DV8L=FTw@mail.gmail.com>
From:   Sebastian Roller <sebastian.roller@gmail.com>
Date:   Wed, 17 Mar 2021 11:50:16 +0100
Message-ID: <CALS+qHM0Zvcu60dbAwO1GtrsFyHMfhpRM-FmFeu6+aeo9X4wEA@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        quwenruo.btrfs@gmx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Mi., 17. M=C3=A4rz 2021 um 02:54 Uhr schrieb D=C4=81vis Mos=C4=81ns <dav=
ispuh@gmail.com>:

> > root@hikitty:~$ install/btrfs-progs-5.9/btrfs check --readonly /dev/sdi=
1
> > Opening filesystem to check...
> > checksum verify failed on 99593231630336 found 000000B6 wanted 00000000
> > checksum verify failed on 124762809384960 found 000000B6 wanted 0000000=
0
> > checksum verify failed on 124762809384960 found 000000B6 wanted 0000000=
0
> > checksum verify failed on 124762809384960 found 000000B6 wanted 0000000=
0
> > bad tree block 124762809384960, bytenr mismatch, want=3D124762809384960=
, have=3D0
> > ERROR: failed to read block groups: Input/output error
> > ERROR: cannot open file system
>
> One possible reason could be that extent tree is corrupted. Right now
> I'm dealing with such filesystem.
> I wrote a patch that allows to read-only mount such filesystem
> (assuming there's no other problems).
>
> Currently none of btrfs tools work when extent tree is corrupted, but
> for `btrfs check` this patch would allow it to go further. Only for
> data recovery this isn't really that useful.
>
> --- a/check/main.c
> +++ b/check/main.c
> @@ -10197,7 +10197,7 @@ static int cmd_check(const struct cmd_struct
> *cmd, int argc, char **argv)
> int qgroup_report =3D 0;
> int qgroups_repaired =3D 0;
> int qgroup_verify_ret;
> -       unsigned ctree_flags =3D OPEN_CTREE_EXCLUSIVE;
> +       unsigned ctree_flags =3D OPEN_CTREE_EXCLUSIVE |
> OPEN_CTREE_NO_BLOCK_GROUPS;
> int force =3D 0;
>
> while(1) {

The patch works fine. Btrfs check is now running and I'm getting "bad
tree block  =E2=80=A6 have=3D0" for a lot of blocks. It supports the point =
of
Chris and Qu that some parts of the filesystem are missing completely.
I will have to look again into the hardware.
Thank you.

root@hikitty:~/install/btrfs-progs-5.11-patch$ ./btrfs check
--readonly /dev/sdi1
Opening filesystem to check...
Checking filesystem on /dev/sdi1
UUID: 56051c5f-fca6-4d54-a04e-1c1d8129fe56
[1/7] checking root items
checksum verify failed on 99593231630336 found 000000B6 wanted 00000000
checksum verify failed on 93744341237760 found 000000B6 wanted 00000000
checksum verify failed on 134571939774464 found 000000B6 wanted 00000000
checksum verify failed on 134571939774464 found 000000B6 wanted 00000000
checksum verify failed on 134571939774464 found 000000B6 wanted 00000000
bad tree block 134571939774464, bytenr mismatch, want=3D134571939774464, ha=
ve=3D0
ERROR: failed to repair root items: Input/output error
[2/7] checking extents
checksum verify failed on 114674562678784 found 000000B6 wanted 00000000
checksum verify failed on 57137668423680 found 000000B6 wanted 00000000
checksum verify failed on 113640702476288 found 000000B6 wanted 00000000
checksum verify failed on 113640702476288 found 000000B6 wanted 00000000
checksum verify failed on 113640702476288 found 000000B6 wanted 00000000
bad tree block 113640702476288, bytenr mismatch, want=3D113640702476288, ha=
ve=3D0
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
checksum verify failed on 121433146130432 found 000000B6 wanted 00000000
checksum verify failed on 122593932312576 found 000000B6 wanted 00000000
checksum verify failed on 136599398825984 found 000000B6 wanted 00000000
checksum verify failed on 101807915597824 found 000000B6 wanted 00000000
checksum verify failed on 57164715065344 found 000000B6 wanted 00000000
checksum verify failed on 96553819602944 found 000000B6 wanted 00000000
checksum verify failed on 117685684518912 found 000000B6 wanted 00000000
checksum verify failed on 94429572694016 found 000000B6 wanted 00000000
checksum verify failed on 103132624437248 found 000000B6 wanted 00000000
checksum verify failed on 136601755516928 found 000000B6 wanted 00000000
checksum verify failed on 57973615050752 found 000000B6 wanted 00000000
checksum verify failed on 121433143312384 found 000000B6 wanted 00000000
checksum verify failed on 136602075971584 found 000000B6 wanted 00000000
checksum verify failed on 57973809496064 found 000000B6 wanted 00000000
checksum verify failed on 110464911507456 found 000000B6 wanted 00000000
checksum verify failed on 57602967863296 found 000000B6 wanted 00000000
checksum verify failed on 121020084862976 found 000000B6 wanted 00000000
checksum verify failed on 122343797145600 found 000000B6 wanted 00000000
checksum verify failed on 136601758367744 found 000000B6 wanted 00000000
checksum verify failed on 58255412936704 found 000000B6 wanted 00000000
checksum verify failed on 98233031737344 found 000000B6 wanted 00000000
checksum verify failed on 112202434707456 found 000000B6 wanted 00000000
checksum verify failed on 112202434707456 found 000000B6 wanted 00000000
checksum verify failed on 112202434707456 found 000000B6 wanted 00000000
bad tree block 112202434707456, bytenr mismatch, want=3D112202434707456, ha=
ve=3D0
checksum verify failed on 112202478764032 found 000000B6 wanted 00000000
checksum verify failed on 112202504568832 found 000000B6 wanted 00000000
checksum verify failed on 99302161956864 found 000000B6 wanted 00000000
checksum verify failed on 57229417267200 found 000000B6 wanted 00000000
checksum verify failed on 123018565664768 found 000000B6 wanted 00000000
checksum verify failed on 123018565664768 found 000000B6 wanted 00000000
checksum verify failed on 123018565664768 found 000000B6 wanted 00000000
bad tree block 123018565664768, bytenr mismatch, want=3D123018565664768, ha=
ve=3D0
(=E2=80=A6)
(killed the run after some minutes and a lot more of these errors)

--
Sebastian
