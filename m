Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277E622531A
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgGSRhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 13:37:40 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com ([77.238.177.145]:38675
        "EHLO sonic314-19.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbgGSRhh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 13:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595180255; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=VIqVDPa58OIxE4a8kyoS2KJZmbjZQR8f4ukk3GBRkDOmYzNO+IQu5jQQ7lDugn+s1xgnwzZkhfqDsqutsor8cWJHCisOp4OOnnriG5HtxCGjL7MLn3dcMwIZ2uzynHNN59wuHvlyqH2NDnghGPVLu4krE1MJzV3oP5c08i3woWE5y0ziC5u/k3b+qv+Amasd9ONtD0WLpEfu9DG4do32nVzB8lOky8foXYukZa8n2P+7p7ljh3qNGFN6VuAHm4SOnL5/5y8OTvrGGsskQa5Sm+yUZ2NAO7E4lMJR9ryng2mXs/dKE1aulxaYdbGNxIHSMOyua/n/CbIkqbYTu9LdoQ==
X-YMail-OSG: WO9cObkVM1lEhsTFqB3LgqY.v.2B7qqZ4Ugrx9fBfVKvNdHW4KXthZ8vErUEpQv
 bVtJwDUO0nRBL70rL_RP9z2tsVEEWyVSwcAkf_CeSqGmcqBTF5VbDINJzS2xbfZQsL.Hl_VKMqeL
 bsWvlzCKB_LnTRAXUf_nyU9Pj9czvMUneVJO5ZxTE5T7r.ewGEmG5.7BfRZvauPgXC.KSUdxcK3.
 a_erOYfJYVZNxEiveP.ND01cKkea2SCDi3kYEfSPDAz72aYRtwkZGIB.Im5XHjkfy0QLoKqSbTj4
 IViUa8.GjatV3GlQiTC6n2fb54N4eVgJW3_v7W89gTNBR4tzE4uEqecXdYK7ftgAs1RFMlTnSS.X
 gMQaVhYxyaJtaj3n6rRS1_ZR2AD8rwyGbHXqSk0FzzWK43KSuvxWvPNPHWEbalT8UWTgSwyhimY7
 qAzrfhZPfHbVA9qzE34S5vR8rX0dyYBJSNf8WSp6AUI.SQSajwaBLL3jlt32Er3Zfz7N8hiIh7JS
 R43ubi9dSpb3mhqPlmhDLTZX7Y0dAtMxAjwU6ijaMNz4WT.WANV_MjPoOcDoIjY6DHpy3nI2OhX3
 3PxKJ4ZrVNDIyWV.jtsrI7A9tlG55IyjTmGkyHSGpISLsPUEApunm.yvxokw4nReu2.sy20LgEKz
 .o7IlzSku8sGPJjYMXT8KVLnddpxB8K4pc3jSJrc.HVmUys97giMz9Ge6mvEYsqhJpX21okkyVYr
 HSKSg5Ex1sBZCYsZtxiTXsii.nlHmN3DM3Wp0KsA614ibGMMTmvN7L01BZX4m11_K.aifI4qnMNX
 qSAskvtO5JTz5K.USibWD_dMVUYRBfthybuISy0unp3h5zctoIJBhFm4M8knEPNf8P1TvKFPeA1j
 r.5oj91HdVB7KQX0SUN06wHn7tTNbQDL85P5si7lS5cAdQfpj4TBN8gK9sKZI7zHVPBxGtgZraeq
 sY5BfS_27lE2P_0wJpqcZSlEeumI519v18E4wqo9.88HTnqOf6soathkMQWqEpUJoJtQcugLf1L2
 d2x4PJ9q8McwOr7k7U1ckkSR8yuyzWAz6mBpjwKMRA8Q5c8x4GGxt66LQ.06h7vMitb6gX7eDZNt
 UmIhg3YvlRYXhK2DOGqAliAukkrGNctRrbdf68iiy6c5Vc9akvhfcNEEvtcKKnK7yD7qEbw.QnHu
 QQzM0vhaPfvEuE9hWCCx2UpBX51m2l_xLAfOWstseUktrXyHNvt87AK_is5mlZBv5lZ9juvMmX1t
 Ou2oOiZ2VlHiB73Nc9V5G.BYkFf4tuNtNcZpJYX.SLbHDitzLWv0RkZUUcSddjpVdwpy59XwaEQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 19 Jul 2020 17:37:35 +0000
Date:   Sun, 19 Jul 2020 17:37:31 +0000 (UTC)
From:   "Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: mrsminaabrunel57044@gmail.com
Message-ID: <186376232.5922971.1595180251749@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <186376232.5922971.1595180251749.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36
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
