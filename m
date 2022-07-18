Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC142577C8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 09:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiGRHaO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 03:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiGRHaN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 03:30:13 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A40E0C0
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658129412; x=1689665412;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WZjGGx1JhjSH1W3MJrCdM/3B3KE2dQymFA3Ij8vzksk=;
  b=ft2mb3cCw2DbP5GF6IdhKKNtvCq5H/OBsgS8HMlQEKxbiox+GmjdSZrQ
   6ITL6tHeO9QMkp8CFcFJL+w9BHUODhtyehmGyW3JpOR36iOxSfozTd4Di
   nUv9li22n5aHASQBFx4dn3uFj92pFWBKBS+byW2EONtvrf5lhmYLhFh6B
   0sBfiZbK37sqq6M+jqj+kiv2GuFwBZgVD6jw6l0bpBSPId2YQ4oYSumw4
   OlJ9gAiRV099x/169Jwf3WndxsVA1DJ/JRgBt1usm0BvCO6wjeEJ+ZzLz
   c4UQskKmpazVObPGEwyyKJxRbJK/FXmw4TcAPFO5ZMN2kGsW7ipVmYFJm
   w==;
X-IronPort-AV: E=Sophos;i="5.92,280,1650902400"; 
   d="scan'208";a="318151876"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2022 15:30:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYSclqXbSa9RAo5cUf/mLgQ5kp+J4PynsII4fYlf6aPUjYt1wEDb94tACTV4IBO0N3m5X3ke2bumneuXpfMHjDOC/opAKa00j1ud+ligIY3XFDT6YE288+IrBQGcQCgHbSIMN4DNaCsGBfIIJDEj/bUowibpIr2tp71Uhy7BI0gbJKAXH7c1XUGldNVfMNPb7jyvKwIJB9BL7z4sVubNXzyHTLSUPMztSbicW+tVbCXdRZD5gHXPdilzZC3CcJ2B6Xcp5PDGBr6qLVWS5AZp5NKE7r/EghNytikkw1rB4CMJmzYY2bf+EAbsMnq6pq0dfzxH87dtFeBmgPjGWerX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZjGGx1JhjSH1W3MJrCdM/3B3KE2dQymFA3Ij8vzksk=;
 b=Fk2rD31mZPKUmXkdh/Dv6pQYgRp1AZqjHgCvAKjaPSEWWmVLrUCdFaplS33VK2GZU4PPdmBd2ILx0nOU3BROP/Y3It3jA4bwuj0n50jV5BJjC5cvrHxUNmhS6JYFTflZBEZSbbsfjFbDEDKLTxkbZdhjFqUbGNfRnBRzw6vuZN9SN9HdZcyp9X8//Af6UBS7OL5QdqIO8vq3LetKA1clOzPAjLZfRtD8IUQhifdsNL+eAr60iJu+pthtwL7+kRTGEG8JHS8L869rtqn4ls1J4/pfSGH9AGe8rQRrF14FV0CfWcaJON2r0/yBicUjn6SVZPnKMAQUDPYLchN43aaUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZjGGx1JhjSH1W3MJrCdM/3B3KE2dQymFA3Ij8vzksk=;
 b=jH/CvoBCrL26Lepxf5l7NR2VVcRtBt/DCzF4nPZhYphKYrNpmyD4BaX3osE+hHVmfbyyGvf5KoLHmXaSw4WwM/HyH6EaBMN4KWcYw0JZcOvM5NYMvcVxDMpKxmm7YIRDk4NrEJ2yJ70Jp99n4wTOnTX/Wp3K0TH9RzVRdtbunt0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB1084.namprd04.prod.outlook.com (2603:10b6:4:46::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Mon, 18 Jul
 2022 07:30:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 07:30:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "kreijack@inwind.it" <kreijack@inwind.it>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Thread-Topic: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Thread-Index: AQHYlqb43VRMNwcKo02MAxAIJIVEbQ==
Date:   Mon, 18 Jul 2022 07:30:08 +0000
Message-ID: <PH0PR04MB74163D25836A5AF57E3BB3249B8C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e3016ef-aaa4-4cec-d67f-08da688f5763
x-ms-traffictypediagnostic: DM5PR04MB1084:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aaSNpFq7rMRoURGqC0Gz8Domi+IZgjVC5X9Or+Yi+9MKRY0DIRPGXyDCc2j4KbjLYR1RfPkJERYNccLAYQAoCwq1jg+CrkDNAEnBnle7Jwh8eblTrKyw+KbWT6gZBpLOMw8GMpDkVVdkcUs9gi0HcnnBAvAhujBsrxKrvmnLFrQHUNifm++5wI+4PUd8cDuLMO1FY97IFahKSZF7raOaryRjNXYuY5pQVUZf5aq6+BkkPG2mtcTh+1tYBTwYWtS6wWTbtlTHaRWBtg/v5JDR7gj2AOhvfcln3+MbbU1IdMD1U7Zz15AtEg2M8PZFkgR4hmq6pHR9K1zKU1HwQumUyHNWeysN+ecinPLiHW8Z5XT16nz63MY1ASJyWXxiUhHoba9WZyieYYtFSpmy3HeXj6f5XN9fNtMzaslNTYGwOVbHfwTr7/NMEQ4DINfK4Xc9mklQ07NjZdF8x4/w2xbc3SriH6AeTHR/wqRJHbNR+KJX261+kxH12i5Sn2XQt4LO3DEH1D6Xozy+a+Yd2zuhbb9w7r6SxoLcQsTo0eBpUodaQY4zXU8lk64tQD9a0yO24uoXV5SkO5kYFgJV9sVw7MwcSNziz8wFL6WhMeVgW5EL5/uH9MinQG1jzD5AIx3gOiwcWUiQpOvAHg/1jco08M/iwbjnaN1KgylcV2tmQL38BGYHZxKuwBadMmNPseDAOad2o30HkaKLl6ESNLBumdFMKGxCb6G+dOpUOdAzQmr1LtZb54ISTQutGuNkV49+SHJrhgyKoXI7USB4eOSV4twA4HAqZLgdhWuvIjLK6QpeDfXYuCXfAwd0slBpWFm1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(71200400001)(76116006)(91956017)(8676002)(64756008)(66446008)(2906002)(66556008)(66476007)(41300700001)(33656002)(52536014)(66946007)(478600001)(5660300002)(8936002)(110136005)(86362001)(6506007)(7696005)(9686003)(53546011)(316002)(82960400001)(55016003)(122000001)(38100700002)(83380400001)(186003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZAs3z5tyPhh1CFWmPARfdtAxEQnWIfkwtL78m8M9LshnjVCMyct7FTY8KktW?=
 =?us-ascii?Q?QSKwkTCKYK/+67sSqK+nCVPA4zbFILqX2ougNoEyATNCYjkT6u0skiljeBRU?=
 =?us-ascii?Q?39GTV11yQJq5Hua//PJpPCRhgh/167kwB/ZsBC9s0PqV5YFGtcoQTzkdUwDo?=
 =?us-ascii?Q?VNMrY1B3Y0XrhhYA5V2HUqU230iZaPG68IgQUDNFoApq2IcKeUffMprsT/KS?=
 =?us-ascii?Q?2Iv1BZknBSlJUGH5jgOHzNxbhB4kQAVavbiZq3p4NjceEdVEfaHPkTGODIqk?=
 =?us-ascii?Q?ZYjM4JQZX4PZaU27/t/KiGCmDWCUPn2z/Mmcom8PDp3EWHANAbwA6oxLxRyU?=
 =?us-ascii?Q?RZZu8RGutVXjY0qLDoYQ/hbosQfZkdkYqpK8UQ27D0pdH4QoHXDWrDGS4zHU?=
 =?us-ascii?Q?MBJjNPsSGC6ysP+U2AxW3aXYozxuHZun3CH6fCKALkzzLqwjF814pAqseP4G?=
 =?us-ascii?Q?hHnR8W0BIvT6rVcZB1dJCFmETUt3yFeRxhox/IgFf0SdqhKNvLgwPmoS08aS?=
 =?us-ascii?Q?mvMyB5M+r+y3zdT3pYjQc5XLFWlXQw6LccfJthvUrXhFoJlntgBYlMBa3poM?=
 =?us-ascii?Q?hO3knivdMVe4dQ7vjiIv6Tobm+I9Gt8u4IwioYs6Timrk+k/zNb/gByoKYX3?=
 =?us-ascii?Q?lJrNx2HGUYNU/xJTYjv4Tt+anu59KLjxyq4LgV31j7PUejo6FRxwz0Ahqj74?=
 =?us-ascii?Q?Y3jEhmfwxQJbtyL8XyHTXsJVY45hmn4R+vud3PMRKXvZq7h+PnZ6GhW0Z2yD?=
 =?us-ascii?Q?HqupwPBvpTRTtsDXGxvrcTYXsi+HLoC5nP6IXzli5Y9h9bCReLKqUTfC+p+G?=
 =?us-ascii?Q?mvGoU7I/tMhQy2tzFnfPUq0DQmm6HE33nAc04Gc6uebOdV4yQQATBHhaV9MG?=
 =?us-ascii?Q?u7K3rNLZjVYHrHPtQy5EfG5pPh1zXkkQsu54RS26Z0eoSZbhwXq5UEzn+Nug?=
 =?us-ascii?Q?Ar/Sx2wT35fHz1io604Ca/9KGC+xKHNbNlP1wyORZz6wPbRiQ6mOllaLV0+K?=
 =?us-ascii?Q?xKo1f93G6nGxi/YGtJv6ovzKxQbh4J5lniYHOPlxalkJ/tNPKUu5YXmcX1HG?=
 =?us-ascii?Q?iflmf5IW4oaQiad9B3qASH8N5fZuYrG7ExRFBYWXAw+KKCKsEcMXtcINjq6k?=
 =?us-ascii?Q?eTQBQQiaJYEE+mCUwG65ElaWLzH0epo24K1isBlIEVSbkbXHrwxxlbCLp0wS?=
 =?us-ascii?Q?DYtIjc/jY5UA3Uu6TcCe8tCxwRNyFP+LBU8EfJjfELfpCR6ZML8RM1qWItsV?=
 =?us-ascii?Q?HzJGil8uYvyqStHm9H6vEDYeHQgznHL0M6YMqhxtkMXMkn4oHb+gJV7qA+Qj?=
 =?us-ascii?Q?Ioy30RwBF7JRUjmvMFuSWS9XqWStILnGuCkbGVZtZ7sphJdsu6ziVleRoHnY?=
 =?us-ascii?Q?nYhBK37/64yZnJMac1s9hmPwtOhiIkIfdqiJg53gEhAxvats9dMAY5GnakwT?=
 =?us-ascii?Q?5hUTVOCXDzU0ey4DHLFSqIR5/Ih3psKiqN8cqXCE3TnPFcb6Kz5WD1BHx1zo?=
 =?us-ascii?Q?mlwq5IFoOHDblcrFeZkrqD5X/+UTqgWpeMygE/4LxZJ5GJ2qDeRs/+ckH4Wn?=
 =?us-ascii?Q?jXe7qxaEY/hKunZOaSscQdq/+NfOAOj9dW1rbHs9mUYR+gLVw8FJVQP27+/v?=
 =?us-ascii?Q?vm2NI9JgpeISa4Zg+oa0a31Ep3Tm2nxZ+rreY7frrKxEq2LwH3+tasdpGkRp?=
 =?us-ascii?Q?KX3JabVDPdMGLmNIONSP4E3d/nU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3016ef-aaa4-4cec-d67f-08da688f5763
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 07:30:08.1963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bOdIZcXsy/rYP5efZ5ZzYMhjgLQ8e4nbdH6yfM1uENogroI3ttHxLPZrg/6HnoMwCXsHHiZp0oudmwl+Rk2F5ziPsjzB77Nm1Uukhm7AcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1084
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15.07.22 19:54, Goffredo Baroncelli wrote:=0A=
> On 14/07/2022 09.46, Johannes Thumshirn wrote:=0A=
>> On 14.07.22 09:32, Qu Wenruo wrote:=0A=
>>> [...]=0A=
>>=0A=
>> Again if you're doing sub-stripe size writes, you're asking stupid thing=
s and=0A=
>> then there's no reason to not give the user stupid answers.=0A=
>>=0A=
> =0A=
> Qu is right, if we consider only full stripe write the "raid hole" proble=
m=0A=
> disappear, because if a "full stripe" is not fully written it is not=0A=
> referenced either.=0A=
=0A=
It's not that there wil lbe a new write hole, it's just that there is sub-o=
ptimal=0A=
space consumption until we can either re-write or garbage collect the block=
s.=0A=
=0A=
> =0A=
> Personally I think that the ZFS variable stripe size, may be interesting=
=0A=
=0A=
But then we would need extra meta-data to describe the size of each stripe.=
=0A=
=0A=
> to evaluate. Moreover, because the BTRFS disk format is quite flexible,=
=0A=
> we can store different BG with different number of disks. Let me to make =
an=0A=
> example: if we have 10 disks, we could allocate:=0A=
> 1 BG RAID1=0A=
> 1 BG RAID5, spread over 4 disks only=0A=
> 1 BG RAID5, spread over 8 disks only=0A=
> 1 BG RAID5, spread over 10 disks=0A=
> =0A=
> So if we have short writes, we could put the extents in the RAID1 BG; for=
 longer=0A=
> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by lengt=
h=0A=
> of the data.=0A=
> =0A=
> Yes this would require a sort of garbage collector to move the data to th=
e biggest=0A=
> raid5 BG, but this would avoid (or reduce) the fragmentation which affect=
 the=0A=
> variable stripe size.=0A=
> =0A=
> Doing so we don't need any disk format change and it would be backward co=
mpatible.=0A=
> =0A=
> =0A=
> Moreover, if we could put the smaller BG in the faster disks, we could ha=
ve a=0A=
> decent tiering....=0A=
> =0A=
> =0A=
>> If a user is concerned about the write or space amplicfication of sub-st=
ripe=0A=
>> writes on RAID56 he/she really needs to rethink the architecture.=0A=
>>=0A=
>>=0A=
>>=0A=
>> [1]=0A=
>> S. K. Mishra and P. Mohapatra,=0A=
>> "Performance study of RAID-5 disk arrays with data and parity cache,"=0A=
>> Proceedings of the 1996 ICPP Workshop on Challenges for Parallel Process=
ing,=0A=
>> 1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.=0A=
> =0A=
=0A=
