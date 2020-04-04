Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C39C919E69A
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgDDRNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 13:13:01 -0400
Received: from sonic311-14.consmr.mail.bf2.yahoo.com ([74.6.131.124]:42852
        "EHLO sonic311-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgDDRNA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Apr 2020 13:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586020380; bh=q1Er/SdqxATomBDx27mJAnsQxxrJWpCL+Y8MaW3053A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=SJXnHSYu2yZOWYqnAIpMDUX4J9ljmFVijx5fyP3yW87lseGsQSAZW+jBCshl5mdJ5aqGyGAQQ8hIrXr6xswHYtrslKDdr22VfirduJV6UOKVfQXvTl3QunPW0nhrMPKi+fiD8njvx3pHpQINMOxjM64YNs2zyFVmGzVx9cwDejZPQW9IcTDeI/E4OZwNHdlOCvfqW/5+OrlXpks7DwYOcyzntGIgRA7dZN9SJJUiQzH/pkhQ3F/H4X8OYiUhjOR07X3lIlGXUkHVYcadgnhYRu1ug6JFoRSck5pl8JSIyBU6fuRTXyU5W9wKRTFHzxrN4XISIE70kdPIp4iDjvh3gw==
X-YMail-OSG: hRfC0MIVM1kYJguK_SDfGijlTBzNDQ9Sabf3zf_nedhodi8JsLif4fZsebqIulI
 lF05oXetWYMfNNHD5BrjeBy8CqwJa518aA7.6RUCF5cEwhQXlKFtQWBCYgyGupAZPkg.QrRRbGdC
 KVhUADVgjkqe582PdYuAGb1PAWewCDfdWsQWgQXF3mHrzNHP88c.yCoULYr5FOnHDQ8_nCniuPLI
 SnE2mdEI_PRibRvljM.u2N10_3TBNbtoEmlt5ClnrK1ooCVjUDi66zod_VmjWzB8E3TeVO2sbdZU
 yHPQ9MOJuaPGaTaySvyzW69sbdkt7JIsZqav32FOkKvHuqWWzIv6Lg.Om.icJTRCUE.LcNZLVYyU
 8.NusUzWBoVhqXsVPAkfUjiqJuLd4DLvoJ4yF1XXzKIl2J03A2Dp0NojT0.bnVWSXQZadfmvNdUo
 xP1BUQzxspfoVk8HW0GO5AJkG49xFgL6sAPIIxQ_olrNj9ZSKKDImwXO9ZJCk2xGgnqNN.FQZ8Xy
 gkW.dEbb1880vZtVD3g4dYoJRwS21Gk3zDH_OIsCWaxkB9XenrfpfE4p69eBvIz981kksOk2KQ0b
 aAJmbjT1GQmcY5XY5gdru8VYpH8wdgQidEJjZ65auTpewlG..RWgpNB6IG2LcW5cvvh98w06nSRm
 E2ijytmKKY3ke5kFez_i8A0lo.gqMpsfweYf_yYO6tlxNK2Tas1esTMBlZ8dJGQ1pxzBsoXcVi4B
 3tPD5b_udLBuTKLdoIF2AVKZ3ozFxzVk7BsNgYVD8DN3liZ6RoUHn1GPwuJSdHbx0v71reczpoW.
 puatUOe.3i3XEWRhI08ji3mXd37U1HoBXVz7N..wEpm8T6VfCII20w4mJDTt7ToSORqtZcqZB2BQ
 Bp.OoV7WpJFe.ZxZgQapZ4poOj5wYHD9DG3.2ok2VDKygyO.MiVhMZSnMlcwkjWGxlId7pxnnkj4
 HL4HMwWvRmG_5t5Xarr2T7cey7YDO8YveMaJ458_c1nibri9jfqqQI9TCCnYLffLIm1qKStUo89r
 NMWuaTGGJV2Ua6ZeZf8rMA4RBEg2oprnfCRXix2aii_FHu5waLqUPAXha2oTKEQaFvFIjPIPCyCW
 tDRRE7GWUYva4bT.6o6uMqp6dh1S_EQQy82KixNUuqgfO0gaFIBdTE0LWRJ9.Qh2qMFk3QgRgiiv
 n0lhF.D9pKoMeT1jnhUEd09R1xKBsH1T3kjyFDpT0JZz.sd0VKDXwOuhBkqBxkGja_Rukw3FNl91
 tXhZ5UtwMpe_RPz0ssb2sNdxhz1RDQcj1O6A4V3S6tWUZX52JYiqfSXZpf77Jpj.MPVMVx8xfweg
 ca0UH
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Sat, 4 Apr 2020 17:13:00 +0000
Date:   Sat, 4 Apr 2020 17:12:57 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.mainaabrunel126@gmail.com>
Reply-To: mrs.minaabrunel30@gmail.com
Message-ID: <655584886.332579.1586020377266@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <655584886.332579.1586020377266.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15620 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:74.0) Gecko/20100101 Firefox/74.0
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
