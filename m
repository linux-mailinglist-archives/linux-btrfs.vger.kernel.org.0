Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6525AE7A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 17:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgIBPLn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 11:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgIBPLc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 11:11:32 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857AC061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 08:11:31 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so5294672iln.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VuIYzkSfka9z/yZ3wqALdRD6qNLVNtO+LM0N8MUBDjU=;
        b=F20nqvnLysmlZwwAco3NIIq+GbtI98FHMtKZOPQsigIRLqehrO3TbFRezQhU/C7I9Y
         sJCUpTGgMoAiOL3vout7/fJ93PTRhGNfbcqwNRUYsi8vX3TjK92m+ERD/AFVCNu7y/Zr
         MHdLNFZ8cgrcNM+LH8oMZe65qyotVyr5vKDsq+RMGAwmfaYbSqvktvbQvk/gnFOkaYQC
         mLWK1y47RAEU3OU80cr6mhcgTne4zyfPrjIWr1IwlMvLggJXhJNs8a3UPn7bRUD5UwlC
         YvpLnNeZy3kLn9vW/QoSaZTlXfeBbGP64LJO9B8QpebNYmK17lpXQ/m95Sm4xYxaX7h8
         rw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VuIYzkSfka9z/yZ3wqALdRD6qNLVNtO+LM0N8MUBDjU=;
        b=K8e/W/7lowLibrkNo80jSdfN26WAtXIAvKYUMFkkDaGkB3mFAuevGdNRInFnC+TyLQ
         GCssdlpUvMlMX+nN40hOj74smhawm42hBHHQ2RypUtZPxR38z7Dol94bVEMZvmY2NxEy
         DB1miiXAyccj1lLO0Yxs9Uipye+bbJqa5DFD51m7sFhfWq3pAYzq8zADkLYKYpx5P0xv
         ltsagfHRB4ho7JWj/gB9JV1+CttJe9+UHtaf6rpw4cOQiZ7F7IAGnpDBjAuCYblGCazI
         vrRwoM/GrRX2s3zEWuftFvwus5rr85dnaBR4tv/52UbZ/OkQfWEErj4wz0H8OvSDxvt+
         0hQw==
X-Gm-Message-State: AOAM533u+5xHDxaw6vapfxmPIdDAH3pwJM3kYnOMtgNsQ3ZGH6zmUTzW
        MgUd5AXkPCyxOGJDEDFTBScyQv0oylNtJnGsPvTFOJJTUYM1Hx/b
X-Google-Smtp-Source: ABdhPJxyevLf3SMS6hg9JXlmEB4Ap1qIyGWRzCbiL0SBl1GYS1Y3/XgEln4gYpJvhHWHji392UME3kTFd10P7ZljL3g=
X-Received: by 2002:a05:6e02:dc5:: with SMTP id l5mr4262001ilj.112.1599059490035;
 Wed, 02 Sep 2020 08:11:30 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 2 Sep 2020 11:10:54 -0400
Message-ID: <CAEg-Je8OsZjWU_ZyLJHrbOJb=_C56MOmJ5w8UUbzz3JNuAi5Ow@mail.gmail.com>
Subject: About the state of Btrfs RAID 5/6
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Robbie Ko <robbieko@synology.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey all,

It keeps coming up over and over: "Btrfs RAID 5/6 is bad, therefore
Btrfs is bad". I know in practice that most people don't use the
raid56 modes for various reasons that are unrelated to this, but it's
frustrating and annoying that it keeps coming up.

I know that Zygo recently posted about how to use RAID 5/6
successfully(-ish)[1], and previously David Sterba tried to work on
this[2]. The result of that was the new raid1cX modes, but we still
have the raid56 modes.

What's holding back Btrfs raid56 from having its status[3] updated
from "Unstable" to "mostly OK" or even "OK"? I know that Synology NAS
devices use Btrfs and support raid56 using mdraid, why not fix the
native RAID features so that layer can be dropped?

[1]: https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.=
org/
[2]: https://hackweek.suse.com/17/projects/do-something-about-btrfs-and-rai=
d56
[3]: https://btrfs.wiki.kernel.org/index.php/Status

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
