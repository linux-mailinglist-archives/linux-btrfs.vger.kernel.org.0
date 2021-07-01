Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277193B8E85
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhGAIFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 04:05:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13462 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbhGAIFU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 04:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625126570; x=1656662570;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ue1nYa430xOMcPgd+3lxXGvr1PdcyOxxFbL5+G210Jg=;
  b=cuZl0NTeDyag71WTk2d2Osm8K+PxdWkBMDPAWmSvZJucXj5uB7HLfq8x
   A9sH3QafGisYV23w0F4hoDA0t+93fBg+DYufCe83NxhBT7TDmZjTq36x6
   0OoY2EFJgPVo3kIppRVZDE+DPLgGjxsuAUJxq9cqzznqDn3SF/YzvBDsK
   XI+zoNcFafcEStgKn6qgGmqC2e07P7pxdoG8ct76/J8HPjl6x2a7EWK0b
   6kKly+p8L4JhWBXkAzHWWR0TKOxbGyuWsd2t5oQXj3QnohmcP1BvwEaqz
   E1m6ewvKOApTz1saIGUAeBBdVw+GXV2uWY0Lm+W0K7QKdbvLFjEcEW7Q2
   Q==;
IronPort-SDR: iZFuGuYwVaMrfS5T2wSayI6crTfaqnGAOINpI7pkTKcEg65YUmbGM7FQOSLN1Ls8em84EXmhAI
 OyJ3MxMzYQ8ubN1UoPn/uMBT3r0GkFoxFOpJEa/6KcWOrIbS62C+7bT+O6EJvOmDZfFqwdSIb7
 J96OksPxLbbnRbvw781KoxwPmiMYjvMj2xJK81fbpPiPn7QQDo1awe/orT/35hR07yanLiqRkk
 N6gOyzp1GnRhzd6b3QysgFAra4viRrq//nbLIVPqnQ3fOqOqxkWqRfX7RXeydbAtpjpAn5OURP
 5Lw=
