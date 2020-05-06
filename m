Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1681C7CDE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEFVyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 17:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729162AbgEFVyy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 17:54:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C63C061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 14:54:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 188so2661721lfa.10
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zXnAAolGhXyB77C6/kiwKNNnmCN6q4NRryutoHKEYqg=;
        b=V6sqj8izbAf3CuuMB1P8V0+/ESMZcW10SZTQu+H9nd8faEseBQMaYilypdkKaFjmHx
         se0HGgl0bDkTnEWhq3pFeacyOQqL555jXS5huakuuDB7TAZQTak0bx18D9rbwJMT6R0b
         L8kiTfXBzPi4VbAgZdQotTMkZHjKAXmkXV53JaEGDxnp3ybRmNKngTS208dnedYWmL2B
         MqmJpK9JxK2wjP3PPLWb4nJg9EMqUJkGfsJ72qo8N9WA2DhTMXUfY6v2nrCSsEK4Mi2S
         T7wyDgfkPv03Q/Dn2lA7PTJAYfnZr80sLlbvmfatxmAjrHdn7NZOayUud7cKkTw8CN0j
         ZXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zXnAAolGhXyB77C6/kiwKNNnmCN6q4NRryutoHKEYqg=;
        b=F1grdyIXTiSk+vhgEVtDD08kEnrpdLern0EjF1hHjOqxDLJoPq/RObwnX8wj4jGB90
         xqosn8V7mvmoZ8dG9JGPBjIxSQ1Wr5EuPS0WeWEhqF8x97etgSSGUzJPUKWcxiXQKbeG
         1gBENeA/PgaW1O1MgkuqzMlOq702nXRgtqyPt1C2IzaR+Q/Yg8X5MPahT5pVIGDyHaet
         GLZlczUiLrNNX/H10uYyBtp1meTX1UqhjOOUb8j9GsMfUpzMCyPCyXASYccXK7khAfLw
         MLX07hvvl5c3t0owcVN1UBTtoQmUxFLv2crrdOWTokA8c81SFIOsWTqBvqnGuGfvcwo8
         44MA==
X-Gm-Message-State: AGi0Pua7eOUko3LwckmWbNw9IDDeSrc3/kcs4lklp6NfT3EXLiZ7LRTe
        /BCaDs/OfnB379vmoIkJtPobsVi8kTNIqyK+w5aOig==
X-Google-Smtp-Source: APiQypLRVgkzKOvNtVHlCygS55UMcCzgehp6CGZAt8AOvnjg+J7WGli+RfRGms3anbXGkJyqGgMJ0CLyqtpw6lFYg78=
X-Received: by 2002:a05:6512:3187:: with SMTP id i7mr6654225lfe.101.1588802091807;
 Wed, 06 May 2020 14:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
In-Reply-To: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Wed, 6 May 2020 17:54:40 -0400
Message-ID: <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
Subject: Fwd: Read time tree block corruption detected
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I looked up this error and it basically says ask a developer to
determine if it's a false error or not. I just started getting some
slow response times, and looked at the dmesg log to find a ton of
these errors.

[192088.446299] BTRFS critical (device sdh): corrupt leaf: root=5
block=203510940835840 slot=4 ino=1311670, invalid inode generation:
has 18446744073709551492 expect [0, 6875827]
[192088.449823] BTRFS error (device sdh): block=203510940835840 read
time tree block corruption detected
[192088.459238] BTRFS critical (device sdh): corrupt leaf: root=5
block=203510940835840 slot=4 ino=1311670, invalid inode generation:
has 18446744073709551492 expect [0, 6875827]
[192088.462773] BTRFS error (device sdh): block=203510940835840 read
time tree block corruption detected
[192088.464711] BTRFS critical (device sdh): corrupt leaf: root=5
block=203510940835840 slot=4 ino=1311670, invalid inode generation:
has 18446744073709551492 expect [0, 6875827]
[192088.468457] BTRFS error (device sdh): block=203510940835840 read
time tree block corruption detected

btrfs device stats, however, doesn't show any errors.

Is there anything I should do about this, or should I just continue
using my array as normal?

Thank you!
