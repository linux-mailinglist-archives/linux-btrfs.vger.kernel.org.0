Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A635F6FA50C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 12:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjEHKFa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 06:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjEHKF1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 06:05:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9163630445
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 03:05:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f415a9015bso23292405e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 08 May 2023 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683540323; x=1686132323;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7QbAPts//V0cqG1dAERocybNxGiqo38JsSdzIJt4Vc=;
        b=W+83l6sn2Z/Sz7u5wO5AI7ElskDMnkXNQ4o2kxwKFVYZV1MoDzbkDeo/PG3xkOUbUn
         DIBCbFzYwjOmYfp6LihaxOB8dFadKTUEDPCiSarpENbiZTgRfGH/8U69askMus7SW390
         GQ3YBuVKIa43vOcsQjKi29ytCKFcjkvNjjt8xp+3KxA+uh1tBwkAhASLJbln3s6LAYGb
         pZYFefanTRTlkHy9YdwAcxvrRG6wRbLuq/GkgIZ1StsPido8UjqVfrO/94Ih6/xz3y89
         RE3nedlQRjPP9tO4DMPbqiaQvEevl0F4IrY3k+w9cR5ULMPJ4ozQtbQYE5X8j49iDLHB
         peFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683540323; x=1686132323;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7QbAPts//V0cqG1dAERocybNxGiqo38JsSdzIJt4Vc=;
        b=QUj2ba4L+rmCcxYcrfCiHdGD6FFISINNNkVzdV4pM4YPN+P1AmCpkUP3AWWPwxYC82
         FlPm/piiZXLXa9dbPS9syvkDHD7e4dDaijUNsNIOnouJ1nar6QvctytKaNLOco9mkYk3
         /Ujiwsohu1EyfxpE8rr/W1amb0HjIsWnA15+lG7SNxHPqcmWNpauFE6+L0vxOiLJ9F10
         pbjM4ACm7Jslp1J2QwvES9qHn0lSZ3/9ibE007c4vL+gFeYBuLx8Wfv2SL+37Pw7z9E5
         Kdpi756vRhLpaNVEwHYm97HnINfACzI/ysHSw2VQMs7bI0oKW8RevMJ29meBb9fUGNHl
         JG8g==
X-Gm-Message-State: AC+VfDzgAYaHGye5vwqc6DK2yASQXAs3wMoY2G1SbuU2MWZ1OtDXrkWc
        RD43K9k+oVPPC81F17KV1ZnxsfZRGSoJnE57S0I4BWwUoz8emlZ/
X-Google-Smtp-Source: ACHHUZ6IB8gD96qSqUq4HIhBYTVRNhRsCU6MH0XuWID3pcK940P5TuGJ7Xf4xDWAsa4l8ySZcjvBp+GNKKunZeODTdM=
X-Received: by 2002:a1c:f715:0:b0:3f1:661e:4686 with SMTP id
 v21-20020a1cf715000000b003f1661e4686mr6812927wmh.7.1683540323513; Mon, 08 May
 2023 03:05:23 -0700 (PDT)
MIME-Version: 1.0
From:   Vladislav McFly <mcflydesigner@gmail.com>
Date:   Mon, 8 May 2023 13:05:13 +0300
Message-ID: <CAGO2SecW7BtE_YWFiO7SL2mvDToGJ-XFfiUZjoMkOXUWR_iqJw@mail.gmail.com>
Subject: Btrfs question
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good afternoon, Btrfs team!


I am a student who is currently working on my thesis that is strongly
connected with Btrfs.


I would be really thankful if you answer me.

My current configuration:

Btrfs version 5.4.1
Ubuntu 20.04.5 LTS
AMD Ryzen 4000 arch

I've got several questions about Btrfs internals. I am so sorry - but
I hadn't found any information about it in the docs and on different
forums. I would be really thankful if you answer me - it will help me
much!

May you answer the following list of questions, please:

1) COW technology - how does it work if I modify the file (assuming
before I created a read-only snapshot) at the beginning, middle or end
- it will anyway copy all the blocks of the source (the first version
of the file) file? So, to optimize it - do I always need to use a
deduplication mechanism?

2) I've tried to take a look at btrfs internal implementation of COW.
Am I correct that COW works based on metadata - Inodes? If I delete
the file(assuming I created a snapshot before), and then create a new
one with absolutely the same content, in this case, COW will not
understand that the content of the file can be optimized(with the
created snapshot, I mean "exclusive" size of the subvolume) as the
Inode changes?

3) During my experiments with Btrfs and deduplication (I am using
"duperemove" from the Btrfs documentation) - I got a strange result.
If I modify the file in the middle or in the end - deduplication
successfully works. However, if I modify the file at the beginning of
the file (keeping the same Inode) - the deduplication mechanism
doesn't work for some reason, showing me in the console the following
message: "Nothing to dedupe". Is there a problem with the
deduplication mechanism if we modify a file at the beginning?


Thank you so much in advance! Have a nice day.


Sincerely yours,

Vladislav.
