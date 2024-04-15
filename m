Return-Path: <linux-btrfs+bounces-4255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D168A4D9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F246B1C20C29
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 11:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2861699;
	Mon, 15 Apr 2024 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NGAH+N04";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wGRD1GXA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2A6027D;
	Mon, 15 Apr 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180216; cv=fail; b=rlyWuXJh57F7RszYEBMJmvNi8cKWsGEUo2yHm5W6kGuD+manMM3kaaXtHSAyNyzzLT3lAGPfq9Gm4t/cK6oFn/7VsFtIep4TTwkzCqJ4XwhENUwrxQFaVIVpRFsL+uafbM0r/LkVR+JoOhuGgFq0DPVPi761Iz7iV2/0Q7/yVdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180216; c=relaxed/simple;
	bh=4ghVL416O9htTzVsWoeJJdPVMv5UCyxlopGPfpbplAA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NQAWAOviiO3cjl/B6hgHSEQSojsz04Lnj17pDlmtJv2VGL2h28y1FWQhkbgjFSBj30HcKJXO08Z6JsE9Z+8/LeKE/dB68JA/Q2GJbPw7Ku6LBdhB4izxljtFtmpweIAjyZZxF92ekv78rHaSC6YNmV9KtFALJ8108rgPNBnwcHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NGAH+N04; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wGRD1GXA; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713180214; x=1744716214;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4ghVL416O9htTzVsWoeJJdPVMv5UCyxlopGPfpbplAA=;
  b=NGAH+N04PbruwrbKc4pRMrcQhzAvipi4ljduel4XYTt+Ah6s/oUCIDTx
   dZKHf4aOvqnILiHlI88plE/EKQbh1inBGI3H8bbidORwRQH5dlhFRjYh0
   WvG3TRZ+Mr48SZje4lohBYtq9ut/lJ2DwatLw+lgMDG55x7dRCMh1sUlD
   jBCQEnhxroSWBJluckwdl+PAl8F5OXvp2JTNx+aR+TNSffszaBpbf0e9Z
   Qcy2nvpR+eNKmp4KfOc+tT5EwnzORGDyjDqEsp4unf8bDc0p2IUqkmufS
   s7YuLbT7OsQ6CqzrjBXs+ochz19MxXnblO41zMWHZq14XmhJkUm87qiXj
   g==;
X-CSE-ConnectionGUID: o/B+H6erTea2ke9y1JbGIQ==
X-CSE-MsgGUID: Ir8q+Hn7RBeEJzn60gz5HQ==
X-IronPort-AV: E=Sophos;i="6.07,203,1708358400"; 
   d="scan'208";a="14238444"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2024 19:23:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auuuGq1aZuKB60F1GdcoeC+58cwgBvQTng1Nriy2RYw8ewI2Is30zwUGR3mgqOISN/QlD/BcJ88oMMJhTymznVYzXf8GMmq+u1XMC3JYO6Bi7FdBrwz12o13HE4ZPbnhZszNXaTiYFkQhlzrER7ONAe1603MPyZ/PsN/f40mRUl5wMznGpWSjDHwD48hwZbPVTVcUXyqDAVEniEGZpULwoVxaDR8xm/LCeTSrXJUaJpTI6KCDYBKvSNxI+kcfXKeCAejqSTTXE8Mtz80VyoZFDLwcIwjbGhBvay31AHmXEFnG1ID/NF/RoO65xYDj1tHelpI2BTqC+rz1Ya4J+nH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra6HhU5+cUfNNUnI7uA0Hdeu6xOQZD9DK5GS2emzHQo=;
 b=Rb784QPTLWnNXCFwdlVbG6hhGEgQsBXA8BzIMvg+hpcypn++YfMQIbFoJ/zILfJ1yFceMO4+i0+VAOMm8bA6eXXkg8cSfykmZz7Y7F7p3IXqbfIcLsjTGqNd00reNy9ATxWt+JoeJQWm4j5KWkWTCwHiSwTSFXFEWq7y8AFv4P8WeHyzD/6+KLobXJIJnmKomqUYE60PNmTyrlrcYRX7L/3R8TlayYSu0x3FB59/gE7m+anZrtaVDG+lPUPvC6BvFUJEd6sem5DN6qN0uIJbnQ7I6lj8xsv5sxbS4g6JeP9vhX8I0pFaQA3Tk09vM638Luor9pMgo15u0WF0JfvElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra6HhU5+cUfNNUnI7uA0Hdeu6xOQZD9DK5GS2emzHQo=;
 b=wGRD1GXAzE2BB20WQZQFuYwkFUXJwFw1T6tr8C22XGRJ00kgmQpuBivXqW9Y8d/9XM6Fp7T1u4++bRNVJFmGY39WXpwahOku8PZ3epImrCJ3hcHZhAJHMmleXbgqHcju40BSOMVCv/cXehe8lwsIu9ACt6uq8AAi+t+xm5xXALc=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by SN7PR04MB8644.namprd04.prod.outlook.com (2603:10b6:806:2ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 11:23:25 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::da4b:6178:f0c6:d32e]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::da4b:6178:f0c6:d32e%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 11:23:24 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le
 Moal <Damien.LeMoal@wdc.com>, =?iso-8859-1?Q?Matias_Bj=F8rling?=
	<Matias.Bjorling@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, "hch@lst.de" <hch@lst.de>, Hans
 Holmberg <Hans.Holmberg@wdc.com>
