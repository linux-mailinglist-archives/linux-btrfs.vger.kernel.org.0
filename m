Return-Path: <linux-btrfs+bounces-20495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3958D1D7E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1CC33015E16
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228163815FF;
	Wed, 14 Jan 2026 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b="JhJvCBUG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00015a02.pphosted.com (mx0a-00015a02.pphosted.com [205.220.166.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A1218AAD
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382728; cv=none; b=VnfwncbOxAm8HvpBDLXLtdGL5LLSFlcigUvfnkxGPyAo6jzlek8qbS0bibMBmKHNjBriGtvSacrG5VXn/o4tjE0OG1+ZsTs0fHUnPlj0gjcJZBGr9SjNUW1PPV/pqsnoeN/SF3iZhAdhjDVq/v96d/KgQNJmX6642VVXkhfaHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382728; c=relaxed/simple;
	bh=gG4JSPspzm3NrGipKJD841NHDL2t7+rELlS9ux+LQXk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MH++Hn2aLYAL3PJ/BdMWa1b6ikOVPOE9c9IzX/KxztGCtc0MoWQ9nrJqyBzexAoWT+LFXS9wQeqknUH7tAzeqxdBf/AFqDP6/I2U6Lhe7t9FA20NubV8tulGv2/ZjqzGTcrDfhRAQLB2nGsi4ac6i5ubs/i+ezsFKYQdn3N6Bl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com; spf=pass smtp.mailfrom=belden.com; dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b=JhJvCBUG; arc=none smtp.client-ip=205.220.166.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=belden.com
Received: from pps.filterd (m0382794.ppops.net [127.0.0.1])
	by mx0a-00015a02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E81Vsr2992613
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 04:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=podpps1; bh=juefc7jJADyaQKNYSvLEDnip
	aP3edNbYA6LbBhfrVjM=; b=JhJvCBUG+zY0/QgaeRAc8ZlT8J0tWY5qw1j/wsHT
	tGyLtTw+GQQh2bcp/W5X3fYRrQVV2oZXpkO4lE/rO/Ixl5/qmPAg+qxB7WsRMsal
	rk2SjaHrXaodvq+ysvMyrt5uy5SpdbLgNfUjrb+fOzHrUSp/xBZXMP81NYb41YDX
	jMPUF9mc8kBQHoSIGIu7nBFTf/NTNBzHg9gHhknYrGq5UAJ3wblSaAc1v1jYGLYu
	CcZeVo3mvUK0czV9sZlM2+Td7hMG/gi4oUFoyLH1NmApdJ9eR7ccL2h7IxCacvfW
	VyyDSb6Azxy4PVsA1IV0ltN4cbKqvvIob+6j4VGrObzGnw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 4bm83v7443-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 04:25:20 -0500 (EST)
Received: from SA1PR18MB5692.namprd18.prod.outlook.com (2603:10b6:806:3a8::9)
 by CH3PR18MB5618.namprd18.prod.outlook.com (2603:10b6:610:199::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 09:25:16 +0000
Received: from SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::2461:6b6c:ad97:fe60]) by SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::2461:6b6c:ad97:fe60%5]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 09:25:16 +0000
From: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: btrfs stopps working when stressed
Thread-Topic: btrfs stopps working when stressed
Thread-Index: AdyFNmudS0nKqt7tR/aX56jro//3CQ==
Date: Wed, 14 Jan 2026 09:25:16 +0000
Message-ID:
 <SA1PR18MB56922F690C5EC2D85371408B998FA@SA1PR18MB5692.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB5692:EE_|CH3PR18MB5618:EE_
