Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B40D5B9CAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiIOOL5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIOOLz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:11:55 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734489C1FC
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663251114; x=1694787114;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=h0zztn0wR1Ia7KlEI6+UuGcbUVs+IGAHi6pCiPozpWhX3/jhoQteVFDG
   5pUWb4AERqlnRKtbU3zoht9Q0kq3tfU7NBRECk2eS+zvmQB72ryXzHNaL
   VAi8f7lqfQKIATzc/DY0AFY5e68JNXvxJjPCvrfu7iWVhi6EPsWJqqCpY
   o2iSC+tXcn5XzCAtaOBZDCpwOeQh/gYVRRGNzluVTRJkT4ezCVxA5T4h+
   tu9RQosrAw/3gW1dSgjxqFV4VJKAyHRFENemN4hFHkkZhW0nzrJC4bIiM
   9nF64B03foAHdxIDc70vLz0779kapZQ1j6w7eOfaHgD8vIEm5bXcB1SFI
   g==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="323543458"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:11:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTHeHDyxrEwyjusMJemP/xNcXc3p7QxV+SMcI4pGvRoJ2bhziBM76v3FlV/6T8zsdtFWeLoB/FsXQbLf4JQ+dKanaWsEMNcQXdw90myRftumH1DtqBVl+4d+AFzFyXDfiL/LbppVEWc6JC88j8IKvr99KLygWPP2SUp765rfowt3f8jBJ0Mw+/tVmtXKW69R2pO9YJzX0LHuMH5TE6arGf3eUYwtveuyquF8nxNjR0+Ec/kpcPrAPvBnMkMD3okTrN26aOFmxfR5UztfJrpD+UJPHPf/nogVUfRhH9OWT2bexVhipu2yakbw49/dDyl7wpP5OAezm+LJ9XorWxXwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=EWZCFUvpgrstHFI5DhTkpetZAIIPrWIP7UUYdtqkMoPaHsdXMOjun5llNEKzz5atDRwjnLzm5qCZUe1Z2solXCkvgvlHBhHJdhnawXWEvD2waWGmn7kvQAJ03kP2qcV9bkWrTcvNow2FVsJv53gg0H0knampTQpIfpKvnTdU4v4Rxemdi1W8f/KAbwnF4FiSFO++RiBpR+hxEcT2Z+rnRXL+UoS7wmtYd/GVxNQgeipHEbiuoW+tXUwirorUbay8JQNHpUDfKgua38Ugb6Sf7LnQaXoXcjTYGOFdWtT1wj28Z1obbjhp2wnI7Pb/qlLicGgSSi6adAkyLUtTR8blqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Z3PvDe55UnEt7MWEvARKRBqyLsTL60OKPftO7jYTFXW/rxgH0v/eBSCt2bqs9OAunC/40le5Ey1Nahiwdng9D5diMzq3oQ8bQJofXVjZ/h0sECnibTpI4dBm1iLs35pF3luLB1z99zuwAgdWg9w74j/HsrNkud4te8fSDQWYJbc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN3PR04MB2258.namprd04.prod.outlook.com (2a01:111:e400:7bb2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:11:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:11:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 02/17] btrfs: remove BTRFS_TOTAL_BYTES_PINNED_BATCH
