Return-Path: <linux-btrfs+bounces-13919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C7EAB42B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C103ACE92
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9C129824A;
	Mon, 12 May 2025 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V0rCb8XJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Try/dNGt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70329825A
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073264; cv=fail; b=AXl0WLsitSKpTaLFG9Zh7oVxz2tVqNAKaBqYcs+nsmdabsai/47nOLxKn9obKcbniqaObHgXHgD4m5tFqSciuPesR5lDgivQV9gzjVujQnJSbqCl1+S4GP6q1Ed1SgVAmpWxz0LMlFSWMrCj6KCCnABMA2O/tr1ZsqTE9B3H9wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073264; c=relaxed/simple;
	bh=28N8KUshOVR1K4W3bQGx6cHwnhEqor3ueyaVAAXq8+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8EiT5E9BCe9QoPUXHtAcNRS7d27k+C5LxmlptnpclWIwPQ+HcG0oTy7Hk56RJqwGfkhFOn5KLnenHceksOnzEYyGPE7MsGFXhANoTscJWnADI8rxDMcBdIjVHveJpHLHuFxGX+UaFrn0wjutlU/z4ADdjUv6TC0VshBU3gAGkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V0rCb8XJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Try/dNGt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH17G9028364
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wciQdgg8n+Q2OVNI5WN716U2Ti5X+IAbu6UJFsw4iAY=; b=
	V0rCb8XJ5Ym+LutwLUtv+5p5iZgVARQRZzl4ezNEqgI9ceOYGQGkVagmLaJ+oXrR
	/D69HXIil2o2W9pq1EvBpofVT6XY3A+fCHDmdW/gFAcpojg0VqnbJ0CG38iHwazb
	hPGRbCDAK/W/44iFLXZrXYnwA4kCUshCiXM/EzWEaU4IlOJUHVYtYu3H6RaYjMtF
	4UEdKFyS8sLw7lhCyJdioYTdcnxoQd31ThUKSJQ3VAm5nwomvj1/idAQjncCgTxV
	TNpMpUPXlsc2xB53DpWnvHxD/qev4lMyo+YdNNgvsg6qdkBmO6+tCGZvgofvW0lT
	DF5/4125fYQdIgv8jbgvjA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j16637qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHQaXt022509
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88q6s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7NLyqFp0m+IecPwMkJJCkIo2WU0ng3BgacMIMkJA61/Z8rWZgzy7uVZoYuaCriI/KDqpZllEHocC0Id6wz43CR2f3xBvc8u8gcVoKArWRmpAnC6ABIHVTo0XEQR/cHxB27cKtZGw6NsSkOIGE41bA1jl5VGiZg3KW9nO4SgaJZsGyEdLqyBp1A/E1ZAaXU5R8KcGef7lz1QyH6z+xhAk/JZWHtgYumsHmMJB7TKF4yaqJVqwiiYPAtgFmApSvXhOEc05Bmz8BUeUWMziwtjAmAXw55JxMBB/tHdQUJpzWkG/9sgBd7PpL9UhKPyXLmwDILRUuwXas3xvenq4qWqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wciQdgg8n+Q2OVNI5WN716U2Ti5X+IAbu6UJFsw4iAY=;
 b=u1AHu6niPIEhobP4xuMS7tURfesYS7gPqBWvZdW3zqvyobUSPZR74bsjV+2KF+E+ma6Pgpp/HYxeO2kzRD9vQzMFW5QUzHIaXvJOmh9NSi+y0A3hYSFVQc9HGj6CzZ71652+crQM3DBjllBS3NDsF4fDZmLwHm+8QVwHEJF6Xcv2xgdCDMUvmI6sTXxfxzaktQZm6hEjxWdvIGNVAtTM+Mg9D9aRAcCBjbgfvvJecLafWOi7GD8iOeRwAsjLwymmLZSqfR8AwbN0f3Cz+xd3nVYQ1AmeuNsWwMpZtx7Z1NkC2PLL5Ud4dPnMh+dj6QoZf3m90GJDJFgZA3I7SAPNPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wciQdgg8n+Q2OVNI5WN716U2Ti5X+IAbu6UJFsw4iAY=;
 b=Try/dNGt3PQH2p3VnD3Q51h/U6xMmZbWtB8etLeFKmbk8ouxkfjO2xoeXb0MyPD92q72Afckb182m478FAAyUr2nrg6/G50NomLn9bEQg0VqvSj/2cTI3G3k/LHtYTmxVfW3zkFYegr+PdaYhr6aTixKFqnuy7OPLihA+auEFe8=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPF415C917DC.namprd10.prod.outlook.com (2603:10b6:f:fc00::d19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 18:07:39 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:07:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/10] btrfs: refactor should_alloc_chunk() arg type
