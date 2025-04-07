Return-Path: <linux-btrfs+bounces-12823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F869A7D29D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 05:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00BEE7A3190
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 03:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA98221DB0;
	Mon,  7 Apr 2025 03:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T46vnJGA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EI7j9Stg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955C14AA9;
	Mon,  7 Apr 2025 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997753; cv=fail; b=pP3yS9m1FmwarBtK8fKcbYxRax/PwbmFLemppeNdUQ43VQZokNfHTpu5Gwf6rohyiE8eVMo8jytYnRfZhqvZJVDBIc/s6fHWdqmyJebty43oHxkV4hZhESlK6OVy46kxxAHXeZAf17uOMooEbPpLEgqieOSnNz7r9R6ulkFqE7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997753; c=relaxed/simple;
	bh=nH8BkVp2y11nlDu1qXgap9vTyMHVBdUx+pNcoxsR7mw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kC94iBnm1UpBulEBK9xN1ugXpSc+EaIWZEAOLoG8bc9OPcE+PTJ8R/iXIGdXwp8wP1/5Y8J1McLRpifJOcLKZet7v+5wNiceksZcWs6ESAozypdSDiDJ5nsa3u7Kd3e1dH91NYRBhMVXa2n3LWymqVqYpES7dC6pxwxfWr1F4zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T46vnJGA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EI7j9Stg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5371CJJ9004819;
	Mon, 7 Apr 2025 03:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=0PlBjO/meyU/F7Br
	ZO9rseSxo2sAG0KeY16PbolpLjw=; b=T46vnJGA/Ni5tXV6Nybymsu/hJRYJvEO
	L5y+VsJvSy2G/R830S1s0WwmxAUZwNtBXDPJRG2mT5gCZLuXOZZ01vua+oFCe5wB
	ZU8FmzPqZXXgn61a4xqHfi1x7k6tAuGG+G5alPvjDHJl/Y+NRhJVWt+Sa6MtJKUD
	bGcWTQ2MrwIwmUue3OCtqRgiAi806tKJtcqJpKsVi0LM169AxAOHg9qYCSTnO/pM
	R/RBxM7dUeVxVmHPdl96HAxoB6JA0YaPKczcFD1u17u22tH/7vAsZzs1HKi4aZg8
	DyphIi5RAFJWceklfvk9eeeUd6RcetvyxRKqO8QJQ6M9sex/GuN7RA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu419qsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5370UQKZ002089;
	Mon, 7 Apr 2025 03:49:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty77ey5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZP3Qg17rywS2YDkSXSkyjeav8ArQT3CffGFBa0K4SKAiYBitV4Pn2o2IzwRJ7faNQVNU0xJbSyc+SPfCfP9MJ9IOxF8y0f4q2V9dF6dEhJNn6SkPsKwOKEvvsurQwic9HjflrRUuhX/U0ztc060loscrCrN7iif89xPPX5RWiJopkAmxyqIM3jfiPyyWQzjZzp8f8AzHH7RG9HihsG3+4hXDObKRCJ5375tHzzLe4q7RwxUxicYl4sclEfVT9Gph6ohBABAaFgRdEAnFgZTZywMKaFLuFi8csULeX/h96X/Ws4ibZYkaPOFJCh2xQVKM45/fJP1IDKZrA2SUIqgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PlBjO/meyU/F7BrZO9rseSxo2sAG0KeY16PbolpLjw=;
 b=yB2kLEoxq6lOeC+gkK/PuuGcUvxiu2dr/H0ff78HWdq6QZ6VLwHUrWdChBEO4rXJW6rtJ02H9ZmDGYAhLFO2Dgi/XJUrPq43Xc7Q98nHMMiSJpBaFeteNNtbPfQ4rhTSSPWU4Hj8n5jX9G3ik/MuY/CemZnxNl1BzUt6jUwV9NKHjB7X1gAhCe6jBws5l/BpZ1zGo/gIIbG9UYFVorRBH18PmLpQhyJj6qHgqkw3PSNjLhlB35qb30YxS2k0fxwygsw4A1XjBwcO5TQPBhx/f9VsXAjcn4NnZWjphs3gnDQSkEMyVUf3OCugK9btNJB8kfBZg56hcbGGOD0x2noneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PlBjO/meyU/F7BrZO9rseSxo2sAG0KeY16PbolpLjw=;
 b=EI7j9Stguoo6qchONYvpnQzc6rg9PBdxyj/AMr9UxOmBndGw/IL/gyhDg9bzaQscKY7sOFi66WVYNOxhgBeqjtuETAstWEeN2y4TBzX+ORL9KeVrd2lDU07ybzDgcaacIyvBMza47mxX3KqOVRgEOuvkA/qMSlnQo3C0aCkpx4w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 03:49:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 03:49:03 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v5 0/6] fstests: btrfs: add test case to validate sysfs input arguments
