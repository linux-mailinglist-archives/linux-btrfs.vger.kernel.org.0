Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1176D1A9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjCaImz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Mar 2023 04:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjCaImk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Mar 2023 04:42:40 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B41BF77
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 01:42:09 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id p2so15665477uap.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680252081;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DfFzcqNBHwwSPeX+4jgdL5Lyf2r9GSzgk6P3plmcNk4=;
        b=HdJOjkx1Piqjgk+TQN8GnmyrX7WD0y937YwYa6Bah1XQNeKQXEHh0HGZv4ZCsN4Hq0
         +18X4ToKK6k2Zpn+st6W8U6M9lPIb6T8XIf3Jin+ZyQ48uTaJRCjy5RguVQXvrdXiGAH
         wlYVDcaGl5IacjYRL1KxBpuTzukJ7Azbp0OiejlPXR08TZloMMXW7f1h6+xF77hqjqYg
         TlpQSRZjHsF+c2fyZleSpG3c7YplAQBgUzrahBDWcb465XFaWqYBGT5XKpgONwuT80jb
         +g2H+ZK8cXI/ur1QOhHNawk8PfmJWJ63bsM6BbxYUNGOvqLMSFLFhQky2bRw/LVEcLWU
         Weqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680252081;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfFzcqNBHwwSPeX+4jgdL5Lyf2r9GSzgk6P3plmcNk4=;
        b=vbc+7agmcqMHqMha/7EyEtr7HzY6C9WNrfcWr7lrhmphLokIAnce3K8oBJCMQrf0WQ
         5LrfUam33ybqL/LByJ4I5FB/7bq5MLH9+51uUTWlkRs0i+wpLSnpZhGuF4cTKtqBCBb3
         DDBg/TzuGnrJD8/BM0Rh9DcOs4l62l8z4hXsPylj7LBkMbQ5zPz7Fp+oDh15HxoDSqtP
         JRl+ih9V6eJBOcn+6CvwhOsZ4KCjcsTYqiiCTvUOseM9fG4dO2YFEwDalA4kH2PUbmR6
         oG1MFUMLROxQptNuWtxVsK5GagQJlLp3pN/gQHxMvrKuzE9AlV/sKeQBrSSz4VHG2C9G
         XIAw==
X-Gm-Message-State: AAQBX9ef2MTS+FuZxWFVZsryiZKrH73vEc+l17SRFqqUyEM/Ca9d9r90
        CYEA8FcdDr4zQ4vXnvKcGZKx1yp6qCWN7xNU3wY=
X-Google-Smtp-Source: AKy350bVzjbFgP7PTWDIzL8KfqRnedSpizcfflc28lGR1u3oRTltnHM61HcsZWvhxfmEPV28Y4syEjzve6G97LLhIoc=
X-Received: by 2002:a1f:9043:0:b0:433:7ae0:6045 with SMTP id
 s64-20020a1f9043000000b004337ae06045mr14183346vkd.0.1680252080637; Fri, 31
 Mar 2023 01:41:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7c58:0:b0:6a3:99db:b5ec with HTTP; Fri, 31 Mar 2023
 01:41:20 -0700 (PDT)
From:   "Mr.Robert K. Tripp" <mo7250231@gmail.com>
Date:   Fri, 31 Mar 2023 08:41:20 +0000
Message-ID: <CABi_HMkr3_ttiRHbECxdVQibBrhYKBXe=QBF+w9xvSRC3-DqZQ@mail.gmail.com>
Subject: Greetings To you Beneficiary
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PION PRZEST=C4=98PSTW ANTYTERRORYSTYCZNYCH I MONITORINGU
J. EDGAR HOOVER BUDYNEK 935 PENNSYLVANIA AVENUE,
WASZYNGTON, DC. 20535-0001



Kontaktuj=C4=99 si=C4=99 z Tob=C4=85 za po=C5=9Brednictwem poczty elektroni=
cznej, poniewa=C5=BC
uwa=C5=BCam, =C5=BCe najlepiej i wygodniej b=C4=99dzie mi wyja=C5=9Bni=C4=
=87, dlaczego si=C4=99 z
Tob=C4=85 kontaktuj=C4=99.

Nazywam si=C4=99 agent specjalny Robert K. Tripp, Stany Zjednoczone Nowo
mianowany =C5=9Bledczy FBI ds. oszustw. Pracuj=C4=99 rami=C4=99 w rami=C4=
=99 z ameryka=C5=84sk=C4=85
jednostk=C4=85 ds. oszustw Wydzia=C5=82u Dochodze=C5=84 Kryminalnych (CID).

