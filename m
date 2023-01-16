Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1E66D0F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 22:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjAPVaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 16:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjAPV3w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 16:29:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9639D2C67B
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 13:29:18 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y19so8845521edc.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 13:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cTmgIBFF94UfpugWlpmPjhF2yPr7cvtloqcn9A/rAQA=;
        b=Wyc1weiuQrbrCHa7qyx5tMTrpnuInIbAYZpF+lqE47VCFHuMUVYrmUwd0fS3SOyW3s
         kZTPF/lGUUvwbVxdcUB3/nCkMfuhsXN5Ab0UCfXzrCmbq3aNbQTWjd7lyMzBhv4jCwoT
         aiiLOpPSBbLEhk5CxFDF5/0D9wIw0rLeb9a7/W3pRPx9JJQfhi8zv1gniofFC9xQE7Vm
         3BthKfrXdApzc/qtAQzNE/bk8SD2UPFhxkvJeWLNX9vMnR7on4UpDB5ZIEvmmhbH9xmQ
         s6eFFCUSL7IRA8lo6uMhJQ8/TL4RcEIbvSTtTo6+tHg3ny5SRwfGInvo5/DujOn7kQ5U
         9jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTmgIBFF94UfpugWlpmPjhF2yPr7cvtloqcn9A/rAQA=;
        b=GKuSisGZLW6cPc06S+7uR6QswiOz3V6lkQz/+BVzu0etiaf0TKQMs4rPsUH+PSBtdm
         5Of/haWUtMEZcks0YqIWPeCuGr9EW78AOjWEMKMBclR2tkZZwJl8jCM8kLsyTDUNnYNz
         zY+ihmPe6cAGk2ABBvaMyWQwbv7W5qJJ36QfW9gnoeHWLNx57hkJp72zLF1N+1Q/6FQQ
         xUCaUqML3cYsq7aFyqUJqNZ5OGLbrjeTC2jK83dKVEp/0ImBtbRLWVhhVvoxIDLrZQPO
         lcKSvpoFG2U+yVc4p5rR3CAcU8YHpVa2uuV7KON1sN5QNr4fIxCBacqjShpFLBHAFScO
         aZNw==
X-Gm-Message-State: AFqh2koAWH4GtuKwem2jzqKTdb6ED9eCZxUAU8K+oWQNu3sy7I038wHJ
        r1wwNvh8KF9dZHcefps8yh/a4cLgMOGMlfXfLFA=
X-Google-Smtp-Source: AMrXdXsfPnhAHd31qPKyPgwQDWibt7prY+GD6biBqETI5g+grv+Bb94e+LzCB+ay+SEnPksTaVJfwf3nghiGhF/MNLc=
X-Received: by 2002:aa7:dd41:0:b0:47e:4f0b:7ad9 with SMTP id
 o1-20020aa7dd41000000b0047e4f0b7ad9mr56758edw.239.1673904556878; Mon, 16 Jan
 2023 13:29:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:42af:b0:60:a0cb:5957 with HTTP; Mon, 16 Jan 2023
 13:29:16 -0800 (PST)
Reply-To: gb529585@gmail.com
From:   "Gilbert Wusa.K" <charlesawadji69@gmail.com>
Date:   Mon, 16 Jan 2023 21:29:16 +0000
Message-ID: <CAEFKCG1TQGSfmv4pVmPZ_EGUBxiM3FdMqJmXFgzLm7QMFUZLCA@mail.gmail.com>
Subject: =?UTF-8?B?R3LDvMOfZQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gr=C3=BC=C3=9Fe,

Mein Name ist Herr Gilbert Wusa, bitte ist etwas dazwischen gekommen
und ich w=C3=BCnschte, wir k=C3=B6nnten das besprechen, ich arbeite mit ein=
er
erstklassigen Bank in der T=C3=BCrkei.

Danke und Gottes Segen
Herr Gilbert
--=20
Greetings,
My name is Mr. Gilbert Wusa, please something came up and I wish we
can discuss that, I work with a prime bank in Turkey.

Thanks, and God blessings
Mr. Gilbert
