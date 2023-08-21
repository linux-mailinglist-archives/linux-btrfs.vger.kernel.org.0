Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173FF782314
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 07:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjHUFRy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 01:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjHUFRx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 01:17:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC27A3;
        Sun, 20 Aug 2023 22:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692595071; x=1724131071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Apr9deBkyRRHsesCVdbx96DFbyfAUwjMFcsv2HJFltE=;
  b=G/HF5ADtpLW0uSoxYrpOOwovGDlg//0fp7p3a13qCnu0G6X4/HX2sA4l
   JrjwRbQfHlLteTdvkKvSgDGwRqCXSkMry/0vFks4IEwnC3nWXAcYdiJeI
   PxrDd8pspzRJzUOwlUdwqJdTli6pkh2ZUifpSYZbakuTZScSlecjXu6xr
   V6SQGobSB2HAUtOd1YntrtfyL3LlydCTH9MFVRChb98bEnF6fXzxOsE9q
   ZuFUG/6GIZSy9B0d+QrerXt6V0RKLC17E8dOFGofPoEsP1uDYhuLiAgoi
   Agd9HkVEzBicgtzwM33EHoPyfcVth5YMw4aAPlLK6FXqd/uMeeDkHd1VV
   g==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="239916621"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 13:17:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSXMP0EoM3Um85ayNXaBj02a/bDNnLTIcsS17C3+h7S01JeoxTqkSUY/tM6jLRjAxgahbNmNj1fFIq3wpSVkwCntiRLW9z/gIE1cZWmSjAM8YVwKp81HMgwA32ME7eS5ST4JE2A9/ypvE/MOb9qQ7N9q5R34n01OZreoxClIFc98egRMEhbHb4qR/NGlfE59TVTn38d8AjpIQrDHf/YKZG2J7u7uyNfw02fkSj/W2eTaPe5wkh//kx7+ozpHUKIfRwz09fVpTgXMGDfhSMpY5Y76DjyyIzNP9vCCkuQtw+UPGXff6glVeh9pRcA5BWKy5JZ+pR6Cy0/ugT/1Db06sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B1sNaLsdgrN+D64vAkD+BKA+7MpeX23I58KlPG7nhE=;
 b=kPA5GMW+bIhbpHiBipfnaylzbvDN42umri4I3WzYoCzBRWj5Irj1JbDZufVuTZf+1gXQYlukQUjg9MedbZLadob0k8sdRj7re9YNdU9DPZtWyOqMupkYnqDYk8+XZYVheWOXRbhPk42ccMRnuo3IX8gxYFlhGh+emOj4swjbw21FGRMPeGRbfljAMunp8QtgYMnE7W5QwOCa8y59lBgZ1tan+NSDKGtEVIA2KfqNoIr0VOz53+eW95NEQp8S2UKvMl22pz7Up5oTc9rnB6VJgbvYRRdE27hr+nV5mcIe437M7HhR8tNqBLYFAeCEVjmCrokmFfWiVlh3CuiaEpAcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B1sNaLsdgrN+D64vAkD+BKA+7MpeX23I58KlPG7nhE=;
 b=VmV/hrXWVliOWAaNlUSjpT2LVdxJEcWq1+VIpiaQM+a8G+hVJkV2YdFkQgJbvuIRUojsJkFcvxfCM7ZfPcRBZ/S9j4ZWo1ylHqGMOu43k6rVng57zOsx0fOJdCp85Fpdbkj7meNDN+FlLQuYakSUT9phO9Nr81KgfypxUvHJx7A=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY5PR04MB6311.namprd04.prod.outlook.com (2603:10b6:a03:1f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Mon, 21 Aug
 2023 05:17:47 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d%7]) with mapi id 15.20.6723.013; Mon, 21 Aug 2023
 05:17:46 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs/179: optimize remove file selection
Thread-Topic: [PATCH] btrfs/179: optimize remove file selection
Thread-Index: AQHZ0MmKZEwH0x5eGEmqqcAZORP8Ba/wdLuAgAPHVIA=
Date:   Mon, 21 Aug 2023 05:17:46 +0000
Message-ID: <wfrqqg3l3epcktr23ezw37s2s5dfk7gadlk7shqojpsxrfu3ez@czzwwcavixre>
References: <20230817051317.3825299-1-naohiro.aota@wdc.com>
 <20230818193533.kuonbvwzvuw7eflw@zlang-mailbox>
