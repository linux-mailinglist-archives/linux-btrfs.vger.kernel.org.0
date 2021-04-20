Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAA365365
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 09:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhDTHlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 03:41:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14379 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhDTHlK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 03:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618904440; x=1650440440;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HUnMGSlz62+p7fZ8LAgdH4cervLR9TFziihOJEQuwZ0=;
  b=JvjyDeWxrM92V0Z5Go4kJw4zaojJe+B04Hqc08RwmYfPcgHjeH4J0A6t
   IQ8zTnT5GMDqGUi1LRk/byFd+NX0ympaoDMg2icDGiOgOKuC8iP8WTcIo
   xCps7duK3N3t4xaJWFlL0L2vkevDqf+FlyY4uTbUB/3gRzln3+4P2/SRv
   2F6QpKQ5c3HA4IGzhaJDpsvkCoq8oy99sGE0VA56M225jO7DB4kSA5Sim
   FUdWzbhwPqTs4e2MYSVb7DgNbNo2q2BvD7P80Q7BzUmFC1JN745cIXZTh
   8BYKsELCopEj35mzotJDsbN4siBD7/4CwzsBjHlhe/CFmH37FDZ38iCXU
   g==;
IronPort-SDR: 9JvN1cUJ4czVXkI2V6Lzo0l1Nn/wMnN4wfI/LBMS9PCcbr7VxeoXWnW3WOyYHEBpPhz7xHLNaG
 9duQrmmfbacIfYOBJnq9pwhgu6thT7gjW3WHBPwceSJVX2PicmSVfX+De+o5hQ9HuzCdK2Ud9l
 lWFNmh1nJ4gzffo7Fu1zY5O89ZZSwVS7wTFjXRPkbaHnoQCbb3YU8Ap3mJwqt1s6GtUIOTsdy2
 NxveX6UuQB43ze7tA7DRQSoZwoqYlsA256A11dWoeTaCvpFpNR6dvBhXduchwrVN5zVAGanXI1
 1ok=
X-IronPort-AV: E=Sophos;i="5.82,236,1613404800"; 
   d="scan'208";a="165523085"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 15:40:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2Z7pqw+R69H4380EU3+VnZG7VNTgyq+lCVWSEXO+pFsFS41dZ2Y7gdar0TpsjqdBAjhVtfY4bKAsjG3iAsusePyE9KjY9lMJ5aoNQ+v/EXslUZFpB5XHJG861J6LeA3m64vK2tTJXjiBtRl/24c4IFn71s9EQ0QEqkVnhLDXPDIMAfE30A+B0lUog9o40zOvq7LWfNI6ewU+ATzQwjX/junIM1LLSkcxrDRtnO5OpHAK6+bqm9g2C+Sp3aGFk8LN6qOqq6wiC2E6aevzWOgxElEbeGJHLbzsTeCNahyk8XhoEZVXD/GUHa8XrBR+oQuSvKMJeebKL6D+9IcNQ7jXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUnMGSlz62+p7fZ8LAgdH4cervLR9TFziihOJEQuwZ0=;
 b=HCgjpPYPHW/HyvYWvtYVUgSVxKmg/heJiDAsHUoobzkdPCB1HLPQkNcTiEss4rf7FaUf8l9omwLxPKItjmSP2hkjwRqiR4o/KFRdPaiQNFHNjlU+KPpht+qCrIV3opisJRbcuKhDPSQHhLBW/6jpsokJGoZUopDHdq8xx4yiOuErS5gy6pqIFzPmF+ki4GC+e9k/ZCXCgNMxQfcSWDmPv5iNFV3XbJWdLnzzorYuGa2ff39TDfZJP/Thy8s3BBiVOQ6TcwzHc6XpRTvxVzYWCRcU0RH0Q41Ek8zLtnvAYHAaR/Tzq1h0O5nmDerfMPyfH3KTuIYWWdWfG3RS6To0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUnMGSlz62+p7fZ8LAgdH4cervLR9TFziihOJEQuwZ0=;
 b=nkY36tRXIPYizYAZ+30kxWT+cH7n/9S6cTkJml6qtjCrJGO1ZvpM0eVwyrp5ZRpadSO4GIAFWcRL8y0wHMMpRLyZSJIu/pb9VCWFQy769UwlHxr6ajrLGbf4dBY67N1FRL+BYskv/CILiJC8sYZ5dNzG19XHyeSldL0UpwFBLw8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7159.namprd04.prod.outlook.com (2603:10b6:510:1e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Tue, 20 Apr
 2021 07:40:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 07:40:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v5 1/3] btrfs: zoned: reset zones of relocated block
 groups