Date: Mon,  7 Apr 2025 11:48:14 +0800
Message-ID: <cover.1743996408.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b3629b-684b-44d3-d4e1-08dd75872320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHVrazNReFNJbGExMUJmUkdvNXF6NG1aWTlSblNDSjFXbElQN1l6VTl4M1Zo?=
 =?utf-8?B?YmtpMUJ5QUVjTU14TE50RFlDTkRHeVovOVVEenNsTkNxdDA3ZGxlVkkrcjBW?=
 =?utf-8?B?YnBkY0k5V0VSaWhUcUs3TFNnMjUycEQxNGQ4NzIxNG1DZE40NHBpRXJzcVhD?=
 =?utf-8?B?eEc4WmljT3V3S2FzalFjWk5oQlBJa3MxSUllWHU4SW03L2xRam1vL0dIZVhK?=
 =?utf-8?B?UnRIYVErKzdDRlVRZjI5NUh6NEhtVDcxSlhUWDhLeGVsdllhT25KdVFWcWsr?=
 =?utf-8?B?aVVCM0JITUpiam5SNjdYOEdDK3JBckxoVklHK3hIMjB0RFBRREIwSHFvMGU1?=
 =?utf-8?B?KzJhYWRLcmN0UndVK3M3Sy9XSG5PVGpNNGxzWUsxT1lkTXRGS2dpN3Y0RjVx?=
 =?utf-8?B?TnRKWVpYTk1rU00wMmJSODk0b3JneHpOUkNSeUtKR0srUGFoNWMwaFRGc3Jm?=
 =?utf-8?B?c0pUZU5oaTVtd0l3ZlNJSFFFS3E4Y3ZpSi9ZdjFzcWw3cHhkeUVEdjdwVWk5?=
 =?utf-8?B?aGtLNjYreGpoN2FjNWlMbmlVVC9Lc2F5REpiQXJEcUUzYUwranhsWEVGV3JW?=
 =?utf-8?B?UXN2aVd2TTh4dkR6NjZGOHZobHd4ZjF6VXI3WHB0SnM2Q0ZRcEFQcUdJcEQr?=
 =?utf-8?B?cGFOdHgwRFl5ck9mby9NeEtDdnNtKzJZMVhJYldKSGlpRHBUam5kd0FCMVlL?=
 =?utf-8?B?Q3d4NHFmR2xEbGt5Rm5KUkVSWXFHSUhtNkNqeHloV3hzL3h2MkZnL255bm9V?=
 =?utf-8?B?THFIL29sUDRhd3U0OVhteHVXSTdMeVdVR3ZqRmN0VnM2Vmx3dnFiNHFoZnVD?=
 =?utf-8?B?Q1lDQTdoK2Z1ajdZUTVGSUFhNVVrbFNHQkdBOGlyaE9qcTRsK0IwTkV3VWxL?=
 =?utf-8?B?elZBNGY3N2UvUmN1OEtFN1ptWjZQbDgwVnV3N3F5bTRadWtocDF2U0lpRGJT?=
 =?utf-8?B?WlU0UjlBNlFwcFRKYUJ5TFhlMEhsN1JQVHhwdjJWVFIvTzN4ZUhDV0Zpb3dL?=
 =?utf-8?B?L3pwUWVjRXlQWW92R2p6ckxBcVpqQ20zcnVIbmJ2QlE2NG5uaWlhYVREeEV0?=
 =?utf-8?B?dlRacEhBb2pkN3MzUWg2SkhRbjY1RG9mMElaRVRpZGltVDAyUlpzNjhadk9B?=
 =?utf-8?B?Y3VjdGcyMVE5K1dPZWg5cEJhalM0OGtTamFISEF4TGZ0ZDdSR0hORGxxZEZO?=
 =?utf-8?B?UVVUaGY5VCtUZWhuR241d1NUOEEyQVBrcjQwekc3WUh2SCtWa1RyYkRLODlr?=
 =?utf-8?B?dzY5UHROREJSRlRJTnZJYmJFV3M5UndScW9qN2xLa3JvWUdUcWxSakt6YmE1?=
 =?utf-8?B?TXpBMGl1eTFTRUxDSUFKS05pbTUvUm5za3N6VlVjZWdRc1NoSDN4bU9FeVRq?=
 =?utf-8?B?K0ovenhMVEJnZlNlaW5wL0pjZmQyaVN2QlQ2czhMNXRVbmN5LzgvQVQ1aHFr?=
 =?utf-8?B?QXE4bi94QndJY0ovVERONUV4d3BXY05TTXF5dkxydGVkRUJTRndXcUMvQUNP?=
 =?utf-8?B?ZWJyeEJ1M1VPRXkyNWRzZFVaR0dJNnNINC95N3g3K0xIN2d2MVF2SHVhZnN0?=
 =?utf-8?B?OEh3Mm5YTnB5aTc2cWJDdmQ3SUxlOUVlWHJwN0tBeng4NGtNVXZHZlJ5d0c2?=
 =?utf-8?B?Wi90SXFFTDJ3blVWL3NscG9lSEhZV0lpZXFhMW50ZDlDZkIzVzdOWC85MTUr?=
 =?utf-8?B?Y2g2OGJjbVRGZHB5VytiSk1LYlZaLzZDTUppcjc0OU9TZXZNVkJCck1PSUcz?=
 =?utf-8?B?bWRrelM4VUFXWXVZazNTTmVSRVozU2N4UTFCNTNqR1p3R0xvSzVlUlFtYzlN?=
 =?utf-8?B?RTdOUlBzR1dBbjNGRWs0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEcwQ2xqdDFnaXovUTVXUXdhMkpqL1AwbDNtTy9EOG5ZUjBZVEJMaWZrcmhM?=
 =?utf-8?B?ckY3SzdieENpdVFvV01kSmt4WTB0WmNIblRYUTVVbzVVTHIwRWVmemJ3MTZO?=
 =?utf-8?B?OFF4eGVaNVR5aVQvZzlUQkh1cUhxaFczNDhwS3pBbU1vR0h4SUlHOUFhcTZU?=
 =?utf-8?B?Z3VxSGFreVhoT1JZcTdMcFZYSzJoRXhpUkVpcDkwREdBcWYwT1E2RU9HWHlF?=
 =?utf-8?B?MW9kQnJwMERQS244TS9mUG9oOUZqUG84NHNwSmkvNVY4ZDVodC8wdE9UQ3Uv?=
 =?utf-8?B?c1Uwd2tEWnNHcnJPVTlyU1RLLzVySDg4cUpaeHV3VlkxazlqV2trUmhlelpz?=
 =?utf-8?B?R2hlVlp5akE2RTVmcHhQSDh6blBVdzUvcGN6NnpjU285YUgwN0lUY28xMlBt?=
 =?utf-8?B?QkJoM0s3VldYaVVRMmVuQ2RVUHhQWTlsUUFvQlVTci83bENwRHhoNDNrSCtY?=
 =?utf-8?B?SEJnUTRhdW45dVE4aENSRWlNVUc1OFZLQTh2NHlORHhwVktITnBLLysxR2NR?=
 =?utf-8?B?WmdhV1B3aEVFOWxmRi80Q2ZrTjZldkJNaTRhMW0vM3lTYjg0TUdpZEJOaTdy?=
 =?utf-8?B?YlZsdXVzdU9DUVYwSGpabUpVVGsybHRQblB4Y0tNUzQyeld4NTcrcEc2RUdj?=
 =?utf-8?B?TG5CczZsRnFwTXhiQjl4bVZSVnFiVTRhRHJYQnJNRjVuV0ZObnEvZ1o5NFFJ?=
 =?utf-8?B?UHNEVUwxK1BPRmFwV2ZDeHg4djI5cXR2RjlpMGp4L2lmMDRLS2doV2lENWJM?=
 =?utf-8?B?SWxXcE52Nzkzc3JKUjJVVlRhSTR3aGhTdkFFS2JuVUdKaUxoK1RUdmtGR2dq?=
 =?utf-8?B?Z2dpODhjOTFuYzJwWmNaUnRIUk9PSEtTek0vOXAvWmZReTNqeklKRUFsWmdi?=
 =?utf-8?B?ZXg1Y1RnTFVhdTRjdmJEVW1zVUo1SW1va3VFdlFPRU9CNlJkNTBaOExsaGdW?=
 =?utf-8?B?UFF4d1FydGZrZklTYk5xSDhVNE1lR0ZTZVRWTXNQV2xMU0xlL2RZMjFac29u?=
 =?utf-8?B?ODJ3dGJ2ZkRRckRmVVl2WlJsTUFZaXlqSUg5VGpsNUt1SWZLaDVzaVNWSDN3?=
 =?utf-8?B?ZXJ4M3NodFcrMkg1U2xmbExZT2x3ZkIxN3d6WFdWWGZ2aGVNdUNlU2srajgr?=
 =?utf-8?B?SHVqWW9QNTVIUS9mUXpBT0YxUWxMeHNIUE42N2RZdGd6ZWhnd0piTFBQSllR?=
 =?utf-8?B?REhyenR6QlExSVRLT3dzUFZ2RUNlcDlFcDBVUzNlelA3clptRkNQZzFmRnVo?=
 =?utf-8?B?azROZmp6aTFoOStVY1FyRGpEQWJMQWJEQ3FLNHdCRkYvaDBnakdqbzNDZmlu?=
 =?utf-8?B?Z1BlM1pTZ0g0NFB1OU81UlVNWUR6RjdTSVM5M0FnVWhVaVJIT1hjaHp2L0hD?=
 =?utf-8?B?dFFQcmkzamRob2p6Ny8xZ3RsNGp1ZUEwdytua2w5ZGlabXFHanRyQktQQWlP?=
 =?utf-8?B?ck51QlVZNjZSODdJNi9tTEIvbThmMjh3aUdUTXdXcHNEZWQ5bHAzV05kUnpF?=
 =?utf-8?B?Wk14Y1l3a2QzR2FwRGZUbDNyYzErZmRsREQ3YXNCV2xHT2hDMXFCbkRzOFpu?=
 =?utf-8?B?OHZldy9vK0FuTElLTFU2bUFhMERWNStkWXNmU2J2MnNTSCtQVHdQdCtDQUQ5?=
 =?utf-8?B?cmRZMmE0R2NXZ1JoN3lnekRpUXk3akNxL3dnMkZ6eHJwUzVTTUxheUhobndv?=
 =?utf-8?B?K2JRWjc1RE0yY09pdUxqTC9iNk96eXh4MmJlQjRmZGNNb0N3dkZBdzFVUnB1?=
 =?utf-8?B?Nm1lWVo3eXJCNG5rOW4vcm5UTGNzYzhaN1dXaTV5ZkFSWnQyc2kzekxMQmg3?=
 =?utf-8?B?cEFVeldDMjgxdzZLRUFiUmhCYVBrL0lyWnI0ZU1EMnpRWER2ekRPRzhVbWlF?=
 =?utf-8?B?VVJFR1Y1VUw2MU5RN3JyRFNMWkRqVzduZWg5QlBzMU5RMmoxczZ3ZldyQ2FB?=
 =?utf-8?B?MG5iWnhmRGdWdGJVM0xVMlZHUm5jc2pTa25MWFJsY0N2TjkvYjZMekhQMFhU?=
 =?utf-8?B?M0NsdTV2Z0hNc1NKd3RySVhLQ005b2lyUElJTVZ0NXM0WDI0N09IQ00vaXNY?=
 =?utf-8?B?R1c4SUJtOU8zK3J0Q29uT1RIRUR4TVNZV1RFbXBTMlVwNjRTYjRJSlJDSG1i?=
 =?utf-8?Q?VgrTMQ5FYuijGw/WzuOt86TE2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GScrzQfDmdeaUE43HgNMNF1rF4PB2Z7NzwuG7FrudXua1p/TQhBOv3rVsswx+Wn2P45EMZCnHM9tDyrj2eNJDAgWX5NBhm1WmHd6EYHZj3vX0GSvU1am7l6zw8fMwYH7MFq/bflT5tkb2sYVxgPpjzLvLsyNc3gVp3mg4tph/Y9CNg5a0SofleD12OWlB9euYR2bFMZYZcDigX3VagqBsa72T3IshIxlTSEVohmiRE2YX67sdw9CxdLPEQ8rPsoe4OcvClwhfbmiPYhGTOjpWohPx9cBVoiMVn2fYCwxUjOU179OckxmEBUygX2Ov+MB4av0HGrjzFmICzZFIfTxHytysCCULOFZV8tGInPKAUmjJRGi12Gnp9zaR791z9SR1fEUky4g8e1PXgs+vQCmsqvlS1GrNtkXYLzc9z/1nJzMZ2y9xQh2JK2TpVxJfMQ5vL4ieK2ThEl88OE4ViOwqeiqH/cGIw1OKkRAyGs5eXvk9fbpv7Vf3xpid697RFUtOpb5PH6X1NidrBoshhl9lXCXo6bUIURzDB4oZzb4jrnYM11Rc+hOmbGSfBRvYOrdLMMj/VykasGfHqJbqd1fMvwzF2CbllR+zbS/IP9Yziw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b3629b-684b-44d3-d4e1-08dd75872320
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 03:49:03.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EJ588MyBTPUhSVaIA+tmEg4Wx8M5SYHr5CqnpOR1bBsEyJWIxN+XAVrGKgSCx97Apbl8YpCsNNIKF5GMN5YpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504070025
X-Proofpoint-ORIG-GUID: Ky9COCYjnzCzzRKKwFCMSmXTkQ2oMHuE
X-Proofpoint-GUID: Ky9COCYjnzCzzRKKwFCMSmXTkQ2oMHuE