x-ms-office365-filtering-correlation-id: 95d3d9bc-ab50-4cc6-38e3-08de534ed444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AkZF9HTn1iEyXmjKKZj3mg/zdGkyHb+RT7mqRJc9Fy0ht04XTAr/yYbnojkb?=
 =?us-ascii?Q?hVGTUzTxwidlytu3Cb5gD5Ww/EamK1FU4kTxfFFIJekfqLaKPWK4Z2ivLRdQ?=
 =?us-ascii?Q?LCEt9RKeXkI04TkZxpM8/nZ9d8kjcFIHyJl9swKTdfv6nw4xjggLdTMcsQA4?=
 =?us-ascii?Q?gWe2AB8MAe1gyM4B+Q7b99uoB+WYhFUpB4dn9t7ylh4RL29tUh/nqVJK+WNG?=
 =?us-ascii?Q?0IX4DRZdeQgoStOmmazsX05j5lm+SzqiVpsUQUq0hgmum8FxBtyhl++LrrYs?=
 =?us-ascii?Q?w5cz3VQSByYuZyOWH1EjpwWJBenQfSFkEm+NvlZjkDwxYn/8Gyqh8Xv1BGoV?=
 =?us-ascii?Q?CRjUdaU9wG0ZdwsVh1ltpMO6rTEFnTEg00St5hie/EDkriBejsOi2Q/yV91k?=
 =?us-ascii?Q?zS6rNuUKmTCYOg0SNaLCWLDlPbJurQgo8BiCgrwBbLQHgSrt8wQnEcjhJNKb?=
 =?us-ascii?Q?IE719b+kstIFFRaGD1khBVM1/9FvWexuec+bTLezuJZ53TCNU4fmTTaS7mm3?=
 =?us-ascii?Q?mEYs/z/irLkOMk8zn2HdlLY8FnRydywQQgeAX7+iSuI1GABM+dRy7l1Hrp5/?=
 =?us-ascii?Q?w9HFgevaqns28mheHvonuLY9QAGC3RYOVcKg84zmeUJ62E1xt8Pp2wV/evxa?=
 =?us-ascii?Q?OBBqNgVfvkd995vksk2T03a+QdkuIfmy9rzHJLQnib89QKSEcdE4AWrepXJm?=
 =?us-ascii?Q?PxV9Q75J4mwYVjwJKpe6H5sbuuny+pUppWdY7hawAIq0SWsQTT4uuosWiGto?=
 =?us-ascii?Q?RKc3wIjtHAbyhJjo7x9lgAyGYDiK8olaEFtLm0q10eYNZTduz0Gm3cRZu2JL?=
 =?us-ascii?Q?JrKM1vEpJMf2kcjwzJyg1Ktfzik9W2p45Cw2vzBZT4Ce20RjpC8zbeIF9XW6?=
 =?us-ascii?Q?buzawZx0MH9CjwBPRvfKovJIuwktv876QdvdulgzXXq332ARMt2ZILmd1lcx?=
 =?us-ascii?Q?rwkaLCjhKB0T6K2l1wCZXb+YARjUyx23HRtr9WuAEfK+UguMYueGQBaeLgcg?=
 =?us-ascii?Q?d85DESuwFy9qr8SBk+SG19UnufvExZ6t/+CjcRvbDk4kTQFd7uND/IxlRZjb?=
 =?us-ascii?Q?RF6FsetGC8snxAvoqvlbJZhg8nHnSVo18MMn7AIFyO78m62CutPsRsbYbbcz?=
 =?us-ascii?Q?o3bqOSrC0uFzHAB2/NCPQOATRSMMpW5VYt3IY1iSMPqQG15fTguAWn9HHDAX?=
 =?us-ascii?Q?Hmvz5Qf6IaJxMdrAujTqUsNu+F/31RsTJKX+UrCrjwG4A3Jly17/BQhiJCM9?=
 =?us-ascii?Q?O1set/61bhSNswqS51X9YKo75Zr9HIoTl4iaVKEm63mMpok2j8//d9nhIyla?=
 =?us-ascii?Q?REtacu5UMk0/PLM3qORvUPSXvlkE3GyAZWnC9tR1/pUlv+s9/Bk/159VJaPK?=
 =?us-ascii?Q?HCa+xEV6U2e8ayYSsFtINCP+pxTagrbczfx1/eN4jIiut6xpUA3XPBoGCwlO?=
 =?us-ascii?Q?/jRgreG2DXloT2un/hGzA0iWG9gDGwuBz85P4Oep4arnYuyZW8Fz2v3I25Ou?=
 =?us-ascii?Q?6UtC/S7O1kZPOVU5KkYMfVD3TTa+vVzB5V56?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB5692.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?65xkMXwtu+pHEK6w982ceW6ZcY7kKeq7LryskBz3gzbYZbrIMiJPNZUo9r8p?=
 =?us-ascii?Q?vKuHpzfp14RcufDEwTzijx/kyiDeI+zTy93a4cVHjRSF43T0T1LVK51w4FEG?=
 =?us-ascii?Q?xXb80PTSdlEq21IiQOSIDXdA3JA+DzXSi4P+JWO2def4yDS+inH6vRWitUfM?=
 =?us-ascii?Q?k83ET9nIzkK5oLjdH6ZzNcdRwnL5ldvw9E55XH/VPZeNet0bH3gjgPCF/+Qz?=
 =?us-ascii?Q?9wDsiVkd6PxhR7wBXSOgWcArEh17wx5odOucUn/bFNcysmUVnlDF9jYqFe7L?=
 =?us-ascii?Q?UbUo/dTT+a42tjPZnsOCQjz7Yes3DWwvISp96fMcSZYME8AVyDHbJLVgQ3L4?=
 =?us-ascii?Q?d8mfm/S9h/CcrK2l/HKFnFmhdCGMQFKmubZfJQTXM2PbqB3Fs51Tq8FiyMTG?=
 =?us-ascii?Q?oN2y0RvCRiBthmhZ7OF671TiX07OiYrfjRi40/AhZF7RABfKSFtS+qICPM9L?=
 =?us-ascii?Q?2HJGgKlmQ3/BiUmVFOtSGO21dfoEt0hDs6tFYc3rQD/6Lk4CKzYsVFlqhaLS?=
 =?us-ascii?Q?jhmLMv0IhjbhQBnwGHxemvV+fGB0kXQIlEa9e0gMfe5KttjqyRVCG+JfK9lr?=
 =?us-ascii?Q?dYFUz8o9cQr6CrtiHDILwNmHbJfZuMOY1vWj1so/xtPf4BJftnK6jVkXTpx/?=
 =?us-ascii?Q?BaK2Zl1nX6du4MyBu18AFmmBZV8Z5Hm2sVr6+fMLmTFutRwOo4vxPpnCGSae?=
 =?us-ascii?Q?glayHIJugt24J94G3nrLL9gevfk7gwoud0L5VZi7TiSwR/Gzj1SGN1sk51v7?=
 =?us-ascii?Q?62OzdfYlTjVIdaKz5Ml8/l407oEg9Iu4Irvp3rfVYpj6OXKWBzI2w4U0an4x?=
 =?us-ascii?Q?PS2JGll+WjZBGXxh9QRxO905X4AVBv35/vap6xY0EzSL2RdlapL5a25OH4W7?=
 =?us-ascii?Q?W7DHuCtywPH9J8TuUb7z/cmnRkYw0uvLLElmzxCOiWwig8vGUc3xmtKqkLmL?=
 =?us-ascii?Q?+6Y20lPgtBTm9WFCeRha292+3Jp2hew0TrOQJkMsJeeXkbX98UyUHTWB/Om1?=
 =?us-ascii?Q?3MRbBiKCCJSpLeVngJMT3vDp/NTDtRTSiPx4xXOBz6VLOiJFGAFixWNsp4gv?=
 =?us-ascii?Q?bfmevzdqeTq4Af6k7bI+GWOccDFlstUdQYRVpdZKCM5h7NNAlC8ceRvn3UHm?=
 =?us-ascii?Q?MNm93fYTPHuS4iHudrHoaeZq9Sm7q4P8+oZQniVmc+wg3zMEVYU7Bo7JD+XL?=
 =?us-ascii?Q?AI6XJidmlT0yrCAtHvQqix1lVCl5f+kcugyD+CS3RJniufX9jgIiTJEjzA35?=
 =?us-ascii?Q?X95j0JPaYxxz+TesSLe5mGAKRAUkdJBLkOWUcI33oV24cd0GHtjdrtCnmwfC?=
 =?us-ascii?Q?2jVvx/9gMpg2ghACp+RIf1eUTrqMv8cZBa3F8417IZdCxxv6NHzOGoZyt+S+?=
 =?us-ascii?Q?8UD+o482seetQloqP9AcZOJuyNPETozBYyz9ANVRIQPf0y+fWt5/ZJDVvyfj?=
 =?us-ascii?Q?qKtiTKMiUWrZzmgyvU6B/LwxUzOxO+xk7mhnp1zfaiqEOstOKYd4GQuPI6PK?=
 =?us-ascii?Q?zU2ijs/pipwXcu2CUkNS+0DeBXSPWvuFrmWycg6NppnygE9/jVp+D0/AlwYT?=
 =?us-ascii?Q?or9cNOvzAuUbjqZrB/4fp2uWSiC4OsPcjZOdovjrP8GKXGom3cFJj2VILm/u?=
 =?us-ascii?Q?PLHDPhal6MMuxBmtbopBHXQns6R6UCwho498sTKq4pwiq0LBiX6NeZxquCoT?=
 =?us-ascii?Q?Rnb3erh1OVH6MIjnYPDCOR1JWRTdhZChvQv+GXyPVy9oBsdmPGsDYWC7OS+x?=
 =?us-ascii?Q?me+/EK9aBEWOrud1HaMswmnqzlVFnMetUwpfmEcQf5xijnzlvo5MhLZQzI7X?=
