Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C72A3887D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhESGzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 02:55:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31615 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhESGzO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 02:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621407236; x=1652943236;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yYCV1IlUpB+t+PNmYwXYNJ1S1BQjXAbOYFoHHo+Kkn4=;
  b=SBMskn6dIamYJWMvwERcuiqg4gTsUZe0OPJDDQ87xXobQp4PqcGgOg0Q
   O7TUDtgbe6yZns2I1dVNYMxQZDTYP6FuS+eQSGTcSbEptH+qxFLa0s1gT
   P7dIXkg7LZAQxJHgcQfNlq6pM5jdJTrPPmZWLaKZna2ZIFVrbDOJqdS7f
   sVV+7Now/vzs4pcwFHcT34fZJOMG9s5HORi15tvEOUVgoB+xmN/i3t+m6
   z1ENmTqhSfEoK5NtfqobvUSsFH1F/XdXKeD+GiGnGZ91xOGNle2VGzt4Z
   2LDC3Xys9JR8JhM173ByDLyJIuZAZNZyAFLqnG4d7W7Tg3OfILy4FWllj
   w==;
IronPort-SDR: 6J8o1vrSnOmNfJLs9hXtUIoADhO3MRhydTIsGGOTf0h/iow0G5WpJ+2EnZlzvLIbSARS+PjLvP
 wup67/cYcjsPUo2rcZyANzr6voSTdyttAWWZZf0s2ds8/fTXm1sHEKS/CDp+WXCvPGcWUtvMlf
 LNJl9gi4SI6g8i2SE127/XJ76Zc7DeTo6vz3UHLo3ihCCArbINGqCy1QPRlPOyzO8d6WHNZv8b
 pzCw9yIbMub9rXHbyzal1W04KoE1mljs7BdDAXlFDKAJ9vfpSTLni5chGB9vaa/U9ncGOquXBb
 R9o=