Thread-Topic: [PATCH 02/17] btrfs: remove BTRFS_TOTAL_BYTES_PINNED_BATCH
Thread-Index: AQHYyEuoSCRMBovRG0WR1KdfjYockw==
Date:   Thu, 15 Sep 2022 14:11:52 +0000
Message-ID: <PH0PR04MB7416DB39F6D3B79FFFAF53F39B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <e17fc6ac382df50bdc88a688274ac98dccd3144e.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN3PR04MB2258:EE_
x-ms-office365-filtering-correlation-id: 56c87ee3-12a6-4b5d-3d7e-08da97243cea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VvHJyAtsgCsOJ3cPtB60kXGSyrosCKMn1pEQTjiBkUnk3NH8joJR/F5DZT+Wvam2iKh7BN+IZBiU+/hsGgCJygdxFm8GqLhnor6+iDHIc6jtCxgiCbDuOqoeKkEL50SFEVD/SaSsXl3epOjCtVeKj5KwiR4hEgX6UeoXrMi+zYfa9WcKLqSNVmfUdzqTzG6ZPeqw5lsvERYyTxtudRAeYh93WQOfddD4GEiRUldE+hTGBVtoX+ys+y/Q149c1IRXCnzNBFojgjDL2pW895/Qt9JR0i+Wkxa2XQcZrS4OjmtQTXvqHTmlpuB+d4SamRWr5Vg20BkFewfgGr7fY6/UeDS2IfoIK8j3FH5qz2BxMjSSp+bPFDmdI5YuZ0Eaz1XyfVz+ei7hrLAsa0E2pBDGyq65SlYBB1OJ5CadR0kn3RUfUPpQUsytClmXbDersgtPYrOpd0X+5MSHWT9zpuZzn4I/sGyyZc/FDgcx3KNN3SUX2Y1Z2dzaoiDL69nwYvFuB+u9G7hUoPfGXLtMfAqrZuZYOHars9YKzMVNWt/3/YfvDNME0/b+/mBeAcglYrwo4/fzmgyw1c6/0k66YKmyKpA/De1xyLhXTeCH4yIXx+VQPcyeRglA/vFguxYlkoICUu4yur72sPa2AuQ8/p7lL1D+fKc+/KnmgTaCBLp1svBYDmRopSkgU2m39CDFNEXlupdQLtjmCUo/261LW5myriIvVvYMzPB31rKhOf0drfW/Y9+2O9IPDnF8Z0hQbGk/nUrI7vFpw+KeyGK3nYS3OQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(9686003)(71200400001)(6506007)(7696005)(41300700001)(38100700002)(110136005)(122000001)(8676002)(66446008)(66476007)(38070700005)(76116006)(64756008)(66946007)(66556008)(52536014)(86362001)(91956017)(558084003)(33656002)(82960400001)(186003)(4270600006)(478600001)(55016003)(316002)(8936002)(5660300002)(19618925003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x6nnW5k0DT8V1oJvqmknSwJz88hHBrdLeUxqyvFvjbJtdvU6XWCp8dzM7uPk?=
 =?us-ascii?Q?Lnr/Kf5WaF45N/egEdlQpASBNEDqKBf+0fUY46fFuXQafeYRyzUPZjZEwnPs?=
 =?us-ascii?Q?+qkczjLVkxuNjbpp1t8roTWgbdTlp6rXF7PcI9RaNxz1RUsCMWToaLGybWsE?=
 =?us-ascii?Q?DWbQE3xXfDffgcXng44+kB4N7whg25jr22h00WV4FKCt5pHvUTbshqhMlZr7?=
 =?us-ascii?Q?apBjGas9YwxsiaDQKxyTjYlrLr1KyM6Bne4kR3L/nwuq0vC10ywF0Shxnc2i?=
 =?us-ascii?Q?kousGh8AZXMeZ4dWHbfobGgvw+ne+/Y4lJ+xxWWvA+sy1ZkP/yhw95VTlQjt?=
 =?us-ascii?Q?Ufx2gjiNY8AEcJZR0U7rHmrQHhdQECZ2Iq5rjYBwMV3X55yeLjkhWURUg/kM?=
 =?us-ascii?Q?PGzPmupoF1PbYIUrROX+YL6D6ALBmD/qjEvIEj54Dj2C+67cTjlhc0DTnGwa?=
 =?us-ascii?Q?EdK7+xy51bYqjJiXXmybfBlgbfbwo6pSJqrWeycLJTiJT4224vKd3i4Ueow+?=
 =?us-ascii?Q?/UPqtBphKiqEFyJIqJB5PsaLOy4QmUvNBzz/LmQ2L1g2NuuWqpKZ7Q9cGMkv?=
 =?us-ascii?Q?Sgvd3r2f3suwWufPDaaetB8ZPn2l1bRnxLBIMxzkmBtyVP0ZIMgTJL+A2qxk?=
 =?us-ascii?Q?mzK270IDAH+alnPfkiTOHECOs2hPbL3lTgnFD8Qlq96YLDGF/UdmwietPhOS?=
 =?us-ascii?Q?g+LFc091cts0sAoUjFXCATjsi4qN3RmhMJikGcPEQ6cMSPMZS0U/7GEuAehj?=
 =?us-ascii?Q?kEc/aX3tczC9Fc/ytcnaJRsMAwNcXp+r62+zjq/uzjaXEe4CQJ2UbwLVQKwg?=
 =?us-ascii?Q?l+XJX2Rsvvp3dfzMZQFjQDD3Zcg0fW9nF039F+nyb91QhkNx0yqe5GQYUZAG?=
 =?us-ascii?Q?IvrYJf7az549GQSYmeW+dEUO6863iGW/Ye7SLRDQQvK7sHM73F90ayaEgAtG?=
 =?us-ascii?Q?/Xn9Q0UrNFbe2vHAaMdWkPKE7sdAKE8n0GKzihN4pmXhkjS5lSly6xOIhnhs?=
 =?us-ascii?Q?YoL1cS55/MlmKU7mjV/x6xY6xQEDLbCy+dFWEiTqMlbN+8i2CsE2O48l9Yge?=
 =?us-ascii?Q?S3S876LpUnWukcL8MJyGVbq5LTEuSqUgOEuLaCnVRbqALP0XlKUBEm7Qk6jF?=
 =?us-ascii?Q?3PbAczkYDNB1bE0IturKLHGYDf3V/zcF8DQIqpvBrj37GpLS1CqW8PWAksyV?=
 =?us-ascii?Q?5REI6HT8Ht+sj3jt077LCDPeW0aDYTZFrgMUAw3LLnYlNljBNOVLmBiBJeEp?=
 =?us-ascii?Q?/dKW2wfKGcNA2ZD990QUfHUJDVSglvfZDpL7CoTIuDusVdL6VF0ipuPmHbXh?=
 =?us-ascii?Q?WkkXjO3X5gwNK7oegBHpy+osoNdzE7N41INVhEtDMOjNf6KQ3CJx5dbFywG6?=
 =?us-ascii?Q?P0ZaVs9zmRPvnn7GiCDq7QiZoOLQ8FLWTu7LyCLgr8JImALURopikH17w/3f?=
 =?us-ascii?Q?5QOPSq0KrpHSBWf5aICd2AX6MkdljA/7qCz291Y0j3epTLRNPdcZ9Rk55EgZ?=
 =?us-ascii?Q?H5KEfnsTBQXrIRhiuFWDU8pDtnveO3vkrz7aF2CVFO9ICBKIbyO+vjLFS5M2?=
 =?us-ascii?Q?VMmlXt6QKRcTDXiLWj7E1AW4WOXo5oVZmpyRF4AiHyORHff6roraOXwGzgm0?=
 =?us-ascii?Q?MwbOVxNDBCXO7bbJqLDhxM6gx0S818eD/FI4npJXR1FuAo+HRG6a29zlbcX5?=
 =?us-ascii?Q?w22ktDhjgmQkCCM3smJlqVssUBA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c87ee3-12a6-4b5d-3d7e-08da97243cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:11:52.2478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKaXmeNQeewtH6ir1mZ1O91b/UxkIABtqBXAtsy1XC2ezHcFnt2OCp3zrkRvOsU8g+DFEydVuk1fBvoC1FQcnctCw+8zbv3IgaIyS1vejcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2258
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
