Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008EF272962
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgIUPFZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 11:05:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64127 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUPFZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 11:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600700725; x=1632236725;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QAA9Lo4FCxTQf0EXW3MFtn1AjumDQc22mNFtI2GN9+M=;
  b=WOodyuTQlEl403VQXtXX+l0l1I7Orb5qirowKyhgEESbQ36R+HrsMpPA
   IbpQW9ajMZYc7kCBa16K8yAyBDxzdkthGxwMyZskdMe0XhTQppKmtTTM3
   qPATTLFrTMLHx7ffFqAVFty6zUUr2FKSOmXKTjxHryhAPeX08ZTvqe5Et
   oU4qJINF2VpIioUKk7Coi1upKDMhh3cj1ZiCR96MwBOqdfhPbyN9T4uPg
   OSzlHk9m4c5Wj9/So9yYvmeCBtfbwUXw0d+cBS6xW5H6B13GBvBRNGldd
   wqV+mOUwiz4SPMNrZFvKSk9g8Tm47zQvLgj36ggicfgG+eWWzJTTzRoWu
   A==;
IronPort-SDR: WV3nGg2GGUaq8GHLTfXwqEbIiZ/21lYiKTwhbOh9FQhfCR+IXLx8c34khIVIc8+vD1yV9go2ng
 1eQQIuWa4E261G3qEXg1pevZ17KOebZFNQ3tXDTG0wb7XizEfGnowyM0vb4yD97BWCfSTIXL5q
 Kkl6m5YgotYIcckgRog6Xc8qGTsVr1vYLLf4TrtvcGGZwQII7dgb36YNGoe6WjBmySj+kz3r+1
 yACVmKIB+3W/SpPjvaH4msSSx4v5rmWSj2ss2CT56sjuY5HOSRB9Nu+yxXHY5f+4kuagWIG5w3
 zkY=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="147913423"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 23:05:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkTZsKDave8jX2CGTGqMv8SQ8TkrIMyKq0NpyYcO8EszceWV67on4N0vsNlZh9XhQVoOdGnZ5fWThAt+Ephg37oqmrcHSiUUb0uBnhpoDch4/AW7jMm77q4wpz/ZOUM2syyUD0KbcLuSzBt/HZosYVNI/seC8EtF2X15EUXuarr3+bO0tkGHQZtqwQlm2BVdxxrVXSojiYaYM2XfDqF9dI1s78VZ7C75OkERM7ymvqxxN6GXbx4W+i9N/srk5lbNA8cGJAjm41/z4zy9m0+0NdxMGTqS9nqtTxooAnkpTzdSx/9nVLjd9W9k/jGjqxvUbPjEDEJ9hOF5bHuja2ORvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgRHUuhV2TLBAMzfo7vHrzlEQ5l9EHaWuN3Pkehn+AY=;
 b=BbnVZTn23xzzEuq/sdX9hVEBT3vhpv2RsIGQWszbMUITGKPKLwSn4OdC0tQwk2avpvwB/iR0kn/+TVuvPk5/gzk9S6lO97AOQbD5XpksaPGB6D2RfKyrFb82p7kBOe67p8tavErg84DaoVBYrxbMiV7CEgH3LXtirek4lTRw1SZObQNwPlJvXY33gBnwmH0Atslj0c7PC+ulHdJk+JisJIVZu+nlJFSTRIVwBNpMYKmzVsY0tIMIUykgsKNqqICFudimCzDfMZpPQCEmJQb5JFcr9r5y1t+BpnkPzsdbYFVn+Ws9ks4TiqpxXc7abWByncB9d+2qpLEAasGhUjq9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgRHUuhV2TLBAMzfo7vHrzlEQ5l9EHaWuN3Pkehn+AY=;
 b=EySIe296Jh0vTc68QdBma/RYOluwVaXXzdJkc0WBwOsIRQcBVcZ9QtzYJ2UNwZJQMPCs/D5Blq6b9QRq6pjmA4E31m9k4DX25rOAUkvvkBCuy/61RZ9XGxgZiWUFlCNscc7VWXyXuaQeK8YnwVSbR6ZsjieihCwz59HRPiJs1KQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4605.namprd04.prod.outlook.com
 (2603:10b6:805:b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 15:05:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Mon, 21 Sep 2020
 15:05:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/7] Remove struct extent_io_ops