X-IronPort-AV: E=Sophos;i="5.82,312,1613404800"; 
   d="scan'208";a="169215109"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 14:53:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBWh+x3o5L7nrKbj61tJNeQnUy+Tr37qB7Dd4qAk7kjKLNNvNsgRWXT79yI3spYxBnPR1t7a7c/Sj5s8JdFmcpLLWB6hGpb7YwOb/B6cfmxwAM+DEOkEIJE+igWXtvbbvrBdrIFVGQjLYe3FRndB671AP/DkEU02vLiBGb+BuQoPGoQnRPejG2Q72QfhmKrZn3rWHmMxNmuLAC8SpI6J+8ftED3bKBvF7waq3fT60AutzqfnNrH6zbVR+O6lkxTMGPMWY9Pfq+IvdCbHWqS5yEDRYCV6CysSIDcc6T2iv4T6aeEstaUiG3+nQTyNlbnzZm2anNNbi0q5VAjIx4LOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leLfmt0wYMb8Ix6F9Z0LFrRzhi48ZwcF0gyJ7bIapn8=;
 b=H8mmwTnCDyJJv51/n/i5rpzmnIvXLmUkQhoQ9BLqIHnNdFzmX6reg+I1mb8aeQEdJ2VNz0k35829TmIrRs5A2pZYTo+qq9dL4ceM7P+KRvfoiaa3zwizaxRvi5EAdtTPz2Ankcimu9sXcob7IBi4nq1WoZy0fRwE6k80CS9Qkl4KtBQkRPCCJHtzl8vEDVUEvE4tE/n+kQaFej1JbpfIWDwsFf7LUe5djLfGwS9f00gIxcaNS4qw0s8WBMLcTNQnwbGkA72tsqCpAxb4RSOo2v9dD7ZPBt2dEF9zovtNNqrImYHA5sAwwATiLg+0hUB87GRyFNXJFKFS7H0pEmb/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leLfmt0wYMb8Ix6F9Z0LFrRzhi48ZwcF0gyJ7bIapn8=;
 b=wDJ/+G50s2kM5F8mV0sQUHMB4MbEnPkFSsHbfLRbVYFJpRipUhiXP4EKQJ+cmcODqZTpii6jmHweVT/kbRpXyZGDwu7TO8C1nRlJ73/a1EnjCSux9zpoMCejLPzPwMk9+r5fAKPco/Mz38s9N4HKZHmOgIAgSl2elZHwgpnX1+g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7686.namprd04.prod.outlook.com (2603:10b6:510:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 06:53:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 06:53:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Thread-Topic: [PATCH] btrfs: scrub: per-device bandwidth control
Thread-Index: AQHXS/Vlei4t9RXqlEKyfFBHrG12jw==
Date:   Wed, 19 May 2021 06:53:54 +0000
Message-ID: <PH0PR04MB741663051770A577220C0C539B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210518144935.15835-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:95b:718f:422f:1ec2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f91004da-73a8-4a85-f86a-08d91a92de0a
x-ms-traffictypediagnostic: PH0PR04MB7686:
x-microsoft-antispam-prvs: <PH0PR04MB7686FC90D1A1AA7CFA79C9559B2B9@PH0PR04MB7686.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8ybgbJckJKawEgT/kU1YWrXeZVGK/4NdvNUnSqUMXCNLtJPYXGfSYPdNOIHt0ZYNaDyk++CEeRLMmIJjYGwJQs25ry2mxTW3uLcTdlBSh4unGPwxpNKzUgx+F7UrWMXmYg+E79xUp9c01OIb7EaXEXrjajpBztWLFfEQm1ff8SBNzWCJya2H80uU8nqLE5KDrBnE28DKy98dnvgV4QLhNwvVDCrshRNOv/qVXuzCF/b3EtHL5QFhCo0RKPivy3vP3KdH7lHI0aNHK540cf3sNPNu31IcVz2ePUj0JOM1zjqpb5jaWwUN4F0tWxx6zqKALOYfz+a/QdKr2NE9hYab2Xq7qxEk8ucKd3B757aNvXAQFjz7RA5LyskTlyxy/iIvg5LSc6CxkfXS17lr7m1BmaStBKRGmIpdqBDSMidMS6+OYbxAmVO/hZmfL7FS6ihwKWP1iPYjLoopW5XwxPTJug+dqfpJiMhHEdTnVYFtiEcSvZn5Es+8b/QNH+QX6tbYIC7vVUiAGY8Up4UN4WZS3q8VVlZ/St1HfcH7lz1wQk7bFQ/A0oLtbBRAbiajplr4Yq5bJaWEWJtM2yLQAvnWLc6t9cUIo3X8WpmYIcG6gE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(39840400004)(346002)(478600001)(8676002)(110136005)(86362001)(7696005)(5660300002)(52536014)(33656002)(53546011)(55016002)(316002)(6506007)(76116006)(9686003)(64756008)(91956017)(66446008)(66556008)(66476007)(66946007)(38100700002)(2906002)(186003)(71200400001)(83380400001)(8936002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8sjTMkNzsn88iWYulPIYYA1AfisNHZa555S5t5qJeuMsAbn9kRvce2S8O0Ey?=
 =?us-ascii?Q?KIzRWJC822kR9sM7Vz8GMrCeyZl1Jr/SJx1mZNtqxASBLONn/7Z8Mrg9g9jH?=
 =?us-ascii?Q?TroShe5zo1zXeTWBSZ3h5F28NUMRz7neNLpOH0Ol9BejHilgHcF5RcvACcHG?=
 =?us-ascii?Q?+9LFVR0Qra2GlPaTp2buSGlE2UjCgMMXWFMglk6th2ZULBUU+aM1YGJfngbr?=
 =?us-ascii?Q?CforbfNfNjVWcMc5lRfqnmc1iDu2t/bWnnD9riaVN9tRYv8goKEMut7vBpwW?=
 =?us-ascii?Q?bYaUAl/4TiMywrn/F8ysTtk1FHE+NVi/3zaew/LMpQrzDzvMG29onETfOSOY?=
 =?us-ascii?Q?kJXk/oJzq5AZcIYWs9yrVNYt9FPyDcNldn94k25JKvbEkKJc12Wa1qq5ofYL?=
 =?us-ascii?Q?yZcC+rVOgZgDdZEbR9dEfTnYEp6ASMqj5a02lYySkgwJG5Dx6yV+ZpRt+POE?=
 =?us-ascii?Q?UyRzzMkYKlTC4Dxt/DNh5kC04IucG3cJL/1oQp1G5pVTnUWtkDtG2ILSYnHl?=
 =?us-ascii?Q?ZI5d5Wo4q6CISrCvMk0wNe6/VU2nXzL5OU6Pgl4mhduCkjcEr0tsYyQzfSB9?=
 =?us-ascii?Q?uxIqRPbpWqzE6CgZvg1VgBTiTSvoB6GdEHVs9ECwoefb4LugxyW8JWhriPGa?=
 =?us-ascii?Q?9aSMt2gS0zgngPOdYDKt9MauG4tT2fhGYhgbbw4szbCY49CobGgnhS5XteUS?=
 =?us-ascii?Q?REhfvbtc9Ipj05vYKpRvBGqIQFv7Na0R1xvv/hoEDk830t+3As1jigq7cXQe?=
 =?us-ascii?Q?29eawKzLWoLeRCMxdl51itawLO2MuLMQNfbz3ACd0RidOaNZbjpFLpIMuwBE?=
 =?us-ascii?Q?qI95WnOlgifoUQMvwG9hpgDjG9sMWOn0z8bDlFFhFafkjh12mJYPLxWCUDvw?=
 =?us-ascii?Q?qz3erbY9rac5WPml7Mu9fOz4g2pwuP7ALfF9R2OrfSdGOOOL73tPO6SGlV99?=
 =?us-ascii?Q?RSW/pgPwSn3s1h1mIisZjeSqWI5dPdqcjghFou0CVPW6xinUVUGCRiIzuRo/?=
 =?us-ascii?Q?L+6gHnOcwjeez+hdnoBJ49xnX9McqXFeXw7zA2tsq6v/0OOCE9SLot308WIc?=
 =?us-ascii?Q?WQzlfZdSDsTNpNznCrbqPZ+V5ITlEptBfY6rlUN2Pq5/xFP6NZx4EWv5kwaC?=
 =?us-ascii?Q?Zcu4YLhsRTDE1d7+jNSckqnaQlcWYbu1RZW9eIlrYM1n1roL14YhLYznaBIQ?=
 =?us-ascii?Q?lJ4BXTreTiR/deoNsu0wUVNNiR2TueXekYp4Vz/v4QUNyOiQNMw8TZ90UtQU?=
 =?us-ascii?Q?wQsuD5m9oFd/PZDAcg2nVAkqCAhH6VQ4523c+dEv91/w+p7Zangjfmx8x1Co?=
 =?us-ascii?Q?JlT9574sY/qRTYgK3jWPBF04AKtkKdyRSb/RKuIXIz9vUkOX/Yimy5njeOg/?=
 =?us-ascii?Q?gpC5DMq9A7wfAM9/cbA3DYhTBTXt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91004da-73a8-4a85-f86a-08d91a92de0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 06:53:54.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIabhtMAdC0jHLqfogMJbh8R27r7E3Z7Hz2r2oEXBLEr7kWuMjRBKjbTDY6jYfxrKxVnt7GXRr7GWJxxuA0BmL5UbNF7SZBtPIq0HOI7K4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7686
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/05/2021 16:52, David Sterba wrote:=0A=
> Add sysfs interface to limit io during scrub. We relied on the ionice=0A=
> interface to do that, eg. the idle class let the system usable while=0A=
> scrub was running. This has changed when mq-deadline got widespread and=
=0A=
> did not implement the scheduling classes. That was a CFQ thing that got=
=0A=
> deleted. We've got numerous complaints from users about degraded=0A=
> performance.=0A=
> =0A=
> Currently only BFQ supports that but it's not a common scheduler and we=
=0A=
> can't ask everybody to switch to it.=0A=
> =0A=
> Alternatively the cgroup io limiting can be used but that also a=0A=
> non-trivial setup (v2 required, the controller must be enabled on the=0A=
> system). This can still be used if desired.=0A=
> =0A=
> Other ideas that have been explored: piggy-back on ionice (that is set=0A=
> per-process and is accessible) and interpret the class and classdata as=
=0A=
> bandwidth limits, but this does not have enough flexibility as there are=
=0A=
> only 8 allowed and we'd have to map fixed limits to each value. Also=0A=
> adjusting the value would need to lookup the process that currently runs=
=0A=
> scrub on the given device, and the value is not sticky so would have to=
=0A=
> be adjusted each time scrub runs.=0A=
> =0A=
> Running out of options, sysfs does not look that bad:=0A=
> =0A=
> - it's accessible from scripts, or udev rules=0A=
> - the name is similar to what MD-RAID has=0A=
>   (/proc/sys/dev/raid/speed_limit_max or /sys/block/mdX/md/sync_speed_max=
)=0A=
> - the value is sticky at least for filesystem mount time=0A=
> - adjusting the value has immediate effect=0A=
> - sysfs is available in constrained environments (eg. system rescue)=0A=
> - the limit also applies to device replace=0A=
> =0A=
> Sysfs:=0A=
> =0A=
> - raw value is in bytes=0A=
> - values written to the file accept suffixes like K, M=0A=
> - file is in the per-device directory /sys/fs/btrfs/FSID/devinfo/DEVID/sc=
rub_speed_max=0A=
> - 0 means use default priority of IO=0A=
> =0A=
> The scheduler is a simple deadline one and the accuracy is up to nearest=
=0A=
> 128K.=0A=
> =0A=
> Signed-off-by: David Sterba <dsterba@suse.com>=0A=
=0A=
This looks very good :)=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
I wonder if this interface would make sense for limiting balance bandwidth =
as well?=0A=
