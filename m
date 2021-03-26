Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264B534A2B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 08:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCZHtu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 03:49:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22998 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCZHts (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 03:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616744988; x=1648280988;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gZQLozvvB6ZtEcZWbbOnQzjFv+fOa4QPu79vvbpSSrU=;
  b=WGY9sEnakrMhuCHfQrbg6L0YwxjE5DVaQ7HLqdRJS2oYiy7RlES9CCbb
   9BnO/SzbkqR9kANBRwa5etJUP2GekxTw5evzlsl5MG070uKMc3gX2MInw
   SVCe8WkZThJt/rPw9pHxvCl20YySwhPwrY8iJ48lO6Z5raXpdKrLaBpTL
   ky9Qk/up5Z0LY+ppcUhRLdOYWLCTlrJVcc2LtMDbTSux2km76hK0g1KXt
   LE3By6GmGx5Cn+Jc2cSuwrszb3JRhprJlGpQAyiGTe5ElMWT0m/pBNsBa
   JUzkis+QIIe18o8rdN2AvCbDagRCcDPHLtqSu9hWJWUeJPA/QC75MXEmI
   g==;
IronPort-SDR: y8Qx08scW4HBHTOBYpaNdt+12DyIksvc3YFiJcMJYQGMkTUDZgEaKwaO+f/VdCR6LHtV6HVNz5
 WUPWoaf8rGVhoA6JWepN7kT/KwkKHZT2PHa/Q1X4xL08DZtIHAfXi821RPO58DBQYZQwjraune
 S1q+cg4baybkjXZ+HVVDl3/e5O1CCjGOf50VYkYn7tY/UyL2gHTEnULfYT3IYXHpp3d0wTZ7R9
 2pTaNb5KVTatqkqc5pCKlaaDZt5aPix8CB7tj5xVj5ZoUOc2Bi/AExeREQ5N//IQFIulH9JYyC
 IJE=
X-IronPort-AV: E=Sophos;i="5.81,279,1610380800"; 
   d="scan'208";a="167547928"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2021 15:49:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2BGF6uOlZvBBQ9E7ma+211LT2A1lW7zCQlgPUhTgQiVIh/Nz/Y0nOqB3tbZ2QzLcNv6AlodHDIB6UJH4hBhwdy0eFKc2jVkC/BGttwe43KMz+IHZVlM4mtTNo5/+4ilSIqEc3qJKJSaYM2/uQn/KJUs3NjFFUwC7a9kB6z628daRUc04m1A4oE7Dr3UL6Kf8ofOF0zB4uCozQeNsEBQi2pb9KTvunmTVVfC/ZTt8bV/ggiyDajNNM6NSgjaihjrYyo9QC+qOjgr3r/s4emASOiiH/qpYqMx/DKRrsYwJAchVJI+S9F4oWux9HJXepAg0Jax2ng7NCBJxnBKad/TFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLDW9lTxPYLkCqDJkP2Ys85wlQgsHvWlRAx6ZNNBeCg=;
 b=QxYY1H+NMU119krXcCSa5XH2i06ppcABXwLe9uCHYa2j4czdB5LIVZ2HoN1wkcLp/WY8+THtUXykaDB1kJ3HWuOcezIbTWJHZqGMqIj2yz69sTKNKx2aWOQ3h0fiAFfioYUkDHFuGGPi3G17QFd742ADFHIPxfj7rG1TYXk/MyZDNWJ7BB1YNyF1gwkPiykgvp7HqMX9uYBNmHcrcSeq/iAwk3xi7/c6qJtkyc+AppWo+uTR3ZILr1PwEWlHTDAmtdNvjz5b3Z3fPf/f3IpxMJOWxby6pCrdUAOkBSLsoB+GFajhKL0IB5809UM9pHJZzC+o2359isFq+jZeSxQ56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLDW9lTxPYLkCqDJkP2Ys85wlQgsHvWlRAx6ZNNBeCg=;
 b=lei0omFnKP6KknZzssAgxxdJxt7mRlGti3q0ZIEkdEyrCzmy1ZzFkou7bvSH5OuVZqgifOSavsD/cbXJNB035rBFP78nVbihqR+BdEuBpkvAP14WFAzzywO1sIkDuTMTVS1Zu89PH/hB1f3tOxfKruuj5HJAfr4QiGNA0nIBOJk=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SN6PR04MB4862.namprd04.prod.outlook.com (2603:10b6:805:90::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 07:49:46 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630%6]) with mapi id 15.20.3955.027; Fri, 26 Mar 2021
 07:49:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, Eryu Guan <guan@eryu.me>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2] fstests: don't relay on /proc/partitions for device
 size
