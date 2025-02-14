Return-Path: <linux-btrfs+bounces-11464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F36A35B9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 11:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85AF188E918
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 10:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D59022A4F0;
	Fri, 14 Feb 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kr+Er9RT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e3DLgre9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7177209692
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739529245; cv=fail; b=ajw+pwA5QCj30sb/YxS1O0V2Sh/Ea24D012pSM7LiIrtnezSdnU2gT09I85yguWcoXtgpH51mWloJHu1pXUMAKuN0fs20K/FJDri2+vqvTN0fBvk5TupRgD5kac43WlaIKFXUsZKMcfySMl6EoAuOA793DbuUvk/Moc8AzVipxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739529245; c=relaxed/simple;
	bh=d6/SoKTLn3dL8NcFtA+8BxKom6ioouUKnHTHi5kQruY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=It5OnzoxzalNi0sVPboUVWk6cgkpbRpgLtCmjFB8aevPiHOjBeZbpnwoELvfBld/9Bbvap40XoQdKxZsnsoIVNqvrg/XM9eMo04NZ3AikJuYLI4plYG1/8AgKezMd20CES7edGY/fYiGU5tOhdC+KyRJp07PskXXfd9ZOyL7OTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Kr+Er9RT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=e3DLgre9; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739529244; x=1771065244;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=d6/SoKTLn3dL8NcFtA+8BxKom6ioouUKnHTHi5kQruY=;
  b=Kr+Er9RTsVAB+QY5E59fb7Rx1Psezcs5AXUBlPCTGHcur2sub7z0ySXi
   ZqUFqqUvUKGwbFqul0uX12meNL7WXgxwSXPeNGlNawS5A9NvhLXjgODzr
   6QrK3xgnKob3XUFbEPsASW6ywxQWXMt6lDkepyvGsIbf+EbpQfrEv/4HK
   LA2RnyLzOB0WL5u4nCnMakaZdQgtToM2wOmLhZuS22jAl5UX1MBN2Dxt1
   B3i9FZmbfkbSB7F1v1CXXUiundwD6IIuPcS5JfSvKNegXdPh2sMqaQyxC
   +t4lE8i1X2y1NvQrVEPscZvmoIuHRsb0TOV8zS7KXIao2N6Z8ooJdDAmz
   w==;
