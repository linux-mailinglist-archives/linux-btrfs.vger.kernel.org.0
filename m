Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE43D589
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 20:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfFKSb7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 14:31:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34345 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfFKSb7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 14:31:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so15772335qtu.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2019 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=kn96utnwQnGrG20QEbX7h5+uROjopklg7CkSOIfbcko=;
        b=PYo8BazIWQIW2gOTcEUi2Jtn/++CXk1KttthwgfpdzkkJNI850HD6QPLUs/aF2li8P
         od8MCWtXybiYoPms4EP2PbkyuMLVyyepQSrAchxCsIMRh9h9aC17KspDM8N28tbHDrJg
         BvjA7zdeWEdzQskpi+7E/C+MqxyNNsQzgYPPwcCH6w6WyRJjz3bKaWZ14ZpMOBqvfsXM
         7wkuyegwRBxJf+uLg6LdBTW5UNv28MkEFxb2i+jAMz48VKo2pQvaSNVBCE0FgW/96Pp/
         MptT4/fDSAaMCDHyJ42fZkWZOTrHxPMixvVHOklXslZkHPbvNtXaTR3fNA1cgtHZjVdR
         MjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=kn96utnwQnGrG20QEbX7h5+uROjopklg7CkSOIfbcko=;
        b=uCB18ZNpKExU7TcNc5P+Fsrm6DvC1B2TgQh+NYnvykSUfxk0S4OEec+4kKqXP/nILY
         3gVmAbJb4pUJZb3RwKwu17TJLK2y6eAFb9qIMiGuGeGo0g018uimRA9iA02N44utotZA
         N4lrgDneRPxr99PIbmy7Wh3kCYy3XlZx64FTLUaFyUM6dFVUguK4Kco8Cujg7t4huCvS
         IEdagyYrjpoATVVKQXNGNrzn2zpPgk7+j5Tk4NOqoaBCp1Yi2Vsbx9BuzMjSYcnGiIlI
         NlCyGv7NYvXVFoG3HZrz49Lir3idZgFGwn0reUsT3/1agXWsAZVM2CyBxuoSZnwisQQ6
         JVkA==
X-Gm-Message-State: APjAAAXwzi0775x7S4Vc8pKz6H2EpLhbRMbKEDGdeteObDO/QEum1nYI
        H5/dxsmJCVRG3so/Up8b54sDO2PfpG5Q5ArHlBDJnSuW
X-Google-Smtp-Source: APXvYqzFf3HpPw+KU5cigeys80UH2cevxxH2158MLIftLk8by3rExpKvMrdkfvXBG9jQFMl8myyo0cSpTsiGVwMdhJc=
X-Received: by 2002:ac8:183:: with SMTP id x3mr63683838qtf.104.1560277917635;
 Tue, 11 Jun 2019 11:31:57 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 11 Jun 2019 14:31:21 -0400
Message-ID: <CAEg-Je9XTvEtg=Mpb1xKkO6Lzd3-yzSK7GcfbKH13uuf-u-wTA@mail.gmail.com>
Subject: APFS improvements (e.g. firm links, volume w/ subvols replication) as
 ideas for Btrfs?
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Murphy <lists@colorremedies.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey,

So Apple held its WWDC event last week, and among other things, they
talked about improvements they've made to filesystems in macOS[1].

Among other things, one of the things introduced was a concept of
"firm links", which is something like NTFS' directory junctions,
except they can cross (sub)volumes. This concept makes it easier to
handle uglier layouts. While bind mounts work kind of okay for this
with simpler configurations, it requires operating system awareness,
rather than being setup automatically as the volume is mounted. This
is less brittle and works better for recovery environments, and help
make easier to do read-only system volumes while supported read-write
sections in a more flexible way.

For example, this would be useful if a volume has two subvolumes: OS
and data. OS would have /usr and data would have /var and /home. But,
importantly, a couple of system data things need to be part of the OS
that are on /var: /var/lib/rpm and /var/lib/alternatives. These two
belong with the OS, and it's incredibly difficult to move it around
due to all kinds of ecosystem knock-on effects. (If you want to know
more about that, just ask the SUSE kiwi team... it's the gift that
keeps on giving...). Both /var/lib/rpm and /var/lib/alternatives are
part of the OS, but they're in /var. It'd be great to stitch that in
from the read-only OS volume into the /var subvolume so that it's
actually part of the OS volume even though it looks like it's in the
data one. It's completely transparent to everything. Supporting atomic
updates (with something like a dnf plugin) becomes much easier because
we can trigger snapshot and subvolume mounts with preserving enough
structure to make things work. In this circumstance, we can flip the
properties so that the new location has a rw OS and ro data volume
mount for doing only software updates (or leave data volume rw during
this transaction and merge the changes back into the OS). We could
also do creative things with /etc if we so wish...

Another thing that APFS seems to support now is creating linked
snapshots (snapshots of multiple subvolumes that are paired together
as single snapshot) for full system replication. Obviously, with firm
links, it makes sense to be able to do such a thing so that full
system replication works properly. As far as I know, it shouldn't be a
difficult concept to implement in Btrfs, but I guess it wouldn't be
really necessary if we don't have firm links...

What do you guys think?

[1]: https://developer.apple.com/videos/play/wwdc2019/710/

--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