x-ms-exchange-antispam-messagedata-1: JNmj9Q6GU+FjLOx0g8K0vkZGM15qUgDiMkg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YCPaCyW+7N70iku4z/wdqq1tPrqFtTgDuAB0RLESJMEVpFt4+vwQN9G6veEBvMqAzYnrhpXgkyVaJnUyX8QT2J897rMM/Zkhm1u4JeUV306NvDi9jKB5UYDm3pvyuG/BSmVf2SbXli0W9wSBY5nVUXr+/O1k+DFFmpFsot2PvF+lVrVFvJwWN13Iy7kkjypFYhMB51QjeAMAErkEWp28H0rqT4MEayOwwNfyiNW7SFEuGiMQGMddeMIj9ZnpD1n0Re3x7lcajHko/RjK2q5VzfIMeVNbieOXLsw6PTGeFlj4LMKoV/kNyOS3g7vVnvsDcAVLEhqxxEykKCyZj6bHj2ZHO0MnaIX2lVGFiUMe+f6RvAfMXcPy6xXBexX8OXSmiVnyFE2JRZEefY7le3/p7M8WWCDXcnvfRzQPnNXhQswclk5+D+u7SsbkuoEXTuk+3mW3Q9Mk0OEUULh8jKEZGn6jEcUY9/YAXv6RQu3tiK73+sVy9qnmAI26gThSWgoft/46nretWq0jvgMznpFYuURrkuzDZ7+vJuHYn+UFvtVtAqe4zxFzybICpJ6AJJHnnrLzuTf7m2E/SHSz18lH7Hnvin8VsFK0Tb9Tvm+3bbLJGZmbgMBWcTHib6Us7XbNew1oiTEViDE8cAMpPYa4pg==
X-OriginatorOrg: belden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB5692.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d3d9bc-ab50-4cc6-38e3-08de534ed444
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 09:25:16.6433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0f7367b1-44f7-45a7-bb10-563965c5f2e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jV0aji50kw1FDzIcT4VQaCKA6dn6+3jLUso4AjnvAUVaSNyXCK7MyDbK7Bdqb4Kj0970BBT+1KMsNFEgRwoj9XAu/yczZVEP4o2035HTnOWbJUHTb7eSFT1whP8Qq+B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5618
X-Proofpoint-ORIG-GUID: mcjuT4uipUuiAv0G8WXvoFu5A1jR-o8i
X-Proofpoint-GUID: mcjuT4uipUuiAv0G8WXvoFu5A1jR-o8i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA3NSBTYWx0ZWRfXwUMxL4DSVuPS
 b7svkcNUFz1TEBdkJ2+xzaetH6zzkFx42XvIn0Q19Gm0DBfKZroBk+lmvVjt21RBsfx49JVUBO3
 vBbqgC28SsK8g2/4KuK2Btg/C2dQtXE2eN1+kF1hLPotrTUeoIwk7zqot80h6jxijjH85+tG0ms
 CZKPVDLJrjmkruxqjj53abMRO7qdg0H2HEqx+NXFwrXd9Y/bk7Z65U07NPOUrFCKl1ko7cq8Exw
 5FN+M0XUyVLlZK5S/p3ml8utCgDS5FWIXZyfLfjrxUBd2iJCAxj0gxt5MqFunuHEEu15W89yqlV
 jP1LOaeXRiVXMt8LgB2CfBUQtYhwPN2Y2WEtwt1pUJJJkM12Nk2AY1L0Cs5aZhksB8ySurbt/1n
 HH7h01P3aQ/o7Hyq7ClLmVSSGS7OyvDakOdbYcCebgtrI9nuUDZVhSNSGAWxWglyPTfTU2qe7Ps
 TMTaJZ4Rt8cG0hlzAvw==
