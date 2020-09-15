Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE66426A2E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 12:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIOKND (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 06:13:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2553 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgIOKNA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 06:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600164780; x=1631700780;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gLMarAs1gBPRWVpph7MSmz5VM4Itho2mZwhf+9BCDk0=;
  b=SE7E5hq7wmMSFKxppSzSxtiret3itE9ZyyuEiXV4/EsmqpjalF9E9ILJ
   8luLaSDwva4SIBE1xbEvkGj1IYBx10ilZzzPEFQWIT8rOb7Po9k0Z44pk
   z7jXmZTY5mXw4b639NogrJm0VsYbHw795yw4ME3sO0UWg+r4w2OpgrH/T
   EPXty1cUONxhANr9SCeDixwyTjtbcgXOQ5wkfr+o0vmfnKrcxlGEm7aiT
   5Ue2vAGrKfWBft97FP/UwiTke8L/nNXwI4hEQAw0XDcby6/g49Z4iOSe3
   3nFeFiw5lpzjnRdj9TuSwVYHKsPykwwlcMnx+oAZxg7T7HluyT9VNWoSW
   A==;
IronPort-SDR: mAoxlm6ajlhthMhN9Mq6VrO8w64V6iGj1d5lQFsATZEi7HtUN/eYD1+3ivajJLphANpLevCk/p
 PXt6jDFhE8ULzFQyvKIqfTOC+zO+iUQYxUtmS9woipXxghXGvMMQk9IoC8Vu2rgWaZw1pk3eG9
 dNzNwe4F5YSwVpm/EVOvfH+AFsvW96G2VDo5LUTFdiDxQZvOgN2JlB0wzzBIsRbAYPm5gKkfL/
 1nLqz/WcUVhosaitaKXi65VYacXDCkFPGLbDZfHcJ7o6ghl35FTP87C50qeDSvqoPmoJlEwhhI
 IDA=
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="257052385"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 18:12:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH8n43KuBB6voIk/N8II+u785aqrp5A0CLXTCUkNib+zxSwJBGuocafWyeqaLmuOsKhU9cftWhUzEmiX9RzI/a977mvbgOCKBzd5U6eMgFdHb/B6H3EfrVJdBAMa16V8t0O3xrZqQV4sQb8BfIVXAiIcGMjmqrU0VVMEJgmD+y6sg/1D8+7Xt5hiHZLZ2hAojnq/gnWdlpg+sYA+xYtE9+s1ZPG9LupuOpvwTG38NFuOC5keEJ15Fl5J9iytS6EvD5c2iaF+bvero2SKb3gYfLbZBamdbm3z9yGoLppyyUCJprrloJduxgy99K/9EJCW2VIiA3AY4pXnHLq46iZZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8Eepe26ywW+Ic82z2Yyl3lgyvhrvSCidLbCmtt/rfw=;
 b=EI2Nivpfe7CLM0gWG0tS6CCNjybBSRkrEmHntcSV/ijZo6rVd1cnqg5/XerNMb4SvllyVUbgfjFEJKmyocWkGG8ZGUMcO7f6A0IPvCf5IThPch7k1t7s7EsCEVb1Lk6zvryoAcIQdm5jBLLFB8TYhf7F5Ua7w0pyHzPkWutCHz6tGSsU8epM1LRReV1kyWuzA5S7X8fniSubREG68eR1vlURkmKlt5bYMz1b7UInVre2ff/q5OVBCXSrtJWZS/4bPg9agkL9XE73HKvD7T/JGnNtTQvB/mQJtqM3XYfo17STntj5By01hPXIArW1l5WQJXID69Ud0ICuR/5pV18qyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8Eepe26ywW+Ic82z2Yyl3lgyvhrvSCidLbCmtt/rfw=;
 b=T9XWzxNY4s9wojtk6QYfdAmXiWEMbdFZf5n4B9EUsDIUMzowmL5haV/7bu/vtxPgJn43j9nLJ8zssywjJb2LZdm3nJJe8lY68tz+10vazI0RIEzuByXmFGtsFIqqPAgBCADYChl4I8sihuk+FnGR/BhFSKRrXgUVvhsulMlaaxA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 10:12:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:12:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 07/19] btrfs: update num_extent_pages() to support
 subpage sized extent buffer
Thread-Topic: [PATCH v2 07/19] btrfs: update num_extent_pages() to support
 subpage sized extent buffer
