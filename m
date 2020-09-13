Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717C6267CFC
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Sep 2020 02:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgIMAkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Sep 2020 20:40:23 -0400
Received: from sonic301-20.consmr.mail.ir2.yahoo.com ([77.238.176.97]:45475
        "EHLO sonic301-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgIMAkV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Sep 2020 20:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599957618; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=r7OZmQhJJfJRexw3CfaX/Zjwz0vKTys2kXuUoOHi17NC926RqAlJ9GJSgzMs8zMKAUfJ26tjixHOc7P1asYcnqopKEz32/9ZKRir3ek/QUlu5KZDrCidzFDh76OHdVUtdBg//8FnczPMnxOyl4OraIEFTLvY2++mx1DAEbN+sn3nCoeUrivRfbP+KNt8yEKq1tDe25CMthIU+xAgweOuDlORKoDrdCMlzwWhMEwCKDc+uxB04uvAm0Sdat/iEIs0DQMmZueWhLBa1I++RcxAIxC60a1I7p5sU+zwNyA0jal681Q/XO9hOO1dad7OAr81ZGgeaoxySWFmGnGs+/gjEg==
X-YMail-OSG: lebp32AVM1ld5CR0Bh0tEyQAg5m7ZyNjXqGELkokEoSJrDm_t44rnW7Oz9mMOX3
 qQWrDrOtqON6XvfgiuTwKA_R4rBUCdG2uKVsj_5fK62fEdTfg2rBplyWc_G6jLimJu2UFXnf9mda
 eyHx9_E_x0oKbJdjm12z70OgZzhyPZfpfisRuHDXbpGj3kO1ukmYBW1RP8TIAgs3fTvW5MoOyWcJ
 c4EjfhIVs7lnhaoXo4fAjZWfr6cwcXSAGRAgGZCx3g3SZvC.rGQ06YNmwDoatzwvPd90Tsn07riC
 x90Ljy1rzxWDEIWZIcrCqqZi48.Copp3CcJnf61rV54uCMSWVwwa8Z6Ajq5B4EDRVRv2MtkuKs5y
 vATQOIaT0lLOrTeTfhCKnm5mFmUyjUbXNuBWWS8lsM9S3dpIAb8fWnrDGo1673i3Yh44AKlVr9mo
 O6TXgWX8TuKM50Ed1F19XfQDlr6Y49U6X5ZWCx0bPaEr4vYNJGClSDubyq9qBmsoeeIV8AifG7Ck
 ZLzkum0cRIgiF5gTJahD4J1C7edwQuZoephv5R5jPQeb18tc6hPLNLED9PDWy3hg2o7U3A03hC5t
 vmju7b5gsfidpMVbaVuLgTZuU3zL.Jy8Z9_KFRJyjFQVm4Mz3w1v9b_sK0GFWg8CB7nR95SDB3x6
 ru4R38m0gIv2j.4OzdyDCL1Vfm2rh4e.c_I3_vVBwkPJw906HvsaPQ9liilNj_taOcQ7od9PypYx
 3Oc8UMRdW4xUIX8SzwIMbAEvumJajua7r0H_1WZkOyZL1UBFyS74IkzoGizbV82yXKXm_jLYuNlz
 vVfl3G3ZSG0LKtZ6Z.dXK4UrAywBj9Rgoji8XOlmxYFEj0BHeCY8vjATFAgkQNkn38qlinRnPfJ1
 heKQUdCxKiO5UVaZc1tBDGorSmEWvRYRoy1MVkwHdiCgppbjJhsQDB8q69R5ot4jhFEEt5cFAsUu
 SYdsdB1qOwCHeDXGbar2RnMBHz8AYRfEliTAzDl1wD0Bp4bGEL3Jfn1KY23jtNoMKt7fIPO5Fxt2
 jFER4g8AXHS8V.70tPco.XXu.gseaQyAckDVjRj57oYAjeck0sIVX_tZFBADGuLVZSyB7iriWg_t
 .Ou3_CiT.OiycwwTXZWVsDog36gJi7gRsTPxcpBQHbV0QHzWpFcQhz0ARAsdq1rzq0mEamsN2hW4
 g2IAU3b8QEnpCorprFOMNrxfAWu5k2qdovTSSEeFP4d4OGCsD0V60gf5IIXgFi7t_yXwG9LVPXY6
 pRcu4NVfHIfl5VkQFtrMjgIc5rg1dAtJHiAWQ.9q1lWfW_LfiSgbwYknUTTiUp6NE2SO6kQlmHsi
 ZzYp3AunzPTbN1VCnMqiI_ROiScRMXbN9mJrxgwoIWZjAdRNyibJpSBkkIYFcn5PZBWwgHgM0fVE
 lXiWeTqmIv.iOva6Np.TwYuKXHmwoE18BIoy.9UYPFl93PgUs0zMjskU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 13 Sep 2020 00:40:18 +0000
Date:   Sun, 13 Sep 2020 00:40:14 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.minaaaliyahbrunel0001@gmail.com>
Reply-To: mrsminaabrunel@myself.com
Message-ID: <874177282.8721680.1599957614071@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <874177282.8721680.1599957614071.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politician who owns a small =
gold company in Burkina Faso; He died of Leprosy and Radesyge, in the year =
February 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Mi=
llion Euro) Eight million, Five hundred thousand Euros in a bank in Ouagado=
ugou the capital city of Burkina Faso in West Africa. The money was from th=
e sale of his company and death benefits payment and entitlements of my dec=
eased husband by his company.

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
