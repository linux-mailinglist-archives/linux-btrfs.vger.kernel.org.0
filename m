Return-Path: <linux-btrfs+bounces-15976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131C7B1FE62
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 06:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C309B3B9525
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 04:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08B24DCE9;
	Mon, 11 Aug 2025 04:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YpDiEy2+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="URGlKEMB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F152782866
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754887303; cv=fail; b=n613v0dzpQQP/2C5QRZ3uN689mLRMmzok2Be8RHOKIXdsvpPldZBDkj0Lsxh9o3QTU1qcUzAeiikqphbU9LUuo1dBjqtD0vz5rSgAjLHVspMUPB3WiDxHG+EGH2/IwCJOQ7i8InDlJDjVI6iM8v0+7ekNd7ro7mDZOY4WHTECUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754887303; c=relaxed/simple;
	bh=UQqhvaQhbURfDyNORxxX1mCsfqJwQWnTsnbShKvO2M0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k/6/FKT9vG9nxD5qGmpfc8EoT13cyLrYmHRYkqc3NkWY2WD1YkKZ4RqEhwQd/cmKUf0PgI3BIAQa4z1zKhiWHA//moLUkzn+RW4VI7QTE5tymH5ctuCQ/B7aBJ5elbTRz7/bKwhoG5s/jHEtiyE1rcRCdL1iHZ/C+LVjg+Z5jm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YpDiEy2+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=URGlKEMB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B3NxQa000864;
	Mon, 11 Aug 2025 04:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jozZNy2JK/MrlfnDJQ5z55uJ3+y5hZQoHIYYq6whLwA=; b=
	YpDiEy2+3OcoS24gDu3udo8kg7wjvqXUf1o0YSmZBufmYITsQy2bbTULv0djgMGO
	ElaKMsfW0WmP/mek1XmlCbZpoquz4NITfz0MLkLXU8VB1f/c+CnpyczsejGWo98a
	2lAzjRV+gyu3n80GOFYKocCxK3R6Ebmvr4WMNIw+No4ScdpSyr40GkX42J9oMY4I
	GyRypPKCLH2BbaiEbkXRYKhhHADv5aupRDJEKrrPp7NGxq3H0M6h6++s8IBzbz7w
	A/2CLSyn9qjgxXlKiDGSe8sMU0FmYmoIqhuDzydHiDIDcQLykaXuPOlGdIV/CWEQ
	C4LSahlKoyjE6TcyA3bX5w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf1nvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 04:41:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B24sVI017505;
	Mon, 11 Aug 2025 04:41:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs85brc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 04:41:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hl7o/PVV6354oVgjJcfG3RIHGN1jdD/Z0Wxrx2e6f5NnEHAYgak+Ea6OyMmD9Fd61h3xAmyuP+SadXMPxhm4rpYm7DJY1jiNKQ3ZWj2iFR+THMu2WH/g8BJWkKabAbR6Yc3tVzhpznXTloafoynz3O7hLesyFj52UFcfpSj81hnQ5rL6O5M5SSulsRtNK/1IUS3ZqF9LG/vsDXQOalItp07ez8MQz5mGJkp19lbqmS1u18/7S6j55miEsU+TBi6vfBKTxHOGV8WiEAaqEeEPAf1q+c3W6//cP1QpnxFbOVUdPLvbcmJ4v8JcDqxeyHgC4+0neZSKywjXYHRkbT6yKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jozZNy2JK/MrlfnDJQ5z55uJ3+y5hZQoHIYYq6whLwA=;
 b=X6dQerf5bSLt8MQi3Bh6BiL0ldwhxQuLsk6cVqtSO2fJIgViwWB+ylPZnoeh4vkAofIRZyoG4yr6tIcNEHM2codlOeTJChfDD7qyWiYM/nr5rKwBTng/zVZvL0yjkHwqvwNfQl9/ACZTLbUZpShnGSkZFnyWFkCSjFtYX3gbvg3+UeRW8eUuiVX8/ThyDd1Yl07N1AZlypu7vQLQvAFRnC1+A8u+qtablalN/zy8DdBz+HR7vztUuyK518+ieD9nXkdZtEx9p1DquTndxGZTeWw987beMI3aP+agSuP6l/9kODtSB/SgwEjAQYxJEAEQpPVy3pa+S5jOoek5B7aueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jozZNy2JK/MrlfnDJQ5z55uJ3+y5hZQoHIYYq6whLwA=;
 b=URGlKEMBtrJrdmTdYxRmQ97Dk6KI7LcuO1cP3IC0Rn01wwXBE9422PfHMGIOkfbODS8dflqeX34dUXViChl7QaMJ3TIrMJ8E62SuTBNoZ0+fIBO7CVIilCowoRYszpMIAC6MxFuKlYX9IWj3nc9craJh1f+jtuMMTD0GSnGl/Kk=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DM6PR10MB4297.namprd10.prod.outlook.com (2603:10b6:5:210::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 04:41:36 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 04:41:36 +0000
Message-ID: <4c5e0d4d-e618-47bc-87b3-b485f54a9b0d@oracle.com>
Date: Mon, 11 Aug 2025 10:11:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: simplify support block size check
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <e21172a455354a71172de72b9af4d844fc6ea9d4.1754714176.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e21172a455354a71172de72b9af4d844fc6ea9d4.1754714176.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::18) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DM6PR10MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e04da41-3774-4ea2-aa2b-08ddd8915a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alZOTkdFL1lIUTAwOEJ0T0Jzbmk5UTNXb0xZdU9uQmVBejBFVUUrTFRrOWZq?=
 =?utf-8?B?UFYzbGR5cGJwcmhtd2JheUgwTUwxOUNDcUJpVjV0RWdmYjJoQ0FNaXdJK3R2?=
 =?utf-8?B?RVBqUzBOWi9jRVZuVkw0cDVWazVzYVZ1TUIvME9xSFl1ZE1jK1JtUTRhTGdN?=
 =?utf-8?B?cmtRLzVGcDNyUGFXUmVqQTM0anowcS80b0Z1bUZVWW54WFBaYWsyZnRpa0VD?=
 =?utf-8?B?a3FUWXR0MWliMC9HenpxOTJiSVlPQm8yTjNsUlRqTWlRUVFPMEpmR214OXli?=
 =?utf-8?B?Z2U3UEtZcG5tTGFwUlNoZlRiUDFRQmNWd0FmY3AwRDZNY1lDVy9LaE5oUE94?=
 =?utf-8?B?elljSCtXa0FZWnFNTWlTSWZ3OWhEVkd0bUFQRUNBRDBodUZ4WVcwV00vTVZm?=
 =?utf-8?B?QitWOG1tSkdkcjhQQytOdkpzYTFPUG5LbHpYVGlpTFJsS3NGSUJkUFJGbHpP?=
 =?utf-8?B?Z3BSbjRka2N4V2s3d2JrdVpXaE56OTBJdHArSlo2dUVBRTVuVy9rdXJPejZq?=
 =?utf-8?B?UmhmOVZIUTZQbEFCZW4rdWw2YVova3lhSXZSTkE4V3FYa3FVM0Y2TkFVcldk?=
 =?utf-8?B?bGdwQTNXRXlKbm4xdlJudVNVZTFJNGJ3cHg4TXRkWkE1WS9vbEc4b2hPUU5n?=
 =?utf-8?B?V2xwT29YYWkyZXAwWnN0eENFSEE1eWlTTnpsL21pbHZYNWdackhuWDNxZG1h?=
 =?utf-8?B?RktqYm5nSEpNa0lQK2RQMGMzOW1wYk01V2hhMmJZTzd6bG1yUENOcXZ4N0Qr?=
 =?utf-8?B?OGw1LzZDQXFxM1hCNGx6cVJjejJ3UDM0ZHhSdENKSjNaYU5JRFhkMjN0d0ls?=
 =?utf-8?B?WnhGYWhNWGZaWC9BejhDM0QrQXd4cjZoNUFUUzlnUnhnb1J1VDlRUXpFYmc3?=
 =?utf-8?B?ODJhVW1heW9HWktldWRaVFpQWGxTK1JtL1hXRk1leEs3VE5PRitJcEtKU3Bm?=
 =?utf-8?B?U2Nzd0RsVExRNWE1NU1zUE9UUmhKZzRVRkFxUlBDYytVRDhralJqSGcxSGRn?=
 =?utf-8?B?TXFTZU05T1BQcDhoTE5lQkxJRnl0dGYvWWs1QVNabzZzeGY5VHdEVUpiMEo3?=
 =?utf-8?B?RmVSZXhXejZxcUZRcWlIb3dsR3Z1OWNUWVMvaEd5cFJ6OTdDMUU5c0dGaWww?=
 =?utf-8?B?d0kvNnRLdy9sZGgyb0Jxb3V6eDFBa24zZnV1cmNmb0lpOThxdHRTekkzOWdD?=
 =?utf-8?B?dWNrdnpWcHlHQm5yamVsOVUySEFNV2NnSGZRRTlTbTZNYnRneEVQK2JPMFhH?=
 =?utf-8?B?MUE2SWZHZExKVmZOSDhxSHJqTTN0MnM0NGdoWXZiRzhveFI3Q1hJVXhCSUNZ?=
 =?utf-8?B?Tlh1ald4MGoxR01nLzJHTGxCVWRjWmZhTUlOdzd6dE44dTFVMlU1RWFNQWxP?=
 =?utf-8?B?OHp3TnJaUGRyZ2hKYnRWM0tYY2tlb0ZiWFBXQ3ZpWjBLYVBxWFc5ZVF6VUsz?=
 =?utf-8?B?SmxUeGJ2WWc4Z1FNRXRkM2JmUnBoSXJHTVV4ZFpieng3bi9SSFR1aENwY1Bs?=
 =?utf-8?B?NTFPU3lWZDFOWGdtQXpmSjRxMkJSMnN3SkFkWVZlSk1pVTFLU1I5RUdlSGtJ?=
 =?utf-8?B?OUU4REhYSFJkY3Q3NE82Qmo0akI5OG4xa01PUkxUejdXb1Z1UUNQSHEranNY?=
 =?utf-8?B?YXhzL1ZMd2NMTENhNGt3T1dOT01TMzMxdlFIQnhsQVBmckNzTzdIVFJkT3Rx?=
 =?utf-8?B?R1hTVGxhMWNvM2o5a3pMS3BmUlFTRUwxamhNYm5SR2xCVE9YeFJGNlhPVUo4?=
 =?utf-8?B?TWw4OWc1VEhCQlVwVVN6RTBqbmFxQnhHQkxlSHo3bEJ5RmU4SGhtdURQdzc1?=
 =?utf-8?B?Y1NTRWl5MW9uakRPMVlYQ3hUeUNnQkh0RXUvb2s0VHFMVWZDVXd3a0VzMnlR?=
 =?utf-8?B?WnBFNklZSC9ITTR3M3o2Tkx5M0JVL3V0ODU2Z1o1QlRjUlZCdHNjQ0gxeVNR?=
 =?utf-8?Q?+pm7La+3Sq8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck1DcDdicjhhazVQanNTeVoyM3Z0YkZ1S3BmVEZoQzhKZUlPQ0dEazlFbE9k?=
 =?utf-8?B?ekF4SFVjZmgzNXFqMVpCendqZDRmNkVBMHJiellvd3FJclM5VUFkVk52ZHJT?=
 =?utf-8?B?NlB0NmUydi9mMCszM2luNm1OQ0xLSEgwK3B4ckoxakRhOTdyeDdoc2Jjcllq?=
 =?utf-8?B?SzZwK3BzWTJXWlFSUStFSzRtelgyVitQY3puNUY3c0ZWSlNGejFIYzF5YVFR?=
 =?utf-8?B?UnkyR2VIY1UybmxkYjBieWNhWG5iS2pIT29YZVJhN3NxUE5xNFh3aVc3VGVK?=
 =?utf-8?B?eGY3TUlVUGI5YXhCOWoySk1OZWYwcnNqcjhiK0FFUzk3K094djJDa1pZZDlF?=
 =?utf-8?B?MGFQbngrQmpFQ2IxVDMxYTRpbGw2eVp3Y2xkVmZVUi9DS1NlaXlZMjNmb2ll?=
 =?utf-8?B?QnlXblFqUnBrRXBTMXdlMVByYTdscWtWek9US1pRRmxJZnR1aTYyMlA0c1BY?=
 =?utf-8?B?aW5uUjVyaWhDeEluYk1BZmVoQ3lMay9ubEFhOXlMcGRxQU01UzB3NXIwQzgz?=
 =?utf-8?B?cTJGM2JxRDBWWWNJNDVpSGtUYzNuMW9HMG4yTkl6RnZUT2o1b1NkK29LeUs4?=
 =?utf-8?B?MWpvVzltdjIwNGRVUjZONUFSa0FDRmJlMUE0QythNmkzaW5zcnFPN3ZMeCtB?=
 =?utf-8?B?ZVhIOVZycFNJcG1yaTJkcThkQWs1aExoNG5kL2VsZmFlSEFmSW9KbGhCUHox?=
 =?utf-8?B?V0hpbXM5bzhHMlFEYVhlbVdpdjZYUnlxb2NqeHFUeG9IbVBKaTRiQTFrOG13?=
 =?utf-8?B?Vk81MDgxVWpGWUttRk5WQTlTV1V2RU5YamNiWjMzY0ZvVkIzWHBNTW15M0lo?=
 =?utf-8?B?aUpkbm16eWMxYys5Y2tGTkxtNW5SMlluK2dkVGlEdTlUL3JialFqaXpMZUZj?=
 =?utf-8?B?R1ArQ01WZkFhWmhkQXJiOVBFTE1mTUFEWHQ3TU1WOEFoNFErcU5ac0I3UWlw?=
 =?utf-8?B?cVFBakFJT2dESWpzbWRNT2hKQXBiaDBmdkFnWi9VYU9ZcnUyWXRFQmt4Njc2?=
 =?utf-8?B?YmFCU2hQdXp2U2VKWWt6bWxGL2RIVFByYmpxdmVyWnUrdlRRV0pmVm5SelBO?=
 =?utf-8?B?UUI5RDFHV3dRaGNuZGlvdDgzd0FxQzlmcTduV2ZVMlpobFpHQlN2b1B6b2JG?=
 =?utf-8?B?ZVJjcU1GZ1pyMk5jc1NyQjN4dUFZbU1YV212UjNWTVZ3Y0tDZ1RWbnl5d1N5?=
 =?utf-8?B?RHRKc2ZaTVk0ajZ0OGJza3YxSFZvdFdtVkdqYk5wVjZTdHlOaC9WQkJHVXl1?=
 =?utf-8?B?dnNYMmJIdzRDWjQ2RnZVSG9RVlpuNy93Q1JjcW50emVMMTM0Nm1QeSt0b2ZV?=
 =?utf-8?B?OVZKYXRobzBPR0h6dGVZUzBwRHdBdzJiN29Nd09SWjJ6K1Y3N3ZBcW9ZZTQ3?=
 =?utf-8?B?Qm5ZSkI3NU5uMEh5ZHFseVAyVjlaZmY5Z3M1ZDI0RTU4RGJ0K1FrNXRFNlpG?=
 =?utf-8?B?SFR5cEFCQ3FyK2w1d2xXVVFtSStmZW1uTEdkQUx3b3QvY1M4emlmVU9nOExz?=
 =?utf-8?B?bDVjclloQU1YZllSU1ZMeW5DMWdZdkdCZjZZTTUrSCtlTWJHVkIwUEVDaDNW?=
 =?utf-8?B?OW15QXdhb0ZsWEIrV1F2WjBWUkY2M1dla3RrZ2RGRW54UDFnL0lQc1lhcnNn?=
 =?utf-8?B?Vnl4cWh0MUZJYmZLcVBSditibWJ1eHdwTC9vV2ZmMytYSVlRS0xEbHdFcEI5?=
 =?utf-8?B?TkF0dkFXVjJhQldOOEc5dGVLWmtjQjdWV3lqdmZwUWdYdVdPd2c3NjhuZXJp?=
 =?utf-8?B?by9NTGM4bjF2WjZvdXBDSzBZb1Y1Z1JMUkJiOG54RW9tUjhIQnBGZi8zcG1u?=
 =?utf-8?B?SHlVcWpXTkNPQ3llUlJ1N3h3R24xamRqRVFxSEdvdEErTFZxQXNBU1ZXeFdq?=
 =?utf-8?B?cmlJb08xOUFvR1pCRitlWFNNd3ZyMFp2ZEV4em51cENkS1c4REFjQVlaTGpo?=
 =?utf-8?B?Y3ZKeGNtbFhYSzVnMnZhYjBGYW1ZUzR3bUgyaDhVc2FSMm5KODdwaXlReS9C?=
 =?utf-8?B?NEdOY3ZSaVMveHI0UTZnU2RQRnllbWZ2d1FOTUlEc0dDQmhoS1hWV21DbEJq?=
 =?utf-8?B?a1BMTzRQekxjWG9RU0JvN3pPU01NR1pZNmdFQlZtVzJwREthRUxlVWtvVWtx?=
 =?utf-8?B?TXFoelJSUzZUZGlROW5LUUpINTBSQTJzMlNJZWo2QUVrLzZCckptaUFjZnp2?=
 =?utf-8?B?MDVCME9QUXRMVHlacS9QRHJkM2x6MTBYRlFRZURtTVdUZGRzZHhEVS96ZnZL?=
 =?utf-8?B?WWpQK1lDSnExRWhmQTFuMUI2blFRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ddL5G7C3mpvQWgSWV5jXkdrnBCs2KuSYmjhmB7iCmKORuL6tlln9HH7IWe8cjXbBoQlrAGZjqhqINKDvXJnhhDC2NjC2CkIngJ71DShcnjvg5koC/rwFtSwP711wfacdFwwh4D61u2ivQLKBEwJyfeJreenXNz3PySMpBhxeYTqHo4EZkKOFqidmHsuWcYarT6jMhXDDHWVOkmO53Z+Ba3MRhrLPyg6K2cpifuGcshnDkTKsKrfx9O2sU4CuVfYoKtnlrtO+Z0GkpWOe3kmtRwTZLSxsvH2+2z6Qu8ECBR9O482s6qhcjZEemMZG9XNRFLp9/OHA0LZvA4/vTvu3hf2wfHoUeME/tgrsFPbA0uYRu/UYbi3FNQKrxwfd9m1i1+czDTDj85tShfSqe9k8JiqB2hrGJv1dW3OcaCnrH84i0H2jh3K/Auk+lcb4M4ryj4hFe1VinXSvRfK7CJDnfKA5mE1eLSdD//6wIoSw5UIygeRRgN+P+IWFBTd1yD0JnCIyc+wNYXA6bn3oealSoRvdM//3Y/6/yAYTM7xb1H4BRUuVVLZZLmtPqgTq5IdJrQp05q4SGR03p+5FzPXLDw3loU+8XP69bhhVvFO/vsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e04da41-3774-4ea2-aa2b-08ddd8915a84
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 04:41:36.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Allnw2RMh1J2mMjDEyh2B9T9bek3GL4JW7a4iJWLzA4f+Gae9HTO5UhdfxYI1D3uA3E3A0fpvAvhVzlHA8mXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110029
X-Proofpoint-GUID: tdxq8008Jz3x6feavWTA5fu5G25Muwq1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAyOSBTYWx0ZWRfX6keuqvQdiaNq
 WiAv+GRKmJCs06n5g7R963owVcZyT4Nmagd7zGRlORTMFdP8fXXA/N6mVYI+Xou7+8UbcJKGtsF
 zxLFB0pS6HJHYhtbi4Ta5DRFqCd6zcF7uBOlKhNVq1xX3w6VEX/C+OaRNqOW4agnECVytwvVFIX
 CtZ8N8hhckkJ/0ajgqEYhjNhoLNf8Ehplj8dNnlfFabzTHFCDYWTLDXvRVCVNVBuwGK4usN+Dkc
 5sEuv3grZVOj6RR4txnZO9fldRIfb95NKBkonZBeQalH2Qhhp4V7NtWVdvcpQRYuhuAoSFC3fo8
 cyMZePmQX5wa2IjYWeAXg6VJCexEwGfKGe3X8JMcf48ozpCP8LwRKzWemxexfS3sOEqn1d/Fw1W
 /4Hb5spFUcy1gzAdZAHIbu6Zcz/b6uqwzD6KEctlpv01eTFfK9KC7XmJ79JdgabN40/fFKIy
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=68997483 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
 a=zz8g5KkFEpHarG1r8gIA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: tdxq8008Jz3x6feavWTA5fu5G25Muwq1

On 9/8/25 10:10, Qu Wenruo wrote:
> Currently we manually check the block size against 3 different values:
> - 4K
> - PAGE_SIZE
> - MIN_BLOCKSIZE
> 
> Those 3 values can match or differ from each other.
> 
> This makes it pretty complex to output the supported block sizes.
> 
> Considering we're going to add block size > page size support soon, this
> can make the support block size sysfs attribute much harder to
> implement.
> 
> To make it easier, extract a helper, btrfs_supported_blocksize() to do a
> simple check for the block size.
> 
> Then utilize it in the two locations:
> 
> - btrfs_validate_super()
>    This is very straightforward
> 
> - supported_sectorsizes_show()
>    Iterate through all valid block sizes, and only output supported ones.
> 
>    This is to make future full range block sizes support much easier.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

> Changelog:
> v2:
> - Uninline btrfs_supported_blocksize() helper
> - Make supported_sectorsizes_show() to use a simpler handling
>    If there were output before, output a space.
>    So that the number outputting part is always the same.


Reviewed-by: Anand Jain <anand.jain@oracle.com>




