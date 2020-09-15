Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30F726A0D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIOI1a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 04:27:30 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16078 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIOI13 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 04:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600158450; x=1631694450;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=F5kysXEwkyNMb3XS4bgZdnCc1hPY040Trlk4JN++6T0=;
  b=AJhjv/8SlvL9iXkDJeqzPi84Dr/jJ7jAScrYwDkLcecHnZO5EpJAmk9z
   joChGQ9qPaJbsajuIrOuTTunHushdmDTKddEEj8KJp9seB2p7ctEMHeP8
   YgjhKh7GagGkXskn2o2+6AvW2TD59MI1QmRxdIuoM1573/Y1RuRqB/Emc
   Qgsp5UgBvaVjr2S2SXgA4hCAcGxOyjTrih+D0XxOnfuRsa4PUSXs7HIJq
   jaG/O176eQuXYSJbxY3MjnH1S8kaDMUGgdtPY26w/VS54XqG6Rq2OVhy3
   3Zm9D023OP8K2vv2m68QP/mdcw8BcR1A/RlEObrk7VbHbXA+v8c+SLJwZ
   Q==;
IronPort-SDR: KMnyzgSzHsLfBO1mnE13Lulr/lJK0lqpr2/Kt9U2meM7WAdTBUBRoaBPcajMjDeYQyf4b0vjIH
 oc/nDOcgZYiyZcWzrrHfh0UdXnPoBVZwZBZ1hPwBEpnEkwYXbmOvxQxFmtp2+S6IxzWiWlbTBM
 n1Q6cR8lA/9B8IGVIgDv7EuuWhJoGd8HXvy3ZywRaxBAHZWOGXJyl9LTERpEKs83py9EHyhZid
 EVOba+a6b/z3yaKUfg67rOzMmmCo9NC9NysjcYbvT7kBVGNPo6jPa6kAlwQNWSFsMKZbD7OUdO
 8V0=
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="147411226"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 16:27:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+dVMxsYsi+Fdoas+kdkfb1vaI185/7qdcCG3YCQKDTJqhjt8RSCehcylD8zdxgzb86b6SM1wybKXLSrGt1OuD4g5TkmGZ6E7kk+5aMl7io0ko8QVRhrYs0EpAP81iLlh2GzriuaaQWAkKDxK4rM/jvdfGvX8IdY5Tnpdtup4Zx5oPEl28Av77UqoGKShvScCLNeJf0Q0OU31d3KgjX0XHCxdtqDIaoL9B5Lp3izREc7X/3lWwILaMYqsgeKtQJMoXnV/g2RiGcr8GNj6RlO+elK63Toub9X8g6Wy3ft+oosIRjzocBCjaowKplxgQWE74ztIk88DVSkb2FxLJmJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4VLpDt79YIy5lGukxlxv4vYUZp1uqXX4mxOznb4OKM=;
 b=lVP9SZ+nn1RSiioWMAybbYt3d4RusTCtOh5okZXmWtcM9Oa3cdOjIjJUmTuWk4YRnsSBvjFJuqGYYIgSPXwK8E/fvvsf5Qa6IvV99V1G2JJfF4o1n7FGv2LtwJSAcecxUpGJOC/oLiHXrwZOuKpN5HsgR7xDtkINLqyCliDII2eL1k2VPVGPSi5gG/IKY36KDlIanrFBWUfyiPELmg3bkZbnPN+CQPU2Blp6T04XwCCf1WmkKVU1YHRGgv+P6tlYT5LDuObIsdHHLt4+QKDlOjPQmvif+1FyaztdXa24FxUkyt/robPULUviUCLQvbn2co4N0Can2Vs6wORmf0izfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4VLpDt79YIy5lGukxlxv4vYUZp1uqXX4mxOznb4OKM=;
 b=Cyx19zMNq1HbhEhFKs7X9vhwN+5j27kZbG5vNn/TZjSYa2PFSEmWZ+KVxJPYskhb+eSmefNbOKdax3IHChFCWoYwg2IuCQBCIMuDuJy7qTZ8YEzyBilqTrL5S3/Iu+XbUc4x9hYRMVOGqKOsBmKXO2ukcqAMOqBoZ4f4osgj8Hc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2238.namprd04.prod.outlook.com
 (2603:10b6:804:10::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 08:27:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 08:27:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 05/19] btrfs: make btrfs_fs_info::buffer_radix to take
 sector size devided values
