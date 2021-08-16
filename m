Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC93ECDBF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 06:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhHPEfO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 00:35:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43542 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhHPEfN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 00:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629088483; x=1660624483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hq/o2RXZ9kFY5WLwksgogWawSWW+qOH3lto0JZyvNJU=;
  b=Eis5NSHbJ4evvhaJh7EmfquRahVDYFOrvZXAM6RMPW+0mhzPE2TvNRfH
   8cPuLogyx/jMNTblTx18g89MeDT813Pj6oe0MZsIPjtz2lyiGbdh1sPiZ
   im5CMRV6XcN1aykEIxhMgaga39x0L37/Ttmf+GUc/s81UgwgHfwNvM46N
   0b6fpRi3YKkvMW3gZsKTfQMHej5vzunSNVkF3tdeYu8YPmvcgjN1S71jJ
   4gjHp7A4h3OC5NUqYSuwjpj9oPTs5nPvpV+iE2cC+PdrLlb8cv1e5G0uO
   KrW9B1vwP6EMeneMQipMHyJZqT57VYKigj1IqZJV19vw94EJmVoKMlAn/
   w==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="281160981"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 12:34:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb7HRt0tJVl8Pi1QJp+wx62nWoXkTiqgbjZ3hgm2wYhXXPn5oX3zd5eAc27i12B8mbYlOkoQ7Fu8S+LcuUX6fmz+MGOFubo58D8VkaZAlTYQlBZ4xFyigB6x5CATjnCXS65n0YnKdqJTWCbP7qnZ+M6T+HvMNln41chKl9/vanfozHLW0/XVfz63qMWhTw2vnq+LD/+pqYCf21u9EmPz2S4+fsNRFRXKQwDM8yYW7I9XhNyBGFPTQYptoVllsABYXgJJr/BEGZ1txZuSuqo+SZd1f/BNobZ/jYlavRnkmOpFqnzRUM2jUuq8vFWEwyJJRA8obDUP7J4PDaS5I8zEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zExGThIksmjYmA0RyuXqKaVIucwdwSNHedd6bAYe7IA=;
 b=WeVQhEOGHO/KlGgjVffrQ5dt79gunqYxYEzMkZ8NAzOSLU7FvwibgB7PO/6Tvt52bcIIAGfT2etztNp9Ec1ZAe6pVG7gn75OZ5O0+R7LDkm1HCOp3tx1ymLgpaq58vLf6G+tfLwBvNAupnJWT5nLB6zmuTbdV8pSBoiy8hZ373y5mii/s3Jf/bxO7FgFIt59Y7TiZx8/3+kh5mDJpBGwR6DK8WirrM52PW7BmhkmM1ZJh97WVfEvj2MEkvIBymD9kvy+4HlGfbUL+KDkZgM3iiai0pVXeAK5biDIjJ9XtvNQ7RxYreEyT9IInAnQN1XkL+4Br41pkxdN5k/8axLM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zExGThIksmjYmA0RyuXqKaVIucwdwSNHedd6bAYe7IA=;
 b=vThzRiMbsXmXN38RTCQ9yf82Q3t2poQxommGKUssDPuArT25vb2vfHRODCjsKI2u7rCM2+lU9whIDieKGcqeG6oyOQbdfkQs4cy3Nmuts3++4LL5O8CfAzTlPjUI7Ibqvom5SYfudt49yJyLJINPsmVmlhJkdyt/i9+2oQHvMrc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7837.namprd04.prod.outlook.com (2603:10b6:a03:301::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Mon, 16 Aug
 2021 04:34:41 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 04:34:41 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     kernel test robot <lkp@intel.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 16/17] btrfs: zoned: finish fully written block group
Thread-Topic: [PATCH 16/17] btrfs: zoned: finish fully written block group
Thread-Index: AQHXjrwicwqxUSBEI0igOtGB0UJQhKtujnEAgAcEJAA=
Date:   Mon, 16 Aug 2021 04:34:40 +0000
Message-ID: <20210816043440.4jxwzexu2xjbdmyd@naota-xeon>
References: <59c069e3890f3cbc7fa425cdcf756d241a8bfc92.1628690222.git.naohiro.aota@wdc.com>
 <202108120115.oH6kGwRo-lkp@intel.com>
