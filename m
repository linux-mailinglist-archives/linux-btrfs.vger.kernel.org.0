Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19B91DA72B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 03:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgETB1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 21:27:10 -0400
Received: from sonic301-19.consmr.mail.sg3.yahoo.com ([106.10.242.82]:43783
        "EHLO sonic301-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgETB1J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 21:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589938026; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=hAoYYTlG0orVDQrY7KEDxsvHRn+X7LD0mofKESx40pHJ5LMl/VFscFhgLssBRT/B0Hitlzogmvy+NcxbAwvdjkMohdG5zruYbL6iR9zIUlm/F9LPveYLhNZvyC7tSphMncmJfgl+evMdpNwG2oURikgUWGBcWL5tL5s/01J1GtxPJDSid3jtWHwk9ifPeCQCwy3mFtiAxl3d4WuYDsSSzx7ugoHwSoqPoxseGG/K0Fjppu0QXJicwK2dM05A8gf7qiX6+5BxLw01fmgbCOvGJD1ye+S0cDXBRSsNirh3TJPV0vTtVtkvhIssyANcAfaWCFgyc1uZrSENtK1L4IYggw==
X-YMail-OSG: O3VcDrkVM1knVeTe6rzGEOFvaIe6ppsKo6kKUiRJF9lGZGMioz0QSYKFOkpjL4J
 mqBvKuj5Fe7sHCO4c15TjPQI9D7cbvKhFQvZS8I0lzzCzo.NNU92.tP.T8i3rc9puZIJvT6PUCPR
 a.a48FI0es6JUAf2sQv2zzK3SlOdN9wYYU7JWmXZQJwy3dJP2TlbhyyTFKQ_.UdgOltDThFhi6ue
 8Yz680EmBLUt7Rk.K36fzZhchxlDET5gpqamt8klNhenkfOAsZ19z7_plr3h2pGs8P2RQvWgnBaY
 F_brH.4DjFRVHORbumBz.XDrwwKD11eQi_mB93YIuHMfzWDf_PdB7XAz.X_GZ0gMBFh4uf9ctI4n
 Na5cxhcvYT9UoWPPqP5tkYij6UVPGUzcMm2t8WGEPaoEGH.STriOT_r28N2Lj0sNdl2d.od636qY
 NEQya5s.esJHj9FEMCxrdH6gdV9fxK8JiAv8RSSXPMHtVZdDM5oAXaM8fv5p_GGCXvIKFERJ05XE
 krlPCWk7A2iDEleUh.SZPzYbbeNeK3QJ4GROajHdg561V4yeel7olL7kEkaRo7D.wkCmpGI1FFD6
 W_CrNT8WmR3euIfU.qKnN0fBJdIpREr2z6h7FzLiB9kH1pBX2AhIlBf_MKu_0fk0RB_4oBbrucI7
 of_U9N9Ae.dz9J9_pqOmitStKyJGkSKJOrJbkuzEaBKO3S4VyIyeR6HfSqqqa2TcR7AG4Vh8lc41
 RExdcgzWTUMXZcwoMiN_2mlIhm9avIb8nSZmkadhOynQGuJz9wvUGMMNXvJexU7uG_gP5Oql026u
 LYjo6itxamml5lSxbXA0wy35Puk_fH9iwLKMiRsXHaSehXJ8JSlP3Z8xtcc8H3uH58tl6yIYTm..
 Sq.seYNakdgZS95dYddo6G3fchpBRnRFza1tD9h6oyyQuXRPb4FbmUZvjuqslu5CL03QEyxYIVif
 _Cm8syqICr589e.U3rhfJFQ12eg6XQzVJFGOPtRoG1pMeaqlrTnLe2Cy7WStpZjdkIhTu6H6ATBP
 ItbyLqU7WQ65rxl250qnpMMzJemot93hgZCI5YruNwZlkfsjk73Oxc5YuqADUObVtaiS02PXSfKz
 TmX_BRiyetMWrAz4kwEYmePuqH48Qm90owfNUcGY0NQXyg5VZqB5lyJufAVeMM3d4u0feoi6vobR
 QdB3bMiQZAOG2u9r8yndSg0P_nvvKc1PaaYX36z.3wsZKjjCba2W6wrLjeqsnsYBYQk4BAcYunoz
 h0zwhPTNrqmSEkq8q0eoUHeMd6ljdtQjHWw_2tg6GkcQ6xGNJXt.ffb6WcXPnJ6x83CHJOnK6kgc
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Wed, 20 May 2020 01:27:06 +0000
Date:   Wed, 20 May 2020 01:27:01 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunel2@gmail.com>
Reply-To: smrsminaabrunel63@gmail.com
Message-ID: <2092666631.1251927.1589938021818@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2092666631.1251927.1589938021818.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
