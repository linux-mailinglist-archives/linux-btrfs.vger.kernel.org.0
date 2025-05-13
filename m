Return-Path: <linux-btrfs+bounces-13968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E03AB4FB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 11:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AB61887ACD
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 09:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515CD2222CA;
	Tue, 13 May 2025 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iniV3cEF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yIoaaUE9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC7221FBD;
	Tue, 13 May 2025 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128286; cv=fail; b=LO5DpUvdByDaT07rlnerrkN4GKP6rq6RueoP0nY9CVPqYIrd74IINwuklEU6gzUrbEK7woOXvE47e9vuscpH/RWQwVNDmgeEJ7IflUaLtQB4iwkSyBW9/M91RrPgz4qzsVDRaGxLqQts5mNhl5lUxp08kRvcjxqfSEFutaY98dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128286; c=relaxed/simple;
	bh=ar9nzBt7UNo3l/zXRdTFIlSF+lL730xUXplAefZAW3Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cAWMwLFX2u+2cXYIcBa3xs/V2U7s2neMJtk8R06Ms5KGUVFgVKWUK3/HmlQTIQRdL0V3wJGF5owABCOwaWfpviHDrRNXHZEWmPphyq2eqESHU2+AFa42lzk8l6nxqlIYv822ZrGrdhbnBXnBpg2gasK/VmiGRPGuFV8mCSabios=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iniV3cEF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yIoaaUE9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D1C6Tl030910;
	Tue, 13 May 2025 09:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ONxAjZUoaKGS/nXLrLqxB4RQxP+Jdx+SNpX5WlH7b5Q=; b=
	iniV3cEFc5yRw7lGkXzMeWyqZIcfmSWtIlpmDuwA+RcSiAOxxrdpagpaV6j21e0l
	uhmGe8L6nTzHmmUsxk9lujrxNKAfE+tNA1ZhE0QRT34b0QbF83Tj3VqwMs5PqHt+
	AMRJtw84Opt884MpMdsjZF+leLyAVuzWi/gXqVUFf3Rsg/qJ7t7A2xdbYa/bvV6i
	0JXkYz8qC5Dnb9bpTC/uxiRI9lJnuF47TfAf35KdH2I5L2R27g/7AKw4nV0L6nB4
	7R9UgFQMTtXeolNWuUfpjQ6DyV7znyHpYg4pM43hYYr0it4bq1CdNdfEmPmrG8s7
	uvOM31bm/TxuXcfRNcnujg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2c86e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 09:24:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54D88mG0036475;
	Tue, 13 May 2025 09:24:41 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011027.outbound.protection.outlook.com [40.93.12.27])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88duv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 09:24:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCztx/LSck7ammXtJPaWCW9+KlFuAuPJhn7wk7mu7AHXGJLCefYqKm/O5Fl2MfooFjkYAHYMupeN8O9DlHDFHyuiNdb1jxBflCOydwjc8Fjfmi+8qZ/Bss3JleLZ73frFBQHjTlmgx/qP+FEXdMiceuI3hdvthqO26XUkJt90eHyBjgNJ9Uw5kuALo5Q0D1eQ2Fxx3Btxq073kz7yYbwQyYfIjgAczjetxQRFvNASaA+VhFtSs33/O/Slfv1xVgUCEbaqkAJCg06yH1MecJ7Cn8E66R63ht7PvdtldPTu27XzJyu6cETNUqpFzEi2fcF/ysxrOtfZ5xBa/dL7O1MOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONxAjZUoaKGS/nXLrLqxB4RQxP+Jdx+SNpX5WlH7b5Q=;
 b=i3Fp41529KOpUurClwe1r5p+kZJ13oFO/UIm3rQ9dCA1ZjHs1pTmCNAN4yDYwPuOv8M62g6m2i7DJmqsnLpLy8PsZa/bmxdnEHpoRc/C+8ScVg8ty/tfYuWOXjzHRIpzF1qYDUSb7i/Sx3f/YYDoghJv2a4bELZVJDxEvAA/qc3aaFOK9vmPvyqmRMYZQcTfKnEccF+ReqES9RQYpWCrkrvSp0GnS5iaAbNsZQ3aeGB1F0Mg0gjZEzEpMn/rPZRh3fzOEaLqCRkaSes2TSaAMjLGc3p8V9o6vlSbZjTHgxdt+2bJIgO5Oc7procijgQRtcmy6cjB4RVf7JPugPYESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONxAjZUoaKGS/nXLrLqxB4RQxP+Jdx+SNpX5WlH7b5Q=;
 b=yIoaaUE9k+6AEV4qiC/jGBL3gVbCUaFk975sQFI7XSha3d3htUfZedZaRw4OW+YlcRSStLPpfnJkbW/JlNy+8QZwVVOttvfd8AvGvRoN0uGRb7RmJ42co0x885yfEoHUx0x4w/ZNfjkNYE1i6Ss4DqcrE324s2dd7BRwWDL1MrY=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by SA1PR10MB6590.namprd10.prod.outlook.com (2603:10b6:806:2bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 09:24:39 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Tue, 13 May 2025
 09:24:38 +0000
Message-ID: <5364767a-e1a2-4fbf-93f8-b85d35d04da2@oracle.com>
Date: Tue, 13 May 2025 17:24:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/020: use device pool to avoid busy
 TEST_DEV
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250509053709.100446-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250509053709.100446-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|SA1PR10MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 13eab853-4155-41d1-821a-08dd91fffbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVFVUEg2d1pEL1EvMWxITDNxckVMYlkvMElmSWlJZTQyZ0Q2K3k0aWIyY1RB?=
 =?utf-8?B?cUNUSllZNnA0WDJjL29GRjAwdThjQml2SHkvZ0U3eVJ3N2pCc2hmVUtJQmN1?=
 =?utf-8?B?R1k1dE1zd1NQY1g1eWsyWFg1TkI3emZwTjdZWnVVd0VaOGJEYzcrNlpvajFI?=
 =?utf-8?B?cGc4TGkxeURhUUVnWGZmTWpJUGdld1Qxdlo2SWFkN3BQL1UrTktNdlIvV1I1?=
 =?utf-8?B?WFdITnpjU1pJcGFSd0JtdzZLYlFQQVp4dzh3VWk0UkdxcUpteGMzbjN2KzdM?=
 =?utf-8?B?clFlRVArNEkvVjJMUGE0ZFFSTVQ5b0V6K2lCZ3ZkR2Vwc1hiTE55MDA5cmta?=
 =?utf-8?B?eklHR2lHMDNvQzZRaGorWlBKaW12a2VTTlBPSFRGc3doeUdiNVNCYXRFSS9o?=
 =?utf-8?B?TTQ1LzVyRWZEVkF6RWJKZmxIOGlWeEwvRkc0NVJNZi9kaUIxV2szWXUrTGl5?=
 =?utf-8?B?b2xMdFRDSEE1eUg3TGdQRncxbVlMQ0txa1dMMHl1dHZDZ1c4R0wvdkxEcGZD?=
 =?utf-8?B?NWlXY0dYRlVwMVA2QXI4OEEva1NNRHFlVGpSdUFFdUh4L0V5M0lHMTA0S0py?=
 =?utf-8?B?YkdzTDBVeDZUYUM5VnVsTld3cmJVUTJZZFN4VCtudGRNTzJXbGIvSHBkcGVK?=
 =?utf-8?B?MG82aVNlaVhzN2hoR0Z0alNTK0wrc3FiUnNlOGRWamk3Wld0VkxsNTJwd1lF?=
 =?utf-8?B?RW9MNVBFQ2o4Q2wxcDVmUkhGSGkxY2IwQ2NheFA3cVE1NW9XRFNveS83RG01?=
 =?utf-8?B?VFBtMHBTd29CeCtHakt3THA0ZUdabkJLVURrNUVMMUZ5a3FqRHBqKytiYlAw?=
 =?utf-8?B?c1RCTWZXOGRNM3g0eFdyVDRNN20zYWVPMFF0UXdxejRUeVcvMDNXV1BxRWY1?=
 =?utf-8?B?NXZ4elJxbVpubWxsb3BzelN5WFl5ZnpHeDZOSHIxc0pYa0l2U3Q5TTVZK3Jl?=
 =?utf-8?B?K1lxRTN6WjU5RjBNTjhJMkEyYVV2RkdvUlJYak05NGxvRUdicjVGSm5yTXJS?=
 =?utf-8?B?U2JrRWtldGtkU2U2STBweStBZjh6L0p0U0htb0VXN2hPTll0VGN1N2puVDdN?=
 =?utf-8?B?ZWlteG11M3R5bFV2cm1uOFl4L0VIdkEyZDhPSjk2Z2ZoK2l4ZWZzQXNhNDRU?=
 =?utf-8?B?QU9WY2xCRnFOM2V2YlBmQW1VQmQ1dEkxZXpvS3dWcWVUNncrc1VESDBIVnJ2?=
 =?utf-8?B?UXFVWWRxYXlJeTRmdjQ4UFl5YUt1c2llU3FCU3FZUWtETlJiQzZMcHk4emg5?=
 =?utf-8?B?Y0JwQ3Z0QnFUdC9KNFlUazkyMFpCWXJhTStOaUlXd3ZqeVVISEgvVUNTNWly?=
 =?utf-8?B?UHhEcVUrNjZhY2tJWStILzVMa2FwampWV2dINGoxOVc5RTFUbEtOVTRpVTVi?=
 =?utf-8?B?Wk52bWJHTEFIbExHMm1sYzVmV2NXak4ramlVNUxPd3RCVTZQT1JVMENZTkh5?=
 =?utf-8?B?N3gzRHZUM1hjMEhCaHplN2FPdjJSQ2FWMkRNUnF5QUxFcFJraHlsYkt3UExY?=
 =?utf-8?B?K2NocEdMbzVEZ0FnNGVDMkptZzZ3VTBCZUNCVThlankxZWRHMVFkRkpmOWRJ?=
 =?utf-8?B?elJ1Ritkc2k0ZU9vYldXUmRRQmsvOHVFWFdNbTB4WWUyTDZoNlJPMFMxNGtI?=
 =?utf-8?B?TndwZGVqZGptZUxlSnh1NEV1d0RTLzNQOWZGTU1IazF2MUloQWRFeTlDbWZt?=
 =?utf-8?B?b0RWTklwMnRwQk85ZDhqV2pwVmZQdHYzbkRSc2hnTk1ER3JFdENLY2NGZXZN?=
 =?utf-8?B?bDQxaUNDaGRIdjFiekRYbGlQZG94SUIvYy9OdkVFdzd4Sk82V3poaExjdENp?=
 =?utf-8?B?Ujk5ZWpyM3FVWjJvcVpZdmZTN2dOSWFFeTltSzF2M1d2OCtsRDhSRGYxakJK?=
 =?utf-8?B?QjJVdnF1Vy8vRUNOVHNwaEkxZnAzTTZsT0Y5aldsR1Q5Lys2dVJIZjRHYy9X?=
 =?utf-8?Q?CC++9iOjGvo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm1uNCs3MGxCVGFSajYrNWx6WG02ZlNISXNwajhjajlPN1hJRXYxV1FBbU9w?=
 =?utf-8?B?eHRuMHZBVGZFekZpS2dLK1JOK2N2UUpES3dNVnVOM2swTDMwb1pXWXN4dm9u?=
 =?utf-8?B?MytKdW02a24yOFBneCtKUzlZSldWMzhxallnMXlteGJFV1BFNkZ3ejJjRVQr?=
 =?utf-8?B?bThqWWRpZVAvRDlFT2RtY3BKRk9MV0JzRHgrdVRaWnJnaUtmenkySmRlWkRy?=
 =?utf-8?B?aTdXdE9MUE5JNVhJTmZTYnNMdms2Q3NiNjBPbDNDU2NkRnl5ZWxlRkhnTGo1?=
 =?utf-8?B?WmE0Q0JRS3RBUHBjcjJQbVg5eWZ3TW1GTDZvNzkvckNBMFlLY2x6dW51cUp4?=
 =?utf-8?B?OUwzSkJ3Kzc3RFE2RGdacUxvODRkV3BpTlZGLzJuZlZIcEk2V3VUU2lWVDI0?=
 =?utf-8?B?c1p6emo1ZHllblZ5aDRNUXRWeWFjN2RhL1QwdFJxVGRNa29LMDMyQmg4VnJ0?=
 =?utf-8?B?LzRiQkZxMHZmL1RRNEJtSmNUT0pLQm9IY3BEQVgwVFBKUWVPTmd5bGR0cW5y?=
 =?utf-8?B?UDZnakFJNytpb25uMzIwM2t5RVpFN0dyOFVQd1diUnBXUkRoVlAyRlVva1J2?=
 =?utf-8?B?eVNKMlRuWnJhSTh2TERTaFcvQVNpcWhrWGw4SFd2bDFTTytUazV3TFR4UE0x?=
 =?utf-8?B?RlZpRVB3NTlhNnR1M0xjeTlqNkFvUmdRV2Y3MGRWdmZDclpRbUo5M1R2TXNH?=
 =?utf-8?B?RGJVeFFZK2FOWjl1ZFV2Q050cXRTRXRiNkUvc2tweUdycW1HMmN6TnhYVHAw?=
 =?utf-8?B?S0hYOWMvSkFvWWFvV1ZOanpUcDdUTmczbUhoektKZnNrY3hPYkY5cGdyWW5C?=
 =?utf-8?B?ZG9Rb3hFNnFTdjFqZXRxdzBTOGdBYm9rYnlQdWZaU2o0elc2ZERLZjFWVlNQ?=
 =?utf-8?B?L0szZmdsU2RIYWU1cS80Umc1MjNHRDJBMVhMMys1OHZ6b2xJSjVqdm5RcFp3?=
 =?utf-8?B?TksxOEUxNUJXQWZwY1Z5NG1MWmt2aHJhL3ZYS3BmUkNoZXkvRm9TeDY3djUz?=
 =?utf-8?B?ZE0vVWhnaklySThvZ1JVQncyMU16NWhBY3EvcEZxWGcrYm5seFVGd0cwNzAw?=
 =?utf-8?B?cWg3ZjMydTg3TURTdDRsRWxXSmlpeFFEdzRmcjNiTmhzN3dxSXNXZVJEeHZh?=
 =?utf-8?B?cTJsVFNCTzZHRklubW9mVjVxNjZ1SitsTHFFMFFqS0JRTXYxNVZGbE5qMEFv?=
 =?utf-8?B?VWt3OTE4d3JURXVBY2xzZnVqRkN5b2FwTG1paFBZY0JZd3g3T3E0dTBiODkw?=
 =?utf-8?B?N21POFJDUDJ0VDJTKzI4U29xZ0lUZjhGeFo2dWZNZG1mSkFLN1huT3JrTTJx?=
 =?utf-8?B?R2pJMXdaeEk2RGprWWdjc0NWSnk5ZlRKdHJiUGFaQkhQRGgwUU5HN2ZnREM1?=
 =?utf-8?B?bnB0WVVjckVSd3A5TGxKWjhoZkUyWmgzSyt1ek5sWXRIaiszS281YUk5b2o1?=
 =?utf-8?B?NXZ0NC9RSWM0QlpzRmRZR0tRUlpWcU9RUDBic09DNHQ0dGNidERoN0graDdW?=
 =?utf-8?B?MG9pNHRVQlVlczRXRFA3UE5abnFiNUNoUWx6WFFlTFdrTUJQWEt2dnlNQTNI?=
 =?utf-8?B?dHk0TkZ6WmdKbVRjK3JTaWFjaVVtQlVmVmVTWmxSZko5TVFBdzR4UkFFQmVJ?=
 =?utf-8?B?ZE9INFVDbFdtNTJLMXhwT3J2TEM0bjdMQzVKai96a0srTjdNMFJPMmxRZTBv?=
 =?utf-8?B?ZXJkQnJOSmlBbndHejRienF5QnRFdDU2UUpFOGJsS0VxZDJmYlo4MVJLSG5y?=
 =?utf-8?B?M0I1SnZ4N0plWFhnNDhhT1ZTUWhMaTZ0blhoaEppSkY4LzRZWURvQ1BKSzhP?=
 =?utf-8?B?T2swVS9DUjU3QnV4bTVJSlJqOVFLVEQ2RmtGbmJ5Z1RlQURvQm0wdmMvMFdp?=
 =?utf-8?B?MGkxTGFub29uR2lwV1M5dm9nTE5KYm1vbi90SkdhSklUK0hGSFdzSVU3OEUw?=
 =?utf-8?B?T2tpemVjak1zWXN1UlJLZ1REOU82ZUdxNldYa21NSGZzdHBHdkw0eFFOUXVN?=
 =?utf-8?B?Mzd6T1dBaThUUjEyVnlRdkZyQ0U1d01QV1pmaWtNODdWeERneklEWDBmNDBU?=
 =?utf-8?B?WjR1WWR4MEFiZ3JoajRDb3d5ZXZLYWZvcm1JbTZEYURiWFI1QkRTWDAxZ1JR?=
 =?utf-8?Q?h61ManZl2jX2/u5WAgdN23oPS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kcPAs8IgqpLox9+PaV875JZFZmtQ8Yl1oNomvoTdCVt1ruae8Wjh6zxsErJCpMpCVsBEAbt23WcM5UJ8hVOztew0gABcpYU8449/ND4GPEyEPcV3rEDEg8mTqYYY6/2RLmcrG1VnNkfuFTWN/qiH4krqhAKwMNOd3gSvd03Rn3tzMMe2z53PoHsfk2OpKI+ZErqvJgqkL5AffWDHbLa5vfyyCFDnRwoC38F4OWG/A5utGHC3KS0TLQBHgfO7unPV5/lA1JmmamuU3pryh/tkaYI+F+lKih8zCQFoS+2pc0dmZB7WtHCIMwS2T7OEh+3VBdPjeVmssf9TcZh5DEc3cOfe1+N/TkNm8oU3ryaIXX8JWrDUAjZj0h/rSy7FJvPPc+t+IxdkutLYrcqCmtVOMd5eaTdfCxxOCYsqiZ3CCFI7/S4GTlJWPkdsBWrW9crfR3Aordbi6IYV8H0TG2HzVPaQngsFhMQDXTbu3RouId/36UTRAdNxHI8POkB4kJ1x+AzGqc7Ewc8mF9AOj38fbZfVRewqhlgR+aSWjzrPR9aXMgPl8G+Dig87QEIxsg5Wl1oOq8ZBK7hT4qq4lA7NclH3R6vnpY9x4mxzfELb1xc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13eab853-4155-41d1-821a-08dd91fffbac
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 09:24:38.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+0EvhWzyz5V4D0t49B0TGZW4I9Khtb30eBQSNG6pXpaMR+xXlTUP5y/y/9uOqheUAOuvH9z8O1x761GF5KQSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505130088
X-Proofpoint-ORIG-GUID: Plxxj3Vj18fOzY5ZMyrDaFSAneV313kV
X-Proofpoint-GUID: Plxxj3Vj18fOzY5ZMyrDaFSAneV313kV
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=68230fda b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=Crmu_kmCxxxAG0to3qAA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4OCBTYWx0ZWRfX+5Oa/gQsNVmC u3nYrpZHFAlopx1/ryCGGBnGJi6d+QuqVVMyy3tAgIcYLqj65gq+cLKjqcy0mPBI4N4dm0xrl+V XYTKFflCYSM2hMm4vzRQrbc+ieewBrIlBstQ1/LuUbo1KNIGFZOo26cm/lkTyWI1YHI4Y8PVZbs
 GANccdGaIbZG1pE+LlHQ4f7GL3390iJpznss1Y2STWrltFGgrL81dv/oD/r/vnVHb+6Y5/4o63s PQvh5N5lzB1Nd9WNQ57TSbqNMeAduRjYfPPpPq58rbsHOXVx+PGYfZbevpI83dx+Nqzh1jZMyP1 TK5D67u7vTUyN2Yg3+HXFBPAucC/385WSS8AdZCH8xrFrMzV/F2lkR+7DySKnjjq1Kf8NxHm9Gu
 m+d2SpEvR749mW5cIxsEgPaID3fyf31PF70XxHI4NwJ4gRS4Ho/YG6bksvXy+LBtl5mfSgvj

On 9/5/25 13:37, Qu Wenruo wrote:
> [BUG]
> There is an internal report about btrfs/020 failure, the 020.full looks
> like this:
> 
>    ERROR: ioctl(DEV_REPLACE_START) failed on "/opt/test/020.5968.mnt": Read-only file system
> 
>    Performing full device TRIM /dev/loop8 (256.00MiB) ...
>    _check_btrfs_filesystem: filesystem on /dev/loop0 is inconsistent
>    *** fsck.btrfs output ***
>    ERROR: /dev/loop0 is currently mounted, use --force if you really intend to check the filesystem
>    Opening filesystem to check...
>    *** end fsck.btrfs output
>    *** mount output ***
>    [...]
>    /dev/loop0 on /opt/test type btrfs (rw,relatime,seclabel,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/)
>    *** end mount output
> 
> [CAUSE]
> Unfortunately I can not reproduce the situation here, but it looks like
> by somehow we didn't unmount the TEST_DEV before checking it.
> 
> This may or may not be caused by the fact we're using loop back devices
> on TEST_MNT.
> 
> [FIX]
> For this particluar test case, we really do not need to use TEST_MNT and
> create complex loopback devices.
> 
> We can just ask for 3 devices from the device pool, use 2 for the raid1
> fs, and then use the spare one for dev replace.
> 
> This should greately simplify the test case setup and cleanup, thus
> avoid the above busy TEST_DEV and false test failure.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/020 | 51 +++++++++++++++++--------------------------------
>   1 file changed, 17 insertions(+), 34 deletions(-)
> 
> diff --git a/tests/btrfs/020 b/tests/btrfs/020
> index 7e5c6fd7..8c05196b 100755
> --- a/tests/btrfs/020
> +++ b/tests/btrfs/020
> @@ -12,44 +12,27 @@
>   . ./common/preamble
>   _begin_fstest auto quick replace volume
>   
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	cd /
> -	rm -f $tmp.*
> -	$UMOUNT_PROG $loop_mnt
> -	_destroy_loop_device $loop_dev1
> -	losetup -d $loop_dev2 >/dev/null 2>&1
> -	_destroy_loop_device $loop_dev3
> -	rm -rf $loop_mnt
> -	rm -f $fs_img1 $fs_img2 $fs_img3
> -}
> -
>   . ./common/filter
>   
> -_require_test
> -_require_loop
> +_require_scratch_dev_pool 3
> +
> +_fixed_by_kernel_commit bbb651e469d9 \
> +	"Btrfs: don't allow the replace procedure on read only filesystems"
> +
> +_scratch_dev_pool_get 2
> +_spare_dev_get
> +
> +_scratch_pool_mkfs -m raid1 -d raid1 >> $seqres.full 2>&1
> +_scratch_mount -o ro
> +

