Return-Path: <linux-btrfs+bounces-5249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE58CD5E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625AD28280D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225213E032;
	Thu, 23 May 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebfdPQ/u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tLjEZeTO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDABD12B16E
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474944; cv=fail; b=suKxFKJhUqINfYPFdr6jOwUD2bQTsJbNrmyNDpEYb27fvz9fj4awVo7Fh74HWMIIPx8WiDktiibvjgK6BpND5zmeDIHKPKRIQNgC2lOr/go0nvR2UOIQU1aa+z8oK/E0AXLAxgu8VndijldcGlLDImXvYelMV9q+qlhPzO64TIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474944; c=relaxed/simple;
	bh=jfbsYPeTOH48D0gAEq/X0IWO1ynjf2XjPLV33BAp7zM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WLdxDTwkWxA1YWy/+99OC+ZzdQZHuRpKyyteF//JI6H0oIvGujGxQfF9q54+KSANzOtWhHSB2hOEWkTF58AxDUF4mtQrwn7ZnGDwgd6AgF/oev4iqPmIaISyphaht/IOowThyLPFcjOX12or+4jrSTq5SBBaCbQQR0VSAca9yw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebfdPQ/u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tLjEZeTO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NEYlsu010765;
	Thu, 23 May 2024 14:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hTBniN27HAUqNO0+cehdMi4Zcym7A0x9yr5JJcfD+B8=;
 b=ebfdPQ/uGPpoNBDTqkW7xjXFzkhA+FNJFF+rrCisZmRs/LjOnfEMl9jtTSuZJQf0xbOc
 VSuJmVAD3w1oxWknPdLVo6sYbh/NYiDEIBxJNuIQW3btDWuaWbxV4VLHcLKL8ZaI/GSS
 DMrDVdRn+hq4Ng4+0oRRHRlAPrVvLMQAyJrPJomTWV97vVXRu3S0lmkZVDh1OvawAJ3O
 rNEFiJsM0cBcSE8rNxP77yvLstSIbzWttGDEdDzzNCbSy7EYGHyN9fy2XbOv67N/jlDx
 vIT3BbyqKVD1OIi2JONYugOJOpcZx03Zd+AVjKdaWTvkEoDpzImyunjH+YhqEPuVEM6Y nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7b9xeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 14:35:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NDjfPv002667;
	Thu, 23 May 2024 14:35:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsamws6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 14:35:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHlwzzRwKTcQNng+rfwbI74b1snFqZ+7t5p+mQtggUvhn43AEaNm8VyqxoqWZtjG0tp47E1WU1ulD6yo4vanKcctq6EQKtW6fYuICIkCCb9XC+CjPJ1wndofa89Qz19FUQt+aA4ellPN8NLwE9ichuvSxPihmMhI0GsDhFIw8/3A5h72f4ejUhIreZhJXGHyc6mWHasar/bS6u0lh1YLAWU85xkU+CcG5iQKfqvNvPA05pW6S5Lk4SBhMvtm3BpY2T0i+rMILdlu0L3egz8efLKD1BO/uDVLGODGesaeiOdX7eVUbU6xvgNZlpMq5/m9eOXjfl5UX8QPPbx9OkazJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTBniN27HAUqNO0+cehdMi4Zcym7A0x9yr5JJcfD+B8=;
 b=I8/QkEILoK1j6FhV5tNtwtwth2JBPn2OKPnROQ+fWaFRkE/RWlor/L09lqFrk6Jo48AQtPhYnpSpYIjo1DTFpLxVHD+MAUzlY+K4/bED4SB2Oo0NyC4vRnxhlAy5qJt+DQ2n4blk5BfX/3JNVwCQuOHYh9XsfLCM5Yr3fWG46x5CLj34VkUhxGTTbLLU+evtEtthtIEkgbVWnKv4xPc33g9zHXbDZ0qd+WjDByl7Hea4WN9OcjQWInkiQJIm2acNjf6AcXsP5D9B2F21xBrL8srMY+i3hacbAUbx+X6leDho9SY1y7dPcIlI+KAFnLQy2ISK6+87v82tw5cAR2uRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTBniN27HAUqNO0+cehdMi4Zcym7A0x9yr5JJcfD+B8=;
 b=tLjEZeTOZkzNdH2CVcgRoTlJbqZeR+ZW+HqJ7ZggWns2XWcJ0qNYY7IYwQ2Ae4akbPuVzABd0k0uXBgzzwR13b9VBJ8mkTUWHkuSZw8q/AUFtCo5WfaHIu3BeLtMkKmFqH7IEGGDnMEG6knwMl4AbEVFMzuCrVQOpPRZUI6Wj+g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6113.namprd10.prod.outlook.com (2603:10b6:208:3b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 14:35:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 14:35:29 +0000
Message-ID: <0ea513f9-bfcd-4b31-91c6-810b59a8ecca@oracle.com>
Date: Thu, 23 May 2024 22:35:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] btrfs: rename and optimize return variable in
 btrfs_find_orphan_roots
