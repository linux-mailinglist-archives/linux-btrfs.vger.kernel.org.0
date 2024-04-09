Return-Path: <linux-btrfs+bounces-4064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856CA89DD4E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69661C21575
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2231311B5;
	Tue,  9 Apr 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A8Su/shE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gM9RUJQu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196F12FF94;
	Tue,  9 Apr 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674173; cv=fail; b=Tgd0FmuzeqWaWY2tlaboXMzyZonFVDk3DxCXNoKtBI+EohXBz2HZ7C2fQqsmLKLbqE/0CnF4Rhb8V3JIm0XXnbEgJ8Z35W1apU8W2m/BRxIBJKvEwJwVCLldGdYqL8yw4Ad8xBRFPTkMCgOrYPJg57BFxpgCHBVHo5UCxseSjp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674173; c=relaxed/simple;
	bh=AgF4BoNt9K78XSXTigIrsOHr89E6OTOv6pGqWB06KoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VgQvucjrW7hyhsqzuYvi7hWVsaHaMC8a1ggoKEsdUyguNbemEVPrkUrydVfdFZgKbDvQLlyHu0jCpaV1sjjW4HlLmRvzhXim9Nc0UGrGPwcnpiXi8TB9dNos9V2y4BzeI4fBK5sEJBbV5hGfw/GiXllCoccqBfCC2C6SiptJyEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A8Su/shE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gM9RUJQu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYKDV031354;
	Tue, 9 Apr 2024 14:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=u6AJdH2C0mJGFjU1niTNmRqq6pDz/j2ydSCpomyNKa4=;
 b=A8Su/shEiVcXicGmGr44WTA2rhZW+BcgN5RYQHZbfRGj9SHWHe8epze6kp1tb92S2k5t
 TKqfttDLj45R3KoOybx+4eJY4XARZAwPYjRNh/FtCRk+Y60bOQbwcs4N01aSb54cIvrX
 0UQC6JwRAWuhkXkqevBAI9ATll9HI9WDC+IReNw/EU04poJvhLRaJs/NbfsTiVxdFiV1
 eHXPwIZTjDkKbcxdlSUN8aDH/Uma/UFzkLNL/Mx7f05SHV7AwNpf8ZR/gZwr7LCC4/lI
 wyv7tKb5cM31hmRPM5F2vHgKdEuJud+vzyCh6PUnnOWxi3BxqmSqKrNmlxXEYzuOLly2 mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b54na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 14:49:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439E5Bhg039991;
	Tue, 9 Apr 2024 14:49:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavud3fet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 14:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYzi283eZeNqJjnuVaZvIDC5e3MMjbn8lTRZ6mhkKArhzyhy8S1Hx4MZ6z5jLX1txdUEPpDl9v7v6Yilap1AEXEGPKKRgk4rOmVGIOMI6tX3ecTH17oEW5MWo/FjwvP6oPDJWyOqa9cjP4zvv0ne0YUPv0/GJxAFH5bBKHVVMoMHCIko3vi73l1UeOtj1HiKpxX+ZN4k1sg6lfE47WIYogFj5DQLjHSMoZ9uj/Mhy4CMrRj8mW4Vg+WTHrp5J/oBf118yY/SapsRHaB1JM4nSqCRev5VoPdzAaDbdd6c1bTrUaD/y6mmWdE7B6BncyX+8E3H2VBWR+RjDLs6GPcxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6AJdH2C0mJGFjU1niTNmRqq6pDz/j2ydSCpomyNKa4=;
 b=Cz52VmLias8cAxRguyPDggOOLtN2qyIon4Qpc/1Q6WF0ZPZXLPCoYrWWg1KNxxA3s55S3yApYliHZf18QoSLQJ72MhXGRb2FtrVKnk2uPkRYVEsJ/ym+XDrKrr3uHoEf6lc9hd8fysY3QXY23+3rC9zkrqwPou0/4t9WV1FdLWR8VpyWKj9GV9vaAwl49QKOHNckvCI7pUCT/lr/lE1ne6fN3mAsgarXD6w9Ecjp/lIY8mTnBuhN3GZyiz4KNkgi+WvlylWxCq6tgmZS/groinLo9khCg5Ttc4HLxHtLAKUuqa09ySXpCv6VxGF84RSoZnOmHfyXZSg9HxQPF34Qpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6AJdH2C0mJGFjU1niTNmRqq6pDz/j2ydSCpomyNKa4=;
 b=gM9RUJQuiuZ5jhsjunt/qoZq9eywCOlvXKkGIup0MNM6TRzGJSMwo3UuLgJFmTP+kPD2ZxjLUb7j+Var5gCtVEUaKR4dhlfnUcyr08o+9Pb1UUEf4CibIzYs8/0yrt9JgIhvTzfrxicVxxSOg0RhwVJyejx+5R75+PwBlX+ysjw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4784.namprd10.prod.outlook.com (2603:10b6:a03:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42; Tue, 9 Apr
 2024 14:49:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 14:49:20 +0000
Message-ID: <91ff6357-7b21-49dc-93e5-14f2f4e3efab@oracle.com>
Date: Tue, 9 Apr 2024 22:49:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/733: disable for btrfs
To: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20240222095048.14211-1-dsterba@suse.com>
 <20240225154123.pswx5nznphszonns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240226113340.GA17966@suse.cz>
 <20240226180723.v4vwjts4dxndifaq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240226180723.v4vwjts4dxndifaq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4784:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XOS8UtkHMv7gVjVSoyqRMXfaMHjug0Pcg+vDJSh+cz0bYXyiZt0btAsOcKfzEPV8WM0uGyjyoDvaq2H9V19fOsJC/ayhXACjjoCvl+C4l9L2+MSrKQtBj1//DzD0EY/6HNlMmIXtfnT9+0cp4ew+egooGYiFkOG3OVtJYaroBfIBbUGWXnrgSDtkWlsurLsUol1pHEbmD2B6Z4szE5zNsoxXnb2EkAlKhg8y+l29Coie+HkAZBWaQM9242NbbA/C2qgD4IpqT6xXmTBtdBorUP7TKYRTcrbz44R85+9G90wPDy0UHve96eF/AJ1Y8RomiXofyZieErahpM6jW9hbhmPCxTKrGclgVy+lHzNvlL2yC+3RdddeYibH3hkHJR+7QUkMwuBoMxTMEW2HhYVL014HIUDO30bqdpJmDJ8NZ7AN1W7sdDhXhpKZMO5f4zlrQd5ENQ3WW7g+7qKfOOapNx64QkTzRs86pHv7XWe6b99WWEvYAizQbKHnLPZSKlQuO9Gnv+w+AsWfNAkiY49sy6Ot7sZL6hegxS3Dr9q0B/0ITsL7xOB556JYO13kdmKukJWaClDilFry8wc5tHQOSsb6HNnwRhuec1PCNPIdNsDSxWaoCMTUHZWO+9iMO6E/i2HgielnkCF9XPQffuTcG2a/cGZQr6Rh06YZERjwra0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0VvQ3YyUlRUSHFBWUIyRk1SN1FuZ1J3UTZaa3RCOUdPR3pXaTh1VGcyK2hU?=
 =?utf-8?B?YlFoL1JaRm9UL2M0UTZYUFR2QXNFdXpUL003V1JjR2drVHRNQWVUMmdQWmhR?=
 =?utf-8?B?UjdObndXYlp0dERwMGRna3ZWYmRPNmxOZG9SRklPK0owVlNiY0lVVHR3a2hK?=
 =?utf-8?B?ZUR4MkhpWXZpVGdOMGhJTnpYN0VpMXdZa2RVeTdiUk9WcXk1L3RnbWRYdlA5?=
 =?utf-8?B?TGJXQ0JIdlY5azg0Z3BBSDUyT2YwekplNlJJd2xEREJrNDRFamI3SGNld3Jp?=
 =?utf-8?B?ZXNwWnVnT2lWUnpmYkhMd0gwV0ZPSFgrRlMvc0dUc2tuOFh0SFB6NFNoQ3Fq?=
 =?utf-8?B?ckZZMEFJZXpJTTB3N2JON3FNbkdMZUFtWUFMNEZtcGt1akVjVnpjMkhjOXdl?=
 =?utf-8?B?REhYTk9BU000allkU0ZXQUs1QnlTVmN4S3ltMSszN2h5d0pRMWlJQjhhd21v?=
 =?utf-8?B?ZlFFN2h3c3h1OHcwSWNoN3A1TmUyaWxwTmozMDEzOHcwOHZQYVozWit1a25M?=
 =?utf-8?B?SDRyRlpoY3ZyWUNWVHVQVWhEVVp2TzdONlQzRGVPWFBvcTQzR0VIcUNaZ3pu?=
 =?utf-8?B?RFFQUlJLQnRJRVFXR1ZiaGkxcG1LckNmemI5STFhejIxZTQ2UHc4QVM4ekhn?=
 =?utf-8?B?ZDhzdENuWnhTRnl2dC9HWXltYXdYcVA5K0t6QUpvZFBDUzFtNWJIaWY4U2Zq?=
 =?utf-8?B?Wkp0U2pHK2RVU2pZd1BWMVdMMHd0QUIvNlI4UVNEZEI2SWNuYXJnWEs0NStt?=
 =?utf-8?B?SFFnSFBYZzhrR1RRL2xVUGhuSTBpeUUrOVNiaks0VVBIMDljNWpEUTJMblhE?=
 =?utf-8?B?bnpVbTFZN3hGUXVqRWJkcWpZU0Eyd2lNWVoydllMYXQxMGIwMUpQNVdVSVRZ?=
 =?utf-8?B?S1g0MUs2QzNwdVJkSzl3SVlIdkxvSGhFbWJlY2JtQjd1QVEvZ2JETmlnOWdB?=
 =?utf-8?B?cWhoR1RwRnoxMytmOVIySDBlcTAxM3ducCtPeGZESk1JOWpBaHVBU2srb1hq?=
 =?utf-8?B?aWFRbFl2SHEzMWN0S212TXBZKzIzWXFsb1lmUGVOQlcydUhCTzErbkt6Mktp?=
 =?utf-8?B?OFRJeHVZTjRGU2plc21vRUh4eHhDbmxjMktLVmZVWDZQWUdzNjJVaHBYNjdL?=
 =?utf-8?B?M0J4MWd5R05MY0YwbEFTSHN0dEJ3UEx2NkV0UEFGeFdNV2FyTVlrODI1Q1p3?=
 =?utf-8?B?Y0lLOGRXbktRdVlaVmE1cG00TkdVNDZXL3BhUE5LaHQwZGFjNE1zWVRxalZo?=
 =?utf-8?B?M1VLbFE0L3ZvMHBBd2NNTDZTOTEvS3VCMG1xOXhmT2F5OWRzSmdXeVY1NHBl?=
 =?utf-8?B?QXplWnJsL1ZyT24xZW9vSCtSQTUzVmlGcG5NanUwS2xZczB0dTA0TVlyZHJr?=
 =?utf-8?B?WitKRWM0Rk15anJOTVM0M1AxL2crRW5NVVNvcFp3U3ZKdlZYSUtmamdMNHU5?=
 =?utf-8?B?dDZDMTRzVlBKL1JJR3gxQVBlb1RPUnc5dDJpa1pVQm5qRXB5bXN6eHRqcW1Q?=
 =?utf-8?B?T2NkMXViQU9XM1NhaHJnK3N0VDRaUVBlQ0hDN1BHd2xTTWRkWEZUTFkyZTlJ?=
 =?utf-8?B?RWswM2o2clhTL2JMT3A2dnBUK1dnM2hzblluVXFhNGFhRzFCcGlHMXNIckpD?=
 =?utf-8?B?eFE4VWk3TUVrUCtDTHRvMUozeFdNWUlUbStLNVNPWWlYVVg3TXo5YThpd0t0?=
 =?utf-8?B?cGw1NitBVlRqUmZoeUpISk04bWwwNHN4WG9QWmh6MkdBRXBQTnA3V0pCQnNU?=
 =?utf-8?B?SzJuamZBN0dsSnFCUHNLTzJPcWxyQStQWjdiT1Qvbk9mZ0hsRDdRdk9VU1ha?=
 =?utf-8?B?bGhya1I4S1g5YjRKaUtQSHNDZE9SYWx1cVd4eUFSR0Fadzhjc29MSks3SXA0?=
 =?utf-8?B?Y3ppd2o0REJXNkRoVTJKQmY3eEY3OTFldHQ4NndPaFRtZHJSdnJtWm51b0RX?=
 =?utf-8?B?a3lxbm5WSVhjblRXSVp1V1N5U1ljME50ODFwaDE2YTZGa2VhMVR4NFVhQU1G?=
 =?utf-8?B?QXRMOW0yV1k5R3Q5cUYrZTFrcUdZSFhPMmFZYXNFQjNxNXI4YjlINWtMSTJ2?=
 =?utf-8?B?TUFoK3h3TGVRQ1RQcTFhUTNsYVhhV0hnYTQ4UnpaNnlBV2Q1QTd0SVUyQ2Ez?=
 =?utf-8?B?UkZnaE1JQi8wRGgwcmtKc3dvMkwwc1VycXJsWHZuWmRhVTc2b2RWTjhDc0ZI?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+bUFtzb49vnZj9bfnXo0HZ2HfmHcSSKVSHtB4JibsD5nTq73mrBdlr3T6AwaRXAD/HjZ+LETM0PnB0ARZ753NiHAAJLSPjF9kGf4t0+Md5LG4bBZ5zts/PY7HW340g0xtSR8ysXOZSb5B09SwDRTLJZpFGHIlORXjYyLdFlAp4U93US/o80FSoFqBKxxesBQaZSXiPiePiHJFpuQKHMVcLHXfJCypJWSHAYWchQ/1I7sE4hAicbllp0fosV/3+m27Xy2mGPeZuVo7meXqe6dTHp16f/XEQJhD9pj0ExKAOVzVDYPNah5x4EmPTBgjQ225E55G6mTqYvIfJgLJ224lhtr8xwgl7Mq5kAHuYOszWXfTOPeJ8X/PHAM9gxJ/XOLwFjkwkpVRcFJfFguFTLGrlpaXllRcLA/TZs64aLn5R3e0yPPNntL2/7+VTPbHAXm+uPCCGvfckx7CEwAP8rVSTfBynXui8p64HgPqCasEKC6f1314yV0FJEemHimrg3WIVti4FBd5183X/ZMxOpWQkjak3qMTcQpZH1YT6svJVhEQj4ftQiY9RrVkBFZf2h1TbEG74uI0YnwoqeqLayw1RZ4oZ3g88PAKVTsHx9Bf4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af64ea0-1d29-4aba-8a3d-08dc58a43cc9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 14:49:20.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNeauf0qnCcLYIm9+lY4UudYl6WW4zEC0UkZTdEPgE3lw/EdA44QBHkwr5xrNAFuydo32englJDgZB5oVKeDWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090097
X-Proofpoint-GUID: 0vrF9C7KGC7awwyPnql6sVLouatZyuh5
X-Proofpoint-ORIG-GUID: 0vrF9C7KGC7awwyPnql6sVLouatZyuh5

On 2/27/24 02:07, Zorro Lang wrote:
> On Mon, Feb 26, 2024 at 12:33:40PM +0100, David Sterba wrote:
>> On Sun, Feb 25, 2024 at 11:41:23PM +0800, Zorro Lang wrote:
>>> On Thu, Feb 22, 2024 at 10:50:48AM +0100, David Sterba wrote:
>>>> This tests if a clone source can be read but in btrfs there's an
>>>> exclusive lock and the test always fails. The functionality might be
>>>> implemented in btrfs in the future but for now disable the test.
>>>>
>>>> CC: Josef Bacik <josef@toxicpanda.com>
>>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>>> ---
>>>>   tests/generic/733 | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/generic/733 b/tests/generic/733
>>>> index d88d92a4705add..b26fa47dad776f 100755
>>>> --- a/tests/generic/733
>>>> +++ b/tests/generic/733
>>>> @@ -18,7 +18,7 @@ _begin_fstest auto clone punch
>>>>   . ./common/reflink
>>>>   
>>>>   # real QA test starts here
>>>> -_supported_fs generic
>>>> +_supported_fs generic ^btrfs
>>>
>>> If only need a blacklist, you can write "^btrfs" directly, e.g.
>>>
>>>    _supported_fs ^btrfs
>>>
>>> then others (except btrfs) are in whitelist, don't need the "generic".
>>
>> Ok thanks, do I need to resend or would you update the commit?
> 
> I can help to change that, it's simple enough.
> 

Applied for the PR with this changed.

Thanks, Anand

> Thanks,
> Zorro
> 
>>
> 


