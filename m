Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149463227FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 10:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhBWJoV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 04:44:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43068 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhBWJoP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 04:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614073454; x=1645609454;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=f+nayMLx/K4naGLnHlnvYK1P6UymiEnQBNvTCu1PpW4=;
  b=WYMCcckL6EpAR8mOo/aR7Q6WI3N/AxgoVhuxyWHdku7eUaZ4KOTKfeal
   s6iMowYQHsk5SlRV23ME4BcIJ+88HTqErry3KrEwScqHNdUToVpAEtWmg
   TegNvakmD5q0PWVCo00dUer23+1CrdEbR5r3EOMMTO66AZ3NYr6JJT3EN
   0v2/gmGK9KqPb3VWi6QeQgvVLuDf4z9UQYHnTkbpEWJbyr0oC70mqjIfo
   2jP2jVOPi1P8d9YzB5XeaF7uMiu5m677qyJiFqpwkF3afRDPRLJfmOlSG
   9Sp3PUAFRHfctpoaocNLB7Pw2pzY6rHtzjsSPS8AXqbSAdoH+1LxflhyP
   A==;
IronPort-SDR: k6UtBEply3DlqqlE0Rm+cIeF5BGC0mgdHvCi+YopW1EK8V5OUhsXITYMYYY6lSLGxr9GPk7tJQ
 1r7m08KBrkLdbQvvK+nwMfKITxXzjgKlARZq3qdql2R3ovxuwm7ghzs2jOa+acCjzty/owoBnT
 F5cLJGh21gnMd0y/iCElkBO4KCV2I+oHQ+BTK0rx6U/skC4dxkDsBdYE0N00r6qX9IYCxZSlBQ
 2Heg6bH5dfWj6qSmDoGwkcGK1WQpyOdN2tRjjvdAcv/TKkyekOoMfPf+bCPVZvOGWm/+FwLqj6
 4pQ=