X-CSE-ConnectionGUID: laSVa72JSjaDbMV/2PrAoQ==
X-CSE-MsgGUID: 7BOucKqSQOOM5JvvWrmJfQ==
X-IronPort-AV: E=Sophos;i="6.13,285,1732550400"; 
   d="scan'208";a="37911674"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.10])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2025 18:34:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRY9Y/CLJuFx+9AEAcRghY1Sv+cwTfFyaPXJWkliwaqXkzOHRc+vW/SSJyXERJAKr+qo0+X1aHfBsDr9DNlcvNGGsODLaEbkxadTVgRvoxOJGi/YqPGOPNL294SfVNJyGvMgrSjHQFaZ0ziqvMNsz/cNTAqsq72yauKxiRXUOBJrWSiEJyp6QSs0GG1D7r0D1zU30eAjqcwPfY/ltUClRlcgDN6D0YS3pQ1YMw/zhCknoMCzqRhMq4ju+6z5YZLzqtoBtjgwatc9GEDhdaCEYEKIhafm20nyyoy8qVHP5Sd1YQTO80/Us/ukiwCyZOKpMtuFbqDQQJ7bGj4o5s7qVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6/SoKTLn3dL8NcFtA+8BxKom6ioouUKnHTHi5kQruY=;
 b=cku7fFmH/ogO1QeFBoY2ScltSUT/JGmcnT8hMbQKoBebvphl9DDCI113ut1u3p8lpcMK33v1jI7r88AcmBPWUmqD48bgxp1OqhqKmBsFCKAxUaJ6Ymu7sp1wmryzBXTju5XpJnkmVKTCjlE1lmTLtUzwuCRSMRQVbOoplBgyrpbQB3AA49omjbfFsN24SIVgiPX9oxFSKfNISAzWgyikJvwQpCNhx//u5fCyI8fwz765XXJX//OJHEwyMq3p3qJskLTRmfRPBwzNB/7UjoUHMQNLzHqql/q1gW7PoGkXHVAPVjwI3bt4JVmoo1MlAYmadaq+Drn+kjaUBqfGhEh7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6/SoKTLn3dL8NcFtA+8BxKom6ioouUKnHTHi5kQruY=;
 b=e3DLgre9Y+qu0p9EDHpK+EKVYHxL/s6yFFsostPUOtRcOaXRT/PodfQTSWY7/GMzmIQ5b2+63IXQPbeU8MKATL2Um50iVmcDghXdxfUdp2kt896rMb8z1gnKc0uEtpvmXTJS8SUoq1+YFUQTjFVDK/r0Fnxqp4h64reyS1z69x8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7833.namprd04.prod.outlook.com (2603:10b6:510:e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 10:34:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 10:34:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: docs: add an extra note to btrfs data
 checksum and directIO
Thread-Topic: [PATCH] btrfs-progs: docs: add an extra note to btrfs data
 checksum and directIO
Thread-Index: AQHbfmLrNw5E2XboGEuHaOFtF16v+rNGmyOA
Date: Fri, 14 Feb 2025 10:34:00 +0000
Message-ID: <664b9636-098a-4847-9d0d-34f699a64eed@wdc.com>
References:
 <b7dd4b16ffffa1114177f37bc349d437fc51cc63.1739484084.git.wqu@suse.com>
In-Reply-To:
 <b7dd4b16ffffa1114177f37bc349d437fc51cc63.1739484084.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7833:EE_
x-ms-office365-filtering-correlation-id: 39d4ce71-a6e1-4a8c-3d78-08dd4ce3185b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGhqWStnS1hXdjczZEMrTUhMQXZpbncvdVdkbUJ1TGRHZk9pM1kya05EcTd0?=
 =?utf-8?B?Ris3TU53aDR1VGJIRW1JRC9BNWpCMzZlNldUSWlTZm1OakJTM1Z4WWozNjI0?=
 =?utf-8?B?Y25RM3FvVUwrbm9Bd0tVajJQSmlQWEFjRG96dUNUcFhTYWtQYjk4czJ0SlBH?=
 =?utf-8?B?aE44aUdBWmt0RG80V3ZQMVVhYVliVFVjeW9IU0Z4YmM5dGpISjFrdGdLWXhR?=
 =?utf-8?B?L29FaGdCTjRKdUNpVTFyMDFrQVMyN3M3NXl2OFgwU2gveGJkNEhKTS9GUW1w?=
 =?utf-8?B?N1JBcXEyT2NlOVhRa2ZTRndlcUVJN2NQK0dRdXJBZUtvWmdUZWNNdk9ZOHFC?=
 =?utf-8?B?R21RaXByNVh4OWpoOXFDcW94bHJxZmdLdlhLTUppRC9sMFl5SVZqOUxjNFlS?=
 =?utf-8?B?dGtDQWM3NkVvUGMrTENjbE4vRFAxWThtcHFhZ2NwTzVSdGZNK2syRDlLd04z?=
 =?utf-8?B?cFVVa2s5Q3M1S0U0cFc3NGJZeERtTE9DNFNJQytIMVRDWnh5c0s3MnBvOWV4?=
 =?utf-8?B?YlFQeVdia2xZOUZLVWdhVW1qTzFrMnorNmRKSkZkZ2xMbVFQYmVwU04vcERq?=
 =?utf-8?B?RFNFU3Vna1EzZDdCSHd6M2RpRW84WXNVYWV0RkdHQks0MHBEU2RCZTFqWTNl?=
 =?utf-8?B?cWoyWjBzUm5qdFZlNFA0a2s2dU9EcE5OMGYzcGlNV2d0SUdGdlp6czMwN3R6?=
 =?utf-8?B?OHJRN3pLVk1MR3ZDTkZhRU9adjQ5dmNOVFc4KzkxSm5NZHZUT1BvZ1Q1V1lX?=
 =?utf-8?B?ZjFFNU9qYWxXUzhPelduYkdQMEFRVXNZRGJhSkkxeG0rMVhrVUZQY1g1Z1N6?=
 =?utf-8?B?WE5wK1BOZTZSL3lUQjVGWkVmUSt4dmJjdW9PQ2lvNWpDSWJiSEM3YUVRUWpl?=
 =?utf-8?B?WUFzQzV3TGhlczZXcUNlUUYwUHlIeUNsdVE0TjBMVDdXaWYzclF6dEw4VWpy?=
 =?utf-8?B?cGZSeVhlT1ZOOHJva2ViZjgzWFV2cDJ0M3daa1JLTzdGR1lBSzdWWjlrbVNt?=
 =?utf-8?B?NG8zK2plZ1QvbmQzbTN2VFhJL09UMUJFRjgzN0ROUnNjalpCL1Bic3R1cFIy?=
 =?utf-8?B?NHpVdU5hdTROVG1laUMyYjA5aGZ5Q3Byb2U3N0xhRmNvaUkxcHZDNU1QQjg0?=
 =?utf-8?B?WVVWL3YySys4NWNmR1hTVWpURDYyTjdIR1o4a1JkKzdsN3NzTitmcVdZelgz?=
 =?utf-8?B?K1puWjdwcU05SnNpVGIzU1dPN2RXMDMxamRidEJUNWhFb3hIeWlPZGx6aGk1?=
 =?utf-8?B?VC9mb3FFNzJmY0UrZGI3SWhucDczSkhpWXNkS2pmK01mRy94Mzlxcm05WHRj?=
 =?utf-8?B?Y2NHT0ZLNk9ZU2RYZEVQZS9RNHJvajVRcDc1VGI2VUh1RS9ZSUcveU1HZVlv?=
 =?utf-8?B?aHI3TnU1Q1Z6Tm5iOTRxa2g0L2R6TTRQSDA0bDVlRzlOVStDZ0kzbTJSSm5Y?=
 =?utf-8?B?c2JoUHNiMVFFNzZ4ZG1pT1RaVjFwV1pwWWpINTFZd2lPVU95TzgxVkFJKzFX?=
 =?utf-8?B?MlE3bzUxWEZmUWtQc21IVEhuWGlDNWRYdHBBaFA0S2p4OFIrS0Y0UDgwNkNv?=
 =?utf-8?B?ZnBuQ0xJcjBMVEJkQm56SXNzeFArU1FaSk5lUkY1bVlnNkUrMFhGeHpOUDlJ?=
 =?utf-8?B?QjJtN0ZzNm1wbjhwNk51eGJYQ0hyQlZyZVNCcHB2ZldMODI3NDR4Vk5zbHo2?=
 =?utf-8?B?elRJbkNqL0N5WjB6YlNRSlZmSjNkbkNWMWNCWWVPc09ackhKZkNzTm1EalNL?=
 =?utf-8?B?cU93ZkpjR3JIT2cwZVFnZHFFL01qNTJCM3IxTHFSczFrMCtSc1dXVmZJZk0z?=
 =?utf-8?B?RjVDRXBVQXRUYVlWZ2NhempSVURJTnJUeE5wdGFYOU5SZnR3Q0VCYlBkanMv?=
 =?utf-8?B?Rm9FdWpkUmsrOXNkZVp4T2phcFVJcngzMEVzU3pSdWFxQ0xDVTYwSDJFRS8x?=
 =?utf-8?Q?YFrb+PFCqkK/PxEV34dCH4Jsplrvzec/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzBMdEZxY2R1Zi8rNUZXL1FOeWZmWmsyR1VGcGRBREF0V1NIR1RMZEpsbzR2?=
 =?utf-8?B?OEdVTUhyN24wNFY4Mml2alZ3Q3BHYUpLUEp1MkxzbTBYSkM3L0duWUhNckti?=
 =?utf-8?B?d21mZ2F2UDE4a2tRT1hhNit0Y1BFUklLOUJNam4rMnA2SVpvUXZjUldWSjR6?=
 =?utf-8?B?VWRzK1kvOW5JL1UzbHdGRG1RSzhiYWdJN1JHOFZlb3QzSFY1Z0Zmc2wySklp?=
 =?utf-8?B?aC9ZNEtwUHhxZndFRFgrcmozRUI5cWtxMWlqTEhiSlprSnM1ODFVc2d3MmVB?=
 =?utf-8?B?dXcyZjVNc3Vib0xVc0FoSWd6MXR6VnljbTRaTUt0SjlPM1ZXbHhDYnZpNXly?=
 =?utf-8?B?ODNjTlhSTkJvMlliUVkyU3BkN1ZON2E0dExSakpmQzVVTlQ2MGlnYUp4THVT?=
 =?utf-8?B?T3lDdThsam1Zd3I5QWJSSVFmN1VpSEZLc2FCR1NJVkVKWUo4Q3RyR25sMFM0?=
 =?utf-8?B?U0dXZVluTlVTVHdrcXZjalFlY0d6T1ppb1ZSVDhTNTRxOWIzeVB3WHZNOVdB?=
 =?utf-8?B?Zk1HY1NZV05HN3lBQzVzYkhjR0dGamF4d3V5Mk1nOWl5WkRNT1NJR09yczhK?=
 =?utf-8?B?blhhbzVUS0lKSmV4TzlqZzhodlpRS0RQYlBKYWpIMzdyOVhjUitQNWZ5YjZP?=
 =?utf-8?B?Q2t2bGtTcXJEaGRpR0sxd0RkcFl4OG1ZSm41dys0MXVvb1doSG5rRXVUbWpw?=
 =?utf-8?B?QlF1OEdSOVJ2WHV1U2ZCd3loMFpZMno4eDJwa1IzUVBtclJBSjlVYkZaWWNE?=
 =?utf-8?B?R0pPQytSVWNBZjRvSG9Td2krMU1PdVBjQ3RhN1I2K3dPK21YVlVRL2d4R0lP?=
 =?utf-8?B?b2UzYUd4UklFdmk0eThCV3lyWEVSWWtNelZsMmNXY0ZaNHEzb2x4aktSZlpw?=
 =?utf-8?B?ZTVNWVVHTkFvMmJLUWpKMjRybUVWb1lYYThXNk5oa2NXd0ppaEVJRXhmZEpB?=
 =?utf-8?B?Y3RCdDhKWVpEQVdhRWN0T0ZlUkJJcW1INlVQVkVFQk9hUTVYRVdZV3BCVHR2?=
 =?utf-8?B?T2Rya05hRnNkcGYrdzN6T1FCUWxSWFNlVVowUE1LNTNMVk1ISXlsM1NnODlx?=
 =?utf-8?B?ZkJzRXQ0N2lyaDJaZHdIWUJra3pCaHg3NHI2RThDcFJlTnFBZFlQc1hoa1N6?=
 =?utf-8?B?SGJjbm9vckdMRHpiOUx1Mnk0WmVncVBRblN5dExOSVQzNnU5VFJLcUZUNTMw?=
 =?utf-8?B?VE03K0lDUzBsZmZtQkR5Nm5GZ2x4dzE5S3FRS2o0MUw1ME1WendRajhoaXRa?=
 =?utf-8?B?QnFPUXdRdTBJUHF5cEhPaWYzRVozbEZVTFhBRjlBUlVKNnhwRnZ4WTRmOFVs?=
 =?utf-8?B?UkMydXk5cW1NWmlhMk1FNEFQWnAyNHd2blJyY0tvbEtWeHppWm5RN25xMUdC?=
 =?utf-8?B?ZjNybDN4eUdMWEwwL3FFYnpXVXU5R0NHUG40alVJL2VZNG1RKzlZTkJoTXZX?=
 =?utf-8?B?Uit0SCtTd21TOHdZT05tV09LVFZ2QW9hTFJ5RDIxODYyV2JTYUp0NXAxdlJZ?=
 =?utf-8?B?SzBNdCsrcitnTTY5QnV6bEcvSXBEcjlVYXhJajczU2NTWXU3aGgvQW12K2E5?=
 =?utf-8?B?ZGRiQmdaNzkzWlNZUmlRTzVWbEpvYndYSFFZUHFMWklkUE9lWThZTnJSQVRi?=
 =?utf-8?B?cUhXcms0TVZaaktjYU8wRFlTb2JOdnhTd0VQaTNJUEI4eEh5OEUwblFhcW9h?=
 =?utf-8?B?cGFtZjVCS1pGL3lPdEdQbE5kOEx5azJrb1JvakJRa0pKVWZVVmxaNisxaUlz?=
 =?utf-8?B?ZDBCZ0ljZThYZ3NKc2dQc0QwM2IrdTJxeXEzck9QOFBQR1ByODl1YTBkQjkv?=
 =?utf-8?B?K1NQR1JBSXVzclVZQVJMMmdlcmI0ZjlFdHAxL3gvR3ZmdHdkNnJQdHNCQTFs?=
 =?utf-8?B?dGpWNXpDTEd5QXlnRFErQTFRb3FmaEM4Rk11N2hQVTgwRWxyRnJOeUdLN3dB?=
 =?utf-8?B?ejl0SUNBUGdEdUl3YXlNL2ZpdE1rVTQwZXRyc3BaSDBwcVdBZUtzdUhsSlZp?=
 =?utf-8?B?RzhVY3dUWTlsYU5iR2xxS0FnbU83d3pEcWdjbXBuN3ZOVmFRTThVa3A0RFRk?=
 =?utf-8?B?bkJJazVHVG5DT0VHTWp6RVhJeXNyN3RDdkREeGp5aURkZXV3SDRYL1VhVXlR?=
 =?utf-8?B?SFFVaGZ2ZXg0T3pjZjNoUnptbGpDS0tvQ0NYb2p4R29IMkMwNW8zdTVja1BP?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C050BF1F15D6164081054664D0019CE5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fALroBM5gzer8tzJ7habNjAgZcUL6QzBo8MGxRBropRECjF4Un8397gz9sAttSpTuaiIwvjJlHXcrkVeaYBUIjxhNw8Sv2bHkMNyLdcXGdvevtVx29dfkFYAieqVe5ivhodlGwPAwcYW5diZTugwaQ2fWRg+58Ppg6xdQu33W4nax16/1oS7AlPPv7hU9Pl55Op9nuR62Wl+Cxd3f3zbeBPGJZIZu0vDPujkKA4f2/9tUUPnHDk9TPBfRkT5qj7YkSnp1S3lG4KZBoa/VYrRFIhDS75pXczJyElz8P2ihevT+/M9CAiGqhqI5jwQT1CpH90ZPAe3rkrNqhhqCoAB7WACuzGpjVaEHEwwuZ3L8V8ZMv0S+9IqOO1j6R597cISx5D6eR7si7Y+y6au4HLGXhbQOkSDi/+dmCJMrw9z0liLhRvbljzg+cspCkUvITqOPY7SsfwCYjkjWrOh4/0gFyeMJoTcmJUHy6r69WEIchvzhw3+NKD/iYLJX4HdhyHUSVTMixI9iz3tXtSYXRMDQnhbfDzoS1jZaoG5shr9vMDkqxZgWgVkKF6pVZ4qOy90pOsBdQlmKNIZIfuFNCg+aOa+B88RtN8O3N6vaenXuALD3s3X2gOag4pohRa8yOSu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d4ce71-a6e1-4a8c-3d78-08dd4ce3185b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 10:34:00.5859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycPXaNJFfTLkql6EfLIL3CeGaW5dnpTjAuEBDMmrjin5LNLW2lgkfj/W9i3Yj6fBGdo56D46OQNVE/WOE+ZfR7hDEGePWUie2PL+H8lr0nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7833

T24gMTMuMDIuMjUgMjM6MDIsIFF1IFdlbnJ1byB3cm90ZToNCg0KTm90IGEgbmF0aXZlIEVuZ2xp
c2ggc3BlYWtlciBlaXRoZXIgYnV0IEkgdGhpbmsgaXQgc2hvdWxkIGJlOg0KDQo+ICsuLiBub3Rl
OjoNCj4gKyAgIFNpbmNlIGRhdGEgY2hlY2tzdW0gaXMgY2FsY3VsYXRlZCBqdXN0IGJlZm9yZSBz
dWJtaXR0aW5nIHRvIHRoZSBibG9jayBkZXZpY2UsDQogICAgICAgICAgICBefnRoZQ0KPiArICAg
YnRyZnMgaGFzIGEgc3Ryb25nIHJlcXVpcmVtZW50IHRoYXQgdGhvc2UgZGF0YSBjYW4gbm90IGJl
IG1vZGlmaWVkIHVudGlsIHRoZQ0KICAgICAgICAgICAgICAgdGhpcyBkYXRhL3Rob3NlIGRhdGEg
YmxvY2tzIH5eDQo+ICsgICB3cml0ZWJhY2sgaXMgZmluaXNoZWQuDQo+ICsNCj4gKyAgIFRoaXMg
cmVxdWlyZW1lbnQgaXMgbWV0IGZvciBidWZmZXJlZCBJTyBhcyBidHJmcyBoYXMgZnVsbCBjb250
cm9sIG9uIHRoZQ0KPiArICAgcGFnZSBjYWNoZSwgYnV0IGRpcmVjdCBJT3MgKGBgT19ESVJFQ1Rg
YCkgYnlwYXNzIHRoZSBwYWdlIGNhY2hlLCBhbmQgYnRyZnMNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBieXBhc3NlcyB+Xg0KPiArICAgY2FuIG5vdCBjb250cm9s
IHRoZSBkaXJlY3QgSU8gYnVmZmVyIChjYW4gYmUgdXNlciBzcGFjZSBtZW1vcnkpLCB0aHVzIGl0
J3MNCiAgICAgICAgICAgYXMgaXQgY2FuIGJlIGluIHVzZXIgc3BhY2UgbWVtb3J5IH5eDQo+ICsg
ICBwb3NzaWJsZSB0aGF0IHVzZXIgc3BhY2UgcHJvZ3JhbXMgbW9kaWZ5IHRoZSBidWZmZXIgYmVm
b3JlIGl0J3MgZnVsbHkgd3JpdHRlbg0KPiArICAgYmFjaywgYW5kIGxlYWQgdG8gZGF0YSBjaGVj
a3N1bSBtaXNtYXRjaC4NCiAgICAgICAgdGhpcyBsZWFkcyB+XiAgIF5+YQ0KPiArDQo+ICsgICBU
byBhdm9pZCBzdWNoIGNoZWNrc3VtIG1pc21hdGNoLCBzaW5jZSB2Ni4xNCBidHJmcyB3aWxsIGZv
cmNlIGRpcmVjdCBJT3MgdG8NCiAgICAgICAgICAgICAgICAgYSB+Xg0KPiArICAgZmFsbCBiYWNr
IHRvIGJ1ZmZlcmVkIElPcywgaWYgdGhlIGlub2RlIHJlcXVpcmVzIGRhdGEgY2hlY2tzdW0uDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYSB+Xg0K
PiArICAgVGhpcyB3aWxsIGJyaW5nIGEgc21hbGwgcGVyZm9ybWFuY2UgcGVuYWx0eSwgaWYgdGhl
IGVuZCB1c2VyIHJlcXVpcmVzIHRydWUNCj4gKyAgIHplcm8tY29weSBkaXJlY3QgSU9zLCB0aGV5
IHNob3VsZCBzZXQgdGhlIGBgTk9EQVRBU1VNYGAgZmxhZyBmb3IgdGhlIGlub2RlDQo+ICsgICBh
bmQgbWFrZSBzdXJlIHRoZSBkaXJlY3QgSU8gYnVmZmVyIGlzIGZ1bGx5IGFsaWduZWQgdG8gYnRy
ZnMgYmxvY2sgc2l6ZS4NCj4gKw0KPiArDQoNCkJ5dGUsDQoJSm9oYW5uZXMNCg==