Subject: [PATCH] generic: add gc stress test
Thread-Topic: [PATCH] generic: add gc stress test
Thread-Index: AQHajydU0MgWW4psBkewF7CTRJyJLg==
Date: Mon, 15 Apr 2024 11:23:24 +0000
Message-ID: <20240415112259.21760-1-hans.holmberg@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|SN7PR04MB8644:EE_
x-ms-office365-filtering-correlation-id: 12ebf900-ce79-4c88-a2b1-08dc5d3e772c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 o5FfVkr1iKdCIrG+ZjYel8GKoG8e541ciuJR5O/klZb/zHtunmTwieOfgdmzFhdqmEU/iBbsA5Tsp89Wj4IbzKyBLzbLedyC6Z48O/kbq+twLxdXdpWDrlA8lpiltCq2XHLKA8sSB43o7KSyq8i9WWu31bh9SlPUVCCqy+fgRgwFXWjdcApQ0fAQeQuZsJy3JAuR/cjA3xRV6YoR5OTN/T5Ton4OpnPP9GloDR/T4EvnGsLQRxceX5ZWiNrI/cQS79LzIP0v474ExosyAkYT+X+AWMVG6OM6vUORU5KVdeT9IZuZg8eGyezmBnv0evBJ8LE900MK+CpPXgCGhMNmwA43TFnN2nnlyGVwtQgE234KuwDnegfTq1pdkKaQrW+Sije9fookAJ8F1XZJE27kANkvg//YM75Yziat5iMDclI1YjgyJHjVjEqWX6J96SfRjlTo3uM9PkbfNSn2xFLTR8sAchp+4v2nwfH9VWx0WreYC5DsSGvWpgP5Lmmvh6qqbVRFANI84VDRxy+gIUTybpI1FQCvyaSO75Zt3Ej87Q/eGNu4JtI6xwpDgaZEar/G8MMljLmb/vWzO3VhD6QyDOtK+grcT/CQL25HvQv2Ci25hpRreSFTIk265rFxlfCBzoHBpsKoIifK2aGBt69l5gchs9/SMmBiz0kdXxhWXlXuGl//drpNudwU2xDqPMZh6PFbFxbTNuKgbgNuiVXucbUX16hFffIB/++eGRdZOiw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WOrf4oWUD+U01F+DMm2OJMzBHmDSnD8UBeY4qQJwHYDb++K2FaP0CCFE7F?=
 =?iso-8859-1?Q?KwGMm5nOcL59D8ezJ0lpLC8Xo+JSrJGPkmPTu9awSNJzQJgPFPTDARiSWQ?=
 =?iso-8859-1?Q?X1+rfIXarMPbzG370XHlyM+12OMhU5kzG4rEFzMl9/RNpilRPkuZI784Pp?=
 =?iso-8859-1?Q?dnchzscX/OkotobbueATAqExd6fpFCDIEZWvoLMFyfVYKHQXJLeDhHh5hD?=
 =?iso-8859-1?Q?jCeCLtB74XgHNhkLjBXqaBzBol1qbU43eWecBWkcTONU/jXuLND0p3CibB?=
 =?iso-8859-1?Q?tF0ZnotfkfbFj0LcGBvv5TC3zsZiRy+mXp+Mk2T9mO5S9+f4+IwgKwZpRp?=
 =?iso-8859-1?Q?lUdL1SUGIBSGxRyXC9CS1o1lXFjBt+/G91tS7qZ5sGbiiEEQorD68zOdsb?=
 =?iso-8859-1?Q?iNf0R4oe3RYmEOjIG/wS6hjqVOKk7PvpyekCeUX5jfcla7asoZNi3ywddr?=
 =?iso-8859-1?Q?LbxY1Y50CgeFK5tjGeA5/fjI/Bzt1iHXfPtTLoqBBT5VwCIJ4Cp8o1XF4Z?=
 =?iso-8859-1?Q?YTobUMld+tLApKSwK6N3TgJwEmds5xEsGB/2m2U0SThTd6uEk166kPH9KS?=
 =?iso-8859-1?Q?Ftksk75Qr9utfizxMO1wZ930bDScbsNAmS29mIHnFPg0auz/+kwKMU1mIT?=
 =?iso-8859-1?Q?K+yPxDiFY5I8Gl9RdMmIUvUvrJtsr+N3kE0siOYf+WkEdND5tyu2Q3Gp8M?=
 =?iso-8859-1?Q?4+3V3ybWAgT5dcv05mXr/WOlcGY5UppQC0QOS1IsRfExKGRWpciwULsj29?=
 =?iso-8859-1?Q?CAmH1fI+k/HW3BRJ143fyU/2hlSU19DQp1wUY0An1Ijh137hnKR7TFktJV?=
 =?iso-8859-1?Q?ll44TA6jS/vbZpt4Qk6LItM2uewuE8LTY1sX9C4Nf6JsEQGa1zc6a5YZvt?=
 =?iso-8859-1?Q?XlvjBnuHfmnsg2vQC3Xep1KhjM0dT8rYRwn/FWqUM9NXx8Anure5UtCB3a?=
 =?iso-8859-1?Q?DvuQ2e0noJVu3QRDs7gROhF9addggSt/jiqb7YAQ0RzA+7tZxTfeNWlK1o?=
 =?iso-8859-1?Q?2D2IPFmAzvtgABPvioJHw/6fnbSY/qZDgwCbn7xkcmd1wMlkNhdnF3nFyg?=
 =?iso-8859-1?Q?EuKkylpuF8Tq4zWydmqWtD6wMc220oEKNuRvKVW8A+LeXF5pyRRPSC+HcX?=
 =?iso-8859-1?Q?i6V6bv/v/QGzEtWP4PfBPVoW2UgkaA4gK/Vkm9CiWNyoAuH+mE/fjae9gh?=
 =?iso-8859-1?Q?UWZrPdfCO9mNyGrj0N9QD9ZJRnWBKwi4Mk2XiT36WhTOZ+QE8hKP6uC444?=
 =?iso-8859-1?Q?6hx78/zMdrvr9mdWF1K6MEqISB5IiN2hQqdssY5hXtCakkhghqP7ELmJOm?=
 =?iso-8859-1?Q?j4mRN40p0fI3McUcs0eKP6kwXHir/FuFTDhXM7feXIJC1p48qossSoyRkl?=
 =?iso-8859-1?Q?4K+Rpjf66Ot/iExkq+BqZztdh2+iqY8tDb546qTjHFIqhNozMJNSt9Br+U?=
 =?iso-8859-1?Q?bgITpA9zGCNlJF+2GgCg+T9c591Ukbv8c9nb/J/6SfgZN3hSPQlDAeyyJs?=
 =?iso-8859-1?Q?MpXbIMziJyYwhwIe4wof6i9+AmX0J7wS1aUr9SlEvNP+D3zzQppZL1nIcg?=
 =?iso-8859-1?Q?i7lNFFBW9ZbQznB9H0RPe0MgeMrKnMp7k9gle1ioVaEse0cGVeEVe82eX2?=
 =?iso-8859-1?Q?DRzmTFx9i5sUEW6izvBRQcPA65qABmYPnRo4+WdlqTKrH+AxkDEbdfyg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x2TTNOhADl2GP4yGHhxoW0++gKHvhbVxrS4FvlMRLXLogohuc97GNtfC1AHOP2ASSau0vd/cGy9hVNJKDM3WdhP29lOG+MIQebcjpClyHnoFh2JtCf0GYycNWEbBnRtvBdzDFqYx7RVE0mu+XWCmXSGIvCd79ANp1p2maViROtlcTY/lLldsZv5c5Cq2alq5Gf3YqNXjzcYhISA69zqDpzfdrejU1K7teY3h6qEFJwlJQ0zq/P6tw93ovfN6AW6+aLPVLFw6g6QdhkPzGPlvQEBDW8fUEScJemInTFoB/v+m0GuGoea1TzuQc8ka+5XI0ZoOfhg6q6BZw5Ru3SE4eUu/zH35waRgtq99PWrzxKm0eGWaMnYeWd3IrLiM+7wpGrvvGuPc+mcNGo2xkssby07SxuOAzwCKO1D6m46QALW/H4gIq/UF4pwWv+jNW/yTLmEmbzy/FL651nYqGIXzr5ml3h10R5rduv5G3BJmCd/WBth5cegfZW3NCeuEva2X2d2T3Hzi5nnTM8b81Q1gYXZ8OcAdrLnpbKQuKfus7Xdl6zpuvhd2ejz1U70VQnH8rGRsUA6Ep8t3wFbctczRHmptS7SrFHBwkWzNYq3BRrgaIAKppWDpxTrqCHWBDqF4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ebf900-ce79-4c88-a2b1-08dc5d3e772c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 11:23:24.8259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Y8DJ7c5KK1/2iqktl0vr1xcA3ND4u/trXBa/oL/RAWm/9uMLTeArzWT86VTl2vhRsfy20noJMKqA8VzxwJXgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8644

