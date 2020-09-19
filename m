Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816152710B4
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Sep 2020 23:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgISVss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Sep 2020 17:48:48 -0400
Received: from sonic312-21.consmr.mail.bf2.yahoo.com ([74.6.128.83]:42817 "EHLO
        sonic312-21.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726617AbgISVss (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Sep 2020 17:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600552127; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=gA5sHVNo3YlIRWzEVOmA9fsYnPWFxldrQEIr5GNvNEnrOYD74/qcdFsBK7sYGRtBA8rH9AfDdoM7LHH+aLI/xbTBllBznDXXUiyRyr6tqvywjRT3wbth81zsUSzxEzdq6nOhgqj7jrKT7pP9zB2/Nw7UKKQ5yuAPz8DTskBER+KouOIlFf4JOV2sBhtlBPVRz8wK2dKAgzCmD6B83ThB4+D4rtygPRIjwFIsIxLLw5zGurAmg+d3+PtETlTiM4h+JUPMfE9XzYT3vx1/nTdyB1Aq0NPp9EsCnNCS5MnDGpWv9+qp6VigsZr7TMSyEFjiuJOENmZBSqgk75sUryMTJQ==
X-YMail-OSG: oPGC9u4VM1lZSkFtRvZbOcT4FwTtUOQMkhW4gQLfh_9G9x8VTw6lf21PoWTLE7Q
 xGdQjs8cluEopbzVozcPZs8EWehEyHMKFCMLfjNZf3pkx19g125QEqToc.hRmNrjXSxVy94qTOVn
 yIM95ZhuNzdVjTQ5NPBNPIzvG9HoPldXqHkjI_E0S8pp0X8XC3RdfSc4n19CHbzDYpSrR.WLgZhz
 8wLDAhH_1fD_1X.sstpN69r_3RYJpzPS8C4JxFLj79Rxgmr8jiXcM4eZHfDeEkVjB3_50JBsC3WS
 NKdIjHWlXZyXvDeHPp9DL4Q3fymLQ1N_2DK5lX397WoL8NbbgE6CYaFTlKQpf.HtFt6gLS0kqZoj
 H.xtbTzmpR4ugewMxDYP_AmFTbwiVEYWePS1PUK7E2OjTISlxct7QgVYjl0ObCjPWyxexwBL1D4l
 GEHQim2Ljol3Q3jFj8mK1rEgyTVpXEol0DpCpoIK4cIWf38mY8m0lAaNncZZW_KHAGYnVu1jUmF3
 1kBIzjrWDl9DDs06_mZt0yXVhqb2PkBYP12iSTxZhczimYd1tEuBrt4sbVNbEP_a0PjpvS6u0f_Z
 WvULonsssdjXCOc8lnqMGNbIsm_JHtS6.DgFu_UbXhUD3Bq7MmM8JHDfd10VBVtieNQ3jiAw11Zt
 miIU_j_CKLjw4TiodL5bygpKpkhABC_ribdtkc19t5.HJ0SJh.0cMux_FYjxuKncbT7d4DJNsqx_
 RkbM6YJCbJxuWX9BuihR1GlHXgjQu6lbV4_CGMeYnWimkUANWd1v2a75x46OBP2Umx31t2kegz.9
 gZ9Z4yWPa6tCdi2OYJEWNmGByKxR0MEUjqq4HXLx1_82bqzolim2buYcs8Eg6RQn3J7oa0ck9Cx3
 kOJAk8JlPH8EKd7TdwO5VOFNpK9BB5g98WHEdzRhpPhWIXDMe4AlxD3fyQtVNwdz81TNI11c5Sg3
 .DI7.7ww4spOQFq3ZDoDwKVDEQeJ5jXLu6eigJpDW_I9zKHKyXnHtElmps0HSlZb5yYZ0OlwglXZ
 eRQOLLuQt610EJD9vrcs6cK_c9i6lhQRwRuVDHtYuMWhyZ9ciXq1Cuu_umiCRlhIqM2TRtaN8vfV
 REIJPZNauS3l7Rr3Udbs5JT1fyMd9gV.V3WAmymPQJOeiMswROVAkfvY3wQuPltXY4JruqYtf_va
 RcQHGsegdJhgi3qndLtnPGwdDLnltGL7C1mFlEifaXoZhGotRNmtFF7HCtYTOPcoEVv2Oo23aSCA
 kQ..6DgaQbTqhFEL6G6VUbzPaF45oj7pgZ03lLmr7HMg7Vc7H.VtitUZP0KRJGuh4KyRffP79WP7
 Sv_nk..ADb0iLKz2Pia6dz1r0kZ7hnhpvURUupnOZw_b7gO2LMnX838yQuINwnPbJJbRvfWYt1C2
 KTlIO7njnyYJerozcnZlc_2l_aZH33iFLOwoUm9doIyvuUpUdFoezIEFn
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Sat, 19 Sep 2020 21:48:47 +0000
Date:   Sat, 19 Sep 2020 21:48:46 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <minaabrunel43@gmail.com>
Reply-To: mrsminaabrunel36@gmail.com
Message-ID: <1356144648.3960096.1600552126190@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1356144648.3960096.1600552126190.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
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
