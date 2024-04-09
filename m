Return-Path: <linux-btrfs+bounces-4049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C665E89D6F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 12:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A481F21FF3
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DEF839F1;
	Tue,  9 Apr 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i8E/vf8H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uSIrY9nG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96580629;
	Tue,  9 Apr 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658563; cv=fail; b=U+pxVcaRHQjR5JgFRe9LuaAaF92YK89aq6PM7lXt9zsruyRwD3NyqGSKvpiwQ1Xi7/hA36b9dtbWj8Fg8yzDOTv9t06tMZj0ykmNJ0dVHmN74sEYlmsRoII8o6DUe8Z3+iNRo1RAdigczzxSU/TcgfQAj32A2WpYurmXcSb/Wes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658563; c=relaxed/simple;
	bh=8cGHWdjcUm1w48mBeKMEXtjqpowgXXXKNCXy9zVWYgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ojMA5vX6aGRs9k9foweEHYzvykPPjSpPOQCu/WMDvP3JgmAcD5y5/wxGn2FD8ZoeCWzEXHribinfZSH3MQeVH4FP8kvDJ/v1M85YvOJXHWLPHPQb+RQiywSkR8RMPkA4B3V+PLUI8NOYInTd5clFo2ZXHp+EZuzjJjsIELpDXQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i8E/vf8H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uSIrY9nG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4398kh0V015341;
	Tue, 9 Apr 2024 10:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=joTOE9Y05a8jElWk+0OAVh5pttqmRzOamNwlYSMy9ys=;
 b=i8E/vf8HAGahUvOHKLgRC43eNfdCudLNinB4sJ3WcwPoP+k1ErgaplDiqbEFBMSLIPYk
 lgHXI2tSK6Wen06rCAgb4OBsUodRQWhS5i/9xKAp6xC+cSLmUMZA1kiPMFVH5/tem5fM
 xw1yBeSZ5/dCZikh4HO+yazadmxJb8ZhwI0Am1tsX3nUpM7PNPT2J19g0fgDwzp5gYnz
 AA9BQQAhj0e0KBJY3U9DmV5b4Il04ZI6VWYjK+1Wj7tCAZ54MZ6dmJZsKYTh/BtKTP11
 uIGEd/qP4V0K7Fc8rAADB5FA0/0w2eSRLh3wsG/Y6dPl3rl8XVVXfhaTGUdILrvZPGZv gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw024pq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 10:29:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4398PS9u003022;
	Tue, 9 Apr 2024 10:29:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavucu8ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 10:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZC6O39g+G2a2x+reQHBqEyseTBplNynB/153UK5jkOEXNuMV4hy9aNHracIAuo/BN+NEMvp7yuSbzxsNA8dJpCnsziR6aQbXLF0jH0DGBbhL/g3k++gR7yuiKjP6EOxZucMD0vo4ZD+HZczvgF7FtH16D7+WD+2wAYB+9jzT4IvzKGDFTV0tm0EBxIlV25mB1hFgmv7hdxFPBWiKvXopvYLNqfCj+6rjo6DWmpXPbwme+N7FRKNiqCKdKRGYx64a34WUq5x+OlefqTqBooVXhoe0IqXSc5KT8L0ngx9pIU/NRzkme5bAy2gLzE/En/pJlR2/ai8gY6PYUMe0Jof2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joTOE9Y05a8jElWk+0OAVh5pttqmRzOamNwlYSMy9ys=;
 b=TLXLDoq6s2TZrF2NGOgUOHV+dJOkbIs61eYdrL2Nca/L7HMIiIOdN9F/G4i2NHI37xPHmQKigJTcOg0B/K2XSv0CSwuUR7fJEswFy69/tDYk2D8j/ZyG7K66f7gLah4l8jHUhutKzCp5Qkhylw39diRap3s4bzrxHL0nUhbp+Yn3kcjRKY6Myz1vfpPE+JhYrS+qAtRWZ3dhdDEE+sGS+En9H280U3c6IxBnSMpkk8fiCiJBpaWxOpb6GBvCcsKGlPfKWnpFzSHanCPhizAPSjyMKB9V28+9eO8H2FEBx+nEUsF59AJMGZ9V8yQfl8KKMl/idmD6m6nN9GHVDas7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joTOE9Y05a8jElWk+0OAVh5pttqmRzOamNwlYSMy9ys=;
 b=uSIrY9nGEJiPAnOdXGIQkCEJxvfPN4n8RPC7wr0+ZWFXIgimT6VLblK022lR3MnP8WAr5WXSVeJrYRkd06j/QU2QuaCio5FQyUXpYAwjgK+AZxSbYpYgK/wE1qFyQPrWEwgTi9+cFe0sx3qkwMvCmmKtle0HPeYahzEL1kRobv8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4331.namprd10.prod.outlook.com (2603:10b6:5:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 10:29:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 10:29:11 +0000
Message-ID: <1939cd62-770b-429a-a261-c130f78bb7ea@oracle.com>
Date: Tue, 9 Apr 2024 18:29:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] btrfs: new test for devt change between mounts
To: Zorro Lang <zlang@redhat.com>, Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
References: <ab39a4385d586a0b82dafdec73f625cf434fe026.1710184289.git.boris@bur.io>
 <20240403112049.awm3kvsl2zeukjvr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240403112049.awm3kvsl2zeukjvr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gUqEh5NsoOMMBRWV5y11It1zaI/eE9cL0ANw/jN6A6sZhiOT59h3qeU+MvrJYXyup0CdKl0j6/XjkKuhkHrNKMpKKKOZV4M3Zti5Z6pf4uyqlXDGIP9GPM+67IQMtFThkU5jp08dhkkFLh7Jg6c4kLX5OIGN5xv0lr3H+qKZhzKUDNiH6qTnpgZUmj06qxT6kwQH0cxixdo+aSyIn3TxEi3j96boJ2m1eRquQJSHe4EyBd3P7c6C2mR1d/RkaIin8P5H92A/UgcOw8gEPb1xbGSvMlOR5V+IvFFUTnCRtmxL8lGPxf9uBPrZg7heBC7+vt7q00PBrS+pdAgdGvHisKKqiS/wz4a/AZv/XiD4Km6WpMFTC1Lli2ER9RlrwE8cxSIIH+9/f/B8TJwNX+kN3/yq0wv8JTCbXABGv3EjvsVlScvhuhC6d1T9OVLnJcGlpPVEZwF855YK/9CKMdJCiCn1o6tlou6q/ZG+EopQfbFJCfs1CORsIbGiPRvnA6bMFuo1ZirzLILxYX3aIzGV1eqJcRqQsUbWPC8gjSoYjmtM7GVRZJzzBoA9rfgvY4EvzxPzl5n+TK+vxEXMrc5gc3NEzrTecVMQYVm//s9xw7wRG99haeTEf/kaCCuson3saQeMGXd2OKTYLV5FcaUYuRbKVvB8WVgUCIBhxayzwcA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amdqOGp0Y2tOdTVOenJUOFAyazRvZmxXZU4xVUdSTEc4bUZXemMweml0Vk5n?=
 =?utf-8?B?MUdackoxUHJCWVQ4N0pzZXpLRGZQbUJ1aldvRjB2dHVVaFFHdzdMSU1MUldx?=
 =?utf-8?B?RmkxREpBU3NORXVsWnAwVk1wRjBvUm4wMVRrdkV0L2svN3YxRTltVWIwSzRC?=
 =?utf-8?B?RURoME4wK2VEY3BUd1RvSWRZRnQ1c3A2QStxcXZXL2RDeWJXa1kvNUNncHg2?=
 =?utf-8?B?a1Q2RjJKWXdpeVRKOVNaLzdST0hkNmxrdTBDdEV1UVA3MVVQeFNvSWxKekwz?=
 =?utf-8?B?eklMR0Vja1FuN0taZmVYK0ZOSWl2SFZkQXFtQ0NVNmNkM0ZBTDlhMTRSMGJH?=
 =?utf-8?B?dkZrd1J5bXpYeTMzaTlGNHQxVzNrWkI1WmxmMU1GeC8xemlkTUtNNjZSZGZV?=
 =?utf-8?B?bVFTOEhhMm9pQ1I5MlVqcE5yT1NiZ1pTWkVFcmRvNmpsMUtweDF4dElsRUd2?=
 =?utf-8?B?SFlmZUVxYVRlUmQ1eWppYjFNMkJGeDJtK2JYeUxuRjFqOGsvVTZTZENPeGo4?=
 =?utf-8?B?bXhWdnV5V0UyQTlOOHQrdC9Gb2tKSnBtUE5Ud3NaWnFQNWxzNEdRdGo0UjBG?=
 =?utf-8?B?V09PQUJTUWIrVk5oZkc2Q2JwUVI5WHJOTEtJWnlKQlRZTmJiTnMvdmVubGEw?=
 =?utf-8?B?R0F0K2t5VS9VTmxHUGJmQVVURnVxYW0wYWJCVXEzbnFyc3E3NXh5b0NrNm8v?=
 =?utf-8?B?d3o5dGNKSkJnaVdNbkVPd01wR1RLSGorUitSRE9rY2JVZDV5eGU0YW5RQ0l4?=
 =?utf-8?B?QmdsSnlOVTV0NmRTb2YyMDcxME1kTXVsY1NNZDJ6WjBzaFpyUkdDQUV1QmNx?=
 =?utf-8?B?K0RCeGJRdjB6SVE3VjMyUGo1K01CZUh2YnI2TlRibWRETUxjWElDMGVEV29Z?=
 =?utf-8?B?amNBcTNPQkJwN05hL1ZOeG94a0crM1JybWxSOCtjMGFTeGhNcWwxWUxRY3lY?=
 =?utf-8?B?Y1gzbDhGSTk2eXN3Mmtsa2dTRXFEZnBiLy9ISTZlQ3p1cjZQdk1RL1hPMjh5?=
 =?utf-8?B?dUxBRDVQcU0vWDFpN3hmRlNGZW9OL1d3YjhwalNDSXZvS0ZTS2piejdjNFNv?=
 =?utf-8?B?Z2tjVWFTb1NFYkhOVG9KQ3FHYVFlMVRraFZQQ2lRemFmcElQRHFRemJWRjlI?=
 =?utf-8?B?VUZMcFZ2WkVhQkRSbzZYT2d1RWJYV2pyNWQ4R3hrZS80MTlxbUVBVHczcUdY?=
 =?utf-8?B?OFhIVCtiWEdVVlQwQ1h5SkdueU1vS2lNTUhpMVlrV2czcWtzamZCT0t3L3dW?=
 =?utf-8?B?MkdTYU4yMyt2SEw2UUNVRjh6V3Q0eVdWRFhKNm5OQUdob3NobVdDWTdKY1Y3?=
 =?utf-8?B?UEJYYXo0M2tTaTB5YmJRTldsNUJmR0tidStmVDkzYlhUMDRiQ3p1S1ZlTno1?=
 =?utf-8?B?TEVFQ05hNExlTlIwS1ZpU2MvTFVaU0lGZHI0Rmo4T1RCN254RDRMNUh2NHpy?=
 =?utf-8?B?azl2U0ZwL05FRzZqZHRxcHNRdVRLYll2QzRreHlTQ3IxNEZIU3BVdkNObjBT?=
 =?utf-8?B?NThwaGJza3hmcWhmMWFFYkNNQ2ZnMFA2Q2ZPQTF6ZnV1NEZINVhUSXhHR1dv?=
 =?utf-8?B?SFhvbkFTb0hvK2hTdCtGWjhjc0x3TTZRc2k1cFRWYmhiN25Dbno1eHdOSmNk?=
 =?utf-8?B?REVEbHlkSmVXM3NaZkhNeURNWnY2R1JodWxpcmdxZlR5WUViOXFURVgvcFJX?=
 =?utf-8?B?WTNsU2pjbnV6dGhXbFpaM2hLSEZrUTU3V3BnUlVuamVrMGs1L0IrcUsvczJI?=
 =?utf-8?B?MGVzOVhOOUU5Sm9sN0cvVEpkRjFYdzdQNFR5V2J5VlZ4QWMzbTNkU2xvMmFD?=
 =?utf-8?B?TElTL3hvT0N0aVh4ZXNISVpmM0Ixd1BRNisyMytGL2s0N2M2NnkwcXJmdUhK?=
 =?utf-8?B?dzVJZWRwVHFLZUpwYVZCVWpRQkVzaktwdUVJSHVZOW45VWdtUHdndERqa29m?=
 =?utf-8?B?R0o1K1NUa08zRVlhSjNPbStwWm5IZjRHb0tTWDZJME1pSmtqOTRXcFJIbEhH?=
 =?utf-8?B?VndPdkFLTXdQNGdaQXc0Q1BidWYrZU8rNllNaFNhZjN2dm9GQ1BhMGRPN29R?=
 =?utf-8?B?Yk9McHYxVCt5MDNrNnJwZEQ5cjg1MHlNb3N6MndjYXR2REoxSG1lbE5vdGhV?=
 =?utf-8?Q?d3WHJdPLZYfbPn6XQqb0o+1eA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DkWbvvNTar0vn03d+ymO8Rh5IjJGUW4A09BPz+e+Dzdw82CIfXlmdJRDwXviZhPX1IxykfU+IK/6/siGl+l0KbD0nWTgxrQrUjRaD3Iu2ALEaMyI+w5hVQHScgE5K/koeGZyPro0YEcmN4nj31Z18NYaixIypHZCK3nGX+yyqQKLUwzqVWDsVQmk8prGYYdjmGoQdEjV27cal/14Zb/Al5mxh0seoFrTWXPHreGY9ng7iLlnR4vL50aamiHrt29gJRQRMRjP261uAzeU4yiyABDbX42PRV/JgEtVmdHxE18ut5g/bdO6njn5RbhL4fSd2TzyGS0rGWKkhrpJ35tSpg2dgEH8GFgcelGTJfL1mWcLvALoxdIoyNYM8/29bLIjZ/YRLqX3T6Rtoc73FdtMciXnXAKke0Borfm0E8L63CIxPlOBl5F7vENCY1UJk+48qupmbhk8d9rLKADN98QTgpXxXNlRDUBBPIXy7Ok+CfTdBPbA5ZH70sxAIckejeo+OzUYvbWTCSlobrMgUzHsWoG5DR6e8tJ8lzPwgLJFlKIgFa9LeQ45VI8QQ9rPzEmaCKDPdMUJFWu+SPT1NhcRo6M5si7N2zB0PZ7DWqtpWlA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68858024-2da2-485c-0e7c-08dc587fe584
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 10:29:11.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46IXFR4kGEtofkVugtftABeULgm1toYKpaJflEDB51f8hrTKn6lA+dZWbK6L6TSsfGAb+rF2+XPlv4a8VpOCWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_08,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090067
X-Proofpoint-ORIG-GUID: 4_6cKwf6fWKTFM-ZLmuQk_YCPMIkxIrk
X-Proofpoint-GUID: 4_6cKwf6fWKTFM-ZLmuQk_YCPMIkxIrk

On 4/3/24 19:20, Zorro Lang wrote:
> On Mon, Mar 11, 2024 at 12:13:44PM -0700, Boris Burkov wrote:
>> It is possible to confuse the btrfs device cache (fs_devices) by
>> starting with a multi-device filesystem, then removing and re-adding a
>> device in a way which changes its dev_t while the filesystem is
>> unmounted. After this procedure, if we remount, then we are in a funny
>> state where struct btrfs_device's "devt" field does not match the bd_dev
>> of the "bdev" field. I would say this is bad enough, as we have violated
>> a pretty clear invariant.
>>
>> But for style points, we can then remove the extra device from the fs,
>> making it a single device fs, which enables the "temp_fsid" feature,
>> which permits multiple separate mounts of different devices with the
>> same fsid. Since btrfs is confused and *thinks* there are different
>> devices (based on device->devt), it allows a second redundant mount of
>> the same device (not a bind mount!). This then allows us to corrupt the
>> original mount by doing stuff to the one that should be a bind mount.
>>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Boris Burkov <boris@bur.io>
>> ---
>> Changelog:
>> v4:
>> - add tempfsid group
>> - remove fail check on mount command
>> - btrfs/311 -> btrfs/318
>> - add fixed_by annotation
>> v3:
>> - fstests convention improvements (helpers, output, comments, etc...)
>> v2:
>> - fix numerous fundamental issues, v1 wasn't really ready
>>
>>   common/config       |   1 +
>>   tests/btrfs/318     | 108 ++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/318.out |   2 +
>>   3 files changed, 111 insertions(+)
>>   create mode 100755 tests/btrfs/318
>>   create mode 100644 tests/btrfs/318.out
>>
>> diff --git a/common/config b/common/config
>> index 2a1434bb1..d8a4508f4 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -235,6 +235,7 @@ export BLKZONE_PROG="$(type -P blkzone)"
>>   export GZIP_PROG="$(type -P gzip)"
>>   export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
>>   export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
>> +export PARTED_PROG="$(type -P parted)"
>>   
>>   # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>>   # newer systems have udevadm command but older systems like RHEL5 don't.
>> diff --git a/tests/btrfs/318 b/tests/btrfs/318
>> new file mode 100755
>> index 000000000..796f09d13
>> --- /dev/null
>> +++ b/tests/btrfs/318
>> @@ -0,0 +1,108 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2024 Meta, Inc. All Rights Reserved.
>> +#
>> +# FS QA Test 318
>> +#
>> +# Test an edge case of multi device volume management in btrfs.
>> +# If a device changes devt between mounts of a multi device fs, we can trick
>> +# btrfs into mounting the same device twice fully (not as a bind mount). From
>> +# there, it is trivial to induce corruption.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick volume scrub tempfsid
>> +
>> +_fixed_by_kernel_commit XXXXXXXXXXXX \
>> +	"btrfs: validate device maj:min during open"
>> +
>> +# real QA test starts here
>> +_supported_fs btrfs
>> +_require_test
>> +_require_command "$PARTED_PROG" parted
>> +_require_batched_discard "$TEST_DIR"
>> +
>> +_cleanup() {
>> +	cd /
>> +	$UMOUNT_PROG $MNT
>> +	$UMOUNT_PROG $BIND
>> +	losetup -d $DEV0
>> +	losetup -d $DEV1
>> +	losetup -d $DEV2
>> +	rm $IMG0
>> +	rm $IMG1
>> +	rm $IMG2
> 
> losetup -d $DEV0 $DEV1 $DEV2
> rm -f $IMG0 $IMG1 $IMG2
> 
>> +}
>> +
>> +IMG0=$TEST_DIR/$$.img0
>> +IMG1=$TEST_DIR/$$.img1
>> +IMG2=$TEST_DIR/$$.img2
>> +truncate -s 1G $IMG0
>> +truncate -s 1G $IMG1
>> +truncate -s 1G $IMG2
>> +DEV0=$(losetup -f $IMG0 --show)
>> +DEV1=$(losetup -f $IMG1 --show)
>> +DEV2=$(losetup -f $IMG2 --show)
> 
> _create_loop_device ?
> 
> 
> 
>> +D0P1=$DEV0"p1"
>> +D1P1=$DEV1"p1"
>> +MNT=$TEST_DIR/mnt
>> +BIND=$TEST_DIR/bind
> 
> Not sure if these two directories will be taken, better to remove
> them at first. And use "$seq" (or others) to be a prefix or suffix,
> e.g.
> 
>    $TEST_DIR/mnt-${seq}
> 
> Others look good to me.
> 

I have made these changes locally and included them for the PR.


Thanks.
--------
diff --git a/tests/btrfs/312 b/tests/btrfs/312
index d30e312f8689..89b548a0ad63 100755
--- a/tests/btrfs/312
+++ b/tests/btrfs/312
@@ -25,12 +25,9 @@ _cleanup() {
         cd /
         $UMOUNT_PROG $MNT
         $UMOUNT_PROG $BIND
-       losetup -d $DEV0
-       losetup -d $DEV1
-       losetup -d $DEV2
-       rm $IMG0
-       rm $IMG1
-       rm $IMG2
+       losetup -d $DEV0 $DEV1 $DEV2
+       rm -f $IMG0 $IMG1 $IMG2
+       rm -rf $MNT $BIND
  }

  IMG0=$TEST_DIR/$$.img0
@@ -39,13 +36,13 @@ IMG2=$TEST_DIR/$$.img2
  truncate -s 1G $IMG0
  truncate -s 1G $IMG1
  truncate -s 1G $IMG2
-DEV0=$(losetup -f $IMG0 --show)
-DEV1=$(losetup -f $IMG1 --show)
-DEV2=$(losetup -f $IMG2 --show)
+DEV0=$(_create_loop_device $IMG0)
+DEV1=$(_create_loop_device $IMG1)
+DEV2=$(_create_loop_device $IMG2)
  D0P1=$DEV0"p1"
  D1P1=$DEV1"p1"
-MNT=$TEST_DIR/mnt
-BIND=$TEST_DIR/bind
+MNT=$TEST_DIR/mnt-${seq}
+BIND=$TEST_DIR/bind-${seq}

  # Setup partition table with one partition on each device.
  $PARTED_PROG $DEV0 'mktable gpt' --script
@@ -59,6 +56,7 @@ $MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 
 >>$seqres.full 2>&1 || _fail "

  # Cycle mount the two device fs to populate both devices into the
  # stale device cache.
+rm -rf $MNT
  mkdir -p $MNT
  _mount $D0P1 $MNT
  $UMOUNT_PROG $MNT
@@ -76,6 +74,7 @@ _mount $D0P1 $MNT
  $BTRFS_UTIL_PROG device remove $DEV2 $MNT

  # Create the would be bind mount.
+rm -rf $BIND
  mkdir -p $BIND
  _mount $D0P1 $BIND
  mount_show=$($BTRFS_UTIL_PROG filesystem show $MNT)






> Thanks,
> Zorro
> 
> 
>> +
>> +# Setup partition table with one partition on each device.
>> +$PARTED_PROG $DEV0 'mktable gpt' --script
>> +$PARTED_PROG $DEV1 'mktable gpt' --script
>> +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
>> +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
>> +
>> +# mkfs with two devices to avoid clearing devices on close
>> +# single raid to allow removing DEV2.
>> +$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 >>$seqres.full 2>&1 || _fail "failed to mkfs.btrfs"
>> +
>> +# Cycle mount the two device fs to populate both devices into the
>> +# stale device cache.
>> +mkdir -p $MNT
>> +_mount $D0P1 $MNT
>> +$UMOUNT_PROG $MNT
>> +
>> +# Swap the partition dev_ts. This leaves the dev_t in the cache out of date.
>> +$PARTED_PROG $DEV0 'rm 1' --script
>> +$PARTED_PROG $DEV1 'rm 1' --script
>> +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
>> +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
>> +
>> +# Mount with mismatched dev_t!
>> +_mount $D0P1 $MNT
>> +
>> +# Remove the extra device to bring temp-fsid back in the fray.
>> +$BTRFS_UTIL_PROG device remove $DEV2 $MNT
>> +
>> +# Create the would be bind mount.
>> +mkdir -p $BIND
>> +_mount $D0P1 $BIND
>> +mount_show=$($BTRFS_UTIL_PROG filesystem show $MNT)
>> +bind_show=$($BTRFS_UTIL_PROG filesystem show $BIND)
>> +# If they're different, we are in trouble.
>> +[ "$mount_show" = "$bind_show" ] || echo "$mount_show != $bind_show"
>> +
>> +# Now really prove it by corrupting the first mount with the second.
>> +for i in $(seq 20); do
>> +	$XFS_IO_PROG -f -c "pwrite 0 50M" $MNT/foo.$i >>$seqres.full 2>&1
>> +done
>> +for i in $(seq 20); do
>> +	$XFS_IO_PROG -f -c "pwrite 0 50M" $BIND/foo.$i >>$seqres.full 2>&1
>> +done
>> +
>> +# sync so that we really write the large file data out to the shared device
>> +sync
>> +
>> +# now delete from one view of the shared device
>> +find $BIND -type f -delete
>> +# sync so that fstrim definitely has deleted data to trim
>> +sync
>> +# This should blow up both mounts, if the writes somehow didn't overlap at all.
>> +$FSTRIM_PROG $BIND
>> +# drop caches to improve the odds we read from the corrupted device while scrubbing.
>> +echo 3 > /proc/sys/vm/drop_caches
>> +$BTRFS_UTIL_PROG scrub start -B $MNT | grep "Error summary:"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/318.out b/tests/btrfs/318.out
>> new file mode 100644
>> index 000000000..2798c4ba7
>> --- /dev/null
>> +++ b/tests/btrfs/318.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 318
>> +Error summary:    no errors found
>> -- 
>> 2.43.0
>>
>>
> 