Date: Tue, 13 May 2025 02:07:08 +0800
Message-ID: <49d893a0a3971d13626f6514428bfa6c00d1a6ec.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPF415C917DC:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb5e951-2efe-452e-8063-08dd917fe1bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HTdLLSIKNPoY9ssxNAAGCuG+6bWKFgfcIXOkpmMlr/IrwrdR6uEM25I9yRMC?=
 =?us-ascii?Q?cSqzw8LOYxXoe5mebt3s5uCEtX79bj0X4LaqkRBg4blh/BFfaPIM/iQAe/JJ?=
 =?us-ascii?Q?Jze/BA0g0y7mJAELjM+8/JRGUJR3i4eOYiCTR1SPlvXa0Jll4Bp1R7DDpKSp?=
 =?us-ascii?Q?TmFJODc6fo9Y/d3Zcu//JKzxoizLtaQlqr8XOJiPOe4epcMpqtktNsdTVne/?=
 =?us-ascii?Q?EeNFqdaeUflq8T4uzMBQsE95l9nv5M3IRpiSMOsVW0/yTHQJxiHzOGZMtBci?=
 =?us-ascii?Q?zx9MfBsuQkSD7hVq+ZlfiSsmhRvNQPFkQnyuaZcGd2ZQAVFxPvYqI4HV9mqA?=
 =?us-ascii?Q?FpIYPz24/f8cGyYElV+IWsUzqtUIinz+wgPYbYlqbmhNmuVVlmrFQesmy9Fn?=
 =?us-ascii?Q?dMFdoADIj710uTwcLy+tUpsbr7dEz1hH3qAOk2o9KhpE/W1BV1PGKNpxLyPO?=
 =?us-ascii?Q?e6OoU9YV9EMi5QozCbpUII4WEm5xVirtNbivYMOoUo44v/APWeCTQbfGunZG?=
 =?us-ascii?Q?8bD5jsR2XHjwMvAgorsW0ZoMYhmr4fE3vBKZmvW340SArJWqWPT6gDI8WhsH?=
 =?us-ascii?Q?RB0T2VfcODXVLS0+8Z87azcqqQ7KDharlXiM1tPnJKudLRTq43NK1faTh6WE?=
 =?us-ascii?Q?Gi57rn0FumzCKCpycBSh076J0v66rtaOAWJ3kVmHplJdREYPyDrCSQTOIwes?=
 =?us-ascii?Q?E1Zf7WgxUy9T7r7gsMkpESUKih1cOOh2S+FU7aoH8uDQfYb2K+aU6XJq8TnA?=
 =?us-ascii?Q?3SbIP9dyWX8BUwr9/dzi3asSB1iEJ3MwBeYpGvsFTbVADpLeB228udqZeMBQ?=
 =?us-ascii?Q?7iqoyHJ8GEkMxDWVcID2nj55iRyIp1Rtaf6VpCIfRfRWtEwy73lVsWmGEEgh?=
 =?us-ascii?Q?afm2GPgDQVUKT7AlaWH3Pbjj0KGv75v4PlIxEShCTMEFXyvd+HOlOp9ptVoY?=
 =?us-ascii?Q?78hAccl6w54GxKvdTbLnJvI+yxWfUW0aY73kivfOzm3J+71TRxocvUXzxefA?=
 =?us-ascii?Q?FYidxSV2tDM6kicY+r6kieEgYiHUctpNhQlpbeNNYdAdNILy47BH9Oa5XI9Z?=
 =?us-ascii?Q?7b2Wcc5UqWmLfZjHVKb4wAXdWSmo4bXgEEOciIqF+cJplV+4ulyJd11Dtw2i?=
 =?us-ascii?Q?nz6inGXUsl0sm39Y8JnnuSIylYtW08130cSoSF7Js1T0B+lZMgdeDBbQbiBP?=
 =?us-ascii?Q?KOnxCvuevj8sOvkpfozgaT0VjMasGFKO3bdt/u4SeoUPIl/odEui2dGYEaGz?=
 =?us-ascii?Q?S7xCQqpHcb8m8dFeEBuPvG+KWisc5YX72kPCIdFI+6DnMJ5aODu/Umzkbfpu?=
 =?us-ascii?Q?SrsHhheya/z5TCWwGCBSAthlSchpYmdadUQPk5ZbKdQ82lcmUqMgtnlvWZw1?=
 =?us-ascii?Q?+eYfLGsHMpvZseafUgCbVs+r8kQ+N09zsLKcsT1dzxKpx1cjGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?acJH9/J9d5e/WmgtRNXM/jlGe9ZXrfSRNddMVCJu6db1r1FlyfuZ1lX6DCdB?=
 =?us-ascii?Q?SVi+wAhSHYJ7QENn7c+IZR716vn1X+OjKmP7nH/AYBPQ0m3PJigzDExCNVBc?=
 =?us-ascii?Q?7aoqa5v51C/0eevkk9U+6kEwE7pywf2Ug5h606xd18KjAno5zkHRehFHDOTw?=
 =?us-ascii?Q?6M58kDdseZOLpdnqC7tjmxBX4IHY2HzyjRwJrryQ9LKgTjLrBfpo8ctkMycj?=
 =?us-ascii?Q?HTLlUB4EOibNcYtQs6v5X0GTGcmcaqE/2gLyCx2TgCxkGyeBlJsREEHWRMrx?=
 =?us-ascii?Q?Q7oex1dGq+lxRCnb4Rti6QHr/2BRp8dOEWm3UzOHp1uLrtvICN+tnCfOSr9o?=
 =?us-ascii?Q?3DIKHh+ZR62R3OKx9QfWznrzPjdrFgcece6VArc489hs6nif3qgUmqbttHAV?=
 =?us-ascii?Q?OgyGV7Ys+SrznPhVAq5k7t7nolmm2cj8jhISkdjXkQtXprpRn/et/vAbRE8w?=
 =?us-ascii?Q?TVS7XDG49fG7Qbvei8F5juKZ2LfFKCckxu+lcQHaC9FnV6YZ8v0RBl5LwXBi?=
 =?us-ascii?Q?HhkYzSj6rpHhNzwHfrF3bouagMStGgDTcSPLyVi5dtUJQNbtp+niGGo1bx2z?=
 =?us-ascii?Q?Y3O1dVs6dWXzQ6gBjnt6hEkSqdRHnQKti6v94nresz0XM68Yx72w4dHKliqM?=
 =?us-ascii?Q?It7ai5clJnkoT9Ou0ebE5dPojzAeOlRf23UrywUAxHEiNH/xHmAfeg9DvHmc?=
 =?us-ascii?Q?lH+lYiOIytouLefDiTALKRZdZ/se4wQ1GEkqiEUprhw7Xw2ouiAJk+dTs6Eh?=
 =?us-ascii?Q?CnfmKI35zDRmjqiwoNFYuayjLGfHPYv4dLF0jVU/qGH+qrdehtoPjrE/nZRJ?=
 =?us-ascii?Q?5BsYeL9NAswBkuSrqHEFF50FISma/KKSr/u+1OhLEgJs3t8aBQCtqUeKB6IV?=
 =?us-ascii?Q?FXoSE4sqx+I8j+CqoJ/kTt2HUtO6/X1biIqVY1LSQ6mh6xdIVojVDAYi7/+r?=
 =?us-ascii?Q?aFwRzJNviqFLdSIKEKzAf+OFG72JVibTgqDXVdB7WaYOmc2zy0dhW3mIO4Fb?=
 =?us-ascii?Q?QeI/7+C7cQBbW1toj5ucJGAoPsLk7f0Huy8dbS6xj5Lrpx2MMLuf+9WImEtj?=
 =?us-ascii?Q?Qlujumptcs3NDlcTSxoLjcfMxa36ETewldMvePReEFEZ7EzL74odThByqe2a?=
 =?us-ascii?Q?CsHkzO6zPdYTygd75Ab0DFY/JvMLzDyJZfF1enj9HCqAGsTUOpRDt5A5gEsV?=
 =?us-ascii?Q?tSen/KTc0PMHBqEuPSZFvLJdosR0AQlPtByg8fPT18yI76PtxnLbkZIYFDCG?=
 =?us-ascii?Q?2UW16c9qKQNx+p57jmlWex5J8JAi4oJuiZ5YzrV70QigVzOrPoAmQqoxXdMd?=
 =?us-ascii?Q?fpP186pTE2aqaryMJwBKbYoeL4x+iCV1A4RY7QOywE2r70xwsnUdufeDI/Rz?=
 =?us-ascii?Q?XtWh/kMEGFcE2/wYeDlBrfgkVU/tHAfDnA2KxxMcZ+njrqmiDtoOK1kRvV3c?=
 =?us-ascii?Q?WZDOaiKQHhsMIB2bCgcZBfgqc1AqT4DynSBMzAfuz/BTXgOBpP6k0bGEcz88?=
 =?us-ascii?Q?XeNms4mwrlGSjbLqHdSUbyCAaNRZg6GmaU+KuT5E9r7l1vD3U9+z+GTo/kve?=
 =?us-ascii?Q?+qfWSAqOLCcR80J0sRBm5AGXzmbEVogYnx7p0xPs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r1ZZ/3gyFfAZ48L6dvi3H+ZqTidDamROBFUMG2du2oHHBizwhfpLOy8xpxn/rRmFXR+nui9iT7Qhje8XSPAxPsinrj9T0tDQC17W8D1aDMEqUTgie/M+qkymdSE1tR9DCDr99BN5YS0jFHpiBhOUmUUE7esfA5nMnCchRuIQ12wGuw+lkHZ6jO5bEsMFx+Knv0ct0gJx9h5qVS53q09b16vNWvj6PLOAWm1UiiQUOYBZ+K03tVYFS4Sic2E9YxKap0Ex+ok5/lGPTvdPg3P7b3ZM5K283QydaMJFRlYLTXpIebFEu+GvjuvErVDpSyISPGX4ZkNDq/SmYgakWDAE86eRqXjizGxKYFfDfYvKWMXYxCW7xwzKOOD8IFryxJQqF4Ek20nWoQvPIb7kfNIAEngb19Rn/AscFdVzUJqgywlMaSH1CFlclpKul/TltTGtc3lSH1Ku/L8/tB/GlOPfKcrW8SYPX98bx94+/BrR5hpqWmr+Sh0ICIhR2JTqUxOsuRqcRYCDIKhFXUpXImQOa59mOpMHXuWFaMwoInkFu66LvrRZfwNi5MjTqWFtRaH1X0XAeKxjFrQvY0ULUzNFYsql/+JzFXzJfGcUhfSRvw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb5e951-2efe-452e-8063-08dd917fe1bf
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:07:39.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA7FBcRhulJMfqso4wm/GUknavtVDEpwkki9O003gHJbkCmzqgyLEAyZ4yauvhH6uPx5Iu4mB499PfPINxrWSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF415C917DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfXwldlaLf/d1w9 tvejqK9Yt291oaO3iJ2Hwzt2KvYkew5kHxByPYEZYzLvmbDO4t3dgqU6tefmVStkL/6WytaQ4X0 1D66JNhfBioxjiMguF2e2s6Pjn/4It2voCN2lIj3dp0Wa2GfRblNDpIepzOtlMweC9a1rNuPgJz
 FM94yJdJplgbGWFvMigsM2e8gKT+gM5IQh8WoO1VN8BBEnslqQQlSuMU+tZyHSuu6VtHVzApR77 k6wO3bH+rWdR0NN74eHribnwrAiD2Lf2+jMeDG4rFR4+nTxHDwfRaaUbC8mMSMiLq7LeFTe/rn/ NRUuCvM07ow/G9CqsUO2mR1ZslVQRTXceyDY+o3KPYINvN+SiV/ZQbCvKU9Zeql+BxGfwQVbuN8
 59AMM31KhS/7m5UKW7t3Q3AQmtE2dR83mvCIeK29ghtRfn9Q3E584QAlsf2rOh0or6aIpAC+
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682238ee cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=AAQpghrRSlWKiBGlPw0A:9
X-Proofpoint-ORIG-GUID: sSkBdoxIadgHFTpcPNzbSLsdCGCRWJAR
X-Proofpoint-GUID: sSkBdoxIadgHFTpcPNzbSLsdCGCRWJAR

The %force arg in the should_alloc_chunk() function is type
enum btrfs_chunk_alloc_enum.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f8317410724a..c92345619f96 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3873,7 +3873,8 @@ static void force_metadata_allocation(struct btrfs_fs_info *info)
 }
 
 static bool should_alloc_chunk(const struct btrfs_fs_info *fs_info,
-			       const struct btrfs_space_info *sinfo, int force)
+			       const struct btrfs_space_info *sinfo,
+			       enum btrfs_chunk_alloc_enum force)
 {
 	u64 bytes_used = btrfs_space_info_used(sinfo, false);
 
-- 
2.49.0


