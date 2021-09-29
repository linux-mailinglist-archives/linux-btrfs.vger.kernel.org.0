Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7017541BCA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 04:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243759AbhI2CWq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 22:22:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30418 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243226AbhI2CWq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 22:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632882066; x=1664418066;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=saAiNBMWDmU185+6GsE6iYO+AsffnVcmIFWu2bjM+mM=;
  b=rtmbavKxXmHoYOWGofupG1H7NduBP1v3GPSiUTAudAeZHVGhdeiVNDFK
   T2bQCIUzkFnxt3DiAfVzF4OHS4oGRy2iqHOHMwnK7HMdTPN7uhzbjkqkC
   405LNu2Co6+eCJKn2BTqN3z+EvITXapfUx/JfbTvnGzGnK3ctPv1mAoTy
   wZVLQYHZKHeTFyGn1Cs1zWpjuUSa2T887idzT0tYVTeAVYz3wF4fvqx9j
   6trt9r/yVt05Zhglr/wn+BoTVzLek4wRvilIjrc29iqaFYq++gIMTIg2i
   lufAHxq62hLYYxc1XWGjb+LarPp8JAFUx3tIt5cuHsuGiVzrVqSX5Q4HX
   g==;
X-IronPort-AV: E=Sophos;i="5.85,331,1624291200"; 
   d="scan'208";a="181857384"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2021 10:21:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayKIAHavOu6OSmSvj+uOcajds0RNvmsElO7bjM4OcXeVoRHiTIi6ct6QlPLYsrHg4bYXRGVNTuN09YBYvKXGTbti9Gp6Rcjffy8jbjGJA56oh1LspkLsx+5jXDPd52tG7764KHB4qqH9dxAV8+XNvBcGP2L0dYns6a8Ot2QJjpVjtKHsSvKce4ls1xiiolGT/RC9fjtM5lxD360uKVHHYdCCqndWLew4O26d2Di2vSbsRLvIG2GzVNWL8V+cICQrpg3zJYnxJXs3X7/lJHplWTJmGHWl4Ps/LqBr5U5V2BW4oFNczptOdrzL/KfkVOiv8NopYFPKnCcD9gtcLJ/VaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aT4QJsfKVDnKHzFgw2aD5PZhFnIBz34g1pmw6HhCd3U=;
 b=Cny8jNKeTSK/spWw7+uCPYKhMPoZlECcsT3073+COZw/ZP5Y0or4fikI3xtlwn38TN97vb3VnNDWCw9h2XtyfATtZ09O17In+A3TyzdjU08LQ62X+CMuGiH+SHFmVfal78Yy+ohHe+COhRRr+YoCtbmPO8GLNSkZJE4dvhpkI0fe7sbzeZN7JYvT74zMQh7fuFegmp6Pl1/boaWW8NErFHMYHQ/QvODapZNajva7ZZILD9HUxWeAhdcBoCX6B9aTRaqkxtU+NxXz0TX3oH233L4ADKss26Hg/kthlxIRaUrpuhMvGmSkmx5yRxcwoF6wq37jXrnM/vAgZ7g32k5aQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT4QJsfKVDnKHzFgw2aD5PZhFnIBz34g1pmw6HhCd3U=;
 b=hgZV/B2fHwFvNEDJ+s+SsFFAyFCHmYTP9p0w9vLtHCNH3XRXn4sD43YW8PRcoHZkmqsAaLc3MwXlpCMaRHU4zXESUMwPFFiSq2eCxcAqLRrhufWssQ8PUnvv8n3TWT/6u9bKLSlYH7XT59vYSgiqPGuzeAwbemJj3aEcv6i8ybo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8423.namprd04.prod.outlook.com (2603:10b6:a03:3de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 02:21:02 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%7]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 02:21:02 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Thread-Topic: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Thread-Index: AQHXs1ZmcoYKRsLonk+Yign1+z8S5Ku4RGoAgAIGM4A=