This test stresses garbage collection for file systems by first filling
up a scratch mount to a specific usage point with files of random size,
then doing overwrites in parallel with deletes to fragment the backing
storage, forcing reclaim.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---

Test results in my setup (kernel 6.8.0-rc4+)
	f2fs on zoned nullblk: pass (77s)
	f2fs on conventional nvme ssd: pass (13s)
	btrfs on zoned nublk: fails (-ENOSPC)
	btrfs on conventional nvme ssd: fails (-ENOSPC)
	xfs on conventional nvme ssd: pass (8s)

Johannes(cc) is working on the btrfs ENOSPC issue.
	=20
 tests/generic/744     | 124 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/744.out |   6 ++
 2 files changed, 130 insertions(+)
 create mode 100755 tests/generic/744
 create mode 100644 tests/generic/744.out

diff --git a/tests/generic/744 b/tests/generic/744
new file mode 100755
index 000000000000..2c7ab76bf8b1
--- /dev/null
+++ b/tests/generic/744
@@ -0,0 +1,124 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test No. 744
+#
+# Inspired by btrfs/273 and generic/015
+#
+# This test stresses garbage collection in file systems
+# by first filling up a scratch mount to a specific usage point with
+# files of random size, then doing overwrites in parallel with
+# deletes to fragment the backing zones, forcing reclaim.
+
+. ./common/preamble
+_begin_fstest auto
+
+# real QA test starts here
+
+_require_scratch
+
+# This test requires specific data space usage, skip if we have compressio=
n
+# enabled.
+_require_no_compress
+
+M=3D$((1024 * 1024))
+min_fsz=3D$((1 * ${M}))
+max_fsz=3D$((256 * ${M}))
+bs=3D${M}
+fill_percent=3D95
+overwrite_percentage=3D20
+seq=3D0
+
+_create_file() {
+	local file_name=3D${SCRATCH_MNT}/data_$1
+	local file_sz=3D$2
+	local dd_extra=3D$3
+
+	POSIXLY_CORRECT=3Dyes dd if=3D/dev/zero of=3D${file_name} \
+		bs=3D${bs} count=3D$(( $file_sz / ${bs} )) \
+		status=3Dnone $dd_extra  2>&1
+
+	status=3D$?
+	if [ $status -ne 0 ]; then
+		echo "Failed writing $file_name" >>$seqres.full
+		exit
+	fi
+}
+
+_total_M() {
+	local total=3D$(stat -f -c '%b' ${SCRATCH_MNT})
+	local bs=3D$(stat -f -c '%S' ${SCRATCH_MNT})
+	echo $(( ${total} * ${bs} / ${M}))
+}
+
+_used_percent() {
+	local available=3D$(stat -f -c '%a' ${SCRATCH_MNT})
+	local total=3D$(stat -f -c '%b' ${SCRATCH_MNT})
+	echo $((100 - (100 * ${available}) / ${total} ))
+}
+
+
+_delete_random_file() {
+	local to_delete=3D$(find ${SCRATCH_MNT} -type f | shuf | head -1)
+	rm $to_delete
+	sync ${SCRATCH_MNT}
+}
+
+_get_random_fsz() {
+	local r=3D$RANDOM
+	echo $(( ${min_fsz} + (${max_fsz} - ${min_fsz}) * (${r} % 100) / 100 ))
+}
+
+_direct_fillup () {
+	while [ $(_used_percent) -lt $fill_percent ]; do
+		local fsz=3D$(_get_random_fsz)
+
+		_create_file $seq $fsz "oflag=3Ddirect conv=3Dfsync"
+		seq=3D$((${seq} + 1))
+	done
+}
+
+_mixed_write_delete() {
+	local dd_extra=3D$1
+	local total_M=3D$(_total_M)
+	local to_write_M=3D$(( ${overwrite_percentage} * ${total_M} / 100 ))
+	local written_M=3D0
+
+	while [ $written_M -lt $to_write_M ]; do
+		if [ $(_used_percent) -lt $fill_percent ]; then
+			local fsz=3D$(_get_random_fsz)
+
+			_create_file $seq $fsz "$dd_extra"
+			written_M=3D$((${written_M} + ${fsz}/${M}))
+			seq=3D$((${seq} + 1))
+		else
+			_delete_random_file
+		fi
+	done
+}
+
+seed=3D$RANDOM
+RANDOM=3D$seed
+echo "Running test with seed=3D$seed" >>$seqres.full
+
+_scratch_mkfs_sized $((8 * 1024 * 1024 * 1024)) >>$seqres.full
+_scratch_mount
+
+echo "Starting fillup using direct IO"
+_direct_fillup
+
+echo "Starting mixed write/delete test using direct IO"
+_mixed_write_delete "oflag=3Ddirect"
+
+echo "Starting mixed write/delete test using buffered IO"
+_mixed_write_delete ""
+
+echo "Syncing"
+sync ${SCRATCH_MNT}/*
+
+echo "Done, all good"
+
+# success, all done
+status=3D0
+exit
diff --git a/tests/generic/744.out b/tests/generic/744.out
new file mode 100644
index 000000000000..b40c2f43108e
--- /dev/null
+++ b/tests/generic/744.out
@@ -0,0 +1,6 @@
+QA output created by 744
+Starting fillup using direct IO
+Starting mixed write/delete test using direct IO
+Starting mixed write/delete test using buffered IO
+Syncing
+Done, all good
--=20
2.34.1

