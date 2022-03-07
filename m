Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BFC4CF292
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 08:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiCGH2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 02:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiCGH2W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 02:28:22 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0BB1C121
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 23:27:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5IJHq9UWNvZPvVOipCVSfkaOtORHQFZ9oAqWHYjlloX+LIz/r6cNUY1qpPOrAdcEu2pRckFCriPU/bOFFXpCoxn/DlHFg9SuxkX0DBDSTUl/Oor6GzSIlt4UksnF4Y+0mgRDXdq5oUWIOHJdw0wwGNRcbfNn9iWVnARu7KM6hvwAnHcIB6QpbB/LtZUxL2eh0o11rvignogLVzhlhNNamJn81N7yLgQhJkTfPdrMRC9+e1V1WES33f9J7QPj9lK7+R9lMRBxLHfNBdNRZCZZsne/34oAsaeWOris6Gqzqt6MQNOmWF3S2HgwjLbOXLX5B2z1EJuDyOzxCPhKJVJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH3guMe4drOcr6Z+o9WMwyCy+IFxDFeFs5vRcSRCc14=;
 b=nlzBdytb2AeDIi10tn/cYLtTUw4aaP2/FLIPQXLdAli8TAECTB3dsR8Fh89XVY2wmAF3RSYqQnkAyPi6x44RkE4qRjzpTY2TM1gKqTeLhDb5OVgzlfYFls0vnex9B0dmvFfefzpj3AK+6i8HvUY5//B7IkhZe5Ou2m+pp0ZQYC/5zlXHqevsVkPXpQeaEjKoVHSocvuTBjGVisKCiaO+InAEn8SammheCUCoQAsXV8QXiEY5b/9Ckj/FCCKBihLUog38gEJNcnsABf8rahwbW3+8XXzWJ3snyoOpkm/RHgBBYpLqClZgOe1Pk7ApikDLOe7YIO2LirxQ3C5UfJVSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=profihost.ag; dmarc=pass action=none header.from=profihost.ag;
 dkim=pass header.d=profihost.ag; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bmdo.onmicrosoft.com;
 s=selector2-bmdo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH3guMe4drOcr6Z+o9WMwyCy+IFxDFeFs5vRcSRCc14=;
 b=CphyXK70PKF+EkfNwXs50136xCCWhE01AREfGLUU42UQ7l3vVJz7/hjhEsgI0MGpwZDjNp7fQXKxI0pEriXYyJMnj8tpx3YOYn/rx+yJAk1avgLsWbiMxLe2yAXPfWERh//EYdpFJ93S+tSu5dpbfrfJ68ZRlQhR8uG1aZ/5BOA=