v5:
- Added `rb`.
- New patch (2/6) for unset `seqres` (can merge into 1/6, but skipped as 1/6 got `rb`).
- Fixed `git am` whitespace.
- Renamed patch (was: `fstests: common/rc: add sysfs argument verification helpers`).
- Prefixed helpers function in common/sysfs with `_`.
- Updated function names in last two patches.

v4:
https://lore.kernel.org/fstests/cover.1740721626.git.anand.jain@oracle.com/

v3:
https://lore.kernel.org/fstests/b297a34f-4c09-48bb-86a3-fea50c364ba8@oracle.com/

v2:
https://lore.kernel.org/fstests/cover.1738752716.git.anand.jain@oracle.com/

v1:
https://lwn.net/ml/all/cover.1738161075.git.anand.jain@oracle.com/

Anand Jain (6):
  fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
  fstests: common/rc: fix unset seqres in _set_fs_sysfs_attr
  fstests: filter: helper for sysfs error filtering
  fstests: common/sysfs: add new file sysfs and helpers
  fstests: btrfs: testcase for sysfs policy syntax verification
  fstests: btrfs: testcase for sysfs chunk_size attribute validation

 common/filter       |   9 +++
 common/rc           |  10 +++-
 common/sysfs        | 141 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329     |  19 ++++++
 tests/btrfs/329.out |  19 ++++++
 tests/btrfs/334     |  19 ++++++
 tests/btrfs/334.out |  14 +++++
 7 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 common/sysfs
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

-- 
2.47.0