X-Authority-Analysis: v=2.4 cv=WJJyn3sR c=1 sm=1 tr=0 ts=69676100 cx=c_pps
 a=H9d2Io+6O/etw3jU54J+0Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=mCf63rc527wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RJYTgV3HXSEFDL3Yu8cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140075
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam
X-Proofpoint-SSN: Sensitivity3

Hello everyone,

I'm looking for a solution for a problem that we have with the btrfs.

We have tried to do some initial investigation on our side however we have =
limited knowledge and experience in this area.
I hope you can give us some pointers how to investigate this further and in=
 what corners we shall start looking.

So, on our products using the btrfs we see that the filesystem sometimes st=
ops working when we stress it with bonnie++ tool.
We see the problem with mainstream 6.12 and 6.18 Kernels, our current guess=
 from the debugging done so far is that
we run in kind of a concurrency	and/or scheduling issue were the asynchron =
meta data space reclaiming is not executed on time,
and this leads to metadata space to not be free up on time for the new data=
. We can even see that adding a printk trace in a specific
point is covering the problem.

To reproduce the problem, we run: "bonnie++ -d test/ -m BTRFS -u 0 -s 256M =
-r 128M -b"
Note that the tested partition is for sure not full we have 800MB space the=
re and we test with 256MB so it's not a space issue.

