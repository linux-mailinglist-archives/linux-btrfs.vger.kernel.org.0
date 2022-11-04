Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01B36190A6
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Nov 2022 07:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKDGEc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Nov 2022 02:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDGEa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Nov 2022 02:04:30 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD2F10CC
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 23:04:29 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id hh9so2515175qtb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Nov 2022 23:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=j5b9GJzBtekkE7yFtXxrwfdSnFiLUyeBirWgEHrY1DwsCmMNln0raTzRxoGjxR0vEG
         /uxcYigPDNuHCnpdjlCMIgM2n48VEgd9f1vOvLP7QtlQ6TZ60bKdG45TIRdnGWFrYvNx
         Cp55Gth/vM30nQcwiFTGNz/rn848q3Eb4Q4zOcHHfzU4yUla/g4Ad3fhG08vEfC5/R3h
         PPkXOTLacmBas/4TqbxS2EbsHUBC7HUkqW24VFIAAc/oUNQgb1e6AqTct7oO2A3z5CF9
         SDfCYWufECI8AAEV1C876JYV0w0fzKUncqX3+GY4OEtVI/MgHr71Oynl7CVhbajN2Mle
         apoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=QAA5K/IHAEGi/6YDg/nZRzuRkNFz9HfaPvo6Rvn8baLoY0NVR1iK2n6jAc8U85S3Pa
         ThE0kOVXmHvvYPl38kQcMagvi4nD+B4aUfo90sJPcdMFhcpCEHHaqm2MbLyWMzxCBXcB
         XXpZSX5OiGiC9VAttdPL5vQclKfrZgGPXV7ixmGAsS/nMe7nGh3pv3i+ElFt4acQKYMX
         VqGjrih2pIhDqwE8Q0RQnpoHoOmZJb/LiP3pq7hsg+lf6vsNGr8fq/R5B1i2Xc25X1HD
         C0IUb6Rl6SG1GLBME1sEpM3JNe5PIPaTMTVc6iccDLCXrGS4to8jFY+ltdEfre1k2T50
         qrDg==
X-Gm-Message-State: ACrzQf1FMEaTRa2xhxCCd0VlzJF4nF5Rd4bvM5OUtcjTUVLxg5UL61yk
        5kU+JzzYpPy95mDUtnsizQ3GVejBW8jkACLhOd0=
X-Google-Smtp-Source: AMsMyM4d+3oHqwtyFW+7gNpseL+BTezKOejCwfVqbuHSnc4TnvWkrB9jZZGIql1DLTGZWP/QM8LeEdkETfs5XT/OIxU=
X-Received: by 2002:a05:622a:1194:b0:3a5:40c8:99a1 with SMTP id
 m20-20020a05622a119400b003a540c899a1mr13628866qtk.267.1667541868111; Thu, 03
 Nov 2022 23:04:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6200:5e0e:b0:49f:24a7:f1f7 with HTTP; Thu, 3 Nov 2022
 23:04:27 -0700 (PDT)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <nancyowuor33@gmail.com>
Date:   Fri, 4 Nov 2022 09:04:27 +0300
Message-ID: <CAN=GBp2sxHb16UOJrQWGG8HwWgM-xtD6Svz2cw0rojg4Fwu48Q@mail.gmail.com>
Subject: Geldspende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5014]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nancyowuor33[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [stefanopessia755[at]hotmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nancyowuor33[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=20
Die Summe von 500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespende=
t.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
stefanopessia755@hotmail.com
