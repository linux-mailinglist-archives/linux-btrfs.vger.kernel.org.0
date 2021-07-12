Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74E13C637F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 21:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhGLTT2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 15:19:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24621 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhGLTT2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 15:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626117399; x=1657653399;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bk3nQCWxkf4BbFN8G7lqQERbP5ishY3lmjKeER///4A=;
  b=eXf4hwLtSxq2oJqMAth3I0PhZlYGbJ3Bgba4UeAIoLwC/DpnA9O/Kxbv
   T09kUI5+pLxdJ8YeAdSeTJdSJK6KhllWoHdifX3cB6sc1GYN6nboPAb+6
   HXNvOz0bj+803y1hp5ONeVN2/HZ8h4LtGEd9782CLYjd+flOtJCmcMp6S
   qdZGEQlyuBz4lg58LsCPPaoUEBq5ki2dkzpL8xgl7/jGqXmKujq9Fh1qs
   t6S32nsuQc5kCsb3Q55R6oJ0KthFl3NMgT6EcEbgvS/JeMBywi4kdq4gj
   wqhwiYIIP3rcbGwfDHy+XZxRrEH65OZ6Mj6LiDCXzmxqiF6bis2FAnwgL
   A==;
IronPort-SDR: uzTm1GagfKsc/mxxWJb20+/BCysIil6K0TGlI4xspYJzjqu+g7juU6D+bfk1r22iukVa5GmQ+J
 wPthU+NUp8MOD39vgCCs3a+e96rUCEgvOEtQItzvjH1eAh4dG+IVXkT8ug/0NvEEYPR6Vk16tF
 Xovvl2AB26OTIVlPsJTNkYQD4IIUUtKbWgGFqVKNrZ841k5akeQS1jKDPkk8J2rY2GbQ5y0r/P
 CtQXxXgb+naFuR8jxtW+Avj35lBS1I3uWU8gpQWyxW70aqowmwX/1TnhagnxtO2CxUhSeCOrK0
 5nQ=
X-IronPort-AV: E=Sophos;i="5.84,234,1620662400"; 
   d="scan'208";a="285918372"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2021 03:16:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmCywqSVrShvrfq+moYYwJKlhwDpCh/i3Xn2D2E87y+2vx4YI82e3fM8Jkn7hJ5T+CLkjsVOKc5CXwO5fOv39Idw5wowabUlzNKeKY/x3T5bMVZ8fn6KN4Ew/jnHYdCYf6tFuGc6kRJ+hZ/To2Tng+UD0hGTh4e9KW5Mec1O800sDAC9r8YlIfjdBf/5T77R2iPsxDvI4UfsNr+qRZeLp0Vr/PtEAO2g8lGJb7YVp5pMsgGMNhoagRkBp2peR+Kk+qGQ3292H95giRkAaofOfX05K8Yyl21D/6gHinlnoLdInryE0iJEN+SV6TrOrFqzmv6FExzTmJiIfSe8aeMA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk3nQCWxkf4BbFN8G7lqQERbP5ishY3lmjKeER///4A=;
 b=SSvt33Hobxs3GqxKKbqdzQPuE1pyn+q25yNwsKvsgKDdaGTt4vP2eltCXMucbdhCq90OOXKY/XN9lACv4qQZxovhZ1LjZgqvxeXo3qa3YH6kY1YFIZHUd4u4QloYOJxI81I9PvbIac8QMDflbVKS+yts6Kc89GNaErvur7EmZscU1YYY257z095/0+FPyHxc2MJRyjW+9h60XpdtHMJLtLCpnSsiCcJ10sIoVhnmtci9uT/vuC3YaPbRk9mzp1ryRs/yquoL+0/8mtf3qJwrJMHISJlejDO7A2cqn6BHuvffK7k4aUXZ87m1C7BN6UwA6Y4G93cba3jABXZfPhnarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk3nQCWxkf4BbFN8G7lqQERbP5ishY3lmjKeER///4A=;
 b=vQn1KTN4SJQt5X3lP/O5xjx0vsa0LO54xnxExwGkHszaAB+WnNLaxHD8QU0jfPrh7EreSFASqLjhM8uXDGtJNJnN5k5nwLoiTMn4LzgYj4aTOVDVhFIrA2dLrehapW6o394s1WISD6jZ5aVbeE4BaZnKjrtspYt1wQCTIdokEmg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7191.namprd04.prod.outlook.com (2603:10b6:510:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Mon, 12 Jul
 2021 19:16:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3%8]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 19:16:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] btrfs-progs: default to SINGLE profile on zoned devices
