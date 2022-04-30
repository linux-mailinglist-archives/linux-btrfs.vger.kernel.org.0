Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C0516044
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Apr 2022 22:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244889AbiD3UM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Apr 2022 16:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbiD3UMZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Apr 2022 16:12:25 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62624719EA
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 13:09:02 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id a5so7747605qvx.1
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=QeqMI9kOZ3XsfK+7r6GsaYHD1psCsveCgY6TGMUnuTg=;
        b=jm2draaARdoVrv0G08mqDC1QkKFo6EKlV5W1HKRO7rJgS/Z/XqPFZL+hcQGY3otahV
         COaigHUVz/9W5X/AR1Xg2NAxuFsB3FLkCTpw5tdfAWPGA5wlJ7sMKP/giKpUoGSP6mcC
         1qdy7mIvTzpWoA96qz1vRkXUrw4QsQa0aDw2+/ssQnGJCe12BCzrogXlbEcId0IM7d50
         gwch+gH5gSOa8mu0PBsBbJq/6lAwTmd4LZMa+Ckr/z19g41zAcNEV9zal+mVylWmQ7kG
         IJ6zye0o/KbczMS4wuSAqP+nW6qptqZznDz0dek7TB4wYlS2wEwHYluFe1S5TLcDWixv
         kS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=QeqMI9kOZ3XsfK+7r6GsaYHD1psCsveCgY6TGMUnuTg=;
        b=yB1XglN8s7cep2U6X0Z2JmUuzEaBWn5q+tOmAYk6SpuclOcmxbd4g8NUxhFJjwi5M9
         DVSjo/RimnNjoXhEr1wRd527GiSPM3i5DnVdyQu6bjnnIYOK34Ky+UwO6DU6eYpAdYIi
         QPDqIjY4saPnBmpNFtDGo5xNUv8yzXgqbpzdbtcm/h7F3fx3DkvqbAiQIzNHTGpfTX8X
         z0UQxBOD1W3kvapzOZqy1aEjUUpwVnEC/8QryllOwF84lTgbiJXhYYSd40EEdHEfWFJO
         4yZ7V4nVUd/09RQfMsGm7ZAF52u3wbDKUfZGbmw0nV7ZNAimqDwVKImI06F3aAVFbFQc
         PBLQ==
X-Gm-Message-State: AOAM530e6rWUA05vBzHHMHv8+mvJBQ/kKyuAN8W9t8fXM62i1RRTatTZ
        gjI+1UfbKBv0HDMtUGTqh0HtDNb2Qf8=
X-Google-Smtp-Source: ABdhPJwlet8TMJNRZ2epytFhzstHjAtmNIsZq3h8OVyOKgjR6fsLc3XqosRwfNeN2qFCzuONOMNHoQ==
X-Received: by 2002:a05:6214:c2f:b0:456:553a:73cb with SMTP id a15-20020a0562140c2f00b00456553a73cbmr4081531qvd.29.1651349341049;
        Sat, 30 Apr 2022 13:09:01 -0700 (PDT)
Received: from smtpclient.apple ([2601:46:c600:af85:e40a:9df7:4908:4148])
        by smtp.gmail.com with ESMTPSA id o20-20020a05620a229400b0069fc13ce23asm1598151qkh.107.2022.04.30.13.09.00
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 13:09:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   John Center <jlcenter15@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 30 Apr 2022 16:08:59 -0400
Subject: How to convert a directory to a subvolume
Message-Id: <87238001-69C5-4FA8-BE83-C35338BC8C81@gmail.com>
To:     linux-btrfs@vger.kernel.org
X-Mailer: iPad Mail (19E258)
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I just installed Ubuntu 22.04 with a btrfs raid1 root filesystem.  I want to=
 convert a directory, like /opt, into a subvolume. I haven=E2=80=99t been ha=
ving much luck.  /opt is empty right now, so it=E2=80=99s a good candidate f=
or conversion.  Could someone please explain how to do it?  I=E2=80=99ve bee=
n at a dozen different websites, & tried different variations of the =E2=80=9C=
btrfs subvolume create=E2=80=9D command, but nothing works when I go to moun=
t it.  I think I=E2=80=99m missing something simple, but not sure what it is=
.

Thanks!

    -John=20

Sent from my iPad=
