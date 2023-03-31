Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C854A6D1F90
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjCaL65 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Mar 2023 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjCaL64 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Mar 2023 07:58:56 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0391C1F3
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 04:58:54 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-545e907790fso294466897b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680263933;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/L/0GhYJiF9q9jl7Ire14bbM3hl0e4FbO8DfgexHgU=;
        b=dwpQnvUr2tmv+l4iF3g1xSn0FxQHiuiX9OhQ0hj2zL75NxHrBLidN/qwiz7OlRTZiQ
         r1r8bkKxQhJREB/5ANCew+5cqMPDdEAcAFXn4K1p0YBxQtxlVaAtOcJxAUbeUMHjoduh
         ggiZLhPfBQb/fKuFad5PsVEU+Mer6IlLT+7HPHkyZlz97wecf0tFafdKaSFtEof/0wFQ
         4FEO6bWAdJtMnCu6DPOE8Ua5IvGKkHA61kQDdKNcSm6CZ0xZ0quU9USSFCQ8Cjh/tbcq
         u2TqOsqCK9nqNeKPArNTQ/g9N72B+gb0pEoNEIDiaj/pACROHmBhprnTKR4dOCWYD3bo
         pYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680263933;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/L/0GhYJiF9q9jl7Ire14bbM3hl0e4FbO8DfgexHgU=;
        b=Mfndp6+DbGXexzYUHx9hTQmnKQFF2G2qx7VD+GYdBN0CkeZMYxOH0BhGMFmaslVHkj
         WyjwhIfsFHodvCxDCGL9iZvmwr8XS4+ybzI2tRrGd659L9ugjE+/tQ0LPo0bmmXujbeQ
         AVD/Uh2HiZtimbzVhjEWIobLhY+d5muCDLATwzNRty+Z8agCvQkHg5dxl97A9bS7YA3m
         66FIGqnzQl6XEx2O3dzkzJM/oAUlNWup+GeEjKLcDFNcA/fV2XB8PLBMGIzEAfA5nTbt
         ryhxeTpvQyz2bJ3Vi1vv7t7AeptdZCnrAbrT/QTdUdEIQYqPZeiad8JdxOaHxwp4uu3b
         m6QQ==
X-Gm-Message-State: AAQBX9cl79E1Yr9tLVgB6Ed2SzpmjTYTilfAknsCaaCp6ybsXq1qyiKD
        ynJQFldiC6U+JScUaDx4oPNH5HvSD/FT209IFlg=
X-Google-Smtp-Source: AKy350aQl3Qvu8P0GetWQ2ZYw2jdIeiJfH864lcoQsGO8piLDC73j6oHX28O4UFdfd6YhDqSkZB0dAys4lVIzJsHbaI=
X-Received: by 2002:a81:b647:0:b0:541:a17f:c779 with SMTP id
 h7-20020a81b647000000b00541a17fc779mr13553417ywk.4.1680263933255; Fri, 31 Mar
 2023 04:58:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:114b:b0:49a:1f99:efd7 with HTTP; Fri, 31 Mar 2023
 04:58:52 -0700 (PDT)
Reply-To: annaleszczynskam@gmail.com
From:   Mrs Anna Leszczynska Malgorzata <hans62873@gmail.com>
Date:   Fri, 31 Mar 2023 13:58:52 +0200
Message-ID: <CAEDL81-KYzXiZ+j-apyOGpp=j1Dr4jsGMpZ5EwfLPu3R5H5bsw@mail.gmail.com>
Subject: =?UTF-8?Q?Spende_f=C3=BCr_humanit=C3=A4res_=2F_karitatives_Projekt?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112a listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hans62873[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hans62873[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hallo sehr geehrte Damen und Herren, ich bin Frau Anna Leszczynska
Malgorzata aus der
Gro=C3=9Fbritannien. Ich mache eine humanit=C3=A4re Spende in H=C3=B6he von=
 3.900.000,00 $
Millionen Dollar an die Armen und weniger Privilegierten, k=C3=B6nnen Sie
aufrichtig genug sein?
dieses Projekt in Ihrem Land abzuwickeln ? Bitte lassen Sie es mich
wissen, um mehr zu erfahren
Einzelheiten ?

Anna Leszczynska Malgorzata
