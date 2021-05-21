Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DBE38C3E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 11:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhEUJzM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 05:55:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19714 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbhEUJyA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 05:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621590756; x=1653126756;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MySDjWOlR2UlilkdOTfVCyt0P85zY7xk3cYiEp8hZUs=;
  b=LPsCBFV6q8uyD76jGzB3Hp/yYxJDyJCQjyVrxYctg2JHqXN0wjCtAEd7
   i+aJhaKRpywDZzpfGqGYVMQN8JWEW6oBiCXsEuBjffAn+eHANdKizjqcm
   pi0EZ4MGw5be29pt2CQuobkArYfeyoxJwEA3EDyelrE4l0EfkHrx86eFR
   SndrLXK+hKD0ambeW7B3P+q0nFzNDWQ2oJ6jEM+i+sktpcxaRGDwjWL9R
   6xMyaac7v49juTzewf80Nyf30GjwEMTL1Sjh3k9XefX4fyu6J2/xagU97
   4updrQq+fL0HYpziypNgVnGwr9OpORfD6d9yn9enOIKZ4QvmdIXmc/5oM
   g==;
IronPort-SDR: ZtIr2G5g3V/OSrrk6PH8jVYGdptZf0Bp8IhpmKQmQPS1iyLs6PomsMh590ai3cCLiek8odFNyn
 FTXnNXoRJG9eAilUUrNCFXI8bZC36q1a9zWCZ+KI7fF7b5B9Rg2fLedYwINpdKzxPU6QYDbw51
 764sXxuL27lS75v1C19Gj7Pb/xfLrh+XXjri0plt4jWoVQOySS6OSUB0QUc3ArsrOvoRvbsIy9
 VzYChYY78rBMGjgHbLiuqTpQ69V+KmPhQ/CWt/5xy9cN5WJa8LMZc/6nylg7nZqvCvutQV3LuX
 xBE=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="173632543"
