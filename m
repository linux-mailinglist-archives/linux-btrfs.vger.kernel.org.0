Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6734BF58
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 23:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhC1Vcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 17:32:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52598 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhC1VcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 17:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616967134; x=1648503134;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7WWxoU4xYMygaAM05kGVrNA7LL/H4W/lnd82OJnkmHE=;
  b=ou+bkdAR0BIyCa8K8AVoHZkaSg8kPIuWE7XaQWEqdflqERSfMjgzCNbN
   91D/g/M+DNejkSNOcvAye8kehW1EGhXWjN/rS8AC3VqlQ4yAz1emPIGXv
   CkfFyEl/XmQFS+FZEada69crYEOhP0Y3h7OJIRcN+VdKOTHZRIMG0Kv8T
   KxbXif3DXeenmF/x56TLmKxB3QH5topg9FaDn4XxZLJT05gTwu3aXaWv8
   frTW3zVmnlumZVXF33q1NryCcfBI+6m+Tmv59U00sO7z/5HsviLFyc6PI
   yDL6wpBRQDD5l++ryfrcvkFi9+wu+IcvY/AoKYeybo0bBMrQod+hZs4FC
   Q==;
IronPort-SDR: vRqyDNZ3vGQihhnbbW4E8caeFDzmDEmClakHMMRMkcoMFS1kgEugcNFncEaGSKv0JIfSOuNbxE
 7a9FKvr5GczOuouUtcLQmj5qywnoUfTfP8G9esg/I5c3LZAOymEtAOcb9hLdzrNkUVRvfdW4Xd
 o7oXTkwKbd9p6lUMsieIUYVLmdxRY3D4wAAmUsngcsqHCY8aqbL139sEmhKMc4w5uVxUkf8Doy
 kV9Xcd84OXjw8VGhW5NrFRpy37QHtAFAFKMZD45O6/hvg8P6/XUnLW9sXEmuQAqtl/jgxWFnPh
 cgY=
X-IronPort-AV: E=Sophos;i="5.81,285,1610380800"; 
   d="scan'208";a="164287814"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2021 05:31:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nogWDv+a6jH4RVoYtgYrOPjGjAMxBLuMckuL/et6vuzvf2APL4M36lefLiSWAyivT/FbChhLvsnptQgB4btfY2XgAK7mnomiV8IEmrr5MN71DKsuaXkP3H3nIKB7usrYc0cjB7lHyVEUb9YG6fkPmeXglJw0dXVTWy8CnrylQiJlTtrWY8TvcoaE8kKKSfZLx7y2qWp6a1iUe0RN5dMp5Ix1yytEFwnuQug0ERyGZB6V9Aph4iKl4YsOCNRYxswoYNeXc+uKqediZ5WqHsQVhCz060oKEtpps3vygolBLxb0qlM7K/DrF0t4y/EouqJbxPJnaJE4wcaA5hPcQHoP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E64wrpXb4RWMgsIH7psmvhW8V31P99yustK/Qqw0Eo=;
 b=CrJJOGInU1hzQVWkfMZNmWOKLYVJO5bkdzG6Y3pIcd1dvWyDpqWH4CnsddiA6qFYuNHYdbTy6ye8jdIRuPhRZO797zRE02gxtjNsQAOwLvIRpJwSX2UwS/1JFHMtTBYUM2n5QEu2ooTa1UzWdJ0eLo/cfRWG9ST997+PmZS7irDtMkFvRHbmCfne1txOPMTl2v3qUGbVacG/bimKh8UP4LGi/qX4d3V97XzktNcfQ20V1x4wKykcjYlRrf9aE7ENmVfjDFUbECKI0LgyDT/kJ7Epo1lSr7Qirq+IFEHVVhnS1Rci/BOU4/Nf/eGnF6LF6k20RmhXqa5msnTvmTHIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E64wrpXb4RWMgsIH7psmvhW8V31P99yustK/Qqw0Eo=;
 b=fJBOWeE707HYLcMOntVHC16rhIZaN/lO1kbQxKJPME69b94RjTl1PUw3NR8d+KURoauUFS9+9QMvgv5/qW7j6M4CTtGjWlKJZVJLalmxAD26CMevqJBGl7uwH3ajcIZ1B0ZHAyfzvh4VUQ7UX0Frh1JnAbAe7x2TsOK1Qz2FJ5Q=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6672.namprd04.prod.outlook.com (2603:10b6:208:1e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Sun, 28 Mar
 2021 21:31:14 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3977.033; Sun, 28 Mar 2021
 21:31:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Eryu Guan <guan@eryu.me>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v3] fstests: don't rely on /proc/partitions for device
 size
