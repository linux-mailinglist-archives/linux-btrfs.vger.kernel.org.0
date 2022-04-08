Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083224F946A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiDHLuQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiDHLuP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 07:50:15 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB7B1FE93B
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 04:48:12 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j21so10517195qta.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Apr 2022 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1Cw+PN6C10DR2gJ2ZgvA0OU3s6vBuxAZStErAD7Pxwg=;
        b=I/ASJHb9F/gEa/faoAsr7ohl1m2v80fFcT09zn1NM/0Ie1tNK1PVMJwHbrzfJepKMw
         eMP5lY4S/x1swEsHGj+QUmrNEJRf/tGYJWppV331vgZH/K0zn/NtN85bXIHXdDZclzN4
         S/lpIQ9JpN+zzArhVyWLGtzVYxBozPDaAR1NyFD3cUWbMxFWzZZhxoLasjhedyRIjwuG
         7H0xTeEVFQx8lduu8VXydFLazdRp/es+KrMnsmfuwQmvppRP/MeIQqqJY7m7XQNSCgwA
         z748j0mRqjBxBU7VAUO/u7mL+J9fFA39DrvvJP/zPtCX9ibavy0YbWKBJzXDDD02/m+5
         vmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=1Cw+PN6C10DR2gJ2ZgvA0OU3s6vBuxAZStErAD7Pxwg=;
        b=bdm7M4GQQ5qhXbjvXi4pYMii0oXMT8NTbz0YkKXRUNbkoHzKvy3/LQCVN4krFkUNLK
         8pkdPfBV3Pw1b2gxDamWAsRDa9s0VttuW1C46TXMBsV+HUSJNw1ZKHVz5AMDI256vmrz
         WUk6AFFNDKbBUHSsD/Ugs2xrpi7HXycQ29x3cv+jGgQlac1OVLG0CRG8WnlLzpTRXXf6
         uuM28W7NqRIhQ2GS2UIhWHFA0R0kgGEkqQniQ3WspSKVXRGkC+SffbUlBJ3Bjn0+aO+i
         slxuf4aT7A7hQSmiROaXxBQGJZPfhW753M5bk4Tt/bxsJNgoAb7/XSQW33XNBhWxD4qZ
         MCTg==
X-Gm-Message-State: AOAM531fuF8Nttxg4oDqlNOKvx9zdeG21diqeFXwCGqxkabAarhD+AtK
        /GTC5Bt4Xo3+yzTMeA7vhqUi3yfoWyXn1kL7PCE=
X-Google-Smtp-Source: ABdhPJxSgTGym5Z0+MJcLuTLGFOvAjtibHoLHOXyUlDNzGh++EfhkGtgTXn9kVEhQdFhPzDPxuGiBDzQBsGhN+v+vfA=
X-Received: by 2002:a05:622a:509:b0:2e0:6f77:725a with SMTP id
 l9-20020a05622a050900b002e06f77725amr15303594qtx.294.1649418491485; Fri, 08
 Apr 2022 04:48:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:6b8b:0:0:0:0:0 with HTTP; Fri, 8 Apr 2022 04:48:11 -0700 (PDT)
Reply-To: susannelegitfirm155@gmail.com
From:   Susanne Klatten <zainabhussaini6771@gmail.com>
Date:   Fri, 8 Apr 2022 12:48:11 +0100
Message-ID: <CAGyfEaf_tW4dV3AX9u0=+Nd7ugoikz3wmu0=JATaC095XSETcw@mail.gmail.com>
Subject: =?UTF-8?B?UE/Fu1lDWktB?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,FUZZY_CREDIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: forbes.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:831 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1019]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [zainabhussaini6771[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [susannelegitfirm155[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [zainabhussaini6771[at]gmail.com]
        *  1.7 FUZZY_CREDIT BODY: Attempt to obfuscate words in spam
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=20
cze=C5=9B=C4=87

Nazywam si=C4=99 Susanne Klatten i jestem Z Niemiec, mog=C4=99 kontrolowa=
=C4=87 Twoje
problemy finansowe bez uciekania si=C4=99 do Bank=C3=B3w w zakresie Pieni=
=C4=85dze
Kredytowe. Oferujemy po=C5=BCyczki osobiste i

Po=C5=BCyczka biznesowa, jestem zatwierdzonym i certyfikowanym
po=C5=BCyczkodawc=C4=85 z wieloletnim do=C5=9Bwiadczeniem w udzielaniu po=
=C5=BCyczek i
udzielamy po=C5=BCyczek z zabezpieczeniem i bez zabezpieczenia w zakresie
od

2 000,00 =E2=82=AC ( $) do maksimum 500 000 000,00 =E2=82=AC ze sta=C5=82ym=
 oprocentowaniem
3% w stosunku rocznym. Czy potrzebujesz po=C5=BCyczki? Napisz do nas na:
susannelegitfirm155@gmail.com

  Mo=C5=BCesz r=C3=B3wnie=C5=BC zobaczy=C4=87 m=C3=B3j link i dowiedzie=C4=
=87 si=C4=99 wi=C4=99cej o mnie.

  https://en.wikipedia.org/wiki/Susanne_Klatten
  https://www.forbes.com/profile/susanne-klatten

  E-mail: susannelegitfirm155@gmail.com
  Podpis,
  Przewodnicz=C4=85cy Wykonawczy
  Susanne Klatten
