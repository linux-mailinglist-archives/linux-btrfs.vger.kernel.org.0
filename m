Return-Path: <linux-btrfs+bounces-3646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0957188D3B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 02:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF321F26CE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 01:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C5B1CF92;
	Wed, 27 Mar 2024 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YrWJ5G5b";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WLX1uGpm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A40B182B5
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502639; cv=fail; b=mmLCIwN6/SpVLbCRyEYjOFjII5C9Yx6lCYxWBXCukb4kStf1YrtpRcQMQN4gviHcZePHFAv5QvwE/HkpS5p3YFeDhqv/ylZInXvmsgP/tjDCK36GpPyZfrxF1Ntzr6aZYrjsylBRoOhMJktJw7btg8tEHpz05NY86kLw8u6RPrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502639; c=relaxed/simple;
	bh=8SBtqWnOOEcsTIJlKZJsga3wMRo/004YmYNjKr0ngvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MuZeRZ8wdDtxWVtU5/LNv+GKBeOm2jfBdhccfevJ6WA4yLtm81Pp2CjT5Cz7XeX3ztJ5JZQsnT4QtpBb8GmWIqRcBstSDhpKqI8RBxKm61NA8ixGIGIBx/8PBaXHvwmLLEEuXN/9/3rpvQNSeQ/pnzMUy7NBMfVr7HFB/nPmd18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YrWJ5G5b; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WLX1uGpm; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711502637; x=1743038637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8SBtqWnOOEcsTIJlKZJsga3wMRo/004YmYNjKr0ngvI=;
  b=YrWJ5G5b2eaRhGmPzKYLg7Xk3JkjjAyeQ8tJEZgI/BeWXw1aGoLUZy1p
   Jv0jVCmFUi2nH5+LocgpdD8qqtq5/KKRymIsRhilDf1aOujtzTLQ5vUDK
   H43vdwHQjxN+D8fKW+Hf1K02Z09IGL+dUkFykQyE4O4jcKrmk57oPntZU
   Xm6C5mVQQyM2DKPGAE2YPyTndj0T9BUv1rCaGOLxr75xhXIaFKmwLlwyj
   iM3PRBqRFHOn0a8EM5SmgoCD0RwJaRLleTo/200lx3+qNDt0kFHHN8ass
   GlbxYr52GcT2+xU1NII1TKREk0QEm9lnVae9AGDYTeyyHYzU6anA6F5P6
   w==;
X-CSE-ConnectionGUID: f7PKkAOwQYy3ba4+PIpACQ==
X-CSE-MsgGUID: /ENlG22rSs2QEryosagX5g==
X-IronPort-AV: E=Sophos;i="6.07,157,1708358400"; 
   d="scan'208";a="12798686"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2024 09:23:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bqk7HOiR+kfZVcEUCpDD8w29kQaj7zZnfMA4977ofmOw7xTYvSUaSEGAlDJs0IRi9FI4f3OJcw2p0/K/h8KIH+wIDjhofNp4daOy2HpmiIG15uvriiinrRa3UG1n6UZMPNWl1i05NVQp1h4e4ZDwtNAf6A6KPgkuLCNfdRvS/ts7dY71fSbndJX3F/t88XNoVlENI4i7CWdPoIobpZwsPcgTefjpXVJ/OajZT0AiUqTDy8IDsKsJa/to81Q7xa4u9DnSvxVHHypqN1JH8bFM4IaxFzqmWa0OfOAbIPXMGQpYrT4diasyy/5uMQojEsrE1kfYNPBbwGF26XzJDSqXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6EY4oh/IxjAWT1RRlJAatuEgL1/X+pWJtytNYI44d4=;
 b=IuNxfDVKcbqS/yD17QifYwKv6uShcRwlGzgSVF7DOcQztIw13xY0MQQ/HVQ+9aqly0OMXXz2nYPiezFywpCr+PU4XFuNdeoP5O37a1E4qmdNJyIKh7cprhhQVzWCjhrqPJFlqJdWsHrHobIfuGqLUTfd+vZveClSUfMcXtz0kNF+mFLHZgZEDHeC3+e8+ZFVJI8lBHt82CetBPMMbuyMunLTQhNtFeBM65guXzX4ZU+zNodQ4kDq5iyAsuPjs8kavGoxitJ6uYZ3l9ug9ano1OKpdIAMIS4CqgkvJ8+WkQ6sk7fLXHhxrRXr4Ct7k36i9ti9R6PoUSmAnlCiSIbRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6EY4oh/IxjAWT1RRlJAatuEgL1/X+pWJtytNYI44d4=;
 b=WLX1uGpmOMVYGjZ3TMAjQl8C/BS4Va2orwK/v+GV5SvhPl1L3yAGIoKDCdqESxsJEQKYOilgJM8+EmMOJBpBzIExvklurxlguKEJ/fUrxiH6YjfHn+eRQwn5jlgb18yk0CcUEw6YnSip51jPAAKTBh1+dpx1oirTI+HtEv5W96s=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CYYPR04MB8812.namprd04.prod.outlook.com (2603:10b6:930:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 01:23:54 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 01:23:54 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] btrfs-progs: zoned devices support for bgt feature
