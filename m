Return-Path: <linux-btrfs+bounces-9169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A4A9B046B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3347C284397
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C839A139D04;
	Fri, 25 Oct 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X/zBfR+z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="r+fZCRkS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A92F3B
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863984; cv=fail; b=FnZI0/p1aG850SyFv0K9HRMGAGAdVRJZpiOsfBbrgLHUk70By+XAc/3l0p8ok24knWglQqkHVwCalE4a2OXQBC/bT8peg/7ea/3uBx4MxfHDZqPV/Ed+b0qNDpGKIW2uYFMkqSXQegoroF3DCmIcnRT2SzZAxzrZAMSajMB6ifY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863984; c=relaxed/simple;
	bh=0yvybZne2fWWXmVWhP8hdIMs4vqQZ+S29xXRc008Tpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QoWcdirrAAdk9ZkB/ZPE1b/FtDwRgABNO8yMh7Y53ng8gdRHQnmEUTK3IIU661lURd1EXCZezOSB+1eEzvQFZZo5/YycLm4ez8ccT0hCfbVQoE0YrOmM5fyegRI6FyvHrjrmk2zZpOx1IgDdudhWBvw1M+03dHBCj+R7AF25/b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X/zBfR+z; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=r+fZCRkS; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729863982; x=1761399982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0yvybZne2fWWXmVWhP8hdIMs4vqQZ+S29xXRc008Tpw=;
  b=X/zBfR+z6T32BxemNzQ3gz92lmrvq7/gZ9v8KyPTUEIMjdCFLb7L4UJF
   xRGbO+MmdSHvhFSEtQoF2xwRs0hhcLrL2BA2MlqdqOlQbMfaBsZgJr78J
   KDlXtRHzMBEiV28LBBLeh6oug4T15CMQcKduN0wGVyWcxuiqVnq5S/pra
   L1zCtzy6yQ0h1oKcbmnP67mIsy+2a/A1zhSbxrvlbHGeosdrzhDEpYrLr
   WRdbBbA/BIegyPrAOu910lLHiuCwuUVvhE3suiGblhatP5QkibhfNEp8s
   PMiE38gCdTiGogjP3iYAbTMUQzrFUelQJS7WF7fLPdN0wBohVr0bL4Ikf
   g==;
X-CSE-ConnectionGUID: 1VrWCFLZRSm4aoesmA+M3Q==
X-CSE-MsgGUID: 7jJE6TBtSo++AA9PidnFSg==
X-IronPort-AV: E=Sophos;i="6.11,231,1725292800"; 
   d="scan'208";a="29267066"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2024 21:46:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCA9DMFkdM02Uv+g764z1xdE+d3OS7nwe7s3EsNYvh5aTWCO1d/EY2akFcgV/8yIj5UUhOnbmyA1qFnqd1koTaqJ1ly7qD4z0FgVXzmgAqG/FxKTWjYgEh/U/wDYUtLXqi+CGgNVju0Yd6frDceADY+A7ZX3ED7OjxyrpYbF7zJjBWSvsNcBIFZuGMQ/7UONhq8sMKAxrj/i33mgicBHSB9tGb3iQWvUXJ4ylIG+vJz16crZiwBM1ANtnGMNkqx4Y5xwv1AcXqu5Oo2ZfMdjN/hCeo00pMRO7Qn8sCqwy4XtoDZ6AnYYkTx8sAgkxx9CpEcmNZsN/HsF3zo6/1dZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yvybZne2fWWXmVWhP8hdIMs4vqQZ+S29xXRc008Tpw=;
 b=F21FjXI3s9A0zE8UNBjSMETJiKLzLiLJWp2sd/lOqDrGmpuLRN+4BlQfUuSH7tN+YQnAD+YY8nhuty2YdvhdS4uOntC+88HbhGV62yL4nk3Ng+WqHWODx5YWmWx9ocPkUPuMX/KniwWkIkli7iUpujkqwpN4x89IWMRN6LFSp4+jrlGV4U0TR/JEeybPUK/1+T7RRwsbAFenzTMZl6JFL4m4Ky2HNR/Qp6eS3aRfqPqSpt0uJjz6M7zR21CNSvPcjJ/mh5gPNCEfmWi3yzgd2MfpZEvHygmMiIu74x8Gjqj0PqEoSLcpn/PnZMmFfbSFIWJg0QLGsbTG3dO90End7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yvybZne2fWWXmVWhP8hdIMs4vqQZ+S29xXRc008Tpw=;
 b=r+fZCRkSkm3+yam7eOpIgCSaHWGXKnunoYT8ZF+xmxRJjR4RZBZ5FR31TIMl8Tb4LmkCnsye8qthHp4stkAuyDLy7EZbYcDYtEfz3hIwomqQsUb4aederhXX99RrXJQ2wSL3pGSM6Wt8mPlWjGIVqr0wdf8SpC2l4zGeoMeoKJo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6430.namprd04.prod.outlook.com (2603:10b6:208:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 13:46:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:46:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/18] btrfs: convert delayed head refs to xarray and
 cleanups
