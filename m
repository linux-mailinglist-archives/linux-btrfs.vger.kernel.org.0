Return-Path: <linux-btrfs+bounces-4212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA18A3F8A
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39055282181
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6245822B;
	Sat, 13 Apr 2024 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kXe1C01H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qZH0tNNB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC2249FE;
	Sat, 13 Apr 2024 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713050259; cv=fail; b=iaHtwq2xmkUp90h4pi6j4OpFg1NNn0ZAQr0JjO6FtwcVp/fG7Lk/bU+UliWLxpca/tdgN/VjuLSIjXuuiKGF7WtEgkT31HO/ARBtYquFMS3r1kxkTTlTV1n0g3atKpzNXhEo/ilUlUMgwTgbgudcsj8uW4j2MLovifAzj6HEkDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713050259; c=relaxed/simple;
	bh=CNf6l/h8lA43kw/21phiKFI9rSE/ThJZf3dVa612kEg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m0n52UXr2L/taYbgE+IZexl1sLfiknCqWi52VEAtlrHmplu9FcQg2cA2Kgp5WIlRWG1x27LIpRxZgCKY+AAlFy8883BZS6leBXDCyl3nQ0zu8/Hs+7Rsf+xsEHNi8pEDFqYVUJYp8K7BnMPIpaT9nbYacPxdcKadFwGhYsNOLqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kXe1C01H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qZH0tNNB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43DMfSwc003697;
	Sat, 13 Apr 2024 23:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TFscdUqeYLB7qKXtf3Na0N0oqri2dSyCuFk58Tjwq9M=;
 b=kXe1C01HfNBNxewbCBqLqIo9E7r9HodioVujvf5rZdOBETaXb1d78+8QKjoRJATL7MU4
 DDI8qyQS2sxlIYrK6M04GHCEnH1Zsnz4dvp8OfoaOH9gjQcQEHJaA1NeNv4nNu9yhut/
 +HOAeNC6kykMaFFxpSxikE1Z5MOQ9eJyKMwYpOCcdwsTgQF2GgEkfLYB2/n8z75yci+p
 ge1ZpD9KoAyngaABgI45LCadH4X15reDtNpgziAYxG5UWq790wY8OQVK2uqmBtYDQJfh
 Ntkl6thqqU4hkV0fLRF5iPiZq7dg7lW1gIxyhy9UU0Tz+n3eXl+PG4tQlDLtRkLDzfZn EA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgujgv8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Apr 2024 23:17:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43DMULiK013423;
	Sat, 13 Apr 2024 23:17:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg4ej6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Apr 2024 23:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6Vkf+emG4uU9Qzobdo1ewLOX3Z4UGAMjfj6qIo69ldCsrVIbyKhS24XmmcTv1KwpmspBUZDCKZUbXL38OmFIDwmb+E9ICzLnxeEbHNJzbOnHrItqd2iHK9F/hJ52k1I5sY7vHaSmE0Aw3Kfg4uO576/DAuyWUBc6sczOb/U2GtWqCoYMAeIgr6m/6ClsKf2I4ikyQ5/3TjGF+EQcxdzgAiGJqDSzJ8aczyV/n1tgCPtYTDSH2sprUXfWD/wij6jjkG+Blila3vUTCUZtjj0p2vc5ORddNDJ+xrUut4TSK+UWYq2/dzhdW9hiMghhoJwah9EyZzMKSMml2tQlZ6IfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFscdUqeYLB7qKXtf3Na0N0oqri2dSyCuFk58Tjwq9M=;
 b=cQGGjbmDVUhHxDJeGJGhIDxwdEsOqohZtaJrHA66q98w5R6ur+r8O9XWGCRBRQKCmlpDCXW6pR34yEW2epz/3wODFXXcOoVK1J7iaq+M53TK4nGU1tgXjNP4THrWJ3YcujV1zaZoOabUVdRNAAth6X2HcdpovQ6mM6HQNe31ekIFrR6tfferWB4hUOvX1h5ajzrjKaQCSWeH8nHOPj1LkIYf9cdqN8vgb3dZGGZw/BYXEEidF+NovbEDOjJAyNpYkBcn3u/RSbqme2orFrEAegD+ogeo1laBjBYLYijPYhDdlubcG/0A2mxwEMHXVsGqsvf/3I+rCiaffI2KSuGxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFscdUqeYLB7qKXtf3Na0N0oqri2dSyCuFk58Tjwq9M=;
 b=qZH0tNNBIQdrAN0f+7/Bx/byWSHrSspnScZPBlhCZvv3372gvW/BleTVsjz9o8On5srh9byXE59F4/eGoSDr1Bza47ryTHRLZwx2hNU5FIsjpJwm3hFRgEjTOSn4a65d6Q38LzxGJJoixb/1a8yKNoeywPPE5cM6CbaFd2U/s8Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6429.namprd10.prod.outlook.com (2603:10b6:a03:486::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.58; Sat, 13 Apr
 2024 23:17:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Sat, 13 Apr 2024
 23:17:25 +0000
Message-ID: <2e59bc14-cf41-4b89-8734-00cc69dcf776@oracle.com>
Date: Sun, 14 Apr 2024 07:17:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <703aa9f2e34bf4dcc1fc5eec7ef4f65a6705ff14.1712634550.git.anand.jain@oracle.com>
 <20240413194029.cqanjm6i4bdhaqdh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240413194029.cqanjm6i4bdhaqdh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: e4db6b0d-1d7f-45bd-3eac-08dc5c0fe159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lvJzfVzjA0taZvTZmrz38N75xWA0YPsVGN/cgEz96i/7cpqjD1TBEUszBgVdPkC0KYuzK/JtQJikpZKnudxmsQxS99GpwJrkyEEZV6jCaMJEkmYmhHXCm3AawDHJaETi2Zx2Wa2TW0kZQQ7Zr+xrOYxx605wM+IV6VMkKD904QebcSFnwz8g9aDy867LwMKIPZ3Pa+2UTftlGxfRVdpHF6+tJAih8dfw1hhIVVoEUQsqkCPek7wTTHm3/5nM/roWZt4PQ8yDaRqyuDiSX5DLRC2yqpcL3sWeaKjvZ/VY8dTkwAONpTgIk92wn4Wr4YpNSifThOvaE5Ic7b2KgfIAEAjOE+45M1wiKx7AqsrHN9Ir0PN+6brt0g+atFSncoaF/tH+OxEjSYDPrqTtU9jj9WMZrKlq2iqXWKThUpYCklM4O3WU2bQ+xHCjlWzuPaCZNy/8IdATqtOd+Jr0FxgAYUpmq1b1bVf8LHlEDuqcA1IQnnzxWrauvjlQe+dW/+FiP3Jlqxx/eqL2H56XT4h4EGknjsKtL2b2TpltiwK+rgsNHADtxq8pbFs61BdVkbThiZa+j7/qX2HmuSzPT+u6rKRfJL/wYvbEUVftbgkS49j+Kh1gO718+YslCY5BIq/TcepFkF5cWFAGEdopXHWsyyoXdmF/s0So4DJyJ+tq5So=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VytPcXNxT2l1Q1RKMHJaYmdPemkzUlA5ZlpHa0ZldVFrTGRGYUhoVWNOSnRH?=
 =?utf-8?B?QmRubXpiWWNncnV3NHBWNHhnYU8vd1FKKzIzVkFFcG84cEh0dmNBdUUxSzJZ?=
 =?utf-8?B?bFcyRHJUSkRTMk5XVURGWjBScXh4UVhDM2JPbllSTFpoOVVKUkxES3VRU0gy?=
 =?utf-8?B?eGFRblBxMGxJaG54Z3Q4MkMyR2g5QWVvRjdjcTIrWG1ESkU2VG5xYWQ1WFVt?=
 =?utf-8?B?N0JOVXE0UEVabGYxTGc4QmVmdnM5Z0oxY3RNM3NKNWZGRzJTR28xWDFhSU0w?=
 =?utf-8?B?aW0wd0RsSS9VcXBWMzVDemVuYkFQdStMd0U0VnJjWXVVMFNTc0VvWWE0TzF1?=
 =?utf-8?B?Z0tuVitrYmhmcktVSTBmT1Fld1hGbWxvVXlnVmc2V0lOejIxMFdYME51L2Ey?=
 =?utf-8?B?aDh4ekxvQ3N1Zlg1THd0YlpHQ1ZFZUhmVjEwUzJObllwVXJhcWtERGE1Z0J6?=
 =?utf-8?B?SmNjcVlsM0ZlM1NrQUV3bVJRc2N0b3FzTFUvemwzeE5XcFVtWSt5ZjZUdkNZ?=
 =?utf-8?B?eit3V0JIcTVIN0dPbWRXQWpKTzFJUGJxZ2hCNEpJeGlDdG1Ycm1OaStjSHBj?=
 =?utf-8?B?bitNOG44dVRJdHo1cnlVQlFrZThSS1lIcDJYS2NqWTIrMnNKNmh6NUFMbGs4?=
 =?utf-8?B?NGdQTGdPaGpjZ1N4WUp1MEhuTE9NSExQV0hhVXBuRHNnK2tZbi9PbndDSkFm?=
 =?utf-8?B?enZGVEdXQmdYTTNvQVVKUkt4aWFCUWdLcUtkalhZWXRNQlE5YmtLcXRjazZQ?=
 =?utf-8?B?Zm9nRkg1TEliS3Jqb09IRFluaDFwYXV3czdRTEVsSWVBelV3RUdjME5zNG9u?=
 =?utf-8?B?MWJjS0RrTjFBK3RFVDZ5ZmxJM0N6QmNvNXBzU1BvNm1xUE81UlRqREFYajc4?=
 =?utf-8?B?OUZnamx0STVQc3dFSGJkN21LcTVZWlBqdVhiMFJWOVBFczZoNjFhVnM4N0M5?=
 =?utf-8?B?WFd6dVBwVlk4QWxjR01iVTNFVndqR08rdm1kZ2E4UG1GQll5ZWN4V1IxZDRw?=
 =?utf-8?B?Z2JpbCt3VjMrNTVqMnBNalo3SlRNT0VPZHFlM203a09mVS9vVVQ4dk82Vmlq?=
 =?utf-8?B?Q2ExZnJGbEh0VHF0ZEFvbEQ5dW4zL0xnQW5nN3RHRUpOZXNRM24rQXV4dWRH?=
 =?utf-8?B?eGlJVkM3TU4zYmpNaUlNa1VGSHA2Mm5Bc2w5T3hhTGIyVHo1b3VpZ1B3ak12?=
 =?utf-8?B?S0RtUjBJNUF2MzFDeTJ1Z1Q5Yys1N2xFVTE0ZU9pbWpQdnNPbEs1VXdaS0VW?=
 =?utf-8?B?YmhVVWJYK1djNEJtWExZVmlQaHoyVGdGcG9rVjdnWUdtVWY0NTQ1QVZSM2hZ?=
 =?utf-8?B?SzM5ZUxLalVhbHFMeHZKOG9UZWRVNGpYd0I3aUNxbXE2ZEVxR2JvbGVxQWE3?=
 =?utf-8?B?Z24xcFYra29pY0VFK20rMXdMcERZbVFsSmNuc2M3L1hVSmRVbERlS0d2TVlh?=
 =?utf-8?B?NlpFL2NhemwrNms3Y29VaS9PVENVSm5LaFppckRsSmdHWDVNbjJsSDliMW9v?=
 =?utf-8?B?N1RUbUlGUXMzMGZOZVNLL25JUTlKTGtUdU92MnZLL0sybEh5OWN1RVJvVjEw?=
 =?utf-8?B?UHpXektkaGh3b21RVkF1d2owWGxRYmYzelNhWFdocE1VSjlwS0xhR2JxVlJY?=
 =?utf-8?B?alZZUjhVbzQxck5ubkQ3bHgwa3J2S1gwZitRNHJib1BZbnFEaFZJU0VUY2xs?=
 =?utf-8?B?MXlMNVVwR0ZwU0xLN0w0WW4wSURyelJUTWUyZllUTlBuNFdVaUJwWUtNVENL?=
 =?utf-8?B?cjVOZmtIcE9QM2RqaDlhMnJPV2dpZnZVZlhCMmNrWmRDNDN0VldyOVVaZ0VB?=
 =?utf-8?B?YmJXWElCWnJYcjZRbUFkQUJ4a0RVSDloYyszRkVGeGdEVXFLZzVjWDE3NEpB?=
 =?utf-8?B?MzBpTGRvWTdTcGFBaFMyck9WejNwTTNiM1JHYUF1RTNBcHFGa2UzWTltcDht?=
 =?utf-8?B?dXVhZXRtQzRKZCtjZDZ0TFJpUEJzdnFXR3NPbGk5ZHlLQloxcFRwK0Fvb3NO?=
 =?utf-8?B?L1V4d2QzWWVXek9OWGVrV3gzRlV6TE8zalpwck5PUkovZVFsWnh5bzdHVkRM?=
 =?utf-8?B?UXVpam5SZ1g4Qko2UTJrQWhNajltQ2w4MkdTSEgzSlJTaTRoN3I1QS9tOCtp?=
 =?utf-8?B?ZTJqV3JhWXZQdFJkRG5sRU9tR1NSTWYxT1VTZFJ5czhPTjNadkRBaHhpWFk2?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5viW04FW24ss7Js4zEQozDp1xK+syv2rivs4eo6thT9CFZCitN3Iv2DRjHIqUpxafhY3+S8IHVe2r+AyXzKxFymij68CGgb7tIirHPo4g70LYtonR1s4QLfrzgv3BOoMvx9yO6sXRf5TyzBlP0/wQ4LAcmpHLxqiD4dhggfr7ULdzzsv95S1KZhlrISfyQm2LgGcv9mfc6T5iycRg5L1CD62FAAp7lhiDhX2sQv20CboMfJ/geIoshnEVypYcuFcPidq5Y7RMle1alotnUhEJIw0z6jL3h6bLSHF9J/+nTtSHdX6M0dFImAQI/QF+LSnzo/DIul2UOyguB9if/e3GHotrsZO/UxNrd3oBR4fAMcknhuFLtpSY+I2PeXa/28GTzsXTbL/k0uDemvJPNZHf2PJap4eKJsovLiNsurWZgbyi0PXF7O8DninlX1BGqYAM3WDB3IcSdWnVsNGCjoe2Vf+AjuOkhBvydDV85SZVDUMn6TCjMRZqnIEgRCq82XgJBHtehC5qk/HLqBkwhUyxotX/EatB8KqhRSkz6sxQRrEku/ch58oYHe378mGAQxKQvISrJ6BABEcmtyD3QBP0F0iMmplnEs1SPUyCudHpYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4db6b0d-1d7f-45bd-3eac-08dc5c0fe159
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 23:17:25.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrEvFJxiZN0I1OfR/NZC0DX1FCEOTgwwFyVr5cMg/F2IuESRMW80f7yVdJQQx+Hy52ksDk02y43sGOwTo1kqXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404130174
X-Proofpoint-ORIG-GUID: BLVkz36nRNAYd9ESj1E90rC2d99n-MS5
X-Proofpoint-GUID: BLVkz36nRNAYd9ESj1E90rC2d99n-MS5

On 4/14/24 03:40, Zorro Lang wrote:
> On Tue, Apr 09, 2024 at 11:51:11AM +0800, Anand Jain wrote:
>> Use SCRATCH_DEV_NAME[n] to provide the device path for each device from
>> the scratch device pool. Also, in btrfs/197, remove common/filter since
>> it calls common/filter.btrfs.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> There are other test cases that potentially could use SCRATCH_DEV_NAME,
>> but for now, only 3 of those are being fixed.
> 
> Hi Anand,
> 
> This patch can't be merged, failed as:
>    Applying: btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
>    error: patch failed: tests/btrfs/197:55
>    error: tests/btrfs/197: patch does not apply
>    error: patch failed: tests/btrfs/198:40
>    error: tests/btrfs/198: patch does not apply
>    Patch failed at 0001 btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
> 
> I'll leave this patch to your next PR, please check and rebase it properly.
> 

Sure. This patch is on top of the patch-set below, which is in my 
upcoming PR.
  [PATCH v2 0/3] fstests: various RAID56 related fixes for btrfs


Thanks, Anand

> Thanks,
> Zorro
> 
>>
>>   tests/btrfs/125 |  6 +++---
>>   tests/btrfs/197 | 13 +++++--------
>>   tests/btrfs/198 | 12 +++++-------
>>   3 files changed, 13 insertions(+), 18 deletions(-)
>>
>> diff --git a/tests/btrfs/125 b/tests/btrfs/125
>> index d957c13911b4..f742d14f858c 100755
>> --- a/tests/btrfs/125
>> +++ b/tests/btrfs/125
>> @@ -45,9 +45,9 @@ _require_btrfs_raid_type raid5
>>   
>>   _scratch_dev_pool_get 3
>>   
>> -dev1=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
>> -dev2=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
>> -dev3=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}'`
>> +dev1=${SCRATCH_DEV_NAME[0]}
>> +dev2=${SCRATCH_DEV_NAME[1]}
>> +dev3=${SCRATCH_DEV_NAME[2]}
>>   
>>   echo dev1=$dev1 >> $seqres.full
>>   echo dev2=$dev2 >> $seqres.full
>> diff --git a/tests/btrfs/197 b/tests/btrfs/197
>> index 9ec4e9f052ba..196110cbdad2 100755
>> --- a/tests/btrfs/197
>> +++ b/tests/btrfs/197
>> @@ -22,7 +22,6 @@ _cleanup()
>>   }
>>   
>>   # Import common functions.
>> -. ./common/filter
>>   . ./common/filter.btrfs
>>   
>>   # real QA test starts here
>> @@ -55,24 +54,22 @@ workout()
>>   	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
>>   							_fail "mkfs failed"
>>   
>> -	# Make device_1 an alien btrfs device for the raid created above by
>> +	# Make device # 2 an alien btrfs device for the raid created above by
>>   	# adding it to the $TEST_DIR/$seq.mnt
>>   
>>   	# don't test with the first device as auto fs check (_check_scratch_fs)
>>   	# picks the first device
>> -	device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
>> -	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt" >> \
>> +	$BTRFS_UTIL_PROG device add -f "${SCRATCH_DEV_NAME[1]}" "$TEST_DIR/$seq.mnt" >> \
>>   		$seqres.full
>>   
>> -	device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
>> -	_mount -o degraded $device_2 $SCRATCH_MNT
>> +	_mount -o degraded ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
>>   	# Check if missing device is reported as in the .out
>>   	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>>   		_filter_btrfs_filesystem_show > $tmp.output 2>&1
>>   	cat $tmp.output >> $seqres.full
>> -	grep -q "$device_1" $tmp.output && _fail "found stale device"
>> +	grep -q "${SCRATCH_DEV_NAME[1]}" $tmp.output && _fail "found stale device"
>>   
>> -	$BTRFS_UTIL_PROG device remove "$device_1" "$TEST_DIR/$seq.mnt"
>> +	$BTRFS_UTIL_PROG device remove "${SCRATCH_DEV_NAME[1]}" "$TEST_DIR/$seq.mnt"
>>   	$UMOUNT_PROG $TEST_DIR/$seq.mnt
>>   	_scratch_unmount
>>   	_spare_dev_put
>> diff --git a/tests/btrfs/198 b/tests/btrfs/198
>> index c5a8f39217d3..ad43b4d1b59b 100755
>> --- a/tests/btrfs/198
>> +++ b/tests/btrfs/198
>> @@ -40,21 +40,19 @@ workout()
>>   	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
>>   							_fail "mkfs failed"
>>   
>> -	# Make device_1 a free btrfs device for the raid created above by
>> -	# clearing its superblock
>> +	# Make ${SCRATCH_DEV_NAME[1]} a free btrfs device for the raid created
>> +	# above by clearing its superblock
>>   
>>   	# don't test with the first device as auto fs check (_check_scratch_fs)
>>   	# picks the first device
>> -	device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
>> -	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1
>> +	$WIPEFS_PROG -a ${SCRATCH_DEV_NAME[1]} >> $seqres.full 2>&1
>>   
>> -	device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
>> -	_mount -o degraded $device_2 $SCRATCH_MNT
>> +	_mount -o degraded ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
>>   	# Check if missing device is reported as in the 196.out
>>   	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>>   		_filter_btrfs_filesystem_show > $tmp.output 2>&1
>>   	cat $tmp.output >> $seqres.full
>> -	grep -q "$device_1" $tmp.output && _fail "found stale device"
>> +	grep -q "${SCRATCH_DEV_NAME[1]}" $tmp.output && _fail "found stale device"
>>   
>>   	_scratch_unmount
>>   	_scratch_dev_pool_put
>> -- 
>> 2.39.3
>>
>>
> 