The backtrace reported by the BTRFS:
---------------------------------------------------------------------------=
----------------------------
Create files in sequential order...[ 173.797072] BTRFS warning (device mmcb=
lk0p7): Skipping commit of aborted transaction.
[ 173.805091] ------------[ cut here ]------------
[ 173.809800] BTRFS: Transaction aborted (error -28)
[ 173.814728] WARNING: CPU: 0 PID: 520 at /fs/btrfs/transaction.c:2027 btrf=
s_commit_transaction+0x9ec/0xb34
[ 173.824388] Modules linked in: qrtr_mhi(O) qrtr(O) ath12k(O) qmi_helpers(=
O) mhi(O) omap_rng rng_core mac80211(O) cfg80211(O) firmware_class compat(O)
[ 173.837988] CPU: 0 UID: 0 PID: 520 Comm: bonnie++ Tainted: G O 6.12.59-co=
reos-cn913x-tiny #1
[ 173.847896] Tainted: [O]=3DOOT_MODULE
[ 173.851417] Hardware name: belden nitroc VNX/NetModule CN9131 based NITRO=
C platform V1 B-Sample, BIOS 2024.10-gae83cab9044d 10/01/2024
[ 173.863576] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[ 173.870599] pc : btrfs_commit_transaction+0x9ec/0xb34
[ 173.875699] lr : btrfs_commit_transaction+0x9ec/0xb34
[ 173.880797] sp : ffff800081e0bc70
[ 173.884143] x29: ffff800081e0bca0 x28: ffff000106825000 x27: ffff00010682=
5c9c
[ 173.891365] x26: ffff000106825000 x25: ffff00010c756848 x24: ffff00010c75=
6848
[ 173.898581] x23: ffff00010c756730 x22: ffff000106825000 x21: ffff00010c75=
67e0
[ 173.905796] x20: 00000000ffffffe4 x19: ffff000125e4f000 x18: 000000000000=
000a
[ 173.913012] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800081e0=
b6d0
[ 173.920227] x14: 0000000000000000 x13: 2938322d20726f72 x12: 726528206465=
7472
[ 173.927441] x11: 0000000000000281 x10: ffff800080f1a730 x9 : ffff800080f7=
2760
[ 173.934657] x8 : ffff00013f76e708 x7 : ffff00013f76e708 x6 : ffff00013f77=
06f0
[ 173.941873] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 000000000000=
0000
[ 173.949088] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000113aa=
da00
[ 173.956302] Call trace:
[ 173.958779] btrfs_commit_transaction+0x9ec/0xb34
[ 173.963532] btrfs_sync_file+0x43c/0x488
[ 173.967512] vfs_fsync_range+0x68/0x84
[ 173.971314] vfs_fsync+0x1c/0x28
[ 173.974589] do_fsync+0x30/0x58
[ 173.977776] __arm64_sys_fsync+0x18/0x28
[ 173.981751] invoke_syscall.constprop.0+0x74/0xc8
[ 173.986513] do_el0_svc+0x90/0xb0
[ 173.989874] el0_svc+0xbc/0x104
[ 173.993056] el0t_64_sync_handler+0x84/0x12c
[ 173.997372] el0t_64_sync+0x190/0x194
[ 174.001075] ---[ end trace 0000000000000000 ]---
[ 174.006424] BTRFS info (device mmcblk0p7 state A): dumping space info:
[ 174.013001] BTRFS info (device mmcblk0p7 state A): space_info DATA has 23=
4418176 free, is not full
[ 174.022018] BTRFS info (device mmcblk0p7 state A): space_info total=3D255=
852544, used=3D21434368, pinned=3D0, reserved=3D0, may_use=3D0, readonly=3D=
0 zone_unusable=3D0
[ 174.035829] BTRFS info (device mmcblk0p7 state A): space_info METADATA ha=
s -5767168 free, is full
[ 174.044752] BTRFS info (device mmcblk0p7 state A): space_info total=3D536=
73984, used=3D1146880, pinned=3D52445184, reserved=3D16384, may_use=3D57671=
68, readonly=3D65536 zone_unusable=3D0
[ 174.060221] BTRFS info (device mmcblk0p7 state A): space_info SYSTEM has =
8355840 free, is not full
[ 174.069252] BTRFS info (device mmcblk0p7 state A): space_info total=3D838=
8608, used=3D16384, pinned=3D16384, reserved=3D0, may_use=3D0, readonly=3D0=
 zone_unusable=3D0
