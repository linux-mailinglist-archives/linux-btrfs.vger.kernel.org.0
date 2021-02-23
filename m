Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27857322FBA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 18:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhBWRgX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 12:36:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40263 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhBWRgV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 12:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614102725; x=1645638725;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bRdnzIEAI7q3hh+6hvfhdpjvZm792lVn8pfuY7HqkVE=;
  b=M0396LBxXjyDMYEHZVzqMcjVs+fkwNjST/dVJfyVzLb1/x9Jw/YmqPk6
   Hy8JQDKgKnYkiqL3jvbfpYADbIczWONZGcKutsWIu0OuT24gdJRZg3kIC
   G08uBV6NWsVc7wtO9T+CWpR1oGwXJ6ViF+A+4c6EkAnQQ5uyzADFSsSCm
   QmiyJoYHpTYnWluWtgIMkSxHbczdKoONlFQVNXF6VHAXlp5KfUmXDiJQl
   r5Bfykbi47JoZ92fYMVyhm3T68fj3wzBXBv5a1ovE0mQk2Be41N8CQS0g
   EIy2nsfxpQAp/rDtP/l7l8ebKLWmddlZe4DeRFl/RTVqiAsTqaSqpLwuD
   A==;
IronPort-SDR: SZearJeBaZQuyYterh+W9bwmmNtKni8luazI+FBNc52ZXQuoOMtvP7aO05fw+aBdYYLc6+N/xa
 zoKrzT4rtKeouTm70LCuz//cv5iELDQKjqA4y5pvkJALe6WjVYsbKXosjC3BHNN/BlCR59BH0s
 SzJYffW5Ohvy42sOZ6D4oTEw/hbbVX7x8ypSuMk2rB/BcJr8Fz0+28xNnwAgFRpS0Z+36opfwW
 nN8Df0oRett0HXoNMYITkcyAjEgZBpPZd6WhoZqRfCJOFSJlCrSHY8ET5PwYTzcvtstGZWOwfo
 Taw=