Thread-Index: AQHWiyIdMcWiFckg70uvUuaCRMWL1g==
Date:   Tue, 15 Sep 2020 10:12:58 +0000
Message-ID: <SN4PR0401MB35984AB89E7D05CF1A464B209B200@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-8-wqu@suse.com>
 <DM5PR0401MB3591309523CD789D48387C8B9B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
 <56c0c885-fb75-36d3-00de-202ea53b1b0b@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a017c637-900c-42e1-24b7-08d8595febef
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-microsoft-antispam-prvs: <SN6PR04MB40457B0DAC1B877F95A9B8E29B200@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZY91fgL2LbB2ENdqnRoKED1xvJTA2xvXsCwVw4jzTxwvJEvkyaXeQut3rjEItGOGVehQVysYSWoB10LzaPb/Z6sDG5SFCFoTpYPk8bKXXHhsLq6NFxld3lWu/mzJrnYxxh03oJWPLffr2BnJ9phyaNmlbSONaoYM5tXX+ZxY1O9BtYNnfolt3E3Ek57rmOP4FIgry9l+AVSjMjzenxvjwoDQeh9KwHLGa6AMPRh/SnPVp1WHCxQFMYrRBC8uAHRcJKH3K8xn08VqeACf4PSLBS23qViupFDSmZ4j+p+9gBqjEfg1avTE/a569YLFLqwXIenqh4gOFS5utXhwNhoNVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(64756008)(8676002)(33656002)(55016002)(9686003)(316002)(2906002)(8936002)(71200400001)(6506007)(5660300002)(76116006)(66946007)(86362001)(91956017)(7696005)(186003)(66446008)(66556008)(66476007)(52536014)(478600001)(83380400001)(4744005)(110136005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4qQfMTLgIz43IP0p+5ebqYR56PnpIq8kfGMzrWcUymVEQACdo2ZNtXRG4LqJ4tHkyGv+89m0v2nqjp28M6qtS+CXugNRUe7Yt49uG8cLX0zDgi/+snBCSMhuXgYJg/h37ntOKpeURASb4aJDu3aLuGOhu/nPGuEpAkUmQyS4CsJGplc7e5BgxaOvCvo8vi6G7ez4PwBcER9Wt8gZ7KgphPsyfDJlorK3pSz+Qa7hOa3fb4NtWjoYXtrXnEa4JyKR/YuEPLs+qIUh37t2DdrMpqdPNiqPZqkq0amOjuguyQ1+CTDXUW1JeiCcOeyUDD0Oac6+DypQzQJ5jxRpBOJ05s7Ayx49t5xPHlbU4KUl8YVOuFiUsAU1Qw3kl03GoFZh7/NvS04k+yl4N1QnL5s2ij6Yv9EfFdPygmpEHf1ZdUAEvr0yd4hxJwYrt/10VwCSBs6k9n55w3wJKlWPJflgwIStR836hZTmLJsyoIEsrdR4NowizgXw2OSOcAlTiQQq6i8JjNj0vToPiCz1g+fR13D8GUKyFMprUoR2vNE5+vvgNCJhacTiF/3gRY8icXFaMzLziWks2soVBKx5KRz3hCou5s8kOuSpNwKTRb6x1X38dkIlXPfXa7b6SiOoVEoMjDT6TrZkJUi0Y3y52jJQEbNgjr02MtqrttSx6B7UiGL5CvzNk+95/IssnVnghhA5XFQuXHCogzyGD+MMwdG98A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a017c637-900c-42e1-24b7-08d8595febef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 10:12:58.6359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4McZK350DJ/v1MFB15keeh5wNTwvckF4sj/se4kifHgAJ07gZ9ruvzm1vNub6X+zp+Vkeva2Jf49r7KDHJKz/rybqhFzTNC4+KhOx6nooVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2020 12:07, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2020/9/15 =1B$B2<8a=1B(B4:42, Johannes Thumshirn wrote:=0A=
>> On 15/09/2020 07:36, Qu Wenruo wrote:=0A=
>>> +	 * For sectorsize < PAGE_SIZE case, we only want to support 64K=0A=
>>> +	 * PAGE_SIZE, and ensured all tree blocks won't cross page boundary.=
=0A=
>>> +	 * So in that case we always got 1 page.=0A=
>>=0A=
>> Just to clarify, does this mean we won't support 512B sector size with 4=
K pages?=0A=
>>=0A=
> At least that's why I have planned.=0A=
> =0A=
> I think the current minimal 4K sector size is pretty reasonable.=0A=
=0A=
OK thanks =0A=
