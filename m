Return-Path: <linux-btrfs+bounces-11718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02795A4120A
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 23:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5261F7A8FE0
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 22:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B164420468D;
	Sun, 23 Feb 2025 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JbPCxiXw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hW4QWlSm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2D1DDE9;
	Sun, 23 Feb 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740349835; cv=fail; b=EZELvWVn214ro2wslk6hF46oL9doAQ6lrt68ti+jDZrqHfC5vTdeLi2etmK4C840nz2jsTRW2lDUcTLD593TJVk2buZm5uP24pckwBIPUKnXcMwZxF5uZQhl/H8dotmxTxekOtNrA2R3tDlA+5qJpY2rtB0QG35zoBtqiw9IKfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740349835; c=relaxed/simple;
	bh=a7h8FolOnYqJq08itKiyJxr2lwbCzAZXi1v1gIglq1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jdt6szzj84uRt0yW2CjJvtkUVDp1yGbby1+XvKoZU360telZCpbkThqSPZ5KflpO2mK2oxwEz63fth26M7T8E6hmDLlMWSkSEWy5lQ0OEgjWx6/GIpqI9U66GUZYfNMBlcIaTGFnLCKk4iiz1s1fIJ69mGqf5SyBeW+43hGTstM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JbPCxiXw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hW4QWlSm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51NLoSiR004441;
	Sun, 23 Feb 2025 22:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uP8NvgQYlD69IbG4vmaanmJ0zQ5cMF95VauqhmgE9sg=; b=
	JbPCxiXwqhKGN9zvu6N4HQx5jDUxVhsQZdFkLC8jUQ0fQR8ohtkpvzbIKk+BJXY9
	7q+Sweo/M9XCIhRhGfbvypkAZBsvYfdYNsHa14wkKjcxgUjQpov1sgulcL0smXr3
	naYSiLk9aT8pj3o86npd6fMSFGKDbzgOSfiBO6R4sv7obYDfXW12Y+k+WrQgZ/sb
	H4SX5v3lR7oUvvAs5LPlJ1eawnn/5GdbCNGDdEb6a5rsd9Yqr6vQCEOgUlA5D25X
	2ZipcQi+Lg8YNJGuS8X8VBtBap1pK+MqruutmzOjkRLjYRGxOKlXMPJHZdJjYOwG
	x7o1+aC3QK5R7egdUaO4OQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c29htf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 22:30:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51NJsaTh012590;
	Sun, 23 Feb 2025 22:30:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5188dhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 22:30:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2gVoqOMj3zVIDN32e5FhMbSmUHP94iHqzIsvkG85pa5odcFgP06Dy54nxMmQ2DTrLwi4kkRshLbb73HixgktOY3nND9VcYQX1InbWzNmALnco1elCZZOoJ4pq6/X+wevk3ztgQVxYAUBb/o6TWUhCrG20QoUMkyXhC5fvX0LwRV5N9AXh2d41Y0eEySiVFnLWfE7VT7SdwxsKTk63la6lfyOl9zw53JOpwUUu+G3yDmADdoKaKvN+b6AD3VQiRsk0azXsuqrQzeVz6O2anepul9o7JSteEqhAjS849UKw/Had0BcJLWg9KFTn4GUVHpn/coXJz8dcRF8wNuNw6OYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP8NvgQYlD69IbG4vmaanmJ0zQ5cMF95VauqhmgE9sg=;
 b=cMxLivEO+lGVhnZp7imC7VI/EcWoncDPfA3qd6mpStgA79D0fv+4SXq8nx0n79GWYInZLOf7ihZQQVW4ODPbneY9QqXvEl+rkM7lIorA4/eLQbrQbu2lw+alGyBiUidg/ggesUUJgv7udSi2Gr2E8btJXoAiI9LQrnVivx2uEigAFndewKoYpt5Fyvj/Ih7mGYON07DhMA5GZEs7IdWKy11krlTTmVydM2lxDibXHKpfpAJM+D2Qtj8Sdn3nptaEfPe6KJhfLZwJZR+X7qCXW4wfC0ZwuIDNWM17KypThz5Qw8r6ZN59NsovAClzDKI1GK8E/z5JzNTF5jSNF8+0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP8NvgQYlD69IbG4vmaanmJ0zQ5cMF95VauqhmgE9sg=;
 b=hW4QWlSmItpAMPlLhaBQ8A5/mel/WKM8TTWgb9bRUR57fBuhQsfpeT1hWEmbtyiLa+97F5b1rtAkKzvnqiPV/k5zEkbNqY4f12LA+78aF12kmaesiZywxvT5c9r4uCJmx+YVxnB6NTsUXDTmwHJEeD46ppmoCo/upOzVk67qgo4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sun, 23 Feb
 2025 22:30:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 22:30:10 +0000
