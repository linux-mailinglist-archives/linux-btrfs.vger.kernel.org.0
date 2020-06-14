Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6286B1F871E
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jun 2020 07:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgFNFGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jun 2020 01:06:07 -0400
Received: from sonic307-3.consmr.mail.bf2.yahoo.com ([74.6.134.42]:33309 "EHLO
        sonic307-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbgFNFGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jun 2020 01:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592111165; bh=Sq0m1vvm2SZTihycyLIp46MmEaT+M4u+5ZuM67ujUHw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=tqOuEA2ZFkyiO5sAPpFSACFYInwAo8ss+8AVdTzJlw8kkA+GP+776EgmTLapp7cXxtRdP1sgcHSfjF5Mwegg+qqC/IPz3e/iVgIoQC7QE8LgBVSi7xc4Y3CGjfkxWzdJKpRlrTVfjeh4EPIU9G+WDfzNvcYAaGJSDCgfCwl/L1lSrkjVz+7y2EeZ6NjA56Cx/bqPkmBh9OkPh1iQpczP+IcJbaoGLsnzwDr8OFSa+EWudIHUtJeR0qa/Di21EVj/ty7/i5UEW8JL5P53xn6rV70+Dcleyj9RVfu3Z/ws3To6d1FDfcJtOLAnDDlmzzyiUN0C+wE4jR1PjNjOSdBOSg==
X-YMail-OSG: 0WG6dAAVM1lFxwwmLZ6maYeZof9IjfM6dBMxOfxJ1rlFx6Ux0mIqpVvpF1Gcp4R
 wH9E7pIRBS3MKJVOUaTp9eMRB7yuL5_w09sXVHUx5DviYUOUXoqfYTKavnCKBDwpw3bx_zYGbVBx
 Ye8Ik5n_C8wKQrl_oMa1I72cFdeK0VcW4Zv2kWAjOMr1UMxzZQESOrLXcR9lnO.BuLZUp9SOGiV_
 IwdcAr.RnFwaW4hW.PBn9q73kwDMXylIKOUHItcfv9wCXwB9pMY0J7y7VtDAP0g6Rlc_KmIZp_IW
 kz.NAGCgWuYZy7FkMdyKSIe8iD_Cx7lio3F773CZemiMdJR15QkoWKm17QYX_v06r18BP9Ji9P.E
 ans7U4TOzsorT9ZzCK1lsOq6Ja9YuQiXePjn.VieIHt7.zTPAfwKzEY0sErdbm4lyEF8DgDF6vvQ
 LrdeYw9JD_GIe_eMZfG4_fsdVlZ9o9KQOp3.S_38rPjvT.ixD8ekIEhV8yH8tLRrO44TKMFtSi5w
 b.ny0PZ_RtXmwIgkcEMDf0Oe4tT29PGA.gOlRE6xBPCK.Ii78GWhCKkFlvNGh5QjmTVdm4k_Awqw
 zDmqxvgmEhK296cDM_u2zV7ZhTlL3O2FyncpLX1EpiHUljRkhe.IzF_DmXJRfXQ6ogW5Dt9z5B.P
 xP_Lfs8GJrkCEcgG3ZuM9URD.Nf99Zmu9Y2GrDH1mn2r447tpQHeSAACj.hpohe2QJEylN4dwPGQ
 NxFeUdFP1Zhp.R.CXUJcORsgvAI.evuS8czyHeWgARwbl183esS6XyGSSw69QLCSf31uS1TFFCBF
 LPDRs5cbKJgnERa7bqUmNDP5OZVIaMg18.n1XsE6Iqgq8X2Btt.9mF.STdpZXbllJL7Q3i_aUAgu
 W3O2qiZZjgAp86x9wkxXcbiYRqrG1l2IzGA3WwN48NquaozJBwAar0abeJt0YTQUIltI2Xws_4ob
 YSomhSfh2Dg8.l5joAlBPu1N9WYSG083u6wISzadOdb_7LNGY1VYqRBaDAqTaRGJGFKKZ5M6yMua
 FYfxrxb3TI4wXhRQqx7V5X_qNYJ0RDON28DuKu1tpuVYuTXxJIVB8RllRzm8dTmwRzZzaRtNGjKu
 XhZXKqFuXatcSgIo6Gtn6vGEFGl59OjhSi82m3dyOWZ2fXvpbrJr5iIkYlVYpjc.JkRHnB2swywU
 0qgDV.DyupAEyDpz3Nkrjhr7WKCIDjlL.Y6dXKuTyyIf.MfJh1PQ8Gx3vfIemBgUaSJ6sFSDWNpq
 MioTGHrHEiTwBX11Bvir4nbTSRnPZeQETHbWHV_Z6hxXdDfaco7Rn8c3WW5Q.FW1Pe7GBrA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Sun, 14 Jun 2020 05:06:05 +0000
Date:   Sun, 14 Jun 2020 05:06:03 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <annahbruun6@gmail.com>
Reply-To: mrsminaabrunel63@gmail.com
Message-ID: <1277630289.354182.1592111163514@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1277630289.354182.1592111163514.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16119 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36
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
on Euro) Eight million, Five hundred thousand Euros in a bank in Rome the c=
apital city of Italy in Southern Europe. The money was from the sale of his=
 company and death benefits payment and entitlements of my deceased husband=
 by his company.

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