In-Reply-To: <20230818193533.kuonbvwzvuw7eflw@zlang-mailbox>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BY5PR04MB6311:EE_
x-ms-office365-filtering-correlation-id: 8c174d7a-0426-4905-ac34-08dba205f4b0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWY71LJ2xQ3Q4HhkcU+vnaobLbqYivVuFSUxwB5CgJzdBLqwQ9OUEy1d8MoJef3jPbxTKBDI6o5mwXUie7XJEpVPiM4KB3d3U511LM1SlOf6G9Ky+F7srASXVSxfQZNKafoPmqIzd2p1gbQ0GGxelaIKN7SS/QxQu9+zweUGjicKsmHBQvftexVPjSydU6AFAa+qV/TwvBOY1VW6XPhPbAxiRq3B9J3Jp93rLngjs38oDRhR5iUDq0Cx1+Np23Bx714+veuHvOsgDJANbd/uJ5VZ2jVnY3olbXiNsfm/iX8dRKXD4seFTAiJRTq6hTa4C/CARNnazML5E4jlXbEZChheKLxvDTvpMmd7jkcddRffYtX7X21C1gK19b2sdmuUDy3QCB3BCOSxQYmC4rKPETRf2sfyPFG+PZFaffXR2QbiF81gwMlZfHNM6Tf8CDYv18Mid8FTgimY7Hjw6FHVAF8KKGBlBA9UeN7zptz626dEDpgqkUIB1GuHqQT0Z9K9syE+O95UMlktlIWhh5CQHOyV17QLj+ht0FAC+x2ayBdkS3lq7lhdNLzXx7XP18Rjt/BVDsHRXIYgvcjk2o0EJyN70TsYqZ2Cyv2l3UWfZVMkO2vfbDvXQ00tw0Q0TceoCDesvdyM1nmIeyNyMnkTcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(83380400001)(38100700002)(38070700005)(6506007)(6486002)(5660300002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(6512007)(9686003)(66476007)(64756008)(6916009)(54906003)(66446008)(66946007)(66556008)(76116006)(91956017)(82960400001)(478600001)(122000001)(71200400001)(41300700001)(33716001)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tb73rVRRhyjR7Xoe8xr04widbvmdwIfRm1X3nulI8H6BA2XVqE4/jZlDvCqN?=
 =?us-ascii?Q?MXgKt609F4vOmjEukywCid3r8B92BV7c0KEliosW0CgU1yig1zWrCQzcP42X?=
 =?us-ascii?Q?8NHf2kRgFd3Xh/gJois5cQhb9vZ4Tu0M+byq56C5psKgYAhN/MMx5lfM0cCI?=
 =?us-ascii?Q?IN0Pe1I6Wr2CoXdGcKM+xY21qvXn3ApSHsXx4h/kjQ2XNyvjyO/zigBBUSOw?=
 =?us-ascii?Q?dDyXlbSMVWfRylG9ypyrWbbrRENHrjrmjedT2aEhtYkRxpSepz3/uHwMsq/l?=
 =?us-ascii?Q?8zCUc8ud047QmzT1rM4uzfKXE13ItI69zy/Q2nSuyyMQsSRBGsZUz9vtgwl6?=
 =?us-ascii?Q?/kOq+aAneEXSJh/Otu4/m77mDRGVlKLRZnxUd6dnn5bd/hT46Ibrc2v+5I+h?=
 =?us-ascii?Q?/6SZyz0tL062IOXayyPBVHbbD+r7l8qkQsqN4NpNEc1SlSIIpM/SBqohD3nO?=
 =?us-ascii?Q?bfBF4FuwmbeJqvYf3QTy55gKWKfBVFNKjEKZxlDpgOZ6teJDcNfKC7Rf1BzD?=
 =?us-ascii?Q?R0jywnuqp7D/Yjt/ZOCXunipKcJ721i293po3VJkHUa9/L2PC0dCdgbnJp9n?=
 =?us-ascii?Q?IbaKJz7rxAWHkHVCK22ylOUM9okmHIh+F8bDnXtTR7WcvChWCT4LXq+ZFbRM?=
 =?us-ascii?Q?QaNkG5vdmNfVTgoqY6D9IATbtQghSBSVnBjQqUBbMH3Ih4EM9STnDKpZFSaw?=
 =?us-ascii?Q?9ohWbrw8jcNVku/gfrifT71GqzK9oJwxqJPU3a+/27kHpxxc03RaNoVPFx0m?=
 =?us-ascii?Q?QVWayi7pNk8P33CURSRLpv4r4b9BSpA9KV0eMJdvwZHxH73eygOF1mJ6YsTg?=
 =?us-ascii?Q?Eeqwdg83t6VKZdoah7DquqPaUwZJXYZ5vWuN/W7bFRr3vbDtRB7EGhbTM8K5?=
 =?us-ascii?Q?+x0IMUe0eTGLcrua7rrXp/JxXrzzv+XVDhPvzN2BEdlW68gLHh1izivyeJIv?=
 =?us-ascii?Q?Il5Ce4/ZWgiqMPywByeFJbXCTnVdvsjKR+HtVnwSkmrzCfR8cgHMZ97lYBdR?=
 =?us-ascii?Q?YS+pU01Gs+QLzq09XmV4D4iWdnfncoB7cHgbMfunrG2XTUTQ/JGNNvdAO6wh?=
 =?us-ascii?Q?hBOzS75E5pky12O7hL3cFdghmzfnafzsmjak9AjZxG5deFo6qsvsBN8SNDdL?=
 =?us-ascii?Q?NlATx6dZNzWguFTi7RlVTah35fhkAs3nthTBHiCGWdIN+2eAeUfVYTLWqQe6?=
 =?us-ascii?Q?af5xSQeLXqh+NfWhhtwWxv01bkeXsIqc9Ftey3ha5ucEJeyKUZbYflY9xMU3?=
 =?us-ascii?Q?3SIs/A6h9FpEKz4iccOOMU63mappcxSMWnk9p/lnVOBsi//YLOmsICjUvUZ9?=
 =?us-ascii?Q?lyNRkXOqJn0FCfVZnoMug5HI9P/HOv47FwF73S+Kt0xnFcL6fa4GvrAiaDhL?=
 =?us-ascii?Q?nvLBDpj+1xKvU1VrRVrXBBbJOoLxDOZWxslYSn4TgohO/Ckju6sqh2nR54Z7?=
 =?us-ascii?Q?LBmx/rrlMJ2C4gQtvHFNGQ6/CpBEISqSjXIBNNY1BtT2bhOjx2WHtxsMiEfb?=
 =?us-ascii?Q?4nRChf/P8lvPO8dGIX5tHB0CLTbZZ9jhrm8FqrLI3h5XrUgFJfWGAZuQIg4Z?=
 =?us-ascii?Q?oSIzkabaO2FS+Nvtc1lC9InTY1Ww17ZSJzcrr6b8Uygy4U/eBNUjx167Z5RN?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <871A034303D65C4EB61043FED3CA0F5B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UVAYYJQp8r4x3/bpRsrFGxKUVi6RBfsY3/07bycRsER9wJyPZaCVNkzE6CgOcogZmNDKnbqZVJ7w/6uFjFFss+M4E8/bX0i3Ra+3ZNNxOC25zH3av0CadQGLX5f9VL4GuUL9BWsr4pB4cT/sAxBTLA+KXN0P1Hn21XPbIh8Uq9qkPNmJ7BfYoVT/GU5Um+y3hd/FrCXOO8O+cV78FtkohBToY9ecuZ0kkWWscHqEMchWw9TwueI1WWfvsuXH1ER0MOt4q6gb6xcjcCeiLwPHype6WlmoGcMaLIF2F+7DYdFJIWKgkzlUxI0V8eh1jBTBDSMGdrsvdLr2vbbSJ3bWMG+BMLEPBz9dKTpA/aVY1bggsLhDXq1NnzZTdgZ4E4bcmzbB/Dkm21eFcdRVSCTleQQpQ0KKsAaMaewxQQkdC7KvbIOl/miR0FinIRtL65BqHiNMy43O8Q1usnko7T7qOFN+kkETrBKECLCe1Xvuc36xI2hNrBlVVBNQuxcTpa5OUO/4o7mkSTpCUjL4CA08qUuSWcSJ6IiwVP1OGLLV3CVtFhHnK3MxMCQolEvt7H+RsmWDIH9+OcF7eQkUKneYBq+21o76a9TFlk885orgu5nQ4l30Vat/mDPF6Efl57t99xJLjmvxbFgXxpTGyd6pMrRPNv7pXROCze+ad57ByjNPHKPoLIDqK4tPVXPK0u/UXtDzIX3qonlwhgn7XKzNF5NrYpLMMmj6d2MkwfaCjnvZaf797r0Kvk26/PxjEypBayPEcY6ClpXX9SVV0/aB61RA+oDs/ObqSCyoUnPKwaEA7fCEnhbD+9coqtVtrKF9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c174d7a-0426-4905-ac34-08dba205f4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 05:17:46.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80f0CJlENg+ifPLYDhX8wCTpbks9sH5RhIPgtjEeVdsMlU7S87PZlmt0M09a4uKznKpCeggGLSGQUD/QXQoPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6311
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 19, 2023 at 03:35:33AM +0800, Zorro Lang wrote:
> On Thu, Aug 17, 2023 at 02:13:17PM +0900, Naohiro Aota wrote:
> > Currently, we use "ls ... | sort -R | head -n1" to choose a removing
> > victim. It sorts the files with "ls", sort it randomly and pick the fir=
st
> > line, which wastes the "ls" sort.
> >=20
> > Also, using "sort -R | head -n1" is inefficient. For example, in a
> > directory with 1000000 files, it takes more than 15 seconds to pick a f=
ile.
> >=20
> >   $ time bash -c "ls -U | sort -R | head -n 1 >/dev/null"
> >   bash -c "ls -U | sort -R | head -n 1 >/dev/null"  15.38s user 0.14s s=
ystem 99% cpu 15.536 total
> >=20
> >   $ time bash -c "ls -U | shuf -n 1 >/dev/null"
> >   bash -c "ls -U | shuf -n 1 >/dev/null"  0.30s user 0.12s system 138% =
cpu 0.306 total
> >=20
> > So, just use "ls -U" and "shuf -n 1" to choose a victim.
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  tests/btrfs/179 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/btrfs/179 b/tests/btrfs/179
> > index 2f17c9f9fb4a..0fbd875cf01b 100755
> > --- a/tests/btrfs/179
> > +++ b/tests/btrfs/179
> > @@ -45,7 +45,7 @@ fill_workload()
> > =20
> >  		# Randomly remove some files for every 5 loop
> >  		if [ $(( $i % 5 )) -eq 0 ]; then
> > -			victim=3D$(ls "$SCRATCH_MNT/src" | sort -R | head -n1)
> > +			victim=3D$(ls -U "$SCRATCH_MNT/src" | shuf -n 1)
>=20
> Thanks for this improvement. This case has two lines have this similar lo=
gic,
> Why not change them both?

Indeed. I forgot to pick it.

> And btrfs/192 has a similar line too:
>=20
> $ grep -rsn -- "sort -R" tests
> tests/btrfs/179:48:                     victim=3D$(ls "$SCRATCH_MNT/src" =
| sort -R | head -n1)
> tests/btrfs/179:72:             victim=3D$(ls "$SCRATCH_MNT/snapshots" | =
sort -R | head -n1)
> tests/btrfs/192:75:     echo "$basedir/$(ls $basedir | sort -R | tail -1)=
"
> tests/btrfs/004:204:    for file in `find $dir -name f\* -size +0 | sort =
-R`; do

Yeah, we can use "shuf" there too. I found even the simple "sort -R"
(without head or tail) is really slower than "shuf". I'll address them too.

>=20
> Do we need to change that too? And a common helper might help, if more ca=
ses
> would like to have this helper?

Yeah, maybe, we can define _random_file() as named in btrfs/192.

> Thanks,
> Zorro
>=20
> >  			rm "$SCRATCH_MNT/src/$victim"
> >  		fi
> >  		i=3D$((i + 1))
> > --=20
> > 2.41.0
> >=20
> =