Message-ID: <86a1ea5e-b0cc-4f6f-b578-9fa0512ff7fb@oracle.com>
Date: Mon, 24 Feb 2025 06:30:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/226: fill in missing comments changes
To: Filipe Manana <fdmanana@kernel.org>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Zorro Lang <zlang@redhat.com>
References: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
 <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>
 <20250221150311.eabczmxfxnvndkqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <4e013629-c1ff-4e84-99f0-6916058ca6ab@oracle.com>
 <CAL3q7H6cAGE4C5vRw60P1iu1zoA=JnK3+rNMbiN8CXiMT3C02g@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H6cAGE4C5vRw60P1iu1zoA=JnK3+rNMbiN8CXiMT3C02g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff66d46-5503-478f-916c-08dd5459a1a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmtYRldPa0RpZTVQTHhzNlZNWVZBcktPbDB6L3dsK29UZG1HbDBxRVAvYjRp?=
 =?utf-8?B?WXZqckNDT2ZKQllsQUpyU0ZGU0J2a0lUSjlranA2cStGRTVQMzE3blE1YU5o?=
 =?utf-8?B?d2h2NDFZZnd5WXVvcGt3ZzVidE51NG5heituRlZ4NS9HQ1U0dEZONlQ1a2dE?=
 =?utf-8?B?SmJkYjBVVUY4RDVvbnU3N3BlUm1NYnZlbjJ2WnErTWpKQkx2VC9PWEtwekFE?=
 =?utf-8?B?TXVRQnQ4WlY5TG1tcDd6eFVTNWwvTXhEdGFZM0ZUY3JVUWpwUUR1K3ZGWDRx?=
 =?utf-8?B?a0g0SFRMVHRLL2xGeFovTUlUa0JqWHhrYXdSNHBEWW1zaVNYbGN0V25hZmtN?=
 =?utf-8?B?SEEzWGZ2RlRzWWE3eUZoNHB4c21wVGtvb0FISjBrbmxsMU40bUFReTl3bFJK?=
 =?utf-8?B?SklLeGhoYWo3ZDM0cmFwUFNRLzZEZ1U5VnJGQmJqS0M4TlcvTWtyZ01NSnpN?=
 =?utf-8?B?dnczcFNUU0g1QlBQQUJOcTZ2QkN3Y2ErUXpmOFZUeGJaY21veWNJYmNDRUtL?=
 =?utf-8?B?RTlJRFFOMmZUR0lXRVlDWDNrenBzbm9RTkNQSm1TcllJT2IrWDEvdWg0RU4w?=
 =?utf-8?B?LzRzTEkwQzRzZWIvbHVFYXg1aVMyNS9tTXlodHlLOEdINEhLVUZvaEtZTnRp?=
 =?utf-8?B?cEtkTjFKQkw1bXdLc0IrM1h4MlZKMnYwV1ZFem9udVIvRDBTcWRFM1RLOGxL?=
 =?utf-8?B?VEhDVnNTYm1XSGVTSEF0YUVpR09SNmRSazc0UG9STUd2cXBtTHJXWG1Jc0pV?=
 =?utf-8?B?UkIrQTl4cmRGQ3ZTOERORGhTZ0NFY3JNNTMwMkljVnVJUndLc21HNXAwUlJO?=
 =?utf-8?B?OXhscXMzZm9mZ1pKR25kd3lQMXM1UmxLR3pjMTNxd1pTaGl4dTcwSmhKR0x3?=
 =?utf-8?B?cXIvbVBLRWVNb3h1VGw1ZEFuWGpBTU83RmVLZElHNDh0dVd0SDFXWjNmUXNJ?=
 =?utf-8?B?aU1xSEp4a0pOa1dNaVh1RTZvbFZDUElvenA2aHFHK0hZU0d0aGllSWQyeHZH?=
 =?utf-8?B?ODJFdldPT0wzdHVJZVVjV3VYRWllVHN5SlR3Tnk1WjRoVFkyRUZLQm1kbUNV?=
 =?utf-8?B?L0toUnNFNXlQQ3JxVGpXek5GZS9aVXV0VDlIckJIMjB5UGpCM1hXM0dxa1Ft?=
 =?utf-8?B?Uk5iRXJjdGNBSndPWDAvc0xxUzZ1U3lkOUU3KzN6Y3F4Ky9neGo5aTFRUTdO?=
 =?utf-8?B?YXM2NjNwdGovYW1BRnlQdHFaR1pnSldBeHNzYWFyNGxuY3lKV3J5Q1N0WDY5?=
 =?utf-8?B?Z2t6bGxuWkZ1cnZFVDFVWUVQVnlHb1hpMTEzaFp2U2pCR1o5Z0lhNHdkWlRj?=
 =?utf-8?B?V0gzWnh6YWtGVEhvWmczK2RTR1M0WTZGNHdDQk52a1FwWVRnT1BmaDdsOUhT?=
 =?utf-8?B?S2ZEbG1SOUlYeFd3blE1ZVM1c2pDZkVJeHd5N2RsSSsxbnVMb0EyNm5lR1RW?=
 =?utf-8?B?RER0WDUxZ1V2TGc5Zk00cHBJYjRCaWVzdUFCMW5DQllucnA2aUw3OU52ejhh?=
 =?utf-8?B?ZCs4RVJQQzAyWHNYRk16YjF3eXB0VkhTL2d6NCt6M3hkdGk3WUU3VitXVnBs?=
 =?utf-8?B?ak8zSC9tNEFWcmphbzlVbzlPcllBOHA4dUMrb0oxME44OW03ck5uTVhOMzRJ?=
 =?utf-8?B?MjBwYU5BcXNkYS8rZ2Y2YVFDZUx0M09uUnhHajRIS3puTTZBWTV2aUI1cnMz?=
 =?utf-8?B?MGxjVDNFem5pZ29VSDRLTi94Qm4wMmk2cCtpSTA5a3ZpZ2VwUjA1amVjWllr?=
 =?utf-8?B?QzJ3NStiTjRYMjBnZEEyN1Vsb3JTdzROZE5VQmpIV3pLNjNxRGNtZUZqZUgy?=
 =?utf-8?B?UVMycUJkRmJjR0ZyQjRHZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE9TMzNmVHZHeUlMVXlLUUJJdGFudnFkRXZPY213SW9zU09iNFdsdlE3TnZl?=
 =?utf-8?B?R2l3eEFJSU9keVFwN3hnMmFtaDVsQldmcm9jVmluREM4SExKTTJNbjA5V2Nl?=
 =?utf-8?B?WHl3ZWJ5NWV3VnFWOGVKK2huZlBKdWZPUXJJQURxcUJxQ1ZXQml3S20ydDNU?=
 =?utf-8?B?SlUyRlNwN3VkUGhJcU9nYUNkVFhYejIzZnFjcldLUFNlUXVDZ09vOGJvZGZT?=
 =?utf-8?B?L1hxYWFTUGpEVVd3eENWTUZwdk1BLy9pRHpDTUc5dDJKZVprMXVXY2g5bUg2?=
 =?utf-8?B?dGNOaDJINmNjM0IxYUgxRmZRTG9FMHhrMlhTRjNpeTFwbndjY1lVZjJ4STRL?=
 =?utf-8?B?S2QrTUJKOEozRUh3OHNiZEU3ZkwyY0RwdmhIeGJLYzljam5NeU5PQ1ZmY0li?=
 =?utf-8?B?cDczakc0QmYrODJwWXF3WmxVNytxTUYwVG9lUmVwS0c1UVVPZ2tUMzBEbko1?=
 =?utf-8?B?ZEFNamw1dUxJWVdqbTJ6M0k0NUYzeVR6T3U0Ny9vd2ZaTkc3WjFQaTJXZGVa?=
 =?utf-8?B?NWdrbzRURVNSYk5ZZkhZZWYvTkdFWldqQkM5UlJPVFk2VGJrbGVWZlllcStq?=
 =?utf-8?B?R3pZYk8wQXo5STZGbnk0SUJxbmljMWdYWk40aFR4ajJsbXp0cmpmdStCbzda?=
 =?utf-8?B?UjlXcE02SFV5S3Q5QWdUc0ZPUHk4R1E2MXU4MGRZcVMzb3JTd2Q0TkNFd1ZR?=
 =?utf-8?B?RUlDcTZVVE5UUFlnaFJGRTkxWitDZVlPU2xiUW9jd0lLbmhwRmxIZm4yQys4?=
 =?utf-8?B?RFBKNnVhWENCblZxeEdYc2poQXRmOHhWZG9zckhxZUJYMWFCRTNrNko0enE3?=
 =?utf-8?B?WDU1bFJnZzdub3c1TldFMHpyUzh0K3p6eHhnVks3QU9yMWFTSUdjdWs1UkdK?=
 =?utf-8?B?aWxvNHF4Qlh6bjFhemd3cXErTkVKdjFaYUNQWWtRNHZMNU1QaFBHUW4wOXk4?=
 =?utf-8?B?b3N6S21DM2dkK2o3a2xGNkZoNmR3djJYOGN1c0VkbTdRK0RRL1FBbzVhRzlP?=
 =?utf-8?B?RlFkSG5VN0thdS82SFVzbHlNY3JwNFMrOTRMUEJZM21rSWVBZ0svakxCVTE4?=
 =?utf-8?B?bzZJNnZtRU1OMWt6dWVQVytFR2EraWxFaFZwQ1pMazd6c3JWMkRSUm5VY1Jw?=
 =?utf-8?B?WHVVSXdyNFRHaVFQR3BnUFJLSG1pRFpKbGNnWWlkM0tvZThINHVEOWZYRjVr?=
 =?utf-8?B?UVc0T3hNSVdTd05hUEpZQUVQaHFGRnBGQ1RnWHdac0tTcUQvUkRYT1dHTFph?=
 =?utf-8?B?MmMyNlA4dFJ5Q1hyVU1UL3lNSkUrL0FCR2pkSmpINDF4U3hxN0tLazVGVWRm?=
 =?utf-8?B?dWIwbUQzcW4rMHlpMzFtaUkxMERmVEJQZ0dHK1FJRVFMTGJBajNmUEc2WlE5?=
 =?utf-8?B?b3NnVlBXazhOQ0xSNnRLd29jbUozTXNHL1R1VDNScUFzMDNDZkFDSGo1aHAw?=
 =?utf-8?B?M0dmelp5NlVpMkV4MFhGRlpKelNDY2VmT05ycXM1MmZUbVFDN2RDUTl6N1Vy?=
 =?utf-8?B?VFd6Rm10cVlQVkozWWR6a3NRS0Q2Njc4ZUpYVk9HbmZ5Nmxtd1NMT3VSMm9X?=
 =?utf-8?B?bXZuK0p6S09lVGFFai9MS2F2dlNWcXNDUVVKamJEc1JnZ2pYenRkeXFkdlFM?=
 =?utf-8?B?TGxsakJXczJTWmxMTStGVWNDbmErWnlJRWVSN0hoYTFhRmZ4bW1kcUNha2lD?=
 =?utf-8?B?M2p4MmY3aFh1TzdScjh3TmRMc2Jja25YSllQdzJLckprZS9wUFhVNGJvVFhr?=
 =?utf-8?B?dXJQZjFJaTlFZFlEL2tNbWtoem03WjYrSFJ5d3VlcWhEVjRNVldVWnUvS3lC?=
 =?utf-8?B?b0FlTmIrQW5FNmV0RjhCSU01VWkvS2RvaG5LWjF6OEhnQnJ3WU5iVXlEeWZ2?=
 =?utf-8?B?dE02SSs2QkpEbjRBZ2JTS1JmU2JoRHVXdEtkRzl0MFExaURjN2VWR3pqdG80?=
 =?utf-8?B?Uk0zbzVRTERaUkZacU4zd0pJWkowOXZ6NjJLZCtvR2thTGc1Q0FoeTJBS0xH?=
 =?utf-8?B?Ri9sWDVBdFBFME10RXZUY2FZNXdTVGdXWXhtSStXYy96QzRhbHA1bXBsUUFX?=
 =?utf-8?B?NHFudHljbTMwNk5EUm5MTFFucWc4bE9lMSszNnA1VFJxK3BGSW8zNHp4eURL?=
 =?utf-8?Q?a/PDFodESqg3UzJVTeBbquIDk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pcYwJl9+gvoFPYpQyQyV48N1sULXIfte5+ZhRDx2A13VQnpqVBU8pNjWyk4IzwHRvOIs+juWH9y2mv5Gimro7bKOBarr9VVRNfB48/RzzPGUq7lrjcIH85Of/cdu1BMVOcyOoUrKjSxiAniiHf2pprzzljgosCmtrTvdYRc0ZmVcVTbbQAJqXazgrGhviUfE5CGNywbbTjAOXbYA1dsYesf3+BYwbZtX19GeqHGr4kz9+yshMjyPWqOza7u2mxsB/9RLxfB2DjFMYH23Wn0//7CgMnMf1wxURzXsX9cS64M721TPqrv7f11CtvT9mbFlov70BrsQNVxAy1xAOBQMpLOAZtuUF7rFsUjKBmgL8Sbxf6bF1cZjs6lRn7a4LEWpnN3lxK97fCBhixNDPugWfuaw/f03zVXx0u+q5ydScn/OdFGsZwz96jZzamO7Tei0aX1jmloTaaZ6JqACMny0qpcVqGndojTmm4sDtPs/lf6gvZtbBNvFtXN8caJQIZM2zCm4S10lamM5RccN8kNkAwNQ4Wfx+YlTgPiG5RVCY8IyAeD4L0wSUUJtc6aKF5yhHVGC9saSyf68IiOUqyEiK8QdvySPsn1LAro3gQyBxBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff66d46-5503-478f-916c-08dd5459a1a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 22:30:09.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJscGqzojcUr+mpiBPACAke2nXbPDpkeksBpTG/7y/76R0lqVpIWexhlPe8KRa7fuWRXN8gRQ3W+EuntAyrM6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_10,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502230178
