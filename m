Return-Path: <linux-btrfs+bounces-9057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D089A9AB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 09:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D9A2812AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 07:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5607014901B;
	Tue, 22 Oct 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jBZ+bWGr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fkob2wZ9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D03232
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581315; cv=fail; b=gOHXkzhhDu/Vibl3oPI1tUVIrn+hOHTNw1ZYLE5UgylOJJjR51laEKSZe60Ktv8pUKckgSL/sTqJuAStbx43dx7sSAtATwCrNR9qzphClNj91Q+ddvupQheT6agdkQkTuYrFMluGRN/Uy97T2mTni+BrYTRHv2nmav7U9ltm4Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581315; c=relaxed/simple;
	bh=zU+icxOas/UMvMoR5O3/Os/wFU0zylOtuZWVl3vrjw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lIhC9LG00PmEHH5lfWMkFhYnOv8brbrWAb807Gb+ck7GBQSoWXbFHmUMUiJ4EY7VMd6NRD/83by+u6e6rmCM4l4f9Q2euhv3MWSVASwdl73ERQGBQwjmcFNwqEcbk04SnRSbXejsZmxu0TZZSN2mszn5DLBGaFySRBlbssEZxa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jBZ+bWGr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Fkob2wZ9; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729581313; x=1761117313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zU+icxOas/UMvMoR5O3/Os/wFU0zylOtuZWVl3vrjw8=;
  b=jBZ+bWGreTaOZFEqGLS+NcyQBKhb4AJUetTeDA5yJgISe++fetEhLjB6
   bXPicxRW7c6ez57Qkkm687LLO0ZDPCu9EwweEuFHReIuqGu1jn96PQa4I
   JZ3KEPrinrkOUY7/saGCuhOexVwVcH3o3PJ6ePZoWpLbceLGyjSm3KMCg
   nM7uye+iFYTlESuPNpdPmlla55MYLULGqIsb4todcl4BQ8B+RBT/hTRAz
   u7Xz63aFzj3WO1tWz6+/hz5t2+ko+ybR5oJ4V5dY8CMFpjrWo+3pFHQV0
   WN8fNLbs7xyxxlnIyC0IrQumws8ijIGVA653OhD+bfsrPGoW8KE1ZZ1tl
   Q==;
X-CSE-ConnectionGUID: 64raEa4FR3KiuRFq103Qsw==
X-CSE-MsgGUID: nkuvLqIuT8iZlU1WhFAVUA==
X-IronPort-AV: E=Sophos;i="6.11,222,1725292800"; 
   d="scan'208";a="30531754"
Received: from mail-westcentralusazlp17011026.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.26])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2024 15:15:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGoxLIFjooVEoRs9eoxgdZpGmmv9fPfDfHt2C9ilu5YrHK9VtxXk0IODmzmUqEHLUinmIXCrCGJ86+bY8iwMaJP72Cm6JHWXsZ23Bb+uQUExvoAf3LgrKdwVCMMHeUG1lzselsOC/V0ithHftjrU+b1+TlyKKn1DYHGMuG7EFqi/EmhLDTtMzWWJZ70Jz+cx5Nqojig+X4Sm7vH5DWk6CF17qC5uN+iGUYVnwMmhpN+uaWwdXcHxvEwaJ/7tLoGQklpkqLDoDGpNZAlVYV7PSgTFT6WZlxujgfnGIvKSFxJj8kq9OAC9awrQx8ZgrNiq/g8QIYXALxKGUjjoe85VFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU+icxOas/UMvMoR5O3/Os/wFU0zylOtuZWVl3vrjw8=;
 b=no8uiXfYz/XnILWK0lx9H/HWxR8iJ0yFrqOVwjbzzi9NJoShOUTCvJwk5jF0hpxE/7RfwIAlMcnOnRrzdluML04IRYN+Js/kqtCEPHOUK62yOadH231leunLvwSGosVMwIQ+gaC/lqP3x/7aIOoQ5fl8mE4UVGZ3qZ26RDjKATOx7rDl5qXT4ZQhXDn7CZnilFTf0Tl0na/EBOiumMS+K58NZWgTDwYbIEaShbQNeMQZv9uCqWl5vsXSM24KyESfUl8GoX2UQHNk/QT/w23yia7pgdLu82mNGM06dlihL1wIT/gNVl5vx/7aTkFXCY2eA8glpUgEDwTPvr5m7OO9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU+icxOas/UMvMoR5O3/Os/wFU0zylOtuZWVl3vrjw8=;
 b=Fkob2wZ91f0iyaVjMmc0JgC+dOLZlAgcvnbqN42FZK0YlSu+0ndgdPKD6YjyQzeUQfi2V7PfcgKswC6ZscK9Nr0jMqcAzb5g7ldYcwScQHELL2oaxx+VcmCPEAb3he53+OxTr5/Hr1OSN8+PsiyswwoiPegPeeNpoXgIPQQmI1A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7844.namprd04.prod.outlook.com (2603:10b6:303:13d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 07:15:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:15:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com"
	<syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] btrfs: reject ro->rw reconfiguration if there are hard
 ro requirements
