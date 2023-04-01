Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACFE6D303E
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Apr 2023 13:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDALlN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Apr 2023 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDALlM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Apr 2023 07:41:12 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70496C159
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Apr 2023 04:41:11 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id h27so21397303vsa.1
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Apr 2023 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680349270;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MNPkrwCZgPiaJWKgFmSrRkueuOUvZYKB4FBaACyCJC8=;
        b=lhMQrRGka6n3wT+cygKhw74cuBK8xN4g1qMxY+j93RKjRTZNoxef8+o7RffVH+LOXW
         CPWDh47oBVG8XQ2oq7c7Uo91gi36lEVXJJIUmr7um2WFxbKfWMI9qkcYbyyJddN+bz3G
         A0lOAnJXf+TU7PseLe1cY4zALRvgCbZhoMQspGc5JSndtKpcMaSvPO9as1tImjOjmSbA
         QN30FyRzbPCp9aodfqOuyzMfivEdDoBTCnin6t5+gVbzvGawod6R7c5+LUuYLVrZTl5u
         xq/au9hhrztV+d7Dmw1ero4ka9cufyXjB37UwmzywcAqu4vQteUSxCfrtp1/5VKI9z2D
         Ce4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680349270;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNPkrwCZgPiaJWKgFmSrRkueuOUvZYKB4FBaACyCJC8=;
        b=3CQqncGXZKf4FHJJ1u2KMbDAcBL6+/5nDEvF85g9ZMaVlHH0yr8x8Gu3YJu9oGdGoh
         D73g6epLzX3QbR2pcePLZwPbCFymlC3Uy7opS7Uyp2Ie9Qux3IOUxWISveium2z0bD4x
         I5QAfpcy6xSkWudKYWU1n8z5mWCzgF8iuuCiMN1CBQGGM0CBAxrUHnBuuBE/ndtm9iIk
         JyiYVSeqdkEU3d+p6WwkK3eAV0ansiwStrBrKk3VwfHrsSJzE5tLHkcnE4OLzsMeBz+d
         xeiX6R2YR8ud59UA5ZM7IkL/TC42E83+IyTw7aJih+ErqCDRaAy60hiNYU86RGzTn4GR
         9PPw==
X-Gm-Message-State: AAQBX9fXw+azkFl1Tc2ivtLHQg7w3cLIhsA2vSQbscBVsjkwRBWzOXq2
        s+uP0rZ+zOa0azpkQnnDC8Z4wriHH5iFuapS3aM=
X-Google-Smtp-Source: AKy350asYCgu93KKVokuyc0MsTe+Jln/30aQKO8UelY3c42NqIuMcDrBZyNiaVn7nYMpR6rYqpT1iZhyibws6Cl4Wxk=
X-Received: by 2002:a67:d291:0:b0:411:c9c5:59ae with SMTP id
 z17-20020a67d291000000b00411c9c559aemr17404547vsi.5.1680349270549; Sat, 01
 Apr 2023 04:41:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:e3c5:0:b0:412:2a02:6a53 with HTTP; Sat, 1 Apr 2023
 04:41:10 -0700 (PDT)
Reply-To: annagrey1294@gmail.com
From:   MR EVINCE <anoithedangej@gmail.com>
Date:   Sat, 1 Apr 2023 12:41:10 +0100
Message-ID: <CAH2kyJ24owGNSrzP+fCkLB6oX_-garFUeHTb_KW6sKUTbCgpAQ@mail.gmail.com>
Subject: =?UTF-8?Q?ATENCI=C3=93N_POR_FAVOR?=
To:     eviik819@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Beneficiario del fondo, hemos sido autorizados por el BANCO DE
INVERSI=C3=93N DE LA UNI=C3=93N EUROPEA y el FMI para investigar el motivo =
de la
deportaci=C3=B3n innecesaria de fondos permitida por la ley. Durante
nuestra investigaci=C3=B3n, descubrimos que su pago fue retrasado por
funcionarios bancarios corruptos que intentaron desviar sus fondos a
sus cuentas personales.


Para evitar este acto dudoso, acordamos con el BANCO EUROPEO DE
INVERSIONES DE LONDRES y el Fondo Monetario Internacional (FMI) que
podemos procesar y controlar este pago. Evite situaciones desesperadas
en Bancos y otras autoridades en materia penal.


Hemos recibido una garant=C3=ADa de pago irrevocable para su FMI.
Pago. Les informamos que EUROPEAN INVESTMENT BANK ha decidido
indemnizar por la cantidad de USD 1.500.000,00 y
por transferencia a su cuenta bancaria por transferencia bancaria.

Comun=C3=ADquese con la Secretaria del Banco de Correspondencia, Sra. Anna
Gray, en la direcci=C3=B3n de correo electr=C3=B3nico a continuaci=C3=B3n.

Correo electr=C3=B3nico: annagrey1294@gmail.com
Para el pago final, comun=C3=ADquese inmediatamente con el banco indicado
para la liberaci=C3=B3n y transferencia de su fondo. El BANCO EUROPEO DE
INVERSIONES debe transferir inmediatamente su dinero a su cuenta
bancaria.


Esperamos su cooperaci=C3=B3n urgente.