X-Proofpoint-ORIG-GUID: rzPL5Zs1n5aVVG_osmseEI2XGtGa3dN_
X-Proofpoint-GUID: rzPL5Zs1n5aVVG_osmseEI2XGtGa3dN_



On 22/2/25 19:29, Filipe Manana wrote:
> On Sat, Feb 22, 2025 at 11:17 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>>
>> On 21/2/25 23:03, Zorro Lang wrote:
>>> On Fri, Feb 21, 2025 at 12:04:32PM +0000, Filipe Manana wrote:
>>>> On Tue, Feb 18, 2025 at 10:36 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>>>
>>>>> From: Qu Wenruo <wqu@suse.com>
>>>>>
>>>>> Update comments that were previously missed.
>>>>>
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>> ---
>>>>>    tests/btrfs/226 | 6 ++----
>>>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/tests/btrfs/226 b/tests/btrfs/226
>>>>> index 359813c4f394..ce53b7d48c49 100755
>>>>> --- a/tests/btrfs/226
>>>>> +++ b/tests/btrfs/226
>>>>> @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
>>>>>
>>>>>    _scratch_mkfs >>$seqres.full 2>&1
>>>>>
>>>>> -# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
>>>>> -# btrfs will fall back to buffered IO unconditionally to prevent data checksum
>>>>> -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
>>>>> -# So here we have to go with nodatasum mount option.
>>>>> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
>>>>> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
>>>>
>>>> Btw, this is different from what I suggested before here:
>>>>
>>>> https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle.com/T/#mb2369802d2e33c9778c62fcb3c0ee47de28b773b
>>>>
>>>> Which is:
>>>>
>>>> # RWF_NOWAIT only works with direct IO, which requires an inode with
>>>> nodatasum (otherwise it falls back to buffered IO).
>>>>
>>>> What is being added in this patch:
>>>>
>>>> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
>>>> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
>>>>
>>>> Is confusing because:
>>>>
>>>> 1) It gives the suggestion RWF_NOWAIT requires nodatasum.
>>>>
>>>> 2) The part that says "to avoid checksum mismatches", that's not
>>>> related to RWF_NOWAIT at all.
>>>>       That's the reason why direct IO writes against inodes without
>>>> nodatasum fallback to buffered IO.
>>>>       We don't have to explain that - this is not a test to exercise the
>>>> fallback after all, all we have to say
>>>>       is that RWF_NOWAIT needs direct IO and direct IO can only be done
>>>> against inodes with nodatasum.
>>>>
>>>> So you didn't pick my suggestion after all, you just added your own
>>>> rephrasing which IMO is confusing.
>>>
>>
>> Your sentence missed the consequence part (checksum mismatches) that
>> Qu's sentence included.
> 
> And that's totally irrelevant to this test case.
> 
> Preventing checksum mismatches is why direct IO writes fallback to
> buffered IO if the inode doesn't have the nodatasum flag - it has
> nothing to do with RWF_NOWAIT writes.
> Besides that, such mismatches only happen for cases where an app
> writes to the write buffer while the direct IO write is in progress -
> which is not the case of this test case.
> 
>>
>> How about,
>>
>> # RWF_NOWAIT only works with direct IO, which requires an inode with
>> nodatasum to avoid checksum-mismatches (otherwise it falls back to
>> buffered IO).
> 
> Just stick it to the original - simple and to the point.
> 
> Thanks.

Done. Thx.
Anand

> 
>>
>> Thx, Anand
>>
>>> Hi Anand, please talk with Filipe (or more btrfs folks) and make a final
>>> decision about how to write this comment. I'll drop this patch from
>>> patches-in-queue branch temporarily, until you reach a consensus :)
>>>
>>> Thanks,
>>> Zorro
>>>
>>>>
>>>>
>>>>
>>>>>    _scratch_mount -o nodatasum
>>>>>
>>>>>    # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
>>>>> --
>>>>> 2.47.0
>>>>>
>>>>>
>>>>
>>>
>>


