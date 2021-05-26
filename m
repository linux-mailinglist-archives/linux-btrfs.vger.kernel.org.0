Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F8E391032
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 07:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhEZFyG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 01:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhEZFyG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 01:54:06 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C29C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 22:52:35 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z38so417718ybh.5
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 22:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=bEC9zwHzJteFC8eDzfmC9hcmhdtFkHcYIm2trLF0qCo=;
        b=n8Hwd+DMlTdu3cwxpScOwkbc3iPkyQ16UlzCNhFtXrUkFVIwv9faBFF6GhdTuNTdri
         KWwt+iLqY3z3wV2R3khSG1wPNLqpFum4GNClHw1nE63YnmQ2QnTf1dcdbilVpljhsfsD
         wshaY1Cn7PagmyxgMykfigd9vbSEgQxtbTFTj6oatpyd/mxiLtAo9tXxZ2KFx9HF002e
         p9PzoWj/9pdok9YuQa5kY+RQcYs7eQRbuUQ2deoszF3TFF9QOSdzT6svGMV7OpFG/DNa
         Cn3aulFf0gNglO81jJ8cjRJmSvmXUjBxdpVX/8fvTA3L6X/PY7lVxy61RnSyuZIPNhMG
         rFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=bEC9zwHzJteFC8eDzfmC9hcmhdtFkHcYIm2trLF0qCo=;
        b=Ku0nMJ+58MbYPxeFDNqcmmOKXSp3BYOBg1RfuP4Gri2VuydLmDJyt+0gIts3VYVT8i
         MyNBmZEX5y7gW7CeibOUql2Vxg7EkRQcM51loxHY8J4V/qr4WPgw7FvjdGwCnbZce/N5
         kpNTplUQM9qGdPAeXv56tSm1zCmoTnCEr2/5dyizT1YRrSZf/X9AxQm7i72NzS05+Lzv
         drzSBsAF2CZGGIjwyrx7FaJjNobCPQYxx+N5QbCRCVlUsXuvrizQTqk+cOPKBy5cAmYE
         6HU3/aNACCuL24z0qpXK7mMIieNZHyCFITf/N1TnhTa5rvmMsyhMfO3yBNksvE1m8tsd
         NqoA==
X-Gm-Message-State: AOAM530/np0H9+DBGfGm7h0uLnOxR6I3wzDM2ahZmbvVWiDemPZ/ALMA
        ZEtJ+LkRE8aie7vN1k4kJ0x/+mFtcscUpYdMH+dBOsdyw9j4Xg==
X-Google-Smtp-Source: ABdhPJw0zRoRZ0aYf0YNxK0+cLcdpCjlBepTLRVWFErfBPW8Ud+g/612hx027TeBkYo403/2QgRkTFim5ls+7TBlC9k=
X-Received: by 2002:a05:6902:1148:: with SMTP id p8mr24259825ybu.354.1622008354895;
 Tue, 25 May 2021 22:52:34 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 26 May 2021 01:51:59 -0400
Message-ID: <CAEg-Je-3pS3BCOv4xVoFeTRkH9ovs5RLn4OjqPWMoQnbHGA9RQ@mail.gmail.com>
Subject: BLAKE3 for Btrfs?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Matthew Miller <mattdm@fedoraproject.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey all,

I just read this article on BLAKE3 1.0 coming soon[1], and the
performance of BLAKE3 looks extremely compelling. With the context of
thinking about Btrfs authenticated hashes and fsverity[2], it seems
like it would make sense to see if BLAKE3 can provide us roughly
similar performance to xxhash or crc32. If so, that would make it
highly attractive for a new default hash, too[3].

So, is this actually something that could help for our use-cases?

[1]: https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DBLAKE3-1.0-Com=
ing
[2]: https://kdave.github.io/authenticated-hashes-for-btrfs-part1/
[3]: https://pagure.io/fedora-btrfs/project/issue/40

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
