Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E055BECF07
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2019 14:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfKBNuP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Nov 2019 09:50:15 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:33343 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKBNuP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Nov 2019 09:50:15 -0400
Received: by mail-ed1-f51.google.com with SMTP id c4so9635391edl.0
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Nov 2019 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yEaI2VSTjFeg2PJcPwUsmUSknamE3JfjF7u7xrHeq9Y=;
        b=I3UqZ7X7sgr/30WVkcgPLV3HXhL6XuO8GQnPPZe0Tt5biMKTwklcG8V9SCuVoqryav
         KELt4Nz0tpMOhB//1PBRxV7jy9MX3uX5TDPrPtQNbtBzmJsE6dcUV+/qrFbcuymNEzIK
         2jTRsJnGxnueeaD0N6QVyhj/hKGlSel9JQR5OncP0vVAY7Qt7phtaJl9y3mPeCtfpwzM
         LrBd6Ijtngw0VEB1ysEsoqpsM9XWGytNgf08/n84WkzRQyT+GvjYUem0iSOsMceIfQfc
         rFu5v7tg4bUJna72iTqlx9xiM/rAM8RZdEGtMe958Di0m8mj/pe0hO9kYzg9Annx6mtS
         YiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yEaI2VSTjFeg2PJcPwUsmUSknamE3JfjF7u7xrHeq9Y=;
        b=hR3S+Nf7NIxihr6t+PcAq4fw/1+/44VQo7J3gwrGTU7E9siUognh360LZg5G6jpFWA
         Zk/InDWmt01Q8J0T99OVcP+dNOthmdyjvTYoTzZUREg17N6hTNhCthepUaqgEG51rSEt
         c+Z7gLUV11+DFsMpRYMcVNzczThyCOVIww2MncZe3TOLCrjNX2s2Gb1A9IxBFuuWUYXT
         VlonYs6fujq8j7omUdpd+ZB1MvpvRThfin/ywDbnYFi0fTYyH4IfXCR5KjvmhvpUXtxb
         dcUz9SOCxMpm0dltimqKparkwZjrm2/Id4FegQeyXpfCR/6KHeRuw208IMeeHJMCYbNz
         KXCQ==
X-Gm-Message-State: APjAAAWicu4p88IQ0atWGwsvbfiEK2LEI80r8HqPTpuKxH7B3/Tnuq2J
        mYSnOkm9+SlAT/gBI9YVYalAQIzTyephzyDlOPcan17pEwU=
X-Google-Smtp-Source: APXvYqzWk+ldZtdh5EL/MycY3m0AYopr29PFORRQkjYlHwILOvTFG/hfMHW0hGBIExQ9F9KmOYSd95f4WAgCmCSigZ8=
X-Received: by 2002:aa7:cad0:: with SMTP id l16mr15463477edt.82.1572702613613;
 Sat, 02 Nov 2019 06:50:13 -0700 (PDT)
MIME-Version: 1.0
From:   Brian Hansen <dulanic@gmail.com>
Date:   Sat, 2 Nov 2019 08:49:37 -0500
Message-ID: <CAMiuOHXH1ic6Mcz+o1uWLNMCK+iCinhR+nnZ8N1wTHQoEms-7Q@mail.gmail.com>
Subject: cp --reflink invalid argument error
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

First time i've sent to this group but I am trying to figure out the
cause of this. Normal copy is working fine, but then if I use
--reflink it says invalid argument. Not sure how to read some of this,
but here is the strace.

I'm running kernel v4.15

Here is the full output of strace. I ran a strace on normal copy and
most looks similar so I'm not able to figure out much here...

https://pastebin.com/raw/YmQ8FvCH
