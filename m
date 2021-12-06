Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8FE46A30A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbhLFRfr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 12:35:47 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60370 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbhLFRfq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 12:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638811937; x=1670347937;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BBrvEGIEenhv6WTTWLr8ZmL+EIq0xzQoNlSLXPuIV5I=;
  b=Ws7+uIhTbjchmsZCM0oTJJbCuKqMM8amCzk8FyEpbvEA3MiOr5PKofyK
   HRboVKh1F+LaXdcqLhVfcWoCiYkAevX1/UJnVcj/YUVwyTviIqCPCH3Ty
   43qxcNgfgPVm3l1xJGBrFkeYBOD4EH+PlW/J93QMhmc7mCuwmGB5PXdMx
   4ySKNvgXaDQnKw5VQ9IUHCevIuDb31dZc7nKNRSoaunO2WhM8T1oPXWRx
   bTIjZvtoiWLCilu0n3MlhPHcFGBNDPI2Rpo1xEdmDLdLaRGyN5uOzS1g6
   Ety/FgY3c9K4TWN0Ay1oXfVAxApFm3M8QzzGJUA3BM3dPySy2OYWUdF25
   A==;
X-IronPort-AV: E=Sophos;i="5.87,292,1631548800"; 
   d="scan'208";a="187577996"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 01:32:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g94CGUhUZvt1CX8Z/M4Rx1vt0z/a/IuysJhO2bIliLBDxzH1KpAmQpwSHmYsw+KSekWhETSadTvov5rQiLQ9DXEVuxUCOH1xxqgZOimqhVc3QDVtwCSEeSTecZevB87WWcXY9tSc5vTBnZ7oQSKQ0yEwO5uKJRzqD8aFH4v8AwqbtNNnoWoUAiVJeH5gWeSPAUXlRRzmv8BaDbX2b4AhxlpBHAv2IWfP6g9uFL1fZs1eCNABQF4oq5vJAIC21U3hOuB4TGTfHtf4VdYUuhG1fpgZoRFancRf/wo0qsgfA/qy+19Lc8PYdALkZ5AX87FNdax7qUJRt4S0qp5MURLz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR/86Ew/nNnLLcjqZDRmgkavXp/OoGN5eHjQfdaIhrc=;
 b=VS5bw5mi7P/KSXe4GXGo4E6U9/4t9YYXuYjfOUh16zHwdSzfT99mgEp5VIzcoXQwxJ+9r1g1p2orkm6htN9jWsNUyPCoyTrSlZkPxGzXzAwy4jqr5hyTkI07QFFCQiU2i19/UB0Zlc9hBs/ykTT3l2NTwS5K3TXqnrSsMIh7Brc9iOmtRHmxsubE21lxzmh+taBnU6t6cWF/ZhIYVHSNGXZpMILayMvwrqOas1pHRqj04CsVsQMPmVabjCCUAuO9tkwUkJmU7MJ/tT+GX0fwRiyZ6LLfUGf9VtN73gy/F2pTrOFHQxYnAe9OyWIqqf0qlnz7O7QLZSiA2kunmfJ3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR/86Ew/nNnLLcjqZDRmgkavXp/OoGN5eHjQfdaIhrc=;
 b=aiccStcJSvhIbNBByQWDBUk1E6wWE3LxFNB1kmugOk1AhOTz+s3KzeYFMMEXvx+4Hn8YFf2/eJelnp8VkqpmKy5DcSy5EsyLSczXYq4r8D3Yjwxe99WD42weoG3+gCKm1PjTp0mrL0xiozPKpm7lZjS97AQSwHeWPBb7mdqYSe8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7141.namprd04.prod.outlook.com (2603:10b6:510:17::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 17:32:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 17:32:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: free zone_cache when freeing zone_info
Thread-Topic: [PATCH] btrfs: zoned: free zone_cache when freeing zone_info
Thread-Index: AQHX6Dat8sU+uwSa10iPzU18qIn17g==
Date:   Mon, 6 Dec 2021 17:32:14 +0000
Message-ID: <PH0PR04MB741661B7C6B6CAFF7E70937A9B6D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <2dbe65bc10716401b0c663b1a14131becff484dd.1638529933.git.johannes.thumshirn@wdc.com>
 <20211206170047.GN28560@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d93fe7c1-a28a-4489-329b-08d9b8de5803
x-ms-traffictypediagnostic: PH0PR04MB7141:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7141D30B4C571B93163156AA9B6D9@PH0PR04MB7141.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:130;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5IkmTvgC8vg7DL7/9ncUgEZh2BIY3CGMH3F6BcqkIUEsn1db5na5eXPwPMQloZT0On7mujfIXKZgllK0Whbh/Bz5jGyHB0LDaJ8YamKqV0kfjUmQpeaOsZum7nIpqx08YF0o+J7QEgFEGv5/7XETsf/aEpoHXrhoMJw/J7czgj1HOOH+DyVZA614ei80wvSUf4gdwcn0PXmUjSKlDoFe8HtsemH0XBJrnmvKY7yJxl/sAMny4hoM9h23oFGT5p8+O5c48994omQzXR6WjBAkCzcSLgMd73oPo18JB92sRptNIV8xxRp2ATowM1vSmRDOIDTdO2vdjpbE4IecUjg1H9JJOU8CugF55nW//MBmH0io0HrFVnJ8Kjx4Q5vA7JhqJfp3uHZH0LI6ISRBk8VRQVSWC5RNKXetBKB2Br4tiob1XW66f+RDSFhZ+kdzVCnEzJzJbMbUhHduik4gesNw3MEigBYn41p9MAJVzRCi+Lt52czgakIiSD8EBEOtlqAARjoQSdmpaHHUescWWMyxYl0RQ15CAUfn1KLc+mEY0nElV4/PE1U/N9c2MQDz4AyaAho0C4SIh0WpG/o6if/87L53f3oXBuVQ4RGaRqu9RaxWbqF49/ObzEngShdNpfJPMH1pK0k/1imsnvCsIo/U/qsliJ7TRwo9tiknUq2bxB6HsxN4fPzRLJrtpmHIV47l/wcqNqLcn89Hn8XGbSnzltU2bP2vkUxMQpUxj0rgEE4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(86362001)(2906002)(53546011)(82960400001)(186003)(26005)(6506007)(66946007)(4326008)(508600001)(66556008)(38070700005)(66446008)(7696005)(66476007)(76116006)(38100700002)(64756008)(91956017)(8936002)(122000001)(33656002)(52536014)(9686003)(8676002)(316002)(54906003)(55016003)(6916009)(71200400001)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HDrzPwWtEyWFr1+c4eJdpcq3jKbaw206SbzQuP7Vbk8TIQnN3XaJJXmWEBKb?=
 =?us-ascii?Q?sq28xxw/YjBuOIP2YBlxo1GgVnIPWlCJ/DtJb/AtMwlSOt0zw2Jg5/pj4TTX?=
 =?us-ascii?Q?PkKPLFVK5idkpDQzuzEbUlVsK9aB3yxpj/HknVRlvyi22v/VNoJK7O7QoPt3?=
 =?us-ascii?Q?0B4wcRAcPufyAHEB2wNuB5G6P8maqn1qW41/5eKqfwg6wMCi3roLnJaMJrUq?=
 =?us-ascii?Q?LBlIn3tTLdL+oBXkutGRKfTfNyr5jOnO3y6F92E5WovM/TFHF9BaMlGiFofa?=
 =?us-ascii?Q?6+jPK+idWF8P4GEvSLu1uZ9d+BIdQQc9ddJCMuopKalsW+JsHwF5exs8ydvi?=
 =?us-ascii?Q?9C6moclFZwJRq/paAB7x+P0AgO8w5TPI9PleITZeRTZ3dXFC1ewxKAyADpSo?=
 =?us-ascii?Q?VIwzkiiH1KPSd2yAuZ5uXTiJLXyS2xWh9xxzq2jnEjsiJBsAFN8GBQygw7Gf?=
 =?us-ascii?Q?Z9QO3nS+tfo7QFBgc2yxfs+W6tCMMallxv8+BpOJG56SJk5/5bRN6vi/UkWd?=
 =?us-ascii?Q?LampdIZJ63Zy5t0HDv2H8ZLoFIdJSZN9XsR1Jx6GrFyDcdRTsx8YXUh+4QIv?=
 =?us-ascii?Q?Z+r0n7y74AKlzaCvOXjlaDEeif0MNk2dTyEzfLj/15X9xrTG7kkqkIUk7s+J?=
 =?us-ascii?Q?waa7nvKGNV/iAm5hm1EjlN2KZ/NpzH96YAjhQ8tX5W11mT9ipmAvmJeJ0UH6?=
 =?us-ascii?Q?9mtQqG5jdF+3li2J3dxcQ4mUG1BDTj/2koMLTFKLHDGOKlGopmjl1UyKc3ag?=
 =?us-ascii?Q?YByV6k9SIr5JlEaO4oFuzBjMRDeJUAnSAedBE3Aj3dW8yO+BHl7ZIDCTlyYb?=
 =?us-ascii?Q?SONmZHyZE9/gI/IaymIJQhvxZn4yMbjP12CfAnsamgqJaQkzPLbjMRwutGmI?=
 =?us-ascii?Q?3Ck7LP9XPgRo6FvReVKtLizFPs7xP7r2QYpoUgLtA82EYHeiIoHpkitJ6t6I?=
 =?us-ascii?Q?PsPZYQmLiiJBJKcQc9Ehaa8651vcdWeiFcCkEJUl1LVjIjG6xniKixRfDRZb?=
 =?us-ascii?Q?7xA2nO0EmHodaeWDkNreiuZBhvGdrrgowMXaTmRGAaIdogOLnLJrsCAyiCOi?=
 =?us-ascii?Q?apsWyHA143rA3pzRN2/53GvYPaBRBlUAFzoROfxdgN/WYhVUgdqNXKPRm6ut?=
 =?us-ascii?Q?0WGBLYOcVVKlC5NlKgLMFDpnV68Jf/FA8X/3oMI3CC3PcTuXvhbvSAwmi5WD?=
 =?us-ascii?Q?Zf6t+Qn5XjxHhwyi3SHhWPTqpGDK97k/zYi/PqP+BBihvAxOb7JVaUHIv1Gx?=
 =?us-ascii?Q?kEEZV9BHA7uFlr1FZl0aPpGmzeFss/RHzIUDMV8iP54p2R86JtVMOdl5vhVM?=
 =?us-ascii?Q?E7P7WMeJShnM1ainzpPE+n+SLsgTCGXsq0DhyYCBwwCYST+shpA5KubYzQzG?=
 =?us-ascii?Q?Nv7d6CTnkfy4ckOi41svK2qw+rp6JOLS9KFtJTYuSHJOA6T7jq7nTlihEL1w?=
 =?us-ascii?Q?i1II7M6UmCfc1iVPirzCNj+xkpicec0s8wXW88rlT4sJmgwcnYjtPRTOzyl0?=
 =?us-ascii?Q?4OzBcKeZ6vfFzi94W667VIZM+cR4BDGLDuJHslWPcxZH4JeY3MEFOJxvzQLw?=
 =?us-ascii?Q?rsH6vDHqxMc57AReXjyYdVbZaYgHCzpa0TKhR8D4izp1TkSKsXmIZHUrbSrD?=
 =?us-ascii?Q?gjYf+waPDYDPzytDRLdky7kSD5+wk2g1h8IddZA2yiXUpaMKrbovJlVEQ3Ii?=
 =?us-ascii?Q?OsAIiL9YMvpxg7PJR6nO4VdRzGY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93fe7c1-a28a-4489-329b-08d9b8de5803
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 17:32:14.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6kKUOlL+TOCk22a9j+L5PwKOtODjk5v2ZTWZO5RxgxJwkh8HxlFegNPzaIL4pqyXd56zbjYwd0iq9uAfdiZAGFgf9+2wORFQZIJqLFveTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7141
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/12/2021 18:01, David Sterba wrote:=0A=
> On Fri, Dec 03, 2021 at 03:12:27AM -0800, Johannes Thumshirn wrote:=0A=
>> Kmemleak was reporting the following memory leak on fstests btrfs/224 on=
 my=0A=
>> zoned test setup:=0A=
>>=0A=
>>  unreferenced object 0xffffc900001a9000 (size 4096):=0A=
>>    comm "mount", pid 1781, jiffies 4295339102 (age 5.740s)=0A=
>>    hex dump (first 32 bytes):=0A=
>>      00 00 00 00 00 00 00 00 00 00 08 00 00 00 00 00  ................=
=0A=
>>      00 00 08 00 00 00 00 00 01 00 00 00 00 00 00 00  ................=
=0A=
>>    backtrace:=0A=
>>      [<00000000b0ef6261>] __vmalloc_node_range+0x240/0x3d0=0A=
>>      [<00000000aa06ac88>] vzalloc+0x3c/0x50=0A=
>>      [<000000001824c35c>] btrfs_get_dev_zone_info+0x426/0x7e0 [btrfs]=0A=
>>      [<0000000004ba8d9d>] btrfs_get_dev_zone_info_all_devices+0x52/0x80 =
[btrfs]=0A=
>>      [<0000000054bc27eb>] open_ctree+0x1022/0x1709 [btrfs]=0A=
>>      [<0000000074fe7dc0>] btrfs_mount_root.cold+0x13/0xe5 [btrfs]=0A=
>>      [<00000000a54ca18b>] legacy_get_tree+0x22/0x40=0A=
>>      [<00000000ce480896>] vfs_get_tree+0x1b/0x80=0A=
>>      [<000000006423c6bd>] vfs_kern_mount.part.0+0x6c/0xa0=0A=
>>      [<000000003cf6fc28>] btrfs_mount+0x10d/0x380 [btrfs]=0A=
>>      [<00000000a54ca18b>] legacy_get_tree+0x22/0x40=0A=
>>      [<00000000ce480896>] vfs_get_tree+0x1b/0x80=0A=
>>      [<00000000995da674>] path_mount+0x6b6/0xa10=0A=
>>      [<00000000a5b4b6ec>] __x64_sys_mount+0xde/0x110=0A=
>>      [<00000000fe985c23>] do_syscall_64+0x43/0x90=0A=
>>      [<00000000c6071ff4>] entry_SYSCALL_64_after_hwframe+0x44/0xae=0A=
>>=0A=
>> The allocated object in question is the zone_cache.=0A=
>>=0A=
>> Free it when freeing a btrfs_device's zone_info.=0A=
>>=0A=
>> Cc: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  fs/btrfs/zoned.c | 1 +=0A=
>>  1 file changed, 1 insertion(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
>> index c917867a4261..fc9c6ae7bc00 100644=0A=
>> --- a/fs/btrfs/zoned.c=0A=
>> +++ b/fs/btrfs/zoned.c=0A=
>> @@ -612,6 +612,7 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device=
 *device)=0A=
>>  	bitmap_free(zone_info->active_zones);=0A=
>>  	bitmap_free(zone_info->seq_zones);=0A=
>>  	bitmap_free(zone_info->empty_zones);=0A=
>> +	vfree(zone_info->zone_cache);=0A=
>>  	kfree(zone_info);=0A=
>>  	device->zone_info =3D NULL;=0A=
> =0A=
> This is the exact sequence that's at the end of btrfs_get_dev_zone_info=
=0A=
> (that had the vfree call), please clean it up so there's only the helper=
=0A=
> called from btrfs_get_dev_zone_info.=0A=
> =0A=
> The zone_cache is also pending for some stable backport so please add=0A=
> the Fixes: tag. Thanks.=0A=
> =0A=
=0A=
Will do=0A=