Thread-Topic: [PATCH v2] btrfs: reject ro->rw reconfiguration if there are
 hard ro requirements
Thread-Index: AQHbCoGFDRI445v2jkyCTPNm+1Qb7LKSjzwA
Date: Tue, 22 Oct 2024 07:15:09 +0000
Message-ID: <c5a4f243-570f-4bd8-8db8-0eaa7cc617da@wdc.com>
References:
 <b03b069ea18d29ccad3410c61ed40b979b12f50b.1726742871.git.wqu@suse.com>
In-Reply-To:
 <b03b069ea18d29ccad3410c61ed40b979b12f50b.1726742871.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7844:EE_
x-ms-office365-filtering-correlation-id: 7c25526f-8097-48a9-a7fa-08dcf2694329
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXpzWmppY1NyM3hUUUx6OUZvUmxMbm1OYnd3aEVRSmJ6Q2R1R0ozRVAzK3p0?=
 =?utf-8?B?UDFNV1RteVlON2tURTN5SzRpSllYQUVMb050TXk5dHJwaXVnOUU0dlMydXR2?=
 =?utf-8?B?NnlwZ2JnWGMxMktGY3pXK1g1T2l1cUtPamh4VXBuQWo2QlJ1eE1jaXoxc25n?=
 =?utf-8?B?SDVWeVA1L0pkeHJVYmgwbVNTbmhLY2dqenpBZ2ljc3dZUlUxZHFqaS9wcVJn?=
 =?utf-8?B?aFVzSU9pS1BFSWl6OXg2SEFvMUtiS3hZbEpxSHVuMTlBSjYrRUV2b1FZV0JX?=
 =?utf-8?B?Q3Nya1FBcEhlTFhTM1hEY1AvOThsRFZveUJtZHVPZDVBY2Q3TDZocFg4SVUx?=
 =?utf-8?B?Qks5WVMrY1dEaTVuK3NNSG5jclRTV0hUamVJK2NWSm5KN3hoYm5wUXRNOGZz?=
 =?utf-8?B?ck5uaHJRR0JHSUh2UFV1TlVPWGlsZTdJRnNsMzlGdDdzR1ljamdLK3RxWnVD?=
 =?utf-8?B?QXVFeG1oS3JhMmdlR0NhQWJaMTBJaVJ1cjE2K2c1Y05SR3dDZHVwcWRoOWk1?=
 =?utf-8?B?Ykkya25tZm5WOGRLaU1LRzV0QTQyMDQweG0vaEY2b29NeFNOb1FEQ1pmbkNr?=
 =?utf-8?B?YnpkbEh3NlllMElZYlhxM1VCeUNhajUxbS9uREN2WmRyZ0hOYlNaWjF0OFpJ?=
 =?utf-8?B?RjI4VUw4WG9hT0dscnphb0hCeGJ4NUJrN1NMcG9zNzcxTlRJQlR4bm9OR3N5?=
 =?utf-8?B?aXVjajdja0JVcDlFWjhQcEp4bXNBamVZQlNoZnpKSE5laWFDcHFUYkl5THd4?=
 =?utf-8?B?Z3hZbVFOc1FHdCtIMHhLcnVtcEt3SEpEL25sVVhuWW9iWTVoOUQ1K3M4eXN2?=
 =?utf-8?B?WVNtekJ4a0R3MXJud2QrV1lubDc5cEZNbWJzNmxzNTRmUnFyN1MzU0RBTDhO?=
 =?utf-8?B?anpSa0VDQXhEdGRuMy9panFTNHpNdGNtUWRXYnNCM0VKNHpSYXFqSEY5aEFT?=
 =?utf-8?B?N2hpRXNab0FwcXF0T1dkL3pURk1rbUZMYUpPT3JJZ2NUdXg1dDBYdmhsZVRF?=
 =?utf-8?B?VzZKbjZ1QlRjQk45cEtKRUJXUGUxWDZaRGEzVUFVbUpBT0lQRVF6dW1Jdkd1?=
 =?utf-8?B?WmVuNlBzcTNQa1RBUWlLUzhNNldWNTN4SHpXWFkxNndTd0J1MkJLck4vb1dF?=
 =?utf-8?B?QUwxc3VKWVJCQm8xanlPT3ZWWjRKNnh6V0FrYjVvRU5yamJaZE0vRkprWWxl?=
 =?utf-8?B?VXJmT2lTWUM4NURsZzFEK2pnSGw0OVIvNW5FSFhQUy9vblQ3RzVFMnNEN0ty?=
 =?utf-8?B?U0RJTE9UODRuMDNPSyswdlc5cjlzY1kzdkRHY25jdzNmWDNIM3NsWFNrTThZ?=
 =?utf-8?B?SWhnUGRmMWJod2gwbXViMFhmVGMzamZ6Y3ZoenJnWkRuekpILytQSHVjVkcv?=
 =?utf-8?B?RlJwZ0pXb2VIK1ZkelBWWWtQMldlSU9VYWV5bSs0NGdtMC9xYjRCSlI2WkxX?=
 =?utf-8?B?aDF5L2lpeUJvN3JRaE9VL3FOTzlYbEtqMkFtUVBkazljdTg5alYwT3ZCanZZ?=
 =?utf-8?B?Nkphcll4LzVCUHhUTEF6azV0MmsxZWlJMHkrYklwVzZKVDBxb0F2ZEpPSlQv?=
 =?utf-8?B?ZGsxZHgyblBYMkRmVDh3cEcwYTQrTG5sNmtqSTc4cnJucjg1RzN3MXdUUklu?=
 =?utf-8?B?OHJ6c2ZCeTZpTDZkR0RHSHVlWTErQ28yVk5pUnIrSHc1b1djSzRyOXZFOEcy?=
 =?utf-8?B?bEpPQkhQVVBhN3NEdGVRSHRieFFjVDdnamVwZVZwREVBOWdBQmRySWlOWlFK?=
 =?utf-8?B?TXEvbnMxRWlJSVZJZnVQWUZFZnlxK0R6S21SSXBKZXArMGhRS3Q3ZGtwUG1u?=
 =?utf-8?Q?B286SGEnTD3z9XgiGdo4OFEPNUZRpPKeoCQ+U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDJuTWdKUmc5bmRaeEdJbFdRNjlkanplSUNDV3hFVjQrTnhLNngxV0VFVEd4?=
 =?utf-8?B?ZFp2aUEweXhoNTJ3YnQ2ZDRXQ2xJNnhwVXd4b25iQlNVbDBzSWg2WWpjQlBZ?=
 =?utf-8?B?R0Z1V25tN0NxWU90QnFMajRUeFJDQVJQN1RnZVpVbnYxVTErQ3ZZK2x0bmJB?=
 =?utf-8?B?cXRmWVhmdkd1ei9iMGhFd2ZIR0pHQXVmTGRKbWp1VlRoM2tKcTZkV1hOMGRt?=
 =?utf-8?B?RVZCY3lxblp1QjVPQUVseElhcFFsTGZpVXpCM0hZSWNpanJybmpUS3ZkUDRS?=
 =?utf-8?B?aHJOYXkyMnRPWXgrOUlNSUlFdlE0RDI5eGRKODZsdVpWR1BXMHZRQXV4Vjc2?=
 =?utf-8?B?cWp0OGl5YUFVdk0wQnlIQUtuVllLZzFXanZnSWdtR0Jla0o2NzFEOThXRmdm?=
 =?utf-8?B?OVVxRlNxWlJybnl6b3BUMHJQOVVXVzgwSWUzMG5VczZvYVozQjBqSnBLa3Rm?=
 =?utf-8?B?WEtrZXdyeWRVWUhITndRZVl3amVRSFExOXpUaitjd2JQcUVWcmQ1dzBRWGw0?=
 =?utf-8?B?SXBRbXF3UVY1TGRSWk1OeGNtd3BRKzR0ckZESmlWM1kySGNzUVQzKzBqSGZG?=
 =?utf-8?B?ajZWcUpBODRVMGxvMWM2RlZEbFFheDBiK0ZUQWN3bGI3N0I1b3BtVWFBcjQ5?=
 =?utf-8?B?SEQzcEM5QzJrdTBDRFdWV3VZNWwzY0d1bS9lU01hYXFkUTVXNHE1RjVYSmlB?=
 =?utf-8?B?eTZweURMcjdkOU00Wm5ONUpDNnpIdkZzSkNoQ0Nxb0dkWEM0QVAxMlhBb3Fm?=
 =?utf-8?B?NWJFMSsvYzNCUXRHN3MzSUN1SHB5RzIwbjVKZDRsOUswdkhzV04zQmxUMmxL?=
 =?utf-8?B?VFZFeFlEeTdodDlrVVhRK2ovVGNVMkJqWjhtdUU1YVNKN1NXWk80ZC9HZHU5?=
 =?utf-8?B?MEFJQWxCOS9meXZMT1F3YWRqanNoWmlKVm1CbWF0aXZ2Rlc5RUs0M2dIR1JP?=
 =?utf-8?B?QlVieXZkT0pJVEQvcjBUV3MrRUE5enp1ZzMzclk1ZGZGSnBzZFU3SnhScUZX?=
 =?utf-8?B?MnVMR1pBS1NMZnlmOE15VUV1SVFtaUdabDdhUVZOZWEyMFJNQlJrYXBxVWk5?=
 =?utf-8?B?aEcwQk8vU3VpU2dISGV2MGU2NGtwQ1FMWUU1UXRZOW11MXhNRi8rNElWVFVr?=
 =?utf-8?B?Z2N2R2RWSVFFenYycFZFMGZ0akplSmtmWEFNYW5ld3RGcVd3SUplU1l5U05M?=
 =?utf-8?B?RDN2QVBaR0x0cFNuZjBRUm5kMThoQVdaYnFVR1RtclIzeHcydFZySjFDR1Ro?=
 =?utf-8?B?RFJ0RG0wRjEwVHptR3pYM3pNZE8ySStzYlpiclJGOG9scFh5VEVSbU9scjBL?=
 =?utf-8?B?S29JWnVwUVBOZmFJWnFSWjFJeDNuTkZzcmJkL1ZyL3dDbnZpYjlrbnV1dGJH?=
 =?utf-8?B?WHdqVGx4TWY0V2ZiajlKOXBITWdBY0xrNGIrTWxENVNjZzh3WnlNNjErRHJ2?=
 =?utf-8?B?eUpOak5URE5LcDlzWmhlUVB5clRTZERrS2p5RU03cGVFbHZzaCtNblR6V3Vh?=
 =?utf-8?B?N1hQVkl1bnhKb29JNUorRURQRlJRb3lKWlJhVmdHd0xKUVE5MVRzWi9weUR3?=
 =?utf-8?B?bkdGbHkxeFZITWo4czlxK1Z4Sjc3SGU1Qlg2L2xUcUFtbWdERXhlNmhMNTVy?=
 =?utf-8?B?V082a000Tjg2Y0J4eTNpaFBydmhvbTdrS1hWMnlFTmxDdlRQeEdUUmh2a1B0?=
 =?utf-8?B?eUhUYndnUjBnY0FmUllBT1VhVFQrUTNzRi9HMUpDNVZsKzBBb24yMW41V2k3?=
 =?utf-8?B?TFo4dVdQZkticU9xWmFJZGNKMG5rMnI2b3dZZ01kWDViMDJTcDV0UW9EVllP?=
 =?utf-8?B?ajlYRTV0TXNaT2dhcGFrYzBRTUk3eXZXYWY2ZFBvS0p5ei9YZUxkL3NsMHhL?=
 =?utf-8?B?VnR1RGtjWmRVQjUxU0dxckpTVHpGVVN5Wm9WNkVpSjZTQnJMSFpzU2I2ajFW?=
 =?utf-8?B?N2ZwQmFWZHU3V2RZUlJCOFVadWU0ZDF6OGNSVlFUZEJsUkpHY2JxUmdlQlI3?=
 =?utf-8?B?SnJKZnFzUUJBMlhIdzJ3TVpseThBT3ZIRmVGV3AydFB1bXF5QjVYQ1ZkU21v?=
 =?utf-8?B?c3l0d3dobGhCTTNaSEFmWjk1NTM5cUFja1gyRGJIbzVVMUpNVTNQa3hnRURx?=
 =?utf-8?B?aWxoUmVxNm1aSU1idmR6cStsVllHSUtsSFFSZnRITkhlNG1ON2J2VUNWeFU3?=
 =?utf-8?B?Mi8vVjVZTG9Ea1BJVEVnT3ZyalhWTXIxNHZsV0E3M1cvZHh1T0pYWEl6SXVa?=
 =?utf-8?B?MzNoN0k3VTBORWNJYVkvNmNEd09nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2416F424211B4C489D7F6913C6E8F479@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h2th34FTLnjLW74nRyhQLh4StccyL/Sw8lQyFtboEV6JFMPHv50kAnZt89frF4gbLpzdtH7Sa3aiUdvhrnOfvuGp7EFQMxe5yYpUppM/wsyXyGs+2UQYCoN9lzyOntww6/CQFGKICA6SqDT/PJ0ayCbCvS5pb1au2tBN65cqsnjtzOeXkjQGeDVXvxuTELOB1NtYjdRQ3zkXHm0eKSWIvqd7mklXpZ0ltCHh9H3DSyUENAp4thiJmpfLjWFNSSvSSMer9qwSFpSRelyNUJACTAcHg7yA9Asvt9tYvqxqofyTS4Rnyrt2BCUy9mKQ1i4VYRF7stpg0lfOG0Xzcf67Gm7UuketpH/zYPZwY0ClcY42qbVHlhRe8VMSgYSdYfgcJof9dNrt1kkzkFSRFy4z+Wy/OPRDQrntH54MuClPMh5W5fxf5u8Fv4W+prnECaU0g1mloSj7pSf2u4sjuguZqCdBhva7iePLh6mGfvxdNLMAFqIdlTTX648IEj57FJWQhMAx3LAWkSYHMW9XJfZo+dwzgAw23I2Pab4kUKIqjMEEzR1zTd1vZ7rhVKjTIeqRSZroXZRk7hxRBITdBrlYdBP5YA50NI7bmdwNKJOd9wEHZcIL2TyAuBNtkQyemex6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c25526f-8097-48a9-a7fa-08dcf2694329
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 07:15:09.1470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /H2k+YXsAyFGv1Cw0EeVOHJxcJD1og7vut5nRFllkq3NewvZV7iY/xp4DN182n632FmX86OuOupWdG2rC/0Ts6BoiqXI/BVInxa4QESTPGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7844

