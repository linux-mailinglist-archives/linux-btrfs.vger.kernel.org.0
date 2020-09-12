Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A237267BDC
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Sep 2020 21:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgILTHv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Sep 2020 15:07:51 -0400
Received: from sonic305-2.consmr.mail.bf2.yahoo.com ([74.6.133.41]:41950 "EHLO
        sonic305-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgILTHt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Sep 2020 15:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599937668; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=R5NM2QP1TgUL8GMSmfc3vofbumHSzF/TJYXsvTrN0612QpU41LSLuXz7JTkEJWb2MCXHMO5fLynJFHsa6akZaSzyA/dQV4lzkWXIHyDwuU6bcyCu6eqk0Uoa2BBCHkZjNqmqamVVR3a52+uqsCzp412W9ESbdt2t5HJ2JWptmZDRuJ/YedA6rylfXP2vD0nOSjV3f9SykKqfqPjHO6gCCyikHh3gta16vbn96uPYBHkP0iSPviRqsz3ftws/O2AOo/p7lgx3WFP33+CfiKTALwb1eu0PArN1eQn1WqBqpAg9e0dz8sGAJMaj0U8pEHT5CtMDDMxPvjkpuf+rlzhEwQ==
X-YMail-OSG: ZnvdTcwVM1mrD6zjyf_ebbiYFaU6keGBmeNmbb_eGxgbN4SsDT_ECPZceWGDPXV
 UVZ7MC8iIN4LUTp8z3hAmwQQhXkQxYqsEZgEjW6gYNuEdk2eZVAEZjh.1jvllz4EK6kmVw7UpC1s
 NHc1JvWK_93WI6FSk2pPRbOXYwXyHzNkDrc_urlCPc6TbXOWyUYmU9TzaKn08imGKBAgvlMPJYrp
 yhnaHrekpqss1EB2nEg5ohAkrBHpdJ1hyC21aJsvayFdQRdhY_ITjXpE97tXD2umO9qc9iBM3_KP
 3lLJyzCo0zOIZB.PYlZLuKYH02Id5cCCMMdOc18rMl1aVokfiiBpo4og4YN.vxk0GK1anYzFukyR
 Rk8A7ZrH1gdFRDiKLxltzII2ZlcqXcQRiCvm6eArTiT__Tliufop4nH3iOp4nRU_O_z1oX7oDkGX
 fHJz9PYPC4jggybPw1K.mS2T5y12r8SXIplgbK3G_IiCDnvvqMhVmwy.5hKJ5C7LIvBs3HzrrUoj
 lNbjrgT2R3_HR8ivzrmVIAcyB757rHgkOYqDSAiozzvDwmYGxYVvHhCYGP26pc5qgitJFtGbGcOO
 kU7YAEvZWPzdnovZiBtnUOCD51j0GBFjD3y_q_Bb9NSeS5Yv0ADZsSSAfQDCwr8PPyaYAh0AwneI
 x6xSiiGOMHLcneTgubs5o9SZ11Q_nB74QvnuZjciA2U6TAYDr8T1JcQXa3RVwlv54T7lCaKPMayu
 dxe9fFKSP9R_ByRkjlhp8zt8cL3wyAQ6IZMer91_r10KLAdS0_KzqQyX9CqG9wpzBHyeLHzzZT7w
 yCXYIMls.zGFaiXMqoej1Vvu97Qi3bX9DeHUVqb_.Zqsp5EEPUDXzZRvCP9MKJTSM.e6ahLm6NPv
 0RQAD1ybBWAy9sc9ICc2lpV9Dvt7FcRupRVWwFdqnKC7t18n4pZqw__lzOAwDvGIKYeuMtrENnWP
 Irrt.o3l84bPcOxHL1nYGSjEbX6A2eZ88oLw7XDdSzCG6BLHz1kA53bDQdj15KDOjOGpkM86_j65
 unXz0vA5MCaEEmXAIcoe6cApzIk306vemTpLL1QOk2fq06sulf_cwYkCvBOT7XfD5anVIzBngW82
 HNe0asPsPnxbWUD4FnacZaU9ooXP6b1ob1E2RVj_DHNA7aMz7QJcMRAxZQ4YctUJ5BR85xReexrI
 5P98rIswWqcW0KoqmhKnrbl3dEmcVwoCRd7vP1jNJC9gS.O6kV1KV7I3iuKt2JA5SEx.bEaP5CYc
 HE0ysoAdN.KalUfy4AzZhhSB6xrln4aV3sEoKZbGZtqQb9ISEtW4e9UVPyH6w5nHzU.CxjV2YWLS
 N0mIGDZV.7JjdOziGc7rbegZbqemRNSfFk1S8MMT0APgrmh0OvZ.lXoW8qEIK9dD9LVDSNKkbKpC
 zNJZoGVGwU116tae97HK4i8MMJ3UDOY8zoTrd2yy.gnTzvCOFs9TW8DA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 12 Sep 2020 19:07:48 +0000
Date:   Sat, 12 Sep 2020 19:07:36 +0000 (UTC)
From:   "Mrs. Mina A, Brunel" <mrs.minaaaliyahbrunel216@gmail.com>
Reply-To: mrs.minaaaliyahbrunel31@gmail.com
Message-ID: <1818263650.1465011.1599937656272@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1818263650.1465011.1599937656272.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0
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
