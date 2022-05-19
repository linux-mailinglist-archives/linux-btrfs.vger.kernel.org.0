Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B37452D1CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiESLxM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiESLxL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:53:11 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B4C69B60
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652961189; x=1684497189;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GI8LJzofyhyQm8Ebltpa5/Vx/WsdGzLjOrSYxcKe6K8=;
  b=fWdwA2ql3/13Yx92Z0DJq+9s0I+wY4/KackWR5MvVqIpAueqcFtFyEi9
   raIFLtjPPZJY/82rZkrTXPwp0ve5G5iMBqy2r/vSA6fs3/b3vKBDy8Dgn
   53XQ/Sh+1VybBMg/J/qGz6KmC+ElTZY3one8W3k1/1Uie9esvOQFY/Nf0
   wJh2pkEKlsIE4xwBBXaiB7AhD82Ks4u0b1Xtt57Rh2aiQ9yIl2v72cBac
   IhQ4HqnnEykJga4IO2EbpN9mJeng2SQkCfQU7PEHmyF8bdu0vfYD7IYMz
   qQrSR6Dup3a7oXpcasM6PC0UujW9H8ecNwTi2ZtGexQGQ9aE+ZwzO5zE+
   w==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647273600"; 
   d="scan'208";a="305007477"
Received: from mail-bn8nam08lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 19:53:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghCEuVUyf22UCuk+C/7LOjIhh5Nz1OEIJCacMxSpOZmMzJ+a1z0+TfVAlm7WO6TWosEo1aEqXC2boDjbVTqojhnFVUqLcEj1hns+eDKhbjyhbxtpU7ykqsWXTGCd+cnlk5OwVPbwXTiZN5W35yICvblPOpUSb/uTWwqJU7+6KTXoVOo3vxIoEtxtbNzxDDiewOTNDyxyYuhc7rgKmDknmzEMg5O9eGj8SmTtF7oOzGs8aCc0kTt5slqXwhLKm/uqtN/5knwpUjIXOFdWPVBeQEXpocqakXDCPJiWAjkixK5YjmW8d6nlFG+zwcam3VrXoo3Ed+u6pzyRz2HMXu8QCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI8LJzofyhyQm8Ebltpa5/Vx/WsdGzLjOrSYxcKe6K8=;
 b=CQUqOAXbRpV0ST4D5MssyPJGcIrApKzyPgC9fv1dpsovyTRbDXCY51WcwmYEMSd1PUrvFY7qNSYPcfW0+BgI/NfAiHzIakBPakplxdHcIp5F0VWNsu4TAz/u76NcyAMlW602LLU9p2g1lJxdlgb01tHZdkl9T03Gl0e/4dDWuXFAXLwducDl6s3u5moJIIVlana7WO1sGGFQQaUmw4u6dEXUdk2E/h0ipdauhig8R6J7E7YUaRXSF9B8HCWY2LZT+1N4ddfOaLxfTvIkUYdgtzhNpXM9v786N1YyuTNKVUkb0iLpyFVxN8TK2qv5ALFV8V3N92K+DGEFjln1YECA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI8LJzofyhyQm8Ebltpa5/Vx/WsdGzLjOrSYxcKe6K8=;
 b=WGBmAf0rqHyzpbZ7G8g4AkGGKw8kCyt96tDwJZT1atBW402LLF9dr9yJtezOdl9omdsa//CwAO5kptRuKqC6LloKS01UIX/hyOvlLmXvk8juJAyLyuoyaFWuyRWRjJcwQx9kEOrl6Iw5vQcSDIFFE+t2m2Ip++vlic/MSwVY2wo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7173.namprd04.prod.outlook.com (2603:10b6:510:16::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 11:53:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 11:53:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Topic: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Index: AQHYaTGyleh77VsKp0OYSKTjOAeG6w==
Date:   Thu, 19 May 2022 11:53:06 +0000
Message-ID: <PH0PR04MB741660F84BFA0F9C4E0204A79BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
 <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
 <a1b876ca-6e6e-39df-ab70-0dd602229f0d@gmx.com>
 <PH0PR04MB74162E6BE1BB1F9519C440199BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <a6540b7b-409f-e931-dbfd-98145b48581c@suse.com>
 <PH0PR04MB741655C18EA13F9152DAEB509BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e66ba88c-52f0-3db9-7284-f7a161542634@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1175948c-5de1-4eab-5704-08da398e237a
