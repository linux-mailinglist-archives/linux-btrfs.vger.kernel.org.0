Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6A280368
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbgJAQBw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 12:01:52 -0400
Received: from sonic301-21.consmr.mail.sg3.yahoo.com ([106.10.242.84]:36405
        "EHLO sonic301-21.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732213AbgJAQBw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 12:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601568106; bh=rL9Nereyf6z11xgF2Y4betqrYfTpmZ3zohYWpfFPbDg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=FNNtvqkaiQDepSmdHDNrQsumFfBkLVMXyFdl8wdo0Pc6Z4nuDKRoBYgndbZkUm2X0GK1FrifHC0mj7NnktHSQlS/vClkX3DWWTTNilJrlmb409b4m2pQ/wm1peyRA+Arx4xIXz3d1gsFSBoHmR/itLmMx0f8JLoARcOLrpDaRI/l5IMUqSBssyjCP4HdjqvsHAV+BtjouqW9HBYThbvmxQ0dTirdlvtE68TgD4lLH0IHPBboGMgaSaKH2aLYQfTBJH22zMdM6AOI//G+0S6UWV9lmwrOrm9wSGuWgBoa6GzbsuriHqd8mo27lwP06sj4U8iFZlF4YJCQAANis+7o8A==
X-YMail-OSG: mWhbC0cVM1lQDDXzMOI4jHbwe9BFERgFBFnKfotLDMnAyZx94sCNt519y.XL9yI
 5he6oqrHI_YQjRTBIxWvBQlNjkMUzZd5M4zhsalbvuZI86duMVKHej3ZPGi6V4ryRqXCkeefv1CQ
 AtlCnZ.7PjhWtve24WEsLRcEn.utXE74VsK1U8YPWLaBpdzYiaDfqztQ4LkwNgEQN_Z5Bfp6CFJj
 jH1teWMgnSKeUePP3F_eUi.MoqYzdK0nvRNxjDAhNcZKxJKDi04sinaY4IFjPToLC9ek287VBorq
 PBg_GXKknXGwkPVAjElpimHTGKX7WDBBkSH9oKscQG2Sz4vpP9qOswJyn5hMSQBxjTfFXDSVd9JD
 JGCddris2NArvbvSpRtriLFcgAlUVvJjtCyJOdX6tyIZiMo6rhN9lj8rMQqD7RSKas2.MQZnPJjD
 4p7GQKkKSJJfTWq4i72dsZK4Y4_REcIpGFg27RAzhpGLBi.E4fa8ZlPfchS5Hl8vlgkQM9c1ZXr9
 oUs9WRUkgUt9FZM2l7F.rEwXwxhYkkiKviCKtVlErsiD.vRU.56sJMhqP5ZrU1UDvK1WihuXobAF
 iQUyP1QLzVYRy2t9onjwlpnvDVVWFldlY0KHWxGCgY8dKbfGdNeSYIcToODFmvOJ7Mxi37Qnz8f9
 1d.vuWHw6POtBeK6rlXzugIUA.vYXBAmjEdVbRXZhO18jRJgkAL_UAF_U1ooHPZIWQ_hHFlip2MU
 3cvPQzUjWN_jbZvZZPoeEIXy4QAMqNCnewRYHSCIKoB0NH5vyLMru68jOxGS26_71qNSVIHq5tB0
 IsdZSQr3qHfRGOUpXX3KQa4YJdEydP0YZNJKdmZRFXZcqUtJLt7unyKKqRxYveOIRqaH7LzdWyfm
 _xhFAS3i1KdI7LZksiPVIpZxURBHKHP_kBZCRXM6ibstlcmneOwUirB3HsWpZfD8appMJzjTLXUS
 bQnAFeamsyg2DfA0YVhUaunasRgBMrpU4x43augZrgKrEBb90_l4SufezhWnWERpbGmq9dmE3oL2
 6wvoEEZTxp0GX_BSzdtNmzhEAwxLU79lHV.91tO48yJ1CZ5ls.zPHFUBfaTyzz9vDh9_0oL9sdTG
 Q6DlIPsGUOPKZGVFh6_AgfDhFLQA35Y5mkJagwHBQjuo7CZGlPtsfs7Fny_ZkHvdkcsilTqoKomB
 DvN5wrZjHudi.c9X7OIoOzma1JDB_ngt1dqF69f5J7aqDXoVbwDfExmwl.DDZy..NFbfi.1oANFw
 K16ERO2ce1ymVvSDmjorKOK9i4DYOxZq8274DTc9AKQ498Jf8unHHCtlGcr4Ya8f5aYdfuEfFrt9
 DD1ElQoZ6u6YRWPbGFe3sedIW78UOYRLfxapxcPiSPGnDz09ZvRWAB803tkd3179psUjB69zloXO
 46SjYkhg3M0GYikMr0ym7P3WBtRW8jXbH3a4m3IQ4S1YJI6Owjw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Thu, 1 Oct 2020 16:01:46 +0000
Date:   Thu, 1 Oct 2020 16:01:41 +0000 (UTC)
From:   "Mr. Abdul Salam" <as6171099@gmail.com>
Reply-To: as6174759@gmail.com
Message-ID: <591264205.681264.1601568101790@mail.yahoo.com>
Subject: With Due Respect,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <591264205.681264.1601568101790.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:47.0) Gecko/20100101 Firefox/47.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