Date:   Wed, 29 Sep 2021 02:21:02 +0000
Message-ID: <20210929022101.h4v7q66xhhjvy426@naota-xeon>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927192618.GF9286@twin.jikos.cz>
In-Reply-To: <20210927192618.GF9286@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c435b858-7397-4ec6-2428-08d982efc8a7
x-ms-traffictypediagnostic: SJ0PR04MB8423:
x-microsoft-antispam-prvs: <SJ0PR04MB8423966FC3C5D7C7D31C9C7A8CA99@SJ0PR04MB8423.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6h+6UuGyCE6CnwV7kjB652lCOGMNej3SxG2NQmZK94/JrGUtWjtHVt6U5XzFtSm1MvtjtuqwtNbnYA+zhX89iHmHubswccYQFkyAum40qmbeYkZVkcNd18GH1T4bRVShNptbYA3nPNGWD/oA4z39YjrvtYW4CwkbnxF/8r4Wb/HpTKzUNMV4xfP3RXDjTCLV1YCEmEYIH8yQqxHcYneplyigVaOUc1EUGNBEIGZGDTtKKnKSPZQDhj7l+VggSTnzByJ94i+mnNHCdQ9nWPATvrEJWC80lag8pdjzfHWzojndfHUervCdSO5TA9wLhuhs2pOiB4dxG0OOfI7HTjYYA2/Uska/HWiXuOUYpBFujHx3u2LT7nmwhlu85tYXJS+qEjmB+G7S3kdJIow1JT4gRM42ccwxB3Z7P9VIGTFZpG/AdzdOBI8X36vIk0ZQPNTC6GrpKtttz4eDjIG/vhOsvZ5OrT+F3CMJ+01kAMKGZeTYyjffKPoPh7TvZv+XmOYuOdazXyODKQjJI/K1HUkZPB1olELFPTKgbCGKRdqCoD+oUwAf1UHuC3OmM8UWvuPk6Y3uIhfexD9Z8ROkYjHF4jC+y+1NiuDZS1pmdlma7FyGoPQKl+jkTuLGiIjuMhb6mVVDwpHUQ0LIAKoNfSgTEN39ZuuyaP3ei4Fxc1M9viJc9Rul3YOmmEQZynxjmLiouer9WuIaZEVG36EdDxsDN3yz1dRTRyYAM+bPO5FQzRiK4EUwN4Zp6DYvg5DsgXiq+dKhDaa04Vvpi7D9MsnOnnU9SOluLXAtJjhZFuuXvm4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(76116006)(122000001)(66556008)(66476007)(66446008)(66946007)(38070700005)(91956017)(966005)(33716001)(316002)(64756008)(6512007)(9686003)(6506007)(508600001)(186003)(71200400001)(26005)(38100700002)(6486002)(8936002)(110136005)(5660300002)(86362001)(2906002)(83380400001)(8676002)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9KzV9Qe3P5kw6sDMcpH3S18MupBv2Ymc/VAkhLZK5XmgnjNY9X2l1DNF83DR?=
 =?us-ascii?Q?xpLEnebWw/d1DTgVA/dAXjfbItONeSLLZi6pbEVgOXx1warYkrRsGPFJ/Yrn?=
 =?us-ascii?Q?drVY/86Z8tnnZtNdSj8KROiszR+B2H4S3CWqQY0MxVC2CvX5unwW4AcvdBoX?=
 =?us-ascii?Q?+adgMnHU02UcRwpFiOVipoxS9J+6nOu+Cop9jncyegReLhIsuzEjjqgQenf4?=
 =?us-ascii?Q?Zdxo02iZTTieFJwr7dfo2ulVaIB+4oR0sfM/AMOkvm4R9MKG9mu1eq1JUNrA?=
 =?us-ascii?Q?7SZag+CDM4JMFcZdwg3yAiv5hOaDBvtNKWEaenoltipcplf/M9a5kUBO3X+P?=
 =?us-ascii?Q?wuxCTar/LPt8tySQ4ChaNTQhGbi1lg4yJHUSQE6Yej02OrvvCFtL6zp1Y+fq?=
 =?us-ascii?Q?SUS9pnX0cYA6vJFbCP34oKCPxqNYVQneicB0jV97ajkA+KJYdTxeHZniSxfx?=
 =?us-ascii?Q?Avsye5WhtZBwt7Vz3I/2pcyL030as05j0slFfLwxFxIU+SJy1Yg2iB7K4OFF?=
 =?us-ascii?Q?r7Kl9dI1iujd0oVDlQC/zi79OX2g0GVJMw/S85YGABCM/sVoBknHRVsiJfEi?=
 =?us-ascii?Q?yNOvqlB/lT2z3eRKBM9wNd29lRbZLHvyyXeN0SJIkXmTF/lGIX0KV5bsXzCT?=
 =?us-ascii?Q?IMnCksnmlj0pVt4KJMAiiHhCV7tq/oRlyLQYZHKOMMMRWpgXnRUjb9Ak6SKe?=
 =?us-ascii?Q?kOiGosXfTvsJMOq9VlqG2/mQt3W1nYJFaAh2RCRA/695hZG/iFBOfz6PtSh8?=
 =?us-ascii?Q?uYIzXfLId8eijFaLSPnX6kSTeX05qui8187iEyj8tXsNgtwjEhwcSSz+wBgR?=
 =?us-ascii?Q?Tc8DWbpHafOtOF5xo5Q++X7xtjp+JZaGvWpM7/HiTNrouGO85HFRkMIcCP3E?=
 =?us-ascii?Q?L/pxymnAkvYaNxjPCF+uvZT8avXkHnP7o6dIOoir794a0VeH+9FHJwVPTngO?=
 =?us-ascii?Q?Anf6rBj6djFR5MePlDdJznG/kbAtsVUwGDYdNwrFq32Wh5P2kpMRCX0DEFSa?=
 =?us-ascii?Q?1yf/Hmah5dmrLQvDb33DvMASkxtz7dCpvNgv/4BSkyWHO0vXyJnHAz296r60?=
 =?us-ascii?Q?T5bmi3VDwZN1L2+T5LbKmB7MXLJ48DMpC8IsBE14SKEmkucSo1jGtP/hwhlf?=
 =?us-ascii?Q?LTbGqQnyicXWhL6N0XnrB/6OpNIPwf+CPOPoOYSLuwGN3aagYHBZzApULsoe?=
 =?us-ascii?Q?2/tOjY1ZCOJEOZSZtLWUsyzLNO5ZrhAFGSMbOO1LLpjo1rME3R2n+tpUj5ED?=
 =?us-ascii?Q?XlmkU4e8djA30IUM1aHGgMkPwlW1bDqZnf6LR+R3lKA2CrtpAu5QnsXlyljB?=
 =?us-ascii?Q?uXymnC6Sn2Vs34XbNhKZEhBlJN29aSfHLj9vQ79jWBz87Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A85133C2F90D374D8F0A0C42EFD25092@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c435b858-7397-4ec6-2428-08d982efc8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 02:21:02.3562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tels2YEXN/K5EUZ4kzPlf1ZaNgQ1B5JFkOCqynMIegWq17LD1WjgTQ4m+FfELr7AfvqHf5sbIJDpsi6Q4Xf1dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8423
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 09:26:18PM +0200, David Sterba wrote:
> On Mon, Sep 27, 2021 at 01:15:49PM +0900, Naohiro Aota wrote:
> > As discussed in the Zoned Storage page [1],  the kernel page cache does=
 not
