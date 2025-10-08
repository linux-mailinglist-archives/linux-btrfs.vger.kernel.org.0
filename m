Return-Path: <linux-btrfs+bounces-17528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7FDBC563B
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334FC3BA2A4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B4628DB49;
	Wed,  8 Oct 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZHn6a76r";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Zrpr+aFV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169128B4FD
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Oct 2025 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932552; cv=fail; b=s6El9ElcpfPxoYCmDuFnzbJhCQymM8SGNMyw0jKzO86eDlKt0ZOBQUfol4OHMRMSBUwhT7CaL8Kw600HeoPVYFm3KpvhSwQY+abFlu/VGzP8/XeSfvi4tQ54cZENyYqz5TUzifeQ/AocNge2cX2Cy/HF2vA0b7SuTOKk9ghLYcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932552; c=relaxed/simple;
	bh=o1U1FrpNlTWUfP+oDFWIWCeQl8zILlJCNU6VjFpsqq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hCpzzTY4AcKjBkrpTrYPFip4XCOApKD7VPql9bTWtZ4qh/f0u6FdC2oYg7Xe6fdhBoo33vc7G2Zg0Pkmw6dIf7v2BnZW7X9jTqy/F/kgyFIxe5crh0iVnshXG/Xrcm4dJdu+bJZ3cdlsBMDuygQIRUXwMMlh/MjnTj7tNFdBiwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZHn6a76r; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Zrpr+aFV; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759932550; x=1791468550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o1U1FrpNlTWUfP+oDFWIWCeQl8zILlJCNU6VjFpsqq8=;
  b=ZHn6a76rSv5bKQNZd21q2O8lBqSnMRsGybZzXZJ+/034dBYXkKX/CVXJ
   Wq6f4sy4dWO1osYBUuVoKFKp7b9kM11GSfv/JNzo0O/oZGkPCJp5MikMS
   oGdZpGjXsQv/xVus76moxrXDAtCnTFK0J7rAokFjGaJkNpuJINNFu6un3
   HqmoO9eeM15xwl8h6O2/itosn1PUg7AQ5JzhGBUggF+MK8AnmaWqCVzVh
   mT4kdOApP4daQDN95ShDHvhcxdA71UCBu0MVPO7KMWW5GtbNTJu98uLnT
   QiI0kzTlI/wm/5xyDdAIrSfxZmIsF4w1uO2zX8eqZkXjk3Zd24GVkTE3J
   A==;
X-CSE-ConnectionGUID: 7hx5SvKqRtSnEt2odVMB4Q==
X-CSE-MsgGUID: npG2ITA3QTmIfeWf+NtF0Q==
X-IronPort-AV: E=Sophos;i="6.19,213,1754928000"; 
   d="scan'208";a="132513009"