Thread-Topic: [PATCH v5 1/3] btrfs: zoned: reset zones of relocated block
 groups
Thread-Index: AQHXNO9gc+Q46UM8vkig+eL2aPleTQ==
Date:   Tue, 20 Apr 2021 07:40:37 +0000
Message-ID: <PH0PR04MB7416A7E77F4B13420AE65E139B489@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1618817864.git.johannes.thumshirn@wdc.com>
 <accfdd59409776466cacb8b5bf67db7e346f6435.1618817864.git.johannes.thumshirn@wdc.com>
 <20210419171038.GP7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:8801:8d26:331c:72e:ec33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e0d2fe5-afa3-493e-c6dd-08d903cf9736
x-ms-traffictypediagnostic: PH0PR04MB7159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7159F7149553E85FFF28A3089B489@PH0PR04MB7159.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WlG9ctE098Wlx3lxn5WXcAXUqm6laOP1ZYjAFLBCBL90FbyEGYts8j+7tcROwAWE7ej5wcHztmvwHqhd3G5Hj+YqC4fs+0JaEO5GY9lf09S4KDRKyvHzOo9eU1csDLzPVEuEIKCOUgfzDFa89j0655gyAFWW/IrlZULeEuca4vMxxRPqicETJQet7upco5hJmxQ273tPeDR22jTgCVTT255cw20ifCUQRqyIoknEjkFMC2SQHfjTR6jig0PDEmo5PKMMUBvvFh67ZlGUZPw44eBFm5Zh59PG6Np4D21tTzn5Wgyah2qX/6y6i38ljpZm+niDepT4b1pId88mrzE0lkgd71k2R5El/e9XtG8Mu5uc1Eg2ARSy8y0OTBXGSmwvT9pWo8yhnRyWQokFgUX5EXhrvT3ckIYJTV/pj6rjRbUNlNFT3mvk5CFQ7cysPhEqcJvRa2HBSTeMrOnUGi2dyhqZeLKFQxdUcgaakcrpzLjOuD3D3qSOfquUNjrgmtCHNRFe9h8nZRWmg1tJoYBLJx3peuKKSy0uJZFBb/kVFpQJfCNvnoR5up+qyb8V046wzd6W1fWHJVl+N66/pMt6e2ILu1/A5gigw/r1OpiuzJTQu7evG5fUqbYO/A8lOmS5YmL+FR09TkhSy6f5mQ/RV6DZloU3nAUWa9Dfkc5GWcIGHAyAYjpMy5QYWUaUek81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(4744005)(7696005)(8676002)(966005)(86362001)(5660300002)(316002)(186003)(2906002)(122000001)(6916009)(33656002)(54906003)(83380400001)(64756008)(66446008)(66946007)(478600001)(66476007)(38100700002)(76116006)(55016002)(6506007)(91956017)(71200400001)(9686003)(53546011)(52536014)(4326008)(8936002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IeHttSsYdcrpSIgzsJg9TEMHtIoh/Pg5SL0ZRGMYYAb36mf9WpHQ9pE9epQF?=
 =?us-ascii?Q?TsfWCDfvlqDDPshJxeO9H5E+9lOnbXkrAllzrYA8uoaE9VfxCnwIelZ/yjIt?=
 =?us-ascii?Q?/onPvO+I55T8rD33q4rjhjzSEG567Sk8yvi/HZ6MO4jYWE6Qry5V/my6yYKo?=
 =?us-ascii?Q?6CbQjKJn85Fr+Z3K8FsmaXMwT4XvUaK0L4ev/IIciEHetw4n+kNz5jXpwt/O?=
 =?us-ascii?Q?rezvubpSjagiVsp15je3AK8myB1m0hekzfaVoBrL8ITpW4Loqc8pDf1YdybT?=
 =?us-ascii?Q?0RcE6fpuY2ygkVtSanASc5zNWpIuE9YUYOphQPnJfjdnoo06p6nDyQKrePUh?=
 =?us-ascii?Q?slvuTGOOocxBKIQtlvIPihCVHePjnB+HmDX+x/GXNW2NUqRhT73w6xTSzJzV?=
 =?us-ascii?Q?r67Qs/Ke6QT4xJjXtfTU2JJxCJh4JsMgE7fYwj7ujkZb+HsMjgiA/yjI37Yy?=
 =?us-ascii?Q?Odqe+g+MYM/qUAv9ZOgbITv5m0OfbUsUNJl512I9P8ePVNR+LHHf7fgfQ8Hy?=
 =?us-ascii?Q?5e4q4M+nmtXu0oqaHoukPPlQrNpivGTJGYq+4P9VWZyzmZLurN8EJZl8x6al?=
 =?us-ascii?Q?bK5fo94NsVGVxBtZQ11KCo3wTuFGKRnr9ZCvjvnJHPRP+kNbfHtBhkG7KtLr?=
 =?us-ascii?Q?uP/ZZ2On4Nb+M/i5WpFDE97SjB65Jfuq2RmPpGkqBmTxWEM5QeiG1SJEY37o?=
 =?us-ascii?Q?YBWmoKiWPuyBlkTZNif2uo+PKeXwtVerpHbjaoiiDSOHJi+jWL3UwHMuamLv?=
 =?us-ascii?Q?v/hZHdLk0euWhoX6+BJf49IQfzjUASrutbIFMH9A29GsJvTjclI/EhaHzJJa?=
 =?us-ascii?Q?/4LcpZx7udchHBmKgiopc2CqmexPrbOJLiNWlxxGbMK+BUS8eSZmUfkOCeK6?=
 =?us-ascii?Q?DSb1b6+KzfstipSQdUDhclRRCtK8dBybru5i8T27doEtzR6MrUvKaLbH4vAE?=
 =?us-ascii?Q?Zm2p4acN4ipVCDRSqm4CL3z+OjjvmwyT028ORGYKF7R7XKfrn0YUGCI9aZ6J?=
 =?us-ascii?Q?qfmqietpnliW4Drq+tuQWHLBFYAMG5imO/TA2Gf0vcE1hZxg+fxnshP4tiOj?=
 =?us-ascii?Q?HmSzjBtWZmW/n/LCrU4iZEeyCOSXR42EFNXERIhEqOtcnfWgtflO2MRHbb2f?=
 =?us-ascii?Q?h+hP0NbxH8NxOoeR0Hh8/in4jvxPq8urFXMo/H2NSGXCQk2Mz1FAEn6rbUZG?=
 =?us-ascii?Q?d39WhuLRFm735bk1jm1FlZ0OnFPJwYte20vpSPnF/pKECIeWkJ7SGr3TWtUZ?=
 =?us-ascii?Q?pqnpUUXmJryaFvhPv6+k++MVSegsj5s474eoCUcO7bOpNYzCLC5EWapX1NpG?=
 =?us-ascii?Q?SFXe7hWptogZuiP3EGuu7/FjHSdc3AlbSXg82u4ZSkiV4uDqbjnp21JjRveH?=
 =?us-ascii?Q?VfOlY0jo6lR1T8TcBERFtsfAO5Jb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0d2fe5-afa3-493e-c6dd-08d903cf9736
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 07:40:37.8155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQBogI2HDkkzw69ebjzIXfKv6uFAAsAVoZnHJvRjiSEX9u0gpB2E0gS9kRjb88uGmZTc8gcazXQsqNJ5u7mWdZwOrdW5z0cEgoF1XTEzf9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7159
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/04/2021 19:13, David Sterba wrote:=0A=
> On Mon, Apr 19, 2021 at 04:41:00PM +0900, Johannes Thumshirn wrote:=0A=
>> When relocating a block group the freed up space is not discarded in one=
=0A=
>> big block, but each extent is discarded on it's own with -odisard=3Dsync=
.=0A=
>>=0A=
>> For a zoned filesystem we need to discard the whole block group at once,=
=0A=
>> so btrfs_discard_extent() will translate the discard into a=0A=
>> REQ_OP_ZONE_RESET operation, which then resets the device's zone.=0A=
>>=0A=
>> Link: https://lore.kernel.org/linux-btrfs/459e2932c48e12e883dcfd3dda828d=
9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com=0A=
> =0A=
> The link points to the same patch in v3, is there something missing in=0A=
> this patch that should be added to the changelog?=0A=
> =0A=
=0A=
I included this link so one can look up the discussion between Filipe and=
=0A=
me that lead to this decision. But I guess this is not really relevant. =0A=