Thread-Topic: [PATCH v2] fstests: don't relay on /proc/partitions for device
 size
Thread-Index: AQHXIhMX2Ho0O08Zh0mhKzwEa6WkCg==
Date:   Fri, 26 Mar 2021 07:49:46 +0000
Message-ID: <SA0PR04MB74184F99AD645228FA26B85B9B619@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <20210326073846.14520-1-johannes.thumshirn@wdc.com>
 <CH2PR04MB6522F59F0B14B2E7A2410F13E7619@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:145b:e21f:c2d8:5e40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1519ab1f-b3ba-4584-92cd-08d8f02bb9db
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4862F1C99FFDE69D2C318BE99B619@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A+SL8c0xbNXcZiG5jZ5ktBPbtoHjoQUjRxTU+lymA78o8U4hwX8BAQGe+4MBtjTQnh5pQoaY1cON74wn9T/6QQaxbr8Xu3ZoMas8bIXVueAOP+9Q5oiZY+E/IBxeryv+PB//PsB7tEI+li7vnzaUk6u2mgcPi3xUJGaGFcqguAC604ACisIR/nw8hA+fjfHLDsycsR06xIPseRSefoWGzBVYKquRNdNS++mLpYhPoa6pAqqwizLGKqE/3SYorWJw1/dBqVYPe/sQkbpaunPDbDT9/EYowqsSxg3FCz8nrDYtTgEwfMWGCIGmKRzeQk+SHcNOqe6mPzc0KxkJQtbjJsdHozqbuEaJWv3JdsDnX2T0jz2qgsEChry1kv1Yvfj2TNLIVyWQvvpMzRHTZviEs+G8NaFocYSxVkr/uUQHDZi9yl26nJ6hXH+oj7X2G/bqIv3mqdqvPX0eupNjC2LHeweWC9P8K8+Cd8e68qT41/kCuTFiY+ER1EeFJ084PpeqJcZr1LL17cf7HZJCBaJeXbwBWuN9lCjsdWX2KDGYfz9qCD4CEg74fnKo++BC4dM71OfIDj1UYin9glyUKWNKgoeeg6FxujBftIwSo0yU+M8WHUadWllvCZ6k6EozilgjO5pi+P8BFl4rJVe2XQEJ2jnjg3mUPijXAsLMxfg93GE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(66476007)(91956017)(66556008)(52536014)(2906002)(64756008)(53546011)(86362001)(76116006)(54906003)(6506007)(4744005)(110136005)(66946007)(9686003)(66446008)(316002)(4326008)(478600001)(33656002)(186003)(55016002)(5660300002)(7696005)(71200400001)(83380400001)(8676002)(8936002)(38100700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?u7L2ngsK2b/7wD44s9a0OwZHujfbTtlDI8ww1lThWHeF1qnRJfheI543gVvE?=
 =?us-ascii?Q?hUNZ7jEVIppwolbng0YhD1DqtU5dsD0RPjLlV/FJcjD7WYdJwvusgiD8X+e+?=
 =?us-ascii?Q?ZI5fBVPQeTrIyhUVUZproDzRoHunqeltqxyKVrvq+RjSBnpB2eXCi0qtKE7A?=
 =?us-ascii?Q?4Lz6sGPb+IKdSUk1sfM8NAV0iFglbZqnhdBvJdwsAK1xyKtJ4wj7cCcilUKV?=
 =?us-ascii?Q?jhBxafLqS5SNuh4/Mb5hCswb6LP6WfAsOwjZ4n3ncArtSIfJRo5yp5dr5gaj?=
 =?us-ascii?Q?IrhCxKTyyJEA6IBWN1ZqWS4QdIK5suypHEpimVa45vS45V/KwDwXxYY6Truk?=
 =?us-ascii?Q?8631LxrWJ6t+kJsqS1l1HjShb96Vcsqm+F4DvcM+64J0Zr7XPmM1ecfjvfaE?=
 =?us-ascii?Q?AOVgrk2NuPPUBJt9bCNmUWuQzXB9b/W0/VM1K3m0GLPqCWQLTX//wZ/RYT1r?=
 =?us-ascii?Q?qnzHB/A5V2GIiE5DRQW8CVfi2dsNhDTmDXuSYAzk44nE8f7Lq5646kTby2Kn?=
 =?us-ascii?Q?6Jt4cqSRmi+Zr0z/IgL6vUWS+epQu+7ZY2WE/Bpo/TF3uwiWp2FLhIqENhg5?=
 =?us-ascii?Q?Q7Dl1OvOCr94xHbc5m9PH/9imQtoBxpq0uZ1ul1mUY+8V4GX1bU4VKC8MVz2?=
 =?us-ascii?Q?+wm35N1Ir026Isw0wUmQF0RYjY5mFV953Vexhcwc1xB4R+n2isde6DUnogel?=
 =?us-ascii?Q?GXMpt8XwzF2e3uoinER7LTyeUG7KBOh5lTHYr8ox2yh3N2R5y173xB+6BX7D?=
 =?us-ascii?Q?ejb27Blq3AGgBw08gzYhhBN0e4PqDJlQJ82XQ8M/zs+yZIDJDboUcsRcJ4K2?=
 =?us-ascii?Q?jFQvUfIOMPwtr0z/fhgAP07D+e9+7hFqoDUh0ucA/ivqt5kMUcZu+Lo2n+mL?=
 =?us-ascii?Q?YfguDc/hGk5+hsEwIKiq9GRBSjHtnER+40XtkpU2N/JE7xJC0JQoa8e5yiiP?=
 =?us-ascii?Q?6zX5hGGRMvtlhg52Un1jxRrs73u2XK/GqZc03SUHhUeQBHC1KkpJ9gRxKGnZ?=
 =?us-ascii?Q?4vjyh/wLkuRuSq0QsFb3bxSyHUMa9ybwei0kxZLtRLV2zSEDABmAqm15TB7A?=
 =?us-ascii?Q?9VTFmiYJu9gR3uALXK/h/BASW76qOhfTNdBZxaclf1fUNqweevF2Vx9hgdRv?=
 =?us-ascii?Q?67MUzJwbP829a4VP53Nv2hg5fJ+/OpupOdq7SDQyf8nCOws3rVkWa2IceyQ9?=
 =?us-ascii?Q?h5LfzdunlBGhgzJuZYnRR6ht01eS1tUXPOtbmAWR453R4lNQyZvkWUVjH+N6?=
 =?us-ascii?Q?606E1lxadu74ZBZB2Em0SM733mZnPnlPd+6cHE05m6a2zsQd6fEYs5SPdrVz?=
 =?us-ascii?Q?uFtOEtHBiQFif3khjiVHDm+qCtnqEfmm3/lXmdU2IbN27DeS3RfA7k72N4yX?=
 =?us-ascii?Q?ZXL3o7azMzNohhRtmfhw35NzwyBm1+9AfYto1zfU7iH+beFlvw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1519ab1f-b3ba-4584-92cd-08d8f02bb9db
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 07:49:46.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qeq1cZR56K+phyzpQcdc+FaHH9mmKQ8n7gEJXOAsMWMrDUHiIpuK4nOl/XjNB1nVThmAAMfpCKqOs7kZNU8l4DI85SpfhaU8ttnMgRA4+Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/03/2021 08:46, Damien Le Moal wrote:=0A=
> On 2021/03/26 16:39, Johannes Thumshirn wrote:=0A=
>> Non-partitionable devices, like zoned block devices, aren't showing up i=
n in=0A=
>> /proc/partitions and therefore we cannot relay on it to get a device's=
=0A=
>> size.=0A=
>>=0A=
>> Use blockdev --getsz to get the block device size.=0A=
>>=0A=
>> Cc: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
>> ---=0A=
>> Changes to v1:=0A=
>> - Use blockdev --getsz instead of sysfs (Nikolay/Damien)=0A=
>> ---=0A=
>>  common/rc | 2 +-=0A=
>>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/common/rc b/common/rc=0A=
>> index 1c814b9aabf1..40a9bfac31da 100644=0A=
>> --- a/common/rc=0A=
>> +++ b/common/rc=0A=
>> @@ -3778,7 +3778,7 @@ _get_available_space()=0A=
>>  # return device size in kb=0A=
>>  _get_device_size()=0A=
>>  {=0A=
>> -	grep -w `_short_dev $1` /proc/partitions | awk '{print $3}'=0A=
>> +	blockdev --getsz $1=0A=
> =0A=
> That is 512B sectors unit... This should be KB, no ?=0A=
>=0A=
=0A=
Right...=0A=
=0A=
Should be 'echo $(($(blockdev --getsz $1) >> 1))'=0A=
