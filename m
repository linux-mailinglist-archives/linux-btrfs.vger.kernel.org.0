Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D097B4CF28C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 08:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiCGH0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 02:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiCGH0P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 02:26:15 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEBD64E0
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 23:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0QomKKEPEuPxox88bQsVkn6jm0BAS5heF2a9a44plDAB8c7nDId7k5QQOyWyPzLkTKhhd6c5s2gE9PadBT92wROqPGVRSu2lXL7az4MOu066NSBrxtYiNmAeYtlVxJRDEJG/XGT9u6Fb6XxaBHQSbktH/LYMVO1JqDcbza2ozNiidzMBzuWV6ZsQYy+uIr9x9NW0URy71HuiRqlQwAuMkRAdHP5D9HMLE2HPwBZHerejBTwhrsTz4XvRumwzYO/n73olGxHwKlJ/OixRq7lksqMwOnmhyop9r0LwVMWM25YU9UjNDYXcIocV2etUcbToplxexhtJktzG5czMlJ6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITI5Ta1R60CwhnOq+OOV0kH3+q1VK85se08UESarxro=;
 b=NggPZlTTd8Nl9IZ+mw6XArJZzsz+opQ2XrOW0fVKl/Hn5zduLBp1w3NrEZ9cTnPiPoiUMK32IfbfRLGTJe56PuCGQb8EGNGubb63l9Lc80OwwZPkhWFqqLii/jdfU14sXJ6WfHIDvcZxTWWP4kQYsV1JBO4lUfB/s9jfUfZgzec6esVuWFnMF9Padko8hARqReWl5zocvzp/vvw8p2plIyy55NNA9BrhZs7L4N/bRmaGZUZCDuN9tAnBMP2h6du3WvCqkwiY3gtl1w3t5szMYlzijfVO1MTj5szhrtMgRuYl/R/dcFgu1nWga+x+fRFnKpnDtYiDHDb9dT8r07cctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=profihost.ag; dmarc=pass action=none header.from=profihost.ag;
 dkim=pass header.d=profihost.ag; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bmdo.onmicrosoft.com;
 s=selector2-bmdo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITI5Ta1R60CwhnOq+OOV0kH3+q1VK85se08UESarxro=;
 b=sSHwJikU1tgQs1FcQNyjR8VtPJOkT55yk/GfTloBZZ532EpX74zSOdaDJAIcdTt4oOKjKFk7bIm8qG+W6EHmn2bRTDcgOBUyW+I/uwrgwF2n4WED0fJpZBpSjqqrY3S0zOXxwd2odJy5C9HNpL5zCMYNGqchw4VG4O1HbuBwt+g=