Thread-Topic: [PATCH 00/18] btrfs: convert delayed head refs to xarray and
 cleanups
Thread-Index: AQHbJjE47/2HCjn3Lk22UAN/97frELKXdJqAgAAEfACAAAMKgA==
Date: Fri, 25 Oct 2024 13:46:13 +0000
Message-ID: <e060a3b7-aa87-47cd-9d1f-b0a380e1038f@wdc.com>
References: <cover.1729784712.git.fdmanana@suse.com>
 <49b1a5df-eefc-437a-b175-2e9532932dfe@wdc.com>
 <CAL3q7H61-kM26sNZC6rLzbv2D3ku7NQ_B+PT9-eQYLMGxuySxQ@mail.gmail.com>
In-Reply-To:
 <CAL3q7H61-kM26sNZC6rLzbv2D3ku7NQ_B+PT9-eQYLMGxuySxQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6430:EE_
x-ms-office365-filtering-correlation-id: 519b14fc-c05a-45c6-1483-08dcf4fb643e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0NWVnZqWm91cllCa3pUa29MbW1PVnFwL1BoYkFyRW9rVW43TEVzeUlVTjVx?=
 =?utf-8?B?cGp0elViVkpEWU1kU1N0VXdMVWV0S2JEY3JXbm96RnphMzBtUFN4L0JMNEU0?=
 =?utf-8?B?Vzh2b2pHRVcvMm4yNzQ3TVI2UXcwNkNTN3o1Y0Y4YlF5SHVsWTlMK3BnejYx?=
 =?utf-8?B?T2I0NnplVkkvV2g5K0JnUGFyR3RlZjU1L2ZWem1uemtsNWdYNERvWElUWXZD?=
 =?utf-8?B?M01LN05wbjltLzBmYmJTbnBPWWxkdmtFYktKb0Y4cXdRZ2UxZXFTUjFuYWJl?=
 =?utf-8?B?V0t5NktnUDZWU3YvKzdCLzBKWWtlT2N0bFZOT3pnZmZGMWp2QTNwYUQxa0gx?=
 =?utf-8?B?Ri9TU0FmZnNqV1owZnRCZS84VEhyVXA2eElWV3d3ZURiYzduOEdxckRDazZX?=
 =?utf-8?B?NmUyZTArY2FObGZubWRmQUY0N3dOT3dYWjY2MlZSNEdSMDZCKzdabHBoSkhw?=
 =?utf-8?B?SnJmYXRJTWhKdHF4MmxDMnV5TDF3Uk5KZTBJaVJKMHk3NDl2NDgzNkE1TUgv?=
 =?utf-8?B?RzljNmVLeFNKMGFHeTlaWkJoMityU2ZURXZheGJFd2tkZk10VXRHalR0aEU4?=
 =?utf-8?B?T2VuOVJQWTNrRTkzaW9TVjgwdGtOeVAwUXhLTjJlcStscDQzWlNSbFB0blo4?=
 =?utf-8?B?Wlg2U1FNQnNKakZDaFNDZFBwN0ZhOG1WWjVKaDRsWHUrOTROQVgyOUxGRCsw?=
 =?utf-8?B?QUpOdXNvTUlrUlFEbWN2VFlFNVB3MVQwc1NDN3hYM2lzZXQ4UHJ3RVY1K1pE?=
 =?utf-8?B?NGkvMkdHc2hkNDhOSFFBOStEb1NvTFA1SllzQXdYZ05qR09WWVdVbnRqYllh?=
 =?utf-8?B?ZjgvbHZPcm9VQlNCTHZrMmFxUTBhaFVST1JPVDlPRUNxb0lTOUhXbkpEOFhZ?=
 =?utf-8?B?VFNEL0c2cnNXTWdweHRNU0MzVHVBTEdqSjdlbWdtYjhmMWRqUjBzTnY2a01j?=
 =?utf-8?B?anNuTnNJcEpicE5aTVY0ZWpWVDh3VVd6c1pWVnJtTG03MWhrRkc5bDkxZks5?=
 =?utf-8?B?TUx6ZFA2cDJmalpWQ3huN0hGVUQwVzZleXlQYTJPMmo4aU16dlYyMENKZnNS?=
 =?utf-8?B?Sm9JZ0p2R2V2WDVucU9oNEtYSGlLck1HbDgxbW1sYkZTZkY4b3lEMHpjV1JB?=
 =?utf-8?B?d3hMZC83RXFtR0VJTlE1czhrM3Jhay9FcVJJZGRYdG9IWVdFSUVPYVpoczg0?=
 =?utf-8?B?TGJocm9ETE03QUdGV1c3eG45ZGVmOEdsN2p3OUFrcmRHVGhiOXMrNTgwUDlr?=
 =?utf-8?B?Z204SjYyaW9GMmlTUWI2QXRKU2FpOXEvRkV6SENDSlc1Tk9hOVYxZkdSRzZ1?=
 =?utf-8?B?KzRoLzQvVG52SFNJNXgrclJJdzhKcU53NmRIeHJDaDZTWlRhWkl4VHhPVFhw?=
 =?utf-8?B?aTk5Z3J5Y0FyQTNuajZsQ1FnNitndjJHSWZYUFgrNTJjR3l0aDlMWFpqOWtm?=
 =?utf-8?B?SmtzVDN3eFppNzFJV2s1L3pxQ1AvRW5iQXExQ0hCVUpXSUVGNHdDbHRuQnRY?=
 =?utf-8?B?L0VRcHZBU3NlUjhPejlKN3VvdWxzbFVBMDd2UWhIYXNyaVVXMmtiMWdqa0l3?=
 =?utf-8?B?R0ljK0gvck9TblpHM0syckhpejJhSUpqN2VjZG5WeXVPYkVXSWNSa21hMEJi?=
 =?utf-8?B?YzI2S0d6QllsdFVILzYzRDN6Sk8rRlBRMDk5Qk4vSUVUc0YzcHNDT2h2MGpJ?=
 =?utf-8?B?SmswVUhRK3E3TWRMKzVxK3BQeEk1T0t3N3E4WlY5NE1mNUY1VndscEs5Mjdn?=
 =?utf-8?B?Snp1V1pjZDl1RG9vQ0FaVnhVT2ZrVml4UHg0ZEJTS1ZIRDN6SUJrSDhXU3pp?=
 =?utf-8?Q?W+0d3wQpuPByeSgQQQtFbxlnZZBVZ2XAdZI5Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTFRWHVaN1lBTnRqc042YWZEeUtHK3pxYW91WUZjU0E0WXgrNit4NXR3UnVO?=
 =?utf-8?B?NFNmblJRNWhsSDBreHBpc2FuUWN2ZXhDcUJONkVXQUUzM2dmT2ZaRmI3OWJB?=
 =?utf-8?B?REI5ZG5DTW1IUXh0WDNFa1VRS0F4ZDV3U2pMWU1NL1pXM0VVQnNWUHcybXZK?=
 =?utf-8?B?QTFlSXlydjBieUhmcFpRVm9Td2duMmkwdTN4SVNocTlCcmVCYkQrYy95eE1k?=
 =?utf-8?B?UHdvMGxCNzF1ZmY3RVhWU3B1VDlHUmdJcVdRY3RxQTNleFd5QlN2cjFZSjNY?=
 =?utf-8?B?Yk91VWxLTFQ0WGdIcEsybkkrNjkxSHFlTVZnWXRneXZEa2RrUWM3cG5ESmtm?=
 =?utf-8?B?eFQ1ZlgzMG84NU1HQS9RSUVTQ1NDOWFTS2EwVlhFM29SbzZpOGYyYVBMdkor?=
 =?utf-8?B?eEdkRXNiZ1RzK0wySTVPaHhpMWo2dTJVNzRKdWUyd2xSOGd6eEJZOTEwcHg2?=
 =?utf-8?B?ZmtrRkNycHFwVHF3cnJCK0t0U0FKQjRodno0dW13dkNhdFpXUnFuaHd2QjRS?=
 =?utf-8?B?T1d3S1RxYysvSS9wU0wxKzNPQTNCeDhVaVJjQnoyVjR2eGovY2k5MHhJdzhV?=
 =?utf-8?B?TThFMytjWXVkVXJpaXhyb3Y1ZklPSkppd3BmVm91L2g5UmRNU0JWdXg5OXZW?=
 =?utf-8?B?b3hKVmhLOGpLSTVkamxLL0dHVGtTQjVEcE55Yld5YmUybXhOeW5nNWMvbFFQ?=
 =?utf-8?B?U2VvK0pRYTVxWXhxSllySkYxZGM0NlgwVWZEbG1kYnNGZVQwQ3V2Zk13T2hy?=
 =?utf-8?B?MWVRYTFORWp4TXByaHBxS012SXFibThRR1QxcndLbWV6aFFvUUo4Yk1Rc05X?=
 =?utf-8?B?dGMvWW1TZFVXdFFENU53cVlyOE15WkZKME9IWnpWSWMrWTRkMUkyRk1pV3Rp?=
 =?utf-8?B?N0NmZmk5L2J0alROc2xyWWo3ZHVBbm9EaXQzbkdDVk9md3VDRi93ekdwMXdh?=
 =?utf-8?B?ejQvZGpCNkNMV3lUYndPdmxsdnZySXJQZzlGMWZ5bFUxNDloZStmRlUzSWV6?=
 =?utf-8?B?VUdMQS9UQ3BpdjQ4QjR2RGZQQ3JaM3dBZVFVZTJIMk14U2U1TzM5VS83bWdF?=
 =?utf-8?B?SG4wVnM0d0I4eHBCOFNtUCs0cnErUTdHMEllU2VuK21wWXJkeGtuT1VmNmcr?=
 =?utf-8?B?b0Jpc21zdHNJcEF2VytkVFpkNE9reGlWSkYvU3UxYWMvd2VRWC96OUFrdWYy?=
 =?utf-8?B?RzVhL3dBWGFaRlAzaGo0bS8zbm0yWXcrd3dXSElQTFlWUG1qU0JBZVV0enlO?=
 =?utf-8?B?TW56bXJoY0N2VXBwSG80U1lVakIySFdWWDh1NnM1dS9vVnEvVk5oMXQ2MFMr?=
 =?utf-8?B?ZDJJalVSWFB1RXREYzcxMEM3aWVvZFF3V3lRSEJEcWIzMDRGYk9JMEVDeGph?=
 =?utf-8?B?RFhLRm41ZEtUR3l0emFaVUpUSmtGYk8reWdpeTJkMmlSN0E2SWRQTVhJVFpp?=
 =?utf-8?B?MW9QWkNtS1N2QWV4bnJPcFRuRGtoNlRsbWI2QlRHRjMvVmwyaDdBR0I0T1Br?=
 =?utf-8?B?LzBoT1ozTkgvS0podkJSb1hJcjZmVk9HUmQ5NDZZd1NBRXN2Wk54QVkra0VR?=
 =?utf-8?B?Lzh0eDFMQnBMOU05TG1aYitwbVBPbzg4RThwTTZ2U3crbWFPb2tCTmp2U1pR?=
 =?utf-8?B?TGx1V25yKzIybWhPTy9nQmFUTzdVRTdxZXBlb0hHMVVkVm9OeUZCOTUwU0dp?=
 =?utf-8?B?K1FiNm1ycVdLTU9GNHFpdmhkUW01L0YyQUNlWFVpNDhtaERpZU8wYXYvSXcy?=
 =?utf-8?B?YWRMajJpSXRRYlJ0aFJSNjR3VVRKWHZWSnNjWDVHTUtGbks4amx2emllUUMw?=
 =?utf-8?B?U21GNXdJQ2NrQ1VvZnhyV09UMHAvSGs4NjBHMHRpQ1VvSWp0VXl5K1JyOStj?=
 =?utf-8?B?ZkhUaUhyaWR2a0RvVHc0Y2ZEdTI4VG5CbW1ZN1RESXJURXZBYnJxQWw4d3NN?=
 =?utf-8?B?Ym9CWUdya2FXRGdkRC9HQlVnZVRiY3pjNHpTTWxGRDVnZXRSU2tISDhraEcx?=
 =?utf-8?B?cUpUSmw1QTA1L2g1Zk5jMVR1eVJRRHVUMnFsYzMxd0ZjeGF6Q3ora3FlRjVw?=
 =?utf-8?B?UXhXcEVxK3UvSHBDWTJrMkdFK3hTZG9qNDJmN2hHSmo3WWlKYU04NlRZSGZR?=
 =?utf-8?B?aytWeHg5a0djR2N6VTNEY1N3NFJWMUNla2RlTkF2MzZyWE1kb1R1WmluYnRB?=
 =?utf-8?B?NjBoa1FEd3Y3UTFPNGpMc1UvOEZ1ZnI3TTZMaVU1WEtzaTRNay91VWZjYnVH?=
 =?utf-8?B?RUFCZ2RYeENFejFkcXl6b0FyRkp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85C4373177FB0449B5F44A9B2717FD23@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CYOWL8FzQ7QAVXeef22fbOJZ3L8pYXSddGfnLZLbaFt2M/99fOineSnWEiCN/nrRroeqDOJzWzeqDrnSyvx0CPyCLnS6EJNr7N/oJNIpMeeDD4CM/q89VNYwVV0SxvzpnjhrbvyREZfdiOmQ9l8YF21fsGXm/1izhRSQnnLdRGCSXGw8aQug5sZwwaK6kdO0E6CH5azyEYTpsF7YMM963hlFX7uLISWzWWhElXGNdHH2blX5LDjiPLHxouh3dnoxdkuqpr8ES6bJKKZRBneA5VCZie2E+OD6Lv6Z9eFVtqOCIGgktfvm7IVGcDDeIKh9IxvY7z/A8M4B7QYaKdXshMf4P68Hv1e90l2D5qS6kIstXIqcKngYVwZEhVXXJY6KEn/HGMwHEammryITNHgWAnADid9mDrc2vaElJhSb3BBY/2SswcL8/bl3ObPYby+otlZpBoNr+1jZTPM1+VZkrWoArpQ3/9sXhJnowi9enYNnI4s1T8umd1l/X/vUzanGZJAE7y5ArMMZKU+Zs4J0T5xOraZDfvffVrweNJA7sH+ks6I4HobOwFPYPnZfZ+Ubo0P/Nvv0vbc6eSAFgdQQcEL42rS7I0rFv0u24lxv2+HAfbhLt8YHlWlM4WPwFLCH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519b14fc-c05a-45c6-1483-08dcf4fb643e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 13:46:13.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 059suvk5zOHkXz1NLGRtaCz38NamZY8Uiaik6QJ0Fs6XHf+oeOUzd63GWW9NrNlyF8nm8a1TC5wlCSKAXxXvT2AmYW5nNXrYpaLuLu1cYVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6430