In-Reply-To: <202108120115.oH6kGwRo-lkp@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcc5d157-e864-47d4-6762-08d9606f29e3
x-ms-traffictypediagnostic: SJ0PR04MB7837:
x-microsoft-antispam-prvs: <SJ0PR04MB783723E888367081D1D39D288CFD9@SJ0PR04MB7837.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:176;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DsoPk7K6JictlNHkFAAQ1dIXBOMcG9tojfR+oH+NB0DNHSYYU094oEPNOtejIxtBV8UJhl6OwWdg5iw9nwvByOBOyjq6eV3Mg7VOWseYb6z7fYa0z/zu2ugaEljxAwxVGEy63gn7ZIH88oD8kHiScR9507zeg0lSFKdpB1iyw1A2OjMN6m1QOZe4H9DN25jQskft1F1eLC5+A6OAxGj7bxD5Juj2QBebYiL+Da5Ju24j9+WOgdgdNqd617RrMFl3jFPUBrERZZVGl7cuXRJLlUyQ0CovFX/59ZzsXuZmv+lJ/FU79Ij1EMoNcrPvRVtkub4HOCBa9I7Kk2dFPUY1rKo5kfm1bv4IYTDnTNCt1J9lV8yBHk1tsdGquNqPMyIXvn27lAxdblWTDyiZi5FDCnEmfdb+EP3iDC70TbD2q34Ze/JVus0RsCQEFQXfWaDAhHugZKLMUyIHZmPUT2S6VbcE/S4Agz/mO5q5lqq/oFZCOuZnvxy75Uy/PFAmetjV/QS8rbPzxgtniW2UDg6t79qnCb7+hAvR7LDH0UofxQKOWcgkFAY6VZI2s8159qxgOVoY5ahDYpKKV2599AvNnsYL4kX9zbb3sjXLLVBGGfA2eJuYMk4cxG9pRNH2dovw0wHljN1a8XuOLE9kDNsexybmmqr4dbFXnlwYyxdkOL9yuMQzOW/h1yGt6Q76zn7oB+9gcsbKxYpgf92mAKptksh6RmZvH+vQd0dwHk7rixV1krrOoh06NL+CQ42wTLhNsA5tz8mz/1CpIdJm+JQOp0RNOjazrNzzG57tq6wvYSDH8VgfqOqw5tbRwlnjCglU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(316002)(9686003)(54906003)(76116006)(186003)(83380400001)(122000001)(478600001)(8936002)(19627235002)(2906002)(91956017)(5660300002)(4326008)(6916009)(64756008)(8676002)(66446008)(66556008)(71200400001)(6486002)(66946007)(66476007)(38070700005)(38100700002)(86362001)(33716001)(26005)(6506007)(966005)(6512007)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V7emred9DNV8QTdHgWMBmSECjnHr1Bi3qtJlrn3GtcE6SCWXKRK/qR8v23p2?=
 =?us-ascii?Q?TStVd3gw9zmszK+fVHe+SSkBdj3/eWFno5vqTTVyW2r1rX6wuLv/Myr7mBqA?=
 =?us-ascii?Q?hp6+kG8TFAb08ytF9IAjyFIzgFH/a3fZGOdbdw4dZDn5HgpBuVvHYG/Fo9Aj?=
 =?us-ascii?Q?HISr4K7m2GfwwuaM8phbOTpKCXmBdJripSsF8E5+5IJSE+ZulbfAYdBpxvHo?=
 =?us-ascii?Q?c0OBFpyZAsqav7GyqGDtq9WGsT9c7/lvyujALb5UQN5Uxac3YknFnWrCEuFG?=
 =?us-ascii?Q?mwqybxzhIXeBsDaGzTfyi/O8qD98cFfdReae1sdroE0GUGANymOV6JNFnMSW?=
 =?us-ascii?Q?0oUVXqO6kRNnIPsIcv0SJQDpp81omfSG49Oww00Ntzj5yvA2katCPrBDZuvd?=
 =?us-ascii?Q?K5z4Wp2hyniX7dMcFVoRARNMTA8+1vTInLGkHFXIv3ACrQMCJzoCGCb0iboe?=
 =?us-ascii?Q?r5g6+19SAjqS4XT3zZDfMt4ZNi04dPGdPvij9Nf6sfeKfCPMoj0YMmaRtadp?=
 =?us-ascii?Q?2TrYoweNoCNKfheeBdoD69Go1TrVNJDASll2Q23Otib7uCnVIPnPPJfOw2/o?=
 =?us-ascii?Q?0ulAlIViG4xd8tY/lHrZkWt7qdp0N04iX1LvpRjzX0MfCSCiyjXCmoZxSJOn?=
 =?us-ascii?Q?UUJFMyIeSPGo/InaQB1447p6imMIZtszWfJ0kQeNkbkFfmqFi/4Fyuc+T4uX?=
 =?us-ascii?Q?NsXx0Gfs8BTYpV4/c09Lz6R5PQtmRSZv7TSxQ5hsJAvPi0u3voNrrqrtmnpx?=
 =?us-ascii?Q?BPW94PkWQZAgeHVbKhPrbR38z8nkvWskHbhQmovtKD8clSUKiyMXSXVFXdkC?=
 =?us-ascii?Q?t29lOF6d6TC1IVY29aF5aR1ffGXaz7kGKJGrTyq6xq7h0UBtSgMHoXUs+3IP?=
 =?us-ascii?Q?+TOAqi+2/4gv29s8jEqYMuF+1NLCgNxs9UYgD6wlbDndJo89jbmFQjzlZfkP?=
 =?us-ascii?Q?B2TOg3K25DH2nAzPUvMgq+Brh7Mei1kJUodtCilOHeWwEJ0d8Lor9/80DxNI?=
 =?us-ascii?Q?QRuG4qzbDLpPXcGwQtrIqpUW6c9UH9HqDrrguOGyK8ZeNP3o4IWRR8Tc3KQ3?=
 =?us-ascii?Q?eapQjybooEJEarXtHn76ckgNratJP9zSAczp1SjXmDOaFbvBhwJWiXCav/kc?=
 =?us-ascii?Q?AppRmXhLrBgvn/+9a0lZehBsuAKHMpvgX9CUakmsXT38L/XtBYKQIJSSychN?=
 =?us-ascii?Q?jWStYm410DCK+hjM0dOSHI6kZghW7uZDbfA/elag5+54KqKQYIeZczNYtS3m?=
 =?us-ascii?Q?SXljQxEbpBdMD49zNPh14M1ZB/QPRsVKBbD/D8hNrT2XV6KVU4DJze1r2gkg?=
 =?us-ascii?Q?chCyjKuT4KCMHL/zCw5nEIZ8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5279DD8902BA27448D931C56638D328B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc5d157-e864-47d4-6762-08d9606f29e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 04:34:40.7691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4J0Eu9+FOOG12X7QMqD5z7ReF8XhpQ2Q9YfBSvv4bf54V7bkc/PzXCk5wpw7QGjo2dxmYQGOapU+4x8TmU+jlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7837
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 12, 2021 at 01:26:02AM +0800, kernel test robot wrote:
> Hi Naohiro,
>=20
> I love your patch! Perhaps something to improve:
>=20
> [auto build test WARNING on kdave/for-next]
> [cannot apply to v5.14-rc5 next-20210811]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Naohiro-Aota/ZNS-Support=
-for-Btrfs/20210811-222302
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git f=
or-next
> config: hexagon-randconfig-r041-20210810 (attached as .config)
> compiler: clang version 12.0.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/ccecd271dc2436fe587af8d=
2083c3c96ab86e309
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Naohiro-Aota/ZNS-Support-for-Btr=
fs/20210811-222302
>         git checkout ccecd271dc2436fe587af8d2083c3c96ab86e309
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross AR=
CH=3Dhexagon=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> fs/btrfs/zoned.c:1948:2: warning: variable 'ret' is used uninitialized=
 whenever '?:' condition is true [-Wsometimes-uninitialized]
