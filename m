Return-Path: <linux-btrfs+bounces-9185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F59B1431
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2024 04:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567E62835C1
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2024 02:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8E7137932;
	Sat, 26 Oct 2024 02:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m6lXlrfE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qDGZ+Pnx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F05217F3E;
	Sat, 26 Oct 2024 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729910092; cv=fail; b=Xt5v8eF7iqL8H70u7r/6e2wJPby1xY7C+11iMfJcSbkRdMcV985LvjXXtaF4/P1jB9iLb/nsVNaokByenBfnSi9jsoTknDEN+5Bo5qNThldvMWKFW4nAsutn4XJiRGr32lpPYfoitKVKwoRNv0TnHxUWJroeeiu6qX3MGccDSbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729910092; c=relaxed/simple;
	bh=zxWIC+x8ZmC7VRxa77GAL5qMPYY7YcfZ4yssOZswbmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sq0GBxmmAHJGm9pVk2ir3Lak/8lOkH89FOc9ciYqQlK4iqLrcVueqPJ/zM6KKjt/+LsgTq2GyfBcQe/258MNGV4T9msVFtrv8wJ2iJeunDnR8Tzf0JpY1q3N0oCRd/93z7SWhIQVFWJc88sUNHdZAlQCUO8pE774C47WqO0w6ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m6lXlrfE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qDGZ+Pnx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q1vN8M013427;
	Sat, 26 Oct 2024 02:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zxWIC+x8ZmC7VRxa77GAL5qMPYY7YcfZ4yssOZswbmk=; b=
	m6lXlrfEzSY++oHO5Vs6GueCkG6VWCw41cB8tetheqIHuL3mBTlPz2eZPbu/AKAx
	bO4s/c6wAp64GIZ7fD3VDIelvoJSk2Fvs5QqYATCp6qHBIcw97WnEfld6B4oEcM9
	P/ndAAoiyWillnLoyS9qg9paP0a96Wkg7bpaYASfOOs/H5kaPdAgUE782x+Ym5/W
	zKvKGIRe/pNzIhSuAUpJWLfQ8KovyB0szfQXpcJSTDzjqXpPkzUDDjJp8EPX9qrj
	I0phxr8MBbj2B6zq2kzGCZAEFc216cHDb2qFDLP2bSTbW0GkS1O/e7vNYmgFDptp
	Yw2gxWuIwxbdQ6zCdhZgxw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42gq7200y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 02:34:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q1Xl1K011076;
	Sat, 26 Oct 2024 02:34:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42gpva8u5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 02:34:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRHQRF5X1f3TQ3t4dUuZyBaz51LLLjegyBxGYITlQtJ6v5GvA0MgcfSwRdTCuRkaK1GaEaIWhDkG2XndGddInF8fwI+y65OdEAwudeBl55l7i/KvVrxa2HiHvSk3K1vNu9lNsh9hH6DelIwhQQy1KjtdWhAbMKNLsGEFBr7rC59X3HKF2D2cxsVxsnYVAD1k+CmJ7DhG8DOvwS+k5tS0PFduO198t+Un+Mqi9t99im1sKek+O8OruiWoP3a3CB99N+IJ7+JEtTcM7Ecupid1KFPdI06t1PbjJISvT8lU0OEaT+qjTTR9QEwAuBrOOmBeKKqdqvDbmq5rZaqQT/+rUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxWIC+x8ZmC7VRxa77GAL5qMPYY7YcfZ4yssOZswbmk=;
 b=ca4z9rFTEPOVQtSBtGg937SzROduuF/tfNrJjKgxM39R+kwiX1nUpyCpiyfwXlYR/Prn5YWqoAhmYpqKyDmcByrBT35OIi5vMckCg6g/G2r5sshmFPxebRJt/Gdh679kuD2E0QqQYisB0+cwp2kTPs3Q7OK7jveijZTevGUkw7JI6emfmCcnVAYZ7OmVf3aAgcYNjMPZgA2vV4gURlkMTJW1ohJZ6QAAilT3v8/yvH2eyOpZc2FoVceJeym5DEALyy4EYoW1wVCqDZAGQI+0kwKmlZDzXW6i+9yPTu7dRtAY8RQ+r9iRqipNdEaXrq6XL/GWyza9Yrzw4/XJPpru8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxWIC+x8ZmC7VRxa77GAL5qMPYY7YcfZ4yssOZswbmk=;
 b=qDGZ+PnxRFneHefRjEj7mMjY/zM+SWiiciZg+v7ZBxcuO3IioR+cn+6pgV1ErGYFOOVd6w1RtltN9I/fxw2F4L8tllq9+xSZ/sGJX6y6xLLmDpOJl/6d5phbyGYghWuSKJGJzdNzAU1Am5QaVYRzbVGs1lik8hCJXOlmRBxGBRU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6041.namprd10.prod.outlook.com (2603:10b6:208:3b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Sat, 26 Oct
 2024 02:34:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8093.021; Sat, 26 Oct 2024
 02:34:40 +0000
Message-ID: <5f235f6d-69bb-4a90-8e61-00519688fa6d@oracle.com>
Date: Sat, 26 Oct 2024 10:34:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: test remount with "compress" clears
 "compress-force"
To: Zorro Lang <zlang@redhat.com>, fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <c0bbe053db28eb35daf4061bf832278305f9656c.1729855555.git.fdmanana@suse.com>
 <965c0f0b02fbf9d314c2a7192a65e5fd5c0afe53.1729876932.git.fdmanana@suse.com>
 <20241025174952.wmpuqmigei2za3ss@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241025174952.wmpuqmigei2za3ss@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa20829-69c7-41f6-7db4-08dcf566bdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U25GdDZyTTVKR2tyUnM2amVDQXpDbDhZc3RhczhEZ1BuRmR1OGhkS0tmOWtI?=
 =?utf-8?B?WGlZaWlQOGdrMGk3VXZ5WjlYeS92QytvS2RBVkFvVXJ5OUUzQVc1L09WcWdD?=
 =?utf-8?B?a0JMODhST2YzRmJPT2NzS3ZUN0Zpa0VQZk13b0N1cDBjWEhDQmdPeU5xWDFt?=
 =?utf-8?B?a3ZsSFBOZExXNjA1eDZ3Nm9hYVM2bkhPYUxudHR1UGwrQUxSdFgxMFlPT0tq?=
 =?utf-8?B?QW9TNzNGWXFkbm5YYkVneWJNRUdsaUtQQlF5YjY3ODQ4eCt1Vlk1UnBFRWtV?=
 =?utf-8?B?OEoycHh0SDZHTmIzUTZTcWZSM2sxK3IxSG1uZU1rOGxwbWFCRnFYZlM0R0M5?=
 =?utf-8?B?ZlZqd0xkYndvdFA0cU4rL0xWODlXNVhsZ0xmR29rRlpPajRMcVVYU2pMMW5q?=
 =?utf-8?B?SE84SjV1cjZ2eUNvNUc0OU1wT3ZaRXBWckwyM3Y2Tm9YNmJRVE1UdWxhOXEw?=
 =?utf-8?B?QWVrTnJocUdVeXlNa0pIRFJnWW5aOGJ5T0c3RTA4dmpHSVV1b2xiUkhUMnNj?=
 =?utf-8?B?Qk9pWjJsK01ta09TZm9vRXkyaWdQSnBzek1TdmptUEJkRkhHaHpSblkrM25K?=
 =?utf-8?B?RXM1WjQwbWE3UnZkcjlwZ2hpUlNOQitaN0s2ODIzSk9RWjc3RmhPVWdTYlNp?=
 =?utf-8?B?dXpoR2pXOXFvem12NkZmcndFRzBZbWZpajdJMTFOb3pydWJGVksvRkRhcUhs?=
 =?utf-8?B?aVg5VHcxSlRteC9qQkNGWFlVN2dyTzRpRXh3c3VuMHI5amRKOFlqdFk1MEd3?=
 =?utf-8?B?czB0elVPeTJDZTI0Vi9BaGROTHQ2U0JhVEw3YnNGWFZuMUNvMDI4ZGEyVjhl?=
 =?utf-8?B?ZmszVFRTMElkZURWUGlWelhCS1hKNUZoTjhSelc1TnV5c3RKU010QnhxcGh1?=
 =?utf-8?B?RndGZEpPR0RsQklVbjQvQWxrTlVQbkF0ZnR3d1ZsTDhMTCs2aHFwV2Q2clRz?=
 =?utf-8?B?L0JHRHlaN2FzMm9UR2R5NkFtUHdlZDE4amtJcURwUjN2dktkVUxSQVRUdlMz?=
 =?utf-8?B?WXg1Z0lNY0NhL1UxS2ZReVFpNEFIUWpKQ0FsTEVTbnlpMzdZNk1OZ0RPSVFJ?=
 =?utf-8?B?dlgycUxTajRUckp6Y2hrM0Jva01ZMWl3RW9ZNVdMaS9IOXU0a0hUYXRxbStK?=
 =?utf-8?B?eVhOY3VOY3RFZDcrYy82MjVnV2g2WVF6NnFSdjdKUndPV3RsWXdpNmRXQ2p1?=
 =?utf-8?B?a21iSEUyU21Ydmx1TTFIc1RzMUZ2YVpBa3pNa0lScGl3Q0x0NFNQd2hLVE42?=
 =?utf-8?B?VUUwTzBDMzhDK0NiRFErdjkycW5GY3hiODRRaHk4WGtXNEJWdE9QQ1FoUUxN?=
 =?utf-8?B?cDZQbXlSOGRNNng1N0M4TmJHdldha20xVzQ3Rk40cXBEVXVrNGFkekxJd2cr?=
 =?utf-8?B?VFFERHV3YTYrcnk3Z1NDOGx3R2t1UlVjNVU2ZlBjc3pLWWd2VnNVZTBYa2VD?=
 =?utf-8?B?akFoSjBMS2Z4V2VxekFna3R4N3ZvQ3g2NGh0eGRuRXg2SG05dDMzY2t6YU9m?=
 =?utf-8?B?aDhRWHY0ZHNlbnp1bkNJa3NybGNTcU83NnVqK016U2g3T0JPYnNWQVI0Wmhl?=
 =?utf-8?B?aVNwM3R6b0wvd2xJQW9UdkhkeGh5Rko4ZXlhTU16ZVErVm5jei9hWDliVUoz?=
 =?utf-8?B?QWJCWTVxdFh1WWF3QmRPeGZoZ0FhSjBlNDRNazZ3ZEZKa0RzdnlGK0FZL2U4?=
 =?utf-8?B?NklnVnNjbXIvMlkxK0J2TTNjNFE2ZCtZUjJST3YyY3hDS1IwbHNSbVZuSGpm?=
 =?utf-8?Q?B+SE+0CYzsWCAa8RzQem6Rul/BYrwLVo5dU0upu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmZock90Yjk4VGk1N0doVlFhMjlPcWZkQk1WeWdxYXh0REFqQkFDeSt3N0Fn?=
 =?utf-8?B?L25uMUozM0FOZkRNWUpKS1ZGT1hEbk05b0lZeUNsM3NXL0cyaUtVRlMveEV0?=
 =?utf-8?B?TTRhMUFtekxPRWtqRng3TjFxNERwa1lTZStONGdwdHp6KzZGZjBCcGRkVmY4?=
 =?utf-8?B?RHN1Vlh6TS91cWdyYnB3MC82a1JwWVZrTE5hRy9wVkp2VkZNNXhITFROV0Fy?=
 =?utf-8?B?TTZONTFKT052MFlUenZyT3lzK2FoT2VFNU5FQnJTY3VXRmpldlp1aXN4dHRK?=
 =?utf-8?B?Mktnb3FYTnpIZ1UyNlN2ZSs0NDl1UVl3L0Q4TUx1dE5TU2thQmtSajNvYzMy?=
 =?utf-8?B?N1h2N2cwZ2MvRmlCL01INkUxWU9nbUtVczEycHh4LytVY1kwcnZJOXlnZ053?=
 =?utf-8?B?YnJnOWpqUkx4SkRUbzV3S3ZzejEzK1ZFYkk4czJSZ2RDNitNc3cvQTZJQ05Z?=
 =?utf-8?B?c2dmUWpzU0loYVZ2Vm1DTTBOQ0VrQTBhQytDYWd5dnQ0TGFraGJGOXNGU24w?=
 =?utf-8?B?N3Vkc3BOU0ZPL3pQQXpMRTFQcVpVbC9IR3dwaStocCs3a1p3cFVEYW1UcWZt?=
 =?utf-8?B?NUgrZHhuWkt0Y3VEcEhXT3VlVU5VZjdVMGJ6WGhwOGZpYlJCbTdqTGN0Vllz?=
 =?utf-8?B?cG1Xd2lDak00bkp6cTNTMm5xeW03OU5sY1ZRUjlHRzNKcHBqRTRzUlZWK3kv?=
 =?utf-8?B?dG8wZG0xMTBVaXlMdDQvS09TYnhTWWdLdTBFUDgrM3E3eWNzWnk1b0UrZGdV?=
 =?utf-8?B?Y3RRMEVVSE1HclA4Y0JBYjlDZ3FsdlJVOE9QTDE1YjlmRklxdjdtS1pZTGZz?=
 =?utf-8?B?VDNRdThrWEM2bzY1UXp4YnIvbVFTYXJIL1dlNjBOeWZiK3pWaEc3TEhsdnhQ?=
 =?utf-8?B?RmU4bDUyZGhWd05iNUNyRzJSd1hrWGtqc1d3NytsOEI3S3lnZjJyKzd2VUFa?=
 =?utf-8?B?R0xtd2RaRWFNUXRIZVFWa29odUVnTUQwY1dUenZJdktZckt0MnV0dlZKeUF0?=
 =?utf-8?B?QU1kZXIxc0xUNmNnNXo2R25lRzFrVi82TmlZWUp6cVoxYWhQUVhOaWpnL3dB?=
 =?utf-8?B?MlpLZm41Zm5DZ2h0UE01YmpYRVJ1amhJZ1VnckpaT3lESTgrNkR3ckdQQjQr?=
 =?utf-8?B?MHNQV3VFQWJlNW1BUkFweFMzVnRPU0tPVE1wVFFCSFRwWXAzNUhRNlV6dUFC?=
 =?utf-8?B?M2JkbGE4TWw4NDJGb3IvdnBvSjVhZjgxMzd4WEpwVVNhZGRHQTNIYTl3eDho?=
 =?utf-8?B?OXlUM0NVM1hTQks4bkZTVnZZekx6S0p5ZU1aaTh2UU1xdmhRd2FtNEtCaWp3?=
 =?utf-8?B?djQ2aXIwdG44QS9hWU1NaklNazdPRDRoS3J2YXNPV2JheEFnSmZDMjJ4NUph?=
 =?utf-8?B?RXBqaTVTb2VCZmZiYnM5cGlhbUU0MWJxRDVUNTFTWjJJTGsvSkRrNllUMTc2?=
 =?utf-8?B?cDFQc0FwN0hEWG9jdkxtRHF4N1RSOFBPemtlSTlqMVFNUzBONGR2VTZrL21O?=
 =?utf-8?B?aytSNFMzcCtzcklJVTFPS0daekxPQk1BQnhyUUJUYk9hL0VsN21ycnc3WGhl?=
 =?utf-8?B?VHRrNjd2T2orMGVGZEFnUDR0N1lBN0drS1QrZGlrcGRNWDljSGY0UmszYVl0?=
 =?utf-8?B?aVZmNVUvL3VodlIxN1VtUUxlK1J5Q2NLQklwbjRJVElEVjJVNHdNVkRIQURK?=
 =?utf-8?B?aHRyUHJESjlmN1h2R2tLVTd3aUZUZHRrT1YvTWgyL1FqRnM2S3VmSjlMbkIw?=
 =?utf-8?B?NjkxaW5scHgvcUp5bEFPU2FTVXRrV01qbVRUbHhnejdiTlBXdnhzMFZhb0Uv?=
 =?utf-8?B?aG03ZnlrdEhzbWxyQ0pxbWJ5cGs1ak9LSHhwS1FkMkh4OEx0WXpUYkhlWVQx?=
 =?utf-8?B?N3VPY001b2t0MmJXMXBjVVdKQUZLOFNVTVBTaUl1OTNsdnhjeVEzemwrWVcr?=
 =?utf-8?B?ZVh5SGpRVHFXNWZUdW94S1BuSGQvRlhmclVyeVdMZnpwVmlJOERQd29iWHFl?=
 =?utf-8?B?ZUdncmdYb2wvbkpWaWoxMkhzd2lCNDc3TFBTVDlKNjJ0L3RKUmZkQTZ1UUZ0?=
 =?utf-8?B?S2JLOFRTZlhQanYycm1rYW9PNVdmeXV1VVY1cjY3ZEJIaVpEWHhXNEhRV0RE?=
 =?utf-8?Q?4pA7/epJIl8TB8/yrEC+arNn+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9WF4KJtyUzuJZ/HXnY+bk0NaEu4T1vnae6NnCFQEykDjoAv70zVVONQ+Ip3t0EkZJCWR+EXS3ZRS2/0FDBw7t8wKM/iRI/KH0wt35UgTOsHzJ8xQOHmIE2RX0MmG7hpSBUXifdVAkIvlRZwElktlonvKzw93G6SypvSSBcNmnumB4UsKzmJdVffIBBiewIKsSGYZD+Nhhb/fmquHLjfAbbfhuD5GgZ4w8L9l8EzYSb0O4/vz+2rpgf5V/g1oeQIfzqcQqvaXWZlBNS3U/7IakBC+CIF+PH+cKv7z6MQmwdrazbR0mc9JfczRyPGFWKRsQwDZzCYFTN0GZp+2zQn8u8Ej2wuCwlXG54iauI3MgdtrntEb4N+0nb9ZqMkW1DByVytpLJF/s13L6u2DiJPEyaLI04km857VOBYWItfOskUdw0f5TyrJTomux9y6NdHb8C5ltGsK4yVvjr9yslSUEjcuqQ80MWGY/PQvqKm7cPRTYHmzArcxM+fBj7GkRH5CGn3uKEKdSKrEBZ8XIpeWtWUvsr5PqwlLYeJE/zxxN/Zz6ncOk6qGNwK5Do/P/3B63JiIU1w40StDmZzDQcqyPIX2teTAp1XRHoKsE2nyN9Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa20829-69c7-41f6-7db4-08dcf566bdb4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 02:34:40.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emz7wfn25w0LW6DMtHRavC9FF1fwUrt2iOBHZD62WiP1DR22RMJobIbvi07QRl1CymyoVrv3kiY8Qfef4rd0Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410260020
X-Proofpoint-GUID: 5TuAwde6-_XmYkILqAg-5QphG3W4N3I9
X-Proofpoint-ORIG-GUID: 5TuAwde6-_XmYkILqAg-5QphG3W4N3I9


LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thx, Anand


