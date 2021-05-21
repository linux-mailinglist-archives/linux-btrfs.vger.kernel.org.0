Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E936038C563
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhEULHc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 07:07:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25311 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhEULHa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 07:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621595167; x=1653131167;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WCxbFB99Gr8OlcsAhBAR2SksdhKJnWTS0YNpwzpe7jM=;
  b=G2HK2nK3oESF01STQzdlGb0MUnc+D9V5AYxz0HxHLWmvj0UeU6NkEKok
   W1l4chNjVJgAJkkP6cnPUIhDySOUGKswswY3guBf/pOa6LYxWa3t6lyZm
   xbgGasf6MWFPwQeM1iV3EjFMIkm7PltZsbqwtHMG6SEIUwAI8RlMTZLPS
   j0Lc9EGeOA8hfh9E+NK/rzPKQIZuOx65uJg5JONXsp8B4NS7y1OlGaGQd
   sSUXDKfVj4nAH79kc+7IcDl+BdikbMyC76gYED97LRzM7f/2N5X9iZYYY
   SiA7Eda67DstaQZ3chAqb/BtRNaQpGLhdf8uvHpac1hvAYU7jPd1B6WTH
   A==;
IronPort-SDR: uD0U9QpIj4R+91ZBAFd5l56hjuVxYxBUsNjd5HLe16DsBXoaBET07Frn/9IsxN16oRbE5OJrjn
 VEMReR+MFHuGiQZYCKWvfWBq1Ni8LjVx/wqWPvJ5GaMxv1vhwFKs8u9xRShhtYh2oziuSsvyVe
 v/FihyBqGUHasOPRtAOmg5COtTlLh46+4Tl9bs5MyA5KWzpZOtunfqe5VqqDEcr13IwWr0Qu3r
 4V99Oe8O602G4E3eWHRCZ78mynwLfxNqeHt1viDV2ToqrFdN2chBhP64pmnVBITDg4lKBfJVYn
 G9Q=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="173637375"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 19:06:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+bmn+UlPzDLw890TnO/iO0Jf92LSo5ysaD0RmMFCOrgYaeibUa2q0UX6mmchhuta714iwZuuYhfE54oSTyftVETDtBW8k6rLjppN3BK9hCn+0tLErqXIYX4PSlpnV67imeCninRGTVt8kJsiyif5sGsOV0E2vVuG4bxPuQIe2qJxSpJkGNCEPe1ri0iYwIfgqnKr6vQChRsxCHpZMVL5vEpuDRtmoj0hn5rszg24WOYRCYa0DE2k6S3EaTVYlSo+XaNPN/Wd9VGHx79vRwa+FXg6oZmU41YoDbfFIEuV9/zVl4f5lZ88DPIO8VauMwIQCBkz8TPDMHDWelnYL68iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOCMab1yDbEABl+UmGriVlrwExYx9IJYtIl+4L6dPC0=;
 b=Fugl1NdGMzDpqXw/MI45dec3joTBT5Jeb/1KXTtQe6gff8qZcXZoGA9R83hdqBHSOsdFOkjUT+yYlU/4G9yfuj1SaQlnVpfP+9KZFuFloPCD54DpjzO8FcVoUG+M4tZb84oKdYDOhgmeRG9J4lq2GF0N1WCneWcWl7fsh2NWaYFoeApywnI+yGAa5Oo4gVLgl8mne1mdsmPBtFhFTRLFVKPNHgVxvORSkjVlfomfhVNqFogECdqJRCus76y9qd6GYQYkv+9WeUJ65Xc6TW5QJCwofKu5hPJE/5NQuCSBSeYHt8UQEbYXZ4oN0Ekevqnp4CCjj49EUdo1HIwuINxLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOCMab1yDbEABl+UmGriVlrwExYx9IJYtIl+4L6dPC0=;
 b=v9NUj2hy6TDxzq7UieuUTitHoJuY4vF98s5WEzUgsMT2jMcpoyCPavZ6KaYq5YWW7rUycSYFeYDXAQeM1VmLevBeDePdFKKMzA6DLGlhlWp+iPSIUpuAHfeCpv2WaydAvtTr7yxP3oY2s5FQEn7DKiWqJ7g/pI0B35BOAedpmH8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7639.namprd04.prod.outlook.com (2603:10b6:510:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 21 May
 2021 11:06:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 11:06:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] fstests: add checks for testing zoned btrfs