> +$BTRFS_UTIL_PROG replace start -B 2 $SPARE_DEV $SCRATCH_MNT >> $seqres.full 2>&1 && \
> +	echo "FAIL: Device replaced on RO btrfs"

Please check for failure using golden output.

$BTRFS_UTIL_PROG replace start -B 2 $SPARE_DEV $SCRATCH_MNT >> 
$seqres.full | _filter_scratch

And in the golden output 020.out:

ERROR: ioctl(DEV_REPLACE_START) failed on "SCRATCH_MNT": Read-only file 
system

Otherwise, looks good.

Thanks, Anand


 > +	echo "FAIL: Device replaced on RO btrfs"


> +
> +_scratch_unmount
> +_spare_dev_put
> +_scratch_dev_pool_put
>   
>   echo "Silence is golden"
>   
> -loop_mnt=$TEST_DIR/$seq.$$.mnt
> -fs_img1=$TEST_DIR/$seq.$$.img1
> -fs_img2=$TEST_DIR/$seq.$$.img2
> -fs_img3=$TEST_DIR/$seq.$$.img3
> -mkdir $loop_mnt
> -$XFS_IO_PROG -f -c "truncate 256m" $fs_img1 >>$seqres.full 2>&1
> -$XFS_IO_PROG -f -c "truncate 256m" $fs_img2 >>$seqres.full 2>&1
> -$XFS_IO_PROG -f -c "truncate 256m" $fs_img3 >>$seqres.full 2>&1
> -
> -loop_dev1=`_create_loop_device $fs_img1`
> -loop_dev2=`_create_loop_device $fs_img2`
> -loop_dev3=`_create_loop_device $fs_img3`
> -
> -_mkfs_dev -m raid1 -d raid1 $loop_dev1 $loop_dev2 >>$seqres.full 2>&1
> -_mount -o ro $loop_dev1 $loop_mnt
> -


> -$BTRFS_UTIL_PROG replace start -B 2 $loop_dev3 $loop_mnt >>$seqres.full 2>&1 && \
> -_fail "FAIL: Device replaced on RO btrfs"
> -


>   status=0
>   exit


