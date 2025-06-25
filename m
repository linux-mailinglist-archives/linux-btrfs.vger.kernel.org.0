Return-Path: <linux-btrfs+bounces-14934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEF8AE7DF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 11:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BC41665C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B79270557;
	Wed, 25 Jun 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nMd8MFbN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0JpPzEql"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50829B220
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844713; cv=fail; b=dA7z+5C9AjFTAtPSJji/5jJYUm2oeaEDymOIOKPO6zybQsJtIvV64dl85w35RwbjeyipC6zSRHDwqbG4KCmjVL7+TjcD40CEnPR8rYY20+30ocbbfu89TTQx2snqeXHFtdDv39IQigfhvQFDj3fMeEw84Tpg77ELk4YLZHAZJNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844713; c=relaxed/simple;
	bh=ls/aWpVSWsjYSIF0AG/jfMjKLZOiKt8p7cfht8d1Vbo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cqjE6QzK30vvaFjkxtzJeU+7FFg9my79Gr+wO4BsZDjai0MfAN+Uh2NIOp8dnbZZBMp8j712c0FcIiaLhSM2fhmjKVqnOYigXcBA1cNv3djjemR3zRtcElT/+9nptSUBwtwGphxZC/ibOnlg15tNOkNRA4SVV5B8sw9Uzlik3zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nMd8MFbN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0JpPzEql; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750844711; x=1782380711;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ls/aWpVSWsjYSIF0AG/jfMjKLZOiKt8p7cfht8d1Vbo=;
  b=nMd8MFbNQrFPMNE7IfofJWpyyFH6RHsQdi0tVPILAKf9h7wcX04cETnF
   bJJRdifMmS4+5Z2MsH56X1dFTyG/nSQVVB26euxMYcicCSOh2Hpxdxt9u
   LvgUbLj114sPefZCRKleVlB4W7EpYeLvzCoXfJUgv1x4fe7ViFqbj921r
   vM4cV4fcZMuTdrN7Dfwo6IbxX+VgisQVHd/utpOFXdISCLC1U0wFn3vB6
   OSGhnqS3y+U622K45pMeX9rcubOszomy9GM+duNrzfnazRY+Iy0wZstRR
   VCqJX9WrLR1tWHwtTtaarLZbAHeOzLQ5g5ZsVQDpZMSRHTpbamNESwDFh
   Q==;
X-CSE-ConnectionGUID: D4p2PrwwQx2DwpxJBETN4g==
X-CSE-MsgGUID: Rf4VLf2oRYqKYKKYrRFAfw==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="91244461"
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.49])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 17:45:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfbuMTGDwPiVUNiEp8iJ87ALJ4iF3ItcKCbiFJQTtrsBobfRRvA/Xs+uuuGBzj3ktG4mKpcevkXvU+PLMZz8EkC22wO90vJUqw9Ow269vBbEC9pXCIDNrT6Vcf7GBdU/b0gmq+Jlm6vX0hRM4gy8/WLSopdEq6cdyNp5GUoA44clTkP9ipjtmXQ/9l586dlIAcRPHEoiEWMiZDOHfPDvgXBZJEmCddf71SLzhHXkBAA6e7ThXxzM3bvfuhVI8ZjHBZ6QFSB5g66RsnqavUiUyUnsLRhsYAlrLv41+rhJ5IWE6BfMn74bx74EPHFYD0Zt3aEIDo7jj9NDQeydgEvpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls/aWpVSWsjYSIF0AG/jfMjKLZOiKt8p7cfht8d1Vbo=;
 b=ANG0IIj7wWsRVrOPGFaLAT8tERkpu9rEbo7v/Nif5i589n8cX7zziJt64OoL6Sfdi8EzJPybsRwrIlzd9rfnh1FoxVgdvYKoc7xxSlseYLFnHxm15ntbCdgyCgGJeYWk76fJYJusoXmv8//GHkjlVVvUiiDNcxZ3Y0ECAQu5Ketl8gMTzskQ5acSRKJoQ65I/29sMkEP4KS0eJhHNej642qH9eReqaJYZysn7CENGuAzo8CHbhORce/tTwqE9uGxEoMoR7YLGS7zW4jRIzYOy6UpACmpgBxqjtzneEtWTicaS+mg4ulafhnIGSqPVh+YUWiw3dLFzTIPUJqmMqX17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls/aWpVSWsjYSIF0AG/jfMjKLZOiKt8p7cfht8d1Vbo=;
 b=0JpPzEql6xcl3SlzZPTrUGyhqXwye1sl+Tcqpbn+QrBX6+WpBUhwQXBqX8sGH3FsB118tYCX2YFNxQolZr0Up5ypbRF9pv/rtqyoTM6jnKbIBZcqPhC27wmeYAKSVtlkqOMDxASRieLQrmyfhmAC2OqfMy1n2vxks/neZ0mIr6w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB7906.namprd04.prod.outlook.com (2603:10b6:610:ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 09:45:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 09:45:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/12] btrfs: fix missing error handling when searching
 for inode refs during log replay
