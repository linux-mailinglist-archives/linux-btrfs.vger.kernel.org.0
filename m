Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAFC1ECF96
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgFCMQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 08:16:12 -0400
Received: from sonic302-2.consmr.mail.bf2.yahoo.com ([74.6.135.41]:42536 "EHLO
        sonic302-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725859AbgFCMQM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 08:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591186570; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=gIcKU6kBi7FWPh8uuDQdtwWnFpKVD7h62XNnYzjILsNE+dwLPYxK7fkKyKUpHlBJ9aPYhQJrQWhrIa81JFnI5BosvSNOjik4F+6W8B9ixlt96NihwMElFtjSV47CjrjGH0aRwjegzu3mG+hOXnbcVKpV/n8OYaTaKZxu0yAU095a+IlkSdLdImNl2CQbXo5hbNL78GENinr5VwLM+oSTGpiGvWBzOeEpvcYKbq2fShxwWl6FCcZeOezGi36E0lT60mRuDRkk9YXYEL5baCTQVkrNUy0IHtZpdLgTi4rVZD3a3/DdHmysfFhAeARQ7Oq17vPlMw0KDWK1hsriflikuA==
X-YMail-OSG: io.Yk9IVM1ngZurFCTtf.wfwcoMzdQryrZ4l5gvatBuEnFVKsBnPD6tuH_FAUWX
 9x0zIAeAGwpUPGg2v42MHGLpI53MsW71Kza4bmg7OfCIdKvdeXyZr3NQB8e4CZN29YmuZ1EOSVup
 pwqjIgF6rTSmxPtaCj50tCnVR.R7MrcG0F61bjsA2RYueI6c1.wPSwG_S6WSYg7iHubEf3KFNy01
 2nuXQSCDTZYF_PdptRE1I7gQwhWG523VMKzHrmp90HCu9rjUPVF8WfGzIQHU8O.gMdh7tUhiRIgL
 hZ5QKuMrYYfvg23b2GJAWooSpkzOGfaSIk5_4nN3kAoPCEdGsM2iWbhYHkthrV.ME_EhB4u9fFac
 TvnhEvjwIp0Qvqtmc.x.a.TWcUt.mjnN7M.nWKXTR.vdZgzUAlziZVFqDP8YufxTOgbXhfW0DwWi
 sR7htWwZlP3iP906MIafDXWcU0uG4X_Go.Sa1QVyfMXzA2.VQf287LvngxmoLf6TZPqGdQYWhviX
 J4R4YCCwXhi7WuDTY2oi8t2J7kjUC2wdkZ8wMOfmHvnY0hnbT.qrw8wlSqNX5p0mQ.tk77YwqONm
 hyZXBDlokHosr1aDRj1j3bi0O_ThirKSHgrzRVpsLEv0lKNAwzdl91fCNOtfdxUdsl77DBcjG_de
 ktBQyUPl1byi_nz6grBxgTVN7kPhv3oGAlT.tPILspFBYw4LheCE_k0cra1DMH0aiLB9.xVKnS88
 e0b7PNBtJwlAvRq_VihsyuCuvzw8Fl4taDzxvBJ4NIFNomiph.h73BRF1UADBdfvJb9F0ei3_7sJ
 J.fmbw5VHFGHF471s8ZcbJoZIj2AGZ6lvD_nQmUrudkxYLNvyJFgrnJOdTWQBynOOUGXdipdAggi
 Tlo02cGyM7_PqUEFCZDHBXXfxMN4rEGUK7G3Xst6qYx0_xcoEAJa4bEW1H878i42H1UMYbVRqrXE
 8Dd2XvjC4JWSlWcXZTEOYfUcKoe1w2wuN1kK2fbKvljr9vpMhsnjnnkv.JQsa8s12.cqu0FP87A8
 xv_aZh4rL4TjIH3EAM_nARegQw4HTaI1XdiJ4MO.T_DkwMOMsOFNO7QaKfPGv84VT9.6DCsjJPCT
 QxSQKJESwOAOAhRwLSBSvZhynPGdmt8cSMlYWa.5eT5nyUNORY7fG.u0bqX08.EDr6R1XYyPG64U
 zq4nruep6Y0HyWGJpAiazF9I9z5j0.j4vzwQWm_ObIrlGwA4NisgXiRGpPRehHA5DcQE_zgicsap
 KkX9A.7RY.6BRZws0yrS3OUeComEwSz7vMEiL0UhcpF7gCyboh5vFxMOeAsp7I3VlpmDnGMMz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Wed, 3 Jun 2020 12:16:10 +0000
Date:   Wed, 3 Jun 2020 12:16:06 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunelm@gmail.com>
Reply-To: mrs.minaabrunel2021@aol.com
Message-ID: <1402604192.1378944.1591186566036@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1402604192.1378944.1591186566036.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0
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
