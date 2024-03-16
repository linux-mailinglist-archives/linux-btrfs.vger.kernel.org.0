Return-Path: <linux-btrfs+bounces-3335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A58F87DA46
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6051C20DA7
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833B18B09;
	Sat, 16 Mar 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TLKg+yt5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JXNGOhXZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A718AED
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Mar 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710595715; cv=fail; b=CKpjo2hkEI2oc+OALIEznj7w90npU2UUfdJ7gRxDKaIVmeN0YP4jtfzLFnFuCB70WM+rC2o4ko1VFOL2bJiTt3jXt7S3aYSDdfeduLARwzKfqOnzTl/FsfS/GKfZllgB1xulbHyLwF8Uo8fW6DRysrn2KXZJ6MuGQ5v72trADdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710595715; c=relaxed/simple;
	bh=sHqi/qAH0q+WyEhX9eIAsomd4sYrw75euhazjDcMAY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e1mOnsXrYjx1s69EdraY8JjIrPcyFyyZxj7NLu/CsILEEc8j8QL74/LsL8p85BQI5wjvAs22WBD1it7dTvPXbBCvqLJv56P/iGQAAr3Bww4K3UWxuV3ZO4Z8ZyFoXpDw0zDQ3Z/j9RHzkUJ51qDf4ALTR60xKm+wHQDFPbWahqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TLKg+yt5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JXNGOhXZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42G3vWao005235;
	Sat, 16 Mar 2024 13:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Gz8IK3tIkxGqdHokwoMBisircoN/tlTxwiTaYEuqPus=;
 b=TLKg+yt5fg1JvpB63Tg1sYXg93ApKD4SR+D2J+UvyncxSjPRJzCOstVXTqrotby8H1k8
 4uIZPuwhRsaAdEWo1QKaMVvOLc90Hk24gYANOGTMrBOO/QW2XjykvO/IDIfZztDTTRLJ
 w+++KRJ00g6NaExARe8Y6P8BO+xQ4dokcGtSccIYG4ds52kEDaGi23PBVAl8QBQ3XyQk
 2I+jGilrxnkwqrLjurHC/VmA6CWVXJYGryKFWPRwHkNm2BF4msjWCBYxmh0pBW2dkrrW
 lOUQbDAXqiCEzXdldfmyPmzxDiT4lWRb1ZJB78WWTG8EKybg0QV5Dqsa30WxvYWgksR1 3A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu0dhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 13:28:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42GA1JTj024183;
	Sat, 16 Mar 2024 13:28:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v3dt3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 13:28:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfp75RaGgWriXNbZ/Ax31Pjn3OJls4+CXssUzemDbK/7fSn6khakSZi4NJrZtdWzn8uJJ1pkGNWr3znzVIRqy7t/O5Y/d9c70QZBtcPle/BKtavBKTOxAjhbrrtt+/30JznEIzdiZqBaq7/dVqnVFLMszz1p9OjEHVny2Aqz1pQ17TJWs8sTn4LL55TZ/qd/kLHOWolfiuQu14FYVE0HN/RM/CKiv2Mxrdmj6XuKz/NShuyPstOswHTkLeAhIVLFJljwajM8p9EPgl6VXxcEitog77BVLAN0cNaiCeC34Avw7mObWgMvbTEHlJs5ipZ7udxrghKNc43dwpnxp9bCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz8IK3tIkxGqdHokwoMBisircoN/tlTxwiTaYEuqPus=;
 b=LDKfV/A/n2EidPgV61/oULRKUjMgWMCAi6qtZoetgjxYHmmsLTTj98ynU4OkU5nc1aprJGJ6nepj40gTd0pUimYDeL24aYWD3Ixqhd/2ypfjNpF3iVuy+dW6CQgmQSa2Q7RWaQseWvWVVtzqV82toHcy3WeoAfbL3Z2XhSRViIa+Rwzw9uXz/2NZIFFLwCWQUC2TNlZVOV9r0i12eeqh/uCdS2Z9iCVK47RjFFfeJJZsoimcTBENYNa8mnXENOgSeIL1N1IZnjskcr+CV6dONt0Bl1KUBfBGfis/kuutplreQgNTaZk9W8PgvjDynFWG6Uz8SwDDwg0dtCskdkp8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz8IK3tIkxGqdHokwoMBisircoN/tlTxwiTaYEuqPus=;
 b=JXNGOhXZZbz+/P6JhsJBADQzVXNdbFVOnF31INzPPhH7reARWB94ju5UFleSoSa0kvSi27PYqJWvtHKHIHZjleriNHqrJmXmK15UlX9mOt1LnsPR368mCwXaVP3H2QSy77Uma1aGHziC4DWxEx6ZbOUIo7QOkhdWtfbrWidBXFY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Sat, 16 Mar
 2024 13:28:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.022; Sat, 16 Mar 2024
 13:28:21 +0000
