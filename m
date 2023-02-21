Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A99269EA4E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 23:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjBUWkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 17:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBUWkH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 17:40:07 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A2034004
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 14:39:44 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id bj35so1046223qkb.8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 14:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.uny.ac.id; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=twdHZET46/F5vizXZVz+VqY+7tyjVRdIagVq9V6tRJk=;
        b=cVKJtoxl0acMJJIwk2hPq/3OBRAVc3EM9BTjXkgsWpgp3u8vCPV+mvlUgevijcZKdW
         yKj8d3Y4qZ/9Eg4qdy1/0Sjmdyk4QHndg3BF3zGn01jkeCIG/n84qxJOD+5RCglv7RTg
         zgbWh0R5Qoo5t2ONfaAYyTgxRyLLvUHoBz9kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twdHZET46/F5vizXZVz+VqY+7tyjVRdIagVq9V6tRJk=;
        b=gDIwHSG5ilrU234ZRb3YH2pYlpiRqyNhEqRx1rKtHxXX2FrZs2ZzZgkLPaKk6i/g7u
         X+8UstH7pgdGBPfIkalrsj1IJOhhaIYxDZw3mf2oPykuuF+g2KnIcMyT7apuh6U8sJXZ
         evhtP1/ftPnuCABu0dcAvZr7Wd0OuTOkwu6m/xJmCQnFeBtFcc6tg+m9rTvlRltExF2O
         zITAxwpmmUA3U5cK6AObleguUKf/P7lUdTRPtt3tzuGDU9A2zhqe80W1WeyL4zEPmygE
         HLRoBIuYvHjVMddTXD0xzVMK4xJ4hLGKFL6KjUr44n7/tLg0L5k2jxCmLJwcUg7UQbCh
         ebIA==
X-Gm-Message-State: AO0yUKWOj+Bz0K2PhT/fqconI8MscXfH2aPqesZ/HAAuJ+Qezk7ZzmFk
        9S1n1t/F+dYqcltSe1BA8K+wj59KUMYIVrS0vNe2vSILMEgg0L40ZLv5Dp+njgFq2zdrUZ1Y3r/
        YUKJe3GCpFyaNhCMuB43vXnnpwPCBTpMxK3L145iQL2KMtQ==
X-Google-Smtp-Source: AK7set9PVR2O2g1LA2BTqu0GQ4mejJLHgcyO/A2UM74GZNzISHf07Zjuehx61mmaKFvYJflBCdhC2Mef2eDCGiE0d3s=
X-Received: by 2002:a37:c407:0:b0:71f:b89c:5acc with SMTP id
 d7-20020a37c407000000b0071fb89c5accmr797707qki.13.1677019183596; Tue, 21 Feb
 2023 14:39:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:3d03:b0:571:1c44:3b16 with HTTP; Tue, 21 Feb 2023
 14:39:43 -0800 (PST)
Reply-To: fdx.s@yahoo.com
From:   CommonWealth Of Nation Donation 
        <fadilahutami.2018@student.uny.ac.id>
Date:   Tue, 21 Feb 2023 23:39:43 +0100
Message-ID: <CAMHH5kh2fSea_DnxFXF520qiR7hbQih-aLXeS_FAaRA+aiNE6g@mail.gmail.com>
Subject: Your Bank Draft Of $800,000
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_REPLYTO,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY,XFER_LOTSA_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:72d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 XFER_LOTSA_MONEY Transfer a lot of money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The Commonwealth of Nations wishes to inform you that the
A sum of $ 800,000.00 USD has been donated to you.This is a donation
relief for Covid-19. Please contact for Claims


Regards
Kerry Russell

--=20



-------------------------------------------Untuk mendukung =E2=80=9CGerakan=
 UNY=20
Hijau=E2=80=9D, disarankan tidak mencetak email ini dan lampirannya.
(To support=20
the =E2=80=9CGreen UNY movement=E2=80=9D, it is recommended not to print th=
e contents of=20
this email and its attachments)
Universitas Negeri Yogyakarta
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
www.uny.ac.id <http://www.uny.ac.id>
-------------------------------------------

