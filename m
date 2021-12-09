Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613CE46E61B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 11:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhLIKGN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 05:06:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23738 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhLIKGN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 05:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639044160; x=1670580160;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6Gkc7Cxgmrp51ag3CuuSVdOuFmvNVwfs/EIhB7J8oFA=;
  b=oOZ/j4ol9bHjq5e14LN3AJmoilYV8UZSk76dz71kg0ZHcirxDEEv+Ic3
   qhjDnOt3mzqgFJVr47ViZCbd7R9zj7o61FwjJwCrHb9gRFFnH+g/912Kf
   hrz/3l5upqbDlMvO4JHPkBRWiR9dvtDjzoz1gWS1envVnKM4ZMswUtOjZ
   T936kIRwPiSyvGBnCtLMbGYyIQJQOYlYimAmXWBR4e2xfwNqbreKqJKGs
   kRelR3amWWakI4tUZl5w08DLdI9JF4iqMGvmSeARoSu2Ah2j0OsnysLJd
   KwXMTRU9uAlLk0pxdgQ8OPJUsENdXB8mzmhNZBJEZfqrod8Vp35PLWeDO
   w==;
X-IronPort-AV: E=Sophos;i="5.88,192,1635177600"; 
   d="scan'208";a="291808749"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 18:02:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/KImh2lurE7xgWY1K/pBYW2mNYC7xCL2oGQRGcZaLYg2p/QgsgOsOtJ2ipMe9GMzt9cJ7DO8WTA9WVOcjH8kxdLk2yBuJz3rQR0T3qnRVZ1A81Llu4dh+HRFQ04S+x+l7we8FS9k0t4pUCp7TKfleN/rtqwSO30EqQ/YG4el/MwkRlblVZ7uziqDgpjKvTOWs5+p/yy2FAQZiii5gsXeqJJ9hEwXz3NlfqNiwufLT6jB+M9cTzR1lPS76Habl4/5lfAl1Zaa6MJ0tb+cMYy2mBAfK3DsAC7+slFRfqPdjTw7u65J62v2lLfP55FRL4ymF1ZDgT5Iiago9tmemGF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggZs9hBLZWdaVi6AkvdgL2bhTgFVnflUvVAtBEe7I9M=;
 b=QHs2iXOG2Nh/vwFIAy7/5+Ea/JG2fr0+HhhBMlDObnTLMIPrm1IgN9wlwqaYv/QWlR89rjvR1UWKFT8idG8LR04j3bkxRwSPTjj5Zbxx2XKw+L8Wxnzye2GpF6FV7q9EPO7Q6dIRWAV6fCAKjt394Axe6oMZdH9bX1b+uUSYfkhy6Eo3JoJQM3/gJSUyAC3edjMXX29FHC4n4ZHc8w5qdguXdzaEYsDSQ5JoybgHckKJdKNdNZW0QvZT6/+od2HKtJmZ0voZA72+acT/ScvUrA8Iw8bhWNwjO6q3wS50ShYvHgypu/wujVCOHKrUYLWVCkcOkxbCGu62TWWgrO4ySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggZs9hBLZWdaVi6AkvdgL2bhTgFVnflUvVAtBEe7I9M=;
 b=AIcd0e1M2fDERXQIaVZlAzx3ZaG2e0uKOdo0RUNkvb/sxhjmKuvVQwJEvz/hrCp0CzR3y6HXHbss8PQjQUpsGHK6WHRkWpavCJmEsxc6BOeTmj9ZfUjwaiBb3jArc4NIl/g5XiqlddJdEbKF9gCVn6butiVx89dESqdhhpInp+o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7159.namprd04.prod.outlook.com (2603:10b6:510:1e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 10:02:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4778.012; Thu, 9 Dec 2021
 10:02:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 06/17] btrfs: replace btrfs_dio_private::refs with
 btrfs_dio_private::pending_bytes
Thread-Topic: [PATCH v2 06/17] btrfs: replace btrfs_dio_private::refs with
 btrfs_dio_private::pending_bytes
Thread-Index: AQHX6kk02sqfdKZCI0WZ3lYuAeiaWg==
Date:   Thu, 9 Dec 2021 10:02:38 +0000
Message-ID: <PH0PR04MB7416D9D7F3A2BB818E9215239B709@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211206022937.26465-1-wqu@suse.com>
 <20211206022937.26465-7-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe71d6c2-ab08-42a4-959e-08d9bafb0842
