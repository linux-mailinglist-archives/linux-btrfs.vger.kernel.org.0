Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C03B6FD6
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 11:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbhF2JHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 05:07:13 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34601 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhF2JHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 05:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624957487; x=1656493487;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5scXm96XFbttjv5dOLxcRmpMeCvTImdGNuARMJzvO5M=;
  b=jRdvBM5kBYRq2+aqOFiOEDeGNSwiw8IZAF7Uh6IbnUvLNFSgMTZCxNZj
   +/YwfPBoVrsNKXFp+/VL6+N92de34FoE84GA6Rz1bhVIAqj3q4Sh0wiFA
   EEJlNyWYnQX1Pziy2TQvazqmKKqhu/qiVEH11kTgcgRrFRz+SRA96j2y6
   Jq3LikMD2m6wyJbcBSUnU5tekc0q80cNLKHQYuBXPuhBYws0y20CzS7nl
   4DASRkUR9z+Mwap1blGV0r/yY/xcGLU78XxNyy2wqaRtk3XyVtdAf3By/
   9JUrg6wm4xbX3EIFDvquzFCicpeMfXQkjm0EQrFWZixKq4dJvv8dlFfbs
   g==;
IronPort-SDR: cS3juXIYGcwYZHbrRYB2MqBiKfkAvmeClcX8z0eJgnQQ7pMHRJrpdYr5YWCkTKs8cmlscKtbsN
 wcvyy98f2qLJzuqxpr+MDHKJy2TrkUntwD5NupC/MigCWWV40TVI6KKTTi9sXirmdCCR8cK4F6
 gsoi2hgwmY72PHm7HcbjFCs6dOFyxuPOhtkjLliBHZkyPfQaB6SbuKrP6I1W2JQwcYlE+WDA3b
 WPo1DhPmmx4rr5OrfUImcs8qNBEWNDxlMQBw33fIwA1ffWjMr8mzE2OiRJveiUDX+crJ4Ymg/w
 U2M=