T24gMTkuMDkuMjQgMTI6NDgsIFF1IFdlbnJ1byB3cm90ZToNClsuLi5dDQo+IFtDQVVTRV0NCj4g
VG8gc3VwcG9ydCBtb3VudGluZyBkaWZmZXJlbnQgc3Vidm9sdW1lIHdpdGggZGlmZmVyZW50IFJP
L1JXIGZsYWdzIGZvcg0KPiB0aGUgbmV3IG1vdW50IEFQSXMsIGJ0cmZzIGludHJvZHVjZWQgdHdv
IHNtYWxsIGhhY2sgdG8gc3VwcG9ydCB0aGlzIGZlYXR1cmU6DQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGhhY2tzIH5eDQoNCj4gDQo+IC0gU2tpcCBtb3VudCBv
cHRpb24vZmVhdHVyZSBjaGVja3MgaWYgd2UgYXJlIG1vdW50aW5nIGEgZGlmZmVyZW50DQo+ICAg
IHN1YnZvbHVtZQ0KPiANCj4gLSBSZWNvbmZpZ3VyZSB0aGUgZnMgdG8gUlcgaWYgdGhlIGluaXRp
YWwgbW91bnQgaXMgUk8NCj4gDQo+IENvbWJpbmluZyB0aGlzIHR3bywgd2UgY2FuIGhhdmUgdGhl
IGZvbGxvd2luZyBzZXF1ZW5jZToNCiAgICAgICB0aGVzZSB+Xg0KDQo+IA0KPiAtIE1vdW50IHRo
ZSBmcyBybyxyZXNjdWU9YWxsLGNsZWFyX2NhY2hlLHNwYWNlX2NhY2hlPXYxDQo+ICAgIHJlc2N1
ZT1hbGwgd2lsbCBtYXJrIHRoZSBmcyBhcyBoYXJkIHJlYWQtb25seSwgc28gbm8gdjIgY2FjaGUg
Y2xlYXJpbmcNCj4gICAgd2lsbCBoYXBwZW4uDQo+IA0KPiAtIE1vdW50IGEgc3Vidm9sdW1lIHJ3
IG9mIHRoZSBzYW1lIGZzLg0KPiAgICBXZSBnbyBpbnRvIGJ0cmZzX2dldF90cmVlX3N1YnZvbCgp
LCBidXQgZmNfbW91bnQoKSByZXR1cm5zIEVCVVNZDQo+ICAgIGJlY2F1c2Ugb3VyIG5ldyBmYyBp
cyBSVywgZGlmZmVyZW50IGZyb20gdGhlIG9yaWdpbmFsIGZzLg0KPiANCj4gICAgTm93IHdlIGVu
dGVyIGJ0cmZzX3JlY29uZmlndXJlX2Zvcl9tb3VudCgpLCB3aGljaCBzd2l0Y2ggdGhlIFJPIGZs
YWcNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3dpdGNo
ZXMgfl4NCg0KTG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpv
aGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

