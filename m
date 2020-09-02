Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB125AA1E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 13:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIBLRt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 07:17:49 -0400
Received: from sonic304-9.consmr.mail.bf2.yahoo.com ([74.6.128.32]:33891 "EHLO
        sonic304-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgIBLRp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Sep 2020 07:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599045462; bh=KThrL1V1srIwPAzluA9XMP9Af7Rw8NwwbTPSpbw7iQg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Ezpt19uMWKXY94UeO8vMtBqosd5HkRssM5rOARU3RCn7rmBhBUoqx01qlSxPqJgbh1F////tIA+QGICnWZkkSfh388LBKAT7uuTfGrC+PQvc1h7XeO3+CyUaRbhnPsMecEVjmZwLulfJpORUxbba/sACii3I2LgPQTFMytP83Dj7tJccg5Hcu4hqGVNfzuMJn2sdlD9V+rnA745oY2GF/XdG81Vt++N2r3sbxuK+QeyHJoucZRoQSQbzqCMphTF1CPWtmLzqaz34RxSJncnB98/7NBfc11uYrFxawIzxzhKVrBzlqy/HQD5MrHm916Lmwa3Lp8B7o2xdd2fhlDOdtQ==
X-YMail-OSG: nfn6VukVM1k1KTsVStLKMbnTO2ckDry39ecFW0zOouac_nE31fgBKwpF_O2kqvn
 OnkZOTUcDXTSZlmqn6Ju71S4TuI653bjE1k2rPMilz1VXSpPdALktubp8XRlMuFzJrS6jUXCc6Mn
 KVJ8Xbw8PgVZGo8T6zJbsP2dX7TS.7VkDFdvMB9_31MpSPbJua4l4uW_4qG3dpyOoe6djjO26jGP
 TATFkIqjOW91RjrUN.NxKaUzpCBzQa37CPyjojmwdOxJOKzo4y5Vw81soOY8lXYQWh9Xv2NfLDOl
 t2N6OwNBaNyJMD5lonNhBvYV8pxWhGOL25aau5yQd6DFPpi7R8hp41c6JlJ.XixkxH.lQMCdDO3_
 BTS0i3nuEmlwdhJjVje48b70B2HPG5C5wLYnl5q0HVXUJqod8hxazNA_OEYMYenJdTFws2vux..P
 jNkAt4rvVdaX5BmN_m82SEc58b60ltZSa8iCy3nvlPhgwl7dhrSmcqWEysXuQ34S5uwGH4WOupaW
 oACcQT8Tn4RPXf_1frJQjjJAbTvkxJgnWf6qSC9bI2yCchHSumtYKA1BDlro7.yxJaWEMyjAuEvL
 z3lai0LMH904mXL2j_wI9o.m3hFsgOxSP7p5lri6ZN_vc49F4UW9TRs7dV2.KQg2QAsDw62SzWry
 6K3Oi7JKzsIsNAKcF5VsJ7MHR4AghR6FOfTRNmZBnxnJipQs3MywrCJO5YH9Ildj_lxhUOzYltll
 PVqAitMROkD5Id29onmHRzf1l4xIaoxO6ZcTCurQ3aFTIFEIVKIyF5xbQCI6qooMho1hVfBFcUpC
 NM8kg1da4usubOCVapfvdO7E5doTq23gw1mwQXGoLw1rp9dulyP1Iabhq7SoMxxJmdcngYKpfeOs
 Ls48X1G.Z9OSpOUWL9BC9sCNaH.3ciI3RJK3bDS9gVHS66OYCPEpV1lwc5HHtikD3Bu8cFOx7roG
 i5O..hExd3Cdd5FOOV9Le.ssxEcPSruWIwRxM.1i3L3VvQgiLzVQXM3mdbyL13VgJBlB.4pVedq0
 N8h6FMKV5StNUMYArldw6OSXlbBZTzKscZVghCevW.2s3cFWBsLI5hhEFQIFKJwWpFdU5rB.aBMS
 46eRNLw9R0Ih9KQfJngV7dGXJF21lTjApD8EHAbGUvLQeCE760zZgn17fr2WuwtYsbB4PAtTj32p
 TDUqQB9KdDmzggxt5BWhnVRuKhhcW_ftEf04YQnHO38Q8OCq6Pnfw2wS8Row2E1plq66FxM93Sod
 xAAq8EvP4gKhyV2IuHUDQo.Wji8DiROKPaMUimpXm1eXVY7eWJ4Fuqc2Hs9yguTK9F1lROTJSa6S
 SUJ4g9Hu0H5qJfvu0RfJNP818GU8qj55x1BZg_FCLg0EyLJ4STvL3sxcN8nC3iGLB5gm3Af4T40a
 GVAgD2i_F6x8UP6OLd1ua8ZkVvMLPVLnNbC814HQKhogCqCnivYqNQA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Wed, 2 Sep 2020 11:17:42 +0000
Date:   Wed, 2 Sep 2020 11:17:38 +0000 (UTC)
From:   "Mr.Abderazack zebdani" <abderazackzebdani22@gmail.com>
Reply-To: abderazackzebdani22@gmail.com
Message-ID: <1115457190.1472620.1599045458061@mail.yahoo.com>
Subject: Greetings My Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1115457190.1472620.1599045458061.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




Greetings=C2=A0My=C2=A0Dear=C2=A0Friend,

Before=C2=A0I=C2=A0introduce=C2=A0myself,=C2=A0I=C2=A0wish=C2=A0to=C2=A0inf=
orm=C2=A0you=C2=A0that=C2=A0this=C2=A0letter=C2=A0is=C2=A0not=C2=A0a=C2=A0h=
oax=C2=A0mail=C2=A0and=C2=A0I=C2=A0urge=C2=A0you=C2=A0to=C2=A0treat=C2=A0it=
=C2=A0serious.This=C2=A0letter=C2=A0must=C2=A0come=C2=A0to=C2=A0you=C2=A0as=
=C2=A0a=C2=A0big=C2=A0surprise,=C2=A0but=C2=A0I=C2=A0believe=C2=A0it=C2=A0i=
s=C2=A0only=C2=A0a=C2=A0day=C2=A0that=C2=A0people=C2=A0meet=C2=A0and=C2=A0b=
ecome=C2=A0great=C2=A0friends=C2=A0and=C2=A0business=C2=A0partners.=C2=A0Pl=
ease=C2=A0I=C2=A0want=C2=A0you=C2=A0to=C2=A0read=C2=A0this=C2=A0letter=C2=
=A0very=C2=A0carefully=C2=A0and=C2=A0I=C2=A0must=C2=A0apologize=C2=A0for=C2=
=A0barging=C2=A0this=C2=A0message=C2=A0into=C2=A0your=C2=A0mail=C2=A0box=C2=
=A0without=C2=A0any=C2=A0formal=C2=A0introduction=C2=A0due=C2=A0to=C2=A0the=
=C2=A0urgency=C2=A0and=C2=A0confidentiality=C2=A0of=C2=A0this=C2=A0business=
=C2=A0and=C2=A0I=C2=A0know=C2=A0that=C2=A0this=C2=A0message=C2=A0will=C2=A0=
come=C2=A0to=C2=A0you=C2=A0as=C2=A0a=C2=A0surprise.=C2=A0Please=C2=A0this=
=C2=A0is=C2=A0not=C2=A0a=C2=A0joke=C2=A0and=C2=A0I=C2=A0will=C2=A0not=C2=A0=
like=C2=A0you=C2=A0to=C2=A0joke=C2=A0with=C2=A0it=C2=A0ok,With=C2=A0due=C2=
=A0respect=C2=A0to=C2=A0your=C2=A0person=C2=A0and=C2=A0much=C2=A0sincerity=
=C2=A0of=C2=A0purpose,=C2=A0I=C2=A0make=C2=A0this=C2=A0contact=C2=A0with=C2=
=A0you=C2=A0as=C2=A0I=C2=A0believe=C2=A0that=C2=A0you=C2=A0can=C2=A0be=C2=
=A0of=C2=A0great=C2=A0assistance=C2=A0to=C2=A0me.=C2=A0My=C2=A0name=C2=A0is=
=C2=A0Mr.Abderazack=C2=A0zebdani,=C2=A0from=C2=A0Burkina=C2=A0Faso,=C2=A0We=
st=C2=A0Africa.=C2=A0I=C2=A0work=C2=A0in=C2=A0Bank=C2=A0Of=C2=A0Africa=C2=
=A0(BOA)=C2=A0as=C2=A0telex=C2=A0manager,=C2=A0please=C2=A0see=C2=A0this=C2=
=A0as=C2=A0a=C2=A0confidential=C2=A0message=C2=A0and=C2=A0do=C2=A0not=C2=A0=
reveal=C2=A0it=C2=A0to=C2=A0another=C2=A0person=C2=A0and=C2=A0let=C2=A0me=
=C2=A0know=C2=A0whether=C2=A0you=C2=A0can=C2=A0be=C2=A0of=C2=A0assistance=
=C2=A0regarding=C2=A0my=C2=A0proposal=C2=A0below=C2=A0because=C2=A0it=C2=A0=
is=C2=A0top=C2=A0secret.

I=C2=A0am=C2=A0about=C2=A0to=C2=A0retire=C2=A0from=C2=A0active=C2=A0Banking=
=C2=A0service=C2=A0to=C2=A0start=C2=A0a=C2=A0new=C2=A0life=C2=A0but=C2=A0I=
=C2=A0am=C2=A0skeptical=C2=A0to=C2=A0reveal=C2=A0this=C2=A0particular=C2=A0=
secret=C2=A0to=C2=A0a=C2=A0stranger.=C2=A0You=C2=A0must=C2=A0assure=C2=A0me=
=C2=A0that=C2=A0everything=C2=A0will=C2=A0be=C2=A0handled=C2=A0confidential=
ly=C2=A0because=C2=A0we=C2=A0are=C2=A0not=C2=A0going=C2=A0to=C2=A0suffer=C2=
=A0again=C2=A0in=C2=A0life.=C2=A0It=C2=A0has=C2=A0been=C2=A010=C2=A0years=
=C2=A0now=C2=A0that=C2=A0most=C2=A0of=C2=A0the=C2=A0greedy=C2=A0African=C2=
=A0Politicians=C2=A0used=C2=A0our=C2=A0bank=C2=A0to=C2=A0launder=C2=A0money=
=C2=A0overseas=C2=A0through=C2=A0the=C2=A0help=C2=A0of=C2=A0their=C2=A0Poli=
tical=C2=A0advisers.=C2=A0Most=C2=A0of=C2=A0the=C2=A0funds=C2=A0which=C2=A0=
they=C2=A0transferred=C2=A0out=C2=A0of=C2=A0the=C2=A0shores=C2=A0of=C2=A0Af=
rica=C2=A0were=C2=A0gold=C2=A0and=C2=A0oil=C2=A0money=C2=A0that=C2=A0was=C2=
=A0supposed=C2=A0to=C2=A0have=C2=A0been=C2=A0used=C2=A0to=C2=A0develop=C2=
=A0the=C2=A0continent.=C2=A0Their=C2=A0Political=C2=A0advisers=C2=A0always=
=C2=A0inflated=C2=A0the=C2=A0amounts=C2=A0before=C2=A0transferring=C2=A0to=
=C2=A0foreign=C2=A0accounts,=C2=A0so=C2=A0I=C2=A0also=C2=A0used=C2=A0the=C2=
=A0opportunity=C2=A0to=C2=A0divert=C2=A0part=C2=A0of=C2=A0the=C2=A0funds=C2=
=A0hence=C2=A0I=C2=A0am=C2=A0aware=C2=A0that=C2=A0there=C2=A0is=C2=A0no=C2=
=A0official=C2=A0trace=C2=A0of=C2=A0how=C2=A0much=C2=A0was=C2=A0transferred=
=C2=A0as=C2=A0all=C2=A0the=C2=A0accounts=C2=A0used=C2=A0for=C2=A0such=C2=A0=
transfers=C2=A0were=C2=A0being=C2=A0closed=C2=A0after=C2=A0transfer.=C2=A0I=
=C2=A0acted=C2=A0as=C2=A0the=C2=A0Bank=C2=A0Officer=C2=A0to=C2=A0most=C2=A0=
of=C2=A0the=C2=A0politicians=C2=A0and=C2=A0when=C2=A0I=C2=A0discovered=C2=
=A0that=C2=A0they=C2=A0were=C2=A0using=C2=A0me=C2=A0to=C2=A0succeed=C2=A0in=
=C2=A0their=C2=A0greedy=C2=A0act;=C2=A0I=C2=A0also=C2=A0cleaned=C2=A0some=
=C2=A0of=C2=A0their=C2=A0banking=C2=A0records=C2=A0from=C2=A0the=C2=A0Bank=
=C2=A0files=C2=A0and=C2=A0no=C2=A0one=C2=A0cared=C2=A0to=C2=A0ask=C2=A0me=
=C2=A0because=C2=A0the=C2=A0money=C2=A0was=C2=A0too=C2=A0much=C2=A0for=C2=
=A0them=C2=A0to=C2=A0control.=C2=A0They=C2=A0laundered=C2=A0over=C2=A0$5bil=
lion=C2=A0Dollars=C2=A0during=C2=A0the=C2=A0process.

Before=C2=A0I=C2=A0send=C2=A0this=C2=A0message=C2=A0to=C2=A0you,=C2=A0I=C2=
=A0have=C2=A0already=C2=A0diverted=C2=A0($10.5million=C2=A0Dollars)=C2=A0to=
=C2=A0an=C2=A0escrow=C2=A0account=C2=A0belonging=C2=A0to=C2=A0no=C2=A0one=
=C2=A0in=C2=A0the=C2=A0bank.=C2=A0The=C2=A0bank=C2=A0is=C2=A0anxious=C2=A0n=
ow=C2=A0to=C2=A0know=C2=A0who=C2=A0the=C2=A0beneficiary=C2=A0to=C2=A0the=C2=
=A0funds=C2=A0is=C2=A0because=C2=A0they=C2=A0have=C2=A0made=C2=A0a=C2=A0lot=
=C2=A0of=C2=A0profits=C2=A0with=C2=A0the=C2=A0funds.=C2=A0It=C2=A0is=C2=A0m=
ore=C2=A0than=C2=A0Eight=C2=A0years=C2=A0now=C2=A0and=C2=A0most=C2=A0of=C2=
=A0the=C2=A0politicians=C2=A0are=C2=A0no=C2=A0longer=C2=A0using=C2=A0our=C2=
=A0bank=C2=A0to=C2=A0transfer=C2=A0funds=C2=A0overseas.=C2=A0The=C2=A0($10.=
5million=C2=A0Dollars)=C2=A0has=C2=A0been=C2=A0laying=C2=A0waste=C2=A0in=C2=
=A0our=C2=A0bank=C2=A0and=C2=A0I=C2=A0don=E2=80=99t=C2=A0want=C2=A0to=C2=A0=
retire=C2=A0from=C2=A0the=C2=A0bank=C2=A0without=C2=A0transferring=C2=A0the=
=C2=A0funds=C2=A0to=C2=A0a=C2=A0foreign=C2=A0account=C2=A0to=C2=A0enable=C2=
=A0me=C2=A0share=C2=A0the=C2=A0proceeds=C2=A0with=C2=A0the=C2=A0receiver=C2=
=A0(a=C2=A0foreigner).=C2=A0The=C2=A0money=C2=A0will=C2=A0be=C2=A0shared=C2=
=A060%=C2=A0for=C2=A0me=C2=A0and=C2=A040%=C2=A0for=C2=A0you.=C2=A0There=C2=
=A0is=C2=A0no=C2=A0one=C2=A0coming=C2=A0to=C2=A0ask=C2=A0you=C2=A0about=C2=
=A0the=C2=A0funds=C2=A0because=C2=A0I=C2=A0secured=C2=A0everything.=C2=A0I=
=C2=A0only=C2=A0want=C2=A0you=C2=A0to=C2=A0assist=C2=A0me=C2=A0by=C2=A0prov=
iding=C2=A0a=C2=A0reliable=C2=A0bank=C2=A0account=C2=A0where=C2=A0the=C2=A0=
funds=C2=A0can=C2=A0be=C2=A0transferred.

You=C2=A0are=C2=A0not=C2=A0to=C2=A0face=C2=A0any=C2=A0difficulties=C2=A0or=
=C2=A0legal=C2=A0implications=C2=A0as=C2=A0I=C2=A0am=C2=A0going=C2=A0to=C2=
=A0handle=C2=A0the=C2=A0transfer=C2=A0personally.=C2=A0If=C2=A0you=C2=A0are=
=C2=A0capable=C2=A0of=C2=A0receiving=C2=A0the=C2=A0funds,=C2=A0do=C2=A0let=
=C2=A0me=C2=A0know=C2=A0immediately=C2=A0to=C2=A0enable=C2=A0me=C2=A0give=
=C2=A0you=C2=A0a=C2=A0detailed=C2=A0information=C2=A0on=C2=A0what=C2=A0to=
=C2=A0do.=C2=A0For=C2=A0me,=C2=A0I=C2=A0have=C2=A0not=C2=A0stolen=C2=A0the=
=C2=A0money=C2=A0from=C2=A0anyone=C2=A0because=C2=A0the=C2=A0other=C2=A0peo=
ple=C2=A0that=C2=A0took=C2=A0the=C2=A0whole=C2=A0money=C2=A0did=C2=A0not=C2=
=A0face=C2=A0any=C2=A0problems.=C2=A0This=C2=A0is=C2=A0my=C2=A0chance=C2=A0=
to=C2=A0grab=C2=A0my=C2=A0own=C2=A0life=C2=A0opportunity=C2=A0but=C2=A0you=
=C2=A0must=C2=A0keep=C2=A0the=C2=A0details=C2=A0of=C2=A0the=C2=A0funds=C2=
=A0secret=C2=A0to=C2=A0avoid=C2=A0any=C2=A0leakages=C2=A0as=C2=A0no=C2=A0on=
e=C2=A0in=C2=A0the=C2=A0bank=C2=A0knows=C2=A0about=C2=A0my=C2=A0plans.Pleas=
e=C2=A0get=C2=A0back=C2=A0to=C2=A0me=C2=A0if=C2=A0you=C2=A0are=C2=A0interes=
ted=C2=A0and=C2=A0capable=C2=A0to=C2=A0handle=C2=A0this=C2=A0project,=C2=A0=
I=C2=A0shall=C2=A0intimate=C2=A0you=C2=A0on=C2=A0what=C2=A0to=C2=A0do=C2=A0=
when=C2=A0I=C2=A0hear=C2=A0from=C2=A0your=C2=A0confirmation=C2=A0and=C2=A0a=
cceptance.If=C2=A0you=C2=A0are=C2=A0capable=C2=A0of=C2=A0being=C2=A0my=C2=
=A0trusted=C2=A0associate,=C2=A0do=C2=A0declare=C2=A0your=C2=A0consent=C2=
=A0to=C2=A0me=C2=A0I=C2=A0am=C2=A0looking=C2=A0forward=C2=A0to=C2=A0hear=C2=
=A0from=C2=A0you=C2=A0immediately=C2=A0for=C2=A0further=C2=A0information.
Thanks=C2=A0with=C2=A0my=C2=A0best=C2=A0regards.
Mr.Abderazack=C2=A0zebdani.
Telex=C2=A0Manager
Bank=C2=A0Of=C2=A0Africa=C2=A0(BOA)
Burkina=C2=A0Faso.
