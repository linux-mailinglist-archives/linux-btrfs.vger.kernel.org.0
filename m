Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6BC36536B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 09:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhDTHm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 03:42:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38458 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhDTHm0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 03:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618904515; x=1650440515;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xzdcmgXrZl4+drPNwyUuSsVCqNfio47QyNi+M/B3AqQ=;
  b=mQQ8K7ykZYeN1ZJgEqgCftyXN0Nrj8hiN6cmtyB/ROq5vkxNTaGWxZCv
   yqu8Zzv8NKUvKVfFiCwR2LvbJAYaS2jbUOqFEZX5hir+ud54PVaIoBqQo
   GRZGBIH2Qy0kyWJc9ThIAk4QD2SzcK/eV45pDQqz7F6RV+x0qC1SzgZYA
   vydBarQp5K6uqrSuzEQE+WaxfggJeWv7e8uEO1lXkX3/k/Bqv4+Z03BcV
   9kgMFdD3DwfOpdCspIrOqvJvyPSDHfBaa8Rmozr6AzW6e2otRaIXzH0NX
   aFGwGPYqj9RCGWEmVZEEH+3MR+StypyZMxXKw+rjtnHgV9B+Jbue7G31a
   w==;
IronPort-SDR: h+XeXmtEGwyvkfKAvG1qUtmivqUNx+mATW7IIrDB9gc8wLk+pRbyfR9i/L0uRjT7tbcCSLwIoa
 W+ME8l7vONw9w8aFCcVoMXLf+eKVR3/ZX4yzv2hRn+BHND+4N8yth7VbBx7Ud9D6ZN0TfaDvCL
 7T6/pYBKkp//bct1LrQnhI9pPtLjOMmX5GOhxd0FdI7w9Q/6CssNE0UFm8SY8yC1xUkLpwSM0y
 L8PKlS4sMChA6ctmqkrLPYvyyrOqGRIUBx2/DTeuYPBxG+EPZyY3EK58LzsdZ475WrRqY9Asvr
 C2M=
X-IronPort-AV: E=Sophos;i="5.82,236,1613404800"; 
   d="scan'208";a="170057201"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 15:41:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IB7zf1ur1KGnbsZaSkZhnMEdwA2NmCKVEzHRvo3IPVUlgVxNbYFfTnGG258Vi3unyljerRkxAUVpcRAF8c+ZdDkjYxThbWqTdCSIhaIw8w1lkfS9lfnMQA2BL0bRRjOhMtWoBIasVbPF+GmQ6F0tLLkfqph+I3bYu1Qbyz7+ApkGWrhESMhNnMQZwYD60q1EiWI/GVX268oCmMGeVYIhCozfX7JibNALcJaxELOIFfz9mm0xaT1goBeGjo39ABDGYwE/HRzTs/m1UQr0zjDxeGBJBfO8qplo6Zjq8wjHCdo4F7mM7EQcu9Uv0drouPYBONWI9MkaomfNxXZMNQsWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJhqFNMe9uRjkrpTeb+2AGfxwITokdT7ArtuHwVMHvk=;
 b=IGf303eYg6NrKay3IojdRFy5te6M1LUaprnz9PzEFtGk+GWv0Mp4WqcWONpuaKpUUpsNvCJNBBLwzwq4FLQ6SPZQyl/5IJk8jwanN04vqOdLarlt1E3XeqVLO/qI3GfVO55TkOGlM0MeS01NnHZkeCWA0x1nswcA+gWQQ1XkNXgvxhcuFdDVQiSO6+WjEKL9Z/iNelJtFVWAv/Vmn6S5H1Xf+tpSD8yjJ9/l7kRpJ3vUFCtiHUz7hSQchAjauc3GmlUnmGAqPdWonQ9RCeHUaTQ3RK9VjhcXSrYE8l4+berj+699O0l0p/d0G5hVAWZm5jL8zmVUeIgXy+jnBDqEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJhqFNMe9uRjkrpTeb+2AGfxwITokdT7ArtuHwVMHvk=;
 b=gxKDsQUvZvgO3IIbgRJpBkHaSG5HjwWBFqsEgb6iwcgyFELS5Uil4H2C6C9Ow0HYOVUk799Fpk3/9ZtgaJFbg/TRJPikwf7M/ixJU/WWT6JP/JnG1FtApVKKrfxwei4XB0Ba7dooYcUBpZWZsYozatkY36+9ZYdx5VW3xVrT1H8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7190.namprd04.prod.outlook.com (2603:10b6:510:1f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 07:41:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 07:41:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v5 3/3] btrfs: zoned: automatically reclaim zones