x-ms-traffictypediagnostic: PH0PR04MB7173:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7173CB4CFEA86D54F498F1B09BD09@PH0PR04MB7173.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umsP99N2G/vza/4SE3wjUy3WBcmSzWV4Fwa+BJKZJ8dd0WCWloEbhctkfs2HqIQiCcn88pd0ixFW82koQZyklko40bLHaGuO+HxOFysF1UZupx5MCs+qewn+jTTjrBHFAIlMSKBl0oYOeKvALRTSZhjJxT+Yn5YBwV9Dr2Kw8cwPcpe2lweJk9XunA/cHD05lwQwCMycSQRqtR/abm8bG3sNVOrW1v9uKSrfZJHxuMxaRCDpk+zbte2QcFaXFVhFsPcs2oYE1LxgP7WZLsG+JF4tMITO11ilIGBNNWdfjPWgQOR1294nM1Z14Pu9ZM8qRpuKALXtPKB8O15M3XkZDKjLwR0EnE/Q0nmMa7abicsS+uaDAX7bJNvRv5hWwUl6KleH03MHKlq7UdcXPGNl3GIzADanZ+xNs38MKagCPQmdmP/2XEtOvuekBkkBf765J3xCDl2GuF4X4ZId03Ekf9j+HN3p+mH827jNvWlzuVSmkThOP4D53E110umwlhy+0FO4qd8OUd2HpgpTNT0joVZ2fdQ0sgGerax0WxyRUnr5RacDvFHQ9Fuu72cvmf0uqZk4Ykc85+/nPSSV+wI2QVuWjDDytURbiyUYzXjAk4eI/3RRPUANht7TnKTxvLGnjcv3q0OlQVscLTGnmkeCDwNlusxOPF1pQyIlQkvA/E2GdZpuxc4aG4oSTA+7p0IVUfkn4n2y6uXl2K9LxinM0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(82960400001)(316002)(38100700002)(38070700005)(52536014)(76116006)(53546011)(66946007)(66556008)(7696005)(9686003)(55016003)(508600001)(5660300002)(33656002)(2906002)(86362001)(6506007)(66476007)(110136005)(122000001)(66446008)(64756008)(8676002)(71200400001)(8936002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TQkZZvDv+UYs08ebCxw8iL6vKc4Q4/gfoiNbkKzSVETxztgoy2jcFLabAOfI?=
 =?us-ascii?Q?Fa5HUM8kr/YCS2PbBl6DY1WSMl0tR/NdP392v/jMeonmHOGWKAFsdfP680Dj?=
 =?us-ascii?Q?CIgpEezuYvojZWiWQpBI7VkxA0E2+yn/PUtanddB5/N5LkDSQZcYo8nIdPWL?=
 =?us-ascii?Q?Y8lN4Z7ZVlYmerHUoCDt4Dmu3IvB2CqtyOsl2pD5zbqmmSak1sMYpuG+cBsE?=
 =?us-ascii?Q?C8uAY6Hjmw/j6NuaDyZLIsZ7dfvNwZ2oUKHELdqaZfIa6BJtD+zqNmOyE14T?=
 =?us-ascii?Q?gWQ+VjvL5BQpXEYMyzGtWzCwmjFAAds4FxkFN66YZL95Opr8VkAHA8gLaowM?=
 =?us-ascii?Q?0GLNL0diUfBg/1tpuoiUYRr2TClR9b0/3bu5v8QFV2wSrk5iECHay206Iw53?=
 =?us-ascii?Q?8IxVE2SvvrKJ3/sApL/dN3hgNFghxe1sB6MOpp+BGV8PW6X+mZhB//L9C253?=
 =?us-ascii?Q?PygUhvdsRxUA0+pcZGEBa+GfedMoDK261+1yJHhdcWpTTJwG/O+tWbF6+6+u?=
 =?us-ascii?Q?eMrFj2SRocafVPbvxqb30nCusW3vK+BZ/jrEHY4oCL0gmVBUNREbNrsOMctR?=
 =?us-ascii?Q?OP/bg1vowir3NOGMBZplXeUfj/I1BxgIzGkreLhE4dlnzWpALedPH9zGx9kF?=
 =?us-ascii?Q?ob8OW+PMcdApz35Lw9PBj6KI+NxvgCGSHEIdhmeqtUdoJS+1CpiwA8pN/Sre?=
 =?us-ascii?Q?Vunp9SgA4QdLRfSHK9EKb+nJRkw4hIe3Ckn94NlaN7poRxECl7rAUZcdBdd1?=
 =?us-ascii?Q?paAXd+PBNUXSkB6oOUCeKjLe5fj11vgCs1k5FH09lXnQ7y0hjNy50TLF4Lnt?=
 =?us-ascii?Q?d/6/ZfqE93sQqh7jC7IGTwLGC+29/FFEFtrPrPzqdFo25kgr+WkQoHN/ti5b?=
 =?us-ascii?Q?l9qcKb1tztH07Z9NQkheDYZ2Z83AS2LDsRlbMCL52qY+GDD6qDL448WLrIi7?=
 =?us-ascii?Q?k6qbgH8qs4YxZF+xoVum5TP2jOs1beXiY3lEH7lJCPgFysvwArOxVm0z2Uz/?=
 =?us-ascii?Q?hL+06l89EVdt/FxJeqma17og+BlL+mRIODgEYZw0IObJ224yd6ybZsatMuWf?=
 =?us-ascii?Q?lAoslEKPxH4TKU4uy2UvAlGNQqkPHXPcHXSgWXDAS9/UvzJNPkCbSEKTQrDh?=
 =?us-ascii?Q?cKGZNC/QAiyYMSl+dltQd8/EbQoR8gAJXvumkeWoGKrv/FqvvTzWiB10LsXd?=
 =?us-ascii?Q?J/h+N/xVgc4la0AR1qq5uBXKH4QCTug3ijUZybOkoud5wo9NrX0LOSXXpFU7?=
 =?us-ascii?Q?VUWXT6bzhAtJ0r/MZPeuwCjzm162UuglOioK8gA6pAe45+lTRcmv0dZ9qscU?=
 =?us-ascii?Q?XarTUIRS56qC93Ypak8FGIN6wkgOB/XGEfYoRcB+tRnXJKffqmD+FQ4a20Kd?=
 =?us-ascii?Q?LvcYm1TqvD1Z0Or/bSCbUY2060/qNw7fuOiYpcltO41KHGKhBxXdenCHTnL7?=
 =?us-ascii?Q?PnmGApJI0AFtusD2NpAN2oPQL/W1wub8cwqLFJGtuFm9HttNn6ooaHbLQhpA?=
 =?us-ascii?Q?mpG/Z/lvCVSDGPWSz+w67Jt2gLWcGK/bUdIPu3ZpGn2ZAtAkU+Vj4YLy6boB?=
 =?us-ascii?Q?QXvP/1Qz1rFVi6VokI+0Tq3p12j2/Dwoao7Gfw4y6WQsdVg2NDQtpsdnl5cU?=
 =?us-ascii?Q?eGRNfyzcBQ+b8MwXpq2/HhGk72VFnCpnmW32TKeMoMazRAg/m4ikJjsCkiY+?=
 =?us-ascii?Q?Va3I8p5UDcI+ZHOBS8lk/lFbvn/uUcoIbeB9Bb/yzIIKx4VQooPUQjoTg4gx?=
 =?us-ascii?Q?1amNAjh0QLUKmfHzxfUF9jwaMl8ziDAaZgA30PuetqTG4DB88xz2h4EDa+fo?=
x-ms-exchange-antispam-messagedata-1: Fe2UETiYZzmeg7cK4ukogkoDS5mttIVZ+h/6iSwj6xcd/WkK05ehqGsR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1175948c-5de1-4eab-5704-08da398e237a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 11:53:06.9393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyiHzTWPXh4L9bU6SEl4L6E9ZwClukVkRFDz8kJWhqb7N2cTX3yHhRsddCN3GXrSljTBMhDIUsokeoXcyHx3qbl+TwXtStt6b+8nAOnJWi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7173
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2022 13:48, Qu Wenruo wrote:=0A=
> =0A=
> On 2022/5/19 19:44, Johannes Thumshirn wrote:=0A=
>> On 19/05/2022 12:37, Qu Wenruo wrote:=0A=
>>>> RAID1 on zoned only needs a stripe tree for data, not for meta-data/sy=
stem,=0A=
>>>> so it will work and we can bootstrap from it.=0A=
>>>>=0A=
>>> That sounds good.=0A=
>>>=0A=
>>> And in that case, we don't need to put stripe tree into system chunks a=
t=0A=
>>> all.=0A=
>>>=0A=
>>> So this method means, stripe tree is only useful for data.=0A=
>>> Although it's less elegant, it's much saner.=0A=
>> Yes and no. People still might want to use different metadata profiles t=
han=0A=
>> RAID1.=0A=
> For RAID1 variants like RAID1C3/4, I guess we don't need stripe tree eith=
er?=0A=
> =0A=
> What about DUP? If RAID1*/DUP/SINGLE all doesn't need stripe tree, I=0A=
> believe that's already a pretty good profile set for most zoned device=0A=
> users.=0A=
> =0A=
> Personally speaking, it would be much simpler to avoid bothering the=0A=
> stripe tree for metadata.=0A=
=0A=
I totally agree, but once you get past say 10 drives you might want to have=
=0A=
different encoding schemes and also have a higher level of redundancy for y=
our =0A=
metadata than just 4 copies.=0A=
=0A=
The stripe tree will also hold any l2p information for erasure coded RAID =
=0A=
arrays once that's done.=0A=
=0A=
So this definitively should be considered.=0A=