Content-Language: en-GB
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1715783315.git.anand.jain@oracle.com>
 <7b9f87e3ca3368648e9df1d124161a6d4b8e1e9a.1715783315.git.anand.jain@oracle.com>
 <20240521151820.GP17126@twin.jikos.cz>
 <3c9cdd87-87ce-444e-a576-7e9626df04ca@oracle.com>
 <20240521175949.GS17126@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240521175949.GS17126@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c533a4-3867-4420-77e3-08dc7b359820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L0I4b2tGUFcvU3cyekVJZzJsWElnalMxbkRMbjYzSjYzTVpVckUzbnpxMFZW?=
 =?utf-8?B?amthOUlVR1kwWmMrMk53K1lEMGxpRG9saGVmMFNSRitzblB4K2h4d003RTdp?=
 =?utf-8?B?N3krZkRxaGlvaGJESjIzbENmTUtIMUNLS1FBL3R5VEd1TTFlL2IwTEhGTXZC?=
 =?utf-8?B?bWF4Ynl6bkEyUlc3SmlFdWZlemRvOGlUbHBqbXVyUVBieFpUVHREU0lQaDlt?=
 =?utf-8?B?TjJKRkR3bmVBK0Z6eGRweTltL01XZjYrVXl1S1krMHpaZEg5SmNyd3R4N0Nj?=
 =?utf-8?B?RGUrbE1PZ1paekhidFdENzF1UU9DayswRFFKTW4vWVdvM0IrckFzLzlENmsv?=
 =?utf-8?B?cWVWSEgyRXB4bWNsQWZ0M0gyRDBzS21ucjZLMHVYamhDbWRQMFVray9sTm1v?=
 =?utf-8?B?cHJLamdZbHZVc1NkKyt0UU80MzFIZWxyNjUwVnRndmRKUGhJZTdXZFdTL0Vv?=
 =?utf-8?B?Nnl2WGI0a200N3VOS2hnRlR4UU1kejZaYnFUYVZ3RHBOK1hqQzJGK2IzN0x3?=
 =?utf-8?B?MnFIcGZGUjczd0ZSZFlBT3E4bGN1S0o5UU55VlRseEMrd0pZN3BCdXIwNkdS?=
 =?utf-8?B?QlY0KzRLbitYVGVjREk3dWhIdnIyRStOYmg1NDVuZmxFUWZ2M2szS0pyR2JR?=
 =?utf-8?B?L0pWOVpwTm45TzF2LzhQRFA2SU53V2E3ZkFaU2ttT25jbTNlazAxQ3FMVHhH?=
 =?utf-8?B?dFNlb1oyemlqZmlKU0RlNXpEOWV0ZEZpQjFWRGQ3U1R0czVsVmdreEZTTUpP?=
 =?utf-8?B?b2doQXJuaE9Bcmp5UHY5RmpMdHVDNVNFdWZhUnYxL1pIYUQ5M09tRzBiSjNU?=
 =?utf-8?B?TWxLaDFNU2xUcjRPekwvT2RHemtBTnU1YVUweVZHZW5xN2QrZ1dLT1JhdXRT?=
 =?utf-8?B?dUVRaUtVc1AzTnhqNzBDbW5vSUxkMXJlVHU2eDBVN1NzeW5iQWFwZ0pGYnFY?=
 =?utf-8?B?R0lVbmhEckNtS2laREZzb3ZRc1o5SWw4cDNIKzlIVVlSUzR2WHZtd0Q0RGFu?=
 =?utf-8?B?MEZ1bk1IUHJ0UUN2V0VSd0lqSXQ4OGRjMnBBMTNhQ0FCSHVzSFlYc1dCZDc2?=
 =?utf-8?B?REdTZ3dXZXJGd2hRU3hqMDVVbVdmc3FWUk9zbzkzM0t0TkVkTXdLaHRmUXJr?=
 =?utf-8?B?OVl2YTlmeEZXY29xRFVaeHkzQUttTlMvbXJnV1p0VE5ieFdjbmhVMFNMSzNR?=
 =?utf-8?B?dDY1U0NjZUNKL1NiNC95d3lOTXRHT2tvcXBjTXh4MU1vM1VjK3FvWGNUeFRE?=
 =?utf-8?B?MVc1ck5XQ2NvRmRUMitvRmxDWWNRM0lIU05FRlhKRm9KSDBJRHpFSkowdUNr?=
 =?utf-8?B?RFM1UnlPNWJGZzNiOEFXaDlDMG4vTGYwU2Z4UzZMT09OM3RWbVRJdDVDTU9y?=
 =?utf-8?B?UUsvTDNQM1Z6QWRqeE1MeXpVeU0zZXp1VGFLaFJNOC93TzFTTE9GUWIrZXVL?=
 =?utf-8?B?cHFzVHV6c2l1blhkZGJtaGZCSmpXczk1Rjd6T1ZFSDR3S1lBN2lQTDlwdjJ1?=
 =?utf-8?B?dVNHbnIrbEQ4TFJWSmRXMG1HMTVWblBZbE9STW1STlR3bThtOFROS2dzdWhZ?=
 =?utf-8?B?eHVkQWozbXpkbDkyc2tuOUMrdUV3VHI5d2FwaFBjTytxbTBvck9pd0hYbGlD?=
 =?utf-8?B?ZFlWK29sajNHSWJjSXZxWWxDekdYTkcyWHovb3NJd1MyMkpUUStIeHd0M3Bp?=
 =?utf-8?B?Y3ZOaDR6MWUvNUJjK0dvM3ZHK244V3NvM2dCdk82MGVzcVRTMldmTlB3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?THkrUzgxbUpZeFRYeGtCdFJHUDZzcEQ2Y1Fqdmk1WUtJTjlWdEN5MnU2cFcr?=
 =?utf-8?B?TXQyeFRlYk9lUFRuZGNuS1g1bG5jeFgwUDlTalpFdlkvUW9JU09VcTZHcjJY?=
 =?utf-8?B?OTgzdmIzMEV5WlQzYzhlVCs4YVVmVm80K0JGM2R5cXVDd0cwSXVjUjFUbVRw?=
 =?utf-8?B?cDJPQVRNalV2bE1yYmQ3dkFlNnhSa0dmOVNybXpKZ21ya3N3a0tqVkJWbVpS?=
 =?utf-8?B?MXM2OGNQMTJNVDUrSXZwWEhTSEIzT3g0M0VtQjlWR215akNwOHRvS09KYTRH?=
 =?utf-8?B?SVRnUDY5dk92REJ2aHZVK3cvcVpDVHE0YlBnWkk2Y25tcU5lNFVUWVAxUHhW?=
 =?utf-8?B?THNnRlMrSW5UdHlVQlRleDhoUFdraDA2SVJXOXJUSElLMUIxSlZtR05wT09F?=
 =?utf-8?B?ZWxEeVVhR1hXek9WRzlyTU9mWjBrVEExN0t4VWdGajZPODAxZGFYb2lFQjY2?=
 =?utf-8?B?Y2NyNFVQOEVNMXdOQmowWXZCeHBNVURwVkE1ckJGZWVodnJzbnk1YXhnZGQw?=
 =?utf-8?B?enk4Q3hWL2lwOVZmOEVyUkpBR1NhR091N0RrNnRjUU1mT2NhdHN2U0dQYjhx?=
 =?utf-8?B?T2dFOGhrb215SVhrcG83ZGp5S3V6dUs2MDN4VXc2YnhEVFFJWFh4T2luVU9L?=
 =?utf-8?B?bEYrZnBBeHBsSklnSjhud2U5WEcyVG1iVXFKT1lnK0F4dkJlN3Rybi9uUGlO?=
 =?utf-8?B?cTg3dkdQcS95WGovSHlmOWJCNWlxdWNGMFR1T2hrVXRnVWNrc0RSMlRKcHYr?=
 =?utf-8?B?d2lVUnpXa2JjTjVuQ2Jla1JpSTBsNjJWSjVYbjNqdDhxdndHck44S2hSK2dL?=
 =?utf-8?B?MlVDYW1ZQW5KdWVxSFcyZnE0ZHBzamh3ZTN0N0d4SEI3cDErUGVsalQvNFcr?=
 =?utf-8?B?Q2NEVDJ4L2lCUVg3VkoxdmxHdmQwTDNYUTdUU01oVFduS1FJcnJhbDVjb25v?=
 =?utf-8?B?WDI5R1RKa0tISDE0OEdiaUhqcnNseGw2bGx6MVZVR0l6UE9rTndoTDlyOGRW?=
 =?utf-8?B?V2FvU1VXRGVySFZXWjlnb2U0WTZKVWRURUp2K1U2dHJlQXZwcXlJUTdDM0pI?=
 =?utf-8?B?aGw5S2gzSFRhWVprOHV0SXVZR2VOTTBqaXIxZ2pRek9QOC9ETi9SNGJ3YnQ0?=
 =?utf-8?B?aFdQc0tZeXBuamRJT2NpTFhqdHRrRGFBQy9iQXhCZnFrNTFJY3BuR2F5ZHV4?=
 =?utf-8?B?SHhNMmdENDFKSWlGOXliV1JXdms3bWpEQSt3VW1vNUVnL1NhNnkwZEtDdlRU?=
 =?utf-8?B?N1hFUmpOaERRK1lPME9kUnZPaEYvNHcyU21qWkovT2RMenhBbEtLRnNQR20v?=
 =?utf-8?B?YUUwcDIzSytIL0UwTEQ3TWJCcGNTVFM5M001bXNKVXlLY2R6Qk9SSUtXTmFl?=
 =?utf-8?B?OUM3ZnZVWkdla3ZoMHdZZ291enVLYVNIZnM3WTlBbnlUSEw4dzFIaDYrWCtu?=
 =?utf-8?B?dDQyTEhKTDRsbXBaRW9YV25Qc29EWFcrYTYvWGtFZC9QQXkyL2I4VmYvTEZo?=
 =?utf-8?B?djNwZERxVXBEdUo4QldrZEc5RFN2KzhEMWJucW1EZVprR3pxbjJIczR6TW80?=
 =?utf-8?B?OE84N2RwRXVjRlhMN0U0R0NrRklQakR4WmxsNTI0L1VzajNaanQ5cVlzUnpa?=
 =?utf-8?B?UjZOeFdLczJ5YWVZY2pJQWgzVzgxWi8zUFZ5L3BKcmlmaC9CTlkxZ1FKOHVz?=
 =?utf-8?B?SEdMcDgwS2cyc3BFYUhTeFJocDdCcEpGNnAydTlyVEFPZjZEVnJJcXB4VnBB?=
 =?utf-8?B?N0E2MnAxTWhWcXh6NVlHVXRxZkJUK0x6eUdZK25IbEF3OS9keXB0YzlhK1pX?=
 =?utf-8?B?bUV0TmRMdHVrV1FmenpML1hLRlJmMFdyTDNsVmpGaUdXd2JOOFRBR2ZCenhI?=
 =?utf-8?B?NGlsRTFaeGsvS3lrOGZCM2ozcVJLem9sbTNlbDBhNlNjWFdnb1o2SWEzNkdk?=
 =?utf-8?B?ZVVnc1lwYTU4Sm15VXhzdjFjdmszaE84SmNaNm01Ulp2U0t0ekVac1FqVDIr?=
 =?utf-8?B?c3BtakVqKy9yRnNLdFVaeGt2U1JmanQ1REtsV3ZKZlh3WjFkZVAvRC9HbmFq?=
 =?utf-8?B?a3BYdjFPVVV3eTlOWS9VNXJJRFYrSncwcFYwQ0RWODNVZ2xOK1B6cDU2dWNF?=
 =?utf-8?B?OTlJK0h5V2Z5bWxZbjk4ck1ZYWc4RE9ORzlza0JsTUtDQzdXUEhrRkVEZnNz?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8IYm5cYQ53U/+fbZ1pvnOdzdPHE92wZEOoGNwn9Onu08qo3UZr6JKCL8td8AWOUnso2BW0uLc++hZjGuWTZR+M9osZcIqtxcUZ3COQi3IfEEFDykvBmgY1EHyswSx8x0IP/yWp2yUj7I0QnPODnKbVRfd4rU2E7gxIAkFSxVqxfS574auwV9GRjb7Z+a4BvpN7BbAaKsVUG3Ij362XeNnMfUtin2mCiCCte03t6Ui0F5XA24utlxlkm7UbbFp8WKinjq+CBrrNvMWRXXy2kViX9MGPgSpIJ9YFa0ncTsz0h0/m69IJELOdE//VKSCR/JTKBMZH6E3TybqTx6aYpeucU1HznZNYpej4pkV0rci38qeKqOfsgannSyYIsgWz5dZI9gbADxJzcBHVCQcpQZLdYAuR/1mEEmqNZp1NU5lXD18r/qfIY+BJ9fMYYm7hchgrdSq9u1bwHmRqkkRwaT8AQlBLZS9ki5StctZ1QtwtL/3n9XnmtTn6BhRaZjgbE72Rt7KDKpsGzu8N7gC+Y1g7Lj6ZX7gZY50+6MSxw7q2miMEQW8xjppUPHfhki9LnNfEpEs0Eic2gvaeYy9bA+49UJJjSaZjnPNSjgLjeHqhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c533a4-3867-4420-77e3-08dc7b359820
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:35:29.8843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fHPQG+OLvFb326n4NHjRePZKaL4eIe+PV4eNQCnKp0YmaCZO1Qi5E2hleyFEALCLn/ajBNPyrYrKl5W8h3APA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_09,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230100
X-Proofpoint-ORIG-GUID: -wbEkpltYzwKgeY7TRsz0VJhGn6OgpYh
X-Proofpoint-GUID: -wbEkpltYzwKgeY7TRsz0VJhGn6OgpYh

