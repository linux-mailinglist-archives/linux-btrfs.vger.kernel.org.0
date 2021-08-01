Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B208E3DCA85
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Aug 2021 09:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhHAHTc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Aug 2021 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhHAHTb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Aug 2021 03:19:31 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734A6C06175F
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Aug 2021 00:19:23 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z26so20191774oih.10
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Aug 2021 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HmKChxBb1hfep+WVOj6pKXX6oTdnXlM14H8hbcsxkeE=;
        b=j9LlQeaev9fgViRIZ02vGuhYIhT8tuc4w3ILqF5PTH8O3fpQPBPC3gQDSp9z9GEsF1
         o29aS+Wt0tPsMQAJluFjVedu73FOqjoTjj9j3iLSPYmNMmyw2jrYkvQ6J3eYLRMr4s5Q
         eO+rU7R4ibulnGarEhzoPzHAwP7yPyFDnNA+Y+JHkK7cpAIVyAW38TAhBcdR6gkAVC+z
         HKtmaByHznrBqmyK3FXS/dM3/gVcUeLZXqgXqqSI3trZ0Lk3yh3T5+3l7SGQkcKCEDCr
         Axg2xMl2Ibvm/S2TILtSNx3zB2nAIGsGRW1ujDenkoaSxEqnSBU66zyEkKA9MMRqifuz
         eaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HmKChxBb1hfep+WVOj6pKXX6oTdnXlM14H8hbcsxkeE=;
        b=Zrw97QGMppneBWWed74iskbZjOSUMNOmPMibOeIW06x9HpETyDeJkC8FJFFvi6y7Qd
         /YwlOAHbEkQJOZBXKH3HyC3Zvl63O3Ik+euvkhzbooi56Z1W0BDQV06vDgXfdrJfRKp/
         cUR1q8QocEoEXttZmhy6GFGm2WetSMDg0yoMNhWmNMDol7xMcXE3bian2T+PZPwM02VW
         B3C8pW80BEhr+AWZ7gaDu8PGbgZ2m7OjUTulMteLVzlBysm4LSAiwoWOAsc9GBkmT2DB
         Sx25k//z98B8KENNC3M2hX0C8tM7xOrMRyE7T04e0xk0UQy3FUdbadzE65ShOI8syLUv
         jm8w==
X-Gm-Message-State: AOAM533LwHVlI818Fh/rGGKm52kZtUW93fBCeNFjoFqKRZzcXms3YCDF
        /S6D0KaHlVltDXj8oOCA3xh7EMZnBn00h0UaMsOsyZTB0S/uzg==
X-Google-Smtp-Source: ABdhPJzbVEOEmQxVJYcjd5SyWGGJj92R8G5mrlLs6Rw/HxAWv31aoxCTljsOoiU5G5kun1kru8JGG5H3nFt7AkpakdA=
X-Received: by 2002:aca:5b83:: with SMTP id p125mr7017370oib.87.1627802362845;
 Sun, 01 Aug 2021 00:19:22 -0700 (PDT)
MIME-Version: 1.0
From:   john terragon <jterragon@gmail.com>
Date:   Sun, 1 Aug 2021 09:19:12 +0200
Message-ID: <CANg_oxz7cDq4J4EPWb58A9Kz_Rb9W279pRW=j3OTRvps-aLvzw@mail.gmail.com>
Subject: inconsistent send/receive behavior
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.
Let's consider the following send/receive example

-two btrfs FS /btrfsA /btrfsB
-one subvol vol in /btrfsA
-btrfs sub snap -r vol vol1_RO
-btrfs send /btrfsA/vol1_RO | btrfs receive /btrfsB
-then, in /btrfsB:
      btrfs sub snap vol1_RO vol
-do some work on /btrfsB/vol
-then in /btrfsB:
      btrfs sub snap -r vol vol2_RO
-then from /btrfsB:
-btrfs send -p vol1_RO vol2_RO | btrfs receive /btrfsA

So, the initial seeding is from btrfsA to btrfsB and then there is an
incremental send "in reverse" from btrfsB ro btrfsA.

Is something like this supposed to work?

Because I've got cases in which it seems to work (no error or data
loss that I can see) and cases in which the "reverse incremental send"
does send stuff back for a while and it creates the vol2_RO subvolume
but then it ends up throwing an

ERROR: clone: did not find source subvol

So, it does not say that immediately at the start. It seemingly does
all the work before complaining.
And the resulting vol2_RO in btrfsA seems to be OK.
du /brtfsA/vol2_RO reports a size that's close to the one of /brtfsB/vol2_RO.
And df reports that /brtfsA/vol2_RO seems to be using a fraction of
its reported size by du.

So, at the very least, even if this "reverse incremental send" is not
supposed to work in btrfs, there is inconsistent behavior of the FS
and/or the btrfs tool.

Thanks
John