Thread-Topic: [PATCH v3] fstests: don't rely on /proc/partitions for device
 size
Thread-Index: AQHXIlWOiGR4R5Pko0yyPoTyiEOgvA==
Date:   Sun, 28 Mar 2021 21:31:14 +0000
Message-ID: <BL0PR04MB651430651E281B5A150DCAE6E77F9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210326153437.27840-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8539:9440:76cc:73ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e800b59-21d7-4758-52f3-08d8f230d0a3
x-ms-traffictypediagnostic: MN2PR04MB6672:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB667201256E698A093496FE75E77F9@MN2PR04MB6672.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bg0Ke+ST0O+lhcl8ffVtscljpSPOWqp4aUIPHDDwNt1jWZFgMJ8zTTtNfcVZVpwaWzNEAj9jLLnlwTk7NnT7Bpxa+/up7fpijXyMSsONME636L3YvnbaTxYdUlNOmo0oO5AXIeI8dw9qs+VRX3+rimbM9IiXq3xubfIWWSFRmdeZvX2UgEl9ENJiQqA8CjvF/zSAjOEU0nj8td6bTJp4Xl/X588QiV25wzy27d1HyQ+REjNcBcgipiexiQk0HVJQxaM5zcMY1aG4kzzt/9ZHUznQPJMWt7AW6XA4xq6A9tUU+KEUGoP6Ji+PuuuHwDVzF9WlO8YAOf4mMzW8f/OMrJAFsOhmTEsda8t7uckCRY+pJdZctbK1DSS31eaa0L4nrBZDnqNneUcIna77a/+YJVsFyxee3xwhGy0S6KYtVuAe/CsqMjV1AMrlJ7GQZTOJc7tsWnPkZyqECx9xc966wSdLsXSs+vZGyXmzBmpo9Nyc3ASfQFN5JeDVX7y5WittDmGds8BZQjtUWGNX8eyCXKeoT6UPD3tiMdHPjPLZAc79YeDv1oQAq+4WlRaSapdsnFYlVqNz9LZU/Lk50abByDCBfBXl21LIocAAsSmG5fbpDHt9kfz8iAJrt9h6AyoxKjrMCqL52ufvYew/mdTBnABNyuhTQWy/Gyd+V2ppvz0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(5660300002)(33656002)(71200400001)(9686003)(8936002)(54906003)(316002)(7696005)(83380400001)(86362001)(6506007)(53546011)(38100700001)(66556008)(66476007)(64756008)(66446008)(66946007)(91956017)(52536014)(76116006)(186003)(4326008)(2906002)(110136005)(8676002)(478600001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1jRg5NHEe3cMXOpq+MXyAcM7RWEV7nvXyRth2go+u15gUKeXxsHJvFffLEVH?=
 =?us-ascii?Q?aDrj9DM5cYA1PAMNBjXsx1bDvg0V2wanKIwOlGKCYP+Xo5a5QRDN1LdV4TdN?=
 =?us-ascii?Q?wG8AjaM4Mq5bdQ4pzzVFEHNuYg3pEYjYrxK/o8kyJnD27FZTzIvfaMslUF84?=
 =?us-ascii?Q?4BjMtXQCMOFqTSfyp0+EVzdxvvvT5f+OhA+BEJPbcHx1QFYIwSPIZ3zRwR0O?=
 =?us-ascii?Q?7Zo+wEhN5SWPdXuwW/O7Asf3/Ggu/F2FWNeeiUUqy/tSy7PGdQ4wLLqdrgfZ?=
 =?us-ascii?Q?0VckByE9m5PC6MtEe7tE/sjHjRTVNR7HgtPR/QXQ/IIY94EvfaUP01s1Nt8C?=
 =?us-ascii?Q?l5GgcWLShN0Me49aA5kgIrFT/1vKS9CUklXIxGiOtOrZd+6gSKVzy/OYBUDe?=
 =?us-ascii?Q?CI1e7rJjj+Mz7w809NE8nPwCjpQc0AZXOMm7vIDznmDuQ5BUvByMRwq6+J/V?=
 =?us-ascii?Q?3djAcH3wngXOSVUyqQr+EKGhM9iOhlr9JjZXB7crE3nfrNomrc4DJctjyN6Z?=
 =?us-ascii?Q?QyK1ni6I0pzPdYssiSVfSMuNA7TaQY/DjZ3IjECMz/X5lzbTNuURpaesasPF?=
 =?us-ascii?Q?8kQLiZl+169QtcuYGBMkmrZ8EZj61oINX2+v0AyjlE2bW2Q6WugSwHrDwxR+?=
 =?us-ascii?Q?6C6BBbfa/eUVxZoi4HZjMZYmz1MF9fSoGNkULfwoL4kdobLuSjGkJS/AHJdo?=
 =?us-ascii?Q?bYfF/jwuxygOg4Oz/g/E43RBXNrWv0Td/mdCaKQVlRNiC3xoSNNROVjP+ybI?=
 =?us-ascii?Q?Gk2uJlPesXzRclNg2iucRgyqcl4PuFdftMZwQmJJzGMjIhhUFvAAyNyBTphl?=
 =?us-ascii?Q?C6OZ/er5otYX47P/CxkX1W8WUZ9fpZ66WyQXdxlSt3EC29U5OFccaX5BYFkx?=
 =?us-ascii?Q?Xk9CEg+Q/vHXfk1rrb3CTEi6j0SVt3ycj8SUFa5L78ooOAJyzYoEKYZC7mP6?=
 =?us-ascii?Q?wQkcblwamCnlk+ciC8Vzvlh99bpkX2FFQkDMhES6fVdnQNpiO0HrTg8c12rP?=
 =?us-ascii?Q?k7h51irjvvvquB8mAhJLQmuu7qGL6DzUnS7PCpKJdYIsSK1/x+4cgFghqcZL?=
 =?us-ascii?Q?N4/5I8DMOKCJBnwxvXtLaZK69+MaYTfdzrq/ahcNIv1ENzeoFUeZBh3LPnaZ?=
 =?us-ascii?Q?9XwF5IH1V1C/Oq2svohpE0aCtVkZwJ744KEKCWfP3ukGb8AHv0rQpq6ARmI5?=
 =?us-ascii?Q?ZKCWrLK1HwCfixxRCS65mDTUCdMr0StOAiKpNiUwvo+O1fBly3BflTT8/oLN?=
 =?us-ascii?Q?mqvpILruJeBMCY8qFb81EJVVE7JJ+RqTAzqJPF8A+33YccD7weFixWtKShsC?=
 =?us-ascii?Q?9IQIl6Yyn+MpP9ePifZtZilLdejyCiVSXx2Xw2oFX8Dmg2aI9WCBVZgAHt/4?=
 =?us-ascii?Q?VbAIZk5n8fkQGcFq9rO+o2ndaDEAZCoS9zOtgGVT3GYZ7f/3ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e800b59-21d7-4758-52f3-08d8f230d0a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2021 21:31:14.3969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuYn/48LOZeRDuWxJlLelg+D1uiuT5/9o1TQJVHu9jkbH+ybd40N//asVzvNmYD+NH/4+/zJ6EEAOurn4ZbGuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6672
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/03/27 0:34, Johannes Thumshirn wrote:=0A=
> Non-partitionable devices, like zoned block devices, aren't showing up in=
 in=0A=
> /proc/partitions and therefore we cannot rely on it to get a device's siz=
e.=0A=
> =0A=
> Use blockdev --getsz to get the block device size.=0A=
> =0A=
> Cc: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> ---=0A=
> Changes to v2:=0A=
> - Don't forget the sectors to kb conversion (Damien)=0A=
> =0A=
> Changes to v1:=0A=
> - Use blockdev --getsz instead of sysfs (Nikolay/Damien)=0A=
> ---=0A=
>  common/rc | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/common/rc b/common/rc=0A=
> index 1c814b9aabf1..2f295fa05484 100644=0A=
> --- a/common/rc=0A=
> +++ b/common/rc=0A=
> @@ -3778,7 +3778,7 @@ _get_available_space()=0A=
>  # return device size in kb=0A=
>  _get_device_size()=0A=
>  {=0A=
> -	grep -w `_short_dev $1` /proc/partitions | awk '{print $3}'=0A=
> +	echo $(($(blockdev --getsz $1) >> 1))=0A=
>  }=0A=
>  =0A=
>  # Make sure we actually have dmesg checking set up.=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
