Return-Path: <linux-btrfs+bounces-15158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0A0AEF46A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 12:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34AA17994C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31482741DC;
	Tue,  1 Jul 2025 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qZwDXB/O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="udr3pOft"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A542737FE;
	Tue,  1 Jul 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364193; cv=fail; b=UNOpwelWwrmcyd1umpzb4NJCFvbI3PxChqdXsYd/vlSUxfpsrQSQrC/vfQsv4UZ8bav/An2YgsghOQLRxzTZnsYtVbrfmmZbbksszFTVNzrk2QfLkUcs7cLZZlWW4w2TUvbojN1xRMyMqueU/UXJ2/xd8NK+0/VjN6VjB9LOwQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364193; c=relaxed/simple;
	bh=evdVIOdiUZQxOGRMX0TBkqUh0DZjido8o6U2SczvzU0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ypp5niX2JeG4rQYgxm23T/FTO1u9Vq9evlzijr2n1JktcroQ6q6UmcZVfOrn3sLo4UnEYw/xiFAXih+xvapqJINV5U/39g65WIMhZlc1PZ7PEZN+6rKBVsTv4d9yrm8wKNz5way3c2JxXtcv3ZtBvfEoV6lQI5wkcQ2HpZEuXsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qZwDXB/O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=udr3pOft; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611N2tq024121;
	Tue, 1 Jul 2025 10:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z1396+vaLL1M4nC2QKZoXwESJdBHQmky8bcrSI6ROTU=; b=
	qZwDXB/O/KCY/A4T9/YXA++D+DCTX+NmbwBFac32n/JJCZB6ZUaY+XjfAFIi7nP3
	tFMlePJIquXT2rio7PFtusuY0JcISV4ouI1T9ZMvOeF1FfDx595ZZ3irEG4Ikgoa
	kPV9Tg2YC8A3IgfDCjcXhCpGu/ZOovCzZ4WezfFycNJRbEQYYGLO8Td1m7otecoP
	hmhtafXOJ7F8b7H6fqzodaD3jxDYYc0xOQ6TJaoh0Q4AbSL9/jZvjoLTIsAEnPWn
	NwreJkbgKwO7sw6ILddTYDiy+yg7yiqXT+FDEXZ0gou+wGp/4NQFVtIeQIWYaIhg
	wF+cvZpCnh+fM0U0D8Kn4Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef4f8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:03:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5619daqt011569;
	Tue, 1 Jul 2025 10:03:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u99uwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:03:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3qIVdPR+iPbU6KUj+yIgFg0agFWOVWI2lfZFwhbvD8o+uZKFbMUy1p80yXWr0e0jWMY8h48cZ1Xj/TScrII02SXNsYIFW/IVE15uq1pPVPm+iy96t1LBADNHzXrfK5VnKpaUxENpUe7pdCb2P4d3ygkopdLJKwRUlZUTOeC4aEiyyQstb17vWFoI7QbUD0pbR4WxnaABetdUS3+sn9jiG+b9jPK01USP0kMf0scjtmvIZtkJRXhU3pbac61QZPNk0C+DzzqD6pPgov9ZwoRZmR3ogcr0lnEbgt7raN8w6sp9s08vXqxRFI65YneJnclNSmKRmG+zhUXADBFEdvwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1396+vaLL1M4nC2QKZoXwESJdBHQmky8bcrSI6ROTU=;
 b=eqNu1B5s6XsCcZLZqefMk6RtjizY8IqmnaA3MFG2PTtpiQTRma0i7pPl6+D9mPUTRsZK44WCV2jeOGmLL19X1lbHCflMupi/qDlGqKYaoSeT5TgoqejtIGIU34+tydHEvs4PePKQFPVFqfBYkjDahuteU440yi/RIK02K0FUI67usVaWowozUW9ZZVGnitasAKEzRNlqdMvvvDtk6utOwSNj8BRRFtA1PifHfMzGREIQfFl3QALvkh77mHG/h4SOQQUqEKXHRQ5T5sJtVQz0qyQVwZCP76FhdQSPQ1rAgGQ+zHEC/uiOvu0Up03+X3Lo+T3gd529ymUc6FWy+TNlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1396+vaLL1M4nC2QKZoXwESJdBHQmky8bcrSI6ROTU=;
 b=udr3pOftQGnbCDL8sJtcewQUxyvFtsIP/Z/p3J3iaO2/Wb/aXpbgL8s/RTQqKJ10fHNmOL6MwHGeWH9F7ZlKcjsohyu4FChwhv2qi5OFXcskBNbrkiemsW+hzSWsA+sdozioq6NEQJTQ9uQQBtJajY/13LOU4x75TcXfCUKgL+8=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.32; Tue, 1 Jul 2025 10:03:03 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%4]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 10:03:03 +0000
