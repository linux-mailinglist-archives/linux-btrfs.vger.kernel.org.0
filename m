Return-Path: <linux-btrfs+bounces-14137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C11D2ABD731
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 13:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3511BA46BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A68627EC7C;
	Tue, 20 May 2025 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rNYAYU0p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zxU0MgL5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E727A47C
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741523; cv=fail; b=d0mrVu2MQvPQf7TQXIJkn/cSz+3TNOSPYKi0yIg5J+S79w75hVPET7Non0ZA3QnmZ0h023YQ32oaqQRNWNlxRPP7aiivZlEC+uJ7gSa/mhjrSnrk219j9S3g+17F4eVXUw9nZ7chYycnDqaKavdRoCrIaxYAjuh9kh6dT/mc2e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741523; c=relaxed/simple;
	bh=ZnfjkQV9+nabLMzFqoP+NWGkzCimQmEZmQJcqVpVXVI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O9jjXGMs004z06oN4KdITPa7eAsZSYP6sAtx+P5fUn7sZGNbVHRHDz9TLCH25C0JCuu90YFLO812PJaM4CL71kJfgwvg07hY6hlqXIDSt8x73IQYHPARUH2N9HPxs6jAHnQVBOkBtJfBkku5y53fMUNjGdHglucDPN0UW4fkHcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rNYAYU0p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zxU0MgL5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9N1G7024991;
	Tue, 20 May 2025 11:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fAsvHRsyrt6R+c4CY3uZn8Op3qBsmiI0U5jc6diwHCM=; b=
	rNYAYU0psvF13OHQ5dc6H7yR1moByDnT+p/hEhj2tDb6xuN6MzYWAK70Nv18q6Hd
	uK8Xcsyb9GrvFt4IAXf4JczMUicFM1uBo7EdVQE1hvs/ca4aH1XKUchj5rXaUpr+
	NM/AYXbC4yczIW/66F461/sTajqEbzNBqL4q4swd0YpN5gAwELI3CENi6Id9RSFm
	+3ocRI3gWT84iw5R5UPABz+fXQxTY5iKNvKIKlIoSx+1kULSd3//53NPPmklyywN
	UkqOQrp6UMQ72fnmkJzdi8PMsWgHPYOFYkOx7GO4pjmb92SE2DIW3LunkQJIAiny
	zFLf4dxCRtVSS21kisCldA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjge58dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 11:45:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KA0uMb037159;
	Tue, 20 May 2025 11:45:15 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013063.outbound.protection.outlook.com [40.93.20.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw8n037-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 11:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TX5q3EXaxOs7jFwFW0cyGlnbQKtham9ORgCPc7W/QvLvaUVujovR9pHIhqr7nzFQwdLQty4CO3CDxQUptXKXCs+MO0G3uWCzV+7IarUwGczPjso2WB6PZTA6h/YEsLCQgNmOklsdLN6L+vuDT7jx+x3WeyqvKSGQc3c0CoTcNsZTffowq8IDRIbCT/AU4c8PjAlVM9ea8XeLojaqQ/U3/1yCurcjJK39qAOi8oUFAJj7h5L/jex2yhy7H0PspYhiXnQMWb/PNhd21YANgmJl2QWS8n7iRW7M2VkpZbQVQflm5HRVveCi/1ZATVZOElLa7HpGFgL8+1q2+rfUJvZgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAsvHRsyrt6R+c4CY3uZn8Op3qBsmiI0U5jc6diwHCM=;
 b=ZsG4DfSBS4YgImrhsX0cSYlXwbLJC1Jt/JQC91Pk2TztfJiMTMPtcyM6b4i/bEc/bKZX9hHRYzjp9EsXr0rirpOO8x1cX+DCyLOdHf1Vxk65szC69buCQmV2ji5w6cen3Ndt+pxm2h3cmHLfpo1zvaLibGjrMbTyS1OsgGims/8rU60lLSLlCO2xHaVTyY/FAvXr+bpdjLsMn4QwW4gspTaEHHj7a8P3hGePdFOBJnGb+RfuQthmmkE7xXEvhODE5oUi8YgnBA+sNHwju6qlU0ZsM68g4zcp3AjoF5e2CE2IuXVcCTloz5lF4Y5IF3BCmuFFDqdEI4+DCphU4CzYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAsvHRsyrt6R+c4CY3uZn8Op3qBsmiI0U5jc6diwHCM=;
 b=zxU0MgL5FRu/ZoLoNvJxPksBwKv4XebxnOooEjaze4B5sQNw305WgnBRdbR7+fgD540/HBPbJCnG8CWiCPJUz2QtWCiV1KzHXSWN0r5zpO8RdR4dgRsNWrtnNKhBK1N6Gk7WvCrXvGNLnQHPOkkdXR6WqmS9EZVE/kJzKO9CqMs=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by IA3PR10MB8044.namprd10.prod.outlook.com (2603:10b6:208:515::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Tue, 20 May
 2025 11:45:13 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:45:13 +0000
Message-ID: <d993a3b4-b278-4a15-8e6f-1345224fe871@oracle.com>
Date: Tue, 20 May 2025 19:45:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: add prefix for the scrub error message
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
 <adb7e0b9365da95d9497c4cde18233f3e52e41df.1747364822.git.anand.jain@oracle.com>
 <CAL3q7H7Ld0-buDpw4RZOaVHe_jMAnYPMnPNu1Nj=g5ODN0ps0w@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7Ld0-buDpw4RZOaVHe_jMAnYPMnPNu1Nj=g5ODN0ps0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|IA3PR10MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: b796d321-5170-4588-d2ac-08dd9793c843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDNCTzlvNGttTS96bG0xMEhzeWZPTWExVG9DbzQxU1QwNzhadmwyYlRzRjhI?=
 =?utf-8?B?a1hvTmVxNW5wMUVkWFB3dWcxeTJIK05PMVNjb3MyWms2NWJWL0tEUld0ZGcy?=
 =?utf-8?B?RDJTaGdUankxbXZTNEtYeVUvbGVvVVY1cDZUU1lUNFJlcDR5TzdCL01pc1F0?=
 =?utf-8?B?QkFPaE8vbVBUK24yOHY1ZG91WnlhWjBSY05Wb1hTT3FjclJYbzM3T2R0VUxh?=
 =?utf-8?B?ZU9uQzNlU2tLV3o1enczaHdqMjZ2THVOZjByWU0xUzliSkhmQnljUE9iMWhF?=
 =?utf-8?B?Z1lKbVJMSTI1ak5TOFRTdTd2eU1lRWdpYkZsUzdEQ0FjRm1mRXJPN2UwdTVh?=
 =?utf-8?B?cDFSUEVUbUVOVmFkY0FpU2dMTGdadWRzWGdFMDhyN3ora2kyb0swMGF5SmYy?=
 =?utf-8?B?elQxRGhBMHIyVzRTSnVpdmFmcm04eHI0SExUTnBXbTFjc0hYQTJ1alFLNXFm?=
 =?utf-8?B?K2FReHN1ZU1MVjlUenFVS0FSZS95cFBRbnoydnNYY0hrOEFSSmhMNzcyM09N?=
 =?utf-8?B?azhGeWF0YTAzWmQwaU92VzR2ckd5UUFkaXRaSExKanY3ZC96Q25QN1R5K01X?=
 =?utf-8?B?bHVYSFNNSitiQWJFckE4cFA1Mk9aYWN1RFhCdmxjRjdCTk9jM0JnSmk2UHov?=
 =?utf-8?B?aitIbldXd3ZVZ3BqS1k3NWM0b0VTZTlMM3FlZFFHRE5salMxSGdKUjlOMW1v?=
 =?utf-8?B?SnJuNXlXMDFpSGgrclRHengxdWx2QjU5SmVHNFptQU5SKzl6QURRcUlCQzAw?=
 =?utf-8?B?Yzd0OGx0a05vRVc5akpDRFpuVXdtUjBNMXlENzJ5UHJmcnVLTHBydDMxbllW?=
 =?utf-8?B?UGZkb3k2VXQxeTZQZnJMQlJmWkVrcHkzbVRtT1hnR3ZjYTJ2akVaOUdUWWZO?=
 =?utf-8?B?TldZT1lOd0E3Um1iaUdaS0k2dUxPVWVNZGQ1TExSdVdMOVhjcWtQSXBJRnlo?=
 =?utf-8?B?TUFhc2Rydmd4UndxNGh3SGQ3R215cWZzRGpZbUV5U21MazVSUml4M0dRSm5a?=
 =?utf-8?B?WEFsanFsWmxibzdBMWJocXNWSjRTMTFXQW9hcGxHTS90UkYwN2ZtQXNEb2k2?=
 =?utf-8?B?SUNwNHBlREpXOE5RaVd4NFRQZ2Q2YmJxQUhlazlDTzdZRldid2Y5QmJweU41?=
 =?utf-8?B?VytIQ0cvR1pjeEtkN1FlYlpYT3c1NitreGcxOUo3QVhxdGpyUUZkc2M5Y256?=
 =?utf-8?B?Yjhaei8zR2tRNzhmMDdzSkhDeVp6R1BxdFJvRHk4azF1Z3VzL1F2dHEyWGwy?=
 =?utf-8?B?eFFsNzJKazVnMDl4cGpWOW1COEtxZ3hzRkNmczV1Yy9Vc2tyaGx6Z0dqa2ZQ?=
 =?utf-8?B?cTVVZU1aRm9pUzY3Q1cyN2JxT3J0Rk9IY1RBaVJTblJMRkVwL2dMZnpXbDYv?=
 =?utf-8?B?MitHdnJLUGxXYUxTMlhrdEFKOElmSUhtcDFybGc4NnpPTHhkYldBZ21uU1g3?=
 =?utf-8?B?ZGl6RFp5M2ZrRS9XY0hzT1YySzFlRHo2dDAzQlk0ZjdhV3dDbUE5V0M3V09I?=
 =?utf-8?B?aDJLOVBMSWd2Vm1iM3lsdkt3Zk4veDR3Z3RzN2hQQmxBTGFHM1ljUWt3MUxj?=
 =?utf-8?B?bk9OQm1QUytDaTl2MXU3ZzA0YlpoTWloajhST2RtNGkvNis3T25MKytKblN2?=
 =?utf-8?B?dDZkTS9wMWlxd2YvZVRLMzgwOEtQZUx1U2tsNm9OK2FSTmFjSm5pa2R1WUtS?=
 =?utf-8?B?WlNaOUZTZzFqTXM1Rk5wNnlMZXJqZUdNRHlIOCtiNk90Z1RxRU1Bc2ZYUTVu?=
 =?utf-8?B?TzF6MXJHNVA5TTZJOHZyL2NCOEt3QitoSmFONG1oS2dTOUdWVWdPYm5kSE5k?=
 =?utf-8?B?OU5mMGd2RHdFTjVQTm1ybStvOGthbi9ZOW5PYjd4OUpJaVVyVzBLUDE5NkNW?=
 =?utf-8?B?OHB4U3FjakZjT04vL3dscGp0ZlRCaVNoMll5YU91QkhPZ1ZYbmk0OVZsWVJl?=
 =?utf-8?Q?HfmQKUeNm1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2VxTTQrOTFHc21DeWp5TEpuVlkwMERMa0NyTytvN2xRM0U5NXR0U0dDYzNl?=
 =?utf-8?B?Z3lqQTQwU3pWWlZxbTFIZTdDQWkvVDNUbkNFbDAwR3QrL1E2VXpLQWR6Rkln?=
 =?utf-8?B?K05hT1JGL1B6Z1dnYWExcXZWQ3ZnMjFkemJJMWJhSlczTGVsa1FvMkhoZ2py?=
 =?utf-8?B?Q2dxeWhkazBMVDIrSU5IRmk3TElzVklMbVYxcUNmdm9YeXpxcGJjZWhFWTFt?=
 =?utf-8?B?bGoxdktjWEU3N2MzU3FQbmh6LysxRkd6UjZ2cTk4VmlhMGo1TXYxMnZBQTVu?=
 =?utf-8?B?STY3SVZDTS9ha1FtRUJyK2JCbW10T2xWQmc3dkZpSzFSRnVJOVBnTE92YTVv?=
 =?utf-8?B?SmdwTjdhWWJRRzVFRWR6R0VlWnFYa0YxUkV5L0pQbEJHTmd0SXBBZWtHekpr?=
 =?utf-8?B?TzN0cmo1a2lRKzg5cFRYdk1EeGhFQTNSeXR6THlMdC9tYXovL2tneko5bDV6?=
 =?utf-8?B?ZFZaTU9GTkRTaC83anNBTDF4RldDNUZ5cmJzOHFqU1NDc2FaSkczMWpqSmxu?=
 =?utf-8?B?azU3R0VXV1o4ak9zSXhXUUkvd3FFMEJaOEdlT1M5cFJDUWxTM3F3VmcwNW1N?=
 =?utf-8?B?Sm1JYkh5NUdnNStKb3Bva2gwb3JNc1BHN2hlUkNlUDdETkxkeXJRUWxPM1lG?=
 =?utf-8?B?SG1lN3gvV2V2TG5LODJ2UGZNb0tlQ1RSRDFEcmFwYWtzTXFpRWZsbDNHVW9Q?=
 =?utf-8?B?UkRaUEN4eFg3Y1FhSFU0S0VVaHlzSkF1UDd0dzhGRkRHYUtXejVESGxZcHVy?=
 =?utf-8?B?eEgrTHc3cGNyU3hpTDdYN3FxaUtvdGUyWS9jcThmdHQ0WG5oWlRhdUgybTJ0?=
 =?utf-8?B?UGtrajZUUVhrWFFyamt0bXBtaWJ0RlpBSlAzVEsvanJkR0VJUzdoZ3ZBc0tq?=
 =?utf-8?B?UFd5V0gxRnUxRnhEekVCQXFxR25WY3ZxZzFISTM2N1BSZnh0Uy9hNmFWTEln?=
 =?utf-8?B?c2xYUjQrR1U1eTZUYlFmNmVCUlVtNVB3M3k2SkluSm1SS0h4YjRVZVdGNlpj?=
 =?utf-8?B?TFRoTmRPRlgraGUvRkwvUGV4OEVXOFJ2MDFrZ3IyaVhWNGVNUlZtYzRYTVNp?=
 =?utf-8?B?S1dRRXlZZ0JncXFkTVpqS0gycFpmQ1M0eXYycENwZ2VKaCtuT25JQjdRdlVN?=
 =?utf-8?B?Q2lmNzIvWURaT3BUOTBPOE9UL2tObTVHVW5ETXZaeXZvZFdlWFZhNmxVdjFW?=
 =?utf-8?B?TDM5UE9XeTlEUWUrdDFYSmM3RVh1L3NWTUVQaHFJSk4weDBqTFA1c0VUSito?=
 =?utf-8?B?dnE4T2tDVEVRSU1BT1JCeEFKRkpQdFNpMzVDcUZvUm5zcXpIdVRuTCtoN0g2?=
 =?utf-8?B?MHVhYVMvT2NNWURublFHQzlXMXhOMW1NNkVSODI4MnNrMWk2Ly84QlRvbkJM?=
 =?utf-8?B?bjFMdmdOUkI0WUpPTzUrdXpEbmlGd3JHTGxqbmVPcmEvTGJ2MFFoc2xkUTZT?=
 =?utf-8?B?SnhBR2lXSHdES21QYUQwQ2RUTi9ZQXlJUUxkbHdkejI5UkY5Qm1POEdNTHNy?=
 =?utf-8?B?cXJCd3MwQWNBVjd0dkNGTk12bmlXU0UyUDFwcEVuL2cxbTZSaDh3alRoazJG?=
 =?utf-8?B?dWpkZXZHRUFrYkNMRis3M0M3VktwSmNEUGtia1JlWHRVM1BSaGJyWFlrZzVm?=
 =?utf-8?B?UXFJOVhLNUZOak5MQmthRUdBK1JVUzNzVE9KKzN4SFZTQ3IyTElhMVhPOEls?=
 =?utf-8?B?K3Q5ZEZSQ29MNFRrR0JpMkp4elJ6NllSamluL0U3anFsOXR1NDV1KzdjMVJG?=
 =?utf-8?B?SE9NK2g3ZDdybFJxQzVlV0FQNmF1TFkvV2ZXTDhvckRBV0hBQmVZbDhEYllY?=
 =?utf-8?B?MktJMlh6aHdoWkRjRXdlblpTcktjV1YwM3h3b3NtY3RwZ0lvdG1odUVIak41?=
 =?utf-8?B?VHRnd01LVG5SNWNUU0ZSU2pFb1FaZmg0YVhFMlZtOWxyVGNoVUNFL3VyOGp1?=
 =?utf-8?B?YnN2SVBvclNxOXdQOHQ3ZVBLb0M4OVB3Vzh4NUpIZDg2TFJrZXlMSUg0bnNN?=
 =?utf-8?B?RVMvWW51eXo4bnBpdGsvRm9yQjc0VVN0M3RNZy9GcUI1K3VEaVlYR0I5MU9l?=
 =?utf-8?B?MlYwdmcxRlRKbVhOY0M0b2RWTTg5ODhuY2diMjBHeWFxOGdRUzhTUWJiNjJN?=
 =?utf-8?Q?XIsuoJvrcqrd305lckF6Vo2vQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	su58vpqFla2OS1W51+S1+37OOXUHGhar27QerwtFhFbkCYHV4x4YdPQEfJbD6wERezCZsorfKBbRESKU2/r49JM2mnCYLDW/XuVq2FhU5NjCJuyYeuiVv0StZK6obYJNjgwO5bHTjcD++CaZrpm2WnRv7dJUD57rItTgqTZpOcE+unaeKsUsWzef1uF6fSdgeA33nOI7GxMuf/kmWTeBeYvKSEO8IRm6M71U9OCu3nQhEWqIwqd53SMmFFEsi9tQfPwFy1N/Dk9mLQrvSbMUdsI/TFQlfpjQzjznMzqGGXGX4HJAi2hIq7p34eirh5VHiRmpiYWDWw6q9Adg+1rGGN1BslNFqLO9fKQIylzGxtuB7SPe8gg7/JwQGNXomll8C49KD0h3jFkX9fJGUc8X+wcOzczY+7zBdMGuE8JqxyM0IuIX4ZsrjjAoOHgaVA3Yf/9zXSxIvFem1KXCehD5A/k0BaSqh4ZwY5v5mVqi9KUF8IpQ/YH4KG1ZgFuxusZdTNYIQEmpB3s6frnFpeM9Dk7ddu2EYf8n12pkZlZSvrJuuF2ppV692c76JMFZC7+hoUnmQqtbPyQH856b0wAhP0wPickLJp5jZr5Kz27GMCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b796d321-5170-4588-d2ac-08dd9793c843
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:45:13.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0cQphk/mKUkxyyTm5B4Jb2i5dHnB/ADjIFfeXgDTa/+0gNNPzqZgDGUPYKmsV17/syq1Rorksu0G6J3c2Ca2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200095
X-Authority-Analysis: v=2.4 cv=RamQC0tv c=1 sm=1 tr=0 ts=682c6b4c b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=5zTSLU4TSuiTJRIIJkAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA5NSBTYWx0ZWRfX3syUN2WPpyPA xIL3nNaIAf554VN+0cJlX+iH8Nf04s7yycsx7C1NKx8IBLLCgZb6F+eQjldgXDl3y8Dp017KW1W +E6fTeyuIbbGWk7f6RBteMdQ2xxfLKzL6yfCr6E909FzEGsjLWeUFq1kgQE0+OwXbUvaGjizbMs
 1CB+gUHEe9qyya+uyDP5OuH1JxIsqz5vkwuwp6nP3xe+hNlrPzBuLQns1eDzoHJ5NWlhNwKdBbp +AEHV5Hr94yRkELlAlUEj53gJLVz1dZxYCPGt6xmusFlE/n6VJ5+rTUbchcu4RzHU4B1S+Oc2Ia hdohDNO1S52RalA9YXcjswQpZPqBxUJqi6B39jn1X+0XZsdCE97i+rpg1os3CvyubiwrIIpvuSV
 pbkmdy20XUpnAvKUN1eOzzn3/eCPXATdlcLe5LW2sUU+TrZzKaNutpEdo9r+aVbU0zBAzL1U
X-Proofpoint-ORIG-GUID: zojcK-3gCgMzjdGJqnLw1-wUBMIzgNvJ
X-Proofpoint-GUID: zojcK-3gCgMzjdGJqnLw1-wUBMIzgNvJ

On 16/5/25 18:39, Filipe Manana wrote:
> On Fri, May 16, 2025 at 4:58 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
> 
> So the subject should be updated, from
> 
> "btrfs: add prefix for the scrub error message"
> 
> to something like:
> 
> "btrfs: add prefix to scrub messages"
> 
> Since it's no longer a single message and it's no longer error messages only.
> 
> 
>> Below is the dmesg output for the failing scrub.
> 
> Which dmesg output? There isn't any in this change log, and for
> something so trivial and obvious to see in the code and diff, it's not
> needed either.
> 
>>   Since scrub messages are
>> prefixed with "scrub:", please add this to the missing error/warn/info as
> 
> The "please add" is weird in a change log, it sounds like you are
> asking for someone to do it, but you're doing it yourself.
> 
>> well. It helps dmesg grep for monitoring and debug.
> 
> Just say:
> 
> "
> Add a "scrub: " prefix to all messages logged by scrub so that it's
> easy to filter them from dmesg for analysis.
> "
> 
> It's a clear and short change log for such a trivial change, no need
> to complicate.
> 

My bad. Kind of missed to update the commitlog. Patch updated sent.

Thanks, Anand

> Thanks.
> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>>   Fix remaining scrub warn|info|erro missing the "scrub:" prefix (per David’s review, ty).
>>   Drop rb
>>   Drop Fixes:
>>   Update git commit log
>>
>>   fs/btrfs/ioctl.c |  3 ++-
>>   fs/btrfs/scrub.c | 53 +++++++++++++++++++++++++-----------------------
>>   2 files changed, 30 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index a498fe524c90..680a5fdf89c3 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -3142,7 +3142,8 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
>>                  return -EPERM;
>>
>>          if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>> -               btrfs_err(fs_info, "scrub is not supported on extent tree v2 yet");
>> +               btrfs_err(fs_info,
>> +                        "scrub: scrub not yet supported extent tree v2");
>>                  return -EINVAL;
>>          }
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index ed120621021b..558f0d249dcf 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -557,7 +557,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
>>           */
>>          for (i = 0; i < ipath->fspath->elem_cnt; ++i)
>>                  btrfs_warn_in_rcu(fs_info,
>> -"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
>> +"scrub: %s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
>>                                    swarn->errstr, swarn->logical,
>>                                    btrfs_dev_name(swarn->dev),
>>                                    swarn->physical,
>> @@ -571,7 +571,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
>>
>>   err:
>>          btrfs_warn_in_rcu(fs_info,
>> -                         "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu: path resolving failed with ret=%d",
>> +                         "scrub: %s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu: path resolving failed with ret=%d",
>>                            swarn->errstr, swarn->logical,
>>                            btrfs_dev_name(swarn->dev),
>>                            swarn->physical,
>> @@ -596,7 +596,8 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
>>
>>          /* Super block error, no need to search extent tree. */
>>          if (is_super) {
>> -               btrfs_warn_in_rcu(fs_info, "%s on device %s, physical %llu",
>> +               btrfs_warn_in_rcu(fs_info,
>> +                                 "scrub: %s on device %s, physical %llu",
>>                                    errstr, btrfs_dev_name(dev), physical);
>>                  return;
>>          }
>> @@ -631,14 +632,14 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
>>                                                        &ref_level);
>>                          if (ret < 0) {
>>                                  btrfs_warn(fs_info,
>> -                               "failed to resolve tree backref for logical %llu: %d",
>> -                                                 swarn.logical, ret);
>> +                  "scrub: failed to resolve tree backref for logical %llu: %d",
>> +                                          swarn.logical, ret);
>>                                  break;
>>                          }
>>                          if (ret > 0)
>>                                  break;
>>                          btrfs_warn_in_rcu(fs_info,
>> -"%s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
>> +"scrub: %s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
>>                                  errstr, swarn.logical, btrfs_dev_name(dev),
>>                                  swarn.physical, (ref_level ? "node" : "leaf"),
>>                                  ref_level, ref_root);
>> @@ -718,7 +719,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
>>                  scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
>>                  scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
>>                  btrfs_warn_rl(fs_info,
>> -               "tree block %llu mirror %u has bad bytenr, has %llu want %llu",
>> +         "scrub: tree block %llu mirror %u has bad bytenr, has %llu want %llu",
>>                                logical, stripe->mirror_num,
>>                                btrfs_stack_header_bytenr(header), logical);
>>                  return;
>> @@ -728,7 +729,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
>>                  scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
>>                  scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
>>                  btrfs_warn_rl(fs_info,
>> -               "tree block %llu mirror %u has bad fsid, has %pU want %pU",
>> +             "scrub: tree block %llu mirror %u has bad fsid, has %pU want %pU",
>>                                logical, stripe->mirror_num,
>>                                header->fsid, fs_info->fs_devices->fsid);
>>                  return;
>> @@ -738,7 +739,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
>>                  scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
>>                  scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
>>                  btrfs_warn_rl(fs_info,
>> -               "tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
>> +   "scrub: tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
>>                                logical, stripe->mirror_num,
>>                                header->chunk_tree_uuid, fs_info->chunk_tree_uuid);
>>                  return;
>> @@ -760,7 +761,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
>>                  scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
>>                  scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
>>                  btrfs_warn_rl(fs_info,
>> -               "tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
>> +"scrub: tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
>>                                logical, stripe->mirror_num,
>>                                CSUM_FMT_VALUE(fs_info->csum_size, on_disk_csum),
>>                                CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
>> @@ -771,7 +772,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
>>                  scrub_bitmap_set_meta_gen_error(stripe, sector_nr, sectors_per_tree);
>>                  scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
>>                  btrfs_warn_rl(fs_info,
>> -               "tree block %llu mirror %u has bad generation, has %llu want %llu",
>> +      "scrub: tree block %llu mirror %u has bad generation, has %llu want %llu",
>>                                logical, stripe->mirror_num,
>>                                btrfs_stack_header_generation(header),
>>                                stripe->sectors[sector_nr].generation);
>> @@ -814,7 +815,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
>>                   */
>>                  if (unlikely(sector_nr + sectors_per_tree > stripe->nr_sectors)) {
>>                          btrfs_warn_rl(fs_info,
>> -                       "tree block at %llu crosses stripe boundary %llu",
>> +                      "scrub: tree block at %llu crosses stripe boundary %llu",
>>                                        stripe->logical +
>>                                        (sector_nr << fs_info->sectorsize_bits),
>>                                        stripe->logical);
>> @@ -1046,12 +1047,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
>>                  if (repaired) {
>>                          if (dev) {
>>                                  btrfs_err_rl_in_rcu(fs_info,
>> -                       "fixed up error at logical %llu on dev %s physical %llu",
>> +               "scrub: fixed up error at logical %llu on dev %s physical %llu",
>>                                              stripe->logical, btrfs_dev_name(dev),
>>                                              physical);
>>                          } else {
>>                                  btrfs_err_rl_in_rcu(fs_info,
>> -                       "fixed up error at logical %llu on mirror %u",
>> +                          "scrub: fixed up error at logical %llu on mirror %u",
>>                                              stripe->logical, stripe->mirror_num);
>>                          }
>>                          continue;
>> @@ -1060,12 +1061,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
>>                  /* The remaining are all for unrepaired. */
>>                  if (dev) {
>>                          btrfs_err_rl_in_rcu(fs_info,
>> -       "unable to fixup (regular) error at logical %llu on dev %s physical %llu",
>> +"scrub: unable to fixup (regular) error at logical %llu on dev %s physical %llu",
>>                                              stripe->logical, btrfs_dev_name(dev),
>>                                              physical);
>>                  } else {
>>                          btrfs_err_rl_in_rcu(fs_info,
>> -       "unable to fixup (regular) error at logical %llu on mirror %u",
>> +         "scrub: unable to fixup (regular) error at logical %llu on mirror %u",
>>                                              stripe->logical, stripe->mirror_num);
>>                  }
>>
>> @@ -1594,7 +1595,7 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
>>                                                      sctx->write_pointer);
>>                  if (ret)
>>                          btrfs_err(fs_info,
>> -                                 "zoned: failed to recover write pointer");
>> +                              "scrub: zoned: failed to recover write pointer");
>>          }
>>          mutex_unlock(&sctx->wr_lock);
>>          btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
>> @@ -1658,7 +1659,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
>>          int ret;
>>
>>          if (unlikely(!extent_root || !csum_root)) {
>> -               btrfs_err(fs_info, "no valid extent or csum root for scrub");
>> +               btrfs_err(fs_info,
>> +                         "scrub: no valid extent or csum root found");
>>                  return -EUCLEAN;
>>          }
>>          memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
>> @@ -1907,7 +1909,7 @@ static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
>>                          struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
>>
>>                          btrfs_err(fs_info,
>> -                       "stripe %llu has unrepaired metadata sector at %llu",
>> +                   "scrub: stripe %llu has unrepaired metadata sector at %llu",
>>                                    stripe->logical,
>>                                    stripe->logical + (i << fs_info->sectorsize_bits));
>>                          return true;
>> @@ -2167,7 +2169,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
>>                  bitmap_and(&error, &error, &has_extent, stripe->nr_sectors);
>>                  if (!bitmap_empty(&error, stripe->nr_sectors)) {
>>                          btrfs_err(fs_info,
>> -"unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
>> +"scrub: unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
>>                                    full_stripe_start, i, stripe->nr_sectors,
>>                                    &error);
>>                          ret = -EIO;
>> @@ -2789,14 +2791,15 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>>                          ro_set = 0;
>>                  } else if (ret == -ETXTBSY) {
>>                          btrfs_warn(fs_info,
>> -                  "skipping scrub of block group %llu due to active swapfile",
>> +            "scrub: skipping scrub of block group %llu due to active swapfile",
>>                                     cache->start);
>>                          scrub_pause_off(fs_info);
>>                          ret = 0;
>>                          goto skip_unfreeze;
>>                  } else {
>>                          btrfs_warn(fs_info,
>> -                                  "failed setting block group ro: %d", ret);
>> +                                  "scrub: failed setting block group ro: %d",
>> +                                  ret);
>>                          btrfs_unfreeze_block_group(cache);
>>                          btrfs_put_block_group(cache);
>>                          scrub_pause_off(fs_info);
>> @@ -2898,13 +2901,13 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
>>          ret = btrfs_check_super_csum(fs_info, sb);
>>          if (ret != 0) {
>>                  btrfs_err_rl(fs_info,
>> -                       "super block at physical %llu devid %llu has bad csum",
>> +                 "scrub: super block at physical %llu devid %llu has bad csum",
>>                          physical, dev->devid);
>>                  return -EIO;
>>          }
>>          if (btrfs_super_generation(sb) != generation) {
>>                  btrfs_err_rl(fs_info,
>> -"super block at physical %llu devid %llu has bad generation %llu expect %llu",
>> +"scrub: super block at physical %llu devid %llu has bad generation %llu expect %llu",
>>                               physical, dev->devid,
>>                               btrfs_super_generation(sb), generation);
>>                  return -EUCLEAN;
>> @@ -3065,7 +3068,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
>>              !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
>>                  mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>>                  btrfs_err_in_rcu(fs_info,
>> -                       "scrub on devid %llu: filesystem on %s is not writable",
>> +                       "scrub: devid %llu: filesystem on %s is not writable",
>>                                   devid, btrfs_dev_name(dev));
>>                  ret = -EROFS;
>>                  goto out;
>> --
>> 2.49.0
>>
>>