>            ASSERT(!list_empty(&block_group->active_bg_list));
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/btrfs/ctree.h:3458:3: note: expanded from macro 'ASSERT'
>            (likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__=
))
>             ^~~~~~~~~~~~
>    include/linux/compiler.h:77:20: note: expanded from macro 'likely'
>    # define likely(x)      __builtin_expect(!!(x), 1)
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/btrfs/zoned.c:1956:9: note: uninitialized use occurs here
>            return ret;
>                   ^~~
>    fs/btrfs/zoned.c:1948:2: note: remove the '?:' if its condition is alw=
ays false
>            ASSERT(!list_empty(&block_group->active_bg_list));
>            ^
>    fs/btrfs/ctree.h:3458:3: note: expanded from macro 'ASSERT'
>            (likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__=
))
>             ^
>    include/linux/compiler.h:77:20: note: expanded from macro 'likely'
>    # define likely(x)      __builtin_expect(!!(x), 1)
>                            ^
>    fs/btrfs/zoned.c:1908:9: note: initialize the variable 'ret' to silenc=
e this warning
>            int ret;
>                   ^
>                    =3D 0
>    1 warning generated.

This looks false-positive for me but still I noticed this "ret" can
never be non-zero in any path. So, I'll convert the function to "void"
in the next version.=