Thread-Topic: [PATCH 0/5] fstests: add checks for testing zoned btrfs
Thread-Index: AQHXTf36vav5X+sU9Eyulyb+u704Vw==
Date:   Fri, 21 May 2021 11:06:06 +0000
Message-ID: <PH0PR04MB7416870032582BC2A8FC5AD99B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210521045825.1720305-1-naohiro.aota@wdc.com>
 <PH0PR04MB7416E64E9F3C70C39EA657BB9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e517b118-a070-4aa1-1d18-08d91c486e4e
x-ms-traffictypediagnostic: PH0PR04MB7639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB76392A2A84A288DB3B9C260A9B299@PH0PR04MB7639.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6mL2VA3HyA9rqjJyQ7tcTPLrbmxSP2U+ZfhfISWgLOg15c2hkEsUTAkKaBnjkecijaHmIcx1TGtQ/f+Bb0GweQFRS8wJdbNgqUNcjr1ZVyAvswzKdzqu88fizYQh3CYlu2bZXcyqc9oJ5hLaAWLJQLdq8RSC9CENJK1sTPM9lw47OHpLHGrF7qvefuvQgSQC5PSUHXv/tKFOHqffCRpKtWSnGu0HJwW+GDZG5mA25Yp3yejEv0oIzWK6yuku/PcEfoqr4INOoW3gUg3QMgOnibq/DWyCE64LW9ElJ0w6ssKe5eA7CXdxyYUofFW7xYpWfzPLZhPmFy4WiWQkM5LOVQKfY95CH4tNLSAQRNXSRGMamhXkABHj+M9P9VmZCl0ea/caPK671iuPstzVi+LsaCutEIxFx1bSO7tJlhKIaHelOvmfrka9jTqMUOiOhwK/jA4DeMPE6Te57gMfEDPox3huuG4AFeymskOXHc3+fvxi7wv+yzNCchEVAOjKTcCNkLpPRhFsv2hIwBhYXtHsKHZsgipbOvr6peY/02s2q7XEW2w5mCsAQ5ybafECcdQ0ytPgNXWpyuvtkcgdj2uHkwcdV+1oTY0z54vTsSQplniYYy3V3aAvmgoF/05H9Ikbl+tHKEX/NPtiPFMHY9Byg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(5660300002)(7696005)(33656002)(2906002)(478600001)(8936002)(4326008)(186003)(66946007)(316002)(66446008)(66556008)(9686003)(76116006)(86362001)(55016002)(52536014)(53546011)(66476007)(64756008)(6506007)(38100700002)(450100002)(8676002)(83380400001)(110136005)(122000001)(71200400001)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?E3PUO/sKgnpFnkklWhsooqzrLVCtdarGwYbbaNWvt3vsb5xAy1JwI897L1uf?=
 =?us-ascii?Q?UjjvFjn01UugCK0Ti/bz/uS48n97eNOeLxDGmT9T5z3326r6xSr+h1djWzEI?=
 =?us-ascii?Q?vUrAVV5TdH+TxtABmmdlYfU/g/Gc2UOlFqpJ0A0tWrm+Uua5Pri4+V7i4USI?=
 =?us-ascii?Q?wLE1eqgG/kB50Poui0mlKE4b0zG0231SITj8ukoZ63u3TekwKf6PxLUCcszK?=
 =?us-ascii?Q?cBzHg2YGk6txVfYOKsy+V/xhD1glP9K1S9pwLRAkmB/hwGn+fuODh8CAaQyY?=
 =?us-ascii?Q?MUiurItcyYewXydYJjNaNMmk/gCqI5Xqb6FuLoeaF/Ut7rb/6xqR/oQ9q8MH?=
 =?us-ascii?Q?4i1pZqlhv8pWiXDzbPKX5fQJlMjONxDgoWPSvXQ2FS4sljg8tsMq2piRkqNg?=
 =?us-ascii?Q?oU4Ti/YLrOQuuvgodJkqjLiB8mOpbmz9+pRlB7Af3MsJK5/ec14g4fuQIq6l?=
 =?us-ascii?Q?W5PxXWnywdSwXgcG2JLChqB5a5pRGne7XqtAVdpIw0iBtJd1xiD9v0BJquAt?=
 =?us-ascii?Q?39REDO7BesMKKWbRjhKcDwGPH9rudw3cFRLmz8Bm1yKQc7KTmZtAPihEmHgn?=
 =?us-ascii?Q?hT5kQDRTH56eZKNSftgFaYMSEQNLpQ3G6zzE1JgEW+oIegUcg7Ci/kyMhyms?=
 =?us-ascii?Q?DlXJk7jcFsnd6gZfog59O0WzsqyHI15yX3ADEX28P102n2nK4bkS/5y2od+4?=
 =?us-ascii?Q?fk2+9n/a3QtMrp2KnrZnp9PqoQ4IVx4qDu/nCzT+mzjCI0eDFFLSht3TKBgG?=
 =?us-ascii?Q?Mn4/riVYhPBzkA7jHifU4Ri77LnklnXlPYRi5rNe2GXxRxEBt+OmrHv9gIc5?=
 =?us-ascii?Q?G3CTJ1qT+DqIhABkIBTLveYrSsYwjbGYLpJ0ESynWi04H2pN1MLTI2AFGoBT?=
 =?us-ascii?Q?/cyrkKdzjTeDFU/1g4F6j2uO7qtfK71HFdM9s2289IIDy8nXDME72tEvGKNf?=
 =?us-ascii?Q?UA5bNyCdmeFuBtsQo2F1dd0fGrOQGFSGJNLMg4JTHJ1hMo6zoJEuqdKt5BTe?=
 =?us-ascii?Q?Bd3mQc4ncpTsfX6NYJImvodZntcIZTjFNYVNgMV04dMF5zFEgps/NUN/cKpq?=
 =?us-ascii?Q?2OG3qv7foGhkwdrPk6G96haIZJANa8+7y9kSe+vh+57BOinWQPa2ZdNTWbcz?=
 =?us-ascii?Q?Nnfh6dQ+BEMCuDjPPfnFdDaaSFQYW2GxFc9QDG9hDc0Ayub8zgzMFNaUwuKa?=
 =?us-ascii?Q?0IYh+CLsGXDKIJo3q2Z4NsU1eQieiLg5U+mThZu1zaYQDmRaf6KuyrzbY/hy?=
 =?us-ascii?Q?gWvi9o0ZEs2refNwQGqYTv1/0RhSE9CWengfNsHv4C73Y3Hl3PC+deV3nDqE?=
 =?us-ascii?Q?D7F+m2Sx2JCS3WYUQWoUcycPo+kUY6XGkadxA8BF6Cm/dhj1J+Btm73FI78p?=
 =?us-ascii?Q?i9broYhEhDDMlPwvV5fB3cKEw85MPX8VKWKc/JmwPt7hUHbRkg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e517b118-a070-4aa1-1d18-08d91c486e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 11:06:06.1450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2zz0eMi0SY1nLYdZ9G14rWSf1rZH/X+bCwuxgZsl6lYlz4UO7fSdtEZCErDUlC0ypE2U/TyfX7y4aE67ikyWgd7oEJXG75qcDQEv8xpkGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7639
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/2021 12:17, Johannes Thumshirn wrote:=0A=
> On 21/05/2021 06:58, Naohiro Aota wrote:=0A=
>> Several tests are failing on zoned btrfs, but actually they are=0A=
>> invalid. There are two reasons of the failures. One is creating too=0A=
>> small filesystem. Since zoned btrfs needs at lease 5 zones (=3D 1.25 GB=
=0A=
>> if zone size =3D 256MB) to create a filesystem, tests creating e.g., 1=
=0A=
>> GB filesystem will fail.=0A=
>>=0A=
>> The other reason is lacking of zone support of some dm targets and=0A=
>> loop device. So, they need to skip the test if the testing device is=0A=
>> zoned.=0A=
>>=0A=
>> Patches 1 to 3 handle the too small file system failure.=0A=
>>=0A=
>> And, patches 4 and 5 add checks for tests requiring non-zoned devices.=
=0A=
>>=0A=
>> Naohiro Aota (5):=0A=
>>   common/rc: introduce minimal fs size check=0A=
>>   btrfs/057: use _scratch_mkfs_sized to set filesystem size=0A=
>>   btrfs: add minimal file system size check=0A=
>>   common: add zoned block device checks=0A=
>>   shared/032: add check for zoned block device=0A=
>>=0A=
>>  README            |  4 ++++=0A=
>>  common/dmerror    |  3 +++=0A=
>>  common/dmhugedisk |  3 +++=0A=
>>  common/rc         | 15 +++++++++++++++=0A=
>>  tests/btrfs/057   |  2 +-=0A=
>>  tests/btrfs/141   |  1 +=0A=
>>  tests/btrfs/142   |  1 +=0A=
>>  tests/btrfs/143   |  1 +=0A=
>>  tests/btrfs/150   |  1 +=0A=
>>  tests/btrfs/151   |  1 +=0A=
>>  tests/btrfs/156   |  1 +=0A=
>>  tests/btrfs/157   |  1 +=0A=
>>  tests/btrfs/158   |  1 +=0A=
>>  tests/btrfs/175   |  1 +=0A=
>>  tests/shared/032  |  2 ++=0A=
>>  15 files changed, 37 insertions(+), 1 deletion(-)=0A=
>>=0A=
> =0A=
> For the whole series:=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
=0A=
Spoke too early, I've only tested with a zoned device. I get the =0A=
following splat with non zoned btrfs:=0A=
=0A=
btrfs/146       - output mismatch (see /home/johannes/src/xfstests-dev/resu=
lts//btrfs/146.out.bad)                                                    =
                                                                           =
                                                                           =
                                                                =0A=
    --- tests/btrfs/146.out     2020-01-07 15:49:53.000000000 +0000        =
                                                                           =
                                                                           =
                                                                           =
                                                                =0A=
    +++ /home/johannes/src/xfstests-dev/results//btrfs/146.out.bad      202=
1-05-21 09:56:43.963914581 +0000                                           =
                                                                           =
                                                                           =
                                                                =0A=
    @@ -1,3 +1,5 @@                                                        =
                                                                           =
                                                                           =
                                                                           =
                                                                =0A=
     QA output created by 146                                              =
                                                                           =
                                                                           =
                                                                           =
                                                                =0A=
     Format and mount                                                      =
                                                                           =
                                                                           =
                                                                           =
                                                                =0A=
    +./common/dmerror: line 20: _require_non_zoned_device: command not foun=
d                                                                          =
                                                                           =
                                                                           =
                                                                =0A=
    +./common/dmerror: line 20: _require_non_zoned_device: command not foun=
d                                                                          =
                                                                           =
                                                                           =
                                                                =0A=
     Test passed!                                                          =
                                                                           =
                                                                           =
                                                                           =
                                                                =0A=
    ...                                                                    =
                                                                           =
                                                                           =
                                                                           =
                                                                =0A=
    (Run 'diff -u /home/johannes/src/xfstests-dev/tests/btrfs/146.out /home=
/johannes/src/xfstests-dev/results//btrfs/146.out.bad'  to see the entire d=
iff)=0A=
