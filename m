Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618303A3DF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 10:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhFKI2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 04:28:54 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:50148 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229733AbhFKI2y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 04:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623400015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGAPtrRq6a0uoykBGCnageWRIetBQut4R5f9TtMq+04=;
        b=EjP5eFcUIIAXKqSmuVIrGTVCcq9b3CBP14U1Dz9uY8wc75LJILh0JH7ZUcjtgmEsxNn0vF
        zRH7veQdmqQp8hZhPoJwC+glKvX0D0chgJ7UFYhr8s8fkW+opJPBxiOvd5ipLzyG3v0xIU
        8+RiqjjpDF4mrmKVFjfcyCXkwHMUjZs=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-LBK1cR6kMK-keep7C9uQnA-1; Fri, 11 Jun 2021 10:26:54 +0200
X-MC-Unique: LBK1cR6kMK-keep7C9uQnA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfUMXSh3M0eUNFLWYIpxCvc8h/TfTMePs7ZGgFBg3J8VhfzN7FStoukCGRmK+RtAbwYEAbz7OIbjxf2MgBqeS+RNb5JmsHep6axNYq+oWxwokQ99C+mpw3G72MlyHiYSIZO8Z8ltarI4evylfL1cmhwwHKe41VvL4lXk2lYnbgD4z5qH3RHsp5M3FE456Vxr2kO7I1Bi/UeNuiYIebJZ/OwwcpTwwFbY1PYvWuo7H4jrHUzpF3wYDID7JCe0VZuGGIj/ThYkUdAtTQzApHUDs19UfwkTelVdiG2n4a9r68f1xo4r/zBRZ21J3Zvvwz21Z7Ehsp572ITQ7DOX0NCraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EtUF8qR/dzxKgrphJQK2/dxxg778TtSuGJ9SHwcT1E=;
 b=NDNLEAJSeEKaAA7I1bUNWsn3yMldTxauYvHPKc780cWYVQBj2Pb5S1tYbvsDdEKya7tx6MgPlTe+Uzoz2YaNnrpli/NWcpRYPXLvDYWsmoCMVDPUIsge5V8VnL2mL/V0+7swIQyThsX0zn9qo9pvvtQAr23wmy7OwElXzKdHXlubAKhYc7YnKO2jk6OOMtGgBJMiHNZBU3c7WW9FLx1QHDj2zKEYmtDgGnZghB3ONpcbt/wLoXNeDc1kdDxPn3dkjhhOuwYSI+rJupa6A04kQl2WmHonFcpPCQqZ6FE8JBLsyQPT0f9VIddCaS1kIq73e9sAeIDWVFPH0qh9oLCMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5720.eurprd04.prod.outlook.com (2603:10a6:20b:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 11 Jun
 2021 08:26:53 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4195.032; Fri, 11 Jun 2021
 08:26:53 +0000
Subject: Re: [PATCH 8/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-9-wqu@suse.com>
 <PH0PR04MB741678D81425B3F3E24DD28D9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
 <3542ce4c-f2ce-c834-6866-eee6c28a967e@gmx.com>
 <PH0PR04MB7416BE7F9C7820B29E0EE18E9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <69317414-5e55-dfc9-a22d-4cc5a7c93f66@suse.com>
Date:   Fri, 11 Jun 2021 16:26:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <PH0PR04MB7416BE7F9C7820B29E0EE18E9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [45.77.180.217]
X-ClientProxiedBy: TYAPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::30) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TYAPR01CA0066.jpnprd01.prod.outlook.com (2603:1096:404:2b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 08:26:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 955c20c1-7b31-40ad-8cab-08d92cb2aac5
X-MS-TrafficTypeDiagnostic: AM6PR04MB5720:
X-Microsoft-Antispam-PRVS: <AM6PR04MB57205B397A79932476BDCB01D6349@AM6PR04MB5720.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZu9qt09eS0DU7ceY+dyTEiHLXv+zKHQJ/hokGH3oLmmeG9rE6mO0SAr/a5tE/PP2RprpO0rzKHJqYCvZ3hW6M9KK8EH/B73Wf9+dY4pCqna4cvkmdIHcLrqF1wADOT+5z66bXEreac1HykDXObQ/ykASYExPMceZ6pFslWMBe8ZrOYDun5jqqbPCD/1QkcKLdjrmODK4e8NKDThAakBzk5y78oZH5RUXn6VNmDCrcBtGuEeVvyTOY69Y9yKXm1Gy4Z+Ydl0Jmv4JSjli58QJMM2cbSfvK8TXCAKdP+zaJ9GWlxbeNfphNKEhRtFiAlet0tevrUJ4cBxWIeHD0BZLke29mpXkxcUfIXFW5SsoZyREkgnIJW319ZZ2kuke9zeUc+HP5Iyd3YSMGnfLTHGwlTrjWc6JVBB+35og1qQQUoSMjm5qEga3QA5f81hhDsUiZ3Ypu89UFea4eROwBD6l1Z4AIXEPW4rtVGEvFSl8VWhEzeR204Xu7mPeXmm5A+YkY8rkWAhPH9hVyt0x9EFgVzvoe79plr2hdFesu1gK9TAGdhvUmKp2ZjmDTIk2pVCK/tudyWWTj40E4+fZVr+Fz4nPfcd2uGzyYjsjS3UPWXDAZDQYOYJ7CLv+ql/ybYe6JnIy1Ot1F+tds6VJ1UIGf7xUZgtK3UmpAu5sutoXXwrRMvyC2TwYB2K/78jl34w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(366004)(39850400004)(2616005)(956004)(8676002)(6486002)(8936002)(31686004)(6706004)(86362001)(4744005)(2906002)(36756003)(478600001)(16526019)(316002)(110136005)(66476007)(66556008)(83380400001)(66946007)(53546011)(6666004)(38100700002)(186003)(26005)(55236004)(31696002)(5660300002)(16576012)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qyl78B3wh8BY6ckjqIrFEz0Z9vtwmLrO+ZcejUoMO3RikXgbmQwQWFSTglKp?=
 =?us-ascii?Q?1+YcGE6EUgTJWBR8S/xPs0SUC3AfxfcyBUsWehGZ3qSwx+/NXYLXJn3RrSdF?=
 =?us-ascii?Q?gqTXfsK6BD6bYjw7vpjZpFshOzX5wBik8xff62kSpP36Z4vo7OWSwaU4O8iU?=
 =?us-ascii?Q?EZ/dHBc3vYtnkFZeLHnIM5uluQi9nJDCX+TN0ohOFTZ4DioDjMigYOXbGRsL?=
 =?us-ascii?Q?1ALsHg6NbMunxN0j1awthP41rxnERBTmv0QvLE5OSpg3IIzqmvHzSypSGF0l?=
 =?us-ascii?Q?FMJbREDQaHkMWp30T97Ntx88NqT6Y4DxuHSNOHWWPTMI5bcX/QI6ZVIH92at?=
 =?us-ascii?Q?OagBwqJenNg3a2jLyv2rPEp6LFV5g1kMyBue/F+nCfLfsw71qZgGlM0r3+c0?=
 =?us-ascii?Q?DJ8KKa6WUdZle0lB02B0X8je5CvpJQXwYiRxYv5w1HI3Gtc15i0eXPfHGBgv?=
 =?us-ascii?Q?3UNouJkCtOX+Geb8+ZXzdyTuSzwa0JGVlbYOoZl+w67XIxzYFcaHoi7Ay6Bz?=
 =?us-ascii?Q?5uXRFcl6x6YsFM7F4WlXI+kkY5Mr7fDmUthAaT5OCU8Y8hFmd8o+32ihrJ42?=
 =?us-ascii?Q?Cvjgv1Yu/Mw4koUja3VVSQRf9Y8l7aYyfvC7qY4gRlLTPVXjRv9oizWG3CSf?=
 =?us-ascii?Q?G/XGB562srx/S7a6OdSoWcWTqZArucQZwwvuam2i8Yj88H8/z79klyslnQaj?=
 =?us-ascii?Q?XtfXmImMYQXo86POgM/ormfR0Mvkp0YHqZvRMTAY75LoHfEMXGOT4lshL8QL?=
 =?us-ascii?Q?EZv3QtkPvwFttCeZ5ljDrqS9SUbvd64VS1TRtiA3bxaDGR81QmCwToeGCEdc?=
 =?us-ascii?Q?5L5QhPRvwJmJ4SPy05rcq46YF0oC3JA8szTLj6hjbWJtXYpckDMCZwyjrW6h?=
 =?us-ascii?Q?ZHHwkJmgwiaz9xJsbr6IwW8w5DliQiCUvZJ3zcEJfkS2RDm/vcgJGHpgIaJV?=
 =?us-ascii?Q?jWOehMkwNSM50HalxapnKDB806btXA8HWxiTgDeidCydMtM0SPDtpmG5Aksp?=
 =?us-ascii?Q?z0k05dMPSQrKDN4Zs3OPF5J6BsbN0//M+Edn6SU2aQpuLf//zk5vzlYl7fNs?=
 =?us-ascii?Q?aEc/7gTAjBFvg7bqfo9OMQsbb9XfN8Bm0di5k7hBv1uscyW80FlgMMtno20d?=
 =?us-ascii?Q?/fqnV6mx6gyCgzgqp31yLWrnCR5bDARTrW3QPW59NEKQNkAgw6LC0KFBNDAI?=
 =?us-ascii?Q?aAtj6mu2FJDl44o1SUwQkvM0PtDi/7AMaPFa1yFzsNsY8UglXWIzITbZW+c7?=
 =?us-ascii?Q?pci583PY5BwIYhXrOATX4nQgXw15aQQFCODlptxH9wjIkpc9DJ4tipPtQvZb?=
 =?us-ascii?Q?pb/Q4L5skpZ31LrU/m9p8SYo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955c20c1-7b31-40ad-8cab-08d92cb2aac5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 08:26:53.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2/hDKZ24tXsCNCfj2rbUkAZ06T41kkC3tKXWxRZ0YeHcN+DCofvzrzGHkDfeFcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5720
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/11 =E4=B8=8B=E5=8D=884:19, Johannes Thumshirn wrote:
> On 11/06/2021 10:16, Qu Wenruo wrote:
>> Did you mean that for the bio_add_zone_append_page(), it may return less
>> bytes than we expected?
>> Even if our compressed write is ensured to be smaller than 128K?
>=20
> No it either adds the number of requested pages or it fails (I think ther=
e's
> and effort going on to make bio_add_page() and friends return bool so thi=
s is
> less confusing).
>=20

Got it, it means we still need to check the return value and submit if=20
needed.

Only for regular bio_add_page() it would never fail as our write size is=20
smaller than bio size limit.
But for bio_add_zone_append_page() it still has extra limit so that add=20
can fail.

Will fix it in next version.

Thanks,
Qu

