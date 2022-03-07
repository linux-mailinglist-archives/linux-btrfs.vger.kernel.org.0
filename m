Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356294CF2E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 08:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiCGHtZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 02:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiCGHtY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 02:49:24 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80053.outbound.protection.outlook.com [40.107.8.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3D313F96
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 23:48:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNp8tFvGdZ4n6YuqTXG5zi6u/xSpPKqmd9mb46XJqxths+/sDalwQc91Y5pN6EeY7KCRy1XXHNA+epAWuq1sVHswHKAhWO+btywYGp8299UdTF3StlH1qrs+R0vfcUbiNOUz0QhZXVQXQO9uEriym4nOYO+Dd7XuRgxQ+BrM7LhFdIbQ3MKHsb01C3tvvmMtzMyYRh+w4eXsQA/yp3P1JLmkgBcb5nFl/eIzP8pZIAXxbwD1YfCJkwsbfKTTSSv8tSgzfB5w/XSoiidsoOIt1qHicYNXgPggSuh7zC7z5sTpDX6L9s6NMvN9N3bmlZKcs/6fdXxilhD+j3MlRZ/EpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyndPDOOz6QrFrHwijTbdfDv0XTreb4Ziu3gqMB2oB0=;
 b=BzNDcSWzR51kDCogL086anVLA0WilfzMPH3MTZiA8XJHeiv1FrWs7p4WSx2Uk1vaGiSyPHIh+ToQlD8Uzm1FJenh+AXsK9fJFvdHAc3sp3E/XRttCaWBp+EYM++CDe5maTBKk8vzYKbLwOIROBM3DiEuCvK7ZK27WZV8Hu7pBY7le4HRBTcQdyCzd33x3xULYvJHYNH1qQ5hKR6UfHRJfRYHLls5/8ipUlH2S4vvFn+pqLt/m69gGk6pt28vTYMybPNhd/Wf67AydfVCI6PuOz7lhGQysqlfE+HrlZdhvmoeyMmegzU17GaMh0UIETSKdo6WnysN4gPy/f0jLn2KdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=profihost.ag; dmarc=pass action=none header.from=profihost.ag;
 dkim=pass header.d=profihost.ag; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bmdo.onmicrosoft.com;
 s=selector2-bmdo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyndPDOOz6QrFrHwijTbdfDv0XTreb4Ziu3gqMB2oB0=;
 b=PIIWilrDajPtWigZi30WFjlJK8pIa7swjkhRly0TMYqbl1o5zYGW6/Ye8TQSIMgXO8ZW+VOj3J5vY7ZufqVenIj6HxvnamyYPAT3JahY59AMKxftl+poG2/B33iEKv5oSPumzwGif2063IZB0xkn41iMFwT1aMemyvMRfyq5zlk=
Received: from AM0PR08MB3265.eurprd08.prod.outlook.com (2603:10a6:208:56::32)
 by PR3PR08MB5562.eurprd08.prod.outlook.com (2603:10a6:102:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 07:48:24 +0000
Received: from AM0PR08MB3265.eurprd08.prod.outlook.com
 ([fe80::ed98:1a5c:2ede:8155]) by AM0PR08MB3265.eurprd08.prod.outlook.com
 ([fe80::ed98:1a5c:2ede:8155%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 07:48:24 +0000
From:   Carsten Grommel <c.grommel@profihost.ag>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: AW: AW: AW: How to (attempt to) repair these btrfs errors
Thread-Topic: AW: AW: How to (attempt to) repair these btrfs errors
Thread-Index: AQHYLNKzWsbDNPNvmUqwF5z6etdMhKyqXA4HgAc/oACAAeyr8IAAAysAgAADOaWAAAM+AIAAAPrl
Date:   Mon, 7 Mar 2022 07:48:24 +0000
Message-ID: <AM0PR08MB3265FD23EA7AC3A8BFBC2F968E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
References: <AM0PR08MB326504D6D0D7D3077A13C7DE8E019@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <AM0PR08MB3265280A4F4EF8151DA289F58E029@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <YiQQOFQO7G4NZTKS@hungrycats.org>
 <AM0PR08MB3265F930C35B1AFBA7E981B18E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <5379ca8e-0384-b447-52c1-a41ef0ded7e7@gmx.com>
 <AM0PR08MB3265B4FA65082A7FDEB942248E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <f64a230c-19cb-e842-4569-0828a4d8bd16@gmx.com>
In-Reply-To: <f64a230c-19cb-e842-4569-0828a4d8bd16@gmx.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: d71864e2-9584-3ba7-a83e-81c42d3136e8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=profihost.ag;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c414b25-d84a-4f0a-fc3b-08da000edc1b
x-ms-traffictypediagnostic: PR3PR08MB5562:EE_
x-microsoft-antispam-prvs: <PR3PR08MB5562B9AB424BE96FB5B0B67C8E089@PR3PR08MB5562.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2B5nMFYQFdnW7x1FxA0ceBltcsuVGA/0hmsbiM8i/lkvwMYcoGTDeI4gzUCyEiq7zhtaWk+OvwTx1bP/O2U+gtoeawWmUbi4ceTF5CpBsd7eeXlDJJUl+gqyTI7hxHwvLjegecv6+Pg1xzoHf79TMSQuL1D+MoRyQ9KrU/KWyntcQHP8zBnEQpcrAVyyeIo/b1eS/edx4fIa5RzP5aOCmN7I679+i199Mhygr6Gej029VlvAkMA2k65xByaSHzOtRRlVBXgIU2I/JCzt6DZs4jRVirEoMPDGQJhlrh4xYRTkMsg4PYKGS0cxTcB89WcMZlp4LHN7SEDWevIWwRWnFITZLPtP2UtJVJhDi7OhhhwRUU+iuVQtz4Sqzvtrg77zsyeOBily4n+mMM9+kmddN7XKmmVwcTmlTFDTraRhQAC7p/KgI5tkIYmHMrQKK1Vpce7F0xNCyuODRVswpBhRiUc4Xyayj5n30V/kgqrhrWunNCAywD6A2EyapWc6W0UV+SjS07RqwZQNoVXC4C4Q/PU4xtQswIf9qc5ErUlysJ9hXZpuFyWWONSkSpAo0su9qivJ2YLYaPhPEW5Wc7ESEWlpfPiOnBLv+5kFFMPS8d6o3vAE987CCEdlqnQQcTTEuMW3B6K1uGtPaGNvYCUm4zLo7yoYZ2cL5JIZ3xKvC1xgaslgIpcQiiaH+Hp9v/KtKcER8S8MA7m+0FG/u5VfT46Z7uQjMH1B4gYq3KDUVnVXGKkeXWGoKwvvyqZEegrsHMAtSTTccz2ntuwKFE1mXtYOjH6gxjgtG2U8gYCOloTqBIsGx8Nr24T4KBa+PssTdNavry3PWCgt9DqDKFN40w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3265.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(38100700002)(55016003)(71200400001)(966005)(7696005)(6506007)(83380400001)(38070700005)(2906002)(33656002)(5660300002)(316002)(91956017)(26005)(76116006)(66946007)(66556008)(9686003)(52536014)(8936002)(66574015)(30864003)(86362001)(122000001)(186003)(8676002)(4326008)(110136005)(64756008)(508600001)(66476007)(66446008)(10126625002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?xsLnqLbQvM/QRn/qap5MR0U8op0ZfxNT/9bZTFdtfDacS0xvtN8LzCyN?=
 =?Windows-1252?Q?x/55SCfOEjwgGLroDl8Tx8B6xlM+fa64Woo+itN15bDiJag3t2WGzttD?=
 =?Windows-1252?Q?F4/XxrqtSPEdd1anfzoZagYg9HYGKeyUy1AtTqCKi1R5Vf+fybdhyvRV?=
 =?Windows-1252?Q?z1nx+GLly7fX2LwIcE9w99SJ2RVO8zo40lQ8BAPRqeTYVOeVIlMA+7d4?=
 =?Windows-1252?Q?CNzeckq2bgfgsSB3JpKyJp4ZrIVsW+cbpIeartnqnpmtp4izY/i8Ogxi?=
 =?Windows-1252?Q?T7nFS3BForPt/1EG+DZCTxt7i+0fCQTh6XiMhxGy6tkz5Y7N3l7vW/6D?=
 =?Windows-1252?Q?OBS4gEK08F5kW5ktSxXCdXTpHT0y38OCGHCbbGpJe6slrsUDXWUXI/AF?=
 =?Windows-1252?Q?sHrR4pfquzukRP04Qy3MDVcBU6NKnl+iOP+nawyhxGLBaab9iCAeLwst?=
 =?Windows-1252?Q?Hq34UxQHbqWUH/nDBjn/Y9jLmKeCDsPKLI3KJSkVWswJl4OyTjCZfDCN?=
 =?Windows-1252?Q?46BfYAkFB3li08iOx7go2zRsKnA4ThdVuiDeMksIW3hb468nGqzfoaV9?=
 =?Windows-1252?Q?RRJFaL0+YR67h48fS6VqvV1+eMpUvnmV5dlPS05dhTOm5gWWv2tx9+WK?=
 =?Windows-1252?Q?VkDcBMNGdUDTWDOhkShT5U5BXtekU+wXGTPWd44S0RKUMiShPBlvZ5F+?=
 =?Windows-1252?Q?m7HKLBoBSq+odxS2Qnydp/tLCA3nDZjSPURYucmYqfzqusO+pjc6IhAg?=
 =?Windows-1252?Q?gA1/19cDQr0mFTB1zDEdbyV5TDCvP7Pj7cHvTEQ2CxJbm75y4uu+kmk6?=
 =?Windows-1252?Q?JHNtH7xVs3GqZjuizNcWwhLR+5LlqVIxKqqC01uphCExqimTMQ2mBzDl?=
 =?Windows-1252?Q?HjtCgVucx+81SzqyB+PCmhhqgF1TRQdzJaEqrah/dJK3dQZYzXltac55?=
 =?Windows-1252?Q?JsVgctqxocce67kY9lBQPiCx1cHVYveSRBM6zxaGkRqnMqMMcQvgbDPu?=
 =?Windows-1252?Q?ghA9KBB12Ol0UzVPblyxB6E+/sPcqRha/tv+n700mgATLfCRcVKo5WNg?=
 =?Windows-1252?Q?lUfrp6oDhuHdGRMlEvNTWMo2EH3Riqmv9GdVvL2mXYT+qYOBUBRNdQFE?=
 =?Windows-1252?Q?7rsnnufuNL9X2P6uFTdFJGwzzBlBfMhuNd4vvS00KJ3jSOxxUBnzTfb6?=
 =?Windows-1252?Q?EXmk8wyUUa5HNhqRJMOT/hYpKAyPcBGw84yI19b/NIM7qTB+RS91WYdL?=
 =?Windows-1252?Q?fo88NsR41BC2bCv4afxDDWiaXhS7pC5GS4sEON0XciJWgKBmtMv9G+q4?=
 =?Windows-1252?Q?TI2z8lVxldCaYZO+APsX0hk+shzjsb43i3lPSuCuGceeJEIlSz+Bbki4?=
 =?Windows-1252?Q?jrOKzRQxDyVlESiN2IFlvRexyAWXVELuNLf97/nzbZg8CNlB3kSslPwR?=
 =?Windows-1252?Q?1bxykPTuJgbvSXfhMJ+5jwMpPfX+C50FP0wd6lt9qWVwNPER5AtZA112?=
 =?Windows-1252?Q?0jjt8N5To0IIH3XtlZrGQVFhNFNf4wDsHAOxLxTfeyVL9LjP3PXrl5qo?=
 =?Windows-1252?Q?gSrNlgJKw26pycyaybx8dWhTUWT9+kBEO0pkKDzGK3g8/HH/uBhhPHhs?=
 =?Windows-1252?Q?Jd1h5KhqtJxjgw4Pl4by9GTru8rspgZRpqN+I3bgMF53IRkmo21rOr5Y?=
 =?Windows-1252?Q?SH4QjLywij8fCLYVBZeHb9BcS9gMJqmcJc9WidbPo1+809UWVu6vvw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: profihost.ag
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3265.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c414b25-d84a-4f0a-fc3b-08da000edc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 07:48:24.8085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b3201e87-5c43-439a-8fa3-eab13a770d4a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FhISMWJlNGFuP51oXTKgisRYWtLWzgKYD/GjppEdlZQ5WGAlBZhHtUuUseB9FRzy5z4vu9U18ANMthcN14iqpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5562
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

=0A=
=0A=
>OK, this explains the reason.=0A=
=0A=
>Some tree blocks in subvolume trees are corrupted, and by the worst=0A=
>possible way, metadata transid mismatch.=0A=
>=0A=
>Although it looks like some metadata read can be repaired, but I guess=0A=
>since btrfs_finish_ordered_io() still failed, it means some can not be=0A=
>repaired.=0A=
>=0A=
>Did the fs go through some split-brain cases? E.g. some devices got=0A=
>degraded mount, then the missing device come back?=0A=
=0A=
Indeed something like this seems to have happened. =0A=
One of the raid6 had two disks failures with one disk being able to rejoin =
the raid. =0A=
This concerned me because in a raid6 there should be no problem with two de=
vices leaving the raid. =0A=
At this point there seemed to be some corruption happening. I suspect that =
this resonated in some kind of =0A=
corruption loop causing garbage writes during the heavy write io the backup=
s are causing on the filesystem. =0A=
=0A=
> These seems to be the most critical afaic:=0A=
>=0A=
> Mar  4 01:25:51 cloud8-1550 kernel: [44623.523395] BTRFS critical (device=
 sdc1): corrupt leaf: root=3D111550 >block=3D849874468864 slot=3D0 ino=3D32=
633089 file_offset=3D7805042688, invalid compression for file extent, have =
15 expect range [0, 3]=0A=
>=0A=
>OK, this would explain the problem much better than the repairable=0A=
>metadata read.=0A=
>=0A=
>There should be no way we have compression type 0xf.=0A=
=0A=
> Mar  4 01:25:51 cloud8-1550 kernel: [44623.527109] BTRFS error (device sd=
c1): block=3D849874468864 read time tree block corruption detected=0A=
> Mar  4 01:25:52 cloud8-1550 kernel: [44623.643308] BTRFS critical (device=
 sdc1): corrupt leaf: root=3D50979 block=3D849880268800 slot=3D2, bad key o=
rder, prev (18446744073709551606 128 1269917216768) current (18446744073709=
551606 128 1269916291=0A=
> 072)=0A=
>=0A=
>And bad tree key order, even more serious.=0A=
>=0A=
>hex(1269917216768) =3D 0x127acf6f000=0A=
>hex(1269916291072) =3D 0x127ace8d000=0A=
>=0A=
>Doesn't look like a simple bitflip, nor does the preivous 0xf=0A=
>compression type.=0A=
>=0A=
>I have no idea how things can be so terribly wrong...=0A=
=0A=
This is where i try to wrap my head around, i just can not explain how this=
 cascade of errors happened=0A=
Do you see a problem in trying to restore as much data as possible with btr=
fs restore / btrfs send | recieve? =0A=
I fear that the corruption could wander, any experiences on this? =0A=
=0A=
Thanks!=0A=
=0A=
________________________________________=0A=
Von: Qu Wenruo <quwenruo.btrfs@gmx.com>=0A=
Gesendet: Montag, 7. M=E4rz 2022 08:34=0A=
An: Carsten Grommel; Zygo Blaxell=0A=
Cc: linux-btrfs@vger.kernel.org=0A=
Betreff: Re: AW: AW: How to (attempt to) repair these btrfs errors=0A=
=0A=
=0A=
=0A=
On 2022/3/7 15:25, Carsten Grommel wrote:=0A=
> Hi Qu,=0A=
>=0A=
>> Mind to share a dmesg just after the RO fallback?=0A=
>=0A=
> the most recent crash:=0A=
>=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.191649] BTRFS error (device sd=
c1): parent transid verify failed on 16155500953600 wanted 126097 found 946=
52=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.194011] BTRFS error (device sd=
c1): parent transid verify failed on 16155500953600 wanted 126097 found 946=
52=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.195395] BTRFS error (device sd=
c1): parent transid verify failed on 16155500953600 wanted 126097 found 126=
097=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.196620] BTRFS error (device sd=
c1): parent transid verify failed on 16155500953600 wanted 126097 found 126=
097=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.197920] BTRFS error (device sd=
c1): parent transid verify failed on 16155500953600 wanted 126097 found 126=
097=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.212980] BTRFS info (device sdc=
1): read error corrected: ino 0 off 16155500953600 (dev /dev/sde1 sector 10=
546500256)=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.214413] BTRFS info (device sdc=
1): read error corrected: ino 0 off 16155500957696 (dev /dev/sde1 sector 10=
546500264)=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.215204] BTRFS error (device sd=
c1): parent transid verify failed on 16155500953600 wanted 126097 found 946=
52=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.215656] BTRFS info (device sdc=
1): read error corrected: ino 0 off 16155500961792 (dev /dev/sde1 sector 10=
546500272)=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.230156] BTRFS: error (device s=
dc1) in btrfs_finish_ordered_io:2736: errno=3D-5 IO failure=0A=
=0A=
OK, this explains the reason.=0A=
=0A=
Some tree blocks in subvolume trees are corrupted, and by the worst=0A=
possible way, metadata transid mismatch.=0A=
=0A=
Although it looks like some metadata read can be repaired, but I guess=0A=
since btrfs_finish_ordered_io() still failed, it means some can not be=0A=
repaired.=0A=
=0A=
Did the fs go through some split-brain cases? E.g. some devices got=0A=
degraded mount, then the missing device come back?=0A=
=0A=
Thanks,=0A=
Qu=0A=
=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.233127] BTRFS info (device sdc=
1): read error corrected: ino 0 off 16155500965888 (dev /dev/sde1 sector 10=
546500280)=0A=
> Mar  4 01:43:15 cloud8-1550 kernel: [45667.247096] BTRFS info (device sdc=
1): forced readonly=0A=
>=0A=
> ________________________________________=0A=
> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>=0A=
> Gesendet: Montag, 7. M=E4rz 2022 08:11=0A=
> An: Carsten Grommel; Zygo Blaxell=0A=
> Cc: linux-btrfs@vger.kernel.org=0A=
> Betreff: Re: AW: How to (attempt to) repair these btrfs errors=0A=
>=0A=
>=0A=
>=0A=
> On 2022/3/7 15:03, Carsten Grommel wrote:=0A=
>> Thank you for the answer. We are using space_cache v2:=0A=
>>=0A=
>> /dev/sdc1 on /vmbackup type btrfs (rw,noatime,nobarrier,compress-force=
=3Dzlib:3,ssd_spread,noacl,space_cache=3Dv2,skip_balance,subvolid=3D5,subvo=
l=3D/,x-systemd.mount-timeout=3D4h)=0A=
>>=0A=
>>> Data is raid0, so data repair is not possible.  Delete all the files=0A=
>>> that contain corrupt data.=0A=
>>=0A=
>> I tried but as soon as I access the broken blocks btrfs fails into reado=
nly so I am kind of in a deadlock there.=0A=
>=0A=
> Btrfs only falls back to RO for very critical errors (which could affect=
=0A=
> on-disk metadata consistency).=0A=
>=0A=
> Thus plain data corruption should not cause the RO.=0A=
>=0A=
> Mind to share a dmesg just after the RO fallback?=0A=
>=0A=
> Thanks,=0A=
> Qu=0A=
>=0A=
>>=0A=
>>> I don't see any errors in these logs that would indicate a metadata iss=
ue,=0A=
>>> but huge numbers of messages are suppressed.  Perhaps a log closer=0A=
>>> to the moment when the filesystem goes read-only will be more useful.=
=0A=
>>=0A=
>>> I would expect that if there are no problems on sda1 or sdb1 then it=0A=
>>> should be possible to repair the metadata errors on sdd1 by scrubbing=
=0A=
>> that device.=0A=
>>=0A=
>> I ran a number of scrubs now, at some point it always fails and btrfs re=
mounts into readonly.=0A=
>> I did not yet try to scrub specifically on sdd though, gonna try that.=
=0A=
>>=0A=
>> Should it remount again i will provide the most recent dmesg's right bef=
ore it crashes.=0A=
>>=0A=
>> ________________________________________=0A=
>> Von: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>=0A=
>> Gesendet: Sonntag, 6. M=E4rz 2022 02:36=0A=
>> An: Carsten Grommel=0A=
>> Cc: linux-btrfs@vger.kernel.org=0A=
>> Betreff: Re: How to (attempt to) repair these btrfs errors=0A=
>>=0A=
>> On Tue, Mar 01, 2022 at 10:55:50AM +0000, Carsten Grommel wrote:=0A=
>>> Follow-up pastebin with the most recent errors in dmesg:=0A=
>>>=0A=
>>> https://pastebin.com/4yJJdQPJ=0A=
>>=0A=
>> This seems to have expired.=0A=
>>=0A=
>>> ________________________________________=0A=
>>> Von: Carsten Grommel=0A=
>>> Gesendet: Montag, 28. Februar 2022 19:41=0A=
>>> An: linux-btrfs@vger.kernel.org=0A=
>>> Betreff: How to (attempt to) repair these btrfs errors=0A=
>>>=0A=
>>> Hi,=0A=
>>>=0A=
>>> short buildup: btrfs filesystem used for storing ceph rbd backups withi=
n subvolumes got corrupted.=0A=
>>> Underlying 3 RAID 6es, btrfs is mounted on Top as RAID 0 over these Rai=
ds for performance ( we have to store massive Data)=0A=
>>>=0A=
>>> Linux cloud8-1550 5.10.93+2-ph #1 SMP Fri Jan 21 07:52:51 UTC 2022 x86_=
64 GNU/Linux=0A=
>>>=0A=
>>> But it was Kernel 5.4.121 before=0A=
>>>=0A=
>>> btrfs --version=0A=
>>> btrfs-progs v4.20.1=0A=
>>>=0A=
>>> btrfs fi show=0A=
>>> Label: none  uuid: b634a011-28fa-41d7-8d6e-3f68ccb131d0=0A=
>>>                   Total devices 3 FS bytes used 56.74TiB=0A=
>>>                   devid    1 size 25.46TiB used 22.70TiB path /dev/sda1=
=0A=
>>>                   devid    2 size 25.46TiB used 22.69TiB path /dev/sdb1=
=0A=
>>>                   devid    3 size 25.46TiB used 22.70TiB path /dev/sdd1=
=0A=
>>>=0A=
>>> btrfs fi df /vmbackup/=0A=
>>> Data, RAID0: total=3D66.62TiB, used=3D56.45TiB=0A=
>>> System, RAID1: total=3D8.00MiB, used=3D4.36MiB=0A=
>>> Metadata, RAID1: total=3D750.00GiB, used=3D294.90GiB=0A=
>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B=0A=
>>>=0A=
>>> Attached the dmesg.log, a few dmesg messages following regarding the di=
fferent errors (some informations redacted):=0A=
>>>=0A=
>>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 er=
rs: wr 0, rd 0, flush 0, corrupt 69074516, gen 184286=0A=
>>>=0A=
>>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 er=
rs: wr 0, rd 0, flush 0, corrupt 69074517, gen 184286=0A=
>>>=0A=
>>> [Mon Feb 28 18:54:23 2022] BTRFS error (device sda1): unable to fixup (=
regular) error at logical 776693776384 on dev /dev/sdd1=0A=
>>>=0A=
>>> [Mon Feb 28 18:54:25 2022] scrub_handle_errored_block: 21812 callbacks =
suppressed=0A=
>>>=0A=
>>> [Mon Feb 28 18:54:31 2022] BTRFS warning (device sda1): checksum error =
at logical 777752285184 on dev /dev/sdd1, physical 259607957504, root 10874=
7, inode 257, offset 59804737536, length 4096, links 1 (path: cephstorX_vm-=
XXX-disk-X-base.img_1645337735)=0A=
>>>=0A=
>>> I am able to mount the filesystem in read-write mode but accessing spec=
ific blocks seems to crash btrfs to remount into read-only=0A=
>>> I am currently running a scrub over the filesystem.=0A=
>>>=0A=
>>> The system got rebooted and the fs got remounted 2-3 times. I made the =
experience that usually btrfs would and could fix these kinds of errors aft=
er a remount, not this time though.=0A=
>>>=0A=
>>> Before I ran =93btrfs check =96repair=94 I would like some advice at ho=
w to tackle theses errors.=0A=
>>=0A=
>> The corruption and generation event counts indicate sdd1 (or one of its=
=0A=
>> component devices) was offline for a long time or suffered corruption=0A=
>> on a large scale.=0A=
>>=0A=
>> Data is raid0, so data repair is not possible.  Delete all the files=0A=
>> that contain corrupt data.=0A=
>>=0A=
>> If you are using space_cache=3Dv1, now is a good time to upgrade to=0A=
>> space_cache=3Dv2.  v1 space cache is stored in the data profile, and it =
has=0A=
>> likely been corrupted.  btrfs will usually detect and repair corruption=
=0A=
>> in space_cache=3Dv1, but there is no need to take any such risk here=0A=
>> when you can easily use v2 instead (or at least clear the v1 cache).=0A=
>>=0A=
>> I don't see any errors in these logs that would indicate a metadata issu=
e,=0A=
>> but huge numbers of messages are suppressed.  Perhaps a log closer=0A=
>> to the moment when the filesystem goes read-only will be more useful.=0A=
>>=0A=
>> I would expect that if there are no problems on sda1 or sdb1 then it=0A=
>> should be possible to repair the metadata errors on sdd1 by scrubbing=0A=
>> that device.=0A=
>>=0A=
>>> Kind regards=0A=
>>> Carsten Grommel=0A=
>>>=0A=