Thread-Topic: [PATCH 01/12] btrfs: fix missing error handling when searching
 for inode refs during log replay
Thread-Index: AQHb5Rgf73tCPx1CEUaP4jc1PS2Z7LQToXkA
Date: Wed, 25 Jun 2025 09:45:06 +0000
Message-ID: <4c76858f-ee2d-4462-9668-d788950ca795@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <78786d6de8f9d4564abaee440ed6260d5c9afd8e.1750709410.git.fdmanana@suse.com>
In-Reply-To:
 <78786d6de8f9d4564abaee440ed6260d5c9afd8e.1750709410.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB7906:EE_
x-ms-office365-filtering-correlation-id: 020b4bf2-6040-48cc-3df8-08ddb3ccf7d3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MEpMRm5xVzZNYzl3MFJNMmxobzlSVHlIQ3dRM1dPVzJIMlA4cUFkazZRZ1hR?=
 =?utf-8?B?dVUwTlJDY0VxbGNnSnNidFl4SUZuMkU4QUdJNDhEN283UHJoQ3NWNHNDa2Vu?=
 =?utf-8?B?b3JwRFJyNkdnYWRTRG13YnNxbHZmUWFQaWtNbG1ZZFAwUVdMaHlCYm04QTJJ?=
 =?utf-8?B?Z3FvZUx1cXBhWFFkU3NTZGdjSTRQYVAvQnBTN01vbW5nWS8ya0FXY0pSVm5h?=
 =?utf-8?B?WkZ3bU9MZ1FVeUwzSXV6RGJaRlJyOUwra1BoUmt1cVd0YTl3MERXbGhpbGJH?=
 =?utf-8?B?SVc1cVVobU04UXZMUzM5Vyt4TW1EN1oyZEl0ZEdGVWRKQ0o2WEFXSEwrUHhR?=
 =?utf-8?B?ZzZnNWRBVnVuVUNIMWN4RmxVaTZvdWRWWlByMnlJTDU0RkVZSXFoWnBwRFdP?=
 =?utf-8?B?V3pJYVQ2bTVZM1V3NHVqd09ZZGJSemgvT0IxMkFCYm1seU5xb09MS0Y4OFc3?=
 =?utf-8?B?b3FORmgvTmVLREpwTnF1MWFSS3ZYOGd0c2JxWUdyZEIwTktVUUtTUGE5a09J?=
 =?utf-8?B?dGhGOUdKSnZPa2dXUGZCVEYyUUc4eHdBWkpQOFVuSVJsc0VpdXVCVFNBYzlL?=
 =?utf-8?B?ZnI1clduNDJReUpIVEJLK3dDVnVqR0ZDRTArMVdXaVFuazVaeDBRM2ZUU1F6?=
 =?utf-8?B?LzMzWXBld2hBU1UvOWhYUFM5bjhURDZTK2dyU1RIMVNiSkFuamlZVTlLV3Q4?=
 =?utf-8?B?U0pwdk9SRVZqcG41aU1CMUt5Y3FwRnhEbWtYWjZaVW4vS01JV0pkKzJBcDZT?=
 =?utf-8?B?L2Uyb252Q0Z3V1FHWjRocnh3ZzM1QmFaWE1HejZzcjhOcnI2V2NYUmRqZERy?=
 =?utf-8?B?YWpyUWluVW9DMiswYUFkaUsyUjNBMW9Cc1I3SlduY3AzNERFcXBzL2ZpTlhV?=
 =?utf-8?B?cUZpZzFOaU9rc2JGUlEvWUFYcUtCRkxObzJjY015LzZvQ1BldFJnWnhjOExZ?=
 =?utf-8?B?S1BYUUJrcWFNNHU3WkZnSCtXblNFN08xVDVJblJOS3hZY0RHUmdMbFFUaTh5?=
 =?utf-8?B?aHJ3aUNLeGpDc2JRZ2t4MFU2NUNXZzY3U0xqZVEvNzZCZzV5V0syalYzM3Vt?=
 =?utf-8?B?dDZ4OXlpSFg4LzdJL3VQZDNScUl0SWo1YVp6VjRlQzBtSXNYejNuMXV5alVQ?=
 =?utf-8?B?cEVtUVFVK2x2dy9oNlUxYkxIZm5ZNUtEYTlEbk9UU3JCRzZETlRrRGNkdWhr?=
 =?utf-8?B?dmJKaEhSVUFrNGEwVWVBK2N2em9KU0FERTZGTExCNmVnbE1vUlVVM3R4aWFs?=
 =?utf-8?B?TVJVNTlmREY0WmVaYUR5Y0VVT01PWEpzUURPRDJvRlpBSXZzaU5zZElkbjJQ?=
 =?utf-8?B?cmdJNGlYaWkyekIvQ25qR0ludE94NC94M21mM29LMEMvUVRCOEIwWnhJaGE3?=
 =?utf-8?B?MU9VRTZKWDlpWDFYRlhRS090dTU3eVR2M2JHWGlpcXdzSVcrNjBtWFhtSExa?=
 =?utf-8?B?bk9PL2k5alRqSG95Nkw4VlJWUzBjWXArU2NuYVQvU0pFSTBUTUdnRlh2SlVo?=
 =?utf-8?B?WWZ0SXZSNFBSUTNvTVlaL1pWMjliM2NGM0NTalFhQWdCVVg5ZlBUdzQrQ0ll?=
 =?utf-8?B?NlhMVkdLbEdONnA0NTBISFFKNzZ1N0NSUDlwdi9pTk1VT0lkaE5NeVo2Wlkw?=
 =?utf-8?B?QlNhTktpOEpHc2lJcFJqK3hBWmlXbkxjWDRhWVJScE5rWE1vdzBqN3hkbFJm?=
 =?utf-8?B?dElkaUZVQVYxUUlhVXdWdjZkcmZhQ1hRNjlEaE1Uc3hZaWdIN3lKTmg5OEVz?=
 =?utf-8?B?U09la2NUNlhFYWJLdXdSdUx6Z1U1UmROUm50WEdsOVVCS3hvWnNKUDNBSmY5?=
 =?utf-8?B?T1NaVGJLM25oQWVjcW5XUXkzRE5FU0trS2ZWTlBFMW1icUlIWEtKRmw2VjVB?=
 =?utf-8?B?ZnVMUkp0eDN6ejd3eCt4Z1NneWRrV290dy9rOXhrV3VDYnJPYzJwZGg2NVdY?=
 =?utf-8?B?aWVnWEZaWXZOU25wcDBGb0VZSnpwNlUwYXorOE5zVUpiNUw2ampaWVN1VkRu?=
 =?utf-8?Q?hUZ+lKQ71I0WLs2lqTjMnRsDUGAs90=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bG5Sait4ZDdVeWJZeFh2b2lpeFNBT1gyVmJpV3dydktLWFE2TWx3OGlPYnhQ?=
 =?utf-8?B?bCtIM0FDVEJtZzQ2TXNWYlpkWXBQZWk0dEZQSHgvbE41K2VuWDc2Rm9sUk9s?=
 =?utf-8?B?TXI4RGRsZDVSL21WS245VGh1ZlAxVlU5WGptMDJ6Q1dlcDUvRmNCUDFUdGxX?=
 =?utf-8?B?QjAxeHBTVWk4M0J2MWl0TnR3czdMKzU3WStNbGd1NU5EL2xiOFpxUDNkTDhp?=
 =?utf-8?B?aXdnLzF3RThHQWNvbURxYWp6N0d2ZUtpOWtOM3JaelNYcndJMS9lNWxFQmpI?=
 =?utf-8?B?SXNLeHJtY01jODhUSkIrdU9zbmpwcmFzd3VyQUtJaVdPb2k1WWxSSXNMMjQy?=
 =?utf-8?B?elltMmkxSTJDYUpxa3hYaGE0SHJXeUlkQmJwbXZwaE5xUFpCdUx1SVNrMC9D?=
 =?utf-8?B?Y0tiY1ZBcDdDZDFNZXI5RUFDakZvSXJ6elRhL1FHWjV5cStVY3hMaFVkQjlt?=
 =?utf-8?B?YWV3YUlxTVJ0SEVuOURkbFRhR0VxSXF4aTk4dzVMUmxmZUlqajdwUUYrdml0?=
 =?utf-8?B?MjVVM0pQQXpCOStROHdMU3FQem1aQjJrL09PMXpqc29BTTJDRTA1QnA1ZGRQ?=
 =?utf-8?B?aml0M2tYV3JLbnQ4VXVua2N2VTQ4UFVLUGY3aGRIeTl2d3c4NzFzTUwyYlU0?=
 =?utf-8?B?UkFDNWg0REdhU2hTUzZhK1pnL0RoOGVZeHVnK3AxRHlsRHdsK2o1NXllb29W?=
 =?utf-8?B?VzlGZW9EMDJqdHB3WkRaZ05KUDFkYnBLSW5qUzBUdFZmT0pvKy9qQ0ZwV0R3?=
 =?utf-8?B?N1laR1d1MGpaSDF5SmhMbS9EcGlucUJvSTNHSlZNYlZOWExmR3NHQWxHWUhl?=
 =?utf-8?B?ZW5XNi9NbjF5NWhYSWo2L3JERVF4RTJpQ0gyNDlXQ3V3djZNSUs0RzBpYXk2?=
 =?utf-8?B?b1NsTWYzeGRvTzhrK3phNDZxTVQ4TmszRmVHNmwwVU5pVWI2MU1ybEcrUmhL?=
 =?utf-8?B?ZkpFUzJqWHhpcGRlNjhITHp1MEVvNjhGeG5CMG52UDlLMHBIMExPengzZlhT?=
 =?utf-8?B?ZDMwZEdlNjlsenNIOUhPeHJWb2V3V2JZRmxMV21tMGRHY0F4RFQ2RCtDN2lP?=
 =?utf-8?B?dENKQjlaTWhxQmdnS1cwdUd5cGNER0h0d2c5R2F2UjNmZFpuZnJTR0R5L3h0?=
 =?utf-8?B?TEhWMWJFaW8ydGpMdGQ2UFp6WjJXRWFBbXlhazNuMkZsK1dmVUtqd1VNVU80?=
 =?utf-8?B?SlgxTUdtVWE0V0V3c1JzVUlNdTU3MTNUODFkR241T045d3JCYTZKaDhibUsv?=
 =?utf-8?B?QzRGRVg4SUFtRXJ0TWtYVU9kY3U5b2hON0piNFFCSXFKOHB4S3IwK01NY3NS?=
 =?utf-8?B?WHoyVkEwZTJ2cEFNTCtIRjkzcW5BRmFWc0JqbEtrdWlGR01UVjB0V04zRm5U?=
 =?utf-8?B?MDB5N3d4dnFiRjZGOXBVQTJkajcvd1lwTm9RNVRRMlM2QkIwQnhyUlNBTGVy?=
 =?utf-8?B?ZGdOOWF2NDdTaW5FcDZxdlVZdkZyMjh3RW53RDFxYlpsQzgrYWJUb2ZvSjNr?=
 =?utf-8?B?MVBidDBSS1I2UEpYRkFXZGVEZStxdnN6UGh1S0xLWVhCS0VVSG5sZVNXZWFL?=
 =?utf-8?B?dU00YkY2SzQ1bllaVnFycWdoR3MxZXU5d2FzcVRoMEtDc1AzN1dpaDdRdTls?=
 =?utf-8?B?QUF5VVFGMmFWZjloS3k3bHlkMVpjWWtlNWJVcUhObnNuVUlpenFXZmFDbGl4?=
 =?utf-8?B?VjNReHQyYzh1RWtZYld5WHgxRUNaTkRYUUc3aHhtbldHb1ZqWWZWV3c0MWJV?=
 =?utf-8?B?VU1YMUdCRFZJL1ZteFhkSG1qVFJHVGtqMmQ5bXJLMmM2RlNlWmpsVjJiWkds?=
 =?utf-8?B?VlhTa0VZcHhtMTIzTFFWRVVmOUhGUTI3SDg2d1lCQWxLR1I2eG56R3ZRaUZq?=
 =?utf-8?B?VUdRQjcxTmFnc2lpQTN4Z04veGJ0WkJPRmV6TlFFZWZObTVJNnBpVXZSbmhJ?=
 =?utf-8?B?Uk9QZFZhMzE4MUxqMmxFczF6MXIzQWFEN1JtT0RJakQzTGhSQWRhQlU0Y1Yx?=
 =?utf-8?B?THNxbCt2Z3BsZDVpNld4NWZsZ2lYUWFybTVMWkhtTVhKVGxPZ3U2blpzTWll?=
 =?utf-8?B?NjV4L1FnZUhoSkpwS2pZT2NIYUE1WWpPaHcwMXEvR0xDUEJSeWk4am1rN0dN?=
 =?utf-8?B?VnZzdUlIRHFPdTdoeGU1REV4STZlcTU0M2xjRjZpbXAwbFVMMzNMMGRucnYr?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B92C74156713B408FBC41E947B37164@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fnlv+LEpkHQ80OtIthOHoqxrIulaz3LmbOAQFc9V8z7BfRY4yZUZkCcdoKNMzQ7fkTMAqkXzRxGKrhkMWARKjUZEvy8vd2bLQywUnYusyqJIursK+3B7W7dKlgtNrmVh33sylLQJgwFjAmss/nmOYnXeKinUH8UA8Kn/8/bcTg0jqo7L/kjOekAc7u8QR3ioU6di1KllAmJFB7sjuobq1wtvfjjPo/pvddY7mHEnwfb/oW9iqsJYloDh/i3rgOwHl81sAlVDYP53Oe+hmUjlVfVpqb1/rqWSoUUkIJ0y6WKYQg6T6X1botWL0O2E1nMpwJBSIB2As74ckEcTHiiBar7xsLBWD7HC2lHJHO3KS1X3MKIqadAnxInVaO7MXGLlh/kHP5heLh4jCeja/Sf3sQ29k9WAljuDsnIMqSnvaJgmCrsAW797gMZnYX1liwVa/5vi2DouUgHR6IKU3aS4HFJni63ry2n3dKYliiVD5CtdiV51ylcCoFY1h1J6BoDWrGSfwLncAWAqvOWxNMZhueUHQ5pBh2kxnGd9fAIizgg3Tov/ygdK15KgA5gdYkzK00sEewNDjb/URCv9GZkzMDkLrImPK2igtNkCQzKr4aS1qQ2Hd2LQqbyf0qAhE4Yl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020b4bf2-6040-48cc-3df8-08ddb3ccf7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 09:45:06.8557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvNESgS58ZcqmKtf5r1PWJNZ6p+E67u2a9DUo0zQ2QJsS3qj9/GUJix5ElpLEUHB111zBqhhzvQYOkdtiXXFRGaGyK3b01rkZkKluS+W0Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7906

