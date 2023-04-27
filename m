Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7896F013F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 09:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbjD0HJA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242693AbjD0HJA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 03:09:00 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C95269F
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 00:08:58 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5529f3b8623so63331877b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682579337; x=1685171337;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9opU1mvnlL/NR/NXJozJSeWMxVHk7n5WKB/zx1llwOk=;
        b=p0avlsvlq3kOXhcWSKUTAprnkveyujW/Puyd5jGOeCswyZ2PhmNybfMgc7UW5/fMQt
         CvJVTnI8Exes1xWAijEJybw7fNoKTPyZRAhBkSou/OZyhAggPC5aUDb0+to1MEd1Wq7J
         ggqzm/ysbLrofF4lw1oOCAVkLpVetYw+DZ1qzllu/5dwiqLWs5UE2GBvin4EY2ZM1jWo
         Tt3AzPS7G82Tqlkr58xuxSPfnciIbXfbM3IoooaWslLTxBIzkX4drzjmwtpazTtmdBfd
         AyRqfUXPCH/DJLSSA26u3HDizdpGpqLdpYSkoSaj9RLy47o+bJ0aM3v6vpQGyANl/VE7
         RrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682579337; x=1685171337;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9opU1mvnlL/NR/NXJozJSeWMxVHk7n5WKB/zx1llwOk=;
        b=Scas7TTWy9023BhQrR5x5e/Eh1ihAdidHRCWMhQnWlMwSiTS/Ugx8Nd5vvT0vn06BZ
         n3Wwbr+LCk3/fHqYvbSVxt6wHMYl/wTvyGh+Fb6Z0hbYFAqgcQ59G8ryKUO5g6ZK7BoI
         bYordkhKPdvfK6fGyny+ALGMbMvujWeyUpjcp0UT9FwbLluevg/St4mfUzH88p5WXoZf
         dyq60W/p8PVHOnWu/HBnJjKNkEZHJuZtGhnH577OgHsh0weuwX5VqnPdszxjZXox+3eK
         oxjv5H4j7MLNsNna61Ng2sV0znI8mZlXxpVIPB/9f0SHVbOt/53SLt9wPSsb8KYTs1xS
         Vwqg==
X-Gm-Message-State: AC+VfDxzTa2ps2FUGIriG1ENor4yjUlyP9T4POpYUkKRxrv03Ym4kjfq
        TSJNHJ0A1H4V3AjD4qreuE+UrrgwYhqU7qBoMnuRaTcqI0I=
X-Google-Smtp-Source: ACHHUZ4FgtMsqbEHwtwe5V2CPeDGIJ7BTp/dN8d4SBXWtC2TKpJJX3sHS9we/b7iBtOONdPmNyHL9hAc+pgNfx1PeZ0=
X-Received: by 2002:a81:5203:0:b0:54f:e0e7:c6fb with SMTP id
 g3-20020a815203000000b0054fe0e7c6fbmr602948ywb.8.1682579337474; Thu, 27 Apr
 2023 00:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2U3KrVYroUyJi-xBTmtEm+bnkz4DjEzdcZqG-=X=333b3HHA@mail.gmail.com>
In-Reply-To: <CAH2U3KrVYroUyJi-xBTmtEm+bnkz4DjEzdcZqG-=X=333b3HHA@mail.gmail.com>
From:   Igor Raits <igor.raits@gmail.com>
Date:   Thu, 27 Apr 2023 09:08:46 +0200
Message-ID: <CAH2U3KoRDTUdsp82Yw27mttmF1qew4h4zDTL9cm=ND=bddP5+g@mail.gmail.com>
Subject: Re: Failed to recover log tree
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 27, 2023 at 9:06=E2=80=AFAM Igor Raits <igor.raits@gmail.com> w=
rote:
>
> Hello,
>
> We are using btrfs on some of our VMs and after some bug somewhere,
> kernel has crashed and the VM had to be rebooted. After that, 1 out of
> 4 drives was not able to mount.
>
> I've tried a few commands but that did not help to recover it (I did
> not run btrfs check --repair yet).
> The kernel is 6.1.18 and btrfs-progs 6.0.2 compiled with the
> experimental flag (as we used that to use block-group-tree).
>
> Could you suggest some steps for recovery other than btrfs check
> --repair to try out? Thanks in advance!

Oh, and I also tried:

# Opening filesystem to check...
Checking filesystem on /dev/vdf
UUID: 261534ef-b111-4056-8124-6dd207030548
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 4346997747712 bytes used, no error found
total csum bytes: 4212554860
total tree bytes: 33341571072
total fs tree bytes: 24185159680
total extent tree bytes: 3411492864
btree space waste bytes: 11646103185
file data blocks allocated: 4313656176640
 referenced 5801072136192