Thread-Topic: [PATCH 0/6] btrfs-progs: zoned devices support for bgt feature
Thread-Index: AQHafxPRP/vBtISeoE+UZGoXHKRkorFKzLSA
Date: Wed, 27 Mar 2024 01:23:54 +0000
Message-ID: <xhsex7cyjbpypcwsxlsn3vjhcm7bmjux3hagsfmf3wr3w57qem@s6degnypynef>
References: <cover.1711412540.git.wqu@suse.com>
In-Reply-To: <cover.1711412540.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CYYPR04MB8812:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bcEYUrGG45/xflIRgtCS5fKSPOMMJfp5IG38ZNE9NUwP50H739E9US6q/dFnjughYHcrLrVc6ARoBDoBJ7AyIl4IGitD2qGqB3MA1IN9mI0ipJDw8k3/Yb7zcbPLyiRyhE8yCm5si/JFq6ldOaJ0kc3jLu32ydxci0dc5NDEJh0NyYjWG9mIlj/cejxwpOd4uWQ5vmJRXaXkv6Blutft9zKNhnvj3iyc451MoE4wUmFHRBwpFkYCdhMHdQyaXBAZ9VQKXYzmTJlj/A6PEmxwNlXREnZdOMKvunFPO/FiuGE3Pk/VROQVpNFVsjJTZaBxsuhgGKa5DuOCavWiLXnMbTMy7ra5crNx6SYGcZBp+xBygw9Q3x3ayyeoFM8j0Mqq+FnucAUBdwr4Y2zgxq4YvDZlMnhHag3vYfJ9Fc1Yn6FCk+GY88lP7NHRR4FwogZ5lyUQpZPDOAOu2gmcsV/TtuVNSzPDcX+dcD1SeurUY32TqC+vZKRiYFvR2QPGQm3ZXt11tk8v+JL5Sby3uPrfYEvcr+4jGaokeDPQE6WKQcfOBjO1w4X/8K2IWLedd/T8AS3vkZAyXbad5krE9okDgH0WBtVYmIjV7PLBCDvQVkbK94OY2uz6qnyqBkcYBsbHT2lu/s0tBhvCUCdLm0UE4MG1sHmq+7SJ5K/69d2UlV8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VAn5jjEJFwoyX2WfnlbzfPRRhL9jooRngoFPZHPfTBLMzl2h1O+AhbCXg9+M?=
 =?us-ascii?Q?eVa2KdoZ9zQEQOc3cy8UT2y/GL/eR38Y6/TkUlqB7iPNt9LiUAYt2kTOnDNa?=
 =?us-ascii?Q?0OOHSYxkfKjqR8j/1zZlm5z21umIjP25ynIQVbD9nLiKf9ci++G63tDuq2yf?=
 =?us-ascii?Q?3/yQ7UVburcpTnMNTMV8/Tgqt/7atjG92SID71BhLuoes1STsDbbpMK0tcK3?=
 =?us-ascii?Q?OX+t35hf78k+fOTOKIiTot7q3+ZuIU1WW8OFObY7I+2E2rRC5mKeYrCZ5pCf?=
 =?us-ascii?Q?em8mD/xc92C+6AU6jefBERGXuwyEgflWEDMyiUkTER4x41Ck67UN0DwtqgqM?=
 =?us-ascii?Q?kCzKQLbT9C1Je1XGTanInX5XDV6J3zaacDlL6HUWnxDtXFpIs9hKbRoRhn3a?=
 =?us-ascii?Q?HbmHVF4/ddCWanGoTgK2BZlIUsdZb6lvo7LoicDCRyCxBZ7poSGaXsVhOpE1?=
 =?us-ascii?Q?PrjoghDkFo+zCglyH65TGJZ+hO0EVhAgwQqdYhpYZuOfS+kFRGx9EvakFDpd?=
 =?us-ascii?Q?LH9HX+bKZrAi4CSy3YU3HCmtItoVwhBJKF419sGvRs1h8PGtSR0o6KN/PNL/?=
 =?us-ascii?Q?CA0i8NIRkcMBVRye5LkNV4TbXjs8udbuQdw91osx9vXbJEmJzVkuQuaHthfJ?=
 =?us-ascii?Q?RBFQjZIw1d6YaoJfxfn2ip8tiiToeYBM6Cyy/3j/FJWUeKmMrFSNZlBKshwb?=
 =?us-ascii?Q?qKCITS4AQmwDZ4mNTzVnWLZ4QOVEEGdjMOEpmmi9cD96kqPVJfa+iYFnWDr6?=
 =?us-ascii?Q?UsgNxuk8tQB0/T2+R/4u44DDfsV/6VAXIn0OOeL1Jc0zl6Y6j2bVOXojxrRb?=
 =?us-ascii?Q?WMLHRUeuyBcRtBWqkDWJp1WjrfRnyFrqgD3u157ylWjCQtHlOOldj7rTU96V?=
 =?us-ascii?Q?bYA8R7cA2StxnMdyUxl1KslX/Xggtj2JufcAHDnurMbJvK66KcNcbEnGSLQR?=
 =?us-ascii?Q?9aJ17h79qJOeaDGez9j5a23hnZJ8rCKwZ3Fk1mkI1hpjTgdiMiCeoBfIDmJd?=
 =?us-ascii?Q?Y+6x99S1xIZrGpJTbYgvcoz3IuE5EsRYrx4DqvcS3BdrxOcrZHOBCG91m5Tr?=
 =?us-ascii?Q?cRfGeUZKB+PPi+IobzNiSCekcuB79tZ8+hQreDBpN79lKBynSQIaL3HONAiq?=
 =?us-ascii?Q?rt+VH+fOb94Tn6GizfpwlopQqs37zGCCEZJ8uQFNOolJvuoc4qBLHvE50KUZ?=
 =?us-ascii?Q?RjOUU7Z7Dbw7vP4C72/2N4mJOcb1c2AexBjlK5r91x3rCnljqKwP3SEjheTZ?=
 =?us-ascii?Q?pfLNaEDzxXT0PqEJeEDsHaxWy61vp4Jh4Sn94qc68rAc5zwCpeJAlH39ztg7?=
 =?us-ascii?Q?jNLjwRfgcngc34cML8YM+9l8Ge83XV/L6jQPb2Gz5Be8lAJjgvyUAeQWowBv?=
 =?us-ascii?Q?Srno3bxsIrgpMN7d74Uwcw0XC9RcAiMpAtnZfeDHBLN1jS6Q0D+rlQOhu359?=
 =?us-ascii?Q?/0GD+gggrAiIEd+26F1zqfcWlaibV7tXSv3u9g7gnbvo+gb6EVs+R24pqIsq?=
 =?us-ascii?Q?EKvx98fcTtUvDcpKof4H7Oda4ypAht/MCAXzpPhvKqtpQYadad7XlJXF5z8e?=
 =?us-ascii?Q?s/M/iBDlvBCSGGAJWVFOEPiLK4zS3MTSkFRWPi7WrqGd/37kLBwS/Lsg0ztg?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37CBB77FFE866A4394D49E6AE7E7F6B8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cSm9aw0zobpZL6QFbF4Akcq3CHANKF8/lwS0W3W9ziPJr7t4ksyxH59xwKxNOglF8boZ2MtzhT8Z2hwytPGglhDXNMDYB4yPQV5Hq+bevwuew+WfGIXHTYu2pjyhnviYkhHJtpHyyKExFaSXjIS+EGnlamssD+Of4edq+ecGCl12BnOu+ze3amDNrQ5AeeddhoHn2NWx7FfOg/m5TDPZslK4x/JOPG6OCU3R6bxjXLEL+EtYeBL7JL+UM7niN0+6T2Efb72WZb0REDRu1udV0p5/GaRONs4pBSA2oa2S7mtU+vAyHHyhMjEohDZgPD5r9ELNrILfd6SLu13sdmv77LojEJgnKHKwOVAnLxBzaO0kGz65Ld06sIIZ9Jk5IDrgfB69bWAMBHHfSwrKvjoxh4j2VpxyuY6k1mTSIdcWU2S6gGSuHql1yrO6044GOnuupOVLsMrpo9Uro+VWiUSb3TKNXuWBtvd/nJzUNmr8yHfkv4w0DK9k2Lo8V/VNRYkB8xRhTUxpNWIoN1CVFZ6GNcASLH7loWNoczMKmUY8c4bsoVjdNzCdWjhAMjUipfDL+qD/nutVBG3GZHcGXkJP3ipAor7B2XjUvYfjzikmakf9tuDcVeco6YvQ5LFIPCk6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db826bd-a0e0-453a-f3cd-08dc4dfc9129
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 01:23:54.2164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeUMVdUn2K/VOfwLuATI4TB2vdCnDs/OxSnuYOXoUiLAIzrJ1fTRHoPWzkH1S64WDz4nPfDm4PE1oWT81qTlkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8812

