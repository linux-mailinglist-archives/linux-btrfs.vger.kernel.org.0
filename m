Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF718BABD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgCSPOV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:14:21 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:44274 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgCSPOV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:14:21 -0400
Received: by mail-lf1-f45.google.com with SMTP id y2so1915489lfe.11
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oR4lumHf3DWZTy7FPnCop9jzCcqACSNhB918dyl8gFg=;
        b=lN0UqgQFu50v3PD0JQ/NF6oYS/lfSNi1zTdZv+xgq7ecRM20AjNozzyRxnKzqTsDTg
         W0A9FhD6swBRbynCUOuT/FsVScEr3FQcJowQrAml5bxqz/DsoYbhlU7B7fFZhiTifyCo
         1mjtLEiVcCAecLogGy+hjvrOS/7bEu4+rcKmad9yZeNdPgDU64disxoLXy35oLbkqVNC
         /L1yjGUwqMp8RDUk3RBPbeCj3If0l2bM2LtADaNaaE67YbgveXuy3vaCuc5XHFsZgCAA
         h663/mQvT6A8yhHmgysg1RQ9Q1yU+xZ1IssBoAGk2lo14RZyzHdfUZLjbhcbLaFY+7k1
         ycWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oR4lumHf3DWZTy7FPnCop9jzCcqACSNhB918dyl8gFg=;
        b=pCUBq2yzY3h19rQe4gSul2Md2JHFjWVJxixSxRo+5D2qcjfh4WUvLdUjcIvrpZgGGZ
         fOjFngKt8dHOa1hpS8897i+kI/QYYSAhf8rS0HH4TL4PGD6abHj9k5w2O7Av4tQrIJc5
         ohsfJfn3b2unX0UQVGjfaldkcE8Aq6O9ZzvnskRJak6zc6OcvRvFaWlVRTw7YyJKnoSO
         kTDoDJq/InlS1msJ8GxJIbwSOantXIxfXiE+GdN/DS3vUn2e8NIUHNDsDBHVId4xdEM0
         zY/rEHsDnKv2SfVNLf2buJWr5iAXAi5toJb08iTzFackSbta3ofrSNhjx1T74TSwL9zB
         EU3Q==
X-Gm-Message-State: ANhLgQ0UFDEY1xwlIpQw753lUgWNMZ8SbCn7gjqmBznlT4ZlLtAeN+Cl
        C0b7lCYEMh45MgGochvvrZdebwpLjgpe029pGbduWPPS
X-Google-Smtp-Source: ADFU+vuu6NpcRTLtQCATQHaHxkK9Xt4deAgR0I9diYq/mk67+WEkHA/EuQGwL/BznprA0XQoufRPF+Cjy/KYKgzUKrc=
X-Received: by 2002:ac2:54a4:: with SMTP id w4mr2445570lfk.48.1584630858141;
 Thu, 19 Mar 2020 08:14:18 -0700 (PDT)
MIME-Version: 1.0
From:   Carsten Behling <carsten.behling@googlemail.com>
Date:   Thu, 19 Mar 2020 16:14:07 +0100
Message-ID: <CAPuGWB8Aqvr6po0-nJskh_5W3rUv1+y2P2U-pYMAJ_wwKnLjkA@mail.gmail.com>
Subject: How do damaged root trees happen and how to protect against power cut?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

the investigation of damaged root trees are already discussed in the
thread starting with

https://www.spinics.net/lists/linux-btrfs/msg74019.html

However, one point wasn't discussed at the end:

> I thought so too. Is there a reason why they ended up being colocated?
> I'm surprised with all the redundancies btrfs is capable of, this can
> happen. Was it because the volume was starting to become full? (This
> whole exercise of turning on mirroring was because we're migrating to
> bigger disks)

Because I have the same issue on an embedded system, after a power
cut, where none of the root tree copies are usable anymore, I'd also
like to know :

- How can we end up in that recoverable state?
- Why can't we protect the fs against the unrecoverable state?
- Why is that error is so hard to recover?

Furthermore, I'd like to know what would be the best solution for an
embedded system where power cuts are unavoidable (because of a missing
circuit). I'm thinking of using a read-only rootfs with a separate
data partition to ensure at least a booting system. But anyway, the
data partition could end up in the same state.

I'm not sure if it would be also a good option working with snapshots.
My space on the embedded device is limited to 8GB. The OS already
takes about 4GB.

Best regards
Carsten