Message-ID: <25212038-240e-4a4b-b086-ef99fa88fe91@oracle.com>
Date: Sat, 16 Mar 2024 18:58:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] btrfs: forget stray device on failed open
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1709991203.git.anand.jain@oracle.com>
 <7abddd87a9b1be4b6da6173478f2ccbcd3117dba.1709991203.git.anand.jain@oracle.com>
 <20240314170516.GC3483638@zen.localdomain>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240314170516.GC3483638@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfc07c1-4d2b-4a61-8849-08dc45bcf308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	agpSfiN8QqQIHUrOdkSFZooNUes7owbGHAEOq5kVrLrECSFt8+MtwvyBEMqP8mrocZ9vF8Z3+bdLIo7fgGWWf4mkAgdaIo+hXKkSMyS4ZUSkHRkwLi/UtXuWLwvgYDs5nhFqF3lwFQ6LtVa42VZ6qg0TRygrCcHeiUPdY+meVhSfwsncpuMbWUvKNjqHCC3/OL+LDLY/NdTkMQyiE/+80l/dkUZePBzr7ADyfb4UnwRZr9QmOJTu7bFbBUEg9uemzBKSEP3rSiVMLZALImHGKulHPi/6Eb3ZuczjaDXcEP0WEcIu8yL/F9eThxX38ZsJ4lrfsuMNehCPUS6YIkEnuYlxp52PwEBRxBpBN9JEPZzm+QSMv8IJE3DMObX1rRBNuqfbEnSb/AzmWM9+mZpduLUaU3E9P0xGFHiL6vjVsJ0ybKnWSnZ/pQVjXiEYpb/bku+b4b0XTvPjDUBs6E2azgkozg+Dy6SHHsZKRh8mwEZ4J22tnqYhS949smNXtSxJPPxyaUywEN1Ynmf+xja0MZfxfxDZX9CFvsjPn/kVSbx3P7Ng8CXW1+yaxdWp+f9lLgC6fpx5lSv+p6dzZhlnwD8THzeEAHBLSMFIW1DmgvIJIn9uIamBw0iapE2yD5W3mhTiWnKRK9EilAcYWt3NilU2FSUcG4szLytZe/TnIx8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmhKZTUra3RwekxDaGpiZC9FZ0wzQldkUVgrb3ZQR2FzV3BOZU4wVXAvRWRo?=
 =?utf-8?B?SGhIRzVpWGdaZHdpcFIyVmYzcFZZT01VOHlLS1liQTJ0WklPaXVoNWY5ZVRs?=
 =?utf-8?B?RnphUWVPdnNHYTQ4VkwzbFc2M2pCek9QdUdhbHJVSk5Ma1RYY2o3VFhpZnZK?=
 =?utf-8?B?ckcwNzREbzg1WEs2TThSWExwZGlBQk1xeDhPY2E1aFdWYWEwNEhIbHFsVmdJ?=
 =?utf-8?B?bFl4ejY4RE1xOGpOdFBXbjVFMkNMTC9iSXE4ZW5xMlByemRDRWpzekdyZUVy?=
 =?utf-8?B?NzBUNWZKVjNkOGNFRXVBNEorRFNFZE5pSk4zMTQyOUpaeE9IeWNaVklrMUVu?=
 =?utf-8?B?cUtrOXRXMmFUbnJVeXdwWHJJRWpnd0dicXdyL3dqZ0tEWDRNRWltbEZzbnFi?=
 =?utf-8?B?SXk1aDVVRTA0THg2RDVhN0ZWK1M3Z2RNRlhpb1ZHbnVtYVhpUjBWNkR4a28w?=
 =?utf-8?B?Yld1YTZWbFhEMFV4UnJLdmttc0hQNno3T1ZONXd2S0c0UGluTTBYaWJkeUds?=
 =?utf-8?B?aHVhOGJmOTVkeWFhei92NTF6Ujd5a1VoeFFZRjlra3RUUnQ3dGZMU0lLOHY5?=
 =?utf-8?B?dVI5R3crWlR2ZjkyalpuYllRaWdFS1V6Z3lTV3dTNmVXTzA1dEtLMkY0MVFx?=
 =?utf-8?B?RUFsZUUyWnJIWkozQloyWWtjUjlyV1pweUZYbW5kdVlDTlVuNlNURFJUTXc3?=
 =?utf-8?B?RWNPSEMweGE0bWhZMnM3aU10d1o0Wko2MUd1ZzlnM0Z6T0xIbjJLMGdzMnNY?=
 =?utf-8?B?T251VHZTWGpWN0psS1dWQ1NVQ1NTYVl1YWt3bkVXcytoR1lOTW4yZ0h0cWJv?=
 =?utf-8?B?NW1TWHptNjhTeDNtK3hVRWMwS3FPRWNrMmIyVWkxeno4VGZjOVdhRVBQMVZC?=
 =?utf-8?B?ZWJBbU5YSDlEMGUvay9vbWx4STlKaFhUZWxabG93MFBQYmxGKzJBNTFyaDRQ?=
 =?utf-8?B?ZEpFYXV1TlVCSXZvS0dMUUJaWi9vVklSemVSMFlyYjlibThiSjYyQmQ4UEto?=
 =?utf-8?B?YTZxdlN5K2FnWXNtYTNhbE42RUxmUVpyNTJ3bmJ0SStTcHpBSDBBZVRzK0Er?=
 =?utf-8?B?eGRiNHc1eFdvUUtwN3MxZCtoK201dGlQYktuOGZRQ2dCR1pVRi9GbUJTVjZj?=
 =?utf-8?B?bGhOUjdWNS9BeWtoQlhzaHY0T2F5RC9NY20xVnFJWHNDTG1MbS9EcUZNbjg1?=
 =?utf-8?B?dWtXdHkrTndjUHc0Q0tqTGFtbFYyeWVkVXB4Q04yd2ZlMElWbTB5OXRHSGJU?=
 =?utf-8?B?am1QUW5TRkpNdXF2ek9ZMFhlWXZyTDFuYkNVNmVmNWsvdTlWcGNvN3RuM1R2?=
 =?utf-8?B?azg3a3IwR2laRjArdXhVZ3cxL1JBN0V2bXBRZG9QWVU1VWVzYUJsQUlXSVJT?=
 =?utf-8?B?cnBYYm53WUU2bUV0WUtCNzZMc2JkTzBXRHY0TWtVRGNqbUhYdnlhYWN0ZUUv?=
 =?utf-8?B?T2tKRzg1bmRuREtUeVlpVzkwaFUzY3RrK2NweEdpS0g5c05GUTBnVUVsRGwv?=
 =?utf-8?B?Ri9CRW15YjZacklrbWo3Z1dnUTBLeXlyeDVUcTErbjY0dXZSK01aVTA2NVNC?=
 =?utf-8?B?TUx0S2lROEJEVGxJRTBLV3ZWRVltZFYxYXJUalhRWjNpalBmd00yZEhwVW1z?=
 =?utf-8?B?aXhGQ2lGVWlxdzVZc0N0aGRNYm1tcjZiYkJUU0xJbXU2UTYyWTNPaytLeTQ4?=
 =?utf-8?B?cXBycVMyeVprRVRSRnZLQkNPTXNiZ2FMWmZ3QzdEdFhLOHUxM3J3Rml6ajVr?=
 =?utf-8?B?SmU2VDV5OWpCRSt2RDA2M1ZIU0F5MDNETE5IM2pDOTdsNmEyT3NqSVRPYXBh?=
 =?utf-8?B?bmtld29YODdjSmhSRGZVSyt1bFZMQUZlODBwQkVVcVFXNVgvam9VOEVhb1JG?=
 =?utf-8?B?QkdvMjN1SURaaXNaTitBSmlqMWtkc29pcEQyQStBNVA3b0dTMFJDK0U3Y0lT?=
 =?utf-8?B?QzlGVkNWMThUSWZhSGNBQWlqc3NlYVhJVGgwMHgyd2dNNEpOTzhlR1JENFN6?=
 =?utf-8?B?eVVCS3pkaW9xVEp6M3djTXpBNG5QZTJzYW9UZVFwV1d1eTYzT2ZBM1N0S1M2?=
 =?utf-8?B?dXZ0bURZaTl3bG1pNStsTTZrWTI5ZHNLK2Zpd1l6RVgvOFlFcUtOU1FJK1Vo?=
 =?utf-8?Q?BbUZgLUfA688Opp+WinZvFr1A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oiB+lLB3FMpo+FsSesHPXCGFYgZ2Ulg6KHw6kUHckhFCtKD/PtkpIJHwS/spbfJaUhuE7s71GUfFyOxeq9N4FhcUSQIX4xXWvR8igMO6tHvPPCBINQ0KyJohnWASaEz9HhqdbmDNIcg9XFyo8ysGG6n4TOKfXEkYP5vTFzrYYSbImdGW6LO59vww4zuoRus0R8g25meCZyxEJreF+MtG3JLDNjk8wkkQwSVRJn0WkyznSwQT1AXCjOMtTCDNr6w9JiCQyDfj5CbMuV1t67s6tLx3v6OH6vwc2v3nEZPb4zSLdNvA3JzzcIwZoMte69L8Zd+mNLuUY+IP4STSG5EjVd9FxvRgObiLPzl2+Yj0yhCYLHZlgf7ZlkDHy+tGS3jLArHwBxL2uFF05ikZdQrY5pMs1k7NQRVEc+mXBiCE2gVIGeyqvywP3ATvWAtnZD+EZGulBB5PIASVFWsN0TwYLnwdv0XNqMJI8dUdGFOW9DaOHKeH0vEWfFYEAR3hoDTIq0kU46OMS860nOwmEWB4pt9vbd52LkS3kYe2JUrbjzDW7asbjSHUZu8/U4cmhOCYtMcthXXwdBGMBRnkfyBob3A7Ida+A+UiLIGFtwE/9WU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfc07c1-4d2b-4a61-8849-08dc45bcf308
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 13:28:21.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ng+h8k/J2dQF7Xs8mv2mcHZoTCtHAH7XXWtlFJ2hQdpABD9F9yw0ejRlQ2JUnWyWPNPtBSKEOG7H9ggb5585RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-16_13,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403160106
X-Proofpoint-GUID: q0CpzmqQtYiXk9ZV5h43sd7xE_6VMFiX
X-Proofpoint-ORIG-GUID: q0CpzmqQtYiXk9ZV5h43sd7xE_6VMFiX

On 3/14/24 22:35, Boris Burkov wrote:
> On Sat, Mar 09, 2024 at 07:14:29PM +0530, Anand Jain wrote:
>> If the physical device of a flakey dm device is tried mounting it fails
>> to open the device with handle, and leaves behind a stray single device
>> in the device list.
>>
>> Remove it if the open fails and if it is a single device. As we don't
>> register a single device in the device list unless it is mounted.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/super.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 29fab56c8152..4b73c3a2d7ab 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -1820,6 +1820,9 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>>   	fs_info->fs_devices = fs_devices;
>>   
>>   	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
>> +	if (ret && fs_devices->total_devices == 1)
>> +		btrfs_free_stale_devices(device->devt, NULL);
>> +
> 
> It feels like we need to do this free no matter what the mount error is
> after this point, not just in this one place.
> 

Indeed. At goto error, btrfs_close_devices() is called, in turn
calls free_fs_devices() for single-device filesystems.

Thanks, Anand


>>   	mutex_unlock(&uuid_mutex);
>>   	if (ret)
>>   		return ret;
>> -- 
>> 2.38.1
>>


