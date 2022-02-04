Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2744A971F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 10:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357873AbiBDJtj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 04:49:39 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:42629 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357849AbiBDJt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Feb 2022 04:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1643968168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VE+Xrj/x1h7MBdn56Jb/AH0iFem/fjplPgbl8+yvM+U=;
        b=bkbz8+utKQrku7kf+D8t3polUtf/VdR4BenzeAkj0WvB/rl3Dmz4RUlmtS3IaDKvhzG94f
        kcpXEW4cK6uJ/uAJi1tFPm9ghn9hMwybKcQH6Cav8+OdLtDCFpj53TvVgmcjHAd14CVwCH
        5FlaKjm3szbdRjfiWfP2MVAmMtUmyPM=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2051.outbound.protection.outlook.com [104.47.9.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-OQapZIr6MOCISQlZMV3iIA-1; Fri, 04 Feb 2022 10:49:27 +0100
X-MC-Unique: OQapZIr6MOCISQlZMV3iIA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0EaPJ1zkJKQbcMH7IfgpxuOdCgHdCevcq9g5o+OjLE/tywcJMtTqqSPmB3Wt8p1RYpaz4qPa0v0j+dCadxVqudaBcAHyjv5hS4332e31lIpReTO+mANyO+o2v9qeHYjNEAE3GSz89gDwhUoistX0sC90EL4kGuE6wlqRZ3xmLnVawLJsRr3dwihX9Hw15bUtIw3AznqjQdCPiix3Kb8SIi6Vpz3c/ltd5QeaCWFO+vrJ0WsUuKQ2eqtHZ38vS0SIopZPtJFbcz6qI0oxkSdbbmGSYDI41omrl+iT+bKLNIGwsrqWXkRu0TpvWlXeLQ11iZce9NK8ayUdaVSI6Ycmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45fHoGywnmtkhDzm2t0x0Manaf5Q6NLo/eUGvw7Akb0=;
 b=jHaTYGCSWw8WxoywDEBgpI8rJJe7gndJlxGujA9tgV/hGbWJapJKI6cORdKJrtTgjXbb8YWJ3+XAOVyUDu4tsyQyO6QiNIhGUEYqhg+HTX6dG+epVvC8C1UVnF7MmcDBFFAp6pea0sk4qVccnoLsT/8oQwCeD6jNejxlQlhVZD2t5RZzQW8VlvjcovwMJZI6nL+idpsaFFvRTeIbWS2lvFNm3mogS4Y//bY6LrShazBBUA0Y+Xet/KlANevUQvBWqX2MyBueveP2jQfSm77cAJOtW+PA+gmLfeP5FM+GIejbUA+OGJgU3rjOagAfyMgUGVimQ2BTfjTY960aR5CriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DB6PR04MB3015.eurprd04.prod.outlook.com (2603:10a6:6:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Fri, 4 Feb
 2022 09:49:24 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e%7]) with mapi id 15.20.4951.012; Fri, 4 Feb 2022
 09:49:24 +0000
Message-ID: <4fdf158c-203e-6def-27e1-8a003775693c@suse.com>
Date:   Fri, 4 Feb 2022 17:49:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois-Xavier_Thomas?= <fx.thomas@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220125065057.35863-1-wqu@suse.com>
 <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com>
 <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
 <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
 <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
 <e67bb761-c4bf-b929-0bee-650f425248ac@gmx.com>
 <6f76b518-b509-dd45-11bd-c75aa78a5898@gmx.com>
 <CAEwRaO4Fo6k2-UjtJaAKjnP79a02C2eQsjoju41HXOzNP9nL-w@mail.gmail.com>
 <CAEwRaO69PQKC1Hn=vWt92BNk8ZQwtz4t9dW4uHYJpGGqYkmjNA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper
 defrag
