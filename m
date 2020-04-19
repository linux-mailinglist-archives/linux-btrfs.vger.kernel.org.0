Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57E1AFE3E
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Apr 2020 22:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDSU4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Apr 2020 16:56:14 -0400
Received: from sonic305-3.consmr.mail.bf2.yahoo.com ([74.6.133.42]:37421 "EHLO
        sonic305-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgDSU4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Apr 2020 16:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587329772; bh=q1Er/SdqxATomBDx27mJAnsQxxrJWpCL+Y8MaW3053A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=tHyTde+3+3uaznQtYcXqicn/j29cXPCPqmyC5L2Rqpb6J2MyZT2NH+nytlTZe/N3+fPZ5fkZ28IceuEGRE+xEobjDao/O9DREO6lJ//poofWQkC+AuUqTb7VMe5epHvyXY4ihjmY/UCVAoJQAQRu5Lf292Z7gOTQxinEEIXejIU4QZjtRQkRzAYYPkwmqjaYDQJfld8zSTpQTOtnqNWxtHgeYLkWMNnYSxIRGtZGKe9EP34PB3vJR7y+BjYCFMkV6QGpNrDwXJWtQ4/W0858h3U4KZAh9ORuNlXw2jKkqCdaL5re4pBVsPkQyif651D4Wf1xp71Q0SrFccv/FIZDsA==
X-YMail-OSG: CoaqYOoVM1nxq5wSi3YbLd4C2TaWBuNpS27FlFzk1OB217IhmU.df7r26_6Aqmp
 ZFuVv3PHfdTScdhaiRb.Ojtv5nIQVMckRknzGmjKdfVoOTWO410e1Ndhk5YeML1uDHZQ4MohKApQ
 bVvKTVsq6AqONjfVTEM9ijy8U7CmrkmIdQnWuLu1gifbIj_8kvs0Ghkb4F3YdQyXwGq9p6TtwDTn
 _6KOqFf2oghhXjU3emCZrDPyuCcaPmqgI_tRL4uLQJdWA5fR_kMinIEpN6EVBL5Ug19wG1IevHOs
 k4D.qjkM8hacO6ZlU_cKmOqHXlcgfHqLvgUFuCCpacMYSii6bjSBBJP26QYPNNETSKGB_C_KSP0s
 g_4dAM0RFsSS2uPSnFUOxYT60kQ7lb74RADfyA4FajW3plrZItmS8dpL9if82jFgn6qvP7TJaID.
 fo4xUfoR_nnSzgJQjtKYRUHOq8Do6kUVFj9UeIsGVrcaBuLOl_R_KIkDWhjdoIewYGi.ZG5gYOt8
 qT3wHt7pQt7dBZk_uLqPurU8sGcuxH_JGDsyXOErM.Q0q7Io_MDLALeXgCWdjuCnzi3gISLVpOTE
 PVUcT0WfXSQrjrfszH0zPOXxfG20ex7aLOINO7KsuapJw8QMTjV85muDfP.FAmr6h45otHZqT6N6
 e_6JU6wg7Lpz3D2wR9lo35jgzIdtFPOhi43jycuyfd47GJ67ab5_hTW7684tc4kct0MIwREtE0N0
 qG.Z6RRLUCSb6oa_VOi4Rz386pMFzVHMdIxdB.dAPQuQQucXd6TlPFEjL8VJ9Urnx8gHDokcwKjB
 yZKIHP7oyeMixB6b2UT.ralbIe93QonVsLANTxBnA0MX1dd6fkeYh3cmTWS04uWToCD8B0eLU2cu
 rNKPkkhQwjNVdgCl7fTaRE_Fg_fLgrFLbCb4N26gw5BiTymphpV.mg4VK6exM8nOmmYQOCHQT_h1
 KVergKtIFm6FYhZXqm3SpQkhJwbgVBgn4wahaHwSrXEa0DrHMwU.VIzWtLQR.Un8oMiFM_DKKaEc
 JOxQ25rlufP9AXw9YPm9v5oSoft4rQKI5ZhQX3euEJV6d273YP.71zDsOb7Das4kXRGpbQKJ2EC9
 Y1zKf6r1F6Td4j.Gq_f5aTNzz1m73at21Rka_T_0Xy8nU0nJnN6HRS4Ykr5cWfJUo_sA0s2nK7CQ
 PZlS2QoWPUgB58pNJu9rfP7a_I1xXAybgbbfNyRzKDKnku.odW8sqYHlPjnNel2eNP_pvMygoHjW
 PNAxH_dcTnEcYIkIm7tRekSNGk257JOWM.7v2X87TWwNQRdOQrpiYM7Pc6M160JdK87M7pCVaKnV
 Y
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sun, 19 Apr 2020 20:56:12 +0000
Date:   Sun, 19 Apr 2020 20:56:10 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.minaabrunel209@gmail.com>
Reply-To: mrs.minaabrunel2021@aol.com
Message-ID: <750112310.2114577.1587329770804@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <750112310.2114577.1587329770804.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15651 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0
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
llion Euro) Eight million, Five hundred thousand Euros in a bank in Rome th=
e capital city of Italy in Southern Europe. The money was from the sale of =
his company and death benefits payment and entitlements of my deceased husb=
and by his company.

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
