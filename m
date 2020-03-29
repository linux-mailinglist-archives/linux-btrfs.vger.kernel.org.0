Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF31970C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Mar 2020 00:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgC2Waf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Mar 2020 18:30:35 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:33560 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgC2Waf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 18:30:35 -0400
Received: by mail-vs1-f51.google.com with SMTP id y138so9829153vsy.0
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Mar 2020 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5FX9daSHxdCwJUhwmZJTk7w8vU+fE0VTYrrVq1OIh1U=;
        b=T98wzzwSdtUkNxRRwnGb1h8ZUvncyWL/U0KgaObQQ/r9LfcRih0kajDFbosNcR6TrI
         tqSUzKa2SBT4oPlh5K4o0ZkhB3BoQ7cKSL6Nal/lrwR+iGZKWhMky2RbzHTIE3vB42yn
         6lpWAzSwuCbY5ijdv0gNNnlhLPWoRXiVX8JOd8sRPg/uC+UikjNvpmWqAncGGXFSfZPo
         aponPuPhGp8HLXK4SIfYKD+PrU85M9QmJ9ee8uou8p6RGIzW4Duf1Jg1cM0SOytIs5y/
         sPwyid2iJYC2lrgWt6j9fLJ/RzJXu4NMYAnzThPpqX7cr5RqnT/YilBK0obDZ4VRKehq
         zi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5FX9daSHxdCwJUhwmZJTk7w8vU+fE0VTYrrVq1OIh1U=;
        b=Xbu2E3yYP0FuYokc1uGxlJAKEPga8sUzkGboyLoAttGzsSYEt8ad0E49Q1zGWjDaTe
         hmXajsuBclDYtgNqi3jdp3MnTAD1qGwML+qlJG11lVnmS0ABmVC5aH64qUuQZIqP17q3
         +miBWDol0JGw+heNei7FawHk9rOG/6rbYFmrll6XjuHfwPJrvGgFjunbbsmzJD1+avYl
         rRlmPLm6WwJLXkqM/ttcYkhLOlmDtzf16PTJFvOuNyVZeeh0KEH3pCFnobQl0ZNiIVOp
         Ikr20KoXMnoGGPJdwB1DNP51fsP9Z168cE+YrOVwL+D3tqvXagoH8PLuT8OsbQb1P0fj
         iWTg==
X-Gm-Message-State: AGi0PubCgh7D92EdASycYm9l8WHe3pFPjx6PLcj9sgsFTSbeD4lVREKZ
        HywEFbyqVLkA5Mv/NRRpV244fpv60LwAL/zhcvu194HuWCY=
X-Google-Smtp-Source: APiQypJgttlcZRJDs/yYUtQ49YvUyuH0bqjz1pENiZmFL4IVK76NmMbxz/KbnzR2vwls/DBMiGTr+SJZicvlg8OJt6M=
X-Received: by 2002:a67:d60d:: with SMTP id n13mr6550372vsj.230.1585521033740;
 Sun, 29 Mar 2020 15:30:33 -0700 (PDT)
MIME-Version: 1.0
From:   Victor Hooi <victorhooi@gmail.com>
Date:   Mon, 30 Mar 2020 09:30:23 +1100
Message-ID: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
Subject: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a small 12-bay SuperMicro server I'm using as a local NAS, with
FreeNAS/ZFS.

Each drive is a 12TB HDD.

I'm in the process of moving it to Linux - and I thought this might be
a good chance to try out BTRFS again =).

(I'd previously tried BTRFS many years a go, and hit some issues -
it's possible this may have been made worse by my inexperience with
BTRFS at the time - e.g.
https://www.spinics.net/lists/linux-btrfs/msg04240.html)

Anyhow - currently the server has a 750GB Intel Optane drive, that
we're using as a ZLOG/SIL drive:

https://www.ixsystems.com/community/threads/how-best-to-use-960gb-optane-in-freenas-build.75798/#post-527264

My question is - what's the equivalent in BTRFS-land?

Or what is the best way to use an ultra-fast Intel Optane drive to
accelerate reads/writes on a BTRFS array?

Thanks,
Victor
