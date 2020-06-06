Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8736F1F08F1
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 00:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgFFW1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jun 2020 18:27:02 -0400
Received: from sonic305-3.consmr.mail.bf2.yahoo.com ([74.6.133.42]:34986 "EHLO
        sonic305-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728479AbgFFW1B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 6 Jun 2020 18:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591482419; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=PtfqudswW1nCDe1VpNYZY04a8KcNT85+Cmcc774wZkHN5g0moPPCxPcGYOo3Xd1jEaUNmQmrztFLrfL2jtx7yrfmiTxvgMs9MrUxA7SretjEHZU4C3uejZo8B6d6He9ial/Y0dMEl+wafmuSl19axQov7WQfmtgvpedRpIpoCo362Wn9wY9G3PUfz0qEL6vAh66ydLMa0x2sBFpFBUcwtU9cKJbilcb6FzJn1T+ivkkA6eLR+1k19ETtSbK046y9buAbId5kK56bp73LE5Qr1ypyY82TUG7cRnHxLj8Nbx7iJ043YPvO97KTSCcuJLjxSeGeP+UChdqIzv2hpHrY+g==
X-YMail-OSG: 1kSXqlkVM1nMBM7tTLJ0qvEeqtzeeSlwUgz70Hu6rHGEUOfB0zsL214zRxNDBWP
 ypUUyShRjHlBbuIRNFPONbvhNeePjU1dicggFrZ6MUlfWZwVZOc22ls4AUMUhdPcOGDbR8Pf6HTb
 baRgZOpquR29BFLY0xt3k0oLGMnq3VC1E1g37wIedzk._6LH5zvsupqX85nWUlSNipWqup_zfSzX
 VY_ZM0f6U38rsxcAGBcUa.jktzdjapp1pCqRxhjx9t.0d5BuqtV3cHpn_US_bBYpj.OmC8o4jehW
 jIIdh3lEVf4F1sF.KBtjxgX39NgZJmuAxRw4PNg8wzGGXEXFLjZMptoHIV8zhmL.OgZ7VuksdzP5
 zhQAJ.rVomlJOHsICpmRpG_4ImAI9YNo0VLSBLLLsPd.QXeA19fV6YLfxh7gG00XxHNnJwC1wq1x
 xPx0Dl2MfmNyFZqn2bKGAW6DhfQzKlJwr6ijumb8Ns7ER4hWkIP0A3iB4wGqwsqeVQd4cuTGplBt
 syg2GHHQmsMaSfne9eS8j_5QUAS9bHRW39SPDFPlPoGCLyR1fGjMsdEnJOS9hCoawSrjNJVGxnxv
 f0wBstREAmfaLxMs2oMtacS5i_yCQgoavR2fswsjNagJ0ZcLm0k9CvaQO6lNFdicbBq9EaqipEHf
 .LbcbooHXiMVorGlGM2_trM63EGYxuD87YHQbb2cGkgrKusw9enY.3JAJhbYFlpNMdnKkr196rWJ
 m.sscjts7ERdE0mpHHN6DBQG5yINpW2RlEjgebSefIak3SALYeHwbaWsVm4HjC8Ld6A9L1UnG8Yt
 7qdhpIPJ69nMyXmeRT8iUtwms4q3zNNrxxTzTu2G_rk07pkm65tJvI6lauX2R_wB5bTOFCvdXSay
 QtXi4FZqEWJwHIL.Bt.iW.P6GOYOKlK.3umo.6zS3n.nw8eUUBfvUpBkdQBAyoWWOUQsPEReVJQ7
 IzEplPKwXh9aYS15BKx5f8qR6q2qiEExAiThn3gJYZP6bP5hSi_J3vWYp1jhEUgdCF1d7dO6G3MJ
 IFWXpfS.OGvtaG4uFd3xn8AofGHfhdJPmUzs9.wa_xjswZFlH1GdKYbXbGGE1vniaGbEK0LWo3H2
 PIuLAVA1Qhl5R01VowT8QP7AOOmBs0V.f9NenSIrssz_PcvSX.0o9W8bGzoswef6lfUqsaWTr64B
 IQGeDQha68V3PQB4OOMGHODNQUQJH2PCT1Ti3t0RB0m4ArlsusLk.1H5Vp.OXL740C48M4ZXIaRs
 fDoOdhT7U57rGgbooiKJB4Rua52MqI8GuDCBFNNJznI6HlWoPAASag1LDl6jo22J0GwKRg.5FEH0
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 6 Jun 2020 22:26:59 +0000
Date:   Sat, 6 Jun 2020 22:26:54 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: mrsminaabrunel57044@gmail.com
Message-ID: <599783602.261033.1591482414173@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <599783602.261033.1591482414173.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16072 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0
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
