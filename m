Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D33B5DBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 14:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhF1MPg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 08:15:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43116 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhF1MPd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 08:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624882389; x=1656418389;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MjQSF4MTuL2ikyWs/1nAoX16DTXb7a/cYBWeZYrSHO0=;
  b=dDVWGu81tUhYdcm83gT5Olvca5vRVYmQSfYrR4bK4skL3Vi2PN3sTPHY
   MefzpFSL3Hj0JmoA7q0lYaMo9/PkGkjrVFiwynUaJTsiegwgQmkjpGR2B
   Dn6gnh3jvZd4ynCPwu83JqS4PBUokl8IU6rG77PkReZgSbYsHfuVu6vjS
   JCsy/WWT0DXdd7xLQiCU0Y+z/taxgbjurwDCnTAvuPPwVbRgiigP154wg
   U1iqNJqRh4SiggXMyxov5ya6ZjfACMCJFbZz4ld9OC0KFHAxFUKNmkQCp
   MIh3XfH/uZUngrEEjmL7Cwy5zHbkP0LX3AlOcN9KQgNHlL8pVAPcjlZc/
   w==;
IronPort-SDR: XocgAJIgvY4NY39lpsQLJGC0xuJnL2jqgbQWpIUp4hhXpMT4IbB3IUuTkaTCcGBdW0sTyPcoZ4
 XvPYnwGKXDGstghsuwjUMEE3OiORVg+9WqWI5+F0d7jbBI7P7JdqcghewMw8VhUoAvhOSSshIg
 6fBaMdrtge/BJ1OO41cn0EB5qxBNX1u7K2olq3KyTbL0HYPL/hkRIkHUPQY3EcSFxD/RIZdb25
 LOKhFi+RA7IkjRauVSM7cEb96LzajHDJCsNE4/U23+S/9g2k1dexFeOuXxnTe2d4Ulbx6jLShU
 RxQ=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; 
   d="scan'208";a="173661313"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 20:13:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkrxItIzwQkOjKdsKIBJDCAb9v+l1VuxZ+Uz1TzVdSwx+4JtZqImTzblKVTb/gfcxv09Xvm+MoayESUeEjV/wh+AMPgWKS5sbWcAKdqp5VHPeqZyXXQkVwYdAUVcdNDlRnn88U+2+z+3rGzgI2K0DELIdRStAr2C3saGBsYlt7W/Hqv6u0QZ/3yvFm+ps/9p8/Z5GWii0f0AR7dRsvbUu9rj8KFBtaXmIdUSn4QvmiZu8Q5AJaFKEnlkxb2VRf4ym1pGvWXrgM6ht38re/cgqvjNsTyA2canus2Tcz3lIvfNsA2752zbXidSWF+SVcff1IDX5v0fahzsmzJ1wW1d9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NETzj0fHWFolcLq9LQiYuJtzjQgaqQuW2ZMnuosQTkQ=;
 b=MVjylqO5X8afLAbfNMo1eJ9Dfia0ts+TCgFRPSPJDIBUTZ+qDkI11XPYiTGB7zyxTqqk8DFs+lPzdM5a3HBZiUR2PnAD7GwnkGPS3BJnrXBI8uAXQVflwO8z4bkVz9xoAu0+VmfN+GsaYze4G9dxd6qrLuKAa40peX85lobM9H1IFrgvQrXz1xzlicBAhvOv7O60GPpEi4fkZhcQs+dMctNSR0eVm7SUVZh4HLixUiBYXaLttmoXZnYV7xPkm6rpIEy7VDIsYvTIrQIsPT0pOnMpmxuNcjVuow3dAXBIIkRpgvgrzXy7rVuLB/iym+3CEPpjAeiGCMYYXeqUJLKjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NETzj0fHWFolcLq9LQiYuJtzjQgaqQuW2ZMnuosQTkQ=;
 b=pdpGawVTctSjzs2vCjLKB9yrFDlY5DIrwsezTnhkqrm6o8hltlkbPWgViz0iCkMWT9xat+LOsGrrsWfE/g5YzJ4kMH6I9LC40UL2fi2wPOmBe14pps42XOu/iVTl4TM6cIk9XIe8VO+niSyK4PiOmkdVyLVIYZ7tkzKh92tKZNs=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5164.namprd04.prod.outlook.com (2603:10b6:5:12::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 12:13:05 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 12:13:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
Thread-Topic: [PATCH] btrfs: remove unneeded variable: "ret"
Thread-Index: AQHXa/qIqPYC2XVGwUGkFAjG5cdOuw==
Date:   Mon, 28 Jun 2021 12:13:05 +0000
Message-ID: <DM6PR04MB708118A4B938CA4B94C243BEE7039@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210628083050.5302-1-13145886936@163.com>
 <ee06042f-da1a-9137-dda3-b8f14bf1b79a@gmx.com>
 <DM6PR04MB7081A02339DB3ACC72F86261E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <PH0PR04MB7416F1BC157F848540DF37389B039@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e73fd408-d5c3-0e17-b3f4-e12f2c105bc0@gmx.com>
 <DM6PR04MB70814C2126868BE1DE1DDC19E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210628120435.GC2610@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:49b5:3cc7:e59d:b478]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7560e1bb-6de3-4d5f-b66b-08d93a2e1595