Received: from AM0PR08MB3265.eurprd08.prod.outlook.com (2603:10a6:208:56::32)
 by VI1PR0801MB1646.eurprd08.prod.outlook.com (2603:10a6:800:4f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 07:25:16 +0000
Received: from AM0PR08MB3265.eurprd08.prod.outlook.com
 ([fe80::ed98:1a5c:2ede:8155]) by AM0PR08MB3265.eurprd08.prod.outlook.com
 ([fe80::ed98:1a5c:2ede:8155%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 07:25:16 +0000
From:   Carsten Grommel <c.grommel@profihost.ag>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: AW: AW: How to (attempt to) repair these btrfs errors
Thread-Topic: AW: How to (attempt to) repair these btrfs errors
Thread-Index: AQHYLNKzWsbDNPNvmUqwF5z6etdMhKyqXA4HgAc/oACAAeyr8IAAAysAgAADOaU=
Date:   Mon, 7 Mar 2022 07:25:16 +0000
Message-ID: <AM0PR08MB3265B4FA65082A7FDEB942248E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
References: <AM0PR08MB326504D6D0D7D3077A13C7DE8E019@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <AM0PR08MB3265280A4F4EF8151DA289F58E029@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <YiQQOFQO7G4NZTKS@hungrycats.org>
 <AM0PR08MB3265F930C35B1AFBA7E981B18E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <5379ca8e-0384-b447-52c1-a41ef0ded7e7@gmx.com>
In-Reply-To: <5379ca8e-0384-b447-52c1-a41ef0ded7e7@gmx.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 7c9ba711-40b9-5d05-11df-5b323014400c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=profihost.ag;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abe3b5ab-4f91-4f92-1dd1-08da000ba08d
x-ms-traffictypediagnostic: VI1PR0801MB1646:EE_
x-microsoft-antispam-prvs: <VI1PR0801MB16469424DAF94E4E33DCF0B18E089@VI1PR0801MB1646.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWHPQn70Yw2n29Uzxsh6eowhvmJkqg6QpMVuIrmHfz8gWfdnNn09nww5FF3MnwCHuxceMwJcN5X8PRyyFGlUsbzZanSQbrzi17VzDjf2nGlXDvdoi7c/UIcrjTYvkYSWi5v2oR9NeIDiHm5wlCO5UK94n/k3yrBxeVtlnsskcO+qi78DL2GnzXRQIfRyS2z2kNH/E40BCZxuCxTcY/uNyYakX2PtRRHRDEGzr0YLdDAee9PAkaoHCeZlPgH1kTMrMCO45L7HG9mvwjVtZGELVEy6F3eL8wfdMvWr38pPFeP1CXJ1PuI251jLtLWo/7VT6eIC6pPxKgQb71t685RBUMbv7YHh39sylDEvlKCylZua2O4TspBmPdrGLMDc7//MfI96Gwj+llr1JhHsK18eChTIKD0VB7O8ZseTmdGNYdRjRsqawAKmmuYDjXrISrysEr0lLFV+disZIq0kOY3p1v5y8jrpUoWGXIWhTYQEPJfpkKMLhZY8EWYqCGQqtMElyRy20CIQ+R4t08Zmzpf35l9NN53yNyI7QdglaxO1zsDYEug/afSIJnOWcYvj4qx/IDIrYqE2AS1EEboBYX6ate+mxg0bI5nPCgHm+fcIP0CUo1fPFHUBEVUjWkUUXll4qg4aPOOgDRyLh/xWG2gJ2plgR2M1qYoUqpOiJKZL2XYVOh6qix/xSrzjbCSZkpxfLo7O9Bmwjo+qr4ChtMpLlzpGDD6k7fpraXpnPYsqc+2D86hHZp3vjnC1W3apwObPYxZDTuiEfKFvLE1FLL+ku0TRbK12UfSEx4vqy0GwoWbKsB8jHNZDpymc1MjaSWNLUqnN/w5jMkikpT2WWSqm5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3265.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(122000001)(8676002)(64756008)(9686003)(66446008)(66946007)(316002)(66556008)(66476007)(52536014)(966005)(76116006)(53546011)(7696005)(71200400001)(6506007)(110136005)(4326008)(38100700002)(91956017)(38070700005)(5660300002)(26005)(66574015)(2906002)(83380400001)(508600001)(33656002)(86362001)(55016003)(186003)(10126625002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?mBAvRz66mJEbBHEtt3pvCm4AbFohVvRIPaPo5FMHNp6YlY6IXFJCnE5N?=
 =?Windows-1252?Q?iSu4DglGO5bgi11ax1DHT7m03Uf7IWhFznNnzYI7CERo3QoqP0Uklex2?=
 =?Windows-1252?Q?2gj5lSyhO57K/zdBOjM45Qhr7M1IcCSQo3rzn9l031ETjpLS9HcRxs3V?=
 =?Windows-1252?Q?JsJXjjbfldzO5QWwlM0q0qdKQhtWT0e37LhbrGcSOahDu5vlDCB3d2Ju?=
 =?Windows-1252?Q?JYp8aSwO3nksfJWMXLY7hkzBbaB5x6N4vmZBRoAIY9b03fxpoASas7qI?=
 =?Windows-1252?Q?uHx18fXNMdeosxx0j883h9gpMYC9c0uIivPU/6LVD7TElZKvntxF7w8W?=
 =?Windows-1252?Q?4jY0SguwDTE0MlzaHj9en4V9PmO6rXNdeuQsplEecsUMUC/D4SjAUTzj?=
 =?Windows-1252?Q?Qr3f525BN12MzXwPRh9CX2JzYkLMTVHTsbJ2XIWZ1OavIWz6md2Nh2rh?=
 =?Windows-1252?Q?bthg6kYCeGsh30UP62hbRjE3XnC97b0XV/CTA0XCPDDpSKTybM9C8tg9?=
 =?Windows-1252?Q?sHp6z6f1cPUNtMG2//7Ksmsk6AXju3hwrtDHmceWX+zKaG6sNBLeL/Oa?=
 =?Windows-1252?Q?JPTvLew7+xPoEEuxA/EdmbZNSfbL510hrIkrEJRWBn2LzsA3guBHu/VB?=
 =?Windows-1252?Q?JJ/+IPi+Tl94lpxU0dwN2Hzq6PET7EdFn4JIg+72Poac8Qipos39ZSLf?=
 =?Windows-1252?Q?CBFAXW+JppXhuB2JGstxZEhOj8ua+kTVumYgSzQjHtydZEVuRzDjcAbK?=
 =?Windows-1252?Q?7r9VKSqW1hxfsgld2P/sjSE9McC0qWnd8PWVZimSNGmEd5VCNnE+JbaJ?=
 =?Windows-1252?Q?PQqOw9+NIOrINTSK0Cdrav96W99HNlTm98uvfa1jsNVOwv5YSpJw0GVD?=
 =?Windows-1252?Q?9gHkC3n2f/ujI9omORUJg44vgQm7R4cJBeNWGX/ymrez8db5Dvj7gycn?=
 =?Windows-1252?Q?s45Yetz8oAB6o0kSGvdZJfw+z4HVfDbLUxdEMXGcc7ztFEmXjF8ldo2T?=
 =?Windows-1252?Q?7kKWa4j3h+YO3QRFlcXUxvugyOrs0UzPotNtcfxGRmTmtfGUDe7heQgl?=
 =?Windows-1252?Q?D/fP4KFkiiezVL09EE9uEutSSn1Cum2ib2f7UP4TgwjL0UA8ZDPCPxw3?=
 =?Windows-1252?Q?UVzg2rukL6mILa0Zu+vVr0QMWWPX81yHK1olc5pXgFzwxHSTptnbYf4u?=
 =?Windows-1252?Q?3YCZ2kmvS9sBVrv7EkKIXY1YqshzYPUlPaTmUgE0OvxzrO5TM40Q5v8p?=
 =?Windows-1252?Q?ieVvRERpdR3v3Ko/JaiRTiChdI2x3565MNlMaA+Dm2jjxYJgj4anhAzH?=
 =?Windows-1252?Q?+F07NG4m/p3kcpwOuMTDf2IZLRggrOYl5tdsq1q4RdvIuQiBUae096Q/?=
 =?Windows-1252?Q?Ks94j65W3EZIlim867OHtP1eUidf6oQuCnETu6K5FwIu3d2LgJ5+d3zn?=
 =?Windows-1252?Q?D3PXirMoYyALzM7IyrxRG51GCbhk1SyBrsPcgFg8tzjOjyZH/X4Wlhj/?=
 =?Windows-1252?Q?Vh8V8oZDVB/UkwymxXIHbD3pVG3JrMoIcIseni2ku5B7VP1fISd46av+?=
 =?Windows-1252?Q?WhDNQnBlM80+Oq6bX6T1dQXDpKghRda8v54exNHSIaJSEouYicmowcR1?=
 =?Windows-1252?Q?Fgtxihecvkvk0U26goXknxhmHTrOO3jhykvcjXRtm7hnkQhVm6sO1iY4?=
 =?Windows-1252?Q?/jlZYLWO98TePnexRLJmx8n/AgJIZOUjmtBJdz7Tv614tZAkPhKyjw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: profihost.ag
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3265.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe3b5ab-4f91-4f92-1dd1-08da000ba08d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 07:25:16.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b3201e87-5c43-439a-8fa3-eab13a770d4a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IV46cJ5uk717t9JEkP9Vc+RWJsf7Hp+dQDqysf8Ey5+IbEA/2iXUFiYicpeQy8dd1FmvGeGZ8JZyLeruztOvhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1646
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu, =0A=
=0A=
>Mind to share a dmesg just after the RO fallback?=0A=
=0A=
the most recent crash: =0A=
=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.191649] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 94652=
=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.194011] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 94652=
=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.195395] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 12609=
7=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.196620] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 12609=
7=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.197920] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 12609=
7=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.212980] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 16155500953600 (dev /dev/sde1 sector 1054=
6500256)=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.214413] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 16155500957696 (dev /dev/sde1 sector 1054=
6500264)=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.215204] BTRFS error (device sdc1=
): parent transid verify failed on 16155500953600 wanted 126097 found 94652=
=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.215656] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 16155500961792 (dev /dev/sde1 sector 1054=
6500272)=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.230156] BTRFS: error (device sdc=
1) in btrfs_finish_ordered_io:2736: errno=3D-5 IO failure=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.233127] BTRFS info (device sdc1)=
: read error corrected: ino 0 off 16155500965888 (dev /dev/sde1 sector 1054=
6500280)=0A=
Mar  4 01:43:15 cloud8-1550 kernel: [45667.247096] BTRFS info (device sdc1)=
: forced readonly=0A=
=0A=
________________________________________=0A=
Von: Qu Wenruo <quwenruo.btrfs@gmx.com>=0A=
Gesendet: Montag, 7. M=E4rz 2022 08:11=0A=
An: Carsten Grommel; Zygo Blaxell=0A=
Cc: linux-btrfs@vger.kernel.org=0A=
Betreff: Re: AW: How to (attempt to) repair these btrfs errors=0A=
=0A=
=0A=
=0A=
On 2022/3/7 15:03, Carsten Grommel wrote:=0A=
> Thank you for the answer. We are using space_cache v2:=0A=
>=0A=
> /dev/sdc1 on /vmbackup type btrfs (rw,noatime,nobarrier,compress-force=3D=
zlib:3,ssd_spread,noacl,space_cache=3Dv2,skip_balance,subvolid=3D5,subvol=
=3D/,x-systemd.mount-timeout=3D4h)=0A=
>=0A=
>> Data is raid0, so data repair is not possible.  Delete all the files=0A=
>> that contain corrupt data.=0A=
>=0A=
> I tried but as soon as I access the broken blocks btrfs fails into readon=
ly so I am kind of in a deadlock there.=0A=
=0A=
Btrfs only falls back to RO for very critical errors (which could affect=0A=
on-disk metadata consistency).=0A=
=0A=
Thus plain data corruption should not cause the RO.=0A=
=0A=
Mind to share a dmesg just after the RO fallback?=0A=
=0A=
Thanks,=0A=
Qu=0A=
=0A=
>=0A=
>> I don't see any errors in these logs that would indicate a metadata issu=
e,=0A=
>> but huge numbers of messages are suppressed.  Perhaps a log closer=0A=
>> to the moment when the filesystem goes read-only will be more useful.=0A=
>=0A=
>> I would expect that if there are no problems on sda1 or sdb1 then it=0A=
>> should be possible to repair the metadata errors on sdd1 by scrubbing=0A=
> that device.=0A=
>=0A=
> I ran a number of scrubs now, at some point it always fails and btrfs rem=
ounts into readonly.=0A=
> I did not yet try to scrub specifically on sdd though, gonna try that.=0A=
>=0A=
> Should it remount again i will provide the most recent dmesg's right befo=
re it crashes.=0A=
>=0A=
> ________________________________________=0A=
> Von: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>=0A=
> Gesendet: Sonntag, 6. M=E4rz 2022 02:36=0A=
> An: Carsten Grommel=0A=
> Cc: linux-btrfs@vger.kernel.org=0A=
> Betreff: Re: How to (attempt to) repair these btrfs errors=0A=
>=0A=
> On Tue, Mar 01, 2022 at 10:55:50AM +0000, Carsten Grommel wrote:=0A=
>> Follow-up pastebin with the most recent errors in dmesg:=0A=
>>=0A=
>> https://pastebin.com/4yJJdQPJ=0A=
>=0A=
> This seems to have expired.=0A=
>=0A=
>> ________________________________________=0A=
>> Von: Carsten Grommel=0A=
>> Gesendet: Montag, 28. Februar 2022 19:41=0A=
>> An: linux-btrfs@vger.kernel.org=0A=
>> Betreff: How to (attempt to) repair these btrfs errors=0A=
>>=0A=
>> Hi,=0A=
>>=0A=
>> short buildup: btrfs filesystem used for storing ceph rbd backups within=
 subvolumes got corrupted.=0A=