[ 174.082979] BTRFS info (device mmcblk0p7 state A): global_block_rsv: size=
 5767168 reserved 5767168
[ 174.091989] BTRFS info (device mmcblk0p7 state A): trans_block_rsv: size =
0 reserved 0
[ 174.099865] BTRFS info (device mmcblk0p7 state A): chunk_block_rsv: size =
0 reserved 0
[ 174.107739] BTRFS info (device mmcblk0p7 state A): delayed_block_rsv: siz=
e 0 reserved 0
[ 174.115794] BTRFS info (device mmcblk0p7 state A): delayed_refs_rsv: size=
 0 reserved 0
[ 174.123787] BTRFS: error (device mmcblk0p7 state A) in cleanup_transactio=
n:2027: errno=3D-28 No space left
[ 174.133336] BTRFS info (device mmcblk0p7 state EA): forced readonly
Can't sync file.
Cleaning up test directory after error.
Bonnie: drastic I/O error (rmdir): Read-only file system
------------------------------------------------

Trying to follow the "btrfs_add_bg_to_space_info" that is in "async_reclaim=
_work" context:
-------------------------------------------------
@@ -322,15 +322,21 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info =
*info,
        struct btrfs_space_info *found;
        int factor, index;

        factor =3D btrfs_bg_type_to_factor(block_group->flags);

        found =3D btrfs_find_space_info(info, block_group->flags);
        ASSERT(found);
        spin_lock(&found->lock);
+       pr_info("%s(%d): %s %lld %lld\n", __func__, __LINE__, space_info_fl=
ag_to_str(found), found->total_bytes, block_group->length);
+       // OK: trigger twice free space is freed at second attempt.
+       // METADATA 53673984 6291456
+       // ..
+       // METADATA 59965440 117440512
+
+       // KO: triggered one, no space
+       // METADATA 53673984 6291456
+       // crash...
-------------------------------------------------

Also maybe interesting to know is that trying to trace (printk) "btrfs_add_=
bg_to_space_info" influence the reproducibility.

Any hints to resolve this problem are welcome.

Regards,
Aleksandar




**********************************************************************
DISCLAIMER:
Privileged and/or Confidential information may be contained in this message=
. If you are not the addressee of this message, you may not copy, use or de=
liver this message to anyone. In such event, you should destroy the message=
 and kindly notify the sender by reply e-mail. It is understood that opinio=
ns or conclusions that do not relate to the official business of the compan=
y are neither given nor endorsed by the company. Thank You.