X-IronPort-AV: E=Sophos;i="5.83,313,1616428800"; 
   d="scan'208";a="172667452"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2021 16:02:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DziUGtZOC49+YjMfA4IeS7LbeLzE0GTe1lx8Qb7YTO+6mlkYr2c7qfQJcJ+XcnuElAO7jGW7dFhG4KDpwKlyPeBp0IrGJdFq+EHl/DDC9uAd3dyjMg6WJS5pmVav2OQGfWiAR6rTbURnUG/7ZCCTHDQ1pmB8360J8I7TIIUmuUB+nNUeV0RegN0rS5tTiERLJTvk8/aqg2NgvDuM02jxDepcleXH7N5OkTAj3k5DJo6+4e8N+DQGwgaEFaOlnOXDodQbbGaMRbWp8JuI2U1AXHKLbPhji5XBDKUo+fCg/YJ2T9QXE3xLkkutianlOWAxHTd8llGYylefVNw+kHAqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFZtPiRLkv6F2LonmGXCFGBmgJz/2Iqd5XoMVuCw8PI=;
 b=SC0sojBUQuc4KlUIja3v82NNE6hgIOLaw8AH5PVesMzNv7dRq1Br+vKkb2NuCrzU3FHLepKPR7+L/K/sqDXcTAinCfRWz337UOPjMH1H6zxs1FSvuNChKK8XAzd9+n/OsXBiEZ/ncZI0HkFs5eYJT3yaCk3VjigEicWTGF3cjT6yFskMN3Y/eamzMOmjkvQPMvTaisDWCKUy4ad5oiSCI0Hb6Oovn2p455rZWDgc4eLIyr4hItuzUeA/rCMi3CFdEl7E7tyv3OCzJY7zJUmlMn6uYsRNSb6W+eFE3fPJCtaS1kxC+96Qklx5KGgCGg81P0LpOyXPeTT+rdJ1ekSTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFZtPiRLkv6F2LonmGXCFGBmgJz/2Iqd5XoMVuCw8PI=;
 b=x8Gd3MGTFUsho2bOoO1OvItCvg5fQ+Y+Vt8oAL5xVFYGM1oe9wX3eJASA9K35vUZxXrGkCf2/QEYkxApEqcYLtkA1zJD4BHkz9m2yuybOyWuUnA5a+ySaVTpt12sHMF5VbiimwGY1+LHEKchLz8z1E/bGGjWOPpW9A3pdS+6cRI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7175.namprd04.prod.outlook.com (2603:10b6:510:19::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 1 Jul
 2021 08:02:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 08:02:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Thread-Topic: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Thread-Index: AQHXbEyTtFQvRlqoQEGKBoNt5m0IBA==
Date:   Thu, 1 Jul 2021 08:02:48 +0000
Message-ID: <PH0PR04MB7416EADB226778E4CA09C8309B009@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
 <20210630184851.GR2610@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c847b5a-c931-4bf1-744c-08d93c669e11
x-ms-traffictypediagnostic: PH0PR04MB7175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB717583018C0BD6172860A7599B009@PH0PR04MB7175.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s3mhJ4Fhl79JnTJZ4YhTvrhHfjZtCQdRoEeOsObZybHuTZgfT57T0SVqOkcV6NU6sJRdfjr+n6OLrfT/kDbbQgIpIw8HIepXc0LPee5JCxTkQciEjwGMhksmRoknpQKtCeR+EynTimTUruXouWD4e5P+1gJegYBnyiGzZAgvHEDKwR+FWUOPYquFIT/SKEBfD5aQFdJ6A2/ZdExOPYE6lrL2MAwg8LTUEdUybaUAs5Jj3o8g3lTPv4oYlbg2mk5jY2/ajmUBa+ueKUqF/taXdT3R9+vKNAbsvGIPUlQOa1zVpJtPZeRT6ExLnnW+g5WzbZGUoWflJZA3XH0XksN3Sdb1vrtJR5pR93afAAEQ5qBAoxQGN9FEaegJYldLz41LXUAjBPrFIaUuysHJInJtZ9WOMQMH7Bjk70wwUU+t9HzbxorGXHjJ3M31SEs+me7IgTWNlhkwM5nSBpQpsw0ra3BUDIwhQCO2lbTtED2FsTmYF+T4pVdnVGWP2EU5FfiKLhlkvs5nTGzMecOHoWD6T5vHxJPV1quGAHKxsaGe8K2Xw0k0QbgCR7BOb/cNuGAP4BsbTRsy/BFCBvnc2C5p4M3KaEZO5S8gVwIPVG9fF/PWDeG4zckBzhC2uVGRKsW/fWfdLYtUwDpWF1SrPoynGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(316002)(55016002)(66946007)(91956017)(66476007)(76116006)(9686003)(33656002)(8676002)(8936002)(71200400001)(478600001)(66446008)(64756008)(54906003)(52536014)(66556008)(2906002)(6916009)(7696005)(6506007)(186003)(122000001)(26005)(38100700002)(5660300002)(4744005)(4326008)(86362001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3KIwX2AblZgjNUqgUXAmeA9xoA3AHzB3msbrJV47HMLnSDT0Ig6huFTzFSTl?=
 =?us-ascii?Q?K787+Pa7IpS30FERTXnx87kQ+zNX4F5u+Y7y3QBQ8acGyAsqn/rly9r+7aMn?=
 =?us-ascii?Q?SPEI3mfASj6WXpASr2tMkxA36QyrtVWsEiAWQdgTPvImtAQ+Rp65QzZNPZ88?=
 =?us-ascii?Q?XVUEEuqRTsz3XOBJAeHpSPrLdc7Rux2ffME5hFJSp8IoHlObthlvqNEdsEJO?=
 =?us-ascii?Q?wTsy6Y4jhCoVrhOADXAEDkx8iuU9NNAMYyUx1WtIBBAj/AlwZRUwCq4n1uUt?=
 =?us-ascii?Q?XjIDNiNPxfuCVx4IyacbyCoOjk58zJ4pq+Dfc3Zx+Td7kDYrQ/+lqMQN29H/?=
 =?us-ascii?Q?HiBq1pbklbWFoG5PTiKlve414aUdqHPI0p9oQKVBygLihay+Y3gbjtvUbcBb?=
 =?us-ascii?Q?Mnwkk9k+hxllsSDhIuLLLt2lD+pBBbL9BWn5uaRimEQUgQRVcAfXgXTQJ3im?=
 =?us-ascii?Q?yLjsTFi32pnuvww/6knQcpEuiipxJGMcqIAFslJs8x/Zm7QfWUdsJaEqXcyL?=
 =?us-ascii?Q?Ho0FDrBpL96ftPOSZmMmdcCCH06ZebPUcp76Z53FjlEZgNjBYQzHyTKBE+h7?=
 =?us-ascii?Q?O+y041ppdMOjP4OvfRazBZk8friDb5fkr3uhdcJ7p3pnIjjFZxOEG5Gw/XC7?=
 =?us-ascii?Q?4Zeca3tE9LzV7CpdfVGXQ0IvFxoR2hyjJaJybjXwN47FUuwwNxTkZN3IZ7J9?=
 =?us-ascii?Q?HKbx6JTZ6PLHbPa9A+yjqLMvHYQTwK4moG391ZNeqcUGuesx3t8y78jrltDx?=
 =?us-ascii?Q?aEIGk4H1KsKmpdpzDZ599Fl/GwbikFOWw2ta3tSuFNSDPTNM6rnNOZuqCd82?=
 =?us-ascii?Q?6AuuyURb15qCKV0iCzrwkNSRwIqA1j4biMVfdsGqBd+CYKmaKGs8wFT5tCF7?=
 =?us-ascii?Q?+olC5csh4Uc6Sotv8U3E0BiZ0uxRDkqIT1oFpoB6rAWZxWHXytpXGLEobXA+?=
 =?us-ascii?Q?iI2u7kHBmZPgwG/OvuuPSR7ZX9oOCq2saaCB1AKmH5WGVexKeXIqkINcnemw?=
 =?us-ascii?Q?AMqrIpk5FGRp5i06ys7PKn//s8ooG4828YgE5/P5DA0KhaAFNK3TZqejeiKh?=
 =?us-ascii?Q?8/hKsyAFGqyefDAhZRO4lhYBmPhbslHIrV4k7nz0Ws9w/vOFKGz87aTyKsFG?=
 =?us-ascii?Q?70yNiiQMMyTRJIcW9ATdwz7n82I66D6hf3UXpjnBUDKKNNtOdulpVutsVE2z?=
 =?us-ascii?Q?x8Fjw7DYh0fV0sSoKoW5KlVg4xrdvZdQ1JLEaHf+dtQY50b2R+N8uYdh3Lkd?=
 =?us-ascii?Q?HnU88RsJomd9hB7lokGSpo33S1MaY5R+ueYxNgE52kj+CudhGDgjhm1ceh00?=
 =?us-ascii?Q?bD3T1Bd3gJhAjyphnx23txoc0qEUQJhkXz3IYZ0iRYPyxg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c847b5a-c931-4bf1-744c-08d93c669e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 08:02:48.5014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eurs23VSg94T51mN745SL4pIxILoIh9ZyIoxDPH47sfbcw20Zk0xjIr7vSCrWe2PDHvxTcQgoAx/Mgo9l0Z8/Wam6PgI8us3JNJofNB94Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7175
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/06/2021 20:51, David Sterba wrote:=0A=
> On Tue, Jun 29, 2021 at 03:36:45AM +0900, Johannes Thumshirn wrote:=0A=
>> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
>> ---=0A=
>> Changes to v1:=0A=
>> - also remove the local max_zone_append_size variable in=0A=
>>   btrfs_check_zoned_mode() (Anand)=0A=
> =0A=
> And what about btrfs_zoned_device_info::max_zone_append_size, should it=
=0A=
> also be removed? In case you don't have plans with it I'll remove it, no=
=0A=
> need to resend, it's just a few more lines but want to know if it's=0A=
> accidental or intentional.=0A=
> =0A=
=0A=
I /think/ this one can stay until we work on multi-device/RAID support.=0A=
We could though also remove it and bring it back in case we need it again.=
=0A=
=0A=
@Naohiro what's your take on that?=0A=