On 22/05/2024 01:59, David Sterba wrote:
> On Wed, May 22, 2024 at 01:10:08AM +0800, Anand Jain wrote:
>>
>>
>> On 5/21/24 23:18, David Sterba wrote:
>>> On Thu, May 16, 2024 at 07:12:15PM +0800, Anand Jain wrote:
>>>> The variable err is the actual return value of this function, and the
>>>> variable ret is a helper variable for err, which actually is not
>>>> needed and can be handled just by err, which is renamed to ret.
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>> v3: drop ret2 as there is no need for it.
>>>> v2: n/a
>>>>    fs/btrfs/root-tree.c | 32 ++++++++++++++++----------------
>>>>    1 file changed, 16 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
>>>> index 33962671a96c..c11b0bccf513 100644
>>>> --- a/fs/btrfs/root-tree.c
>>>> +++ b/fs/btrfs/root-tree.c
>>>> @@ -220,8 +220,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>>>>    	struct btrfs_path *path;
>>>>    	struct btrfs_key key;
>>>>    	struct btrfs_root *root;
>>>> -	int err = 0;
>>>> -	int ret;
>>>> +	int ret = 0;
>>>>    
>>>>    	path = btrfs_alloc_path();
>>>>    	if (!path)
>>>> @@ -235,18 +234,19 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>>>>    		u64 root_objectid;
>>>>    
>>>>    		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
>>>> -		if (ret < 0) {
>>>> -			err = ret;
>>>> +		if (ret < 0)
>>>>    			break;
>>>> -		}
>>>> +		ret = 0;
>>>
>>> Should this be handled when ret > 0? This would be unexpected and
>>> probably means a corruption but simply overwriting the value does not
>>> seem right.
>>>
>>
>> Agreed.
>>
>> +               if (ret > 0)
>> +                       ret = 0;
>>
>> is much neater.
> 
> That's not what I meant. When btrfs_search_slot() returns 1 then the key
> was not found and could be inserted, path points to the slot. This is
> done in many other places, so in the orphan root lookup it should be
> also handled.

For the scenario where ret > 0 is good, we generally do varied tasks.
However, here we need to reassign ret = 0. Originally, err remained 0
and returned 0.

Or, my bad, I didn't understand which usual error handling pattern you 
are referring to.

Thanks, Anand