Thread-Topic: [PATCH] btrfs-progs: default to SINGLE profile on zoned devices
Thread-Index: AQHXc0EDcsewi6Ar9kOYVUBSRO35fw==
Date:   Mon, 12 Jul 2021 19:16:36 +0000
Message-ID: <PH0PR04MB74163E89A308E4A7760B41119B159@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210706091922.38650-1-johannes.thumshirn@wdc.com>
 <20210707145048.GK2610@twin.jikos.cz>
 <PH0PR04MB74164EDF2921DB4141CD40579B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d131be49-bd91-4968-c2b2-08d9456991ca
x-ms-traffictypediagnostic: PH0PR04MB7191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB719157EFF62BC9E8747DF3649B159@PH0PR04MB7191.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5P119s+8xXb5dOcqmKPqAypYeLwcTYzYYt727XhcyZ+ObVykWpeqGkeDzJGR77IQSOpaRHVU+FziY5vkIUZYpM4BPFt7t2okHpQvThPIt9SpLNA+mABCiVSuFHnEiCuDPGMlS/58jBu59463iZ8DD/rKUCJkay3sVD7YRurxzJSTN++COvnF3JUU5MX85vhAKm2vm2i7Ws1UdQ8SrT1VnCLOeB7IZWWyhF8mQLR6hbotuLr3SPR1X/laE+q/xa5HBWBdjzge663iWLo/xjhSOFvEK7tucRuaWqoN9nPSjOuOYmK4aNIirJnbTDoyvBigU6fh3962rS1dwkEAuHSXTESLI1JVfKyC5unkQhxPM/3TOCzxMmwSiWMMByARQUKa/6RKEwkQpvXFGf+onvB/tqo/tySmyTdgjUXM1Vm68GOAY+iC2h8S4PG5qDPMhDK7LipCoL5GDBnz+SUfsdDtAUBZ+XjgGLjodU5nbU4LYt8T/oa2rEG4ZPDtpVcPOb5mefOHfLBBbWB2FbLeoLGGFOet0kUGdH29C/Zd6wevjbK9AzgCAXXtYYN0S5uBMeUg8ADYcnm835EDfxcg26YqrUXDo+EfNYvG5SYULXbR2WPV9z8wpM83adQsJqvhJY5wYPBQUbGNGpMNe40TFp7pTWZ+BERvTRD/ob1LkgpGMmfQVsBtsTn4dUY+bPjZXVxaVBUGjg1v56D/EGU2VJEr3OLfORN9H/HK6AxTIWfqYQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(6506007)(5660300002)(2906002)(53546011)(76116006)(9686003)(966005)(86362001)(54906003)(8676002)(4326008)(26005)(186003)(7696005)(71200400001)(478600001)(52536014)(8936002)(6916009)(83380400001)(55016002)(38100700002)(91956017)(66476007)(66556008)(66446008)(122000001)(64756008)(33656002)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?36sn+WGvQJQVmDqdVbQnjCx93dtELWDThKIWBrS71rxpNM/bvqAlkoI8ucE3?=
 =?us-ascii?Q?UfXZvGzhD47mrDugtDgo4ma03IKDXZg/qJEGqzwvLhASohCY4mv5bh53tw7Q?=
 =?us-ascii?Q?MNKJ1C4Xae6tyryPNMbFUVKROv65YKccp4YAiTshozh4/4G5GkCOSaV/aKOP?=
 =?us-ascii?Q?I4mgTtpm9HrNLUykQw0JkoXO7PAyfHlmPfPSg8Vryq2A95IaaKKqE6PN2n2R?=
 =?us-ascii?Q?Uq9vt/0PZLBFhmrSNDLk9zLlgL4XgtwTfNoX2qv5ggg4uwZxpYugTzwBlc9/?=
 =?us-ascii?Q?rwftNN8SU3KgPC/aRTVqIon+sCz3CsRxf61CpmIyIe4larcmuSVyEL1izDJJ?=
 =?us-ascii?Q?iI+g2Lxlq6vR8sUh4bU2e0Mq4BKjFlNuNjVMj1wmhfDUlZqPJ3IaIwu+B6dH?=
 =?us-ascii?Q?g2wUlYj2vIM4ixEQHlML5OpPazYQq1/BuQ8drrhsY9rtqRaNPNcEPKiXsDLU?=
 =?us-ascii?Q?4y3jV3+luWtrh3uqU6D/v9nVNSRH5P23ulVg5PTPOZ26sKFKBo6//siUOPfQ?=
 =?us-ascii?Q?b20NoLQ96Q7pdY7U/9YohJ5WlWPHaIDi0UpSty2sKsp9SUK414bGAv6jKhmR?=
 =?us-ascii?Q?NVfnAvlNEe85n6+DRAJ3bqFrN1wT7FdgPv5eTUkMo301VU+nfU5e/cBEulBO?=
 =?us-ascii?Q?O4ZsLZJGb0ZZe/zYcwRGdOHi1Nj3FhKJOY3cqDKeQelsPpMMw8TVxVUcSfpJ?=
 =?us-ascii?Q?aNC1ZIvGZRG1aASpRJtwoi6yCAbHtNk7LmzFOacCrbHbZvNyF236XOYRSIZt?=
 =?us-ascii?Q?YfMA67/DhGdjskrF+yUEUV4kXeZdY9nagFmcMHauiy9hf+xJwvVJMXWFsHjs?=
 =?us-ascii?Q?NuyqAY/QKp94QsPD2ghe+9pfvBhhg7DZBNkQ5gPJ9oHVO1nd/vJ1sRJGpYk8?=
 =?us-ascii?Q?ZW1C1NTDUJk3KIe6dMo1+dWAIo2SlKMblZuyJCSyfZ4ZvFZAkEc/aOmMQB9M?=
 =?us-ascii?Q?6e/8qNCvzQEYEWlg1k6NY9kI7MlVVTCFHhELAFZp5BKO2wUTSBf5A233llO7?=
 =?us-ascii?Q?vUQGfMD28nBJh7OwJBskfDi/OyLTfJiIVxMUqyy5NKQhK5gcOWzLL+JxWTNv?=
 =?us-ascii?Q?eTLJRWRX9VbbXYYCj1RiKbgtvZgBplFY/9uBy8XLfqzxCG3mnwb/pypLCf/A?=
 =?us-ascii?Q?2fa/aRTjPyRN5K8mWTnLUF/H+uQvdH1KC5zulR3zzQGAeDbJv527M0jha/te?=
 =?us-ascii?Q?ynnrjDWepR8EZNV66xJyz9rW+cNCqd4dz72dhtBKUQc4X1ULiks9j9Psyy3V?=
 =?us-ascii?Q?AOhs4eAmPrHZoGtCLnwRe5wzAOgEOMGVpONTufyxjr0fF0BxD4K1ui4xUwL9?=
 =?us-ascii?Q?1E0qJAJVtAC6MwuiVUjbvc/E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d131be49-bd91-4968-c2b2-08d9456991ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 19:16:36.8696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qzLgjRrpngQ3i/uJIyzSqWhRyJX8xQty5LMO8nQ2Tuvy7uy/RfQbcFahCSTc/H9D9Ryt06TlBEbJq1ca7Y05ZPwTz+ntJ2v64FVGO1vETI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7191
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/07/2021 17:02, Johannes Thumshirn wrote:=0A=
> On 07/07/2021 16:53, David Sterba wrote:=0A=
>> On Tue, Jul 06, 2021 at 06:19:22PM +0900, Johannes Thumshirn wrote:=0A=
>>> On zoned devices we're currently not supporting any other block group=
=0A=
>>> profile than the SINGLE profile, so pick it as default value otherwise =
a=0A=
>>> user would have to specify it manually at mkfs time for rotational zone=
d=0A=
>>> devices.=0A=
>>=0A=
>> Yes this is annoying but careful with setting defaults, it's hard to=0A=
>> change them. And in case of zoned devices it will be possible to set=0A=
>> something else in the future so defaulting to single/single needs to be=
=0A=
>> justified in another way than "currently we don't support anything=0A=
>> else".=0A=
>>=0A=
>> The SSD fallback to single is not showing as useful and there's ongoing=
=0A=
>> work to make it default to dup for metadata again. For consistency I'd=
=0A=
>> rather have simple logic for selecting defaults and give hints=0A=
>> eventually instead of checking random things in the system and then=0A=
>> selectin on behalf of the user. Unfortunatelly it's not that easy as=0A=
>> there are conflicting valid interests and we don't have defaults that=0A=
>> fits all scenarios.=0A=
>>=0A=
> =0A=
> Agreed, but without this patch mkfs with default parameters on a rotation=
al=0A=
> zoned device will fail with:=0A=
> =0A=
> johannes@redsun60:btrfs-progs(master)$ sudo ./mkfs.btrfs /dev/sda=0A=
> btrfs-progs v5.12.1 =0A=
> See http://btrfs.wiki.kernel.org for more information.=0A=
> =0A=
> Zoned: /dev/sda: host-managed device detected, setting zoned feature=0A=
> ERROR: cannot use RAID/DUP profile in zoned mode=0A=
> =0A=
> So defaulting to not creating a filesystem won't work either.=0A=
> =0A=
> We could improve the error message hinting the user to specify =0A=
> "-m single -d single" on mkfs but that feels more hacky than setting =0A=
> the defaults to something working.=0A=
> =0A=
=0A=
So what's the way to go here? The current default won't create a file=0A=
system so it's unusable.=0A=
