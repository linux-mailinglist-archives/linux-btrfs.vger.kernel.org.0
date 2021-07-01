Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4201F3B8E16
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhGAHRn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 03:17:43 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22923 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhGAHRm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 03:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625123715; x=1656659715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O2QmZ4cVD1NU22sWIrRtZR6RPYfSjAGsJ4A2bOkswNE=;
  b=kW6OF9BYWLl682Voc510n7tnOxmNHbVodTpwG/0XMUnlBF6rN9o4iE4k
   NyDTowkiADsMDDmpkNADHCbqN1Mt37wpeM9yPBiIJKt9nLeCw7wO7SPeF
   2vmGYY9ZIx0oCOYa2FYTUUsrnXQH4QDZkeHr7NZC5AHii4knU8YcPuqvo
   9b9MHCpSlNJL+jUaU7u/XklkdRiNAcXoISSa0FKtYubbVxzMnwahS0Rwo
   2030RzIE5yaCt+ilW8TYIzuQLzsnUG8MZOEPs8iLYL38VCeysrlkziJQE
   oomWcqXQfqEDKysRZSBIJnvFAlSn9juKOeT2JIPrKThc53uuQmNThjLTd
   g==;
IronPort-SDR: dZrOIUQyXTxq2kBLwtNij0tao6iBMr8ROgrFGxWQSEzTnLags5SzCrmLdZVr3+GIjBdFt+dkmI
 uUJiZQ0bIyKSrkS2+7Y9EUXlSfFcUFHCtsatEKIyQF2jOeySsJ4H6srlH7rBZ9sLFWqpfR1lmr
 cLxxJzsN2l73zXgjLFwf1O4eUKPLaagLcxB8VVUtF5aAKsnsp4td39jPNjNATzj99cMiQ1w3MT
 ofB7sEvIu/pUfR75Yfx4AIwYY/v3HXc6eVZuPLx0/xNiwjTKM89sfuJm0IqBGKdoEzYmNMDctu
 OBE=
X-IronPort-AV: E=Sophos;i="5.83,313,1616428800"; 
   d="scan'208";a="277212086"
Received: from mail-bn1nam07lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2021 15:15:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb+sXxaneb7WJgYMDhuG/dbiZ73LJPwItDNDulc5d1x20F1nxqKmMfQpakky/SRZA+yzyqKu2QnQXZA7+ffkNwfOgx7y6/SWxETc6Mf6+I6AzwCB3/8qaIWnGXBtN5zB3YTq918r7Z3kjukrGyYOtsuEk0RYlQwg2B8sVepbEaIozBfqm6sNKx2VTBiR2tDoeupZZqP4bG5KnbGm/VSsD/lt3jS6kiDlQO+JexDWpUpX5NFMm8AoxLYJOhEkvNSPfmYwu3ZkuRjEW4D0+neS4NdysuXdipraDFd01A7UEdIYqZI2rLbWalOWb6gTEwQwiMB9WFX8JBAr7M7iG8ErFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdfry5wyufkPzGWqtY3EWHcRzDESaJiY/yKCHTHEaXE=;
 b=Dj+Pizpjz3aPSnG5dsAhgUlIQJcBslLGMiDUQATQNoZZorVFDrTFLeq8ri+m0+5XqnwUTMVxjW1QozO/XnrM8pGKPdLPXozl0lzvgUPttbLRhX610+oDPzGC+JDZgxv5o8TcukSf1G5zcm14F3vrtAXiPuHfH3G9nn+hWbvzFyEtjnOyXgvKK5MW5vm0VXUYVOpLD/7LTs6ygiN7YoEYCClCEEgry2fhhBPXqc6Dnq9gMTxgFv5ZKHjzOZQcksFZ+Nslxvy0wtFM8IEML8N3Hcdrsqwe10yFejvhV081DfzHmeS4zHqvBaeC1A8/UEdOmSaDDPg9hFGRMOqMfE3U1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdfry5wyufkPzGWqtY3EWHcRzDESaJiY/yKCHTHEaXE=;
 b=j2t5Uh95d2dAGOv6hDuvpbnFg5VI5HVJubu9P6Ze4FFjDgHo+g4F9KUGD4BYsI71ze69fFfOebO8VFuxn+/kkdr5YS/koPnBIjclwTr7c3YrTbjzGOn/0mKDMC0r+sbjS2/gIa3Eu9hHsF0NddStCopiQHj1nPCbqe9kluo31Y0=
