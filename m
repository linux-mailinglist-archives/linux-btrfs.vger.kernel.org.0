Return-Path: <linux-btrfs+bounces-2348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B4852B8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 09:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FB3B235E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7949721A06;
	Tue, 13 Feb 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RSMP2otn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0ZR2z3q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631120B27;
	Tue, 13 Feb 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813986; cv=fail; b=qz7plmCGh88H7vQmw8mC9iq/+gfk3bTt9kgc9zocED7t8iArQqpizjvcQSkE+pE5uu8oPheb6QB7Mo6+PchojyGJEZJ6MptV0m/cZE6ZFE0EXUusW/bv8Dl82RCBflRUc8djxDXH/5+4VfjpVDiJgFxU97IXCKhlH7ikR50t0ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813986; c=relaxed/simple;
	bh=ghODaq5s9ThN+LyH4yNfVodnsRIQAWYYknyyjgTjbYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JYVM3E+z2Px30+iaxgdQqJaVorR3bOAHoUmagVag/ji7VxmZBUlYcT6Aco632CIMrxRxaDZOEHiWcoEvTkZD8dRbJLH5bgyE923gSIhHtHZ0kEh4avBptulck5e9tqxFdQIcN847ronZTCzK0yiBRPezTW7AvNw3sbS82i7cQIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RSMP2otn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0ZR2z3q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D8j69x027913;
	Tue, 13 Feb 2024 08:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5uC69q+VH/y8RrkaRImJ7DpGwU0RqsoLdkL9/ERmP9A=;
 b=RSMP2otnMyXg+KYR+WqPilywSTE9hIcpPwChPzREG9UhHvmDClskYntw1CL6In69sqXr
 H5gptOf3lQ8OziJSrVTAR9YsFlh6CMjzhuCSWBMCFsdiCEnyUl5DXFu5UzNCJa7EPp66
 EjUZxbKY+j+PJ1bxG9FGEVV4MDhVh194Q4GIZcSpkgzfewt4k6oQ2T8O14AFae2wR/tm
 o6ielSOZPFOfOUQhA7zG2tnk3vFftXA9tEf9HkDFk71Eow+ab2JXzJZyRHDNAamnFg75
 NlOFAcS3dnsgl+4BwuE4R3Xbn/ql2IvPn9xZcNBiENuNbjWMJ9qwdkAJ6UBgP5DesvZj rQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8568g01d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:46:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D73XND000862;
	Tue, 13 Feb 2024 08:46:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7158v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:46:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpIYHBC+St+A2h8EwvQP3vDGv257izvIqwSDxcYpD16LugflgtG/J3JZmXHgAWYyPGZgwlb68prtc9rMxvpYUtuOmoWVNP/0v82tuKoNQNKDUVbY6G7YW7IFZcgwMgB1hnZlQD/zRYBgL81ts+5zc9c8x8STfzdVXxlJ2bTtWHv0DcpILC++VyBh7k7Ktf7q7Ga8S2BGDNjY41V0C8n0DkqWB7t+YXCxT0nWs47JG1zbrI9iF/gxYBFo8b180ESLIA4saYDYf/mf6KWVK+iGp/dnHVWIhffOR6k/oymPGseCW1ra7wILdD8OQ0O0O0a4aO7rsQNnViJTX5cEGQaYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uC69q+VH/y8RrkaRImJ7DpGwU0RqsoLdkL9/ERmP9A=;
 b=BO0MjDIJRVt5nQA7b/dx8JW5F/icqe4VEoOtvM2oBRFLKqSNrA2ul0q8HvcPPFv/S05HdqJ7BExfECMKqIsSECFzFJwdYHI/XnDXnLO1obpWve/2FrufIxi7FFRQQwuTV+aHcMmDJx3/uRHl+yqq8tAx51vXS1bfpTJMfPM6V6ws9baevYuP0DY0jXE5Zad3ovJYfwYTxoTAOXRQ5wsaKIuUVeUia0tD3J6bfghfoR2LQs83L7G3SoZnrKY4XHlFYB5dyvlvtLFBqEkO9qZt+cvHt5QABBH/vIUzoCllhpg53bGs9jQiy0lmQAwQYvH6lFSXsPlU0b994gwhF8K/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uC69q+VH/y8RrkaRImJ7DpGwU0RqsoLdkL9/ERmP9A=;
 b=j0ZR2z3qowdWMx/VEHeVs6WAyrS0BuL9SVizFODZxSL+KzeFyz3s4TRndRfBzS48xQVmaCgMbMDf1N8zgXYhOewix7sfXAtnbfkA26vUga22codANxZstOJ3MQDiZTOpqgxmBZsaND0wh1L+QGd4cGfhdqoh8Z8bxW/y5/cyi1s=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SN7PR10MB7101.namprd10.prod.outlook.com (2603:10b6:806:34a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 08:46:16 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Tue, 13 Feb 2024
 08:46:16 +0000
Message-ID: <02dadc0b-85af-47ae-8cf2-e1289c521aaa@oracle.com>
Date: Tue, 13 Feb 2024 14:16:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: check conversion of zoned fileystems
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <20240213082031.1943895-1-johannes.thumshirn@wdc.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240213082031.1943895-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::11) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SN7PR10MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 93801077-d46f-462e-7a74-08dc2c703d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sTLIFTT9oq4aiyEumTS9uo1Fba9H8stLtr5Djah8fh1b0W0f6GEw7GEhj5WqT7P5iWvzRIvbluKYyutsVuv7Rsa6I9A7680DsxfZD95hw9YyrwPFUCh2i7UnlazvbwhIeTuJBZwCrUvb7iLaUVYMIH16T8125j+/P7ljw8nSPieNgEYWDScPYTXMkr+MmWpOhKJkSPo6ZpjjXBVYf1XRaDXwYRKliBXAhLnDnPOK4ShVjrlS7HDx7DQ0LpqoqeWhdBOYGRF/Hi2lk5waNWERvR+185iwpx/wBN0DhNZNiVkG5vxY8TvMoIV/5FraXWPICK05WzPhgfFrLvyU1aC1GwI07QTkT7m4dQtVOD7lcJpEdZxFIqJIQ2r8S8j/amXiPTkm9dqelCFbTcc/Pn7gf2o3uPNEI1L8GoRD850RwPYR5U0JjN160oSuarWsWfm6tneNJ6EJe3eFQ5G8F3u0gG/40aGAzL0j2zk4wpL3Soe1fHiBl/O1EMZM8CIUsXaU39yOicWBMHaNyo6D/VCwEA/sESRhOWD2UjGKttl0D4aBe/CpMrnqHdVidrmi2FcK
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(5660300002)(44832011)(31696002)(2616005)(38100700002)(6512007)(36756003)(83380400001)(54906003)(66476007)(66946007)(316002)(66556008)(4326008)(8936002)(8676002)(6506007)(53546011)(6666004)(6486002)(478600001)(31686004)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0RETHlheEJKOHMvNUpNaXhTTE9nb0xGdTV4bWdKYU1pUllNMGNGUHJJMlkw?=
 =?utf-8?B?dWhDMTJvMkJleUdZWjYvcE9xakV4R25xNlNHWS8zOFczcndhdnEyNHFFSmQz?=
 =?utf-8?B?OU84ZTRjUWpoNm1INlo3cS9UWmdFT2kwT3F6SzBwbGZNQVhUT1NzTHFOWWJQ?=
 =?utf-8?B?VnVLYnNIdUhpd1lxQUFodDRlZjFCOUpvT3dVUXk0UDVTUVFBdVFFWFNvbFVO?=
 =?utf-8?B?b2FzMHRPUUd3UlUwM3Y1WndqWm1PNEw4TWh4U2dXTEh2aWtmdWk3OWhVK2lY?=
 =?utf-8?B?LzBMVXR2LzZHdDhVUWlQcUlPV1N3cSs5NmsrdkFKL3JidG1pSk1QTnovdjFn?=
 =?utf-8?B?ZFMybTJNSGw0K0JhODBjaWtRd1ZYWmp5aVMxYVE3cm1ZQy83d3lRMi9UbWlY?=
 =?utf-8?B?Sm5SWVdWWUM0SXozaHZlOHVGWU55MlBSZ1VKdHFzaFNjdXFVSXIzTUFyOHQx?=
 =?utf-8?B?ZGdhYkpIdUtnRnVybjVPTkpWazN2M3BFelNuSjIxbTRhS2duVzhwYy9ESk5R?=
 =?utf-8?B?WFJna3lZOVZ0SGozcmg0a2Z1YVJsUkYrNkNMd0pnTG1vaFJWajNvZVByMW52?=
 =?utf-8?B?REhYSUc0YUdrNGwyMjZ6ajRVaWVVS3V4S21CRmNieU5hUnE1WEJ0cmRGbXFZ?=
 =?utf-8?B?dmtmSVJwWVllRjYwSWhCTmRLODV3UzR1MlMzbzVVMjZTbUd4L3FTVFJRNUg4?=
 =?utf-8?B?U1NOUHFLSUsvTG9BZFRkNHh3ZEJKb0pTd2cwNHZDSWlZeURYN3NhN1NXaHRa?=
 =?utf-8?B?ajBPemdJT2g1bWRGU1dCZXFBU2k3NjkzQ2FITXpPMnExd3RoYjRFSmRSYTZZ?=
 =?utf-8?B?MEpHTFFiL0F0WEIxZDlTdjBuSWhKYm1YRzI0aW5SdnYzVkEvd0dKV1gwNUZy?=
 =?utf-8?B?Y2hUV3dyNGxYeXZtVTlkUDMrV0MzWW5lWmllMXNYcnZGeldDZHpVWnhCVlo1?=
 =?utf-8?B?Ty91NUNJRDZ1NHZaSzhvNW10NmFOUmxzTWJnTjNyMHJ2MVNVcjNzSkxBZlc4?=
 =?utf-8?B?eENNaVhNR3Y5Q1JCd3hhVERoRHg3N1RVMEV0YjN6aXN2emZhM3hTa1VGRDVC?=
 =?utf-8?B?WFBJcWhHVXcvN2lJenNoem9YQkhRYnRHdGFLSTVTdlpjYlR5V0ZFQVY3R0ox?=
 =?utf-8?B?OU1OK0FjYnJkWjM0K2FSVnlvZ2xJZ3haZG9BQ25kcjJ2S1c4RENJVkJBdktJ?=
 =?utf-8?B?VXJLR3o4bEVEbitvZzB6L0ZKdWIzMkpUSndCOGErT21vbnNnRnNOV0lKKzJp?=
 =?utf-8?B?K2p5TUdJTmlXM01jejE1U0s4TExRTld4eVo4blFkSzNaditnZjhGQ2o4dHVi?=
 =?utf-8?B?YXk4MC9vQWI1aHhoU0I3R1BQQ3diUE1Hem9wNTUrd1pPTk1IZEF5clhjamtL?=
 =?utf-8?B?VldLdzF3RHA3VXNqdXFjMjZ0Yml1SHNNSlAwVUppcmVRWmV5QlZUZDlKR2Uw?=
 =?utf-8?B?YkV2L1FNZHhPbGJFMHZ1cWhVdzNsRkY4YmhCcnkyRG1vNXZTTFlvYmFDRy82?=
 =?utf-8?B?QTFoQ1Vxck9MY0ZZaDI4Mjlzc05oZTFZOC9TaDNEazdvM0FuWHRqSzIzQ0di?=
 =?utf-8?B?c0xZV05xb1Y4dktsY1RibXFUcTFlek45OWtOR0dKMTBpbmlINldOZUhXL0s3?=
 =?utf-8?B?Zit3YWd5cm1uM1cwaEdqd2MvUk5nbmtjTTExazl4UTJZZEZtejhhVjZPa2o3?=
 =?utf-8?B?NTdjdWdrbTcvTVVsVzJ1dk5henNWNHM4MHR1QlRlVm1BT2p1VXNoTGppT2Iz?=
 =?utf-8?B?aU9jMUdJTXVKSHk3L0J2RlVqS1B6ZGhxeWsvYWJHVEFlSHVrdkVHaWZPeS9q?=
 =?utf-8?B?RG9GZ0FZczAzZmc2UW5OaXY5ZjRrWU1WaXEzcCtHaDlvVmV4Y2hvY1V1MnZn?=
 =?utf-8?B?cnNjOW5BMVA2ZEZTbWNYQlRraU1FTzZON3VDTi9YM0dzUU04c0srRVlnamFW?=
 =?utf-8?B?cG9kRmJUbXp5S1N6NjQ4MnRaQk1HOFRsQzJpN2p6cUU0cWIxOHo1NkM2RnR3?=
 =?utf-8?B?T1c2NXB5a2JwWGpwbUZsMmtGZWVMbWh5UGtGVkxFYU5NWlVRbG9sNnV2VTBM?=
 =?utf-8?B?RHhyNUVnMitjRmYxeUpiMEw5b3NVWVBXM0hxWWR3R3BSMFhzWVVCcXJnbDdS?=
 =?utf-8?B?SHRNU1M1K0FtVEhGendQOGNLOUs1aVlyTXRVSFhSUm5UQjJTaGdSRWtQd3Ru?=
 =?utf-8?Q?stIISLZpN7zpPb15KcCZAZRHL/zInhsx4daEpNQV5yWq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	P+HnwM6s2tPZM2lUH4LqZd3+ZgW0yijjtuycAqxT+MkQkDgn6A4oGvgnJufdC8Yx2ZGG/bhX2etmViDpUlAQG/9C9tJfivZwYGT7d5jplnJJqQB1mCqBx7m63rBDCbnB2xV/MZLD7NkS1Yym8dLBP6lhqJ6oDDDLSOmMVlA53OS+CPUSy1A9retn8QxqVbNxVv3VPQ9WBnV+ZqGxSgmEI1i44pKu3zoSErmLuN4+TWcCJIuc1pTWDSksqEWXtjkq5c7WkoV50kUaWv206dbBsOA4OB8nbEbEJaqcXXzPof1JSfl2VZIUE6IB0lma8j884dQQab/zxWwDBA3il5bDpR/DdyUe2Z52GsTMDQG9zk+4jUj8xcaDoR/7riA028yrZYSbWsHhKCABXjGMeLLWwyvdPiUtXQy+QCa5a4FnDdnKK+TX6D6N6H7CgrITLYoNjphQ7vcKui1kxSM8LE81SKxEI7+8JfVxXw0QEKMCQDw0QKFYdFpe/PMA42kAr3MMHA5/IiJAcQUoQFu0pxduuMSPe5berYBeEszdLFnP7opiDTR/QMFkVseg6wEBbNU5GbDC+s2swaHJujRD6onsHrsAkBeKEhBS5Zgdv1uVYxk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93801077-d46f-462e-7a74-08dc2c703d7e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:46:16.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2ld2M+Gp8KUqwniopf0YFuwnHoS0a7TTygq70DzX1JOYeJHaNroqNr2ZsbGiDC3PcErV7HTiylpjARebngG2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130067
