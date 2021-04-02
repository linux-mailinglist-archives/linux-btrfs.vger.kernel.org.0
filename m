Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4421353100
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Apr 2021 00:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhDBWTY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Apr 2021 18:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhDBWTX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Apr 2021 18:19:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C311A61178;
        Fri,  2 Apr 2021 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617401961;
        bh=+P3BB/M2Uz+uF8TVRvntTLY5K9BYSVWDtARx8GT6QvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fvJ4WezfJrDdOyJQhSoQPS9IMLQWfcRKDiLPjq+ggxSoz8xrrjFenx/0U3lj64rAp
         c4Q+rb3U45H9ga5FABrFq+sgZResytJelhl1eDK0hdfZ2MWn+MqnLMY4h+HDhYs/++
         HO6UyLjXbE+iNfApB4pqhVZlTS1ugkSALgb2CW8ojtW38C39OUNb/h9vnOux4AnLgu
         C/StkA9VqRaxycglhWK+gPzSOzEMQTa/rU/sTp6LQZmIHj3g5O4fO5A+U3qao0nhiv
         r6dgXNrEbeuKYDXLzYaWwyNhXRwf38GfWk+qo51CU2Ld5gETtQd3UZ+LTC3yS0ySCi
         UQZZkQnBW+wmg==
Received: by mail-qk1-f177.google.com with SMTP id q3so6389864qkq.12;
        Fri, 02 Apr 2021 15:19:21 -0700 (PDT)
X-Gm-Message-State: AOAM533Rjx+e7caowkx/ARcOi0JKv5xbwAl8Sy0qb81XiB8zhqDowjGc
        v14pSerheIZveC/wWDrxcbHlleCbdblRqRvcUEQ=
X-Google-Smtp-Source: ABdhPJxkKzKmz3eKjoILxitpl/STJhRa6LLD1KXUCdSTcCMB50+iFkwLEIob8SpJMIqlR2lNHuJI+6KtdKhET+WznuE=
X-Received: by 2002:a37:d202:: with SMTP id f2mr15235336qkj.273.1617401961030;
 Fri, 02 Apr 2021 15:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200813163749.GV4332@42.do-not-panic.com> <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
 <20200813221348.GB4332@42.do-not-panic.com> <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
 <20200814163723.GC4332@42.do-not-panic.com> <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com> <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com> <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
 <20210402180253.GS4332@42.do-not-panic.com>
In-Reply-To: <20210402180253.GS4332@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 2 Apr 2021 15:19:08 -0700
X-Gmail-Original-Message-ID: <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
Message-ID: <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
Subject: Re: Is request_firmware() really safe to call in resume callback when
 /usr/lib/firmware is on btrfs?
To:     Lukas Middendorf <kernel@tuxforce.de>
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Lukas, can you share your /etc/fstab ? Also, how long do you stay in
the boot before you try to suspend?

 Luis
