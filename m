Return-Path: <linux-btrfs+bounces-3715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383E788FBBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2CC1F278BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3FB64CF7;
	Thu, 28 Mar 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KMnBwtK4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MaYMAP+R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B118E1E;
	Thu, 28 Mar 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618527; cv=fail; b=Gej5YmKlEAC5WayZNgKS7ukLNTzfwqkVttshW7thxSBHEsKzcQb1du+4PoFRfQ1yzqWleL2kjWNYk2JAU1AzJG6AJpXjA2fj2LBIEvd9iTCx4Bf+sOPeU2YMgpGByZpXFmmAyEUGkhTTSipFl12C3aiCLyFViTaTdbSHNOVez3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618527; c=relaxed/simple;
	bh=wzNOAP/t7SJisQ2hOExANyvlhEJv62VEzvXuUMLuLEU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lajOMzjutAG4EhDAd8RRIdbiHoccIL4zOsW5RsVDPj/FhWLjs8wsdwuPZUpcHSacyQFaU5zhR9P8a1Ilj9klr/FSlGIAP99RFn29HkPc0iSMJWBc9fAO93crjnfqFRK5WALd5CMZGOQccBJAl6GwLrtTFlTTokZmb3/MYX5Ip2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KMnBwtK4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MaYMAP+R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S8x22Q025120;
	Thu, 28 Mar 2024 09:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gQAVDopl18PRA4QiLhV2FrEvPpul/K1y6wdRqtnG3iM=;
 b=KMnBwtK4IZJw11boDYEQR2H0jUb1Gq9Yw/qkoreBJn1S3ia/YW4OBY3Q9VuHSyFPdQzJ
 onvcHWid0/xZpZsWadp1EGvUmajkFt9SIgz2mRA7LUt0/+gcMxvgztRCe58w2zHFqD2z
 FIhgnBVc71Su/RpdYiRc5mRk/Vg2w+sU8wyie7zs9qPpMolLm6YPoW53YIXiHeF0UP+r
 rFfm5++wgfgnqTYLfsr5REzVRLlKAdFGr+3t+o8MIpQIHBNwpPgcmEJNPD94gZ44PCHX
 mxFo0N7loz1QJdJKPSV2ZCZiZv+KQlS8V6XQCizKeGH7Y+LlnFBQ7ARoAiblVPcdB/0k Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x4cxy2r0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:35:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S924Dl012873;
	Thu, 28 Mar 2024 09:35:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9q0qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mki6J/hBJMDPR4+X4yeRPSj5h7ha9ljKikVLWo02EneegcoNDKtlujGGkaeYakkqIpPNfNVda2T6lAlZbZSbik9leg8ueLVSrDtnr96GJpa8VIj8KoRcVACIdPlYxZYVcrEIGWnr1ZzAP4IPPcjwqauqab/dAEHQ50y9HIbkMvgO2f4LKgu0DcINvU4Grs99VeI31M1s2UyA75xAjFNAn4EkorJ58LwQ36oLJxuR3VOLy4k5PyyvxSE129Vir9p5IBAChLwd/Y7VBTPYkt+F3pbrtGGSkA7W9+r1spbxWzcRmTjm3Ba/6vDzljBp7YZP+emB7U6jYQVOf8rK/6E9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQAVDopl18PRA4QiLhV2FrEvPpul/K1y6wdRqtnG3iM=;
 b=AymoNv4X3fJRgsH8ah2K0BnbMDoI3XPzk+AdtoVDi1I8Waw8Zb672sxM1+YQAVoJkBmcapXCZRzjTUv3mtpuM3TljZiUHZXfpErlcGRg64gxHJ6YTFwQZdxbINq+aX51FLukd0XDmLJp8zgBWL+Nm0NdXIKMyMhFayYy9cFsF4Uu6T6kIcksBmk1ERwSJuzaZUCDiyCTUiKjma7wPCUaUURjkOwN39g7FVZQ3kO22KBu3lKGPJVbLv+TjxKlvILUQoZDOPOc0PrqHXjGuVhmy27r+z8MK+PdcYhbxS81+P1i6p43aQ8QP2fnHGwGupPn5d+8yMAPBYZSwarTGozfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQAVDopl18PRA4QiLhV2FrEvPpul/K1y6wdRqtnG3iM=;
 b=MaYMAP+R/NM/FocrfFJEc499k3Ofayx9yO4n51Fw7ifXy1qpbsZndGZbihMSvCzy3pYGAYeVhayI83Rnb4mCz1FYglFe1Nqa0BPXMsjt3O5G5LplBAZ7twghbEhUNxjBoWjf4D2MlV+bMxQiyJZcTnZUhWX/43mo+n7N8J+Vf+Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7220.namprd10.prod.outlook.com (2603:10b6:930:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 09:35:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:35:15 +0000
Message-ID: <2c3964c7-9123-441c-8bf6-eab0315e2a26@oracle.com>
Date: Thu, 28 Mar 2024 17:35:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] btrfs: add helper to kill background process
 running _btrfs_stress_replace
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <3334980dc99188a6742b28ba813268221d20a3b4.1711558345.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3334980dc99188a6742b28ba813268221d20a3b4.1711558345.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0089.apcprd03.prod.outlook.com
 (2603:1096:4:7c::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 1144d8fb-fefc-4fc5-a58c-08dc4f0a5f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	w1wQ3dpVkrYi2xXNe50lw34IMsWSv0NYTvnn+xYtGucvwd2a6dhNLcYKJsatUWxltfpsKzjLyiHIWLney39MwPwQf9ZZyJ7Qnat3c03kb6m0cW6H6IJLqWMFvJfrpYTotBlvkqMbKNkc+DdMF+jRpYJxxyCAaPsQxDwfkPrEDbyIrp2mlSbWdj/hLPvbfgSBQ1I8SguAfk2C2LNEhrjAT5WyIEu1PfO2gZ9EOkcXk5OiUSLMTi6vDis/77C3Hg1KU1QP4xbCJuzn8IqS99+d8CYu2Kj3RwA8P6kT57ZATySCnlewUne2IDvW0r1h5WNfVnbwmtYgNBHUjAw7K0a3FKnms3ZqG6f1BIVpGGjXvC3SNlYtCMi7j5xqYvNPCHThb382WQmzdCAHr7+9TZa84+17S4n42Y4wH/j0PYXAacU9dS0seJS7iaVHLXccg/JXaS+HF4Rm/Wn+cvixj2QDz0i0sMxx2C/VluSnw82sKHIFH0M+Oi0SyUZ5sBsb86lU456K+AgBd7A663KjLQ0x0AiDV5M01XzbdqmKGH8YTjNsmXfLyhAOWxTaY17BPcG/aFWu080egO8XO6I1VSbK5oZCL+IicmBMS+byllgUUfk3b4g15Klx1Rw/rBWhCY+rwBsWjkuJLdgHzxWLExcm5F4jon0FGkxB80IvxUbzjd8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QTB1MFB1MEJESzYyWXM5b2JPZC9jaVBqRnJ3ZEZVdGZqd0RzYlpMejYxL0Y3?=
 =?utf-8?B?K2FhdUtnaHkxUkxkaGZxTDN4RDlhUGdQVnczSWZ3ZlNGUmk3Vmpjd3JUWkFO?=
 =?utf-8?B?ZEYzd1VhcFZUbXlUWWx6d2ZnUWtWRG1WZ1NRbmdLTXFZS2hLS1EzMGEreFFX?=
 =?utf-8?B?VFhkUGM2TWZyVCtXY2pRTmJKZ2NrTk1sRThYWmQyNzB4WUMyL0hwUUsvQ25Y?=
 =?utf-8?B?U2NNWGVhVnJuMWlxajhHOUVOVldvZ1lmNmx2YUJ1Qm9aTUhUWDBnNmcwcUxL?=
 =?utf-8?B?RDdCQlkweUNiWWwvSVBsQmJST2taZ1ZsVWZwbk9PNUhvNVZTa1U3YktVUmI5?=
 =?utf-8?B?emNOc0oyS0NOV08vNHlpM2R2emRVa2htalZJZkRLekExWVdNU1p1YUY3c1E5?=
 =?utf-8?B?Y1h1blFNVjJaM3JXbDlNK0dNZzhndGNzaVY4Wmc5RTBsSG5VbFBsU01jMmN6?=
 =?utf-8?B?TXJqUWRZaHA3QlBERXNHbU4zQmpyVFloZ2tVU2pVV3ZOaC8vb2NLSno5YS9F?=
 =?utf-8?B?eVpTL2Q4WkxmYjZuVVRSZlpKSFZtd3orOEtjNDJPcVBMRkR1MmdxMHZEazNG?=
 =?utf-8?B?dDh3VnhKSzgybm5HZlBIRENpbG1RRzZUM3UxUzFZWFpkYVU4V0hPendESXFH?=
 =?utf-8?B?ZGlZTGVwK08vK0FKWldsK2tDeXJYWDJqbjBwM2kxV2FJMTBKRTRKdnNKb1My?=
 =?utf-8?B?VFZpcFQvUU4zYmxWemxXZTdQTUVHRGNxbVkva1h2T1VranVYUGlxUEVTOG5h?=
 =?utf-8?B?MWpucnZ5OXpKeFRnSmpIeXdYT1JFbUVyNnhaREkzNjVXRGdRMkxtOURpWUpX?=
 =?utf-8?B?VEdzV0NkS2dvYXprSno3dWRJbFpLTENrSURHbGMranJPdlQvcTJ1aGlLOElO?=
 =?utf-8?B?R2kwNFM3VXFiU05OSXdLeWptNms3Q21sRlczeU5rNG52NXdPZlpEQnY0ZFZF?=
 =?utf-8?B?QmZwNnhQeFpFOUJUNFRPRXExbUVxYTFkblUwWkxYSkFnNW83UlNZQnJncjlO?=
 =?utf-8?B?VlFnU05SNTM0QmpwcWhPMkdDZWtodFdvUzE4eXVVNHhZZTZHc2hFNk5pZzds?=
 =?utf-8?B?bXhWWGJ4TklqaEZBTnAwL3YzdXJJcXZMc0pLRVFNd0tPWTJLZ05ta1NjTXlG?=
 =?utf-8?B?cXk4bk5BUitFcC9PQkQzTzZLUldmQm1IRlNkbEF4a0R1bGxvb1lWWit6SWJR?=
 =?utf-8?B?QnJORzNKSWNWMXA2NXR3OEJSSVl3a0paejhHcktUd2RpdlB4M2N0ZFhMYWt6?=
 =?utf-8?B?THF1UGhQOHdXVGlWdGpTOEg0cDRHUXFLNC9qYWNFamVqRDl6azdMQzAzK2FW?=
 =?utf-8?B?eVFZWWl2TDVNM1hXK0NJdnlHNmliTWFZc0NHN1RwVnRPMHJwMnhKdzdaSGdH?=
 =?utf-8?B?TGJxbHZhMUZ1bXM0RHRmMU5GOW1ralNSdjBISHNYU3RZR2IwK0lLMWJZU241?=
 =?utf-8?B?UC9PS212RnlWZlZpTElmMzUxdWpUbDFUTHhRQVVhTWE1N1BobnVvQUpJcEZD?=
 =?utf-8?B?WXhpQzFhUDFtMCt0d1FqcWhZNVJFMG8rVTg0UXlEVWpwK0lOTURhbFNLUXA2?=
 =?utf-8?B?M0MyOXlDeElHOFpxK2YxMzVTbkJKRldzUWhPTVFSQ0F2MC9JMUo0Z29yYTFr?=
 =?utf-8?B?ek9SOEE2eWd2VkVycmFmVkQwZVU5ak9HdlJkeDNlMkEzQ1ljSExEb2Rjc0Ry?=
 =?utf-8?B?OTdJTWk1cVFnKzlzcExnWUhFZkh3bWE1ZXRTUFhBbUQraWdFR0VDbUxmVjJD?=
 =?utf-8?B?azJvNDlqMjFEb2hLTXJ5amR6dmdtbXo3aVN4WGRIbXU4YUQxR3lQWUVIbERU?=
 =?utf-8?B?SjF4eFl1V3Yrb2RsNUZ6UmxiT1pHS1p4aEdBeEJXcWNoRk5sZFU0RnFhV29p?=
 =?utf-8?B?RXRNZW5OcFBtSjlISkgvdDZ0NTNxbDRLSGhKRy9mWU51bS8rVmxTN0lGK2Zt?=
 =?utf-8?B?UHkwMXpvU3lKbStjSElJZWNDMnFrK2lTaDg5dEhnSTg4Umt4ZFJHajlCM1dv?=
 =?utf-8?B?Y3Vob01oM05GZ0s0K1phWHVPOHZiWVJnblo2TjkzR21LWnVzeWZ5c2krUkFP?=
 =?utf-8?B?NEp6TFh2RHlZVTBuQ0FGNTRsbUY4NENFUVdRR0QzQ2JpbkcwOGo0Y3pZWHFm?=
 =?utf-8?B?QVh6VUhDYmFvNkdTS3pDYVhSQU5IcUlGcnEwNWVrK2d5em5BUEFBeFFpbHpC?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mdAvhcfiCPkdcy9I6RvU36DBVuqoEs/Ljodj8FZGvQLtmZMq5nxWpfy13UmWNR5i2fQmLiNtcvUBLPz4DIwp5EyqfdFIjZmIVgGHvFzO/fAsXM7M9zPPlw3H7oazMOgZxk9ygz/aDAMgXh2WqCvL3MHSSEUSD4kxR+6q/muAVNHoCEr1yr11TPndE0ehGlaenHa7LQOG9IWFDhwGWM/HJJzu4kehZbyDbmGendS3X6GlhRP+hgAiPDfMmEGXUgY0KWTcnGRiIT2BhqC2tV30En8uubFG/FeQ3Na71F/wFe9ktZd01wxzUk0AyYJVYyfnn73BXEX9JKSaqy1kaV1WkDVdCzqetDrQJv39PidLiN9yjCKqmZrB5/uP5oAJIfzJrzBYTDdM84xkEBQtX/3O+sBBZeB4KYkrd2K+OTGcN+k8wYJXYS/fW7q8gwcgnfopvk6nU7Wry00IROd8kwr5KWDKmq+zzVkRptw2BRwcDsLMBUhVSK3blGN1RCZcMafKzv4Tn5UFpARQZZFgAfpeoiDqG1GSxD9lVVwMykFigSGg12VT4RwtPWcPZ7P8tG22uFbAp75Wukd2uLgcgTczoBdyLk5aX4yvidUVACD7B8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1144d8fb-fefc-4fc5-a58c-08dc4f0a5f66
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:35:15.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DzYzsd3ZPNLmovDymsfA/YGYRzxDP+IJujXjQz1uLL/DrNIl8d5Pe/WSQDQzvXuGUSUJrbugNiBbfvhlXNOLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280063
X-Proofpoint-ORIG-GUID: IZxhwYwS82JuvhPKqF4Vvrbxgq3vf8B_
X-Proofpoint-GUID: IZxhwYwS82JuvhPKqF4Vvrbxgq3vf8B_

On 3/28/24 01:11, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Killing a background process running _btrfs_stress_replace() is not as
> simple as sending a signal to the process and waiting for it to die.
> Therefore we have the following logic to terminate such process:
> 
>     kill $pid
>     wait $pid
>     while ps aux | grep "replace start" | grep -qv grep; do
>        sleep 1
>     done
> 
> Since this is repeated in several test cases, move this logic to a common
> helper and use it in all affected test cases. This will help to avoid
> repeating the same code again several times in upcoming changes.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks, Anand

> ---
>   common/btrfs    | 14 ++++++++++++++
>   tests/btrfs/064 |  7 +------
>   tests/btrfs/065 |  8 ++------
>   tests/btrfs/069 |  9 +--------
>   tests/btrfs/070 |  9 +--------
>   tests/btrfs/071 | 10 ++--------
>   6 files changed, 21 insertions(+), 36 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 66a3a347..6d7e7a68 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -475,6 +475,20 @@ _btrfs_stress_replace()
>   	done
>   }
>   
> +# Kill a background process running _btrfs_stress_replace()
> +_btrfs_kill_stress_replace_pid()
> +{
> +       local replace_pid=$1
> +
> +       # Ignore if process already died.
> +       kill $replace_pid &> /dev/null
> +       wait $replace_pid &> /dev/null
> +       # Wait for the replace operation to finish.
> +       while ps aux | grep "replace start" | grep -qv grep; do
> +               sleep 1
> +       done
> +}
> +
>   # find the right option to force output in bytes, older versions of btrfs-progs
>   # print that by default, newer print human readable numbers with unit suffix
>   _btrfs_qgroup_units()
> diff --git a/tests/btrfs/064 b/tests/btrfs/064
> index 58b53afe..9e0b3b30 100755
> --- a/tests/btrfs/064
> +++ b/tests/btrfs/064
> @@ -64,12 +64,7 @@ run_test()
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
>   	_btrfs_kill_stress_balance_pid $balance_pid
> -	kill $replace_pid
> -	wait $replace_pid
> -	# wait for the replace operation to finish
> -	while ps aux | grep "replace start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	_btrfs_kill_stress_replace_pid $replace_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/065 b/tests/btrfs/065
> index c4b6aafe..d2b04178 100755
> --- a/tests/btrfs/065
> +++ b/tests/btrfs/065
> @@ -65,12 +65,8 @@ run_test()
>   	wait $fsstress_pid
>   
>   	touch $stop_file
> -	kill $replace_pid
> -	wait
> -	# wait for the replace operation to finish
> -	while ps aux | grep "replace start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	wait $subvol_pid
> +	_btrfs_kill_stress_replace_pid $replace_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/069 b/tests/btrfs/069
> index 20f44b39..ad1609d4 100755
> --- a/tests/btrfs/069
> +++ b/tests/btrfs/069
> @@ -59,15 +59,8 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $replace_pid
> -	wait $replace_pid
> -
> -	# wait for the replace operation to finish
> -	while ps aux | grep "replace start" | grep -qv grep; do
> -		sleep 1
> -	done
> -
>   	_btrfs_kill_stress_scrub_pid $scrub_pid
> +	_btrfs_kill_stress_replace_pid $replace_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/070 b/tests/btrfs/070
> index cefa5723..3054c270 100755
> --- a/tests/btrfs/070
> +++ b/tests/btrfs/070
> @@ -60,14 +60,7 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $replace_pid
> -	wait $replace_pid
> -
> -	# wait for the replace operation to finish
> -	while ps aux | grep "replace start" | grep -qv grep; do
> -		sleep 1
> -	done
> -
> +	_btrfs_kill_stress_replace_pid $replace_pid
>   	_btrfs_kill_stress_defrag_pid $defrag_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
> diff --git a/tests/btrfs/071 b/tests/btrfs/071
> index 7ba15390..36b39341 100755
> --- a/tests/btrfs/071
> +++ b/tests/btrfs/071
> @@ -58,14 +58,8 @@ run_test()
>   	echo "$remount_pid" >>$seqres.full
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
> -	kill $replace_pid
> -	wait $fsstress_pid $replace_pid
> -
> -	# wait for the replace operationss to finish
> -	while ps aux | grep "replace start" | grep -qv grep; do
> -		sleep 1
> -	done
> -
> +	wait $fsstress_pid
> +	_btrfs_kill_stress_replace_pid $replace_pid
>   	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>   
>   	echo "Scrub the filesystem" >>$seqres.full