X-Proofpoint-GUID: u0Es3EtQPIIk1DUvpffo7qpAcQIgjPTt
X-Proofpoint-ORIG-GUID: u0Es3EtQPIIk1DUvpffo7qpAcQIgjPTt



On 2/13/24 13:50, Johannes Thumshirn wrote:
> Recently we had a bug where a zoned filesystem could be converted to a
> higher data redundancy profile than supported.
> 
> Add a test-case to check the conversion on zoned filesystems.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/310     | 75 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/310.out | 12 ++++++++
>   2 files changed, 87 insertions(+)
>   create mode 100755 tests/btrfs/310
>   create mode 100644 tests/btrfs/310.out
> 
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 00000000..6b0846f0
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Test that btrfs convert can ony be run to convert to supported profiles on a
> +# zoned filesystem
> +#
> +. ./common/preamble
> +_begin_fstest volume raid convert
> +
> +_fixed_by_kernel_commit XXXXXXXXXX \
> +	"btrfs: zoned: don't skip block group profile checks on conv zones"
> +

> +. common/filter
> +. common/filter.btrfs

common/filter.btrfs includes common/filter;
So common/filter can be dropped.

> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 4

> +_require_zoned_device "$SCRATCH_DEV"

So, only the first device has to be a zone device?

> +
> +
> +_filter_convert()
> +{
> +	_filter_scratch | \
> +	sed -e "s/relocate [0-9]\+ out of [0-9]\+ chunks/relocate X out of X chunks/g"
> +}
> +
> +_filter_add()
> +{
> +	_filter_scratch | _filter_scratch_pool | \
> +	sed -e "s/Resetting device zones SCRATCH_DEV ([0-9]\+/Resetting device zones SCRATCH_DEV (XXX/g"
> +
> +}
> +