Thread-Topic: [PATCH 0/7] Remove struct extent_io_ops
Thread-Index: AQHWjcB53g1kEfBlTUeDrNbnw9XRlQ==
Date:   Mon, 21 Sep 2020 15:05:23 +0000
Message-ID: <SN4PR0401MB359886867ED0DFF2BADEA2709B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200918133439.23187-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86f05108-e623-4bd1-4aaa-08d85e3fc412
x-ms-traffictypediagnostic: SN6PR04MB4605:
x-microsoft-antispam-prvs: <SN6PR04MB46051E152880748F754866A69B3A0@SN6PR04MB4605.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9C/d9f0EsUKB9Au1B+csKAP+DskRS16lv3T5KeG9keVIBctcx9IVgxnD+ODJ/wLIb+lOBsDycL/QxnxdWm9B9OleyikAPfGP3llkjlbm9soqgKzQ624ukxeMAqiPNCUi9Cvk4Gi/QrHFNeHPZy63M9Gdaa598oA7hoO2CvuinlBSswDiNkBcPdCBki47r+MN3zadWfMlFsSsCLWuqAR4S5+CJMx6eu/hTYFAhCPNPqyaW/qZcn6BeKFoOeujfga1C8zUk1Y1lQwgFz9BXd9R0tEoVNU6soTonCPPZsUJham3LLkFqpn49HlZqKUZ6+N2YaMl47EGX97lkknuS9P9cMC78CKvmIO8gryOt0smg1xa34Jt67jn7GEHoct3Suj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(26005)(86362001)(316002)(76116006)(2906002)(91956017)(186003)(7696005)(83380400001)(52536014)(8936002)(8676002)(9686003)(33656002)(55016002)(5660300002)(110136005)(66946007)(6506007)(64756008)(66476007)(66446008)(66556008)(71200400001)(53546011)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ehiqAO6FrJ9sjorniCkirpqDnwTvjQJwgbu9seY6wA5Z/VKsZFrUOxXZDOiOCODQhp4nrTeKryhvOFJSzUF1bIGnmc0b7kMrPxuuhhhqVkq4WaorNKDCJiWK84iiV9lRmge7tjTnPLsgDC9YdxJ4eW872rmq/6dxy4o1yrUG9cAI8IJzcuULQmSvFhtDv5WluqZKQfpygcWTjfh6EDnhj0wkJ3H+2qDdeO10NJIBt5wz2nJ/RUDtGGn5GaIN/LqKqT+8gkFu9f0PeLfGOstqDiB6UFh/W2vc1DlTvRqkPlpflp4w2Zkkf0YVTRvwBvjOW3fM1CvT9KY9XeY91Ts7dWwhwFZKEPTeyOU5NqTkC+5jlEGQrheCsyZlidCoUZUUQdmBZCzGuVqxR3eknWT6C7fSaO5eNdy2cu/lx9QZvqgSNURk2EAybisUL+/+QSYqwuReej4ZbrdPfIB3Od5ZRzgzh2Tla0JrMLAvh39eNqW27/cRqDKjzH97ZMYzl8Avdg7R//QlLT6HKKSRNydGpN1QSmSaDURtYOO78YVhrCMpa3rtmg/y00+mcNu4W6zEt7oNozHY5cGch/nfazSsKLEOO/YW8CACS7XyyWYXcdO6eYhlAWC/YcxvCU7ev39UMXI8e66bj/j+q/opMeDddA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f05108-e623-4bd1-4aaa-08d85e3fc412
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 15:05:23.6849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNq0WZ41pp79asrCsz+I3vPCSfh7blJdvFRyPYdBmS8DBwVbTH40rnwZebJ7dsygjYS4Ge6AepFlWQicr1i5phjbaoQDTfDR7I/HtsxInjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4605
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/09/2020 15:34, Nikolay Borisov wrote:=0A=
> Finally it's time to remove "struct extent_io_ops" and get rid of the ind=
irect=0A=
> calls to the "hook" functions. Each patch is rather self-explanatory, the=
 basic=0A=
> idea is to replace indirect calls with an "if" construct (patches 1,3,5,6=
). The=0A=
> rest simply remove struct members and the struct it self.=0A=
> =0A=
> This series survived a full xfstest run.=0A=
> =0A=
> Nikolay Borisov (7):=0A=
>   btrfs: Don't call readpage_end_io_hook for the btree inode=0A=
>   btrfs: Remove extent_io_ops::readpage_end_io_hook=0A=
>   btrfs: Call submit_bio_hook directly in submit_one_bio=0A=
>   btrfs: Don't opencode is_data_inode in end_bio_extent_readpage=0A=
>   btrfs: Stop calling submit_bio_hook for data inodes=0A=
>   btrfs: Call submit_bio_hook directly for metadata pages=0A=
>   btrfs: Remove struct extent_io_ops=0A=
> =0A=
>  fs/btrfs/ctree.h             |  6 ++++--=0A=
>  fs/btrfs/disk-io.c           | 20 +++++---------------=0A=
>  fs/btrfs/disk-io.h           |  6 +++++-=0A=
>  fs/btrfs/extent-io-tree.h    |  1 -=0A=
>  fs/btrfs/extent_io.c         | 25 +++++++++++++------------=0A=
>  fs/btrfs/extent_io.h         |  5 +----=0A=
>  fs/btrfs/inode.c             | 28 ++++------------------------=0A=
>  fs/btrfs/tests/inode-tests.c |  1 -=0A=
>  8 files changed, 32 insertions(+), 60 deletions(-)=0A=
> =0A=
> --=0A=
> 2.17.1=0A=
> =0A=
> =0A=
=0A=
Apart from some nitpicks,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