Received: from AM0PR08MB3265.eurprd08.prod.outlook.com (2603:10a6:208:56::32)
 by DB9PR08MB6681.eurprd08.prod.outlook.com (2603:10a6:10:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 07:27:23 +0000
Received: from AM0PR08MB3265.eurprd08.prod.outlook.com
 ([fe80::ed98:1a5c:2ede:8155]) by AM0PR08MB3265.eurprd08.prod.outlook.com
 ([fe80::ed98:1a5c:2ede:8155%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 07:27:23 +0000
From:   Carsten Grommel <c.grommel@profihost.ag>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: AW: AW: How to (attempt to) repair these btrfs errors
Thread-Topic: AW: How to (attempt to) repair these btrfs errors
Thread-Index: AQHYLNKzWsbDNPNvmUqwF5z6etdMhKyqXA4HgAc/oACAAeyr8IAAAysAgAADOaWAAAEGfA==
Date:   Mon, 7 Mar 2022 07:27:23 +0000
Message-ID: <AM0PR08MB32650EE051D9A01316C6525F8E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
References: <AM0PR08MB326504D6D0D7D3077A13C7DE8E019@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <AM0PR08MB3265280A4F4EF8151DA289F58E029@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <YiQQOFQO7G4NZTKS@hungrycats.org>
 <AM0PR08MB3265F930C35B1AFBA7E981B18E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <5379ca8e-0384-b447-52c1-a41ef0ded7e7@gmx.com>
 <AM0PR08MB3265B4FA65082A7FDEB942248E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
In-Reply-To: <AM0PR08MB3265B4FA65082A7FDEB942248E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: bf7c1864-5b85-18eb-0138-3b92b06a15cf
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=profihost.ag;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ba3a3e0-5cd8-4b16-ef38-08da000bec5a
x-ms-traffictypediagnostic: DB9PR08MB6681:EE_
x-microsoft-antispam-prvs: <DB9PR08MB66812F6C0D9D3EAD7A768BE68E089@DB9PR08MB6681.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XefwFMeH3QbCWV25Bwh3418OJKP3m6gQVVYEGoQFrRfeBBskpti1/2Bd8K+0yuMnx0aG0bHGvUcJpZekCufQxsdmPdchqNVnArWiM2Cc0U/HIEVaUkAAYekT06lofGE1iKa5bl+DgHS7lj9seNnC3eCVsjoBgNlEjE6KtICRGZpADnayLVjjj3RqbowvQa45w8zqaEAz99BNNmdKkfdDD8r7HN537DlB8hLkW2wK1EbmRUAJx2ix+s1b0Czkux+/P9P5EYhqxFQiJTA3AkZw5pq0Vtz7Psp/LLresJMTYS0+2tYSLc9IT/jmfjxvbd0Sy5bHY5MYVpZGTVi+g5qRbpcfngyTz3zjKJ2dP0tJOy5KaiB8RN1wUYVoFIcZtMnznlcNesiuXVO4siD9dK2JjVDM14T968sQLSC8Mqrt75qlkRsfv0HqpwpGsoFA8QcWQ94E7Dq6tp3h+tb+h8mIPiRWHqPzk/xVuLyRtYfsnAAfjLPUDcfvl8bml2CTL3j/DCwOLWFh5X8z1qjlT3akUPXVtZnu17vUEC6Q6dt0nds2DTaRXWEO2ER4vNRRJcXWWRdJNvCnVU4Vkag8K+d8PHmhCligLdRmoWwnK1opz9fluaPW446kn54ueAhL4zBPZ+hkIHmoXifAosvjD6nAjH0/vb8P7jX0/mI3FIItIogNisYaW9gOuuZQpRgREfcsw26fr3L3RgE+v6ZzL6+x04fW1Svokj55l4RQkZAYEkC2uBligyZDQKvFFUwV5u/PI15tzD9XK3RA0H1IuvPY53AaO7mn2PVe2sxjDnGpxYakbk4doBZUsZC6+OV4Fd5pwQW4Vzs/2bkyw0aX3UenTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3265.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(9686003)(6506007)(7696005)(53546011)(71200400001)(5660300002)(38100700002)(33656002)(110136005)(966005)(508600001)(76116006)(2940100002)(186003)(316002)(122000001)(2906002)(38070700005)(55016003)(86362001)(91956017)(66574015)(83380400001)(52536014)(8676002)(64756008)(66556008)(66476007)(66946007)(8936002)(66446008)(4326008)(10126625002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?gg2mP5EnQPz1mJe5YEGBiTVbQS+2pXerpVkle57JmcFGi8TE8uIKleoA?=
 =?Windows-1252?Q?ycxQacSXJ1OPcX1C0HBdHm+1WvV6JTDLtYjHlcVOtScyhdPNpDKoTfRV?=
 =?Windows-1252?Q?P5VF7lrg6M0poGOsrYTcbFCXzsSha+9R3s3rYOtTu2Oa5VZdl7JGps1U?=
 =?Windows-1252?Q?PPH3q/P+sMknoDgp2Kq5tZW+XJOLC5+31PamI6LmbaHjDFHXYCR8AtCU?=
 =?Windows-1252?Q?uh2AqI3WifFEwdFNNfEjU4Fx+cdknK4oBc+EpmVHblN/dMpx8ruDFALn?=
 =?Windows-1252?Q?V2XflGrb+j2dm6FAs11iFJLWyqIXAw9Jd90675Oj8GGnKBM+xHNzloWm?=
 =?Windows-1252?Q?mDcsFxdbGKkzVuA3bcvp6daprRfO2ykuMvXIbeVS9qUcuOABjHqtcgob?=
 =?Windows-1252?Q?JKEwLzd5FGmxnx3wVRQV3zdALZPqaGisWjdGNbYDRraG1baiUWkiPdPP?=
 =?Windows-1252?Q?T6kdPV0FukDo7HlZhoEKmqfTokXEcFjkapnT+O92Oin/2R4lchdqqmcy?=
 =?Windows-1252?Q?NQIbgy2dM49yWgKh+6fBEI+4zA1PdwWv5imH/1h6aBW1XM7W0BcSEkn7?=
 =?Windows-1252?Q?BOn+FpObcyb4n7qeyB8iyWlG1e8w5atEbZc+KrnpigSWmmbTkQN+NVVF?=
 =?Windows-1252?Q?7bPa2EGwgixynJABk6+c4774FckJ6QodrbBGVLLR2Eq5gdHFTtz6TMox?=
 =?Windows-1252?Q?ezG55UqqRazUF1GPXquPMLJIek8L9ptPx+9mRtBGTHAEJICY5ycPN3xa?=
 =?Windows-1252?Q?7zQONqxiHMhSo2aTg7gMnHaQQPjb6s07E3d5HpTmdv09XLu0MJYtkXpy?=
 =?Windows-1252?Q?ZeDDHkZdO7SX2vX+LPcBRjZ7Su2eiYIG0cthpVKQl4iMYHEVRd7XOAfs?=
 =?Windows-1252?Q?TaRZCYX6TUmjLCzx5j4jiMLzB6XnoZdo0Myf17mqlG8d8PQ/p7eXPY0d?=
 =?Windows-1252?Q?sToq1ud1El3jWghdkvx3aC3Q+0xmWpxnLORtPmLD9j/d9QH7K9l9fiTH?=
 =?Windows-1252?Q?8J9Y9uSjX7fdsUWetrua2A/k8rAP18Z2U9q1nBXaLOH75sVFemVj1KhJ?=
 =?Windows-1252?Q?aiGrq0lHQ1L1/E2RaqQ7zLkuEmrwo7texAE92YCBQHlcNz9+gnhZNbSD?=
 =?Windows-1252?Q?oiXDudjx8O45ydmrsqZLI0MNHZhAqvifrBrmfaQG8KFDHpKiRQe5Qt0o?=
 =?Windows-1252?Q?Kii19oS/jFQx/nZF8D28F5hkz4QkOWGI1SpA4oa6W8Xjta00o8ZK5tiF?=
 =?Windows-1252?Q?y4xhXb8E8OKU/hhDrJWD02tBJvtY0YSmd4fTH52cLtG18S8s4EMgTS3/?=
 =?Windows-1252?Q?UGwxEeDL0IzyrmNR9EBIfPB/WbprOuLE6bzTPH+rcPexWgxTYzzX5uQq?=
 =?Windows-1252?Q?LlRAkvDc/QvidaDUdtfDxDPR9b83Qdoi9/uouyjHPiErMRwD7+z3M7lF?=
 =?Windows-1252?Q?PqTlz4ZlgxdxAB9BBAXZ+3SRPAD3/20vD8D2y45rOxVWr2xyTNIX3X4s?=
 =?Windows-1252?Q?IMGnPc3qqEWoH7nMn6mBVn0lCUBslDY1ld2lQJFmkeBi94HJh3KaSAzT?=
 =?Windows-1252?Q?LJm95OqYqWkaA2e3ZcwSAiU0Mv2Zfi7bCtbF+OkIL5SAWBIRkPBqCLeS?=
 =?Windows-1252?Q?B8Z4alcz6BENrN/InwCgNZJpwhQg8POkugzpokqbX7EsG6KOiLNjGuqh?=
 =?Windows-1252?Q?jGTu2zOqOuEQTqf2kYmXasRI+aXk2sxJprDbEYkCAOkwog1JX1jkPw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: profihost.ag
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3265.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba3a3e0-5cd8-4b16-ef38-08da000bec5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 07:27:23.5744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b3201e87-5c43-439a-8fa3-eab13a770d4a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fOQbqMLraL2kGCEevDshsn7Pla+vVH742/2U0YESizq3pDXvlfwYryz2ciwcgsXs6B4O9GgIUaq9PsOPXAkEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6681
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These seems to be the most critical afaic:

Mar  4 01:25:51 cloud8-1550 kernel: [44623.523395] BTRFS critical (device s=
dc1): corrupt leaf: root=3D111550 block=3D849874468864 slot=3D0 ino=3D32633=
089 file_offset=3D7805042688, invalid compression for file extent, have 15 =
expect range [0, 3]
Mar  4 01:25:51 cloud8-1550 kernel: [44623.527109] BTRFS error (device sdc1=
): block=3D849874468864 read time tree block corruption detected
Mar  4 01:25:52 cloud8-1550 kernel: [44623.643308] BTRFS critical (device s=
dc1): corrupt leaf: root=3D50979 block=3D849880268800 slot=3D2, bad key ord=
er, prev (18446744073709551606 128 1269917216768) current (1844674407370955=
1606 128 1269916291
072)
Mar  4 01:25:52 cloud8-1550 kernel: [44623.648078] BTRFS error (device sdc1=
): block=3D849880268800 read time tree block corruption detected
Mar  4 01:26:30 cloud8-1550 kernel: [44662.087943] BTRFS critical (device s=
dc1): corrupt leaf: root=3D7 block=3D83188697202688 slot=3D0, unexpected it=
em end, have 16139 expect 16283
Mar  4 01:26:30 cloud8-1550 kernel: [44662.092173] BTRFS error (device sdc1=
): block=3D83188697202688 read time tree block corruption detected
Mar  4 01:26:30 cloud8-1550 kernel: [44662.094775] repair_io_failure: 170 c=
allbacks suppressed
Mar  4 01:26:30 cloud8-1550 kernel: [44662.094779] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 83188697202688 (dev /dev/sde1 sector 3800=
92288)
Mar  4 01:26:30 cloud8-1550 kernel: [44662.144525] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 83188697206784 (dev /dev/sde1 sector 3800=
92296)
Mar  4 01:26:30 cloud8-1550 kernel: [44662.147691] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 83188697210880 (dev /dev/sde1 sector 3800=
92304)
Mar  4 01:26:30 cloud8-1550 kernel: [44662.149705] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 83188697214976 (dev /dev/sde1 sector 3800=
92312)
Mar  4 01:26:30 cloud8-1550 kernel: [44662.156236] BTRFS critical (device s=
dc1): corrupt leaf: root=3D96207 block=3D83188697219072 slot=3D0, unexpecte=
d item end, have 16395 expect 16283

________________________________________
Von: Carsten Grommel <c.grommel@profihost.ag>
Gesendet: Montag, 7. M=E4rz 2022 08:25
An: Qu Wenruo; Zygo Blaxell
Cc: linux-btrfs@vger.kernel.org
Betreff: AW: AW: How to (attempt to) repair these btrfs errors

Hi Qu,

>Mind to share a dmesg just after the RO fallback?

the most recent crash:

Mar  4 01:43:15 cloud8-1550 kernel: [45667.191649] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 94652
Mar  4 01:43:15 cloud8-1550 kernel: [45667.194011] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 94652
Mar  4 01:43:15 cloud8-1550 kernel: [45667.195395] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 12609=
7
Mar  4 01:43:15 cloud8-1550 kernel: [45667.196620] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 12609=
7
Mar  4 01:43:15 cloud8-1550 kernel: [45667.197920] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 12609=
7
Mar  4 01:43:15 cloud8-1550 kernel: [45667.212980] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 16155500953600 (dev /dev/sde1 sector 1054=
6500256)
Mar  4 01:43:15 cloud8-1550 kernel: [45667.214413] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 16155500957696 (dev /dev/sde1 sector 1054=
6500264)
Mar  4 01:43:15 cloud8-1550 kernel: [45667.215204] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 94652
Mar  4 01:43:15 cloud8-1550 kernel: [45667.215656] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 16155500961792 (dev /dev/sde1 sector 1054=
6500272)
Mar  4 01:43:15 cloud8-1550 kernel: [45667.230156] BTRFS: error (device sdc=
1) in btrfs_finish_ordered_io:2736: errno=3D-5 IO failure
Mar  4 01:43:15 cloud8-1550 kernel: [45667.233127] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 16155500965888 (dev /dev/sde1 sector 1054=
6500280)
Mar  4 01:43:15 cloud8-1550 kernel: [45667.247096] BTRFS info (device sdc1)=
: forced readonly

________________________________________
Von: Qu Wenruo <quwenruo.btrfs@gmx.com>
Gesendet: Montag, 7. M=E4rz 2022 08:11
An: Carsten Grommel; Zygo Blaxell
Cc: linux-btrfs@vger.kernel.org
Betreff: Re: AW: How to (attempt to) repair these btrfs errors



On 2022/3/7 15:03, Carsten Grommel wrote:
> Thank you for the answer. We are using space_cache v2:
>
> /dev/sdc1 on /vmbackup type btrfs (rw,noatime,nobarrier,compress-force=3D=
zlib:3,ssd_spread,noacl,space_cache=3Dv2,skip_balance,subvolid=3D5,subvol=
=3D/,x-systemd.mount-timeout=3D4h)
>
>> Data is raid0, so data repair is not possible.  Delete all the files
>> that contain corrupt data.
>
> I tried but as soon as I access the broken blocks btrfs fails into readon=
ly so I am kind of in a deadlock there.

Btrfs only falls back to RO for very critical errors (which could affect
on-disk metadata consistency).

Thus plain data corruption should not cause the RO.

Mind to share a dmesg just after the RO fallback?

Thanks,
Qu

>
>> I don't see any errors in these logs that would indicate a metadata issu=
e,
>> but huge numbers of messages are suppressed.  Perhaps a log closer
>> to the moment when the filesystem goes read-only will be more useful.
>
>> I would expect that if there are no problems on sda1 or sdb1 then it
>> should be possible to repair the metadata errors on sdd1 by scrubbing
> that device.
>
> I ran a number of scrubs now, at some point it always fails and btrfs rem=
ounts into readonly.
> I did not yet try to scrub specifically on sdd though, gonna try that.
>
> Should it remount again i will provide the most recent dmesg's right befo=
re it crashes.
>
> ________________________________________
> Von: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Gesendet: Sonntag, 6. M=E4rz 2022 02:36
> An: Carsten Grommel
> Cc: linux-btrfs@vger.kernel.org
> Betreff: Re: How to (attempt to) repair these btrfs errors
>
> On Tue, Mar 01, 2022 at 10:55:50AM +0000, Carsten Grommel wrote:
>> Follow-up pastebin with the most recent errors in dmesg:
>>
>> https://pastebin.com/4yJJdQPJ
>
> This seems to have expired.
>
>> ________________________________________
>> Von: Carsten Grommel
>> Gesendet: Montag, 28. Februar 2022 19:41
>> An: linux-btrfs@vger.kernel.org
>> Betreff: How to (attempt to) repair these btrfs errors
>>
>> Hi,
>>
>> short buildup: btrfs filesystem used for storing ceph rbd backups within=
 subvolumes got corrupted.
>> Underlying 3 RAID 6es, btrfs is mounted on Top as RAID 0 over these Raid=
s for performance ( we have to store massive Data)
>>
>> Linux cloud8-1550 5.10.93+2-ph #1 SMP Fri Jan 21 07:52:51 UTC 2022 x86_6=
4 GNU/Linux
>>
>> But it was Kernel 5.4.121 before
>>
>> btrfs --version
>> btrfs-progs v4.20.1
>>
>> btrfs fi show
>> Label: none  uuid: b634a011-28fa-41d7-8d6e-3f68ccb131d0
>>                  Total devices 3 FS bytes used 56.74TiB
>>                  devid    1 size 25.46TiB used 22.70TiB path /dev/sda1
>>                  devid    2 size 25.46TiB used 22.69TiB path /dev/sdb1
>>                  devid    3 size 25.46TiB used 22.70TiB path /dev/sdd1
>>
>> btrfs fi df /vmbackup/
>> Data, RAID0: total=3D66.62TiB, used=3D56.45TiB
>> System, RAID1: total=3D8.00MiB, used=3D4.36MiB
>> Metadata, RAID1: total=3D750.00GiB, used=3D294.90GiB
>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>
>> Attached the dmesg.log, a few dmesg messages following regarding the dif=
ferent errors (some informations redacted):
>>
>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 err=
s: wr 0, rd 0, flush 0, corrupt 69074516, gen 184286
>>
>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 err=
s: wr 0, rd 0, flush 0, corrupt 69074517, gen 184286
>>
>> [Mon Feb 28 18:54:23 2022] BTRFS error (device sda1): unable to fixup (r=
egular) error at logical 776693776384 on dev /dev/sdd1
>>
>> [Mon Feb 28 18:54:25 2022] scrub_handle_errored_block: 21812 callbacks s=
uppressed
>>
>> [Mon Feb 28 18:54:31 2022] BTRFS warning (device sda1): checksum error a=
t logical 777752285184 on dev /dev/sdd1, physical 259607957504, root 108747=
, inode 257, offset 59804737536, length 4096, links 1 (path: cephstorX_vm-X=
XX-disk-X-base.img_1645337735)
>>
>> I am able to mount the filesystem in read-write mode but accessing speci=
fic blocks seems to crash btrfs to remount into read-only
>> I am currently running a scrub over the filesystem.
>>
>> The system got rebooted and the fs got remounted 2-3 times. I made the e=
xperience that usually btrfs would and could fix these kinds of errors afte=
r a remount, not this time though.
>>
>> Before I ran =93btrfs check =96repair=94 I would like some advice at how=
 to tackle theses errors.
>
> The corruption and generation event counts indicate sdd1 (or one of its
> component devices) was offline for a long time or suffered corruption
> on a large scale.
>
> Data is raid0, so data repair is not possible.  Delete all the files
> that contain corrupt data.
>
> If you are using space_cache=3Dv1, now is a good time to upgrade to
> space_cache=3Dv2.  v1 space cache is stored in the data profile, and it h=
as
> likely been corrupted.  btrfs will usually detect and repair corruption
> in space_cache=3Dv1, but there is no need to take any such risk here
> when you can easily use v2 instead (or at least clear the v1 cache).
>
> I don't see any errors in these logs that would indicate a metadata issue=
,
> but huge numbers of messages are suppressed.  Perhaps a log closer
> to the moment when the filesystem goes read-only will be more useful.
>
> I would expect that if there are no problems on sda1 or sdb1 then it
> should be possible to repair the metadata errors on sdd1 by scrubbing
> that device.
>
>> Kind regards
>> Carsten Grommel
>>