T24gMjQuMDYuMjUgMTY6NTYsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gRHVyaW5nIGxvZyByZXBsYXks
IGF0IF9fYWRkX2lub2RlX3JlZigpLCB3aGVuIHdlIGFyZSBzZWFyY2hpbmcgZm9yIGlub2RlDQo+
IHJlZiBrZXlzIHdlIHRvdGFsbHkgaWdub3JlIGlmIGJ0cmZzX3NlYXJjaF9zbG90KCkgcmV0dXJu
cyBhbiBlcnJvci4gVGhpcw0KPiBtYXkgbWFrZSBhIGxvZyByZXBsYXkgc3VjY2VlZCB3aGVuIHRo
ZXJlIHdhcyBhbiBhY3R1YWwgZXJyb3IgYW5kIGxlYXZlDQo+IHNvbWUgbWV0YWRhdGEgaW5jb25z
aXN0ZW5jeSBpbiBhIHN1YnZvbHVtZSB0cmVlLiBGaXggdGhpcyBieSBjaGVja2luZyBpZg0KPiBh
biBlcnJvciB3YXMgcmV0dXJuZWQgZnJvbSBidHJmc19zZWFyY2hfc2xvdCgpIGFuZCBpZiBzbywg
cmV0dXJuIGl0IHRvDQo+IHRoZSBjYWxsZXIuDQo+IA0KPiBGaXhlczogZTAyMTE5ZDVhN2I0ICgi
QnRyZnM6IEFkZCBhIHdyaXRlIGFoZWFkIHRyZWUgbG9nIHRvIG9wdGltaXplIHN5bmNocm9ub3Vz
IG9wZXJhdGlvbnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBGaWxpcGUgTWFuYW5hIDxmZG1hbmFuYUBz
dXNlLmNvbT4NCj4gLS0tDQo+ICAgZnMvYnRyZnMvdHJlZS1sb2cuYyB8IDQgKysrLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9mcy9idHJmcy90cmVlLWxvZy5jIGIvZnMvYnRyZnMvdHJlZS1sb2cuYw0KPiBpbmRl
eCA4MzkyNTI4ODExMzguLjA4OTQ4ODAzYzg1NyAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvdHJl
ZS1sb2cuYw0KPiArKysgYi9mcy9idHJmcy90cmVlLWxvZy5jDQo+IEBAIC0xMDczLDcgKzEwNzMs
OSBAQCBzdGF0aWMgaW5saW5lIGludCBfX2FkZF9pbm9kZV9yZWYoc3RydWN0IGJ0cmZzX3RyYW5z
X2hhbmRsZSAqdHJhbnMsDQo+ICAgCXNlYXJjaF9rZXkudHlwZSA9IEJUUkZTX0lOT0RFX1JFRl9L
RVk7DQo+ICAgCXNlYXJjaF9rZXkub2Zmc2V0ID0gcGFyZW50X29iamVjdGlkOw0KPiAgIAlyZXQg
PSBidHJmc19zZWFyY2hfc2xvdChOVUxMLCByb290LCAmc2VhcmNoX2tleSwgcGF0aCwgMCwgMCk7
DQo+IC0JaWYgKHJldCA9PSAwKSB7DQo+ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJcmV0dXJuIHJl
dDsNCj4gKwl9IGVsc2UgaWYgKHJldCA9PSAwKSB7DQoNClRlY2huaWNhbGx5IHRoZSBlbHNlIGlz
IG5vdCBuZWVkZWQgYWZ0ZXIgdGhlIHJldHVybi4NCg0KT3RoZXJ3aXNlOg0KUmV2aWV3ZWQtYnk6
IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

