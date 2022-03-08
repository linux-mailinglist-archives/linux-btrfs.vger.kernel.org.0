Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933174D20E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 20:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349823AbiCHTGa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 14:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243715AbiCHTG3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 14:06:29 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB46C3A5F2
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 11:05:32 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q17so25801671edd.4
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 11:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=lTSNbDoy1f+Qw6zlnkwhDAx4Hp6BLf3VHrrIACt1KDc=;
        b=g6IV/6B31e6h6Gr7JskSz6+aoNXue/uRySYailqWQO1hDroNscU6M8vKczP8bptKZF
         Y5m/HxmDtEHXVI2xygil4+U+X0A2vPDYDQ/FlFtCO19/hrYQIeHKC9DtD0xadfCvFdd0
         pXct2oBa25AT6pbQmV6bx0sqXVlXV1IaKPMItzxxCEO6Q+c321X0OI0QdV2gmZF6DBwg
         lB51DQX7IZHrdfbgVS08BvEhaUqYoq+szMuqSukuPTJlirjZIOP/iXtlwwCCOV8XDJBh
         bOEJBoqnDSdRdC8mC6/e5QpjlCAaS8DEcYHzHoF+S0aeKMmoPxqSjFdkF3Ck/jrKb+N7
         hO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lTSNbDoy1f+Qw6zlnkwhDAx4Hp6BLf3VHrrIACt1KDc=;
        b=Xxs9BXMYdCz+8/lcsNzGXW/GqjVAfp7cFCwQ3pO8CHO9pMwTuqc9qtRrGqAR7AhASL
         YJp9Q2pPBeQzsymcRcP5igtruHdkTattjQVjqr+BWX/FgeLRdE44W0AGoPYPkMBPTLl9
         uMczphJgjrZ5NTBdZ4tSJJ94ZcLEfn3L9IBvlPkYOY074wlc95sdBFu4DhFUsKTpcufJ
         gL00gM96oPmh0uWEbtkFyo+xh+7saEDZHU5hDdY1bJvP/gjXYfvgzRhTjFeesUWhEy7Z
         shTQWwZSD0BnudJ5fXORHkPxDapzxGrc7cfWhvC5CYNwKC9aJxT5miv+KLnw16U5febk
         Oqsg==
X-Gm-Message-State: AOAM533afF04LRLNDYyt9AYrDwYlhSK24LS0X51C/rEQ7Uca6b3pbREs
        MeclMQYBScnu6tu5vBF8QxebyUVIlNqhZKwq4ZRLJAhXPhE=
X-Google-Smtp-Source: ABdhPJzNJ8vOv7WNMpyxLP0OUZM7h7j7zTWq1sPuqWb277t52zshRCdkbWyr6Yq3mgJ6QtBDqKkclwwNyqn8WoAudOs=
X-Received: by 2002:a05:6402:520a:b0:416:78d2:3b53 with SMTP id
 s10-20020a056402520a00b0041678d23b53mr3509979edd.217.1646766331346; Tue, 08
 Mar 2022 11:05:31 -0800 (PST)
MIME-Version: 1.0
From:   bill gates <framingnoone@gmail.com>
Date:   Tue, 8 Mar 2022 13:05:19 -0600
Message-ID: <CALPV6DsfOQHyQ2=+3pKF3ZfavL21fgthQS+=HStEfMQbhZU50g@mail.gmail.com>
Subject: Updated to new kernel, and btrfs suddenly refuses to mount home
 directory fs.
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

So, I recently attempted to upgrade from Linux kernel 4.19.82 to
5.15.23, and I'm getting a critical error in dmesg about a corrupt
leaf (and no mounting of /home allowed with the options I'm aware of)

[ 396.218964] BTRFS critical (device sda2): corrupt leaf: root=1
block=10442806968320 sl
ot=8 ino=6, invalid location key objectid: has 1 expect 6 or [256,
18446744073709551360]
or 18446744073709551604
[ 396.218967] BTRFS error (device sda2): block=10442806968320 read
time tree block corru
ption detected


Interestingly. that 18446... number is a power of 2, looks like maybe
a bit flip? dmesg, uname, etc included in pastebin below. "btrfs
check" found no problems with fs on either kernel version. Would like
to figure out how to fix this, if possible.

https://pastebin.com/0ESPU9Z6

Thank you for any assistance,
-- Laurence Michaels.