T24gMjUuMTAuMjQgMTU6MzYsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIEZyaSwgT2N0IDI1
LCAyMDI0IGF0IDI6MTnigK9QTSBKb2hhbm5lcyBUaHVtc2hpcm4NCj4gPEpvaGFubmVzLlRodW1z
aGlybkB3ZGMuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAyNC4xMC4yNCAxODoyNCwgZmRtYW5hbmFA
a2VybmVsLm9yZyB3cm90ZToNCj4+PiBGcm9tOiBGaWxpcGUgTWFuYW5hIDxmZG1hbmFuYUBzdXNl
LmNvbT4NCj4+Pg0KPj4+IFRoaXMgY29udmVydHMgdGhlIHJiLXRyZWUgdGhhdCB0cmFja3MgZGVs
YXllZCByZWYgaGVhZHMgaW50byBhbiB4YXJyYXksDQo+Pj4gcmVkdWNpbmcgbWVtb3J5IHVzZWQg
YnkgZGVsYXllZCByZWYgaGVhZHMgYW5kIG1ha2luZyBpdCBtb3JlIGVmZmljaWVudA0KPj4+IHRv
IGFkZC9yZW1vdmUvZmluZCBkZWxheWVkIHJlZiBoZWFkcy4gVGhlIHJlc3QgYXJlIG1vc3RseSBj
bGVhbnVwcyBhbmQNCj4+PiByZWZhY3RvcmluZ3MsIHJlbW92aW5nIHNvbWUgZGVhZCBjb2RlLCBk
ZWR1cGxpY2F0aW5nIGNvZGUsIG1vdmUgY29kZQ0KPj4+IGFyb3VuZCwgZXRjLiBNb3JlIGRldGFp
bHMgaW4gdGhlIGNoYW5nZWxvZ3MuDQo+Pg0KPj4gU3R1cGlkIHF1ZXN0aW9uIChhbmQgYnkgdGhh
dCBJIGxpdGVyYWxseSBtZWFuLCBpdCdzIGEgc3R1cGlkIHF1ZXN0aW9uLCBJDQo+PiBoYXZlIG5v
IGlkZWEpOiBsb29raW5nIGF0IG90aGVyIHBsYWNlcyB3aGVyZSB3ZSdyZSBoZWF2aWx5IHJlbHlp
bmcgb24NCj4+IHJiLXRyZWVzIGlzIG9yZGVyZWQtZXh0ZW50cy4gV291bGQgaXQgbWFrZSBzZW5z
ZSB0byBtb3ZlIHRoZW0gb3ZlciB0bw0KPj4geGFycmF5cyBhcyB3ZWxsPw0KPiANCj4gRm9yIG9y
ZGVyZWQgZXh0ZW50cyBJIHdvdWxkbid0IGNvbnNpZGVyIGl0LCBiZWNhdXNlIEkgZG9uJ3QgdGhp
bmsgaXQncw0KPiBjb21tb24gdG8gaGF2ZSB0aG91c2FuZHMgb2YgdGhlbSBwZXIgaW5vZGUuDQo+
IFNhbWUgZm9yIGRlbGF5ZWQgcmVmcyBpbnNpZGUgYSBkZWxheWVkIHJlZiBoZWFkIGZvciBleGFt
cGxlLg0KPiBGb3IgZGVsYXllZCByZWYgaGVhZHMsIGZvciBldmVyeSBjb3cgb3BlcmF0aW9uIHdl
IGdldCBvbmUgdG8gZGVsZXRlDQo+IHRoZSBvbGQgZXh0ZW50IGFuZCBhbm90aGVyIG9uZSBmb3Ig
dGhlIG5ldyBleHRlbnQsIHNvIHRoZXNlIGNhbiBlYXNpbHkNCj4gYmUgdGhvdXNhbmRzIGV2ZW4g
Zm9yIHNtYWxsIGZpbGVzeXN0ZW1zIHdpdGggbW9kZXJhdGUgYW5kIGV2ZW4gbG93DQo+IHdvcmts
b2Fkcy4NCj4gDQo+IEl0IG1heSBzdGlsbCBiZSB3b3J0aCBqdXN0IHRvIHJlZHVjZSBzdHJ1Y3R1
cmUgc2l6ZXMgYW5kIG1lbW9yeSB1c2FnZSwNCj4gdGhvdWdoIGl0IHdvdWxkIGhhdmUgdG8gYmUg
YW5hbHl6ZWQgb24gYSBjYXNlIGJ5IGNhc2UgYmFzaXMuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBp
bmZvIDopDQo=

