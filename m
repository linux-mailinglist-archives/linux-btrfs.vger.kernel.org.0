Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B52B52D1B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbiESLoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiESLoG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:44:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EF1B36DA
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652960644; x=1684496644;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Zl0K6L1MIR11vzKaw4scE1uzsCYl9Cd/xOyqtqfVywI=;
  b=JaceUHdVfBqos6eSQftmPacJAbPgxY5tp4TAv2oewCYl+Dj4BzU6+Kqu
   7CPt9wvieK5fMokkI/clpvPM/i0WIw2Wn+3R3WiRh86MO+x3Y2j7Cn//Q
   ZuWdhXKPTet/oNVJbdwCaYxrRPqo1ISqoM4JHj+xv5jtIqBLtHd3j42C2
   ZfJnZBbpL/X4Inj4CLv95araqyfjqE7ligFVXxYOTpm9+VbiEmiRTifJF
   Az1pDRpbE9G3H0CpDYM7cMrx5PCHfvMQwbGlCghtDe9OCfdTXextkgWBg
   gshcO2HYcskyhhO6Lee4xMf8MXiqnCyyNYmPOiNdhpTa3G3NorX9DYIZe
   w==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647273600"; 
   d="scan'208";a="205653170"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 19:44:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEBDY+PSoBLgQpIJQUkDzmeI/IArCB2KwQ16Cf1PCQ5YYOf9nf3SrlyDemZXPGDNYXXl19kUFZfOXEPhTNsP3RlOsYNZv6TrVdYvnQfiwZYrF2oL1cEh4Z/ItiMh/3WF1GwktMblVzLRTsnc3N35kMQESWPXpaR7smukBs60ZWX7MzVWkjZ7ZUZ5tvUqfYyUJi3EJ2qOtf41V8+rN3pIsFEVTyn6EWrjOS+l0OmwmKcDyu8mNJGBiDe3BdUrI9RPGskV+dLV1BfRaU2V3fmek8zo+ejTjIjfN5+WiQM0uSM1GrrjWLon9wIjLa0JsdRXd4Sj2Iw7lqFx9fiNFUvjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zl0K6L1MIR11vzKaw4scE1uzsCYl9Cd/xOyqtqfVywI=;
 b=GWS6HT+oqlibAOmei5MlWrWSHYrRn/Md6kH+18FpaevlAy9vt4HWlqxfb/03x2gX6bKkS4li6LdpkTOXO6a3xLXa7QivUayBZsosi8uBtMvUgbiu9QQ7bqbISG6kJ2/Bb/b5lTB12gUcQMG6xlLElA7zQ5e0Df3NMkv/5hOCSkCciQN6HADwq39kpPUhom8h1UOE2+mFez45uY49TgCE1XlOWNc8pRcHgd2DlPiKbz9Mr4f4eHYHtAfawVllPa6JCQgtuTlHeNfx+B0x2A4QpGsPUgvBt0+0JdifS1HTxeETbEqr/Ju6UEX1gdb1wrd/p/gMjjjN8er1fPve5lG1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl0K6L1MIR11vzKaw4scE1uzsCYl9Cd/xOyqtqfVywI=;
 b=e7GBEwWCyWWELrbMxw9w9W1Z5bOAG5DYXCPOFSw1XDBYEI4ePphYikEbnTMoo6NB4dehqRYiQnKp/UZMtT/LpUzPzmC14ymosxNLXK6R5TQ5Do5wfUzVCs3FeK90gsVuOz0+aJpTIpQkVfM5F1YL6WjGm6904YIV9Kc8HNrJJ2U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4825.namprd04.prod.outlook.com (2603:10b6:5:1f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 11:44:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 11:44:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Topic: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Index: AQHYaTGyleh77VsKp0OYSKTjOAeG6w==
Date:   Thu, 19 May 2022 11:44:01 +0000
Message-ID: <PH0PR04MB741655C18EA13F9152DAEB509BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
 <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
 <a1b876ca-6e6e-39df-ab70-0dd602229f0d@gmx.com>
 <PH0PR04MB74162E6BE1BB1F9519C440199BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <a6540b7b-409f-e931-dbfd-98145b48581c@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 318764bf-b144-42cb-65e0-08da398cde74
x-ms-traffictypediagnostic: DM6PR04MB4825:EE_
x-microsoft-antispam-prvs: <DM6PR04MB482582E946A14DC875741E509BD09@DM6PR04MB4825.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZC82t5N88H6MDjoW360iZSREElPQHO7SNszoJU7fY0jltR4i08qXu7UbcghemQgmPb/fBrBivz1PmKhdMuEGhNABMt2iQt11ssO6/HNOJd+yZkVy8DMg/a44XbxotDozfAppiKtT0x6ydongw/SKi7BRkhQqnHQuvGMKlb4lx8Oso7Ordm43+i56nGYYd/LXhnH8EkaJiPY/I12hXX8VH7geMkZvMyIK7CT9jh3mgzhP8SoVpu66+TGZhaVSCeDvYP9qvpkjGCJp1D9e1c8YSzOtisOZg7Tvas+JoWyI96VGCv2MPV25c5SzbyRGMOyshk91Y/AWBAOLq1wZP/jHovs5mWV2naBZySKV+H9uBN6QcY8PPnP42/XsV5XXn0gV0WVcaYMrG5Js3rhUm7d4YpaejX/KfHT9mIvzra4FJS1h8lq8qH+5ZpS7rUfH/PCuWxdq2EOVr1HN4+6GkHHgvUOyhXKMW/pAFiTdUJn0QRV1EIKljfqXMz/cFUOM2HgR5VctGA8EY3W3FHYMWiOF3iDFL89n3sq4t+d5+k2maP5bWQOgf7KAq4Aq5Q3P/N/g1MiEbHUr0d5TpgrwcGQ9Okp1z9j+3gPKSUuikcVEpLkEQ2O9jkJF7F/PGXmtzZZPwBENlClLzEoCg4owP4vKtdwhUJa1eHPQaspi+DiZrXCbVY0YaAugWbSHub54ohxxNoOvVpuBUu6Vntir1q0FQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(52536014)(66556008)(86362001)(110136005)(8676002)(55016003)(66476007)(66446008)(64756008)(82960400001)(8936002)(5660300002)(76116006)(66946007)(316002)(91956017)(71200400001)(4744005)(38070700005)(122000001)(6506007)(7696005)(2906002)(53546011)(38100700002)(9686003)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jWlKA0HsfqzsUtMYJNhyclyk83ShuXezpkWgFpBbStN9sZbJD7LvttwFpCCF?=
 =?us-ascii?Q?8vXRB6pqLHt66vAC3095n6cZRX3+mp+aMIAU3JT1kPQ6LPCh6nk7HSBUZwkm?=
 =?us-ascii?Q?3dYckUWiYHTtNWbuc1hvKbJNVKQzXOZJjXWLt/7ArdREo7WpWl9S2guqtX9h?=
 =?us-ascii?Q?dK/txooXkMNiGQMrzhHF8wSOZN2iJnGhq/d6M5GE8a65wflDskWeqX1xF1AM?=
 =?us-ascii?Q?cnX9qm6eKIST7uMp7459ZaIDfS/ZymLxO0ihLher73TWejUDBEdHWgeJo9Mp?=
 =?us-ascii?Q?9Hh3WDEPEBTuKVEHv+fWjr8Mph4Z+2+thoSe9JmPTkPxL1OOOMJaY1JzwUPE?=
 =?us-ascii?Q?bzsJ7Vm0lawm54pgPaOzcltppIqvBfau4dqSq/UVC7DzJnMgqPBSoVOdCkDF?=
 =?us-ascii?Q?2Jg4/aFC1yTsIxUW5DjxeaaDqrEBeAbhDX9luDAIBJsQwH4PSqsNJGETTXp6?=
 =?us-ascii?Q?QwAMfioneKuG5GhzxOsMT68JledGNl1PNbOTTwrzZdTK192ol+OiD7Oqpmlm?=
 =?us-ascii?Q?OcUBWTqrBMN2MJ5fLseXdw2gliN9znPT75PBipn/LphgiFMCf5aetNnIu+eq?=
 =?us-ascii?Q?dW3w07I6hv0RpNPLdpTSwaEFXKuEfscPz3JoSYFFCTsfm0IYx9VXanUQF7bP?=
 =?us-ascii?Q?ihhDPYvhrmZPGRkSP/KPt9gUuQ2UEEczcmELOCLBt4OZWY7wJS7R57n8muTt?=
 =?us-ascii?Q?qGlspjwxK/GVvX2ETFjIUCLgG4xQdat2cHLQWbqOIQPsJusVJIHcorDo8LkU?=
 =?us-ascii?Q?5VI6MVqcuCNb9NJaEJjXQxYXI0cxkXVG2HwCmw0IY75RJEtQh87lTbdFL1ya?=
 =?us-ascii?Q?iIwwr3ptOrUQStOOzWrsTOiAaFD6i8Mq5u9YjcmbNIrniAW9lUPFlg6O3/+D?=
 =?us-ascii?Q?Sqm8VaRTa8tGUw9uoMw/nGnu+NVNw0Pv9i329dgyawc6/xJ+zarKfv1yzFAG?=
 =?us-ascii?Q?jTOeLcX7As2fxbH4nGY2okUYtUDG5x51LYAcS8nRzZvR6G/qt3DgvQDrvfXR?=
 =?us-ascii?Q?PGsxU26opdrqc91Uq+c6OWE/uSTymgEeV79HT10W6LSlTvUDQmH9MPGQIqE4?=
 =?us-ascii?Q?fPUQglp72DtXYESpwt3eBSxosXxfikkeRx1z1lefMyj1tCuSyrSW1QGDPxbx?=
 =?us-ascii?Q?va/ymwdNUvur+lCFkQikronyo0KBTOPWORp22GNZJksb538FqsWvCvAobQqX?=
 =?us-ascii?Q?pFMHDq85hg7yfbB/ccYNIIrFKXInRrUb6smEs9B5gJPktaeGXAKggItttmXb?=
 =?us-ascii?Q?ugdTHMSI+RRhSnS7h1okShLReJCJHnZeNMEeIOVMsIpIcAFFQCtj2V2MWLb6?=
 =?us-ascii?Q?5Tyzxhb4l+8V4evJm+utLnBLlwJv6zv+2cH0d6MUBQRukasGyzrPy7cM3Ls+?=
 =?us-ascii?Q?YCKu/YfD5b2G3wxEoYWhjXJYaoSydpxfxdwU7DNL1N06JgSg5rQST3UOVCN0?=
 =?us-ascii?Q?5Ep46X7kqkLxF5Tj5KRim6sHFSOkAn7CdiVf7ZGvgpmQ7c4yes8LuJTeuVnz?=
 =?us-ascii?Q?cuMbqhkNz1zhWOUEy1O6qI/mTx1SHN9n4lhVinXHawdwjLhgp851eJ98jvSc?=
 =?us-ascii?Q?Fj7kxrPGOVtx82Qv2gYpPkXMt0wr/Osspf34fpdfvbArrdNuYf+BvGYtNNHu?=
 =?us-ascii?Q?CZrgqD4y1KcEBfzblrS6I3r6jHnqIxjccBnJVzbeUCiJTZyLNKsD4a30EYNh?=
 =?us-ascii?Q?BvZJvYwDl6wuTQVzPhpVYq7rjcnxlnxomrXLBSrq1DBywuLRbFKi9mRxDuti?=
 =?us-ascii?Q?v+ADN/R5vg4tqE6XdhuPW2feRujLyBneajwNFy0qtvkJ8nIRvzVbZP7TayYc?=
x-ms-exchange-antispam-messagedata-1: iwCPgbXxvzzLTtD/PXyBWq3SJOCMbuv8DlNwHYCcWwr+d/vNGQolwNRA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318764bf-b144-42cb-65e0-08da398cde74
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 11:44:01.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56VpK7YdJMJksLZklJkfwM28r9T2uhmHeEb52oiLTk2C/hsy6hDz/fseTisCzpqmmObx288YFoQj2T1x/cLBzrzabAZmIPXqX2mx4vrm/JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4825
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2022 12:37, Qu Wenruo wrote:=0A=
>> RAID1 on zoned only needs a stripe tree for data, not for meta-data/syst=
em,=0A=
>> so it will work and we can bootstrap from it.=0A=
>>=0A=
> That sounds good.=0A=
> =0A=
> And in that case, we don't need to put stripe tree into system chunks at =
=0A=
> all.=0A=
> =0A=
> So this method means, stripe tree is only useful for data.=0A=
> Although it's less elegant, it's much saner.=0A=
=0A=
Yes and no. People still might want to use different metadata profiles than=
=0A=
RAID1. I'd prefer to have system on RAID1 (forced) with stripe trees and =
=0A=
data/meta-data can be whatever. Of cause only RAID5/6 or higher level encod=
ings=0A=
which might need a stripe-tree should be accpeted with a stripe tree.=0A=