Received: from mail-centralusazon11011026.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.26])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2025 22:09:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Djdny8661MiWLUEU7IsE5nTn1Q7e/9stfsGraC1a2q0FWtyFHfyL/HKLOv9LaBDRcSOEIsoy6G+GiwXtBc1HYKH1CRYSD7kwTzFA+oB/8Mih5nE9vNynzvjY9C6SMcs088PKgswO/WdPw3B79phLwr+f1B6QxqwLO9Xmq8jDL2knwNwojv8HeGbTsxoucJRR9gpsoIZN87333gpptTQbfgkrJ22nrYE0LWrws3T2ZuBP3n50jcSF44xG/SrmM15fKDkVaCdVCj5aVN3h3KDKEq5kxfCAI4Z7gAoLXRhxkgkL66sAJsE+Kipb960EcxMAPpXyCPmEALo+Ec4zqPSW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1U1FrpNlTWUfP+oDFWIWCeQl8zILlJCNU6VjFpsqq8=;
 b=yr7E+JBQYUEuVYt5GZ00aTcJ4jOOYCiMdUA4Gejy8MbJnLXhBt1Cxn9IDkFqRmyBYT3JvnkJ7nAjIye4/WTk8JuyT8psVxOR6cGYZcpkVdfnFWs1r6T0olANl9UXL4xwFoVXuZKaoAnMZPIoTdXlgfb0rb/SNxzfCgJDxThsz5Cd84oz3PqbnEsXlnfo9sEW/6zG+4C3D5TGah6cEJ+mZ8ifDN10GfdCPY/4WWpdDjvf+ECpNP9NVTDsUvhgAIDVtouBB/MC2A7DIWDiY2v6pkKWfYeR9017Mzko8oTJkSV8gH6Zjyw/0UmRekd7QmRIuxVUU1QsRd1wdmx2Z2l7Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1U1FrpNlTWUfP+oDFWIWCeQl8zILlJCNU6VjFpsqq8=;
 b=Zrpr+aFV6yIDPW4Dn5p2VF1KJwF4Es3BJqvoVYbSiWGGFCzYRDgBO22TJqCn4cSSwTFdUPcaEt+vIP8ABUosfP0w7bZMU1PX8nmgvxJy4ydZ0fh5UVlcqHm6S4sL61YrYCyMt9Ai+l+Ou1Wobx917KGO7TuSh9gD9g2zDyyyGNk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8014.namprd04.prod.outlook.com (2603:10b6:408:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 14:09:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 14:09:01 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Topic: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Index: AQHcN1KuGCX0HNOhIkayN1jmYD5sCrS2iOkAgAE6w4CAAAEogIAAhrYA
Date: Wed, 8 Oct 2025 14:09:00 +0000
Message-ID: <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
References: <aOSxbkdrEFMSMn5O@infradead.org>
 <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
 <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
In-Reply-To: <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8014:EE_
x-ms-office365-filtering-correlation-id: dea783f9-56c3-4f32-6996-08de06743b13
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MCtxbFpYZXdWMnBSSlVOQ1pyeVl2MjVPWlZVakd6dEVKNC94cGJldy95TmIy?=
 =?utf-8?B?ZiswRm5wekZaVkJQckNxaXJWM2NZVTVBdktGVHRGRE0weGI1Q3NTLytUUU00?=
 =?utf-8?B?Q1hrTWljQWNHUG54dmVzZnN2RWpaOU9CSEFzMDJucTJBWkFGcEhCdXN6eStt?=
 =?utf-8?B?eU1kQmpDZmtFcFhtb2orbDR4eUZLZXdlTUdFZ0xSaHlsUjJPNmtORS91d0Iy?=
 =?utf-8?B?elgzR2FSWFVSVEFaekd1VEdGTDlVYTJWMXJlOGp2bm9XOFMwZkhxSzRPZ0Nu?=
 =?utf-8?B?cUVZekFJZ2R0cjBXZVpHRFl3Q1BVUUUxYytxYVpGeExGK0wwU0hTSU5zNVZl?=
 =?utf-8?B?SitvQW93SWQwSUFwdGlnc2VJWDh0Z1AyVmZTVzl3czZ3RTdFNHptd1g3dWc2?=
 =?utf-8?B?L2FmR0NXOEpnWGRuSm5ja0MwcjJaeDdqaVFlMzJWOXJFeTM1c0xuZ1o3VlNW?=
 =?utf-8?B?eCtEaDRlQUlnbzU2M0dpVzZJUUdHRUpDanRlWTBKWnlZTmtZT2RNSmplYlNF?=
 =?utf-8?B?czU4NXlxd1FqQjU1TldhdDV5MXFod1F2TnE5b3hMWlZhbzg5S0wwU09mQ2lF?=
 =?utf-8?B?K0tTNzlHcG5SZUE2dkdqTXVSRFQwc01CYXRYRVZqSEt2N3p1ZnU2d0ZLK3Vw?=
 =?utf-8?B?ME9vS2h5QUlseUdkRSsvZllNNjNyeFhxcEQrOG9WMDNTYkFBU3JQeGJ2VGwr?=
 =?utf-8?B?eTVtZXZGN0NiZzFVcERkRzJHajM4SHZrWGhaKzAxYS8ySFRnSkh5ekltN1NU?=
 =?utf-8?B?M21uejVsR09seFp3UnJKZEtXRUFIK2RvTkF3UkpmSXRhVGRyMGtpR0J4TVgr?=
 =?utf-8?B?elVYaFZwTEpkM3NCNkdLMDhYVFU4ZHVhVmtqWXprQWJQcFg0MEFaa0J0KzVF?=
 =?utf-8?B?cklVNWt6MEhlS0ZQNXBNUCtrQnFRT2N5YVZ5T1hxdEpiMklZR0grY1FSUVFY?=
 =?utf-8?B?TzE2QWZqOHovUHdEWjN0VldBdWcxbjN1SU5xZU5ubmFOUGJZbXRYTXd6Q3Jq?=
 =?utf-8?B?Qy8yc2JDRkVITWlxRm1Nb2ZMYzhJeW1zYVNYMkVLVWVLUStEWjM1RWo4THR6?=
 =?utf-8?B?SDBlVElUMlBkNSsxQkZUV0g4SDFoYlN6NmNXa1dNR3pxdE13clE5YUF4QTV2?=
 =?utf-8?B?UTlMQUxGV0lyRGZ6aTk4anV3NFp1NVN4Nmh4TnVXQ3YwQlR3ZkFsNkNnWWw3?=
 =?utf-8?B?OUhlZnY2akVsT2pIa1VMVkh1RmVubXZjeGlid3duWlRMZlBqb3JrOXVoUmQx?=
 =?utf-8?B?UUJTN2kyLzF2Nnd2K29SK1EzOEhsVlQvWmRvL1Y2S3NCbXV5WWRJMm9xQTlG?=
 =?utf-8?B?b0Faam5qV0N6NVpod1JZZ1ZnQWJXR2ZMNE44T0NFeTF3NVhMckgwWlRPTWYy?=
 =?utf-8?B?SHRyVXRSTnVNUGpTckdMRlFPYXRQZjMvci9QbitkZlpOU1kzQkdnYW90MlUr?=
 =?utf-8?B?SUlWZTRqWGVtbGVxWi9ibDJta2c3OFR3Z3dRby9yU01ZaE5xSGNvaFZPMlZU?=
 =?utf-8?B?OVpPd0NLYjBXdHJmWnZ3ajhTREhjOVJKakFOK2pTc0Y1NkhETnUwRXFlWGhu?=
 =?utf-8?B?NkUzdlN4cHpWQm5WZmdSZ29KSVF6bndaOWt6RDFoZmh0b21NWVRrby9XaldM?=
 =?utf-8?B?YS9lOWk2NURINGpOSjl2OExPZWxwZXFrWWtMNzJ6N3hKRmxaMkRFKzd4MEty?=
 =?utf-8?B?OTBFZDBNdjRtckN4U0MyUHExbUI3QWhtTndQZCtOdnIzc0JFUklRTGhjWUNL?=
 =?utf-8?B?aG1zSVRKdG5DblV3RmRVMkJnOUJtYVBlcHBSMW05WmNITmZHNDVGbHkxbGpQ?=
 =?utf-8?B?cFc1aW5meE12L00xRUZMc2gwaTlOKzJDZGhTVjNxSjZQU2RuU3N3cjJ0RWxh?=
 =?utf-8?B?TzkrL3BjTGc2RFJVZ09mK0hZQ0pvOEQvZmMrQjduUUQ0VG1nVmhwMDFLa3cv?=
 =?utf-8?B?T21JZFVadU5rY0tsdmhybmlaWjV0L1k0RldrV3pNMnQ2OHkwa0VqY2hYaU1m?=
 =?utf-8?B?ejZMeFZSeWw5cExNbFVUTGlUWmFjaHlWZi9LRVkwbktmN04zcFlBb1J5YkdK?=
 =?utf-8?Q?bl3LY6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wkx2WUllVFhwR0ZZak1Ob0J0aFk2QlVIMzFjYnlnTk15OGk2Y29vUnpDZnJu?=
 =?utf-8?B?Z0ZFOFpzeUU2Z1BPdlFWTFFsN01ZbTd6RW12QjZWQXQ0endHaGltOTYvUGVj?=
 =?utf-8?B?dDF0NGlmbjYwdEE5dldqVmJOOXd1U2pKd0RDMk5vZk5JT3hHWmtVeFpwc0pE?=
 =?utf-8?B?RmUvQ3FZaHdsQkdBRURKOElCK3hUVWJKYlQ1VDY0ZUF0M2xiWVBlNUY4OVNo?=
 =?utf-8?B?aUdJd1NjM3ZTOElSRUVBcEVDenFFMVJ5ZTBRRlFrY2ZjV3FpdEdnNmdnZjhQ?=
 =?utf-8?B?T2E0V2NMWjI2Q2d3TzgwaHZyQjk4YjZQVUlQTndiY3pLazVJaDFONEJ1QnFw?=
 =?utf-8?B?ekt2dEFHK1Z3dFo1NFo1clNwTGJPeEVOTmhDdmhpUUpXVFE1aUVLMUJOQ2FI?=
 =?utf-8?B?bi9qcDByY015QlNCUXZXTnE2ODhUTERzbkZ2VTlaSXVqVFNIQ3pWNUJDb0FI?=
 =?utf-8?B?cUhldFZyaUkzMTN6bk5rYTdhR1oxOXRPcTR3NmZWZkFmNGZuNGI5WlBSNWpS?=
 =?utf-8?B?UkMyYmU0Q0sxVGtiUnYxd1lTdis5aWNNbDBkR0NwMHIwZlpyZmlicDkwVy9p?=
 =?utf-8?B?eFZab2xoenJFUmFXc1FZVnYvOFA3NXJjWUE3NWlZRHhWWTdDcVlCM0ZYaitY?=
 =?utf-8?B?eFlXZEo3WkZ5cStQSTBIV2FIZ0FvQVQxTzBPK05rZjBycjE3SGZSU1ByTWl4?=
 =?utf-8?B?Sy9CMVd6cVNqNWI4N09raXJnNktrUE9pY2RLNG9WN0MxKy90Nk1wR3VQT1ZF?=
 =?utf-8?B?aHA0eEpuQUZLOFV1WlJkT3B6R25QSVdNeGcrSy9WcFNRVHEyY3NqTVR5bVZS?=
 =?utf-8?B?UGk0UTlQcGc5TEZGVnRwTDdhNW5SRU9uekwxbXdxaHRxeXF4RGw4TFp1SjVX?=
 =?utf-8?B?dnFHcElNZjc0ajJhd3JRT3A1T2I4YlFNRExzN1d0RmVMbURNck85YlVWRm5Z?=
 =?utf-8?B?dHJBd1hhSUhvMTdaRStZSWF6UlljMEs3RVJzaXUxUHg3cUVvYjJoQ29oY2ZF?=
 =?utf-8?B?OUdJNFJvekhRRWpHbWpORXpCQ2lTcVl3Y0J0Q0l3Q3NXMm1YRmp5eXZvS0V0?=
 =?utf-8?B?TG9XVHo4SFh0OFJNUy8vdnNuVjJSbUdFNjgrQm9LSTVXTzY1ODRwYnBwZVY0?=
 =?utf-8?B?aHlzY2pma3VJSnp6OWZMNVRuSVczNkNoRmVHWEpXYXp3K2xySFowQmJqY0xV?=
 =?utf-8?B?VmcwN2JlY0k1MUlVNWNUcnRmblVrOTh3RmVWYkQ0NkF5TUY2Yi9SZ3hsaFJj?=
 =?utf-8?B?RXZjUjlmMzQ2Um9kRS9LdmhLU0d0NVp5VXZQQ0kyV0VGbWJlcFNhWU1sQmdl?=
 =?utf-8?B?WUhITEJycjI3dStkQlVtV3pZdDI4cnIzdEVMZTd5REhIdDlIbEZlZkhSbVNw?=
 =?utf-8?B?U3phYXFYSGlKOHNYbUNZK204N2VPNUVxYWdLaVQ2VTNzK1hraWhwUFpLTWt2?=
 =?utf-8?B?c2VzTWM2aktQTmludk9xaEJzd05tSFpYTncwaGQ0Q21LakdjNHZUVEJKaTFm?=
 =?utf-8?B?b0p1TUlGZFpyMGFJWnVpcHd0aytmQ2V2ZnFFQ1hvZzIwM3RPTnNoYTltN09a?=
 =?utf-8?B?OTg0MUpYUzg0dWx1ckxTS1pyMjJTWUFqQWw5Z0VaaG9MK05QNE4wbXRWTEdL?=
 =?utf-8?B?cUVXTzR5Q0FFOEJFSXN4elhqTFhZLzhKbHMyakszcS9jNU4zVCsrTllKTm1R?=
 =?utf-8?B?UGhFbnJKUUtyQnlabElPb1pPdHpiV3FiSS8ydzBoTGdpT004OWk2eWIyZytT?=
 =?utf-8?B?bWllYytPU20wbHovQng0bUFaT2FVVnYvdjVvNDFRYnlMZnhGK3lhdFovTlR0?=
 =?utf-8?B?Sk5QcXk4UThMSG5zM0FMMmNtZm90Tkk2MXFYZFgzZVFoandZZlYvMVI5MWNG?=
 =?utf-8?B?ZkV1Qld2dWw4VHNoOW90dTZWSE5HM3d2R3NUcFIzMmFkMDhmRk1TalEzZHVI?=
 =?utf-8?B?eG8zUVoxU3BxNk5rRVlHcFF5dUVWdUF1T3dVOHZLNm9DQXc3cHJvR2owUlZC?=
 =?utf-8?B?MDdveDNMT0hzNklmalEyRUxUVjFIQzBZMncvZEt2NWFCbmMvMXRNQUFDd0pQ?=
 =?utf-8?B?bHoxVTdZOVBQZzRqUEg2S1FkMGVMS1pZTXlwa0FZUVVvMlRWTmlJcUtsSUJ1?=
 =?utf-8?B?bkQ2L1JWUjJaays1dGdmQllid3lEMlFFa1RMZzNDRGxkcXFVMWZaNWs2c2E0?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60C0660441C54244B7E38852DD0A5E56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PgzGN+m+hftRKSN+HH/x7NkBdNbwF8AbrHKIxP62lzUn/LcWSFw++Gh/nyAxV5nlyH8Viv6cirr7jvVfprz2gk2u0y6LTVMYgqoltVynO3eh7E27rYLf9srR1Vti9N75uzXMya8Gesby0GbBhmbCw1aDdWR2IfOvLjYpcThrhB9CmpIkyANg3oWrDfurmiRBIYGxt6aKriXBGtB87/sxIs3wHTLTtRovXSFTWWlQp+Y3GtU74wlQ5S1HoU+AN+tHg8Rnl1wfrAjlaPxvZWL3b/BZTOxb780MwndGQwX4k/4SQMPnOVvALpRJZjuK/Q4L+wxom4es9jQIkZw1eFum4md4nPHeF3HTvICyaGvYF263E8LOPt/1NCX4BVJJp5CwO0e+AgauQNQaIKYubRguPbUrPyAXqUAHbaPxQQpSjLLpxK4BI3OQXfNso07LTobJyRR0kBh0cYaglIWJonBxWtEqhKgS+/D4dMUqqq2YqmO7jG/SuUlJZLKPgiJTLMZYL4amXfPrGMQ28qpqkTuGeivkZwhmFCHVbvko2kOl9SVp7G9cCQy16+DbPzTYQ9R3ky6Kyx1/suRastQWTa+MwmHBfAXXFAKohUv0XYpFcSUSkSefP73Mi1XAy8PywXAe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea783f9-56c3-4f32-6996-08de06743b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 14:09:00.9837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2N3o7poYPzi3jT5MzQpXIrMX/zcdJ6DZtdXakgmFSTEVhO/aY/2g5cLCzeK2nwoGuBhtP90fp2MhCGapgiDIBsinMn+g+XPNVOgAz4S0WJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8014

T24gMTAvOC8yNSA4OjA3IEFNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+IE9uIDEwLzgv
MjUgODowMiBBTSwgaGNoQGluZnJhZGVhZC5vcmcgd3JvdGU6DQo+PiBPbiBUdWUsIE9jdCAwNywg
MjAyNSBhdCAxMToxNjowOEFNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+Pj4g
aG1tIGhvdyByZXByb2R1Y2libGUgaXMgaXQgb24geW91ciBzaWRlPyBJIGNhbm5vdCByZXByb2R1
Y2UgaXQgKHlldCkNCj4+IDEwMCUgb3ZlciBhYm91dCBhIGRvemVuIHJ1bnMsIGEgZmV3IG9mIHRo
b3NlIGluY2x1ZGluZyB1bnJlbGF0ZWQNCj4+IHBhdGNoZXMuDQo+Pg0KPj4gTXkga2VybmVsIC5j
b25maWcgYW5kIHFlbXUgY29tbWFuZCBsaW5lIGFyZSBhdHRhY2hlZC4NCj4+DQo+IE9LIEknbGwg
Z2l2ZSBpdCBhIHNob3QuIEZvciBteSBjb25maWcgKyBxZW11IGl0IHN1cnZpdmVkIDI1MCBydW5z
IG9mDQo+IHpiZC8wMDkgeWVzdGVyZGF5IHdpdGhvdXQgYSBoYW5nIDooDQo+DQo+DQpOb3BlLCBl
dmVuIHdpdGggeW91ciBrY29uZmlnIG5vIHN1Y2Nlc3Mgb24gcmVjcmVhdGluZyB0aGUgYnVnLg0K
DQo=

