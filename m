Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A347E54AE3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354361AbiFNKYh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 06:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiFNKYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 06:24:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FC44756E
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 03:24:35 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b7so9189397ljr.6
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HI7mop9v/Y4k/2K8Z+RNWKGLaK3HTeAH+wJXPA8w/Fs=;
        b=j9z7E3LhkYeVhJrLSOvV6+h//X9SN6bJY5GbepuBroDICPUtMwrNuGq4z3UsTvJvLN
         QVY4Xv0ti6v923ER437MG+KpOhrWpjxtL26CApp+xBPWbkb0qycm12RHYkfp/JK8dnkI
         OKmAnMaWmc/r41bWS7sBxhMe8aiik+WIGGKusADuVChSza22YmJRZM3+fwGV8d83bzBm
         a42vCVxcj0rbmSCJJEyMV8a6oHMf+SY695tgzDm6oA15SQoAw1WBrozRrJZOQnpYSyhe
         Dl0R7k4dpqV7Tu4+aCfMk51/iElFhumw77xqxgNoqzFKK8M2Ch7EnDUNWtAKacSTmJqD
         3FuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=HI7mop9v/Y4k/2K8Z+RNWKGLaK3HTeAH+wJXPA8w/Fs=;
        b=lJpo6mRaWfnpljxKYRJVkbx9CeK15Psym9FQLrCMFjgB/7MjBnV9HxPMIU8X+FpPlv
         o1x3Nloegb3xWL/4xAJWp8Nod9GmGNQwMvhYyphC4mCgdJt4X+lVvB3tmAIH5iOka1tK
         GToclJn+wyypDdyuS9xEbUit1diY3IBzwjcv+AOgQIm85tlV4b0zYGxFxD4nobqxDtf1
         4ksGiAzpdUCuUGHYBs+c05IoNJLUWSbSyip4W1DI739yhZMpFAkDY3SMt8Ji6L1c0k0l
         Rwufp5dkUJgCE9VJVnHxLsFfh7vLyJUy/W5wz+AP+oxKfnsiBCqYVP35TKzJD+gqnrI7
         yKqw==
X-Gm-Message-State: AJIora+uhhgPmxzl9DwWY9S3g6ahbWrYrzZ8pG5mmZRAS24gneZRULe6
        CuLTZYxputDkMefioPVBXlhwroaKtYE5XQKsLIE=
X-Google-Smtp-Source: AGRyM1sGpPe/hZW5Jp28X6Xz2nFwOkAaeO10NgUSU1VVr66KqNRxwnLsXmvK3cpiRXpA9lgGxAdRe45XZZp2UyiAPqY=
X-Received: by 2002:a2e:9609:0:b0:255:8364:9fd8 with SMTP id
 v9-20020a2e9609000000b0025583649fd8mr2073413ljh.132.1655202273152; Tue, 14
 Jun 2022 03:24:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:d990:0:b0:1e5:95e:790e with HTTP; Tue, 14 Jun 2022
 03:24:32 -0700 (PDT)
Reply-To: mesquitamario121@gmail.com
From:   Fast Track Agent <moussanouhmanou@gmail.com>
Date:   Tue, 14 Jun 2022 03:24:32 -0700
Message-ID: <CAPCdybF7v80G59woR9XbmVvXNne=w9dDThbUB+Oydk+Xj3pNtw@mail.gmail.com>
Subject: =?UTF-8?Q?atenci=C3=B3n_urgente?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [moussanouhmanou[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mesquitamario121[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

=C2=A1=C2=A1PROPIETARIO DE TARJETA ATM!!

Hemos acordado finalmente entregar su caja de env=C3=ADo que contiene tela,
Computadora port=C3=A1til y Iphone 8plus con una TARJETA ATM con un valor
de fondo de $ 2,500,000.00
a trav=C3=A9s de la empresa nacional Fast Track. El agente ya est=C3=A1 en
Aeropuerto Internacional con su paquete,

Logramos esto con la ayuda del director del FMI, John Andy, el I.M.F.
director y todos los acuerdos necesarios se concluyeron con =C3=A9xito con
Empresa de entrega Fast Track.

P=C3=B3ngase en contacto con el oficial de env=C3=ADo de la empresa de entr=
ega
Fast Track, el Sr. Mario Mesquita

con su informaci=C3=B3n de entrega, como:

(1) Nombre completo ......
(2) N=C3=BAmero de m=C3=B3vil... o n=C3=BAmero de WhatsApp
(3) Direcci=C3=B3n de residencia .....
(4) C=C3=B3digo postal

a su correo electr=C3=B3nico: (mesquitamario121@gmail.com) para recibir la
TARJETA ATM
(GL-1416) c=C3=B3digo de registro y su PIN (4917).


Tuyo sinceramente
kate andy
