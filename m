Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59874C6F8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 15:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiB1Obu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 09:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbiB1Obt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 09:31:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A587EB38
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 06:31:08 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id x15so15747311wrg.8
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 06:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=87O0a7nz00iNXjFEKfa2cMRzf8NNXjyGFIQyBmpZIgQ=;
        b=Na9crJfq56jW0PmQVRBV1QMeKV+MIp6r1/3LH/5FOP+qvWpd2yncFXR0iwKhexTTPM
         UITR8t8ajLI4kpjrnt9lTCPxBGZPPxVwwK5yZEtzcYpCnxjau5Vz+keqQYV48qXLGxxr
         m3CYMafNnnezczhhPdRZwWZNqmcgUx1KHg+Umy9zgn6ketRd+Zu83PWHezH8xV6Nx/a9
         czT27tIhT1U83N3E19qqNhAOVK9mHWbPtZIzpVw1Wtsgp7pXKFM7CfqLRiuBmEkUDXwf
         NxCK+63fLqbd0jHdMMNH65QpBmJ9LrydywTGbg+zy3SpLgwKAj0opeLGel3Gf0EcXBJW
         cgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=87O0a7nz00iNXjFEKfa2cMRzf8NNXjyGFIQyBmpZIgQ=;
        b=FACzCamLTktxIMWF6tKd04bbStbUEAw5WvF5M2QYBzpZAj7AqwBt82peiSUBhmXLTY
         zr/pMsTG1uRwQrzejUPKXuAXt8+2DJZrIh2KjXE7WNKkNJN1v3+P1ePA6NNHB6OTqQ02
         Is3mPQQTSyNyrxW491+nEYHR/guT35BjIwQF7azIpAshM7N8IEOiXL8eUPnwZH6ks+Zg
         zIwfQZD8DWqVBj7/NutxUyTUHRSy/xwRwi0D81ly+Z5PARUKiHuNp2w36SAkl81stfgZ
         wZx+Znd+dSo7sIOuOPWICtf/CG0i84+zQQRFpgQa7mtD5I6sIhkyYIvReJZ0tLv3hir8
         BDFQ==
X-Gm-Message-State: AOAM533vExnhcMdL0MBrS3yJrVzMdP3cNaIbqVmRmt4Y9hjeuxS62IRu
        NnQiBHSW04U58HzFDdXaMZNoQd81Qom7iXPnBWQ=
X-Google-Smtp-Source: ABdhPJyWr4MMtGcQ4Sx93vS7aeRq4M6BI37TmuTOjDuXVTKgUzEse+or23tPaEjFHwjP1jK0W9mM9MPHL9ZU4/B9iA4=
X-Received: by 2002:a05:6000:1846:b0:1ea:7f4d:c56f with SMTP id
 c6-20020a056000184600b001ea7f4dc56fmr16030150wri.25.1646058666964; Mon, 28
 Feb 2022 06:31:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:1e11:0:0:0:0 with HTTP; Mon, 28 Feb 2022 06:31:06
 -0800 (PST)
From:   Belen watson <belenwatson35@gmail.com>
Date:   Mon, 28 Feb 2022 14:31:06 +0000
Message-ID: <CADiofxHLsGKN0T-vJ-waddT54+6fX3xAgo8+NoJ+kmFE2OwaRg@mail.gmail.com>
Subject: =?UTF-8?Q?Sauda=C3=A7=C3=B5es_a_voc=C3=AA_em_nome_de_nosso_senhor_jesus_cr?=
        =?UTF-8?Q?isto=2C?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=20
Sauda=C3=A7=C3=B5es a voc=C3=AA em nome de nosso senhor jesus cristo,

Desculpe se esta mensagem foi uma surpresa para voc=C3=AA. Meu nome =C3=A9 =
Sra.
Belen Watson, uma vi=C3=BAva, eu encontrei o seu endere=C3=A7o de e-mail at=
rav=C3=A9s
da internet do meu falecido marido, Sr. John Watson,

Atualmente estou internado no hospital sofrendo de c=C3=A2ncer no sangue e
doen=C3=A7as de Parkinson. Eu tenho apenas alguns meses para viver como
conselho m=C3=A9dico. e eu quero que voc=C3=AA me ajude a reivindicar o fun=
do de
heran=C3=A7a do meu falecido marido deixado em um dos principais bancos
aqui no seu pa=C3=ADs para fins de investimento e tamb=C3=A9m para menos
privil=C3=A9gio e orfanato
pessoas em seu pa=C3=ADs.

Antes de meu falecido marido morrer, ele deixou uma quantia de ($ 6
milh=C3=B5es) d=C3=B3lares dos Estados Unidos para um dos principais bancos
aqui, que eu lhe darei as informa=C3=A7=C3=B5es banc=C3=A1rias assim que re=
ceber sua
resposta para voc=C3=AA entrar em contato com o
banco e fazer esta reclama=C3=A7=C3=A3o.

Meu falecido marido deixou o banco saber que seu parceiro de neg=C3=B3cios
no exterior far=C3=A1 essa reclama=C3=A7=C3=A3o.

Separei 20% para voc=C3=AA e sua fam=C3=ADlia enquanto voc=C3=AA doa 80% pa=
ra as
pessoas menos privilegiadas, darei mais detalhes ou hist=C3=B3ria completa
assim que receber sua resposta, pois o fundo foi depositado com
um banco

Permane=C3=A7a aben=C3=A7oado pls voc=C3=AA pode entrar em contato comigo c=
om este
e-mail belenwatson35@gmail.com

Senhora Belen Watson