Received: from BN6PR04MB0707.namprd04.prod.outlook.com (2603:10b6:404:d2::15)
 by BN7PR04MB4257.namprd04.prod.outlook.com (2603:10b6:406:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Thu, 1 Jul
 2021 07:15:08 +0000
Received: from BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71]) by BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71%3]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 07:15:08 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/2] btrfs: eliminate a deadlock when allocating system
 chunks and rework chunk allocation
Thread-Topic: [PATCH 0/2] btrfs: eliminate a deadlock when allocating system
 chunks and rework chunk allocation
Thread-Index: AQHXbOy32TDiXYYmz0K1tooZ/P0VJastt8sA
Date:   Thu, 1 Jul 2021 07:15:08 +0000
Message-ID: <20210701071508.m5fxalsk6tyrjfv4@naota-xeon>
References: <cover.1624973480.git.fdmanana@suse.com>
In-Reply-To: <cover.1624973480.git.fdmanana@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [164.70.191.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2defa1b6-e782-42d1-867b-08d93c5ff57d
x-ms-traffictypediagnostic: BN7PR04MB4257:
x-microsoft-antispam-prvs: <BN7PR04MB42570A6044E17960CCFEDC378C009@BN7PR04MB4257.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwANoWwnj+ohaH97TfreR4JnVP3SQDc05S1aYZ0YhbBHYukzKDDbs0m2y9EUGE1xYqA/inbDW5sToj7CmwEwgguPI3aPh2qWHnggINjrS4LFwC/OTbOXwvwUH7pcbDj4/dEZMuTHgwbJa14rypLAJdCVoGapw8g5SsYvxHtg4y16adGFJ4xi+hqHCQEB9pTIUQ85uhR2ea9Nvh007H/3W98lvG+FcKUwMpvNjEnnrXwzUOFl0fub4OLuN6KKExhWXVSX4Sr3M+1hIodMSfQGi+g9UctMOxh2OTBj+2hwmBlIgo9Uuw/OQoZNn7i/camHCc5aW0bfC2Ct4P4vfncLEWWF72gqajt9PMR22n4Q0wzYpQOEFjdnaWcqF3ECIxBvQHOmnuDsIrpfJXBW135+P7JhOiWHr4pkNvGl+f1SnAF8MBtGsKrNfoiX+Ds8SHoG4skDIiUAshNnDViU4qnPOF1YFE6WRdDAyVVTz8J+sOl7EA4fy6Btv3P11kBRN4kNwup3U33Rq5/Kxylt8WrRYcBhmJ4sCCMnunC17GXPThNUSS5/PKRpKtHAdf4STy3mby6aQR0K+QGPl/uUTW+mrUdO70RqQZ1SKlaM+4niQLXcthJi2YRWxIsh/30uAaamemIc9d33dOGR1Ed/fK0tKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0707.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(9686003)(6512007)(4326008)(5660300002)(316002)(54906003)(71200400001)(76116006)(64756008)(66476007)(91956017)(66946007)(66556008)(6506007)(66446008)(478600001)(6486002)(122000001)(38100700002)(2906002)(8676002)(1076003)(6916009)(86362001)(8936002)(26005)(83380400001)(33716001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zM46tU62gMgjTydvRp5AvijmDxTtekPQg7k9LMpYBrQvHFf4BWkqAHXejPz+?=
 =?us-ascii?Q?hklCqTD+AeBpKxPEosmeJi5aAEGDpJY7JEFFWLB0TXbwcZZ39ezsPffCGDCE?=
 =?us-ascii?Q?7dL/LrpbGNUjM1rXC2l963I7ccYpFBStmvFaQwVHznq3esM5XQ3apo1GUuGI?=
 =?us-ascii?Q?9ihUfNqqOzieh5mCpp6ie2NbJ7tUu5t/jdCFhtos3XFnEF27dSx3yjSpT9Ms?=
 =?us-ascii?Q?rk/8Apd6M1IwzEblEFu86TpuBad/5tvJaMCqjgP4lQulIh+rqAjdcYPOEtWh?=
 =?us-ascii?Q?P1FsyjI0e+nDDM4h+YoltJSH+PQrBeQUiIHeTudSWSqrzbkJ9X9ydUHDmABQ?=
 =?us-ascii?Q?4oaxMMfGhj2zPG8iB6JllEVKPnzpUPgFfiDNRV1BduBi7KuFke/y3YfNXlER?=
 =?us-ascii?Q?aBkkuEu20M2nZ72YdT3tU/TRdu3bO3Om7u2Htux6rLalcrn0eut8CSFYV+2o?=
 =?us-ascii?Q?isuHb6pHgMFS+0FotRPglw0PehAtsXVlp4dLaMEQ8Sye8TYIgDoz2SyuwXVk?=
 =?us-ascii?Q?dYvd2wimPeNnEGeBpl+HCPpyKrIQz60mhEU8S0KurLTymjOdLkbQle07SlE8?=
 =?us-ascii?Q?+dq1TceOszlKalzYbROg/2+GrerXAGOLJ1aibBDGaHXn3fx9bzuHE0kuGGAp?=
 =?us-ascii?Q?ExdOE12XOcCtH538zcrZC3tI9j8831/4WqD6rTjbAVREi9cgC3Z5db0O4rF3?=
 =?us-ascii?Q?ap8ZzLfQHLV1vN1egj2JcR9vwn9GLYHJbfZLk5HdSK9y5HsWQmfNXADceLH9?=
 =?us-ascii?Q?1Oy/NtC/sX14Z6AUWQVIw7UVcHM42xgRg7BUr4Aheeg1Q1lt1XTFMDBgPuuT?=
 =?us-ascii?Q?vMIpX2ohkzvYvQelJRTeM/FqDy+xZnhKJIOL7YleAve6PwDakrisnpcV1X47?=
 =?us-ascii?Q?IY5+CJu6LDrxicQr7Bkkrf2v+UKPXDmlxVlv1KkUJ2bNMonc6Qwj62Dfm4uR?=
 =?us-ascii?Q?L+rpl8et1hceq8w6nZsI1iXtWOLVAmWv9xw4/wWhjDYzMGkZONJtF4gBKP0Q?=
 =?us-ascii?Q?PTLaSACykgNTPZQYVAa9y/DpEEEZZnVWNazsti8K1vm5DzLswsViWzudNLIn?=
 =?us-ascii?Q?JooSHLie1fOvPuhbPV4Vox3U/YZKsIBx5+FnhaTOyN1+7Eru5cM+XXF8EGcc?=
 =?us-ascii?Q?U2ax5NC41wUaLUOC7LhbijDyTay41NJEVmXfnAWcSH9HgbOK33QNh7YBhbGi?=
 =?us-ascii?Q?3nvPspxZxF5P7htuFJ6o5HzwmtJufHZI+ui5F9TIVFGDJXC7CMhniOhkzguW?=
 =?us-ascii?Q?zvLhi51PjA32DCmVL6lsVy8kUXew4pUghVZD/dEVEuzz/38sgpUwmRb6pv+j?=
 =?us-ascii?Q?4aehyElpn5JKKV2DzgvFf/mk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52F4D35E8CAB604DBC57F05850E90920@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0707.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2defa1b6-e782-42d1-867b-08d93c5ff57d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 07:15:08.6870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kfAveaKLGhQn8tBREpovnX8KK1ecLn4+7XvM2je1VPh2qu6SfOkqcjoylAzwksyx+EltuYZWZZ0hxfeZEspSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4257
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 29, 2021 at 02:43:04PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> The first patch eliminates a deadlock when multiple tasks need to allocat=
e
> a system chunk. It reverts a previous fix for a problem that resulted in
> exhausting the system chunk array and result in a transaction abort when
> there are many tasks allocating chunks in parallel. Since there is not a
> simple and short fix for the deadlock that does not bring back the system
> array exhaustion problem, and the deadlock is relatively easy to trigger
> on zoned filesystem while the exhaustion problem is not so common, this
> first patch just revets that previous fix.
>=20
> The second patch reworks a bit of the chunk allocation code so that we
> don't hold onto reserved system space from phase 1 to phase 2 of chunk
> allocation, which is what leads to system chunk array exhaustion when
> there's a bunch of tasks doing chunks allocations in parallel (initially
> observed on PowerPC, with a 64K node size, when running the fallocate
> tests from stress-ng). The diff of this patch is quite big, but about
> half of it are just comments.
>=20
> Filipe Manana (2):
>   btrfs: fix deadlock with concurrent chunk allocations involving system
>     chunks
>   btrfs: rework chunk allocation to avoid exhaustion of the system chunk
>     array
>=20
>  fs/btrfs/block-group.c | 343 ++++++++++++++++++++++++++++-----------
>  fs/btrfs/block-group.h |   6 +-
>  fs/btrfs/ctree.c       |  67 ++------
>  fs/btrfs/transaction.c |  15 +-
>  fs/btrfs/transaction.h |   9 +-
>  fs/btrfs/volumes.c     | 355 +++++++++++++++++++++++++++++++----------
>  fs/btrfs/volumes.h     |   5 +-
>  7 files changed, 547 insertions(+), 253 deletions(-)
>=20
> --=20
> 2.28.0
>=20

Thanks for the patches.

I could run btrfs/232 100 times without hungs.

Tested-by: Naohiro Aota <naohiro.aota@wdc.com>=
