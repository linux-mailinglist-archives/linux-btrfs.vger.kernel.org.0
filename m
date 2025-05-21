Return-Path: <linux-btrfs+bounces-14144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC8ABEA41
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 05:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EC54E27C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 03:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A4022DF8D;
	Wed, 21 May 2025 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="haesHfv/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xHGMOv9u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5F22D9E7
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797304; cv=fail; b=Xj33NS4p37I3h1IvapSp37QPhf3E2yk4bZ7jB7tznAQwsu3EzHqw9ku3xgUnOOPDYdYRJ+tBrGNW7ffEj8k6K1FmECUmcMG/aGgQT1Oa0bVjqkEbGPESDb5ggfE1aRVRsKhGJZFoYsuXaXKAWS0JbwUssJAweRiorXs7MpDQRao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797304; c=relaxed/simple;
	bh=UkHNzBhUD6IL4NGB3Ql5e1PJlq2qQnaIsvwDC1qAGnU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rbEKLN3ki7Lp3OkIDpu+QWDgFDa8o9nTcxHnvWpY0n0RCGAgxDrqvAwBxLqrv/F6uTVIcWA/M9gekuUHrdtkoSOwSoGcrng2NUBF6BBFelbQsMHrouwtTgIMl8308vBFwTMn9IHKBSRiDnQPu8jQao4m8HNCK38Z0sZTDerO3yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=haesHfv/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xHGMOv9u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L2u44o004933;
	Wed, 21 May 2025 03:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HGHFxzcwZmPh/0rB/OF+RZqfBmgcQR+ubwuauIMFuYE=; b=
	haesHfv/x8NlRSIV2vFhiWlaJXBvugN9xnD1ARFSrIxGegFeIKOr+fUMZvRO00I4
	FOY0syRju5vFRuYgJ7uROBDjtDUVCeeDOAMQFPFa93NbSZjQwanYnhOdkn/J6EZY
	PuyTOvHUAiNCw7mPImCMf+Yu9jgLQfvrlnSqMzCJE7Aw7NsTDrwzWOe+RsI6bR1j
	uCWm+zL3pz9Azqn1iG2AW/L6b3qCIV8zx4+xRAM7NGef8/6VcGGcGzyxM1bB1pqX
	myzVM7li6qqTM3ROz5mZSnUdaVihWqZsCLZiOmdazqhfif++AoRS/YnuUsy1wwcF
	bSDVtUTbsJnPe3Dq9PjwUQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46s671g1xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 03:14:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L2DalX034612;
	Wed, 21 May 2025 03:14:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwep9yvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 03:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hj1Bn8wi8qP21ne7goUt11QDJbppluRAgLRPpJiNaF2zLHcGXcyxiMtTSIkfFO2XGZt9a/9IfQnnCt6o1xkj1lW7pfLi5GZIOc+1fsZa+jvkNcx1T+0H+YlXBfuo8kEIw1zrpYh4Yc7iyKK159BFUJ8tqX95F1Q7a6Kg7B5ZJ5/Hknu0TbhgLXfkJ9GaLcl3qi5zvSAvnSCz31AcMEjnz01jEx9IS6czQrak1Ju4D+cbf22p3H+oDs7we4rgOfVMyTa//cK92QRXuccFsxQmFhMclbZhbG6bzluZs+ZIKDU5tHfptio3a3UA0bU7dLzQjs46W7Dddsk3VeFWZijjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGHFxzcwZmPh/0rB/OF+RZqfBmgcQR+ubwuauIMFuYE=;
 b=RHKWItrYYdcPzaElI11/ZZyyZE5LWIZ1AJ2d4zSExzlIyVUwMHrfh5oQDcAnfbuX6U8TaA2N8lHPD6CYCVuvmdGqUUSq1uSphk5BQpkMNJ6KCegBBbcsRDvzlQgHWUUI6vc0pN5x/ss9a/ia9b8NeW3Shtojn0QiLeQR+e60lktxNVf2qQHlKFc8HtEu+664i8B8yxDRekLTkVmDbzwPj34aWJ4h7ADse5AkVeA9K7lAHOH4o+nQQ+WoCu/LddRIqOTFia5NWEUGNW7enfpXFeAMU+nYc6b3X8k3R+jiMcs4Xz6UDVqrF7YLCj0FbUqG0R/lX3UWSz/gx3k96R40BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGHFxzcwZmPh/0rB/OF+RZqfBmgcQR+ubwuauIMFuYE=;
 b=xHGMOv9uplADNuFhgrYmSXIjra5wYTYGhImPj0TGsUU3mlJeMMSJnZlUPDEMc9TcI7O+LqjYWXdEHx3UcwJJs9V9XuwG1M39qsPnyqJLk65HRuKNz9jJWHNaCVJmoafcKAhh+ArzLBmlx5kU935Qh/9F5Fi8iTj+hBqS9EYsdds=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by MW4PR10MB6606.namprd10.prod.outlook.com (2603:10b6:303:228::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 21 May
 2025 03:14:55 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 03:14:55 +0000
Message-ID: <74ee4615-09c7-41c9-9197-c83b171f1c74@oracle.com>
Date: Wed, 21 May 2025 11:14:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: preserve mount-supplied device path
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <85256ecce9bfcf8fc7aa0939126a2c58a26d374e.1747740113.git.anand.jain@oracle.com>
 <da820980-ecc2-41d2-8406-fcde11b0bfb5@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <da820980-ecc2-41d2-8406-fcde11b0bfb5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|MW4PR10MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 58992c4d-7f0a-429e-d241-08dd9815a898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UERXZzhmeGgxU0Q5ZU5KUzJ2MStLNk5RVWQzektwb0U2REszdE54TkZBbnN3?=
 =?utf-8?B?NDk3Q1BQUkVNNmozcU5DNDNab2hJL0dWSGdLSjFLU2pJVk4xNDBvZnlDK3Ji?=
 =?utf-8?B?dlFINEpqL01DelBMTlRKZEZEbnZqVTFrbmtjUHY0M01YQ0FkTWw2NDFkTmFC?=
 =?utf-8?B?MEorbjllZjh0Ti9WTFExaXV5SHdsZWJYSStmVTNDUE4zQllIRnovazliblJD?=
 =?utf-8?B?ZVRyWkRBQjlOa3p4YU5iMU10SjV6aDJ1SjNPdFVhUVhsZEpWeVl1V1p2YU5X?=
 =?utf-8?B?YnhaSk9mbm5zOUFxN1p2eG83TU9wM3BuWTVDck52dXFqaGpVU2R2LytWNi9S?=
 =?utf-8?B?V3M2WEN5K3M1SU1abzBKQmt3YUJNenNmbTFMS1lkbFV3U3NQUzd5UGtTRURH?=
 =?utf-8?B?aytpSi83L3l2MG4xdW1xRVJDTVdhVUh0VHYxWXlEZU16cXlMWDhWMTdVOTNH?=
 =?utf-8?B?ZDc1VnR2RU1Qd05vOC9hVG5xNnZTaHZxNExSZDk2b2xtelc1TGJCTm1jVFh4?=
 =?utf-8?B?WDZVWDZ2czBzMG5jRzVvNlI3V0tha3Y1S3FJSXRqQWlDZWlMOFhXWTAyMXRD?=
 =?utf-8?B?RzNDNE95V0VRQ1hFUDVNWFdoUC9scTR2R1lWeFVqUS9WSE05ZkFlcHFwZTlX?=
 =?utf-8?B?NEJqc0YvUUMyaFE5NktuTlRhcmZqOWZEWTZEajZNNlJTRnFrTGRqNzA1OHZ6?=
 =?utf-8?B?S0E0YUtpNVI1dEZXcDNvNnV5RDRUa2wvNkdNVEtjUGRQZG8ydVBYS3lRUXdV?=
 =?utf-8?B?YnU5RXF4NmIrMVlTdVdmRlF0ZU05am4zYW5KeUhDUEI1b0RNRWJuUXJyOVlQ?=
 =?utf-8?B?aWlDSWx3ZHVVSkh0QXcxNHkzUXJIcXZ3QithdGFnNUJPd25MM3l2MkVpK1hS?=
 =?utf-8?B?NDRsWWFPVEhlaVZWT2RpVTdTaTNUK09OZExwbWkxYkhHdTF1ZXRIcERPTHQw?=
 =?utf-8?B?NVgvRThNb1pDdzZLbDBEREtTWXNJK0dyZ2NqZE9ic0t0YVpid1l0QVpIV0JN?=
 =?utf-8?B?WWpxdHozUmVKQzVXNmhnRkRqZG5kZlZyNzVEaktRUWJieDI0VU1XTU15czM3?=
 =?utf-8?B?MFpKNE9lQTAxRzROaEZ5Wlh5S0xRNzNubXRScFlpSGs2ZXFFNlRqbzBjQXZn?=
 =?utf-8?B?dHJ5Ymd6ZmNCSU5KaDZhenh2c0dHL3pOWTJrLzMzQWR0c3pyNHRBbVRISFUx?=
 =?utf-8?B?akN1TG1ENVFFVGdkSkZxQitYYS9yOTArZGMvRkpNRXROWTFUcjIyQ0dQbDlx?=
 =?utf-8?B?UVZ6WTZucFlUNWp6WHREMWJkTFhxQmxnSVl5WTZOTVdyWCtlbEwzUUUxaXhu?=
 =?utf-8?B?ZGZ2MDFwVEYvVUNNOUZUcDY1dGtjc25uQkc1ZHJUbUJNdFl6N1dVaXBmNTRk?=
 =?utf-8?B?VnA3TGV2WGlMRFFZeFpxNDM0aTVyMzl5MGdhYnFpdDQwSlBtUjY0V3paWFpB?=
 =?utf-8?B?M2xZZ3dPRTJndHhuSXBwQkNvcGJkNkhsWGpWUHdDb3cyL1QyZXhwcUtqWG1D?=
 =?utf-8?B?SHp0MXJ4L1BLYnRyMUV2Z2pSWWVJQUxjcjhYaEduM1JUZE9vYkxqdmk1UGNx?=
 =?utf-8?B?MFNjUTVoazlhYTF3eDBiVmdtYjlnWDhZc3htZlZyaEwvbzk5ZVVEQm54Sjl3?=
 =?utf-8?B?SzYyL0k3d0NncEpaeTh2bWczUkRUc3YwV1ZJd2FYY0U1MXMvdTVzOGZMRG8y?=
 =?utf-8?B?Zm4rQWZqdzhTbklvMFZnZHB1Y21ySXM5QUphRnlzd0d5TWpQejVpeEhuT1Iy?=
 =?utf-8?B?TmZkQnUvam5hRDNiUEJSSncyS0dibHNlYXpKZG01eGpuWG95SVRjcjlxUnB3?=
 =?utf-8?B?SHRFNlMxRWlvOUlINFZKWmxDVGRJTVJWQnVoZmN0TlFlSlRFaFBGWEVDZWV0?=
 =?utf-8?B?MTFYUWFmYzZhY3RvYXBVS3BDNTFGNHlrWWxjbU1SNlZld2NoZGF5U0F4TkxX?=
 =?utf-8?Q?nX5ioxpz4Dg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVhJMHcrODg5UjBsOGJBclBOb2FweFVyNk9UcnI5MlRQNnVKeVhWY2dyMDlr?=
 =?utf-8?B?UGhyYzBUSVlYTlhoQ3lrakVjOU5uSVJIUEhSUDFTTkRST3JEWUNMNExtTDRu?=
 =?utf-8?B?NXBBdXBxQWM3bk9ING9mWVowVllZUTNlWjFvVFRmdW8zMUg4QVNWdTIyZ1Bq?=
 =?utf-8?B?a0xSdXJLVXpUWHNpWGNkZnRmUzQzUmptb2JIWVFMTnlTTncvVUR1Ri9UTDlK?=
 =?utf-8?B?cWJ3ZHoxN2pNY0Y5OFN0cEtxL1llaTZkZ3ZPSHg4bE9uMy9pK3Y4VzEzaU13?=
 =?utf-8?B?V2FCYzJka1htd0drR29QT1hTcjRGekI5UW5JcnBaYloyenI5TGNIUzl3dzRk?=
 =?utf-8?B?VXhjU3A2SlBHcDNGWHo3QktvcG9WU0cxTEtJV0piUGdna21EZ1Y4a2hzdXNM?=
 =?utf-8?B?RXUyNyt6SHlnbnA5eFZHQnlUL2VFVXlneVFvUm9SblFibEtLdFpieWJ6TXVJ?=
 =?utf-8?B?MnZzeXpvVkNoOVA2RUNiQ0lBSThLUGVqNHhsN004ZzdBeHpVcDJxZWdjS0Fi?=
 =?utf-8?B?Q012REJnSERyRHpOYW1RcXBUY1l6MnZqQjd4UFRKVmxvQ1lSR3hSdlFVNmRC?=
 =?utf-8?B?d3pHWUJHZXN4WXZoRTZDM0lyQ0crUGIwd3RYWHVwRlozekxYeXNvemNkZjZC?=
 =?utf-8?B?N3ltMkdNRnppWDNKYTMrMW1IOW9mZGZWREpGTWxUNEZMSTNYcmhybHV3TzAy?=
 =?utf-8?B?Q3paZDZrU3owVUVOaXBrT1B3TXlNbHVCUGtYRXZ6S2swSnBHUWFMWldoSkt3?=
 =?utf-8?B?Ulc2c0dSMWtDV1oyZXNJWmVGN1hLbzN6N0p5blVxSnQxc0ZETzgraWZOYTUz?=
 =?utf-8?B?ZmJxbWdFQ09CdDhTY2xWb0RCb3hKcG5oM3cwZ0JsM0xUMmxUSThXa0ZDZmk3?=
 =?utf-8?B?VXJYZTFMRWdjdHZPSWFORlpialNqNFNKemtjckdraHYva1NsUnB2a09wUjhx?=
 =?utf-8?B?cmgyVVNnekZmcmJUUklkYzhVeU0rbHpWeHZZQjVydC96cEdDcWkvdEhWc25N?=
 =?utf-8?B?c3N2S2Q2cWlGMU5ValNSWWFWYVRNdUQ5TFYyZy9pREhCeHBlTlYzcnQrNDBx?=
 =?utf-8?B?a3BPKzhPK2RYYWEvQ29kbGhiZDRsNzIvcEh5MndDdkVXckE3SkpJUG5yaVhj?=
 =?utf-8?B?cU5DcEZqT09PMDlXeUwvVllJQlhiNGtlK082ZHJxQ3hoN0czR1hPWER4Zi9M?=
 =?utf-8?B?emttb1F6ZzFoakxMLy9LMmdJcElYN0Nka1pDbWFGK2cxVkZuOU85cDk0MkxX?=
 =?utf-8?B?OVRlTkxvbXZxblJvbzJWWS9DQ3poRVFuNWNRc0NLRUIwT0RFd0RVMkFrZlJ5?=
 =?utf-8?B?VHVYNGJYMTk1UXJiaXExTUJ6SXU3L044V3U5bHl3Snp1MEQxeVBieWsvM3VF?=
 =?utf-8?B?OHFYOVFVZFlTYUp4Q2g0WEhhQ2FVUFdXcFhPdTNNR0JVaExxRWdrdFRQU1JY?=
 =?utf-8?B?ZnJZRVB4MEgzR0ZHMUg2SWZVaDR6Vys5RlcwVEF3Ym9McW5neWFjN293THhX?=
 =?utf-8?B?S1hKOERrakdTRmc5YmJVZE9GYTQ1S0NpYWt0OEFpcmU2YVBnQmlVbnNCWllr?=
 =?utf-8?B?czRkRWJuTlh1aWdjN3Z0Q0JTWE9DVGhGRloxYkdwbnQ0cCtUNzFpYldJendL?=
 =?utf-8?B?QmpwMEVBUm9Lb1dNN3dXNVlFUVQ5TVFCZFZFSFdFQjV1a3pPQmRzWFZuZVZJ?=
 =?utf-8?B?WTJsZzRFVGc3a1dsaHBob213VDBqVFdJa2I4WlNOd1JZLzh3RDNTdXVIbjIr?=
 =?utf-8?B?ZXBZSUxPOFJWTTRTbXBXYk1ld0xyNFVEemZmb250MlQyZkp0cFljbVdPMHp1?=
 =?utf-8?B?cTBxN1BuOG9rYlhaYVpIWnlJYzJieWd4ajY2T2l1U09LMnd1ZFBHbFA0eGRt?=
 =?utf-8?B?ZjVocUl4Q0Jnd0Y5cUd4MElidlhidVdXS3p3dUdjV3pxc1RjMVFtMFpZMU9Z?=
 =?utf-8?B?SkJYTkF0WW8rV01JSWcyV1lURHB6bUpTaEd5ODBoUytZM1FhYUpUbEZYOVhr?=
 =?utf-8?B?bjBXT1U5T3Y2bFZmME5tdEpqR1ZIYXIzZUYrRXNWeG1wUFRjNDNQUUczY1RU?=
 =?utf-8?B?NDJXMFZTRFU1b3pvVVdUYjJEQ2FBVEZCNUZ6UTI0ZnpTbzBYVjBiR0FuUlM5?=
 =?utf-8?Q?EeKQ7J+dFXZiAgvhGcC9XBeS1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G9DzktQXGEHVwfgMaNok474om9QucE1L9WnTBG80ZNygbm3fM4ztILhVXLgM7QwFOczMthI4MCD+sVOMlfSuo8yfxTSQvBSDU0gMLHT10yscqLgByz8y7Bo6InJ8is5QEeRjIqzlSYfdSA3Tr7kPq6JnMfQ2iAqNxR1pd745ev7wI/xOHN6Hk6km+0Cns0cueoRYa7Nt6r8c2dEmVB+yjT5/CHbplWXahhFTCyjeaBCtdKdWO1n0n+A171Zn3xzrCcdYGJCR1SN3HLFipsHcUD5ge/TKqXc+MP1WVqH4GkroDFwgatxXPWugZHrFWyWBwd/kDURvgGMvoIxXAzxDpOOUwE3dhlQgWk0pMA1zjpMzceroHHR0IfbA0U9UFF65+YkbPc/fD+0JNGfQU9Ds+faqfg6ZJVjJcnaaJbAX4zd/LjwGjQLnAkv7GCjLrA4fUZlSt0LEQQqCBpsyQhjhRuGSsVTq7Ysqlbad+9vsjVxIPeewvgtN4XBBwH/zk9/o+cVKaBFXn3/SHaXz7PptA5b1S4hg9M8lHntTZyoehHdXBj4fmGg8LEQS0PZ0N5Gt2PvUHH5BFIcL3DqcgjkRiDZXQD/QYjntN6caEnKQSbM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58992c4d-7f0a-429e-d241-08dd9815a898
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 03:14:55.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVVPt7oaCcJC8JJqP7ExLB7DzNwTZZ7b2kf1uP+kveY/DAyUgur+3ciWFZRmW+VJ1TKyJ7Q7EuKzsh0D+BLyhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505210029
X-Authority-Analysis: v=2.4 cv=A/tsP7WG c=1 sm=1 tr=0 ts=682d4533 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=0F0CHYbJwk1biDvzvJ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13188
X-Proofpoint-GUID: qiwQpmGWHpGzjq-YzU5mgYCkyxhOauFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAyOSBTYWx0ZWRfXxBIuba16OZLK PSZe9nNB8srDbra5PVuVwa1swCyM+3PHJlf8UFeeAI8+JxrXkZI9u9ASPhY6WWOQ/riIutfGG2q ZroMFMfdz34TBcjPViR7fGd+o0dDG2AGd/ovp6G+QWLZXE5NmH8izil/g8BLETkfL0I5LZdmyxA
 JeycqxVmT2sfKQKNq5mlQnTSgItq6xTOlaIbYB0OVMcZa8GbORhphu1R0I7Lx6/UBfG9WssygxZ zojEcRHGSkxV1KptjCkWYfwOpP53tYYay+Jr7XNb7opZhB1aG6xnzK5yRwHmRvMxC7IT6yjQxG2 MhI84JzpbH8+u69F7+DnEmN5AnovIWsNZIDrkKKZdsDJGYNNXTDNJmGhN1WoWZqjIcjbtZYygN3
 dcVGVtkU097hY7uQrtttwQ1Q34ksfT17pUl6cAvw7Dfb2DENg132VOWDZ8AsJUlcjFBHNZv/
X-Proofpoint-ORIG-GUID: qiwQpmGWHpGzjq-YzU5mgYCkyxhOauFx



On 21/5/25 06:25, Qu Wenruo wrote:
> 
> 
> 在 2025/5/20 20:53, Anand Jain 写道:
>> Commit 2e8b6bc0ab41 ("btrfs: avoid unnecessary device path update for the
>> same device") addresses the bug in its commit log shown below:
>>
>>    BTRFS info: devid 1 device path /dev/mapper/cr_root changed to / 
>> dev/dm-0 scanned by (udev-worker) (14476)
>>    BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/mapper/ 
>> cr_root scanned by (udev-worker) (14476)
>>    BTRFS info: devid 1 device path /dev/mapper/cr_root changed to / 
>> proc/self/fd/3 scanned by (true) (14475)
>>
>> Here, the device path keeps changing — from `/dev/mapper/cr_root` to
>> `/dev/dm-0`, back to `/dev/mapper/cr_root`, and finally to `/proc/ 
>> self/fd/3`.
>>
>> While the patch prevents these unnecessary device path changes, it also
>> blocks the mount thread from passing the correct device path. Normally,
>> when you pass a DM device to `mount`, it resolves to the mapper path
>> before being sent to the kernel.
>>
>>    For example:
>>      mount --verbose -o device=/dev/dm-1 /dev/dm-0 /mnt/scratch
>>      mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.
> 
> So what is the problem here?
> 
> No matter if it's dm-1/dm-0, or mapper path, btrfs shouldn't need to 
> bother.
> 
> I guess you're again trying to address the libblkid bug in kernel.
> 
>>
>> Although the patch in the mailing list (`btrfs-progs: mkfs: use
>> path_canonicalize for input device`) fixes the specific mkfs trigger,
>> we still need a kernel-side fix. As BTRFS_IOC_SCAN_DEV is an KAPI
>> other unknown tools using it may still update the device path. So the
>> mount-supplied path should be allowed to update the internal path,
>> when appropriate.
> This doesn't look good to me.
> 
> The path resolve is util-linux specific, and remember there are other 
> projects implementing "mount", like busybox.
> Are you going to check every "mount" implementation and handle their 
> quirks?
> 
>  From the past path canonicalization we learnt you will never win a 
> mouse cat game.
> 
> 
> Again, if it's a bug in libblk, try to fix it.
> 

ext4 and xfs don’t hit this because they use the mount thread’s device
path—we don’t.

Sure, libblkid could be smarter understanding that /dev/dm-0 vs /dev/
mapper/test-scratch1 are same, but that’s separate.
Between mount and unmount, we should just stick to the path from mount
so everything stays in sync. As these tools including mount use
libblkid.

Or please look at this like this-

The Btrfs kernel needs a device path to display, which comes from
either:

Threads BTRFS_IOC_SCAN_DEV (only Btrfs specific),
   or
Threads going through open_ctree() (usually mount-related, system
specific)

This patch makes sure the path from the mount thread (open_ctree()),
are  preserved because that's system wide common to ext4 and xfs,
BTRFS_IOC_SCAN_DEV is specific to btrfs.

Why now?

Commit 2e8b6bc0ab41 blocked the mount thread from updating the device
path, which it used to do. That’s now leading to incorrect paths being
shown—often from BTRFS_IOC_SCAN_DEV (mkfs)

What was that commit fixing?

It was suppressing noisy path flips caused by Btrfs’s udev rule on a 
mounted btrfs filesystem.

ENV{DM_NAME}=="?*", RUN{builtin}+="btrfs ready /dev/mapper/$env{DM_NAME}"

That rule switches paths like this:

/dev/mapper/test-scratch1 → /dev/dm-4 → /dev/mapper/test-scratch1

With this patch we will still block such flips.

So this patch restores expected behavior by preferring the mount
thread’s device path.

In fact:

Fixes:
2e8b6bc0ab41 ("btrfs: avoid unnecessary device path update for the same 
device")

Thanks, Anand


> Thanks,
> Qu
> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 89835071cfea..37f7e0367977 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -778,7 +778,7 @@ static bool is_same_device(struct btrfs_device 
>> *device, const char *new_path)
>>    */
>>   static noinline struct btrfs_device *device_list_add(const char *path,
>>                  struct btrfs_super_block *disk_super,
>> -               bool *new_device_added)
>> +               bool *new_device_added, bool mounting)
>>   {
>>       struct btrfs_device *device;
>>       struct btrfs_fs_devices *fs_devices = NULL;
>> @@ -889,7 +889,7 @@ static noinline struct btrfs_device 
>> *device_list_add(const char *path,
>>                   MAJOR(path_devt), MINOR(path_devt),
>>                   current->comm, task_pid_nr(current));
>> -    } else if (!device->name || !is_same_device(device, path)) {
>> +    } else if (!device->name || mounting || !is_same_device(device, 
>> path)) {
>>           /*
>>            * When FS is already mounted.
>>            * 1. If you are here and if the device->name is NULL that
>> @@ -1482,7 +1482,8 @@ struct btrfs_device *btrfs_scan_one_device(const 
>> char *path, blk_mode_t flags,
>>           goto free_disk_super;
>>       }
>> -    device = device_list_add(path, disk_super, &new_device_added);
>> +    device = device_list_add(path, disk_super, &new_device_added,
>> +                 mount_arg_dev);
>>       if (!IS_ERR(device) && new_device_added)
>>           btrfs_free_stale_devices(device->devt, device);
> 