Thread-Topic: [PATCH v5 3/3] btrfs: zoned: automatically reclaim zones
Thread-Index: AQHXNO9jw16khJCmGkevzXaXiVgdNA==
Date:   Tue, 20 Apr 2021 07:41:53 +0000
Message-ID: <PH0PR04MB7416A5F8C633033309A930009B489@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1618817864.git.johannes.thumshirn@wdc.com>
 <f4548d6db76cb1168266d1a216563441308b615b.1618817864.git.johannes.thumshirn@wdc.com>
 <20210419172634.GR7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:8801:8d26:331c:72e:ec33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7942d56-ade1-4167-2a66-08d903cfc41f
x-ms-traffictypediagnostic: PH0PR04MB7190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB719058A6F4262096FA57142B9B489@PH0PR04MB7190.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PopH4fcajGKtlorN9B3zj/qa8V/l0arwlnvflM451tjQOQVtJaPg0MJqPTlOlyazHS+tMsmaIROv6oeJsSwLQS8O7vYK2zhXNThjm872Ze8VbGzu34FHtfOloxwf53s42A50CMOoptk75La36Ei76KYaTeiIMRmAF6hckhxmJOyU3VWxUqA65j1aaiER5MclJeoMMA9X/jCyWjUQdnRT8nkedpjHF7/C2ABc1/wLmloeVwvJiXX01qIM+1J73xESLj0ln6q8AzkwTjPbnPJECfFeEBUpvEgF4nJk9pECiq6zgWHy0pu534G17gV/pH876r0n0M8Z3M+pdh0eDywxDG5aAoREBFtSkWNMQwgajylDRhsLg8UazmzagXWfOw0r1CE7VvHmvJdlHmzaIzBK0E4CLmWL7cQJbKXY6P7QoPxNgPxHGRDMBTkxrNWhzXZI3CGnw1Yo3aJP7BE29/o7HcTicjlDmvqXmneibgmVau4Y/2HffgmB9j0elKnVvimFHBLLmSn773UXNwGbd47y/6u3W8yfCucpsjzOktPb9TZNxpfyjD5lZxeAWHYYmLvi5qstwryIh5ixpdmlVruMQSqEwVITxA0CERJbhV7yaU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(52536014)(122000001)(5660300002)(71200400001)(33656002)(91956017)(55016002)(76116006)(66446008)(38100700002)(6506007)(86362001)(7696005)(66946007)(4326008)(83380400001)(64756008)(66476007)(8936002)(66556008)(9686003)(53546011)(478600001)(2906002)(316002)(4744005)(186003)(54906003)(6916009)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZcBydP4dJsRev5dhZNwwNcsziGpeAW0lx9jRdSIDQAJGqyrHv7xeQlerM3K4?=
 =?us-ascii?Q?kAE0z6bNdclG2MblbVCAo9dQobj8v4OnYGwr92ZE0YdV4/xZskDKsNv5Mxsr?=
 =?us-ascii?Q?+yyvEqXVggwDtDNQSpD2WdvYl2Zfxh6NqA4HFhDC3mzlTfuNfcSRY1iUzh91?=
 =?us-ascii?Q?KpihU+CkeBrXQEBRcZo+pGlPFEAMyoJUzSfNuYuj5oq9iyOLdW6PFcRJh5fz?=
 =?us-ascii?Q?cQ/rZ9nnFFrMivel+w2SjzYaeHmbed/IZ7qYyq4jMJDTh1Hr/442oPlbur+N?=
 =?us-ascii?Q?BrMhNdMF18iYQjaB2bc8zxF5uaOCXW+f5GRX/DHaW4iq1pNBtBgcaGDSszJB?=
 =?us-ascii?Q?P0TV6VYTRs5LWvYnnhk0n0Wk0W0c2LDMzhv9Q25nQuy1Xqwgm5kpPlA5ZPy5?=
 =?us-ascii?Q?LiHDxgccBgJG38W+wDrrGd9nuDqtBu73rVf/vKp6ZdnoA1OU9fQ1c3/QJG4c?=
 =?us-ascii?Q?xKbPU4MI+YrMff9yPmD4k+/M9yqtzQTazLiaySSy7/DhvG7z3Vfxl9ORP7Nc?=
 =?us-ascii?Q?ZOu0Q6pkFBB/Z5WSz+6tJkRsBUVNmPiN3MBS4bJFD/LuryV3PIPD0r4WrdKu?=
 =?us-ascii?Q?4k1FJsaTLqsWfMqm8urPq7Qw3tbigs8XkAfNcqDWfzOQXg2rm2tNYXb3xyQp?=
 =?us-ascii?Q?IYweq1QJxNAkMfN6egBLcSMXuxhPK3+5rqF0IZntOQBACWkZzfXXptav7RoJ?=
 =?us-ascii?Q?g1AAqsCWXVqLyLb+/pkKzielaCJOF9kZ3vDWFiKkEXNxIHlGf0Av9dH8BKBw?=
 =?us-ascii?Q?0jHh5o93IgzkTfcDoziEl9ivTaVAJCWoyEz9JYVSNHVK3O27iWJLp5iDPhvr?=
 =?us-ascii?Q?sdn3ChZ3Zzf4Lg/AVLbT2+35cD6Fv6VbGZfA4ZEjZgrMLER0KrFSBjO+WrYT?=
 =?us-ascii?Q?Elh/fLv8aMzupUCTEBLmEnP3ZleNRpde1p3Mu1/+Xzof7nKfhIddJbYmXTJy?=
 =?us-ascii?Q?f0DGNYf2b/XJAQwKImX7sZeuincFh5gkmgXFWSiap0m17CSaqgCcXG/OZt+E?=
 =?us-ascii?Q?RWxrEOSOkK77QxeOksfvmxuVidcNcQOnxSCK69xKhquChfSuqVLb8urzy5Ax?=
 =?us-ascii?Q?dE8uKCUq/HwAoQg35BY6WIQUljoyATZQ6MjBuP8nkqMKIaeRZY9AE+dXkLNH?=
 =?us-ascii?Q?t7a7vr6Z2gNeuXl++eg1BUlf7kk1s3WhrqsSWzI3ZtOmqq0v+KcJa93GoHoQ?=
 =?us-ascii?Q?emQ6q7obP4XPUxAo4+FgBdIw/RuagA13nUSanCB1qh4r7IOC3YwawoqG5iMs?=
 =?us-ascii?Q?DqOZmw9cbGItRVlbjhUzOaOCVjHZQZKOCwAKKC7s0UZG7FXRI94okAukyf7t?=
 =?us-ascii?Q?A47+oPP2layNAW8CKTd6vRkdFYxsc/AthJ662kbmjsDTW1wO7vEBaMiUmB4P?=
 =?us-ascii?Q?gmStdRKRo5297+G1Cb2vnUbDtG5X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7942d56-ade1-4167-2a66-08d903cfc41f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 07:41:53.1642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXRRpukvEh9PUDNwXGSF+ur+DXsb+4BwHmLQ5rIHbNWQUx2y/k43QWm2+V4rvfz46a2MXzRAeUyXEXBvDItpiNcEIeb0iL450hatBW7CgRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7190
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/04/2021 19:29, David Sterba wrote:=0A=
> On Mon, Apr 19, 2021 at 04:41:02PM +0900, Johannes Thumshirn wrote:=0A=
>> --- a/fs/btrfs/zoned.h=0A=
>> +++ b/fs/btrfs/zoned.h=0A=
>> @@ -9,6 +9,8 @@=0A=
>>  #include "disk-io.h"=0A=
>>  #include "block-group.h"=0A=
>>  =0A=
>> +#define DEFAULT_RECLAIM_THRESH 75=0A=
> =0A=
> This is not a .c local define so it needs a prefix and a comment what=0A=
> the value means so something like=0A=
> =0A=
> /*=0A=
>  * Block groups filled more than this value (percents) will be scheduled=
=0A=
>  * for background reclaim.=0A=
>  */=0A=
> #define BTRFS_DEFAULT_RECLAIM_THRESH		75=0A=
> =0A=
=0A=
Of cause, sorry, will do ASAP.=0A=