Message-ID: <a3c1dcfe-14a7-4fec-aaa8-12c4bdeec27e@oracle.com>
Date: Tue, 1 Jul 2025 18:02:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fstests: cleanup duplicate initialization and avoid
 writing to .full
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
To: zlang@redhat.com
Cc: linux-btrfs@vger.kernel.org, djwong@kernel.org, fstests@vger.kernel.org
References: <cover.1748058175.git.anand.jain@oracle.com>
In-Reply-To: <cover.1748058175.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::14) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|CY5PR10MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0a97dc-1d09-4de7-a43f-08ddb8867792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXBSNXUvczRxSnd2ejBmN24rbEFsNVhaajk3UUh5cnBubjFlZFlFeHQ1QVJx?=
 =?utf-8?B?TmVOa3I4QzJ5V205aWlVbXdTVG9wNlg0ajJlYUtVc1MrTmIwTHVmOG43RlVK?=
 =?utf-8?B?YVhCZDFWeVo1UW42cWpWUWF1T2krTUV1Zmd4WkZabFRQSmxoaHZaRURGL3Rp?=
 =?utf-8?B?b2JOUjhHOGRqK2xTNW90S1NDRk9Qd3B2Q3pxb2t5Mi9NZTBSUlF1dytqK3c2?=
 =?utf-8?B?QUR0bVNCcGFQTC94UzJPRmVlUW5jTFJ0QkllZmdhMVM5UUF6anluQUNwTHpV?=
 =?utf-8?B?eCtXRFh0N003RUp6ZUxIT2NaWDFtQTR0QzdXOTlpWTJxWmJ2TndQRkFRa2R3?=
 =?utf-8?B?N0hKbTdpVGEyRG5uUGE2bTJDc3hxWk91c2lzY1hKYzhxRWhUS0hTakxFTkdN?=
 =?utf-8?B?UEFFbmVZNGs1S3UzeU1Ob0IxQkI4WDlMY21xYWdmSUpZNlZURG5UNUdHa1Av?=
 =?utf-8?B?OGpGb3NIZ2plc2c4RHBIWUVtU2V0WkZqbktmVElHc25xRlRxUzhlUVpMVjVP?=
 =?utf-8?B?b0ptZlZKTXZaMnBTekZ5ekNJK2srV3ltUi9IR2NmRDdHcGVKaUNQVjM1QWps?=
 =?utf-8?B?a3BGZk0wTHEreStJUHRGQy91T0x5NzZYTXRuOHMrYlMycXVrTXpIckdUaUZH?=
 =?utf-8?B?VFBjSFp2QXdhcjBwN28yRGVkRFVtVHpwSkpyZGVQZ1V5RHppUU5zSXY4V3Iy?=
 =?utf-8?B?RkNoQkRIWnlzakdjbUpTc2ZUSHZxVzg1Z050S0pYNWpxQjYvc1M5VllBa1Nm?=
 =?utf-8?B?bHBxci9udUVZSUJTR1dUNHFHUjdCWVkxYUo3T2MzTnZsY2FKUVR5NDRIQVNz?=
 =?utf-8?B?MjgxSVErcEZEemJZc2Qweml6WVhoeGJIT3A3MTVJRFBWWWhhOWIwSU1sVUxq?=
 =?utf-8?B?b1J4dGUrR1dlL3RQb3RxN2FXVUljN3dVMlg5N3pTV2wwM3VDRmdiakNrRmgv?=
 =?utf-8?B?UnY5MGRhNWY0bXU0dGRZajRabVpEMmY0WDhuSm9MUFhhNnp5eDBWZ1kwZ0I2?=
 =?utf-8?B?Vm5ZRXpGWllyOEtxdUJtL1RCMk9FUzFGTEVOMHNjdEMrcnZ5Vkp1a2lGMG5C?=
 =?utf-8?B?aTMyRTZkSjVKaXg1amRtL2UraWFMUTNNYnFPYWo2cU5sMGl0R2ZsZkFRQ2Ry?=
 =?utf-8?B?QmJaWjRMRzJsd1JxbFQ1ditsMnhXS2JnWXNIdkttSHpWTDZBYnVQS1pSa2tS?=
 =?utf-8?B?VnBYWElRZE5naWJMSXczZk5FVy93ZHZLeFJoVU1rcVpDdzdjZkE5U2JqSWMv?=
 =?utf-8?B?Mkc5SHVMdUx6QnFPclBmWXh2dHpWSy9aMW9yVDRGVHliTXZoa05WTFV3QXdq?=
 =?utf-8?B?MnF1WklhVFlEbFNZVGlmWjVXaWJLUlBTb1h6Qkl0TkVtdU5nbmdEV24zazJL?=
 =?utf-8?B?UjQvRHdnQTVMZzF0bldlellyQVZiVG93RGlHNUNVV0lUeDBEekJocCtxSVcz?=
 =?utf-8?B?N3l5MEVNRFZZWGRweFlycVg4ZUlRWUhYbmNNUzFGVTBhZkxTVGR5MFhSVVl0?=
 =?utf-8?B?bUhUY2I0ZStiVTRaQm1nM0huVnBHM2FBNytLa1RYcE5WKzVrVElYei84dVBp?=
 =?utf-8?B?MHpDMkg4MzFETmNPc296cTBTRm54U3N4bStDQ3FRRDZDNzRTZ2hsOVl3THhr?=
 =?utf-8?B?Vm9MblR4NnJ0dUN1V1hhUTFId2dyQjU2ZGpZYmFDWnlIbU5nSFIyenlMQ0xZ?=
 =?utf-8?B?czdLRzhNQko3Ujg5enVSckRYcFdZRUpncnEwWDJvREV3QjRaZTRySUxZdUsx?=
 =?utf-8?B?YWhscWVUM05Sd3FuTkN2Mk94TlBDaVphdk9MblRUVUVBNWpNOW5yU3UwNnJT?=
 =?utf-8?B?Q0p0SUNTaE1Rc1BPbkp0RmRhOVJFYUdhMC8wQW82M0Q3TTVtdjRUNFdocGc2?=
 =?utf-8?B?eXFuNU9naVV6dTNQdWRoMmJuakhyOG9ab1hiQUE3Q25YQXdXSXhjdjdlRWNP?=
 =?utf-8?Q?zJehITOfzo0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHZSQjltTHJ3dSt5Y3c4T3NaOUplZWlxeVNpVERnd3NGUGl6RndxdElNNDI1?=
 =?utf-8?B?NWlPeVd3cWxvcHFBaGdaakt6enRCUEhsblJxZTh1eVgyeEFRNkxPK1VuZFhG?=
 =?utf-8?B?TytIalkrclVtTTRJSk1JMkkrZTNnZC96SlNSRlZma1Jvb2c1VWNEa0pLUTZ2?=
 =?utf-8?B?TXVJNTJGOUx1TGpOS3dmWVBISEVwQk8zNXFTeFVpYWxxeFNuVXdUeUppTG4z?=
 =?utf-8?B?TnY5ekJJN1BOczVmZUdqR29MWk5DdlZGVVlmYmJOZm9DdmxwM0JMbmR0clB3?=
 =?utf-8?B?NjdVbnRWVVNjSGdackU0OFFQM0wzVlVVNFppYkE5ckxTWXhvbDJJcTVyUXls?=
 =?utf-8?B?OUhEcWxJeTVTTUI4MzYyeUFjd0xiellPeG5vRWZzcVJGZXFNNlhPZUdmWm5p?=
 =?utf-8?B?eTVJVnJJQnJuSXQ1UFBzK1ZUMmlnc1FoKzdWYTVnSU9xczA3UWVXdXR0YUVy?=
 =?utf-8?B?VDk1TDUwT0QvRUxlY3ZWZVhmN2lVRFR6bHJuaWZwNHFkdUpXbEUrVG0wUjFt?=
 =?utf-8?B?ZStwR1pVandybEFiQVlFMkh3WkhIZkNnUEQ1Yi9HUnZTOCtBWmw1NS9ySzZ3?=
 =?utf-8?B?NHJNeUNoa1o4WUNoSURSZXNMaW9odFhBYnN1M0o5SlV5aXFOSGY0K3N1aVkz?=
 =?utf-8?B?c3EwZ2FwVGtxdisvZDhGMy9nY2h0bWVIWlk4bVRUYk5JM0h3azVpQkExdXZq?=
 =?utf-8?B?SVVoVVVoOWZFNGxmalNtcWx1RHc1K2FPYkJmV0p5UWx5aHp4QTA1WitGTjM1?=
 =?utf-8?B?aTlkTm9lcm0wRnVGaEZRVWJ5dklwVmVUNythOTJpVEZmY1Z1SUo0YjIrNlRI?=
 =?utf-8?B?S25rWjJFcGoyUWR5T0JUSi9WMkVzZWZMOU9QaGk0WFNLSVhpOGQzUnVnLzJC?=
 =?utf-8?B?a3g4akgrTDBhSy9JbVlWU2pENHNFZEhsV1g4YWRuN2FkS285MFB3V3hKMnA4?=
 =?utf-8?B?dmVFWmJxaDVxdTBmRmQ3MzJKZGl2V1k2UUJpc1EzRlp3ZGI1eitLSXZnU3BK?=
 =?utf-8?B?T2NtOXB2bm1rYlFuZzJTdyt3WVltYngrenlNMWpQNjU2dkJQWHYwVThIRmJY?=
 =?utf-8?B?enNYVU43cGJKbXJ5ck9nM0h3ZGdPVXI3MDhvWnh2a0xqUWNZWW9wNVRpNzZI?=
 =?utf-8?B?V21MMFZRNk85TFNhQlVhcldvTG9raHI4aHcwWW94WjZ0N2p3L2UrU1h2T2hn?=
 =?utf-8?B?ZGFRNlJWak9TRGJvYnNjbzdjY3JsbURxWFVtL0gwMkNDM2VETzg2UERZYVdH?=
 =?utf-8?B?MGNWczljMmsrVWhSc2VXTGp1UVZsd0hVdWNFVkRzNjJianh2emlYMUhPSzh6?=
 =?utf-8?B?dkErSEo2bWZoZGRyMUN4aThKOG12bFk5WGw1Mys5MHMxQzErcFBWODJrS3lz?=
 =?utf-8?B?YmFiSmQvTC9YSVB2OFJ1Tk1RblhMRjNyK3A5QzQwaVRSNkdXLzdKamJLL2t0?=
 =?utf-8?B?aCtuakNXWTVsT3B6c05xMFlacE9PaUt6bll5SE0xTzN4RkNoZllyZVFMV2Vq?=
 =?utf-8?B?d2NONk9UKzRwUjIxVmRqRmFXdnZ6NzNqRlhKdDdTL1QxRnhLOXEwcTloZFlM?=
 =?utf-8?B?ZnoxVm5IczczenE4UDRIUWlmMHV3THJ4ZmNsRGJNVzk2UzJ1S25OQzlQYTll?=
 =?utf-8?B?YkluOVFVbTFKOTZIQ2VpeUJjanNOQkFycDUwRTBjUXZVcHcxSW9TbEpMallY?=
 =?utf-8?B?OU5sTTNudDQ4UXFUeFd0UlE0TjFnRmxPTWkwMitBY3pXaVgwTndBaVhVc1Vx?=
 =?utf-8?B?LzZaOTRISi82MEszUDM2UUJ2RURmd0Y5MFRzTDFaYyt3MFpoN0ttdERXSmh4?=
 =?utf-8?B?K01GV0pycVljWXZjWHVqbGJTVG56RXFDeCtjZi8zcTZJOWk2V01kVEFKWDAv?=
 =?utf-8?B?T05kRjN2dGQzanhydEZ6STNDWnM5a0ZhL0JlTGpRUUlGcmw3bENlbHh1aFdq?=
 =?utf-8?B?djJhTlF1clJTSmJtVC8zbXZaZ2RaSVEyYUtrYU1rRU5Bc2lRcVZKb3hObWgr?=
 =?utf-8?B?c0VZNmVFcUIybEkrb242N1VuT2ZqSzNnaVVQRUxCN2VGRmhYYUNmVTM4YTRV?=
 =?utf-8?B?cjZTdHFWSkRJNXEzYkthUlBFQk0zVUIzNTBVYjRIK1RWRHpJTm93bFNEcUc1?=
 =?utf-8?B?d2Q5Z1JDb2hhR3hzVzU5VDV2ajEzNHZ3TUJkYisvUzR1TUJRY3N5bkJ0U0Nt?=
 =?utf-8?Q?+HspbBVPrhljaVO5I5XqQ1UG5EtQR1ak3gGxjJ+xHKMI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p+dPw7MWIJvtIaFNAfdypxrZCA7OHAgd2wDlhuBTc+jDt9zsOWyuaM7yJ18kCofgnHOBhMZLw4pFTn6Ij91IRmFXcZ2Xk8maHiMmPee4WisLM/Q5Un48NYESpHc6QiyMJGdNEL4oAVNAm9ErlONXKl9ADCDYPsz6mCw6/33+rr4zL77OHMrEWWchQTlkaGUonTB2JV1xURnmwxxPDRPkKuc3nePbVJkPRE5HgnTj2LVh8Kv8nl2V3Ten5HZ7QEMb9xSyqDAZLyzGoZxJgegkOsv7SjE34Qw4alXnNaqAOjHAogXJjUq+9uieo6reQdH0L1Z0k67wua9xBO7LbhRs0G5GfkUomiWkbgIPAh6OM5eHgddrmfOYOg4oEYkNWLw0QMvHFi8FKt9wJkqpYWHG/wrdcBzgPEPQzyi7Cben3YixKuOZfqqHQjArDGAV2vWXyt9Oa/8WZWxyDOlThBGhmVxy+3uNfn8SfAP06GQexi6+4+qBzPFI2je5me3BDPRFtNBFXiPm7358pHJAG2odeISmWQ19A553PkBQ2cMgxuDLyQEHvBA5WpSdNcIf/YNNVf3N/h0dzXoCH1Z59ue/lDZKzJFpqYlSJOvvOW6iCAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0a97dc-1d09-4de7-a43f-08ddb8867792
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:03:03.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iot4OW/OIFbSYMl1pgnUwrHimIqFioSSIcemjpxRaC3RBBld15B7EyeAX1mD9R1V4cK8icMwZIsjMSuGN3vWqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010060
X-Proofpoint-GUID: hYVsP_be81qP4bNUknqwh4_TEELcsnrd
X-Proofpoint-ORIG-GUID: hYVsP_be81qP4bNUknqwh4_TEELcsnrd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2MCBTYWx0ZWRfX/AZJz817lJYC jt2Ug5xX05NYLeaRjIKo542M/pPi5Zs/GyD/I0otKlQ0ZMh9lRX/y951T6b+DtOToXZvWRbeA0s ILimbkpd0NLV7dlqPss7Ut8am5fCPJ26N8ilEVIcCLZMqU38MPbA+Eq2zlpVDQlsamfnTRVbhWx
 ZNEsfLgPRIcuUxb37kqz6+ONRMooWRk4UlUPbP6FbdE3REPeVvpPucTI8dIxt/AOi0fhyWoM1ER p0DoXEccylL6JIY3C3OQgBeahqvOKeY8rw05VnUch+SaNv2JPyMerCk6br2DkZgpdGpw5J8HIhL xPegK+MVylR4pcwbYeBwKCEXu+mbFzalU9wueUqpqt4LN5jjLlkP9472KOG9CLmEFmOcntig0VR
 o++JTtFJvDzn1IUB4VMns+w/XGBARdW/AdY5xbmnpRC5D22ZviN2Jl62pvihPkw0kHxs8CFp
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6863b25a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=9MXDbevcJy9EF0qALhwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10


Zorro, just a gentle ping on this patchset.

Thanks.

On 24/5/25 11:57, Anand Jain wrote:
> Patch 1/2 removes duplicate initialization and unnecessary comments from
> the test template.
> Patch 2/2, sent earlier [1], initializes seqres early to avoid writing to
> .full.
> 
> [1]
> https://patchwork.kernel.org/project/linux-btrfs/patch/12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com/
> 
> Anand Jain (2):
>    fstests: remove duplicate initialization in the testcase
>    fstests: check: fix unset seqres in run_section()
> 
>   check           |  2 +-
>   tests/btrfs/253 |  3 ---
>   tests/ext4/053  | 10 ----------
>   3 files changed, 1 insertion(+), 14 deletions(-)
> 