X-IronPort-AV: E=Sophos;i="5.81,199,1610380800"; 
   d="scan'208";a="160590574"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 17:43:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPDXa5FnabsHFyEtXN7UV5d8bojWLBHRRFINkYl8kyOJLIPFa2Bb8I6snYUlsyhqkeyPFX0ulMy0Uz0wkasLjGWzi5ON9aaBGQgwslmng+xFSABa4StBfEgVqIaUIdueIOm7j5ZgL6Nkk7Xa/fRbk28k2WVPGLtyd2L0bzdl/WqJHkAxk/hjhzIPEpbUzn5NzzBUKqjXaLm/xcMFXVzw5cJfqcvfsCGeV1YBS4/jJ+EzKdjmFkeQsXat3pcd5ZaItR5EeWQFlMUTS8zf36Z172U4rg6bE16HT1Quf9gy9dQtrqUjvLQuKrS4LVFXEVXRSx2yhnUxg1AHU1mR8vpgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVJN8bU9KbhFAku2q07YnSRJIJYbjIF8bqB1nMHq/X0=;
 b=baAvchBbvegU3tHu5YgvQqOeDxRJZdA0YIDQ6uio6sRpqK0CQo0eFsAzNSm0iKKiCERRgy1HMYSG7eLusiEp0NWD9KwWgtflHNFbHQ26MjDl5JJCUFB3pQVRRD92OQX+hwjfi2ExLE6Jy3X/x+yO4Dn4U9F8XM0pq+ImHrto8+adGpDIrVt1RQV5VNZhFRN0pR8FbURagYOyVPRnRcU/2TXKap1cSdfCtHMCfrf02xaS38cdiP7slqNN0Fb3ZZhKpYeNpgnK9kdA1l/zLcGezka0X2XXJmpp9IEXMEWVlR6W3fqQ6K7Mhbi29toRz0aXS3kodZDwg7OonylTg4ID9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVJN8bU9KbhFAku2q07YnSRJIJYbjIF8bqB1nMHq/X0=;
 b=K9Qm6R5fByWdphpuD9C9efsLWjqBb44kPFy4uzkB0ARP49p6yC8oCgGEvDPl3eT8YrZDokLIniuKD5ePiOUPimf9x8XD+9PPWpSHsEdCavZxkhrUFRyZ3U0FonMUgii9H1zYi+MS2KoU2VMCOwOdBXEVVXopscpsO60JDB1xN5o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7430.namprd04.prod.outlook.com (2603:10b6:510:18::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 23 Feb
 2021 09:43:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 09:43:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Steven Davies <btrfs-list@steev.me.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: 5.11.0: open ctree failed: devide total_bytes should be at most X
 but found Y
Thread-Topic: 5.11.0: open ctree failed: devide total_bytes should be at most
 X but found Y
Thread-Index: AQHXCVZZbch6GFpjTEmrkxrdQ5iSyA==
Date:   Tue, 23 Feb 2021 09:43:04 +0000
Message-ID: <PH0PR04MB74167CACC7802BA85638105F9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <34d881ab-7484-6074-7c0b-b5c8d9e46379@steev.me.uk>
 <PH0PR04MB7416AA577A3ED39E4C5833819B809@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: steev.me.uk; dkim=none (message not signed)
 header.d=none;steev.me.uk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:41af:77a9:fe21:4e5e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7705ba77-637e-4d81-033b-08d8d7df6aed
x-ms-traffictypediagnostic: PH0PR04MB7430:
x-microsoft-antispam-prvs: <PH0PR04MB743023E8B3E5C4DE96EDDE419B809@PH0PR04MB7430.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 89gnLJvl7Uoti4g4KA/sZaLGgL0igw+ZNBSFCLwrOistwbqQavigAi1/m1yHOOJJlLNADi0wN5vD+T+2tMdiJ6IeNyBe+klnF3lUw4QIZ8Z+mtAX9LZu6e5Mfd/9LYdCzayMlecTbbQrgxZi+7HuON+Mi5yzaBZmOTRYxAnNHRJrCVvEvCo2gc3MQEBki/I4Nyqlu5VT8kNb8/xCZGo251tzJRfSGKAsFlTKl8jtQvCQhS0l2ACPOiaHd5wDnEQdZsewIMsGvPP5A3ZXNCRBGYteyjLmyVEGjY+PBL/beNFw95RfPUvmEzOoibQGDcoyHR0DiBvlW+PjyLsppez1X76FV/eL/Atpx1nfW7R45zKzbaIJVLZwE2oCWN31H2cN/SzFEgeaMagvL1X8Z/jO4yVuj5yu6Pmd1cPDrL7aayY4M8NbeCdPa1qZWWm7jbM8MUdQYhR4BgKb6ZtRLILJ8o53vqX5joKnRSZte9WODl1RaDbPbDmaCOANd4WP7gzNirrzwfXRgNxkmM2hqgRnzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(83380400001)(186003)(55016002)(86362001)(53546011)(71200400001)(478600001)(8936002)(6506007)(8676002)(7696005)(9686003)(33656002)(66556008)(5660300002)(66946007)(66446008)(66476007)(91956017)(76116006)(316002)(110136005)(52536014)(2906002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Znj8S8O5CllZdjs5vn2mP9G5ippkPtQ/KgyB0VeDUzrCSsPYTtVHh7GQGK?=
 =?iso-8859-1?Q?YlHAf2BhshgMNwiSD3sVc5yNkYvKnPTbZlaBBtETxAdXmHs/pgOnLUosZa?=
 =?iso-8859-1?Q?6maJWDa/LZT/D6/hUNWLerZo33Z2AJeICqf7989lUFrrcMEtHJqnWoyqF7?=
 =?iso-8859-1?Q?tYo+x7WU283UID/t6mJzvzxlZKGjjdaQJyWMhRoHF4xUXPZCG41riOYpci?=
 =?iso-8859-1?Q?QSVXnW89UO9gHRSdLPUhhHEbDO/I31g0w7l/2BdaaO1/QsbUtA8FmU416Q?=
 =?iso-8859-1?Q?2k47Vk8tDd0Y9VM1uu1LCKGCQDQQ4/ocxAQKxJPuzMw8AlMEyofJJJdk2f?=
 =?iso-8859-1?Q?8gbvmc9yQOE6Z449gPw2Muw4j+uCvJKN4nd1bTEl+v4SMduZ4YoA0pLFv3?=
 =?iso-8859-1?Q?dlock5FdEBIRKDpdc6SgpI1U4XXW2gnS/YzgnIH2alVmVb+PvnsvsYgpb9?=
 =?iso-8859-1?Q?LPs3+/yFAw4oW4KVZeMEASGB0PWMSi7yTVU1XBouhMBmcQyKK4PqQkeymn?=
 =?iso-8859-1?Q?Mso2mMn5kBCHxYTaA4vEfw2Edh9N53igjJWpG4J9acfmogglc0qUNIk/nD?=
 =?iso-8859-1?Q?D6AbhZ7FGoHo2NrF+MG/MtoyAgxFlTrTGaaZ/6llVczePimqeUqO6oysvK?=
 =?iso-8859-1?Q?++SQ9oyWzEY87KfN4Qt8Es1Vb2AhtS4vcPKYL9qLn5aj/ox1uFUPu4C/Z4?=
 =?iso-8859-1?Q?4KBk8j3/jxJuCN6UH/wFUxJLObVdLJZK1G8DViOgt8OJOXkKTUbyW4lz9N?=
 =?iso-8859-1?Q?WMFhpDhLK6aHKk4TZnPcfF4rMminMYxiwBOwJLONNOZpwGEHRssWFm6+DU?=
 =?iso-8859-1?Q?PpDRloP0WiqYDC5zS4x7bsz+IzE8bnbw1tKqxtHDswkkny/7KWpCKGhqa5?=
 =?iso-8859-1?Q?4uYcSP+C7LXmuUk0yQY2Mnvs1U881qS45wxX8JnMVsfCk8tYN/YbX4GjBU?=
 =?iso-8859-1?Q?aVngwZb2GkA63qLAj+0uxUse9xyDCYZ9SSzqsM/857/q79mDJoc5PjswXq?=
 =?iso-8859-1?Q?NNDtaP6DN6vlrp4q8DT1XvqsXYFurZivlfSbetsJyH99OmV+NxFQh4HnAh?=
 =?iso-8859-1?Q?AnsWm1EG71qrTZtydXpj2FVVAjoX4DFtlTlZx5MvfG+X9GXCC0HjllZpxV?=
 =?iso-8859-1?Q?E1A29oInyW6ij7LcI+FpAzsZUIj7An1q5XDHvHtGWU0EPV90j+U/DQa3x6?=
 =?iso-8859-1?Q?xDl9hQzi8gb1W90oxJZlM92u52Jjvr3LmogU1OAYtc4rnXLJeyEFBSHYKz?=
 =?iso-8859-1?Q?ETuS2uWMq9lRaiiN14lyJM/4aoRlnLnyD2LKe2JKwYCv5A4foMaSzN5u6X?=
 =?iso-8859-1?Q?olPtUBHcsu1vBcY04K0psc3FFLBfkLZCgk9lNU7uC3I5wvXokCBkJjH7f3?=
 =?iso-8859-1?Q?11fbUKuqwKdK99u9lY+pko70I9AMIRr2Ujl8M5esSaWRcDepY/Tb9D4qy+?=
 =?iso-8859-1?Q?qRNjENwOC+p3f3Dw1FRJcn4NwLaDxs84V6FU0A=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7705ba77-637e-4d81-033b-08d8d7df6aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 09:43:04.3516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Zcv+3C2jJGzkNo61dimdFyVbNJ19xQb74gtmbsXGdlDneQteoyZb1/KtB3kOGjnzf8envumaqZkqkLP6ZWY+wzvpM39IJYtIIQCu1vO3wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7430
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/02/2021 10:13, Johannes Thumshirn wrote:=0A=
> On 22/02/2021 21:07, Steven Davies wrote:=0A=
> =0A=
> [+CC Anand ]=0A=
> =0A=
>> Booted my system with kernel 5.11.0 vanilla with the first time and rece=
ived this:=0A=
>>=0A=
>> BTRFS info (device nvme0n1p2): has skinny extents=0A=
>> BTRFS error (device nvme0n1p2): device total_bytes should be at most 964=
757028864 but found =0A=
>> 964770336768=0A=
>> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22=0A=
>>=0A=
>> Booting with 5.10.12 has no issues.=0A=
>>=0A=
>> # btrfs filesystem usage /=0A=
>> Overall:=0A=
>>  =A0=A0=A0 Device size:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
898.51GiB=0A=
>>  =A0=A0=A0 Device allocated:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 620.06GiB=
=0A=
>>  =A0=A0=A0 Device unallocated:=A0=A0=A0=A0=A0=A0=A0=A0=A0 278.45GiB=0A=
>>  =A0=A0=A0 Device missing:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0.00B=0A=
>>  =A0=A0=A0 Used:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 616.58GiB=0A=
>>  =A0=A0=A0 Free (estimated):=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 279.94GiB=
=A0=A0=A0=A0=A0 (min: 140.72GiB)=0A=
>>  =A0=A0=A0 Data ratio:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 1.00=0A=
>>  =A0=A0=A0 Metadata ratio:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 2.00=0A=
>>  =A0=A0=A0 Global reserve:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 512.00=
MiB=A0=A0=A0=A0=A0 (used: 0.00B)=0A=
>>=0A=
>> Data,single: Size:568.00GiB, Used:566.51GiB (99.74%)=0A=
>>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0 568.00GiB=0A=
>>=0A=
>> Metadata,DUP: Size:26.00GiB, Used:25.03GiB (96.29%)=0A=
>>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0=A0 52.00GiB=0A=
>>=0A=
>> System,DUP: Size:32.00MiB, Used:80.00KiB (0.24%)=0A=
>>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0=A0 64.00MiB=0A=
>>=0A=
>> Unallocated:=0A=
>>  =A0=A0 /dev/nvme0n1p2=A0=A0=A0=A0=A0=A0=A0 278.45GiB=0A=
>>=0A=
>> # parted -l=0A=
>> Model: Sabrent Rocket Q (nvme)=0A=
>> Disk /dev/nvme0n1: 1000GB=0A=
>> Sector size (logical/physical): 512B/512B=0A=
>> Partition Table: gpt=0A=
>> Disk Flags:=0A=
>>=0A=
>> Number=A0 Start=A0=A0 End=A0=A0=A0=A0 Size=A0=A0=A0 File system=A0=A0=A0=
=A0 Name=A0 Flags=0A=
>>  =A01=A0=A0=A0=A0=A0 1049kB=A0 1075MB=A0 1074MB=A0 fat32=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 boot, esp=0A=
>>  =A02=A0=A0=A0=A0=A0 1075MB=A0 966GB=A0=A0 965GB=A0=A0 btrfs=0A=
>>  =A03=A0=A0=A0=A0=A0 966GB=A0=A0 1000GB=A0 34.4GB=A0 linux-swap(v1)=A0=
=A0=A0=A0=A0=A0=A0 swap=0A=
>>=0A=
>> What has changed in 5.11 which might cause this?=0A=
>>=0A=
>>=0A=
> =0A=
> This line:=0A=
>> BTRFS info (device nvme0n1p2): has skinny extents=0A=
>> BTRFS error (device nvme0n1p2): device total_bytes should be at most 964=
757028864 but found =0A=
>> 964770336768=0A=
>> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22=0A=
> =0A=
> comes from 3a160a933111 ("btrfs: drop never met disk total bytes check in=
 verify_one_dev_extent")=0A=
> which went into v5.11-rc1.=0A=
> =0A=
> IIUIC the device item's total_bytes and the block device inode's size are=
 off by 12M, so the check=0A=
> introduced in the above commit refuses to mount the FS.=0A=
> =0A=
> Anand any idea?=0A=
=0A=
OK this is getting interesting:=0A=
btrfs-porgs sets the device's total_bytes at mkfs time and obtains it from =
ioctl(..., BLKGETSIZE64, ...); =0A=
=0A=
BLKGETSIZE64 does:=0A=
return put_u64(argp, i_size_read(bdev->bd_inode));=0A=
=0A=
The new check in read_one_dev() does:=0A=
=0A=
               u64 max_total_bytes =3D i_size_read(device->bdev->bd_inode);=
=0A=
=0A=
               if (device->total_bytes > max_total_bytes) {=0A=
                       btrfs_err(fs_info,=0A=
                       "device total_bytes should be at most %llu but found=
 %llu",=0A=
                                 max_total_bytes, device->total_bytes);=0A=
                       return -EINVAL;=0A=
=0A=
=0A=
So the bdev inode's i_size must have changed between mkfs and mount.=0A=
=0A=
Steven, can you please run:=0A=
blockdev --getsize64 /dev/nvme0n1p2=0A=