Specjalizuj=C4=99 si=C4=99 w dochodzeniach w sprawie niewyp=C5=82aconych fu=
nduszy,
kt=C3=B3re obejmuj=C4=85 FUNDUSZE ODSZKODOWANIA/DZIEDZICZENIA, Email Lotto=
=C2=AE
Lottery JACKPOT ] i zauwa=C5=BCyli=C5=9Bmy, =C5=BCe otrzymujesz wiele e-mai=
li od
os=C3=B3b, kt=C3=B3re twierdz=C4=85, =C5=BCe maj=C4=85 do Ciebie fundusze, =
ale radz=C4=99, je=C5=9Bli
nadal komunikujesz si=C4=99 z kt=C3=B3rymkolwiek z nich w sprawie funduszy,
jednak niniejszym radzimy przerwa=C4=87 wszelk=C4=85 komunikacj=C4=99, poni=
ewa=C5=BC osoby
te zosta=C5=82y zbadane i potwierdzone, =C5=BCe s=C4=85 oszustami.

Pragn=C4=99 og=C5=82osi=C4=87, =C5=BCe dochodzenie, kt=C3=B3re przeprowadzi=
li=C5=9Bmy kilka dni
temu, zako=C5=84czy=C5=82o si=C4=99 sukcesem; My=C5=9Bl=C4=99, =C5=BCe zain=
teresuje ci=C4=99, dlaczego
przeprowadzono to =C5=9Bledztwo. Dla twojej informacji, naprawd=C4=99
potwierdzono, =C5=BCe masz w 100% legaln=C4=85 i legaln=C4=85 niezap=C5=82a=
con=C4=85 transakcj=C4=99
na twoje nazwisko w systemie Banku =C5=9Awiatowego i masz pe=C5=82ne prawo
ubiega=C4=87 si=C4=99 o te =C5=9Brodki, poniewa=C5=BC potwierdzono, =C5=BCe=
 jeste=C5=9B w=C5=82a=C5=9Bciwym
Beneficjentem wspomnianej kwoty 2,5 USD Milion, kt=C3=B3ry zosta=C5=82
upowa=C5=BCniony do wyp=C5=82acenia Ci bez =C5=BCadnych op=C3=B3=C5=BAnie=
=C5=84 przez Biuro
Prezydenta tutaj w Stanach Zjednoczonych (USA) po naszej weryfikacji i
upewnieniu si=C4=99, =C5=BCe jeste=C5=9B prawdziwym w=C5=82a=C5=9Bcicielem =
=C5=9Brodk=C3=B3w, Ze wzgl=C4=99du
na op=C3=B3=C5=BAnienie w otrzymaniu tych =C5=9Brodk=C3=B3w , Twoje =C5=9Br=
odki w wysoko=C5=9Bci 2,5
miliona USD zosta=C5=82y zatwierdzone do wyp=C5=82aty.

Zdecydowa=C5=82em si=C4=99 pom=C3=B3c w uzyskaniu =C5=9Brodk=C3=B3w bezpo=
=C5=9Brednio z Federalnego
Biura =C5=9Aledczego Stan=C3=B3w Zjednoczonych (FBI). Chc=C4=99 wiedzie=C4=
=87, czy jeste=C5=9B
zainteresowany otrzymaniem niezap=C5=82aconych, uzasadnionych =C5=9Brodk=C3=
=B3w o
warto=C5=9Bci 2,5 miliona USD, radz=C4=99 natychmiast si=C4=99 ze mn=C4=85 =
skontaktowa=C4=87.
Potrzebuj=C4=99 tylko Waszej wsp=C3=B3=C5=82pracy i zrozumienia.

Skontaktowali=C5=9Bmy si=C4=99 z SANTANDER BANK w Wielkiej Brytanii ( UK ) =
w
celu przetworzenia Twojego funduszu za pomoc=C4=85 przelewu bankowego.
Pieni=C4=85dze zostan=C4=85 przelane bezpo=C5=9Brednio na Twoje konto.

Nazwisko re=C5=BCysera =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Nathan Mark Bostock
Adres e-mail =3D=3D=3D=3D=3D=3Dsantanderbank@consultant.com
Santander Bank w Wielkiej Brytanii (Wielka Brytania)

Nie wahaj si=C4=99 natychmiast skontaktowa=C4=87 z bankiem zgodnie z powy=
=C5=BCszymi
wskaz=C3=B3wkami, aby przela=C4=87 pieni=C4=85dze bez =C5=BCadnych op=C3=B3=
=C5=BAnie=C5=84 Wy=C5=9Blij mu
informacje o swoim koncie bankowym poni=C5=BCej, aby mogli przela=C4=87 ca=
=C5=82=C4=85
kwot=C4=99 =C5=9Brodk=C3=B3w

1. Nazwa beneficjenta=3D=3D=3D=3D=3D=3D=3D=3D?
2. Numer konta=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D?
3. Nazwa banku=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D?
4. Adres banku
5. Kraj=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D?
6. Numer telefonu=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D?
7. Numer IBAN=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D?
8. Dow=C3=B3d osobisty=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D?
9. Tw=C3=B3j zaw=C3=B3d=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D?
10. Wiek=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D?
11. P=C5=82e=C4=87=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D?

Dzi=C4=99ki
Tw=C3=B3j w us=C5=82ugach
Agent Pan Robert K. Tripp
Stany Zjednoczone (USA) Nowy mianowany =C5=9Bledczy FBI ds. oszustw