My Dear Friend,

Before I introduce myself, I wish to inform you that this letter is not a h=
oax mail and I urge you to treat it serious. This letter must come to you a=
s a big surprise, but I believe it is only a day that people meet and becom=
e great friends and business partners. Please I want you to read this lette=
r very carefully and I must apologize for barging this message into your ma=
il box without any formal introduction due to the urgency and confidentiali=
ty of this business and I know that this message will come to you as a surp=
rise. Please this is not a joke and I will not like you to joke with it ok,=
 with due respect to your person and much sincerity of purpose, I make this=
 contact with you as I believe that you can be of great assistance to me. M=
y name is Mr. Abdul Salam, from Burkina Faso, West Africa. I work in United=
 Bank for Africa (UBA) as telex manager, please see this as a confidential =
message and do not reveal it to another person and let me know whether you =
can be of assistance regarding my proposal below because it is top secret.

I am about to retire from active Banking service to start a new life but I =
am skeptical to reveal this particular secret to a stranger. You must assur=
e me that everything will be handled confidentially because we are not goin=
g to suffer again in life. It has been 10 years now that most of the greedy=
 African Politicians used our bank to launder money overseas through the he=
lp of their Political advisers. Most of the funds which they transferred ou=
t of the shores of Africa were gold and oil money that was supposed to have=
 been used to develop the continent. Their Political advisers always inflat=
ed the amounts before transferring to foreign accounts, so I also used the =
opportunity to divert part of the funds hence I am aware that there is no o=
fficial trace of how much was transferred as all the accounts used for such=
 transfers were being closed after transfer. I acted as the Bank Officer to=
 most of the politicians and when I discovered that they were using me to s=
ucceed in their greedy act; I also cleaned some of their banking records fr=
om the Bank files and no one cared to ask me because the money was too much=
 for them to control. They laundered over $5billion Dollars during the proc=
ess.

Before I send this message to you, I have already diverted ($10.5million Do=
llars) to an escrow account belonging to no one in the bank. The bank is an=
xious now to know who the beneficiary to the funds is because they have mad=
e a lot of profits with the funds. It is more than Eight years now and most=
 of the politicians are no longer using our bank to transfer funds overseas=
. The ($10.5million Dollars) has been laying waste in our bank and I don=E2=
=80=99t want to retire from the bank without transferring the funds to a fo=
reign account to enable me share the proceeds with the receiver (a foreigne=
r). The money will be shared 60% for me and 40% for you. There is no one co=
ming to ask you about the funds because I secured everything. I only want y=
ou to assist me by providing a reliable bank account where the funds can be=
 transferred.

You are not to face any difficulties or legal implications as I am going to=
 handle the transfer personally. If you are capable of receiving the funds,=
 do let me know immediately to enable me give you a detailed information on=
 what to do. For me, I have not stolen the money from anyone because the ot=
her people that took the whole money did not face any problems. This is my =
chance to grab my own life opportunity but you must keep the details of the=
 funds secret to avoid any leakages as no one in the bank knows about my pl=
ans. Please get back to me if you are interested and capable to handle this=
 project, I shall intimate you on what to do when I hear from your confirma=
tion and acceptance. If you are capable of being my trusted associate, do d=
eclare your consent to me I am looking forward to hear from you immediately=
 for further information.
Thanks with my best regards.
Mr. Abdul Salam,
Telex Manager
United Bank for Africa (UBA)
Burkina Faso