x-ms-traffictypediagnostic: PH0PR04MB7159:EE_
x-microsoft-antispam-prvs: <PH0PR04MB715945D94A4DF41C84C36D759B709@PH0PR04MB7159.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFasFJSguU+HS5EV75bTTTiRrwmnuqGi88dwzPkniH4eA1mCCxYROoexc/lfa31yvB3MOxuZPnxaFNfzkOAuvffSo44V87MxVC5DsfzvomPy11B/j/vM91ADZRS8nUWNP685/GVNKHpS/O1axQuTLj59YsSpIrHG2GWlN5LoNUOcIsIHzkbbD4WonUL6e1a7N+Nkgq1Z96JluM88oLCkPuSGGyN+5m/8yGN67ZX4Pi7U7iRaG78+GQ7gV+FM9jjl/y9hiGOi/8o3IQjZonEANHAaHbykVuL7xOV0SjXRvJ1DfFrk7aLCnuKvQv54R4fD1LJ5lD/kt0URzJOcogA1l/EC5tgdDYBq9xHOlORgyyHGixjW1bBAvlr3AkXvWYMD5MnL3HKjaVpl79mIi7lwc5+zJrbMh0uvGJUdQ4fn52VQVyzCKHpVcNMHmPcW67GjDM95CMj9GCRHkeOE3CIasCRnqu7ypNK/vV3hhwEdEJPT9gO3V8DG/IZUAy045OYcDsIDQv+RLwpc2e23JQmZWB+YL65ov4VsAxSiyq4s3Cx/J0fB8kM66v2Y8/VcdyUCtfpFbXujEsTJ7gZMln5HZehRoF51fGyLvJlIwsiI2qnQcH2xmZXW/MtvEJukZkk6WHGGtDkRfD3VDZjUFL82aEynfzApipiWt35tJUBMd8z1DfR2ErvJ+KDN2+NE+oGszYTrYemVjTXcrHEa705U5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(9686003)(7696005)(186003)(82960400001)(6506007)(66476007)(508600001)(86362001)(53546011)(33656002)(2906002)(66946007)(71200400001)(8936002)(91956017)(38070700005)(4744005)(8676002)(64756008)(122000001)(76116006)(38100700002)(66446008)(55016003)(52536014)(316002)(110136005)(5660300002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ko94zcfo9ExeDir7kcKMuc81oaxzS5DCnm46stb0r4TeM8gBcPV+HGtUYHbb?=
 =?us-ascii?Q?ulCJ0rLuTrYtEO+ok37hyh26N2wd2g/PdNc2Ewl7ZTQSNYzx+FSL20OgyUIR?=
 =?us-ascii?Q?3Xy04AH2HeHzeUCtg6Rdvtnj3kZKpKJdzJ6tkPx6m17RFpo0P4/oU2EQkqj9?=
 =?us-ascii?Q?ZIlvBX/upQ6sBYyrqXnVhnLqKwxsSiDZ0kjTph+sqFcBvo4pyq3sXW9W9vdU?=
 =?us-ascii?Q?Hbd5NvmBeV4Qa3iyncx2P/xzrfdkEaQnX7OjMKXU7D6mXlYcGyE4QtY83DQ0?=
 =?us-ascii?Q?gsahdplNx/RkM/mBIpSnk7MV0vEj5vWatb7A60T4ik/L0Vclpwhcai4y5kKC?=
 =?us-ascii?Q?yBbdmzqFIUo9Kwc4dDxnodfBE0PGPoQfSfcysbgEFF22gkSJrOoluP0LpPlc?=
 =?us-ascii?Q?/FLpvq+0EJeTbsnLkeD6bK/Ds1s1wHn5x3DhXEgaCzAiIOJblFsfltSYTJKq?=
 =?us-ascii?Q?JzKfqZDHj34EDHNvuge6HtnHGT/lMHfDJUjkCMLZ4mXO2xj7cVtc/UYaUH0T?=
 =?us-ascii?Q?ImQB2Vwe29RJHQL5PIfbaM/uDoJpYQbMMZScniSsDesGKBHXNQJEiz4egbvr?=
 =?us-ascii?Q?77H8VLihAOscb7zGPCzIfKOevJnGbFIbqWBqZtxTSJSn7JWkiutwanFyRU7J?=
 =?us-ascii?Q?YdFlDEekGrKurO2LZ94nETBeEhf+sb3+eS2HYCcZPUe03QJjvBE+4/95k7ZL?=
 =?us-ascii?Q?BTTDJa9h7Ou9Eid2/FnNBFALoSQilw9w5mWBm4ESTszp+Mkr+KNTBTSRtj1N?=
 =?us-ascii?Q?6StIt2ocmh+KkXNClQanVSljAJgQiQKRuCcVILtXSxdBebdYsP4vxOmFE303?=
 =?us-ascii?Q?a265RTGO43L3jv2BG9CFbZh4IES6clW6zXZZydkL0bZrfDPBCJHS8tH0yyiu?=
 =?us-ascii?Q?6sL2UETpeOxOfb9uYm8ncocRrLq8CTt85bFmXRXShE7T9x2S0rjctP7JnuGN?=
 =?us-ascii?Q?FI3wc3v3uJxvBTKIITy3wMy2Tp1zn2DguSIelXknq1tXlNa15nsvV8TJCmLM?=
 =?us-ascii?Q?VschJhITpqMFnrwHLHApzNFZMRtt0Dvh5DhouLrJGwGwjbqBGUlRyQdUa/Xw?=
 =?us-ascii?Q?0MfO0eYsamJmaqGsdZpwU3gkDiIeVFm/6eH6XqBXiVB7XIegHy/lDxDDhafJ?=
 =?us-ascii?Q?HOXsm8FjJ8Up0gtEVehItMd0azYeOvmPrfV1/f24U773oOl8k/rIvpbOf2KW?=
 =?us-ascii?Q?NgI7bdKGaEQMwg0PMCXIWjjkZFf/7Hly3z2vtKBLolGr8t8AGBgorcxbJfYZ?=
 =?us-ascii?Q?jyQjKwoz+m2dMELFZcFnEi9jAPlAfFrwg1AUzgJgV0tHzzMuWmh828Z+QxLp?=
 =?us-ascii?Q?HZ7BhHD0GjXnoFSjOlYIKRC5CVfOqWYvo3CU/bJGFqusfOB+BRaaOWz0GPtb?=
 =?us-ascii?Q?OItH2ne0j8B3tu5NygAlTksPLLGRbbG8ITA3FxwaHo/EUzZ+rprBvBTirZ9t?=
 =?us-ascii?Q?qUjSZIVEX2deeQgCIUPyUciRc/SOKm4pVg7hg2H7BUMeoh0TV/ZRVuA12eFG?=
 =?us-ascii?Q?8SkjyulbdXF44l4t5HkY+vr1C9sPpuZOLVbOMgmsN21HSrZ3c6OW0QunW7FQ?=
 =?us-ascii?Q?rjNCME/bRdjl4HLeDF/cbmd4xm4atNyyv3mfKPAgQrnrJ4ycfvmMeSy2872R?=
 =?us-ascii?Q?wFxm5TignK/Lh5lkZ6V/8hK76popIaKmO45sIt8mVEuv57jI2QlyZVREaqll?=
 =?us-ascii?Q?fvaG3fSTi7vQa6RnLIcw1+mEgkzAHJYUfhw7RUp4FZbNgTnFy4jiKftKf0g2?=
 =?us-ascii?Q?2xpJ7m6bbEc0MiXxSlGsyhT7/0jBmHg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe71d6c2-ab08-42a4-959e-08d9bafb0842
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 10:02:38.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Akjrkf2Gtxu2OGXmyRiTOaHZhfwcyFACQWhqKVV7UAQG5bCmUjaRhfKK6bwLF5YdAZC7Eenxz/PiVhC94+FJmdx6QUTfumLiBtB3WCQ41xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7159
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/12/2021 03:30, Qu Wenruo wrote:=0A=
> This mostly follows the behavior of compressed_bio::pending_sectors.=0A=
> =0A=
> The point here is, dip::refs is not split bio friendly, as if a bio with=
=0A=
> its bi_private =3D dip, and the bio get split, we can easily underflow=0A=
> dip::refs.=0A=
> =0A=
> By using the same sector based solution as compressed_bio, dio can=0A=
> handle both unsplit and split bios.=0A=
> =0A=
> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A=
=0A=
=0A=
JFYI, for this patch I get checkpatch complains:=0A=
=0A=
Applying: btrfs: replace btrfs_dio_private::refs with btrfs_dio_private::pe=
nding_bytes=0A=
.git/rebase-apply/patch:37: space before tab in indent.=0A=
                                     u32 bytes)=0A=
warning: 1 line adds whitespace errors.=0A=
ERROR:CODE_INDENT: code indent should use tabs where possible=0A=
#32: FILE: fs/btrfs/inode.c:7693:=0A=
+^I    ^I^I^I     u32 bytes)$=0A=
=0A=
WARNING:SPACE_BEFORE_TAB: please, no space before tabs=0A=
#32: FILE: fs/btrfs/inode.c:7693:=0A=
+^I    ^I^I^I     u32 bytes)$=0A=
=0A=
total: 1 errors, 1 warnings, 180 lines checked=0A=
=0A=