x-ms-traffictypediagnostic: DM6PR04MB5164:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB516414B23BB4697D05A61684E7039@DM6PR04MB5164.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /7oz+xLJh4nBagCOILzeoq8XVGn4SbgirLD4CnIJEWMxn1RpE5uD4waElk7FiVQwYFjGYFXqzpSr/eS64wfsODtjbqt0lUrNBIGcxND4nicFYUsG7LHzjg3q/RKpQ0Ouxatd2nxPKT9P5hLGFIpsvta17SMLYyV4enEYbJCkZCjSE7TtukbuTzOybaaLysKqsF8kFkxqlwLaQ+lytY3NyDWGuLeo7g/IdUdcPdX6Wh5Z2ondxqsbyM3++yK+r+wy5lG33GUWSff8F+a9OM1rF3ni3XfNe3+3jF3aFauJYG2Oa3O+HOpHHwb+RXL7Qp1henLzuIZd0bTkifrIVGXjLvi85JqEWBT6JiTZs9yyFr4dqldDk2nISkGRR9IdB/CZLA62X1Q4KEQbNtEMU9TYuEPqwXiCVvr8Q8oO6IKIkgi6BeYK648Su1frrRv+rnMHAllk/5dIUP9a/Y7m55YWeuLw2TS0GuqdCM7j1c+BcLTPacEXY/ZENJ+0HaBO+EW5VmozDledIS8pIOAIQ3WaGkcYp9mqp9lTf5sCRWLZ+yh7+ciy4AC1fn3qHZM1aeChqBChDtmtBF6Us0R1w7+HHGMG/10myFxRXN+C3qAzEnVzwPNTOlLR3z0d8I/cBf1dbjVgfLSy3lrq/rtoMcc23A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(478600001)(66446008)(64756008)(66556008)(8936002)(53546011)(66946007)(55016002)(9686003)(122000001)(66476007)(52536014)(76116006)(2906002)(6506007)(54906003)(91956017)(33656002)(6916009)(4326008)(5660300002)(8676002)(83380400001)(86362001)(316002)(7696005)(38100700002)(71200400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TaxPeFuuYwyqMGuFeHdOAPy9iipzVAQx3AWl0BpYVJfaKa6F2Dhouc50DZQg?=
 =?us-ascii?Q?SBEV99E34+S9Q2r5DFJD2pECpLOcvKCjNLjURDSRs8/570JdmaXdZ0f4GxQ6?=
 =?us-ascii?Q?BZ6TWb3PUb3DZsyljaDc1xWhgXA+UK/ESfLeNd6al0hICjuEqrlQDK2vvvyH?=
 =?us-ascii?Q?X+M3cdsYsg0UCVUHD9Dc8IUsADv7kDEhODMiI/N0YhkVN2BpmtN3O1Z7p/HF?=
 =?us-ascii?Q?fqW3aPXIfxvKgSJlBJ8Qp2O6/AtzVJ66hLKbhfGHJoP7oi1RSywstc6g9lOC?=
 =?us-ascii?Q?nAWraX1xB5tjFfFFCdP+5v913pCYega0RoLsn77ZmGoMhdB2NgidOb9wLuld?=
 =?us-ascii?Q?zdAsMavj5tldracFbnHreFz22i+miW8qBb71SXmAk3xnSRL2FfRn6uJCFArJ?=
 =?us-ascii?Q?QFil+zNC9Ctq308P1IuxRhDofojz18Dl4Rjcwfoh6qtCuXVpSgkVcEI0Qu/I?=
 =?us-ascii?Q?U1WySRC+nnX66wkMDRWBGx1RY01wmLyzlCeD5u+vcI4WzF79Mvwbi+j7igI8?=
 =?us-ascii?Q?+nEfih2DR+boFbeQxX9E7McHpkEm3vL0lOG4N3o703oiAT3Cb66Xd6Dpaynj?=
 =?us-ascii?Q?4c1E1vHY949CWyytwN8+dXUpcpbXJdIaqF3P0ERDgMi1hY6I1uEUUpLJhFOR?=
 =?us-ascii?Q?CU0FpNI0Sb21Cj2vExZMUtojAPIAehSWSuLXXu+MlbYGotrCfpqKLGbDJTQ3?=
 =?us-ascii?Q?T6HeAvZLbmDDV7Wum1sydUUUUiHu/+kzGv/fYqHhWsvvJznVVMFuJEHExQ2c?=
 =?us-ascii?Q?XTneYigfeJMQHhN9x/tlb7JbOZGyo3J1Dp48P4rzmQKcyDfiLulCFo7M/7HU?=
 =?us-ascii?Q?el/9KyAmCbXRpkXu/u/mPaL45g/kF1VEmk5TAkZKfaS2He7AFUdN4SCrqmMn?=
 =?us-ascii?Q?4L4/Ty2Ybj10v0AQmDuw+tKea/cTFpT3m+vmvbhsRhabWGvm3N87OZD56RU/?=
 =?us-ascii?Q?RxeK39hAnn5PmeOKNGLIc+khoLEqUUyjsLz6uQSAodQMqwSZrpMeNxR8tBQT?=
 =?us-ascii?Q?jdfY7Cl3dCMyfrYEX7iQFgxfsc6KOj/5Tny+WBHCEox45DrS50HM30g4XAuv?=
 =?us-ascii?Q?0kRYf5hSOkhXQ69O05zOR3+bcSnDemp4mK4U8CPyw0cJbYCY8lvmnx4br3oT?=
 =?us-ascii?Q?01aM2oCprxJNrTnmmsfw9XiZQcFv4kTQ7v6jZ/F1/5UZkaeY+pXDe8uKJZxz?=
 =?us-ascii?Q?njRxcnDW7lbsO7ll/0DjEBdfXxgf1VogIPY8/qKzX+RN0VsGUmIFYyQoodqa?=
 =?us-ascii?Q?E4FA5FiGYShdH6ceafb61FRzjFRpJ2lU38iN5lZv04aMhe8b7nrz0t5oswGe?=
 =?us-ascii?Q?SjmI+cbHAHmVSKVCfA29ZYhhEh6+qSu2OFW+fPFeWTso/7kEthKfT326nGBD?=
 =?us-ascii?Q?tFP7+UulGGk+EYoOvwc5L1KHNnoE7GOEyMX6f3Zm3EJsMHdTYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7560e1bb-6de3-4d5f-b66b-08d93a2e1595
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 12:13:05.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elStrXzp8kkezHeD3vedQoakWG3ur+8+mjvhejzYhYtjpEJdf8oei4wjMnYtO674nKs93S7be5IyITIvsWMtlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5164
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/06/28 21:07, David Sterba wrote:=0A=
> On Mon, Jun 28, 2021 at 09:48:40AM +0000, Damien Le Moal wrote:=0A=
>> This one is actually a good fix :)=0A=
> =0A=
> It's not a good fix and has been posted several times already. What=0A=
> needs to be done in this function is to propagate error codes from the=0A=
> whole call tree starting in that function. Removing code triggering a=0A=
> warning is perhaps the simplest thing to make the warning go away but=0A=
> the right fix needs some understanding of the function and context.=0A=
=0A=
Thanks for clarifying. I actually did not look into the details of the patc=
h.=0A=
From a 10,000 feet view, it did seem like something OK. Obviously, it is no=
t :)=0A=
=0A=
> =0A=
> The patch also comes without any explanation so that does not help to=0A=
> back the intentions to remove it. Reveiew of such path is "Please=0A=
> explain".=0A=
> =0A=
> Replying to patches attempting to fix the warning (and not the code)=0A=
> does not seem to help, it's just pointing to the previous iterations.=0A=
> =0A=
> Everybody is free to run checkers, find the warnings and send patches,=0A=
> that's fine and that's how open communities work.  But in this case=0A=
> we'll probably have to put a note in code not to touch that particular=0A=
> line/variable.=0A=
> =0A=
>> Just did a make with gcc 11 and W=3D2 and this warning does not show up,=
 but there=0A=
>> are a lot more warnings about unused macros and some "variable may be us=
ed=0A=
>> uninitialized" in the zone code... -> Johannes ?=0A=
>>=0A=
>> There are lots of warnings about ffs() and other core functions not in b=
trfs=0A=
>> code though.=0A=
> =0A=
> That the higher W=3D warning levels are too noisy and have to be filtered=
=0A=
> or specific issues fixed after manual selection. We've recently added a=
=0A=
> more fine grained list of warnings that would apply only in fs/btrfs, so=
=0A=
> if you find more that are worth fixing and then enabling by default, no=
=0A=
> problem.=0A=
> =0A=
> Some set-but-not used could be useful to point to code to analyze if=0A=
> it's not obscuring some bug but given that thre are lots of instances in=
=0A=
> the system includes we can't enable it.=0A=
=0A=
Yes. Agree there. I personally use W=3D1 and W=3D2 only when compile testin=
g patches=0A=
before sending. Not having these enabled by default is fine with me. And si=
nce I=0A=
just noticed the warnings related to zone code with W=3D2, I mentioned it. =
Most of=0A=
the W=3D2 warnings for btrfs are clearly not related to btrfs itself.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
