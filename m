Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F218E54000C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbiFGNat (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbiFGNas (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 09:30:48 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38369D2460
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654608647; x=1686144647;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CWciHdA2INpIZ7fgHdq7y7XY/reddbSGfFpPy7zF3/w=;
  b=nWNGycra0efN1vNLol1+reI8juEWlGGf5exp22traQC2UPTXbHLniwXa
   xFZ86mga5mu4JHuFnqpljM+iN7qRvzaLUzBDdnK8gww0qpEGS85fAbNX8
   LEi2jfYNZlmj2qkOF/m9DXMy/eONnc1afWV2mXGlslFjbcxowYJvy+89k
   a8kyuT4E1xXf6lorV0jTrYln5Sp3sITIMHTKmnEedaqT7k9OPArHWTwtV
   lIrQzigp1xjj2cIb5F6E60wByaoaEpS93Q90xkgHmYcs1JAYMrrQwUPxF
   i30QsJvkvKl7yGHvEcz4f1lQCvRNUKn9D+cpCRnqocaaYnvSi+UhRYbQO
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,284,1647273600"; 
   d="scan'208";a="306759190"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 21:30:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSbujMxq3eCv0UIGl1q2Zq5qoW7VXZ1N99D9Maic32xspVWhoempqlfd486VvQaVqpvn0Nn3fHk0fhY04gB7hSazRE6oqo1XaPW/R2i9fX/QtTQ9d1LoFxqtwmmiIUmRhSC+80pjoOMsIbNig2myQC6E0VO9LyYofX3Dv8mhsNQyFjDZ/qDWJ/JrloNtTqoGFzfMhLgBr0MmChjVQcQpASF8KmZ/lwraI4uFB2H2OX2SoogHx1YffTSmBTlrS9Aco7BKfmLO7MMNtPwI32kF2lQxGpSNAFrQ6rUOeNuMwDcqo0oBPL7WXUudzp3h4HnPO9cgKHUt3wp/fwEGix3jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWQ4rGRONkdS6MfpkUWMFk2IyfKOLivr6J/Y744WpJ4=;
 b=kH3Amre2V/ITtTIAC1muQX57D72SLvmjnSL3MDZwIy37roEoDGdj7aLIUXGpsDL1oz1qkjiOdUFAzghIZnhjSeq/yibcgYXAvq2aQtEKdB8HrLb0CYTKvcGLUhXFCqcNUXrl1jIygkEUvFuu69SudEIFLt+4dN65GXXXe4hl84F2nxwGd7tGRDnhI3fcFloSJ1HTaM4yTNhgELcYxUpo16Z9oL6JKgRG4JGs47cqQ99aRj0OQHbbeJ8qsmBlJtuFptwy0exxHmy4z38BV5q2wNBGHKcczrta51R1kgHbKDwG6NFdkYNA1DrbwEm6PbuKLHPM7ud6D5rj+MB7l4aZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWQ4rGRONkdS6MfpkUWMFk2IyfKOLivr6J/Y744WpJ4=;
 b=P5mc0DOTZHigbLpRtXynzLfbrQHaiiTuPF5T4jW1xTU7uHYkYWlFgjCkaTJehIVZyjS7Lmg9BDrQrdYO6i+J6qYuXTpG2DHcxQPnOv2g4nrVyGI1B5mYPMjWTiCjjNxHiyYWZjap77Cacy8Ljh2C7olMtrxdI1bMx5hLbdFMBW4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4525.namprd04.prod.outlook.com (2603:10b6:805:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 13:30:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 13:30:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/3] btrfs: wrap rdonly check into
 btrfs_fs_is_rdonly
Thread-Topic: [RESEND PATCH 1/3] btrfs: wrap rdonly check into
 btrfs_fs_is_rdonly
Thread-Index: AQHYdu5D1o+8BoVxXkCmw/M/kqtAAA==
Date:   Tue, 7 Jun 2022 13:30:37 +0000
Message-ID: <PH0PR04MB74161BAED56B59BE081159CF9BA59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1654216941.git.anand.jain@oracle.com>
 <0bd3d3777e34a5322fb4d3ec315df4090ee43399.1654216941.git.anand.jain@oracle.com>
 <PH0PR04MB7416C47B4A55666510F7FDAA9BA19@PH0PR04MB7416.namprd04.prod.outlook.com>
 <95980806-b198-d75e-d50c-0c18486da9a6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d967e910-e182-4b22-00e7-08da4889e8d1
x-ms-traffictypediagnostic: SN6PR04MB4525:EE_
x-microsoft-antispam-prvs: <SN6PR04MB4525586164CF3995C385A2F99BA59@SN6PR04MB4525.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovtq0FSAu2CD1xOO0npxjGYLrRhbJ6L/UHwVUZXEPvj0FZUnZwIlJqGeQiQtVRauaZUnFKwxUig8qrvU2NnQvXZ08XyNXGfGeq72RbT/hnpfmr9VBD2BCZhTBOk+oIR0WOMDcEe6+qPHMNJ4/xox1NTLzWHQl5TjPSdFubHXulxKwj8aeOooiHstbmSKZiCIYXZSo/DLtFtdz4EowByukae2Bq4NlqgKjpY45xKNQAqonDnnpqGx0hczzOuQO0+z1H+LBxcYE4FpbXuxhuKeXg1zWEmWNIpFucAgycyDGUTqzge2O+PmYAzLoHLh62U3mu3rBzTIN4MPq0M6zdHlVpDcLZC1UgkHzg90tfawWIyyAtiMdbYFyATS1uNHEzOrTcIJxGrNbK1FvFmCR6tqX4i3ganfHGuDUa4Hmv6ddB8ZLhneeM3tHtXuxBoBqG8XRGQECaN9U5A/vg7P9At62EFqB+vMojVl8N4oFKRdkPBUIm1oz4/rfJhddxMORjAqBIzMHwsxyZrbrptkQooWzLrYySQFoy6kHRWgma+N794fCpCoEJ4s3k2zI/TxkbZ7s4f+jamLBa8c4oHVOr6ztjoE9fOAme/9zfdryFeSHVQ1RZiWGGCExYK5M351i+vZv4C27JT00Pgq4JK3L3Vtf4rL/5yaBSaklbioXl/ngaEbSKranRvjTSe78EWtyxwjkdxNHvMXIPGLSfsrC6sUCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(186003)(4744005)(8936002)(508600001)(122000001)(91956017)(82960400001)(8676002)(66476007)(83380400001)(66946007)(52536014)(71200400001)(76116006)(64756008)(66446008)(66556008)(5660300002)(2906002)(316002)(7696005)(9686003)(6506007)(53546011)(110136005)(86362001)(38100700002)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?noW/sfloitAWfUypL/xMCY+nlqpi5N7VJVSMui4HHdyWRxqd1enNQfHji9X3?=
 =?us-ascii?Q?0+CdulUCsZnUUfjxgXB5561FfzLgyGSyocOYdRldijBCGuYNYl88cdiHgzfb?=
 =?us-ascii?Q?Fbtu54Wdre6YBufb+0UqgniPwQOvKG/gI4bpBfihjKDwSDQftpXemwYAikQJ?=
 =?us-ascii?Q?m0uHITBEjnqfyhpfscoztTk5dOC/V02qs/5Hi2dQLSytP5G/TTRbtqPM0TMS?=
 =?us-ascii?Q?CMRcA76SFEVO1yxLC/Hp3amiNwSGBU08RjnfBjQd8bLx8U0MLTBUA+MmQGox?=
 =?us-ascii?Q?bdMsqWIt/XolKQMnD9LGzCdiU0NHWa0l/uIBWRPRjjl6JKTV/nPxd+vcnrcJ?=
 =?us-ascii?Q?OvVQ4n0mwJYD83Jk0uwrFWKsaIt/QHN5LiZyWylP6osvz9Iyp4IWS24U4JRB?=
 =?us-ascii?Q?Lz3Tc63jf/VY9YZwTohoMtnLtiDeLOPj0CQMcD6FLEJ1J8wCRADC/562zBFv?=
 =?us-ascii?Q?crHzLZ0FZFQnnnnkYGjKv+GZks0c6yov5ZKA9P8WrBuj7fIDpK/eBUGNj4xe?=
 =?us-ascii?Q?eb7fJfiidqoA4Cxg4qmZJVQ9Ni599cNzsvrBYjBGb0DUdZ9HFNecZCueS9qU?=
 =?us-ascii?Q?bZJ5L2SpqtQyBAW5EnZmt1uUyXmCvhhBqvKezCHbDaSiq0GhUiU93fPanacP?=
 =?us-ascii?Q?IVMuHW0r41/F3j/KYcuxRTrDeKaLoHN/spx8+lXLDwQQ65e6xYU5tsbdiwFT?=
 =?us-ascii?Q?RUHYGYCsuXs4Ogfeum15Eh3wtXk1qdSIqrmRDPUUt0PWVdsuW8U4ba5jTHTu?=
 =?us-ascii?Q?rJjpkr0xJCacjGcw43XnhKjad6BmcSEirZFteVzxMaiv4vKSGvxJqVeRE40N?=
 =?us-ascii?Q?LsI3kV8g92HMBLPr9MgRJG/JKVD73Eo2JiTmj2R9oBLsu+u8yb6L0J2adAN5?=
 =?us-ascii?Q?EjmOUgKI52FFfyWtewWhZQm1MJRT20STJb34n3nAqlg1koMKMEvXka3BqRI/?=
 =?us-ascii?Q?DCF8sA7z4d6Av9BOHk6quj89IbmIrHFya9RzmIthhifuELuY7fbPbkCab6ql?=
 =?us-ascii?Q?jPqwpslpLO/NQ8RwczmdIaEEuELKPPmAe478xsFBDiHwZti4wknnG3PsRMeQ?=
 =?us-ascii?Q?yaKYR6JsdXX36EWPjSvpdw6aAZEj5rlq1OELYJecVorSAyD2rGCCSgGceU1H?=
 =?us-ascii?Q?2OqKs9nuXr3sfnapIfbBlvSNj7zn7xscGxDTbyj9r1Pcb+AXo43WfyDp7DRG?=
 =?us-ascii?Q?KufDTcgMJopQafRCPYoC84PlpVbcbV6jbjhMJ+qj+zxKm3iqixXW/PQaOidL?=
 =?us-ascii?Q?ZOA9FmG/i/0Pi2/TIlojTN0J/+9lbW8urTe57PGwX9DKIwTYnaefsF0YIpYn?=
 =?us-ascii?Q?3JO9uQZONW5JDqmDH5YpXp4kLqmO6QjzF+9gi0PcSWPFiMymuCD8lGqwglL0?=
 =?us-ascii?Q?/9aUgx/h+Yg/uNHWwid32cHGxBUlTyvbe99R+NUCkvZ/6jhEy+5MZt+99moA?=
 =?us-ascii?Q?85QDzvkpLJTcLU3Ttse4cYxQnbqHgC/sIP//aHnbn031f+GpTE1jNqOafSBz?=
 =?us-ascii?Q?sui5wjslm8tD6k4QXs0KXNIXS+DusvrZT3g6HSsuBuC4dhFEhkDzUR6s8EQN?=
 =?us-ascii?Q?oPnye7UnaGBtI8XxfSI5reerzC2ot79ovBlXGtKOXngyEmnkZSaFVBudWx7l?=
 =?us-ascii?Q?aXIBDpTOdM22T4/coGJvpO78YrfwyHTihMLKBj2yIJWta+X9sC8djUsy+Wgj?=
 =?us-ascii?Q?QvWa9Fcgny0XwOKQlcRjOnqgPvX5kKaFJHNLt2PDSFrn91980l5D4b4OqlBm?=
 =?us-ascii?Q?yCPXio4P0gBYvQlxS+2T5NUuqnzf1+bX6dqXoifF2IDSPiSrvThDmZi+CP2J?=
x-ms-exchange-antispam-messagedata-1: UgsH1oovyROQJqmdsy+FTZd48fUvqZjfJbg1BAPd7uROpOwDVnNdf4Qf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d967e910-e182-4b22-00e7-08da4889e8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 13:30:37.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InQd+5Z3T9oRVEQKwZ6K2jy1DKDrgOvEgAweStRIHsoqnJU+1KQeZoTF3vdfdYbumJIoqfLwyJSmLWRGvyOvjS68mQxBmGShSS2URAoNnBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4525
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07.06.22 12:15, Anand Jain wrote:=0A=
> On 6/3/22 14:13, Johannes Thumshirn wrote:=0A=
>> On 03.06.22 04:04, Anand Jain wrote:=0A=
>>> +static inline bool btrfs_fs_is_rdonly(const struct btrfs_fs_info *fs_i=
nfo)=0A=
>>> +{=0A=
>>> +	bool rdonly =3D sb_rdonly(fs_info->sb);=0A=
>>> +	bool fs_rdonly =3D test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);=
=0A=
>>> +=0A=
>>> +	BUG_ON(rdonly !=3D fs_rdonly);=0A=
>>> +=0A=
>>> +	return rdonly;=0A=
>>> +}=0A=
>>=0A=
>>=0A=
>> Do we really need a BUG_ON() here or can we make it an ASSERT()?=0A=
> =0A=
> =0A=
> These two rdonly verification methods should match, but we have never =0A=
> verified them. When this is through a few revisions, we can just remove =
=0A=
> it instead. I suggest we keep BUG_ON() a couple of revisions.=0A=
=0A=
But isn't this what an ASSERT() is for?=0A=