Received: from mail-mw2nam08lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 17:52:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/7slwiraTddA/UsW7MRSwbM2YGnQTWpbmHp2/lCamIz6JvYFurMLIpC9tIzc2TcHrLFOSjwHSnqb73ibb0sko+WgLpIF6UmSuAbpLF2b5rrrRBNhofGfwFJ+v+8NzzTo5CuY2QWp8KKIw8ufIN25Pf0e1WFacullFcOklRpKpUwryLnP6oghPqzIRS/InDkEmRPcKxt36NDUqhiypT9kHgTMMjzSm+g7jyz9wCfiXxFlxzWp9aT0ITrOxuhZT7uuyi0RtFhb6SapbaHUF/cCZDFMBhOnh5oDpeL54OjbLIVFQGLr10ouaR3bpB3L1m5gWcXVP6fZuVO6QHeTUc0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MySDjWOlR2UlilkdOTfVCyt0P85zY7xk3cYiEp8hZUs=;
 b=HANnDYHBb1GhjEEUOoUQZ09n7uGPmSl4LmNsMJpWkzHOzmE4krvjWXwOXUrmk5Yo9Ec2JUzJK+9xNedrq77uSQt7hvCb1qbJTDgXgXQNu/rKX4id5KQ6saLeJqlYpeiYIiLSiQm+J59OraApbyQgA5vo2WRSMO5RPqRgD7EcooEX+8d6hsX1AuzpHZZIreMVD5O3ZGXz/zYuLHjFgT8IGGzMxfhlPK/8/jx06bBE1DZ7hLXU1cbROPluXD6DgWdjJPoavs2Yb/5yFCBo1qUZOcE1aqXrBiJHbsOE1gz8/YxwgUQXrO8FDbKkuorBgjSMx23cM3E3FcMBOLSoUskPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MySDjWOlR2UlilkdOTfVCyt0P85zY7xk3cYiEp8hZUs=;
 b=WfFSJvt3olrEvMIIp025u65w3xJArpn1/wv4fjC5UEDWeacRaZ8Ak/4QNtCyhUXFXjb0+lk8noVe59peBpXtwFmJiVg/hNZAqoAkia2fx20GAwDFwVscYQLwaKys1uFOAHrWrpAzX4M6lAl2b+TebWCt6fJRTs9/6EmR4z/+znk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7509.namprd04.prod.outlook.com (2603:10b6:510:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 09:52:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 09:52:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Thread-Topic: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Thread-Index: AQHXTiFEXNaFexnNjU2Pxag8tm94KA==
Date:   Fri, 21 May 2021 09:52:31 +0000
Message-ID: <PH0PR04MB74166A812143B574C9A943F09B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
 <DM6PR04MB708120047EF5A0B1397C173BE7299@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee56168b-4f17-4a9f-1c95-08d91c3e2703
x-ms-traffictypediagnostic: PH0PR04MB7509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7509540FB34A662E90E0EC2C9B299@PH0PR04MB7509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dEOy7EvkDsqoYVlT5SyTaZxW62sAZ+CqohGDhPZNH+uwIJWLwvSoaSWE8sBSJO83x7vow5ljmxlfMVHdm2XyBH1hvDH4v2wDceFMFyM7aviXnNZQUcCtAHBQNQ+nwNbx8u2htbkAszjK6McFSDpwHlQLZdQySX/P7fhmErTPCOcxQLE7h9zZzrEGCaQwXitBzj5YK2YYdjfazK+jYkBkyqQXuU2PhOyNWK9gmDb7pDQjrpFkYrEBw1GpEiEcpfaUApd6tyBNP6VlsnLSQsigtuv9kR3mT1m7iBXDZZgfbYQtTP3s7BcsLW/VFIlmuANMaHNT8YbtPDQzdWZNkpxsPPLhIzuDi/C6eyVh4q6IQKnNwmpk56ONV40g4aRvY4bl6uF8Jb8slmNhfh58ZhV3lsz0YXlWJWsyzO2JITuz0MuKyHbfdHd+MJP2N0r6/hWB6oxiSkK1jmRAHtW+VAE1GZJTpBOYOjHpdjeuv26JY3bpOw5RuXskvk3HpxIe3dUdR+uaLsOpyF22yVU00FlZKKveaGQ8PlMKZSNCLgS3UMg01WYNfJ+KKTQ4uquPPgEvqvgqEV0vpsZmJFBnobaWtokl3zkK08GmkSiY2ekKzU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(2906002)(7696005)(6506007)(122000001)(38100700002)(4744005)(5660300002)(8676002)(33656002)(8936002)(478600001)(110136005)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(86362001)(316002)(4326008)(186003)(52536014)(9686003)(54906003)(55016002)(71200400001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1mllSbIL3o+abh35/ZBQRUTP2gcQTWb6F3EXfgYhXEW6X1mECXFkuAVJCoXy?=
 =?us-ascii?Q?YKW+m2pzf/San6Fqu6CWmzwA9MsEaYMLrE0FAlfkfeRZD2R/qyeKPEz8NoD0?=
 =?us-ascii?Q?JybpS093yEFf6ND2OueKckhN7wGGe5J5357J8N8w9uwu0Fpqu03MmAXIpF+Z?=
 =?us-ascii?Q?+Y/+TOvv0LDY/sy+GggjnV76w5qChLxbC3BIAgSfK8QIXt9S6+Vkky7aORI4?=
 =?us-ascii?Q?FLlFVOZ3tbD6veABduKhHvXoyETS3UfH8pTQWqO6O3K1DkyDIn0j88PiYbxv?=
 =?us-ascii?Q?cobsksWDp8Aap7H4UU4TQvqdnJlIKpsObUUuB/G+MhwNkkjpao3KuOf97PgU?=
 =?us-ascii?Q?CJeiLKCqp/fBuT8F20gffCYZYoRe4lSuZKRpr4r3uld9PuQxvZQVyCPh/NLe?=
 =?us-ascii?Q?0FposGpiTOMUM5em9g58iqCzLeaAFzgUnQ5rAcSb8fsR/tt2GttLpzsXsBrA?=
 =?us-ascii?Q?50ETXc+u2+2dPIscJeFpfBRZ3gwBj7+J9dqryXkRdhpA23JToWrrH8gXLx3I?=
 =?us-ascii?Q?xnTXDthFkdUzmiL3fQl1VS6F5I2JQwy2hF8kjPJeHzNwk/LYhrKgctknP+VD?=
 =?us-ascii?Q?LbzU0qYNJ+Cmkt7wO6Vmoku7mCLPyUUc2Ph9ueQ1iIETxLaY+Hw74V7GMiPG?=
 =?us-ascii?Q?Mpc9NA+IxCNdA7jmH/AJZKU4W34DkDVSS+U8EMY5laI0iz6GNQ+9jiJVXroJ?=
 =?us-ascii?Q?uQlD9g6Eg3zDKvRRYEBnT2gTcjPX4lROE/eAicATkB5UaNMrU4jSOA3YDklO?=
 =?us-ascii?Q?gWZfVH/SsexPvLe3eft8qktBVTj2CK5Bs3bgsoxzA/ONRvYJSAVe4LCbZkcQ?=
 =?us-ascii?Q?ckEt0c6+F5ybZ9SNeayoN14NosvDEZnpaPSyaCVgTBz7ALoVh604Vz90NMst?=
 =?us-ascii?Q?TBb2qLbRKHZWF9Hxxx8a00JTYo7qIiJ/JsXePc5f90uB8oKrCZchA/MmmSrk?=
 =?us-ascii?Q?2INKIaYizYkv0izK/KGFHGwqY6tu1OBuwooSZdk9KTU+Ll+GbuRPLTFoieHs?=
 =?us-ascii?Q?4e72di8W+SaEK6PQ+a6GVfpCg31ItIT+0bkkWFqIch3QP//vJ/2JbXFjNO+t?=
 =?us-ascii?Q?FaK02FT8T0zpo9RYC2Jg8HnyFFtThu7Dr7zv28G3MnD0XZKOHys/NLp/dzWA?=
 =?us-ascii?Q?RbRWtKt1DmhtrgXyKgvtj+b3isuAY2z49kopuW0Xbfjg9HchKmE6vYTSn68i?=
 =?us-ascii?Q?BDR7UAAHuiwOnP2ukwGf1pxOoQLXsDHnMXHfQDuyrMhrQpNfp5mAvug9tg3J?=
 =?us-ascii?Q?DHjuJuhheW1vQ5ARfxViY+4hp8AcoekmEy8aKiJTH918kPO15zcSFkXwwUBQ?=
 =?us-ascii?Q?Rc25zdEaZA0WmlgwdjSYzLgBenbubENtXHZR8aTAcIZDzYNI5iYUrBm/OX+Q?=
 =?us-ascii?Q?0Aml1kPgnRlLC6rSq7lU4syA3sM5pKzWdcaDrnoYnhN2BYBugw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee56168b-4f17-4a9f-1c95-08d91c3e2703
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 09:52:31.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Welpqe2UNyrpS2VPwEfEUUTLA3zEgQk0np19w2I8s1IRSHbQMcmwU5suKBlU8ZuE85O5UD221BmifpPC+ByTzqE3bzOI4eazJgxW4Rr+D4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7509
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/2021 11:46, Damien Le Moal wrote:=0A=
>> Note: This patch breaks fstests btrfs/079, as it increases the number of=
=0A=
>> on-disk extents from 80 to 83 per 10M write.=0A=
> Can this test case be fixed by calculating the number of extents that wil=
l be=0A=
> written using sysfs zone_append_max_bytes ? That would avoid hard-coding =
a value=0A=
> for the zoned case... =0A=
=0A=
Probably yes, but I'd like to hear from others how important they see the h=
ard coded=0A=
value.=0A=
