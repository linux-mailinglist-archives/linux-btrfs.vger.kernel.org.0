Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D64B89B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 14:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiBPNXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 08:23:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiBPNVR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 08:21:17 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCA029A561
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 05:20:51 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id lw4so4504729ejb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 05:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uLtWfobciGFyuTVW3LENmAo3LvGO3rQRFj2B3nOHV2M=;
        b=aVxl6mQNrXlHru9FBy3V+s0sn3VG1PcR8CW2DErrCLhIh81mRt4iRmKim9ABDk19mO
         7xYRAr6nsJz68RVXDFsRTDdVgHsBy1k8eLbndZs3Gpme8Aq6oDlvTjiPKbH5EFlXBP3a
         Xj3z4bqiuVgYlzV1tUn5LcOj6fgJfwy1ju2Hqk66vKnCSWOSUXc1+6CcD2poLJ4ln7yq
         ePhM7KeOykRzwszTE3BfEXGip+4kKOUxegAM2mWr7yW072lDBNWEIiuVKZeWx7323g63
         NLA1XYjl1K34sklQIqkSdYPn7SFXcCxbUbsLtSxF63yRm/MtkKDJv0D6MEtO1Ignnv2p
         6ZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=uLtWfobciGFyuTVW3LENmAo3LvGO3rQRFj2B3nOHV2M=;
        b=cJpCK4XGPetnkqMIgAEyKi1+4i2BI0TFQU7RoVZvpQrwX6gvgC/vKqrOnQ+GYuULaH
         +I91mkyk7t+09tiBgOG2kFfm9SZXHJaFt/176bSFgb17G8FrCLGLzl0mWn19eedxWO2k
         Lq206+7FybSrcRIwgOVfRRl37AxjmAAfIjguXZp3fai1C+ykIG6AeAKoZGUBi2/TQkUc
         lwQJMeWRyGF1W6zALFpcowooiGQCcWTuALjQaTZZ2NZf7WXlZDL7tN9dWC0J4soJUKbS
         j7pUR+5E3aSfVfZ+HAvoh2yP4K7n0G+bHBbCo1MDAriEC2gLgoR7ftC2/PE8d9doN/f6
         CkgA==
X-Gm-Message-State: AOAM533X6Cz4jFBm1eQQV2Edtm6p4azvHykM8DC+k+8OdqgRl2f0d2Sn
        zQr80BmUUKH9+BvVs4sneiuuhdbnzbw/DG5y0yA=
X-Google-Smtp-Source: ABdhPJxdMQUWEmM4/XmRsXWB9BXHkAidWj7xVG5uzwPlffLIIhpsk63eiW1X1YYb1pTRgM8yoODWRJ7KkTu8o5Nudks=
X-Received: by 2002:a17:906:b287:b0:6ce:98af:3f6e with SMTP id
 q7-20020a170906b28700b006ce98af3f6emr2229682ejz.216.1645017649682; Wed, 16
 Feb 2022 05:20:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:1a56:0:0:0:0 with HTTP; Wed, 16 Feb 2022 05:20:49
 -0800 (PST)
Reply-To: orlandomoris56@gmail.com
From:   Orlando Moris <jamesmrsluisa@gmail.com>
Date:   Wed, 16 Feb 2022 13:20:49 +0000
Message-ID: <CAD=A2zgPkCrGrXrM_-kS-i2Az3y=J+eq1+Z1pqd_RM1A+7OsPg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:641 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5048]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [orlandomoris56[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jamesmrsluisa[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

GUTEN TAG, seien Sie bitte dar=C3=BCber informiert, dass diese E-Mail, die
in Ihrem Postfach angekommen ist, kein Fehler ist, sondern speziell an
Sie gerichtet war, damit Sie sie sofort pr=C3=BCfen k=C3=B6nnen. Ich habe e=
inen
Vorschlag von (7.500.000,00 $) hinterlassen, der von einem
verstorbenen Kunden hinterlassen wurde, der vor seinem tragischen Tod
mit seiner Familie bei einem Autounfall hier in Lome Togo lebte und
arbeitete. Ich kontaktiere Sie als n=C3=A4chsten Angeh=C3=B6rigen des
Verstorbenen, damit Sie die Gelder bei Anspr=C3=BCchen erhalten k=C3=B6nnen=
.
Nach Ihrer Antwort werde ich Sie =C3=BCber die Modi der informieren
Ausf=C3=BChrung dieser Vereinbarung. Kontaktieren Sie mich unter diesen E-M=
ails
(orlandomoris56@gmail.com)