X-IronPort-AV: E=Sophos;i="5.81,200,1610380800"; 
   d="scan'208";a="264818125"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 01:50:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgwoLPg0Usd/J1mjOMKMzceUGrPTivrz2292bRWlYa1zLojG/ZTahYB6Ci3daMUNu2Jg9QBqv1Aya0aSHhUXV3g4SUGQfg8hRWDrMtXNnzgm73BKR3xJPQsFhoNMkwAHGwW5arFZp43Q6a8Olfb6fScqKwTCDKvLG/Av7kmdfN5W/sM4n7tJLqlOe26PyMF5fDpEPQNQRAJfbWETvZOwyEyyclDqHR4QEfHpJVE7dfnW+CCAt6eKpZcxZ/4U0s2jFsK3Mp1MtNELxMwB6JqaXMjZs/YQ9MT3xPU5B6UAP6fKmFksIyq1twql0czs/7vPdrcKHm3v6c/YZqbIHmcBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5XYeZk2cOtSFswL4XMOJp8dGbvG4DNGm0Uv8RojpYc=;
 b=I+nEf81+mblBn8O1qYgS9f7T+2Tx4c3ST9BXsXrEdlCuHAG3e6w42/DSq+FDscQr6YRIPewRMPZyR80aQiN6zSnUwfrnuSBJLGlIfDiBIG4jI1Tt0zSrRC6gMM9zUSnXBCcNhbgLtrBpGvMO41BV7fb2fijj96ftoP7z0Av5fZGHgKYHm0ZFrnGvcL2QM5Q5EY7wJgoAO/VTqV+dX4vwEfqoC8YNUL1UJTV4c05xwiy6UezFDry2HicOYyM/pKAzIw4i8PA1dU7B4jQ07nHQOgQb7ecspTM4f0FDcvi44mbZKBFwfhFKOP8TwHMDBkF7jCJY4/16j1rN61Q6TEllHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5XYeZk2cOtSFswL4XMOJp8dGbvG4DNGm0Uv8RojpYc=;
 b=DV5FUl+auf4hY/y376c8YM7TsA9G3wIEabOfF0KvnlBXO5zs5i4xki3+Mfh2JVUPCSKux/JrSJhB1gV3qy5E8qU9iKDDIrR3zyqjESkfVuQc6q6m1gYM6fwOyiU31gHnJG74DhV4w/4neWWhY74OyUlG0ef7qerGXlcnlyo+5KU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7208.namprd04.prod.outlook.com (2603:10b6:510:b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Tue, 23 Feb
 2021 17:35:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 17:35:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Steven Davies <btrfs-list@steev.me.uk>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: 5.11.0: open ctree failed: devide total_bytes should be at most X
 but found Y
Thread-Topic: 5.11.0: open ctree failed: devide total_bytes should be at most
 X but found Y
Thread-Index: AQHXCVZZbch6GFpjTEmrkxrdQ5iSyA==
Date:   Tue, 23 Feb 2021 17:35:10 +0000
Message-ID: <PH0PR04MB741625481C6DAC65BB52857E9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <34d881ab-7484-6074-7c0b-b5c8d9e46379@steev.me.uk>
 <PH0PR04MB7416AA577A3ED39E4C5833819B809@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB74167CACC7802BA85638105F9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210223143020.GW1993@twin.jikos.cz>
 <457bf37240392e63a84c7e1546f7d47a@steev.me.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: steev.me.uk; dkim=none (message not signed)
 header.d=none;steev.me.uk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:41af:77a9:fe21:4e5e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18c2679c-508b-4653-e943-08d8d8215e77
x-ms-traffictypediagnostic: PH0PR04MB7208:
x-microsoft-antispam-prvs: <PH0PR04MB72086C18A710D3986E3C75889B809@PH0PR04MB7208.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fMmpXxNd2EfFI/cI7V3/21TuVvptq/c0oFxfCtS1k86a7t/0TR/nOQOX5RzTOoRHOe2D8lj8GklRUWpBEGzHkg+kRLTnzdiaVYkkqCiR63e/YizTHjIbUquFflpWZXO+C4a9lCBruxnhGpYwOnMqinzUqhuDcQ91LT3cNUC6tfZADACK37iT5AjBmfOkKhxFCSgfxMFyB+RebY8gU7TstkvyAr1MG1w2QmGg1/nFjGmq3iZrvmFrcZ8qi/306m1gwqi/9QcgsecIElbk08dcMXFpl33kwEvVh2grN8kcbMOjB2rxnOOhq/Z92KfMKqSRuzF82KWg37O21dteDrGzwmkdcKdyZOFcPLU+eWDpe2wqcjeRwy418kbUM1sYl/wV47QKM7xbdrCSava7c+2MS511LWHyC/weYjRHJT6k80wW8J2+VyyeW+Co+6zce1E5WeSiyVpi7YMcZI2birrN+mwejvRJu+MoCaW+ocXpC1iTLzUlDgb+ltgvX5W2T0ikBWe2SKzU0ab7a/3E9Xr//Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(110136005)(52536014)(71200400001)(83380400001)(2906002)(53546011)(6506007)(7696005)(5660300002)(316002)(76116006)(33656002)(9686003)(8936002)(55016002)(91956017)(66446008)(86362001)(66946007)(8676002)(186003)(66476007)(478600001)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?G9Q9LOMogtN/L1UTCpzTlfQjhi7ga38oGsio7iu80LLbT/ZqTHFpr471jb?=
 =?iso-8859-1?Q?mjwGagz2sVJ/fpEi9lYjRa+0j50okp0P3Ymg1Oo9rRrmoe6+w70KvPreXx?=
 =?iso-8859-1?Q?tmFNP79RM5ucyQCF+/goVkCD/NrITpiuVLGrPNc3wrvlBxSKpTo+zDFFV9?=
 =?iso-8859-1?Q?WFp13r8DEBuZyvWtQoLaHXAFD07cGUWdgtukiXdPktq71k4tij7eTopjBI?=
 =?iso-8859-1?Q?JmPgM2sM73Q6lyHZhroe/FzuGHI2KfOXkOmWa6b07bccOpmoIwJbIv+FgR?=
 =?iso-8859-1?Q?OJK4SSiVJ0voFS1GaHQLeRO9k9Kasb1m2vqz1TO1+5Q4L/UxTJys8VFbKl?=
 =?iso-8859-1?Q?BoRqPpWziCGLXliUvfQKKhPGJmlOuB4o9q4LLaPEv/z5zBNY97D988vg9M?=
 =?iso-8859-1?Q?3QAX7NVRy/vsBVIhwmnEptO38yLmAdX94VKr8lobF/gg6MNLMcyMsbiDLL?=
 =?iso-8859-1?Q?jPslfmpK4MgmKArlLeF+pna3UQQMMFkNwA2cG4L89Y8XlDSb0WcKame3ug?=
 =?iso-8859-1?Q?HpcSkwBhjILzAZuh7kZ76YxMYTCiT8ineYEantxFrtizUvshU3VmSxtL8V?=
 =?iso-8859-1?Q?Bdw/negsf+bA89xPwvj2IOB4fMgUtiFvTjkLuoPLuq1DBMUfCLJUo3X2rI?=
 =?iso-8859-1?Q?nWRufiYqYxcvC38/DLnpBYh6bRN6MvSQMYnNIc6TIG/FCby2cG22+n0XYJ?=
 =?iso-8859-1?Q?1arNgS2yCpA5Crl5GsRs6jmGZe+X2ppDf5IlK/e5oGRU3hLQaeKbZETVPs?=
 =?iso-8859-1?Q?H7Zr84tN7lLfw2JlKrHMUhD4YMoqCYWeAYD3zWJ1qt5lj8S/VBniFhg06P?=
 =?iso-8859-1?Q?wlvPdlgdq3sCczlA1ceW1RNBv9xRmfHbrboL/j3eHDft6yLHMEoKCdREO9?=
 =?iso-8859-1?Q?WfsnectDKastHQb9Nx1nxjlQv6kzAcVQ2ZsP1l+Ksh004Bx96+LMVZV7xU?=
 =?iso-8859-1?Q?cYsnQrB2R34xbK5ECcNSOID4zfVr9LYgOzyyJrYZMnBSei14VwDjaOCEOY?=
 =?iso-8859-1?Q?rdufFk0FslxUpb1+MV+PQkrZCGrFv4XYl+awWyHoKsrBe04JjzfhCDTTxg?=
 =?iso-8859-1?Q?PNU/X0ZzrPDD/N9zil2pQXyWi950nYCLL0cAxVxIgcPoLqI8H/r2y8sXxN?=
 =?iso-8859-1?Q?olNHLm4KI0C8i21EM0svL811A34JUj6i0EMMfabQN3GOettAjPOwsxKBDF?=
 =?iso-8859-1?Q?kyaBsEe/RmNAgVVBTptk/oSO8t3kz3ZcAITDsnoo6c8wBcVADFBJont3fY?=
 =?iso-8859-1?Q?rZEEbOhcvlw8ar2vf9jZIBy1CylJndem8A3TOEGWpyDq+MNnB4ekRjhkeL?=
 =?iso-8859-1?Q?7QP/9GvKygSRTw5r0a6l3FspBQ1qpNVxG4ayVvcjOJUxEgBKsAGZ2zry72?=
 =?iso-8859-1?Q?qxPzKBKHSx89nPeeC4UP9CxKUHzVtjedwah91IOZt3PLe40LuAGA8AEp96?=
 =?iso-8859-1?Q?vWttfwJ1Gw29+1cL/O8Q3BWO/3OzH6OOQgjO5Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c2679c-508b-4653-e943-08d8d8215e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 17:35:10.1908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jvm9Pqhibo3CquTrV0g784k7IgVgPVrWTzriDIXGjZQWmR/ne1r2pl2vEMtqtexn7YJpm55EO9RvWnVohXK5gmzGUiiYhZMcp09FhoyR0sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7208
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/02/2021 18:20, Steven Davies wrote:=0A=
> On 2021-02-23 14:30, David Sterba wrote:=0A=
>> On Tue, Feb 23, 2021 at 09:43:04AM +0000, Johannes Thumshirn wrote:=0A=
>>> On 23/02/2021 10:13, Johannes Thumshirn wrote:=0A=
>>>> On 22/02/2021 21:07, Steven Davies wrote:=0A=
>>>>=0A=
>>>> [+CC Anand ]=0A=
>>>>=0A=
>>>>> Booted my system with kernel 5.11.0 vanilla with the first time and r=
eceived this:=0A=
>>>>>=0A=
>>>>> BTRFS info (device nvme0n1p2): has skinny extents=0A=
>>>>> BTRFS error (device nvme0n1p2): device total_bytes should be at most =
964757028864 but found=0A=
>>>>> 964770336768=0A=
>>>>> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22=0A=
>>>>>=0A=
>>>>> Booting with 5.10.12 has no issues.=0A=
>>>>>=0A=
>>>>> # btrfs filesystem usage /=0A=
>>>>> Overall:=0A=
>>>>>  =A0=A0=A0 Device size:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 898.51GiB=0A=
>>>>>  =A0=A0=A0 Device allocated:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 620.06G=
iB=0A=
>>>>>  =A0=A0=A0 Device unallocated:=A0=A0=A0=A0=A0=A0=A0=A0=A0 278.45GiB=
=0A=
>>>>>  =A0=A0=A0 Device missing:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0.00B=0A=
>>>>>  =A0=A0=A0 Used:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 616.58GiB=0A=
>>>>>  =A0=A0=A0 Free (estimated):=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 279.94G=
iB=A0=A0=A0=A0=A0 (min: 140.72GiB)=0A=
>>>>>  =A0=A0=A0 Data ratio:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 1.00=0A=
>>>>>  =A0=A0=A0 Metadata ratio:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 2.00=0A=
>>>>>  =A0=A0=A0 Global reserve:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 512=
.00MiB=A0=A0=A0=A0=A0 (used: 0.00B)=0A=
>>>>>=0A=
>>>>> Data,single: Size:568.00GiB, Used:566.51GiB (99.74%)=0A=
>>>>>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0 568.00GiB=0A=
>>>>>=0A=
>>>>> Metadata,DUP: Size:26.00GiB, Used:25.03GiB (96.29%)=0A=
>>>>>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0=A0 52.00GiB=0A=
>>>>>=0A=
>>>>> System,DUP: Size:32.00MiB, Used:80.00KiB (0.24%)=0A=
>>>>>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0=A0 64.00MiB=0A=
>>>>>=0A=
>>>>> Unallocated:=0A=
>>>>>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0 278.45GiB=0A=
>>>>>=0A=
>>>>> # parted -l=0A=
>>>>> Model: Sabrent Rocket Q (nvme)=0A=
>>>>> Disk /dev/nvme0n1: 1000GB=0A=
>>>>> Sector size (logical/physical): 512B/512B=0A=
>>>>> Partition Table: gpt=0A=
>>>>> Disk Flags:=0A=
>>>>>=0A=
>>>>> Number=A0 Start=A0=A0 End=A0=A0=A0=A0 Size=A0=A0=A0 File system=A0=A0=
=A0=A0 Name=A0 Flags=0A=
>>>>>  =A01=A0=A0=A0=A0=A0 1049kB=A0 1075MB=A0 1074MB=A0 fat32=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 boot, esp=0A=
>>>>>  =A02=A0=A0=A0=A0=A0 1075MB=A0 966GB=A0=A0 965GB=A0=A0 btrfs=0A=
>>>>>  =A03=A0=A0=A0=A0=A0 966GB=A0=A0 1000GB=A0 34.4GB=A0 linux-swap(v1)=
=A0=A0=A0=A0=A0=A0=A0 swap=0A=
>>>>>=0A=
>>>>> What has changed in 5.11 which might cause this?=0A=
>>>>>=0A=
>>>>>=0A=
>>>>=0A=
>>>> This line:=0A=
>>>>> BTRFS info (device nvme0n1p2): has skinny extents=0A=
>>>>> BTRFS error (device nvme0n1p2): device total_bytes should be at most =
964757028864 but found=0A=
>>>>> 964770336768=0A=
>>>>> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22=0A=
>>>>=0A=
>>>> comes from 3a160a933111 ("btrfs: drop never met disk total bytes check=
 in verify_one_dev_extent")=0A=
>>>> which went into v5.11-rc1.=0A=
>>>>=0A=
>>>> IIUIC the device item's total_bytes and the block device inode's size =
are off by 12M, so the check=0A=
>>>> introduced in the above commit refuses to mount the FS.=0A=
>>>>=0A=
>>>> Anand any idea?=0A=
>>>=0A=
>>> OK this is getting interesting:=0A=
>>> btrfs-porgs sets the device's total_bytes at mkfs time and obtains it =
=0A=
>>> from ioctl(..., BLKGETSIZE64, ...);=0A=
>>>=0A=
>>> BLKGETSIZE64 does:=0A=
>>> return put_u64(argp, i_size_read(bdev->bd_inode));=0A=
>>>=0A=
>>> The new check in read_one_dev() does:=0A=
>>>=0A=
>>>                u64 max_total_bytes =3D =0A=
>>> i_size_read(device->bdev->bd_inode);=0A=
>>>=0A=
>>>                if (device->total_bytes > max_total_bytes) {=0A=
>>>                        btrfs_err(fs_info,=0A=
>>>                        "device total_bytes should be at most %llu but =
=0A=
>>> found %llu",=0A=
>>>                                  max_total_bytes, =0A=
>>> device->total_bytes);=0A=
>>>                        return -EINVAL;=0A=
>>>=0A=
>>>=0A=
>>> So the bdev inode's i_size must have changed between mkfs and mount.=0A=
> =0A=
> That's likely, this is my development/testing machine and I've changed =
=0A=
> partitions (and btrfs RAID levels) around more than once since mkfs =0A=
> time. I can't remember if or how I've modified the fs to take account of =
=0A=
> this.=0A=
> =0A=
>>> Steven, can you please run:=0A=
>>> blockdev --getsize64 /dev/nvme0n1p2=0A=
> =0A=
> # blockdev --getsize64 /dev/nvme0n1p2=0A=
> 964757028864=0A=
> =0A=
>>=0A=
>> The kernel side verifies that the physical device size is not smaller=0A=
>> than the size recorded in the device item, so that makes sense. I was a=
=0A=
>> bit doubtful about the check but it can detect real problems or point=0A=
>> out some weirdness.=0A=
> =0A=
> Agreed. It's useful, but somewhat painful when it refuses to mount a =0A=
> root device after reboot.=0A=
> =0A=
>> The 12M delta is not big, but I'd expect that for a physical device it=
=0A=
>> should not change. Another possibility would be some kind of rounding =
=0A=
>> to=0A=
>> a reasonable number, like 16M.=0A=
> =0A=
> Is there a simple way to fix this partition so that btrfs and the =0A=
> partition table agree on its size?=0A=
> =0A=
=0A=
Unless someone's yelling at me that this is a bad advice (David, Anand?),=
=0A=
I'd go for: =0A=
btrfs filesystem resize max / =0A=
=0A=
I've personally never shrinked a device but looking at the code it will=0A=
write the blockdevice's inode i_size to the device extents, and possibly=0A=
relocate data.=0A=
=0A=
Hope I didn't give a bad advice,=0A=
Johannes=0A=