X-IronPort-AV: E=Sophos;i="5.83,308,1616428800"; 
   d="scan'208";a="276973435"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2021 17:04:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoRKeRpnKvu8Yd11Li8MKtMkCQ2FVUncOjoqpsrlHV4vxmCeAmifx1A5aYleqFkf6+53DVH/wAQEcnY2vVaWvj+MdX8iFRXWGK+WjABAmIMF1XA0mEJy0DdCiHM1qt+OOEAoqTXNvCY4VKceoR1Kl+phHbsDoR7Rrafc9LzCt3HQTej4H4xEE1vkHLzdsHGK9SqFc9TjbsGZOwAyDr/i/rvQYpVCC3XA5R2a7nJ0XeRfWDWQXbJqCcLUF+VDU99c7w2mknO0Paygxw/qN6wTuF6LqNbTp9gsU/BHRF7Rf9La7MGiuy5Sl9j/Qqb+j4V5yQdzN8XWZXvcI2gaudQ0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82tynPnhZx+HYp0Bp1XLyeljnXAhjOocX39nNJVgfS4=;
 b=leTwbNGo2F/7YkAX7DioKLtNiIRS2yxscfd8Hqq4erUpM5DD3lQ8nNP0s5kZi7WWW8LDp3/b0+MpepXXghO/hmyTeR1j2JBFvp/KXeMzDAxtYu6ghsjScNpuWjCJxlv9HGGLBt5qFy+DNe/q2gb9xn2fbpozs1j1r+S+QrENXQdVnMZF2PTmkZB0TLCY+LRp3MjG1nfM/2Y9zPhcuoiHFI9IiLdteeNkKFlBUfb2T3dR14fG+6hxcrZUqlx4p8dIxrhZ8HNsAJpb9KOmXNvMG415rvU1LRlPuAb6qA5AvQO5BMumTvzSUN72O/nNZpYBwKRB5A0XBSk4Nq5bmPuiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82tynPnhZx+HYp0Bp1XLyeljnXAhjOocX39nNJVgfS4=;
 b=RaKNgKoWBL/wL0kpBBHKrwrsCp3AnmCAfWZSFn6KvTFGsq/Z1sjmgoG9lYDyX5n0WZun9PonXPHWp7Au5B3YxUL7yyevcQ8Wp8+eGpiVz4zacuWT9RYL48Gc998cs7CRM5sRyuXs42DTyLAV0nOdBzP3BwNOmO9A6n1Ew/tyrwA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7269.namprd04.prod.outlook.com (2603:10b6:510:1c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 09:04:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 09:04:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "lijian_8010a29@163.com" <lijian_8010a29@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lijian <lijian@yulong.com>
Subject: Re: [PATCH] fs: btrfs: extent_map: removed unneeded variable
Thread-Topic: [PATCH] fs: btrfs: extent_map: removed unneeded variable
Thread-Index: AQHXbMQAzBmALZ3G+kSY1PzHly/n7g==
Date:   Tue, 29 Jun 2021 09:04:40 +0000
Message-ID: <PH0PR04MB741666CF29DB96CF0DB0C26B9B029@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210629085025.98437-1-lijian_8010a29@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cfdfd79-ada8-40c3-5694-08d93adceddb
x-ms-traffictypediagnostic: PH0PR04MB7269:
x-microsoft-antispam-prvs: <PH0PR04MB72690687B133C05E6117F1709B029@PH0PR04MB7269.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNJH0s4Jeh4stLtBsQ+kKIDftQ7arLWSBBCBzlU2nZ6JufkOVWfous5dTyfxSUWzUP4zxXmMvoRqQwnDWpsLMG1TjqbSXtakbx7N5n56XFkw85V8mFvOzDFjjVwWT7Q3X4MNW3YhrukEQY/XGNgjZn+VRgl7PvUj5utG/xFmmQbPEZ2xa1gql66K6JulAqawLYCRCgojQF9kjdnKSx3loZ0YQjb6n8agEJmeKkIk2b87/2vMUZr5jPRE1prTscJp/fr3ZsqJMllyv1wX1ay6pNN+1svV9x62UWMTLnCKDp/tuVeJOeppj+Q9vfQwn6wKYRipMeAG1v6bf23OJxck+7wWbchRlics4/meSHMjYaGrbpdpkVzBv8fYw0lWBkvRM5o6xqcTbC0GZVVkJMM+gW06VVVgv0dyolpsljjkTluSlwRQbMiAh894CHOz+pPhAPB6Ra+kxEs9lF6f/JQvo95M5mB2YS+T0n7aG8q98fFK+O4r457V1WAj2uoTcTPsAYpzVJhiH4/eh5AJ1MET213s7fP+F6EiMIPF84Pdiq4aRzrTqb5R3fIn2qtSk4u6qdM0VEcPhSGHde/A7sH2WHmjq8qvcqzDdThqdy/6ABQ9EMS/ivJIOCoUaka5odju+1vCTrBfaXXyiz/gAEfIqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(26005)(86362001)(83380400001)(76116006)(54906003)(38100700002)(8936002)(66946007)(4744005)(316002)(122000001)(9686003)(478600001)(110136005)(4326008)(55016002)(52536014)(91956017)(7696005)(5660300002)(186003)(64756008)(71200400001)(66556008)(66446008)(66476007)(33656002)(2906002)(8676002)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m2E9L95qH+RVT4i361uo9DOA+2+ts0WoFoFGo4gvayXvUQAQDSvv7YRA0Mth?=
 =?us-ascii?Q?jEYvMpPoliMM3vsG8ZHIGAaGHWgO8EwZA5jFYBPl2AxU5RNEKBF7rqnPsg3+?=
 =?us-ascii?Q?+eysYy5vctHcbs7iVuGdWlCsp6EXijxxlBrkW2e0URcyORPYd/soV019hwNP?=
 =?us-ascii?Q?ztpFRVy/qO6hQFTNwpa72z3H51ordoU5cMTqxxUay0ujdDNGbfH1AJXPhJJa?=
 =?us-ascii?Q?XgJPWOFDP8SmFnpO6u1U8iB+rZbiek4LGYXIPzmJ0PXRGaVYebsRlyLcmNQO?=
 =?us-ascii?Q?cADIeYJeXnNAhtpXrxnw1xvAiIuUsCC6s/ySTyie8kVwTBk7U08+Ry0ptTPz?=
 =?us-ascii?Q?oM9j5Ycd9yANFp9Pixhc8a/Xc4eRWrvpDAFZ+9CfnrZ0tXE6AzT3H1ynaB5k?=
 =?us-ascii?Q?b/8V7P0vV3l4z49BFzhM6+kgCD/Elu1A4y3rwFWPDo0GKZxjy+MDhFD5kDzY?=
 =?us-ascii?Q?i5KVgWtXS07Y9GO//HDCqOcrflMrOI1I3Alpyu/5mJmidFpJnkwF/fwbg3M5?=
 =?us-ascii?Q?KWL7jo1Azkr9UkUHfbO7gXARLaInCbVl7+ygLv+dg1fRmJ5RlH7S4kHI4jvp?=
 =?us-ascii?Q?3u5ma6Pr025r1KacfTkihih/rE4sAaPwYjfT5LfAYvwQsE4hV5J5YECIQuWS?=
 =?us-ascii?Q?0cBj5WpTRdroOQ6QeMQbtpqWDP9JGpI9Cv5uaAvdNZ3alcZVSnyTHaY4h4jY?=
 =?us-ascii?Q?gZ0JqppjihlzGwMZkgpIwkz6dwdl9JcPW/61CvAqJcsXXcd+AZylaIsgoUPv?=
 =?us-ascii?Q?pq+tEslHq0vpiIVEByjbpxR9wQvl6IZ+uDd/rjtDWxG90SXeit3jOynZUaag?=
 =?us-ascii?Q?BAEO68FfPyK4YummxhZwRgbASNi4qVdQGzPISSmKmQwyQY2/yXbnpY5WqRXP?=
 =?us-ascii?Q?FKwnAuGTJmjjKzIdJxrZ/xm8Ipf63r5PXeRdynRUEly9/PL2rMpZlkLsOL9B?=
 =?us-ascii?Q?ANNRBVSZ2qEy0yhB5nXWNXcKNlDIvMa+8yhfqVAs3cUHepKFzRsVed8OZl5U?=
 =?us-ascii?Q?ZwWibHzHN2FzwaBkujs45Ot6nBzkwDUJaS/oCSxAbK/pth25zJ0+625RvbwQ?=
 =?us-ascii?Q?ui8pN54zSrr4iK6BVoy9q/mFydhRIhJ2wk/NOPQyEszwhGvYA7487YQK8Tyr?=
 =?us-ascii?Q?PXO1w99sJWFriuweHCvVzsIrL+7AbXFpzlw3ulSh7OmOUBoAXRfLqTTqvw6H?=
 =?us-ascii?Q?3sYQnsx3BWsRpo+bRfa9KD3m2NCPJSoNahglGYkeA9VwGUCk351grhX/dv+T?=
 =?us-ascii?Q?s+olzcerp72rzUD8xPhPR7EoYcn7Ia7tamSq4MLXFngG67JQCr3BcS+iJlM5?=
 =?us-ascii?Q?Tlw2l85lN2KfxfxwEZVhLg+n2xc/GZW5/AYIDm/I4XasAg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfdfd79-ada8-40c3-5694-08d93adceddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 09:04:40.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szguCjZiS5l2IsxCiCIlOh+Q7wLU1+pDzVjdPKwut2TNd6CPR+E9RzN7o1Bg4J5oDPh7JA9nzjVGtPC4a+EcbWWjI6n2cXbB76jRVT6sIZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7269
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/06/2021 10:51, lijian_8010a29@163.com wrote:=0A=
> From: lijian <lijian@yulong.com>=0A=
> =0A=
> removed unneeded variable 'ret'.=0A=
=0A=
Wouldn't it make more sense to return an error (-ENOENT??) in case=0A=
the em lookup fails and handle the error in btrfs_finish_ordered_io()=0A=
as this is the only caller of unpin_extent_cache()?=0A=
=0A=
I've actually tripped over this a couple of times already when =0A=
investigating extent map and ordered extent splitting problems=0A=
on zoned filesystems:=0A=
=0A=
	em =3D lookup_extent_mapping(tree, start, len);=0A=
	WARN_ON(!em || em->start !=3D start);=0A=
=0A=
Maybe even turn this WARN_ON() into an ASSERT() when introducing proper=0A=
error handling, as we shouldn't really get there unless we have a logical=
=0A=
error.=0A=
