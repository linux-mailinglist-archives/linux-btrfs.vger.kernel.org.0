Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3924C42D323
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 08:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhJNHBx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 03:01:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13414 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhJNHBw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 03:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634194786; x=1665730786;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mYvdSacuUS+YVE5sXerMiPJX7eNr/ZtrJ8X0Y5GfbyQ=;
  b=hithM9GbydksGv2ewrKHDAUDUBxVQTUD1+zBEAp1Q+AXJrS0Swjx0o4g
   cmSFMnrsVwkUCz8AMZfz25j5beGaYwtIXIRAB2L2Ped757+YSAB5ESEpr
   rTZUusQFoTBXH7qNW+XW5VRJ6aE3onV+DAiRFXxNm5l1Ckg9h/MZHWJkL
   QsKx8utVuKTia3kAPGWHZ9Y7NzANgHNLFN1dtqjee6KmcubytGGlrCgwW
   nJ9khQ7UnqQReQbJfBqBCRNFvSJ9nbQT0lSxOv+08GtgtT7K9NapiGsGS
   UaxgYQvL2Nc2kShNlVxWPVu592E9/eiuPaqDMma8cMAamO/I1lN9sN4Zh
   w==;
X-IronPort-AV: E=Sophos;i="5.85,371,1624291200"; 
   d="scan'208";a="187588192"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2021 14:59:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3hH6d1EoF+YQ384DWudvIc+zbGjxGdpBLKkpg/DDbmH6trddKEg4MS+VS7gyaY+8ahQtTs3GF3FwbSzNGAAloIMNLpaXvrTbrjwUuI8620tRh3NPF9bRuNV1eunFB7yqjeJE7Klng8laEtlnD1me8eXyQxYmeAypqEbIs12NQfguo977yU7PVSNdXoaWidbueYF5aUwsVgeCkUK4oJpKkAigMueDeQpKF4JcorPaiRGcng+X2IJqvcpbkFtDOh7VvShmdlLT7P2ih32S/a7DcKYrzfxc4ru6ON3XriFIFOnbWvdvg51g5rbqg7VcauDeaSvsWBxqs61x30K4wCx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6Rm9S0sLWlvwhVcEE4VZRrVIPhm1oOtPl00LBUj/6A=;
 b=Mzm5P1kr629FWI7bCDI6B0i3q8RrBYOMkLYFT1mMscTM7O2Rq1RA2vsG/4GLIknFOX70BOJykYWQvjm8I/12PK5gHXoEmm/jGtRfG+Pq8DzzTlT/iI/lI42KD7OTIxVEg0FX2oLcqaf0GjMv5w4fT6yqv0Y7Znxyl2s9Cho5yeC/aCfCjZ3LjLZ6pc9i1tVvwVOls7c4CyFdvpPGW9OTh9kbi3OHUVmjX9tll81AE7ebqKhvkIYi8HO84IVaO7sJQPD552julkzQx5bKG6Hp47EyMGVpKF6Iritp7v5SH1saUdOsR/zIj/DIW/RP+QHBVFMz2BRIhxF3Gn0Za7TZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6Rm9S0sLWlvwhVcEE4VZRrVIPhm1oOtPl00LBUj/6A=;
 b=oMbq1nwDVh5KFozp85RryAlE+UK8z4+SHcM8WvWDczPtqxBtM5MUVQt2QQwBuLJQ7aMWWANkgOIsS3I0ZmVCz4pU9nyEqL1KN2QXt9/He5tFAEY7nsckuuJwenN+IIXM/tX7Bfd8MOa8K1NDmLw86t5C2hqOwYytb42yV9KoZ0c=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA0PR04MB7292.namprd04.prod.outlook.com (2603:10b6:806:da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 14 Oct
 2021 06:59:39 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::48ac:4b18:7edb:aff5]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::48ac:4b18:7edb:aff5%3]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 06:59:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>, David Sterba <dsterba@suse.cz>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: zoned: use greedy gc for auto reclaim