In-Reply-To: <CAEwRaO69PQKC1Hn=vWt92BNk8ZQwtz4t9dW4uHYJpGGqYkmjNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43de5adc-8b84-493a-ada4-08d9e7c39fe7
X-MS-TrafficTypeDiagnostic: DB6PR04MB3015:EE_
X-Microsoft-Antispam-PRVS: <DB6PR04MB3015FB78F2ED0AEA07088650D6299@DB6PR04MB3015.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KjnNuzZ8Ogqz0WGExp4ZE+GChpVDgl2FCsxZnxeDh7MKljlXnh/aVRC+gMkIooHPZTnJPbqG1MMET6IKfFkCew19XdPtg5+3rdJ7TsbmJeIVl+NCyzmkDjjJg6ZaaR3bh3e/dytyB2T8l7PWo7S6qbd0xPB3lyvTHzK1iH7LwCQ8VjTBg1h8qyydNjWOd52JmdmP98QopI8Aaguj8i4seXhwaXsRZ+bww/t8UFw7j4KvZUHyfq9FsZglZ/k+sEosfHAAMs1c6EEGCz683ryz/1XKxkVj03CXrAekfTtn6qH3no6rPjrPDJio0MHo8N/CDx6/Kb1epqqQgcepEuMtu/J44bmRbUBs2HTCL7WbC6cinwAnUlhI4NxyPiQsxLCXOTx53R5BHH7UCqd/v30jIt/c1nDmPnoyn3maFJnHXdSk/YjRAjzngcwRlCMuf/wr83UdJQuD48ysGY1JiL64pC9sqTAdiQiDHR2ubB6iOtgw/iSZf9cdyHvUJWabli7mg02KnGCvUnOkBvTfQKfP9N5g3+U3PMrwYKf6ebveklx+8bo4P64XHqG83lQv5mrSiWzws7Ism+ijT5V8SAgE0uaL2IgVCvMROCRFuAyEd1hOVcSz19MFbJICz38nG2c9PzrxHKQhH7TbxaK0WznVuow2/DiTjSuptd/xaQkF5BVkgqr1PQAz5jhdThr6Tm6dgjdPjagXmYdZbJ1Fgy7UzsbOdmKNL9RXh1lT6wojiz8BAQuRsZvCMBWZ49rzZ6pr3WYeMyrGjmuHPrCGwnCS1DnPuQqI3cUgqx7t7ZPDpexMbX5mqLoWW5WpN/qaZWyk7Prve/Tgmir91eYTAtSMnACCzp8TC8xr0Cd9LVgiqgc0LCPn8vUDQ6NRGQFZm7H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(54906003)(8936002)(508600001)(66476007)(6486002)(966005)(66946007)(186003)(26005)(66556008)(6666004)(316002)(31686004)(53546011)(6506007)(8676002)(36756003)(110136005)(4326008)(86362001)(6512007)(2616005)(2906002)(83380400001)(38100700002)(5660300002)(66574015)(45980500001)(43740500002)(15519875007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KP4aNn0XdRX4PfeLJFfS9AJ9JFXVMmiP6dShnLMgq0qiyJNZ0rfbDq02JqG6?=
 =?us-ascii?Q?q4nRSrGTmwckYtmWQCsqoJacjmKKxtyDsZKR3TPyDOsaWgj1CrmaKF/ONzJ8?=
 =?us-ascii?Q?r4KJs0v8KzND4TjqS4FLhRaZqazj7BV0+tHYStHNcMFkVbSoQ0IDu05IEbPJ?=
 =?us-ascii?Q?ilM+RJL3szCFmgWTc8hu2J6CBMuRI0TmF6DhTV08Zms7ePSk9YtYZtxJCpKD?=
 =?us-ascii?Q?BNCbNnoiZCmv5CVlhEgThakOLwkUFSxB7daFbAwnQWuGVZgcqPkvwKYRaXP1?=
 =?us-ascii?Q?HSnwuIrYt5O0lPiV7IFFEXInw6w9ISizTCNiq+sPmblhqbx0hmsBLmvlnYPn?=
 =?us-ascii?Q?0A4UFRvfykHcfRfoSTr++EWvBMQnIK1aa/H+vPNlSb9tN0bRieYZL5qcXlJ5?=
 =?us-ascii?Q?cQESumAapJzbio2Vp3/VDHayeu0kwW/KFhDywjkvS3FTzsfEvrbiQdAymFn3?=
 =?us-ascii?Q?afE52DUtszqYyVpNp4hc4OhcQ+6ahxF2kwOGQIB71FFnvNkZh7yrV0LAWpOn?=
 =?us-ascii?Q?ey+UNH7J9avGxUX89x7j03ykhcOFU5Ay3hH4Am0UyuqqOYb2DG4+QqvnnTHb?=
 =?us-ascii?Q?48Rulv2Q+Nb8+wc7Y6KlzhcdGf8kelnyPP7ykhWp0T3o3OAB7eTsYLKdm+oY?=
 =?us-ascii?Q?mZ0qw0rBJjiNuRkHceWxvvyz24qt+89EmpyJqnxcPwSZ+/3q6IdVHkf4+sz6?=
 =?us-ascii?Q?pqnP7AIXTEbiDMhfGgeW16DfzsLJAI3Wg72G+51ibJs9HoUS/9wiS0KyvPO4?=
 =?us-ascii?Q?jh9QXbgVTeFc4nrBX3BskEu9SB9a3XxqGp9RqsBeEFHOKIo3D3AmYFrf08Y9?=
 =?us-ascii?Q?p0aea56CPpcOtQbOAH0roirRQ3zl+bMr+0I2EP0E4qGcY/5VFQEVIR+39D/F?=
 =?us-ascii?Q?kU+HeBm6wa2z8Ii2I/zX0IJVgKd5CDfO4OT2S8p92bX0QBo2T3fHnvRhx3qS?=
 =?us-ascii?Q?ts7Zg+/vBt3UYap6YHg5wsOqyi0MKCYDQoBqtyob4bWNqrnG4/DK5L7Ur/LK?=
 =?us-ascii?Q?hx2g9iaVwok47MKJNf3Jo/v6jWfjOX3G1dPSubYH/KJoPFkG8Z9YPrF8ed85?=
 =?us-ascii?Q?vknAUFpPfL9fIVt0obsRDcKZNf9+X5ZITck4pWlLm5Bt/DFsHNH6JsHfM4fT?=
 =?us-ascii?Q?3zwziRifZ/KBZ8RvCORfQdOTmL7WG1umB3GCxZJxENl9TsgTB/I+5Hwkknrf?=
 =?us-ascii?Q?SenhXUYVgQQtgpBms5byvciKNhqBPB7XelzNOTOcTSji/QGztjIs03VSK9GU?=
 =?us-ascii?Q?IVUb0PdaR3aHA4nczPxIbP7akY6qpiiqFrRUxg7LNkbap1ZesXTiRlMzAbIA?=
 =?us-ascii?Q?oeDka3zeyazgm2BLK0jf21ZqBW30k+5eOq1ABr1UzfIZhRT0pIRgMiMG7ow2?=
 =?us-ascii?Q?31lJJbqpRSdCHK/QAbmQgfO2gLGw6xCPcig06QGZtEb0W93L6yXo1yfRNniN?=
 =?us-ascii?Q?O4mg6HWkJrOaRn4DNzETslSKQCql0qm01ClTCIMICkx2303Lwwoq5c2HDeAS?=
 =?us-ascii?Q?m2AFSpJghat8bE3v/QLunmlcmr0NM7hYOdXv3C9kuKGada06JR32LRSn5+Zz?=
 =?us-ascii?Q?b9qKlvEsx8+p+RoGgK8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43de5adc-8b84-493a-ada4-08d9e7c39fe7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 09:49:24.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8tq8kg39ot67iMAATxqwze7qtIHvdZypH5/BVs9cGxxhi1JHOE/IbMNHkGOlm/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3015
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/4 17:32, Fran=C3=A7ois-Xavier Thomas wrote:
> The increase in I/O is small but noticeable:
> https://i.imgur.com/IJ4lLI2.png
>=20
> I also checked 5.16.5 just in case, and the difference is still marked.
>=20
> Fran=C3=A7ois-Xavier
>=20

OK, then it means there is still something else involved.

But one thing to mention is, the color scheme is little weird to me.

Although the legend shows dark yellow (?) is read bytes/s, but in the=20
graph is more like pink.

The same applies to dark green (?) which is more like regular green for=20
sda write bytes/s.

So what I got from the graph is:

- v5.15.13 vanilla
   Less than 3 MB/s write for autodefrag,
   And has burst read around 15MB/s.

- v5.15.13 + final patch
   Approaching 5 MB/s write, and neat 20MB/s burst read.

   I believe this should be our base line.

- v5.16.5 vanilla
   10MB/s write, near 35 MB/s burst read.

For the write part, I don't really have better idea.

But for the read part, I'm working to bring back two optimization.

One is to skip large range which is not our target.
That patchset has been sent to the mail list:

https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D611214

The other one is to reduce the metadata IO and memory usage for extent=20
map searching.

In theory it should reduce the metadata IO, but I'm not yet confident=20
enough.

Will give you an update when the testing branch is fully prepared.

Thanks,
Qu