Thread-Topic: [PATCH v2 05/19] btrfs: make btrfs_fs_info::buffer_radix to take
 sector size devided values
Thread-Index: AQHWiyIaFB5Tct8Sd0CX7t+FPfvMLw==
Date:   Tue, 15 Sep 2020 08:27:27 +0000
Message-ID: <SN4PR0401MB35989CC0C4C17E2FA93A2AC09B200@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-6-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c64f07d-f050-4903-d0c4-08d859512e2c
x-ms-traffictypediagnostic: SN2PR04MB2238:
x-microsoft-antispam-prvs: <SN2PR04MB22385C980FF7C59CC79306919B200@SN2PR04MB2238.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lE5x+JM0v+5USAPKS89DC7Jz0l8FmTd/uhelDsyJ3xh2dvI39wwVU9ky2A4cMjl5kRibwTdYsTfhA5kIn9KoGs1TUgWLf6JLW1JcWjCaErBd4x8TB8EJ0h3iWYS8iI7SLed94dy0rzLYOl1bTdjod3ITWEQ6RwwYWVu7S8PeVJeey2JLTDrkSx2IwWqAenK59qMiaAkkIFvR0YFDyy7NAtU2DL1NRsWYD8Lcwp4MXNYC6uGRQpTF2QmP6nlJxEalwXMVBzifVFrzRjZI/qo9mRK7hl9vobnkITl32HcTlyYSozt0+O9KXgbFRkawSpk4uhrVe53IsqMJaQiRXEGLDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(55016002)(91956017)(64756008)(66476007)(76116006)(66446008)(7696005)(66556008)(186003)(86362001)(66946007)(6506007)(53546011)(4326008)(478600001)(316002)(33656002)(52536014)(8936002)(110136005)(2906002)(8676002)(9686003)(558084003)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OGcK4bUlP1UB6z0D8EvkDEGYUPKzcrkkosmaWqU3bUuXTrkw6xwIJ8SiOCUHX03B6HiWjoXb59Ved7Cd1+KU+Oa3iqzIAFQri8S9MhNayi9anP95acRrxh5YQDqrEWGyY3dssLBsOKXGaDvb4KC5WFWZ3Ozssaa6xd7FGn7QYNYRycJCHEnhXuN2X3TFeZLM71uUB957oivOCgdjIarbcWR8EI9k4fxcuhUfXH849i+lGC2HmEbs9hT5SugHvbhQNWBUy0nOFkjcvv69SITD5vm1UvxILPLCLqvVXO+V7/12vmGQCCDcV/kj96UzdKW6/HDqhVnziWRC2zDtzhXVsCjTRJnhdcQIQzxMCs7iF+LgCJb1ciPfaguuw4DmDCan05t36mXPBpgeXy/lzUu9zEebyytsN4fO9dgBKvY7pb+3npyf3Sb+H+mkaNlYnZwgX32EJhdJJBZURm7cuBH7YEcbWAoQd25n1Yv8D4Y7OYiYJxFa6BwDOwQ2vLNfT3PCr3oxdAsS+7a2I+VJ8fmSy1RPicKwgYXGj3cHyZ18akWlZRGLzXr9Est+FFm9XxrIzPiGSffkpqMpQnxsMRMH7SxzVaZnClXe3mLdhjqepsAkhURa8KQHimCjDzUvjyevb2fMEz8Jx8SuEa9VlDR7bvNXMIDNGkLA3JFsiXvh3JZVEeB5WQWJbS1pV9jGIji7dPp+cZ4aOXwyDx6HyA7quA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c64f07d-f050-4903-d0c4-08d859512e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:27:27.3607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hm3qtjeDEiGZ4Ea4BYG2iLJ6odvREe603dNU5Txp2tes/J5jx12sQcTsgIZaF4/XqmnHbbPHeo9S/yzt/lA2YLY6Dmw1AzNys+X73Y2HgDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2238
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2020 07:36, Qu Wenruo wrote:=0A=
>  	eb =3D radix_tree_lookup(&fs_info->buffer_radix,=0A=
> -			       start >> PAGE_SHIFT);=0A=
> +			       start / fs_info->sectorsize);=0A=
=0A=
=0A=
These should be div_u64(start, fs_info->sectorsize) I think.=0A=
At least 'start' is a u64.=0A=