Thread-Topic: [PATCH v2] btrfs: zoned: use greedy gc for auto reclaim
Thread-Index: AQHXv2X6Gmlj9V7VfkG3+gxGWTRT/Q==
Date:   Thu, 14 Oct 2021 06:59:39 +0000
Message-ID: <SA0PR04MB74189EA29C0740E80E4F58309BB89@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <75b42490e41e7c7bf49c07c76fb93764a726c621.1634035992.git.johannes.thumshirn@wdc.com>
 <509765cb-9f8f-871c-1e6c-a867ab8870b2@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31c99229-1ae8-42c9-b5e9-08d98ee03110
x-ms-traffictypediagnostic: SA0PR04MB7292:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB72926BC9E08CE62AAD17B23F9BB89@SA0PR04MB7292.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xqfet9wIYpiDoJmVTzjSi3EXNc1mykS/WTWFHLlmXbTLtF5wVWTU3J376DP+tnNZJE41CKtTDNrzW6joePJz9sOfEIMiziauuV+KJOrK01KXYqJJgiUsDNNf2FqzvLogB4LBbR8Rh4kuH8d2tFU5sMxTYIOWVs/LMh4Av2nASxEQ+QTri4TIfloKiXEhnlc/oit0cUNP9s9EgU0MsIzOF04wU+SAC/YHC2IyQq2HjzMdByF4+VNi2xwo4bg8CPSYYAyWLooQOB7Rg4j9SIxBTdO6MTUd5M1oDy3W4QIlgbU61thH/VRdDQkYeyc5yiurmz7ZYZSdjxM9V/mUIl8BDPsLMFIKH1+zQxQNSORoMMq7m1fQb2aPnYnPxZcvVB4SbCutKHG35AXsUkLP7SZ3PyPs2ZELWo8Eyn9SsFDaEoDgToe41MeEupsSpOPk7X6q1e1PFD/7MlIERHHKBDaYqpwAiNxWsNikG0PhgSWdFFsRov41S6fQpyNiD76bdEeag6NddhYu39va7YnGzMGu+QQZryj9FVou/ADU+I/AplrMEQzbEi0i+yTQCORpcuHzf78gMK58UHJgAQ6LbSE+eC35ZAoWvIvbwSewTC/cIIK9YE4zK88P9E0jrEthScD6CoYycX5fE7EMT3yQGMeLrY1iKVtfhSn7KgfxYkNpptRAPNTqXvIUfQ/h1iVnl/Y2zQE0MIhZQYrfOLanzai/dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(76116006)(508600001)(186003)(66946007)(66556008)(64756008)(38100700002)(122000001)(33656002)(66476007)(66446008)(5660300002)(71200400001)(86362001)(83380400001)(38070700005)(316002)(4744005)(8676002)(53546011)(6506007)(55016002)(2906002)(4326008)(7696005)(9686003)(8936002)(54906003)(82960400001)(110136005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z3ZvNPmEhD1T/r6oYlxw+/Vp6h27OL9nHvihXeo5l22x9mcbSU+qJkhT6M8z?=
 =?us-ascii?Q?XTOve8aKRvwi0Vw4+zoQ5N4e0v4uhKRwQ8BlCTyL2VusiR6GUahgk0WjZtd3?=
 =?us-ascii?Q?QwgsTcExJh+4YsmmxcJguBxy5tSZyjX8zUN+3OVrYcN2a4IJLDdbEPkYbWri?=
 =?us-ascii?Q?g5iOyecQGopCtScnLqiDpokoyn+FXHUTCvqx6YUPfFzKcuJVXBZbJyGSJVxR?=
 =?us-ascii?Q?m3IzWS/xHDGNBLB5raLks25LidsS0qkgI4OUodHE8FLYDZbzcXoikZJb8H0G?=
 =?us-ascii?Q?kyv9jWPWtg3xkH6S40w02BWwEnyvzu2V6lKV31/32r47EywSafp6K2exWDpw?=
 =?us-ascii?Q?mljmHc0lp+OV5tr+scau3BCAIZQq1ecvI+jQlmZgU9Og7wMehs+3sdIgoV5b?=
 =?us-ascii?Q?1Rfya7zoaYYOqEXggzlMdJ6QOY8J23sKJ6ekhp7IQOoJkxW77cCIcHISV3x5?=
 =?us-ascii?Q?HObbwkucDLE4xdyn9l882/IgmsoysIxP1715sWogA9VjPqnHtQ09EMU6x36g?=
 =?us-ascii?Q?1Oo0xLXQ9WpL+XhL6q+c+Qd5Q7ehKRWAojcZyGDjhVFfpvALUxjrb7MOVUln?=
 =?us-ascii?Q?bs6L1Wqc0oTbWq7Ivj2aIvvrYDHnJdPTUk7/xmnkE7EGJwK356YRRP5ZnGl+?=
 =?us-ascii?Q?XWDYb0IxY+3Yxc9C6U2bDVDjPhwwTozAMSErdsNa2RhWALoZjWkhzi1Cfm1H?=
 =?us-ascii?Q?4BwxUieSlOS34S/FUKgHeQZ6a8eZ3n5eYJFNzoNT22d19W3M7pv33XGo1Yaw?=
 =?us-ascii?Q?MdaTIv3XRnp4Xa5Rk5HXde3sCDh/Yny6K+FggAG1295JHV7923JQG8boQwwz?=
 =?us-ascii?Q?dG0RFJAGKEsaM/K+FCft64wJFpqbHusB5GdEBJm24F9XamxVR2l4HqoTM81q?=
 =?us-ascii?Q?bv6P+wjhnuCxmJ0L9LoFtHnSR9oJBeelAxsOeR4Drb0d1oAzu4iRhbyvKEK2?=
 =?us-ascii?Q?9A7b7ePs34pZeoqE1CMNp4ZDshjT/3PNBsn26NUUxl7ZLMWp27O1yxhLXPhq?=
 =?us-ascii?Q?xNRYqBRBfX5P5ifnFwKrDN6dAKWWOOdoYFR7oAULb2USN2dqMoSGbevkbFjP?=
 =?us-ascii?Q?RdRDahBWe55ShEDu8gpQlVpnpGeW0AvxbDGk06/H3RiWZ+T/18ZF3skCPYLF?=
 =?us-ascii?Q?XmkaZZ8XF52gYmU1hvt+xSI/KxDkeDnclHUPcnv8ReU1mpPKLbr7L05Lcf6i?=
 =?us-ascii?Q?Cv7qGj5CnV7kLo/iRbvSDn6l3jvOqd4qtHokMzCeVm9wFnRHrYgvu98XzYaY?=
 =?us-ascii?Q?VjmOUhE9E59Cfxewn2X5+FPcKzyraZDwUXDjj9PN3OvsWYIz6g873SPSRGd0?=
 =?us-ascii?Q?B3XbOem+pxZxdgqsS6hgKtGQEoGCRI4K8b4hXSd2gwHM6FRDAmnrZJtALSZJ?=
 =?us-ascii?Q?CcL5G981qNhFs5HyUNrYOFR/RdVAh+6jkb/3yM9dokh3nUq/wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c99229-1ae8-42c9-b5e9-08d98ee03110
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 06:59:39.5746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUPVYt0B00gKtmQRG+hGKEoHExVbSZZpSwPXbPTQtyLb45QZ1F6mLYM7lPp50U2+tvXSSn6FlPQ614z3X3gXpEGTHrrIujSVFRez0cL/hIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7292
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/10/2021 16:18, Nikolay Borisov wrote:=0A=
>>  next:=0A=
>> -		spin_lock(&fs_info->unused_bgs_lock);=0A=
>>  		if (ret =3D=3D -EAGAIN && list_empty(&bg->bg_list))=0A=
>>  			list_add_tail(&bg->bg_list, &again_list);=0A=
> =0A=
> After this bg is unlinked from the loca list, can its bg_list be added=0A=
> for reclaim again. Is it safe to access bg_list without unused_bgs_lock=
=0A=
> being held? btrfs_mark_bg_to_reclaim for example will add a block group=
=0A=
> for reclaim under this lock?=0A=
> =0A=
=0A=
Correct me if I'm wrong, but I think this is OK, because i.e. =0A=
btrfs_mark_bg_to_reclaim() won't run on the bg again as it is switched to=
=0A=
ro. So there should be no concurrent accesses to bg->bg_list possible.=0A=
=0A=
Or do you mean, that I can remove the again_list and re-add bg->bg_list to=
=0A=
fs_info->reclaim_list directly? This would probably be possible and could=
=0A=
improve readability a bit, because we're not having to deal with three=0A=
different lists but only two.=0A=
=0A=
=0A=
Byte,=0A=
	Johannes=0A=