>> Underlying 3 RAID 6es, btrfs is mounted on Top as RAID 0 over these Raid=
s for performance ( we have to store massive Data)=0A=
>>=0A=
>> Linux cloud8-1550 5.10.93+2-ph #1 SMP Fri Jan 21 07:52:51 UTC 2022 x86_6=
4 GNU/Linux=0A=
>>=0A=
>> But it was Kernel 5.4.121 before=0A=
>>=0A=
>> btrfs --version=0A=
>> btrfs-progs v4.20.1=0A=
>>=0A=
>> btrfs fi show=0A=
>> Label: none  uuid: b634a011-28fa-41d7-8d6e-3f68ccb131d0=0A=
>>                  Total devices 3 FS bytes used 56.74TiB=0A=
>>                  devid    1 size 25.46TiB used 22.70TiB path /dev/sda1=
=0A=
>>                  devid    2 size 25.46TiB used 22.69TiB path /dev/sdb1=
=0A=
>>                  devid    3 size 25.46TiB used 22.70TiB path /dev/sdd1=
=0A=
>>=0A=
>> btrfs fi df /vmbackup/=0A=
>> Data, RAID0: total=3D66.62TiB, used=3D56.45TiB=0A=
>> System, RAID1: total=3D8.00MiB, used=3D4.36MiB=0A=
>> Metadata, RAID1: total=3D750.00GiB, used=3D294.90GiB=0A=
>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B=0A=
>>=0A=
>> Attached the dmesg.log, a few dmesg messages following regarding the dif=
ferent errors (some informations redacted):=0A=
>>=0A=
>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 err=
s: wr 0, rd 0, flush 0, corrupt 69074516, gen 184286=0A=
>>=0A=
>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 err=
s: wr 0, rd 0, flush 0, corrupt 69074517, gen 184286=0A=
>>=0A=
>> [Mon Feb 28 18:54:23 2022] BTRFS error (device sda1): unable to fixup (r=
egular) error at logical 776693776384 on dev /dev/sdd1=0A=
>>=0A=
>> [Mon Feb 28 18:54:25 2022] scrub_handle_errored_block: 21812 callbacks s=
uppressed=0A=
>>=0A=
>> [Mon Feb 28 18:54:31 2022] BTRFS warning (device sda1): checksum error a=
t logical 777752285184 on dev /dev/sdd1, physical 259607957504, root 108747=
, inode 257, offset 59804737536, length 4096, links 1 (path: cephstorX_vm-X=
XX-disk-X-base.img_1645337735)=0A=
>>=0A=
>> I am able to mount the filesystem in read-write mode but accessing speci=
fic blocks seems to crash btrfs to remount into read-only=0A=
>> I am currently running a scrub over the filesystem.=0A=
>>=0A=
>> The system got rebooted and the fs got remounted 2-3 times. I made the e=
xperience that usually btrfs would and could fix these kinds of errors afte=
r a remount, not this time though.=0A=
>>=0A=
>> Before I ran =93btrfs check =96repair=94 I would like some advice at how=
 to tackle theses errors.=0A=
>=0A=
> The corruption and generation event counts indicate sdd1 (or one of its=
=0A=
> component devices) was offline for a long time or suffered corruption=0A=
> on a large scale.=0A=
>=0A=
> Data is raid0, so data repair is not possible.  Delete all the files=0A=
> that contain corrupt data.=0A=
>=0A=
> If you are using space_cache=3Dv1, now is a good time to upgrade to=0A=
> space_cache=3Dv2.  v1 space cache is stored in the data profile, and it h=
as=0A=
> likely been corrupted.  btrfs will usually detect and repair corruption=
=0A=
> in space_cache=3Dv1, but there is no need to take any such risk here=0A=
> when you can easily use v2 instead (or at least clear the v1 cache).=0A=
>=0A=
> I don't see any errors in these logs that would indicate a metadata issue=
,=0A=
> but huge numbers of messages are suppressed.  Perhaps a log closer=0A=
> to the moment when the filesystem goes read-only will be more useful.=0A=
>=0A=
> I would expect that if there are no problems on sda1 or sdb1 then it=0A=
> should be possible to repair the metadata errors on sdd1 by scrubbing=0A=
> that device.=0A=
>=0A=
>> Kind regards=0A=
>> Carsten Grommel=0A=
>>=0A=