Can we add the prefix 'balance' to these functions since they filter
the balance output? Also, imo, it is better to move them to
filter.btrfs.

and..

> +devs=( $SCRATCH_DEV_POOL )
> +
> +# Create and mount single device FS
> +_scratch_mkfs -msingle -dsingle 2>&1 > /dev/null
> +_scratch_mount
> +
> +# Convert FS to metadata/system DUP
> +$BTRFS_UTIL_PROG balance start -f -mconvert=dup -sconvert=dup $SCRATCH_MNT 2>&1 | _filter_convert
> +

Why not update _run_btrfs_balance_start() to support argument passing
and pass the options to it to run balance using the helper function?

Thanks, Anand


> +# Convert FS to data DUP, must fail
> +$BTRFS_UTIL_PROG balance start -dconvert=dup $SCRATCH_MNT 2>&1 | _filter_convert
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT | _filter_add
> +
> +# Convert FS to data RAID1, must fail
> +$BTRFS_UTIL_PROG balance start -dconvert=raid1 $SCRATCH_MNT 2>&1 | _filter_convert | head -1
> +
> +# Convert FS to data RAID0, must fail
> +$BTRFS_UTIL_PROG balance start -dconvert=raid0 $SCRATCH_MNT 2>&1 | _filter_convert | head -1
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[2]} $SCRATCH_MNT | _filter_add
> +
> +# Convert FS to data RAID5, must fail
> +$BTRFS_UTIL_PROG balance start -f -dconvert=raid5 $SCRATCH_MNT 2>&1 | _filter_convert | head -1
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[3]} $SCRATCH_MNT | _filter_add
> +
> +# Convert FS to data RAID10, must fail
> +$BTRFS_UTIL_PROG balance start -dconvert=raid10 $SCRATCH_MNT 2>&1 | _filter_convert | head -1
> +
> +# Convert FS to data RAID6, must fail
> +$BTRFS_UTIL_PROG balance start -f -dconvert=raid6 $SCRATCH_MNT 2>&1 | _filter_convert | head -1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> new file mode 100644
> index 00000000..bc06b29e
> --- /dev/null
> +++ b/tests/btrfs/310.out
> @@ -0,0 +1,12 @@
> +QA output created by 310
> +Done, had to relocate X out of X chunks
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +There may be more info in syslog - try dmesg | tail
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument

