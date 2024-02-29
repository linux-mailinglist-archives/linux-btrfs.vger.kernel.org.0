Return-Path: <linux-btrfs+bounces-2893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51286BE83
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E1C1F24A81
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECA336AFE;
	Thu, 29 Feb 2024 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YAJ68X2m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qZKLee4u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9ED364A4;
	Thu, 29 Feb 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171458; cv=fail; b=AY8u9ug4MBkuzgyBXQp+5YH8sQ94gms7wh+BXLY/Ng2vx115Z0k5KZmLsiKg23tGy+OELzk6ncD0vp1QKM/wP/iKLf9rNEarS+XpQ716ik6f2aGFzCuus+087cwh8cFfN1YcTG2HgXp0DMDN4zM6hSvvfqfFrdtdJDOcnRsfQUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171458; c=relaxed/simple;
	bh=6jdX2zxMlEDQ2YbYQOW5KkvvHatVsNmFi9Z+zQnT47I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bSvlg2aLVS1Nm0FCH15InjqvWiHkmVu0j9RbHlztz3lTbbyUZIJBu8UaKvn+DNuVi9GfeYX4n9+VdookYEEaMoBP+TulSVSnqPIN3GJwrM/1zqjTKUChnm46XLzxFBsMrMZr3m05Q2Xr5l03vgfNGtyPOytPgR6LP0zT6mqKnLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YAJ68X2m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qZKLee4u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SKItRt012815;
	Thu, 29 Feb 2024 01:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6l/Kk+7fQR4hIisRZolT+dZ0ZCSv7HTmAque3Ia7FWA=;
 b=YAJ68X2mreLSL9Cbf9X4SATzZ5hYEmZn7ruCrwL+EA4kNjgTYieg71QJ3ifW4c7KHImd
 FHrn8zxPb80C2FUdLDgHVrl72vtkb1KmNphVuv8D7lhXjNPj/96gzh7xlU+h1CgrxvTl
 /gNRXDhNDLWBSTTSnbpJfZCCY3gMWSOnm+YHGbVXBygBMFU368bmSZemOeviOM2q68wJ
 ikBbTkDwbuRYHkxZH/G/8wqyHIluYHiM7zoVdSUcAhlnXzFhgVsYRzUoGjUZLaz7Q4k6
 hXrXryGZ8sg1TCYiuqMujJ06PZhHxbq1Xq8z97Rl2euJNAiNFiAJXupeSt8/bbT7dAAG 1g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784m5ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T11d39001690;
	Thu, 29 Feb 2024 01:50:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9tbpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJCB0Slu2Ht0SHLV5i7ydY8OSyHO/tjCqKK8Kf0PkYjpR9eAzO+G6zpJ7oqTSzsyoY8CqLZL8GeR+5K2HdiW6pJcNBW0nYRuUR9TBAInYmzFwHac9u1BMX6wLYrlEoIUgJfetVo1JWPUllF2UKEn8jdb2tiz9+Fl1MdhYI/7BJfOJiVNJS7XK9XT1pO6vNw4J9FMPHbHyMmiVLYgYuOo0QhRvyKWc1uxWb2uPgy/g4ytWEWYNluqfFCXx5UcYSsz5by7x13kygDB7XYmY9KRaTMjDFVcGkRzH+U3CQuHEeXkxBEMoRiwWJz+S3JNDrDWfy+4k1knmKtGR17Vt/5wNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l/Kk+7fQR4hIisRZolT+dZ0ZCSv7HTmAque3Ia7FWA=;
 b=QmZTFObpa7En1Bf4RkNcMlJIlVgFGWg2WeXuf289yQdMypRR+Hhx9KOEYS8fjcyLwgBf8pVLl/fbKzOWc8NtSQp66qNhhJJLR8BII0o9kP7/z1ZKcjUWhEvDilBbfQ5btXTFPffPwDzD88/Kr31ZoCCHv9RGvyFDzkHVJDKwHdkzr+GbHaDcde8ovXnvtUKfhDPw3YPi9RBir7iGg3k535QgpjPmtuwA3HP5++/PdtXSVxEzB5ilfEIngiLfIoxQfYO2fbmoe0qhtvujegaMdvGYHpEMt2HWUaBib88SXmCSSWnV43kMseO5zDGsqb/qCWTT6x93Rjx7BtHpXJ1GMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l/Kk+7fQR4hIisRZolT+dZ0ZCSv7HTmAque3Ia7FWA=;
 b=qZKLee4uofOgtg8UPs/4GDHMbyOodWbcFyzHLeBONoc6SnNNZVx6O54EvMQY3G1E1hn0meEDkCAyPoTyPxb57T1T/NouqJaHLRczfCzx69vTWb1mTz3kmm2c+rUKmIpQ5nY5OMSxVJFNp4eDXB8WmNFV7RB9dJASAYbNgH8uRFo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 01:50:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:50:49 +0000
Message-ID: <6c50f2c1-407c-4ce8-a2e7-50cdd3b164a9@oracle.com>
Date: Thu, 29 Feb 2024 07:20:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] btrfs: create a helper function, check_fsid(),
 to verify the tempfsid
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1708772619.git.anand.jain@oracle.com>
 <3fe54b69910e811ad63b2f0e37bd806e28752e8a.1708772619.git.anand.jain@oracle.com>
 <CAL3q7H4EdcvJm4jAD+5-zm-WVAoaHhyy-9Q_1-P5pOWk_f6m=w@mail.gmail.com>
 <e4416120-e682-4a43-b79e-a930838bb64e@oracle.com>
 <CAL3q7H56eR0BW_BW08i6+sfQ3VHyh2S7DuffNRob6GVEWDSFQA@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H56eR0BW_BW08i6+sfQ3VHyh2S7DuffNRob6GVEWDSFQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc73265-8067-45c0-d769-08dc38c8da73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gJp8MMACMGPt1fA4KhR2XCMKFI1neXy9e/vVG1wwineFQu8j8qhAVwXNHzgEm3HE3aWsI4WM4Ca9WOABVddm/7JUme6pnuUj2C1PNvtp5KXyqykCprewdRn1GzMEvDrd/jAqTyvLPOFHjmzyVPdKcW60jUkU/NF7xMpzxK9m2XD9cnVVAogwJWbKFlJaB4H4u6fUY/uiL6AOMRyV8XA2NNqdi6sn9mKK+zfQ9nyj15YylUzvyFXxTyuDPZbvLwDuNzWT37vM2okehk9VvNs2j/zXQRsRY5bOK9XkM/nnTvI7H98/1mkjF1eJczq15woUdtY3WZYqSiWTRUPFyE12rQ4pVlIA7V2oJA9Rfjp+bW0zeOGM++lmjM1aH4fFvw5asp+qElb9vZaNUU6fFzcUeodi8GmAmIjQPBokoIMAw8QBRgidFTXp9wrdbTvHaCLm9iLeMjRUb6UgYPIDjvMDxjz58xZdcNax2oNGDcnUZWTUPCUbzl8O+49FsDKaazWdcGQyeK7wiMt1MRCAXo5jI0qZ/ZdNzzYcY7xR8xCc/R8Qo0njueh8RBixWuBKET+d1KsQqcuH25kGIUBR3rj5PXPKap2pcVmnV2NKc+LM82R4laFCDDhVpTTBrtnBcIJI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmlkNGtHQjVaUlMvNXFyTkIvTUlOdVFDVDZVVmxIdVRNaTdOcVBaa2ZPNHA4?=
 =?utf-8?B?cm5vZk5iN2Qxa1NIOC9BM01jRnFUZkRkL2Y3TXVaQW1oWnZUMWdYK2JIUWQv?=
 =?utf-8?B?YVVaTk9Sa0h0Zmh5TGUrL250TEtjZTNTNDltMVpMdVdsc0hLRHgyMW8vT2d5?=
 =?utf-8?B?ZlRJbGd4LzZtQld2S080MlFCa1dYVGxGTW84a01iTlY0SHNLczZ3MWhnek5s?=
 =?utf-8?B?RTVzTVdCUVVNOHZ6cTR3NWFvOGtndXh3dGdhM3IzeDhscDZQaWdGWGtlcXZK?=
 =?utf-8?B?eTFZeE9uNWxiMDVtTkdZa0wxWVZkejZGQ2laUWJCMW5aRmFIdXRoZFdnVkdU?=
 =?utf-8?B?eUYyUDFMUTZWZUp0K1B2UXhpeU55YVRVTzFJaWxWNjc1bG1EVi9jWlFRaXA3?=
 =?utf-8?B?QVlOVkxFUnFlY0lRVmtYTVpKNCtEaTV5S1RxQ2ZGcVdNaXZtSXFaeTVUVEQ2?=
 =?utf-8?B?RVR5LzJSVVJUeDhZbVFTRVA1bzNiYklUSCtFY2xxdktwSGRPUVFKWE0wWXhL?=
 =?utf-8?B?WXNCY09RSjFwSXdsVmtGRnY0eFN0NHdKbCtGWVhWdGtjNE8yTElIdnIyT1Zq?=
 =?utf-8?B?djBSQ3h0WkdNRkJtL2hibzJkelZDOFRLdVFFU3hDTWl4WisxZEI5VnBGbTFk?=
 =?utf-8?B?OEVSUzVtQzlOSXlOSFFMVWJNRWVFWTdpQ2FwbFVDRXBkQk5BOHJLM090cWhU?=
 =?utf-8?B?Nm9SNGhoWGdRZzQzdGFXaDh3aXc4cmlzWm5HZlFBMUdwcnlabDlpV2piQWFH?=
 =?utf-8?B?S0xaV3JJN0xFWU9NN3NnOW85bTcrc2ZMc0d6dXY4M1BXZHBjTXJHUU1QY0d4?=
 =?utf-8?B?dnk4d3gxNlFKMkdSK1k4TFl2TWdKaWgzbjBjaUZaUzhBTTN6cFlOUkZXbzhE?=
 =?utf-8?B?bEgxUStKM0REZUgzRFNDNzljMkx3Wm16UElWeDFUSGtqWHRsWHB3S1VqREVx?=
 =?utf-8?B?ME5Xa3F0OTdXSUJoOXh0TFRpUHRjVnoyVGRPUXlkMVhmZmxzMjBqREdUU2kr?=
 =?utf-8?B?Y3hFQ1NXN0M2ZEk5NlRNTVhzMVFVTXFZRHVVYWRGOHYvd2VZWlkxdnk5U2U2?=
 =?utf-8?B?VjViN1R6V1FIemt4VzlSRFJIb3NlWUk3YjVBUk9yWTdacHU4V01vU0xrZkdH?=
 =?utf-8?B?WW56aVFWb20zQXg2RUJyMThTYVVFV2pNU2g1NUpnOUlEbzNvQ2tYdjVMNjRC?=
 =?utf-8?B?Mm9rVU9FWGo3RVVVYlpXZTUwUnpNWTV2cC9zZWh0Z2N2MzUyMkJQc01DeXl6?=
 =?utf-8?B?OFYrTm1CUHFYMTFUeG1iWVIrb0ZNOHJ0QXBhSjJHOENRcmdlUUJadTVTbFk5?=
 =?utf-8?B?WnQ2K282aGpkWDRmSE9LbHg1ZEZ1dEdYTXFVKzk2UHA5UjdlTmsxZXR1UXJp?=
 =?utf-8?B?YithM2hrNzR6QXFJMDNLUlZiTFgvWVpZQmlSODd2U24wTU5WVWpqU1owTzla?=
 =?utf-8?B?OVZRZzJiVCt0S2VNZnVjOXI5WVExOFg1dHU3TWFTTnpscFYrWWo3VlFkTSsv?=
 =?utf-8?B?czA4b2o1elZyRzVOVVNDOWZIK1ByT0g4OElQOVdNcDlYbzZuOXJFbDNpQWFu?=
 =?utf-8?B?RUNwbWl4MXFUdWtKazZHZDQvQk0zR1FLUWZIVjhKRDdnd1NBdjhjRUtCQ05l?=
 =?utf-8?B?MEQvMUl4N3dtN0tLNXpBWStMOHROTWYybWNkbEVhcmcrNlBkcUkxVTRIcFkw?=
 =?utf-8?B?RFRuS2FsRHkvWDlxbWNvWWg5eFlFR1pjOEZ4eEhJYlhqTGphb1Btc2NuaThC?=
 =?utf-8?B?b2FuVVdlUTg1Z2FmOXJZbTBLUlRQRDJkSTErODBzQUptODNKN25ITlJCdytY?=
 =?utf-8?B?Wm1IaFJjc21HRUpyWElPNHc5NU52S09DZ3VROVZtbzcvMUhVczBQQlNUUkgv?=
 =?utf-8?B?SFAxZWdvRzFERE0zcHV6ZzdrTXZqRGdaeGozMjdSRk00VjlPYXczZHByQTZB?=
 =?utf-8?B?UFVLc2lCLzZpb1FsVFBjQmRqQkxJYW5KS2ZDaGxVSUdCT08zZDlqdXBiMWZP?=
 =?utf-8?B?dlZWMjNDUjZvbmJWOXd6dDVOU3ptMVdwN2h6cjl6bEw2bXZ4dktlb3ZPYjcz?=
 =?utf-8?B?RWxtUFRVNEdCN1ZHb0JXc2JmWjFseU9zVHREdDBEWFlDOUtVMHJIWGk5dlkz?=
 =?utf-8?Q?QTcoq0kha0ST4Q6GcacmkwRIH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QhzGiQtx8yU/+nWqoJEcOoulSp5cp6XAgrUXt6PHlCY7MGPXpZ7mOR9mHklFbgefLh5GY5eh311BBZdOzyiwOZnhzrEbqAuashWLshaRLbVzCy7gou6zP5eVtDoJU8rCYLcRRj8EAPW2rDuUMPPacXzg8pFZ0NhkYdjY9iE9oU6vNeQG8WVb1fL2NHkfPOAjsek4xwN5oUFvHXkG/6xcLPwZzMGl2GLWZjUUt5DXLbbHV+8lUrMDkM36l83ho6PvS2csXg3kxXQBh2OHb1eqlHC0xkscNFx4tfpAfTtot02OVEj7UWhw+YlAHv2HbH8yPegezX/TZ7PfZl4cFbybNJ1tjQNDjTB9Yt8XEteeqKwwpdwRl0UOnMkTKaYcwxXWqHzKhe66oGvsJDZywGD4X+9O/AWvVM2XBrkfopXwwTNTTdzhy8T/7hdCkd8+bhs7ko1VwS0trNdeAHyVpfEgswvKpgBx8um+fB6i0s/rBTjwLZ+GdApPJCIbSRYGhYNk0y9uK1wGwM7LaYEBrn2VVASrSBu6Yt2egpUmtT2sWX0Pg/yR4J2gHWnBVLMBk/PCI7AkIqsyQe9uFlOXg62vyi6s8+c8i4blU1X4LX/ji1U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc73265-8067-45c0-d769-08dc38c8da73
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:50:49.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aIk56TiEct805mRZ6g4Yf/RUouf4i90LwVtwo5iqMgvu2G48/YUWNp9oHjXpCeXSelfBnjWe1Xj0C6b1GjDbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-GUID: htBPB4_N_o1FP4MAm8Vmma0exUc-39ie
X-Proofpoint-ORIG-GUID: htBPB4_N_o1FP4MAm8Vmma0exUc-39ie



On 2/28/24 15:58, Filipe Manana wrote:
> On Wed, Feb 28, 2024 at 9:36 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>>
>>> function should do the require for everything it needs that may not be
>>> available.
>>> It's doing for the inspect-internal command, but it's missing a:
>>>
>>> _require_btrfs_sysfs_fsid
>>
>>
>> Yes, it did. Actually, check_fsid() would need the following to
>> cover all the prerequisites.
>>
>>    _require_btrfs_fs_sysfs
>>    _require_btrfs_fs_feature temp_fsid
>>    _require_btrfs_fs_feature metadata_uuid
>>    _require_btrfs_command inspect-internal dump-super
>>
>>
>> I already have v4 with what you just suggested, I am going to send it.
>>
>>
>>   > Instead this is being called for every test case that calls this new
>>   > helper function, when those requirements should be hidden from the
>>   > tests themselves.
>>
>> However, I am a bit skeptical if we should move all prerequisites to
>> the helpers or only some major prerequisites.
>>
>> Because returning _notrun() in the middle of the testcase is something
>> I am not sure is better than at the beginning of the testcase (I do not
>> have a specific example where it is not a good idea, though).
>>
>> And, theoretically, figuring out if the test case would run/_notrun()
>> will be complicated.
>>
>> Next, we shall end up checking the _require..() multiple times in
>> a test case, though one time is enough (the test cases 311, 312,
>> 313 call check_fsid() two times).
>>
>> Furthermore, it will inconsistent, as a lot of command wraps are
>> already missing such a requirement; I'm not sure if we shall ever
>> achieve consistency across fstests (For example: _cp_reflink()
>> missing _require_cp_reflink).
>>
>> Lastly, if there are duplicating prerequisites across the helper
>> functions, then we call _require..() many more times (for example:
>> 313 will call mkfs_clone() and check_fsid() two times, which
>> means we would verify the following three times in a testcase.
>>
>>    _require_btrfs_fs_feature metadata_uuid
>>    _require_btrfs_command inspect-internal dump-super
>>
>>
>> So, how about prerequisites of the newer functions as comments
>> above the function to be copied into the test case?
> 
> Calling the require functions doesn't take that much time, I'm not
> worried about more 1, 2, 3 or 10 milliseconds of test run time.
> 
> Now having each test that uses a common function to call all the
> require functions is hard to maintain and messy.
> 
> Commenting the requirements on top of each function is not bullet
> proof - test authors will have to do it and reviewers as well all the
> time.
> Not to mention that if a function's implementation changes and now it
> has different requirements, we'll have to change every single test
> that uses it.

I was trying to keep the code optimized and avoid duplicate '_require..'
statements as much as possible. Also, I aimed to avoid '_notrun' in the
middle of the testcase, which keeps it inline with the rest of the older
testcases. However, it seems not to be a big deal, so let the
'_require..' statements be in the helpers. This makes the test case
look more concise and further makes it easy to make changes. For
example, if a helper is deleted, the testcase will still be fine
without bugs. I have updated the rest of the test cases with this
idea in v4.

Thanks, Anand