On Tue, Mar 26, 2024 at 10:52:40AM +1030, Qu Wenruo wrote:
> [REPO]
> https://github.com/adam900710/btrfs-progs/tree/zoned_bgt
>=20
> There is a bug report that, the following tool would fail on zone
> devices:
>=20
> - mkfs.btrfs -O block-group-tree
> - btrfstune --convert-to-block-group-tree|--convert-from-block-group-tree
>=20
> The mkfs failure is caused by zoned incompatible pwrite() calls for
> block group tree metadata.
>=20
> The btrfstune failure is caused by the incorrectly opened fd.
>=20
>=20
> Before fixing both bugs, do two small cleanups, one caught by clangd LSP
> server, the other caught by my later check on the test case output (a
> missing newline).
>=20
> Then fixes for each bug, and new test cases for each bug.
>=20
> Qu Wenruo (6):
>   btrfs-progs: remove unused header for tune/main.c
>   btrfs-progs: tune: add the missing newline for
>     --convert-from-block-group-tree
>   btrfs-progs: mkfs: use proper zoned compatible write for bgt feature
>   btrfs-progs: tune: properly open zoned devices for RW
>   btrfs-progs: tests-mkfs: add test case for zoned block group tree
>     feature
>   btrfs-progs: tests-misc: add a test case to check zoned bgt conversion
>=20
>  mkfs/common.c                                 |  4 +-
>  .../063-btrfstune-zoned-bgt/test.sh           | 55 +++++++++++++++++++
>  tests/mkfs-tests/031-zoned-bgt/test.sh        | 40 ++++++++++++++
>  tune/convert-bgt.c                            |  2 +-
>  tune/main.c                                   |  7 ++-
>  5 files changed, 103 insertions(+), 5 deletions(-)
>  create mode 100755 tests/misc-tests/063-btrfstune-zoned-bgt/test.sh
>  create mode 100755 tests/mkfs-tests/031-zoned-bgt/test.sh
>=20
> --
> 2.44.0
>=20

Looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