> > guarantee that cached dirty pages will be flushed to a block device in
> > sequential sector order. Thus, we must use O_DIRECT for writing to a zo=
ned
> > device to ensure the write ordering.
> >=20
> > [1] https://zonedstorage.io/linux/overview/#zbd-support-restrictions
> >=20
> > As a writng buffer is embedded in some other struct (e.g., "char data[]=
" in
> > struct extent_buffer), it is difficult to allocate the struct so that t=
he
> > writng buffer is aligned.
> >=20
> > This series introduces btrfs_{pread,pwrite} to wrap around pread/pwrite=
,
> > which allocates an aligned bounce buffer, copy the buffer contents, and
> > proceeds the IO. And, it now opens a zoned device with O_DIRECT.
> >=20
> > Since the allocation and copying are costly, it is better to do them on=
ly
> > when necessary. But, it is cumbersome to call fcntl(F_GETFL) to determi=
ne
> > the file is opened with O_DIRECT or not every time doing an IO.
>=20
> This should be in the changelog somewhere too, the last patch looks like
> a good place so I'll copy it there.
>=20
> > As zoned device forces to use zoned btrfs, I decided to use the zoned f=
lag
> > to determine if it is direct-IO or not. This can cause a false-positive=
 (to
> > use the bounce buffer when a file is *not* opened with O_DIRECT) in cas=
e of
> > emulated zoned mode on a non-zoned device or a regular file. Considerin=
g
> > the emulated zoned mode is mostly for debugging or testing, I believe t=
his
> > is acceptable.
>=20
> Agreed.
>=20
> All patches added to devel. Would be good to add some tests for the
> emulated mode, ie. that we can test at least something regularly without
> special devices.

Will do. We may also add some tests for zoned device by setting up
null_blk (provided the machine has enough memory).=
