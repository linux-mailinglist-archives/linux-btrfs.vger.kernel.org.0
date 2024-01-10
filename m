Return-Path: <linux-btrfs+bounces-1335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5E829175
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 01:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670411F25559
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 00:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBE2579;
	Wed, 10 Jan 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MYxf8Tts";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W7Nv7K6f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5220FD
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 00:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40A0Xb6L019873;
	Wed, 10 Jan 2024 00:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=njKQ5E6IXCEPr02QMcRDEmvvgFLNCXbRHGSKEatn8Ls=;
 b=MYxf8Tts8hZtEJxOyUo8ZBPcEwSDRIwo+I/bBaIyPQmO9I9EHZwUz4o4ISt4DdZEw7tj
 ambqhXda2m54OPjX9ZdzkYB1Mdq3Vnm6GeF7VTF50oGRuEPGwg/yebQtcsWDM0gjW3pq
 6/lgPRyoENxZ9MYTZF8EtvcJ+4TBSgCyf1j0S7rT+5NSrT9dhvob3/xCO57zeVqwTFJ4
 8laXsvVbn7X0vbNeV3hYmMgn66i2pvU1xC0e74n+Uz+EyHphST3iFx5ZOwh1o+8nbCLp
 LI6o5GX1mTh1M+hZuBleTWp4gy8n8ZV8au+1WEG2phcy+XNweRZ8wmvrZ0hhswQEBfik ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhb748mn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 00:34:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 409Nppku008684;
	Wed, 10 Jan 2024 00:34:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuujtw3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 00:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG1XAGTzBSr0gIZBUkDe3E15KdeFxQyUXTgkfO+lfSLETndwsb3iZP68watpp75pllaH1wn7p7MficN2NksEZphjNWrY2XjidDCjyV8dqT4Qu5mAwZ1tNolWcoQYd19RuO0sbQ/KXkFJSuqkS43GwdhjEKIe7Le5TvmZvEjTOtSm38dcOdVQTKWz6iaZvToSoYQ4tmqSM0pXdvQbn8NOrR6dgisz3bIJSMIhlLfZ9de+XCGbQkrRqNILoyZ8v+o+XimAX78iSZVbbObUj7/SHCtQ/L8o6LLFzI/tAhXc+EtBpv6ApXwY/JIMkNwhptbESOvONRf8MeiPJPE/AGUdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njKQ5E6IXCEPr02QMcRDEmvvgFLNCXbRHGSKEatn8Ls=;
 b=Pqdi7NScSMj9IqcDbQkBh5BbTqzzID6DH5CPfSamqZcUcxYAfMK7JYLOckD0UWeb5Csusgy7mejlbOLfsadnAYKlUPF0Frcjxf1IqIsBAr6c1+vurLEgiYNR98PJj3knUrnPTRl92U+cecBVcOVW77sFo5v31Y6lxAsVb2b30US2d11sBsFHMgeGdFLpGL6tRs4y48h7CFbRsbiIZD6QDHTohivzwQadLqp5N/LjRjCtCb1Y2kfVHN9QprQ0UXhYtNggADJfBQTEVFgsjOQ5RchIQukUbiLZ3vSfF7XpDU1rn5iPS8y5MvwUSfRicII0Esf4TMpaARbJkCSMN6Visg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njKQ5E6IXCEPr02QMcRDEmvvgFLNCXbRHGSKEatn8Ls=;
 b=W7Nv7K6fyhvii2lwDL+E8x+DOiU5Lf2TGh0LGh0ztuliWyFdEzL2y5826o/zc+luQUGcoCYh/2g9cSMaBWxNlImuFDBmAV8YaX4gTy9O8l0Olgu86tJ6RQaQS8WMwRKK/f1A1Y8q4ySefQrEDSJWB/znUsYqLlRIojzSX6PV+A4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4404.namprd10.prod.outlook.com (2603:10b6:303:90::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 00:34:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 00:34:08 +0000
Message-ID: <a1089ac6-c08f-5022-2c72-1ce610dab34a@oracle.com>
Date: Wed, 10 Jan 2024 06:04:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] btrfs-progs: Documentation: fix sphinx code-block
 warning
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1704438755.git.anand.jain@oracle.com>
 <b5e7aa00820d6fcc680b201070f81e3178571dea.1704438755.git.anand.jain@oracle.com>
 <20240109161915.GJ28693@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240109161915.GJ28693@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d9b0e1-fe01-4431-7662-08dc1173dbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cKnNY1RNErNoDcMa9ZvkxZz2CnKljn36g/FMI5n2jmbXGMsvi5UICu3i8tf6GtV1SAi6gYIac5gmqtmOvWo65mDz2OhfjL4pYVnzKZPT4dvsMS2fqblAvVlchZaFJMmIuSwO4uOq85AjBbuovnumTBYJD/CNY+PejOvuB82ydXs80LLGtFEJDwZNBjbbaVV7HAor/g+JF6uPoUYbn2HcaCZENpB5Zv5M5Ga+Dg6JwFmxehW0wju1Iu6VVOcQ4Vi32vY+N1suin2SQnxMoJdr7brQDLjK4d7pz8k4o9h33R+7AAt9cGaKP1VFd97pqUctNF3KS80Q/lnHB7T6zwzT8KxPwsTIy421eeevN+qZyCCxyY6X+jrA8xhGxIbnBMHQRyZVXvXtcDVKIxMFzi/DUJd8D61VhoEg+Ct0i0Sd/v4pgvexv0v4n/OYSFJV4oX5dAsey/X3AW8tdR8BnreH7n3VIEDGGZO2nJETU8MRZUjgv6z0Q8JMbmaHqxGY66jpd/UWe3P3EIQvb9OUH+r46mf0OtS306xy+FYT//VrYW2fBL3f/wEYecAan1wtbNivxJIEDkC2A2fsPZpNTeIg/Kpk2T20ldIhbCm0efa+gSu1T0ROStJGMU4ZzUcFaudRM5+zpO9XXDSI0FaK7N5jLA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(36756003)(31686004)(31696002)(86362001)(83380400001)(2616005)(26005)(6506007)(53546011)(6512007)(6916009)(478600001)(8936002)(316002)(8676002)(6666004)(66556008)(66476007)(6486002)(66946007)(4326008)(44832011)(41300700001)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z2hzMTdDSmdsQk45QUN6Q0FLN1J4aXBDSmVkUFBhbGQ0Ym9uYXJWaEl0TFpC?=
 =?utf-8?B?dUl4VEpnWDhxKzV2L3pjUVJPeHRTK2g2TlIrSmxwRzh5eFdGUXQ5QXczZkd2?=
 =?utf-8?B?UlgwMTRsTVNNMjVRUHBBNGNZVE5CZ0pnRnFCdEZkcERsK1p2c0RaQnU2ZWZn?=
 =?utf-8?B?QTZjK3VnNjIvVU5ETHI1YkhwaExLWHZYN28wSnN1N0lNbmp0Rlk1WFlZaXJJ?=
 =?utf-8?B?YTVZd3Q4eGJNYXByeEJqVEJLdXFHK2VUeGJmRnV3UWZTOFc5RFpwWW9YbC9J?=
 =?utf-8?B?c3l0em1qNHRSajZVRGtBQStFV1ZoVGZNQ2ZZWEF3MXRIcGszMnlodENkcVp2?=
 =?utf-8?B?TjRzd05BYUVTK2s2RFh5U3kvN0h1SmlGVGZxYk1CVzJVN1ZqeWljVHVGOEg0?=
 =?utf-8?B?TG0xUUc4dldUR2oxODB2VUlNNEpZVWZXaitGL253SHU0ODJPbGcxQnRTS005?=
 =?utf-8?B?UWVPcStGeXplQWFyckd3b2tFL1BXNEE0MXE2dVhPVHYray9wMUhkSjJQZU9Y?=
 =?utf-8?B?N1hMY0tLYnJCTTI2VVY0SVJmb0krS2gyU21sdDA0S3VuRDR2QzlWU1hVaGRF?=
 =?utf-8?B?eDhrb2h4UzJJU3B3dUZkY2EzcVFOQjI1dkVzY1JZK08xWW9SN3VFTXB0RUJB?=
 =?utf-8?B?c0FIaTZsNkczQ3dZQ1JrL1l3SlVlZDcrdzNUWlI0SjcrNnpPZHVBK2tJWG1X?=
 =?utf-8?B?UCtpOUQ3MVd0Q2t5R1U4SE5XVCs1WWVuSmJmNXAxRjkzZVRWRExFYm9BNkts?=
 =?utf-8?B?UkhaZytnOGh4SFRJY1BPTWtwWUxDS29CSFhVc0o2SzZpTERteC8rQkJTcVBP?=
 =?utf-8?B?MnBGNFdBU3lGSnVaeGVNdFhUYnpYQmR0bytuMFo0ZERhQW5BTkx6MzhEK3cv?=
 =?utf-8?B?ZUVUdit1S0QvMnZzZHVOcjVMb3g0ODNqTE5tTXliOFNrRkJiRTY4OHViclBi?=
 =?utf-8?B?dXljWHpMaTRMenFEWUJaV2lMUndnRU9jblFGYmJRa3JpWWtwS25aL0RUWlkx?=
 =?utf-8?B?bWdxSHh1WXFqWHAxR3ZmV3puMEZsREN3aGZWMWVIZWNJMzU4V2VleGJJWmh0?=
 =?utf-8?B?eFMzYmVqK3VpMnl3RnJsVFRsSFMxVWJady9sNlE4bHYvVFAwZS9wOElFR3NJ?=
 =?utf-8?B?bTV2alF4QlRsNThiMXZVVzVLdU5QUndEY29xSmVvaDVLK25SMi9xWnRrUEpy?=
 =?utf-8?B?Z2g3TEZOOEVpTVptOVJGR052dlQyVU4rODB1NGhLbjRaaG9JdVZnQ1dlYVFk?=
 =?utf-8?B?TVZyMndUNTloazRGd1Z5TlR6N21JRCt2TjJVdW1OZlBHaXBiMnA2ZWlKOVhq?=
 =?utf-8?B?RmpCUTlLMjlBZHFGcWhaNGRRMEhwQnBTSEI0S2RHb1JGRVlJZFp0aXUwSDBn?=
 =?utf-8?B?a0hNaU5oZFBoR3NZcWVvVnpWd3lOcDVrYU9kMit5bU4ySkZ3RW1Fc0U5MmV2?=
 =?utf-8?B?L2lBTFF3QXMxUG5aUkJndnY1ZXU2UENkQnhxZmxSbDBKZW5rUnl1UmN1dkRM?=
 =?utf-8?B?V3RHcE03RXM1N3lUaW9kdUFqaHJsU3pJUnhrcnJiWTh2Wnk5VVlUTGdlY08v?=
 =?utf-8?B?cmpSQnNKT3lac0k1MGNVV0U4MnJrUzB5Vkt5Rit5ckpySTU4TzVMZ0MrZXl5?=
 =?utf-8?B?M3hKVmVrSUhTZEJxTlNJWDN0QUtaa2NpQUt6cStxYkEwaVkxV0hNay9GcDcx?=
 =?utf-8?B?dE9QTDN1NHFwN09wQng0NXozNEVtUEc2emJKZnJXemZjb0NOYnVjOHJOdUdT?=
 =?utf-8?B?VUEzeEJ1VDY3UysxSXNTNFd6eFhqT1kxN1lhRVNWcXY5TmsxczdHL0FocmlR?=
 =?utf-8?B?WmxpQUs2cGNjaDErU2VGL091T3hBUlUvNUo2ZDdEUjczM1FHM1dZdUlWV3dl?=
 =?utf-8?B?aGY0Y2JXRHZMUjc3cTV4NzAwRndNQy9BT0NmVFFEZFNWUXMzQU0wU3FnSnRy?=
 =?utf-8?B?QnZxb2JLSHNseHVidHVTUlZmcCtvVGpERU1OQnZQOWtNSTFodkdWR0k1UWJX?=
 =?utf-8?B?YW4xTktWNE5rb25ObytmaVhuKzd3OVNLbnMxL1JNQ0dDMTRjMWhmQU9NckhD?=
 =?utf-8?B?S2Jsd3ZON2U2SCtzdjBBcEZtdU9mV2ZubjhacEJvcU0vb3RxWFBpRDNENDU2?=
 =?utf-8?Q?a9gsg6K4u4xPLUfer91//CbzL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	idgQqJCYgtOhUrR3Cqt8Myy0ntjJIKqp7O3vJG/qmVDdMk9xbceikEV8uUaJd/TI2Qq7ocgLqciPkwSz8B7Nlta7VDoSgWJus2iWu0vyTJgCWl0tq6rYZ2amzMn57NiIPpgndNCTO5EB4RBaixumCff6c3mz0T21b3Thw7hTxBgn8FON0a1J7RfUwTm0JHpJi5w6ILdREURzWVZ84PKH0ewU5RwW5Km7eUsubSl2GSRwCrl9b06PsEkH2I/4l3lkLkX7SO+/d77MqyMeiFBSYvVKhuYvHX1uOfQgc8dMcYgMtvpvu/zRM5gGMyrTxvFicIKEUuLKciTv/S+I/vEMvgIP8KN5oLfbyLIA+SjeotsWWJAQryMdnSjM197Cyo9seKM4pU1N/EuRnv53nXnKGftVGRrVDEC84gvJNygcgrmJxdDqrkKRoXGFHx5jHd8cglt0oEgd1jg4qilmBaE71aQESJwUXPEEV5QLlWMx8EB7XxyQmLcDGQXnzsB+JtpfsYriwJd0JUqncEd8WtOnfkqo47T7WRxddvOU3g72NdZk2CGi6K37mLU5KPJRjdSK11kMk2qNbObel1h0eMrDPwdKgQxgF6N8atxUhEP+sSQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d9b0e1-fe01-4431-7662-08dc1173dbb8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 00:34:08.6527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BQesY7n++ZoZnpbRwyEwpXJQ6/ZDFTO8DPJ1bLW86HTQVXAVyOPIzrc6wG8cLLNm/lY8uQAtxruXANcTDiuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_12,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100002
X-Proofpoint-ORIG-GUID: ordfVmNCKiM4FPzfi_eLnwu8eCTrW76v
X-Proofpoint-GUID: ordfVmNCKiM4FPzfi_eLnwu8eCTrW76v



On 09/01/2024 21:49, David Sterba wrote:
> On Mon, Jan 08, 2024 at 04:31:07PM +0800, Anand Jain wrote:
>> diff --git a/Documentation/Tree-checker.rst b/Documentation/Tree-checker.rst
>> index 68df6fdfa0de..c0e5e316d958 100644
>> --- a/Documentation/Tree-checker.rst
>> +++ b/Documentation/Tree-checker.rst
>> @@ -30,7 +30,7 @@ fine.
>>   
>>   A message may look like:
>>   
>> -.. code-block::
>> +.. code-block:: text
> 
> No syntax hilighting is specified as 'none' elsewhere, so I'd change
> that to be consistent.
> 

Yeah. I'll update.

>>   
>>      [ 1716.823895] BTRFS critical (device vdb): corrupt leaf: root=18446744073709551607 block=38092800 slot=0, invalid key objectid: has 1 expect 6 or [256, 18446744073709551360] or 18446744073709551604
>>      [ 1716.829499] BTRFS info (device vdb): leaf 38092800 gen 19 total ptrs 4 free space 15851 owner 18446744073709551607
>> @@ -54,7 +54,7 @@ checksum is found to be valid. This protects against changes to the metadata
>>   that could possibly also update the checksum, less likely to happen accidentally
>>   but rather due to intentional corruption or fuzzing.
>>   
>> -.. code-block::
>> +.. code-block:: text
>>   
>>      [ 4823.612832] BTRFS critical (device vdb): corrupt leaf: root=7 block=30474240 slot=0, invalid nritems, have 0 should not be 0 for non-root leaf
>>      [ 4823.616798] BTRFS error (device vdb): block=30474240 read time tree block corruption detected
>> diff --git a/Documentation/ch-subvolume-intro.rst b/Documentation/ch-subvolume-intro.rst
>> index 57b42fe7a97f..3a138f221cc6 100644
>> --- a/Documentation/ch-subvolume-intro.rst
>> +++ b/Documentation/ch-subvolume-intro.rst
>> @@ -3,7 +3,7 @@ file/directory hierarchy and inode number namespace. Subvolumes can share file
>>   extents. A snapshot is also subvolume, but with a given initial content of the
>>   original subvolume. A subvolume has always inode number 256.
>>   
>> -.. note::
>> +.. note:: text
> 
> Does note really need the paramter? You've added 4 but there are 70+ in
> the whole documentation so that would need fixing them all (or none).
> 

  My bad these shouldn't be here. I am fixing it. Thx.


>>      A subvolume in BTRFS is not like an LVM logical volume, which is block-level
>>      snapshot while BTRFS subvolumes are file extent-based.
>>   
>> @@ -34,7 +34,7 @@ Subvolumes can be given capacity limits, through the qgroups/quota facility, but
>>   otherwise share the single storage pool of the whole btrfs filesystem. They may
>>   even share data between themselves (through deduplication or snapshotting).
>>   
>> -.. note::
>> +.. note:: text
>>       A snapshot is not a backup: snapshots work by use of BTRFS' copy-on-write
>>       behaviour. A snapshot and the original it was taken from initially share all
>>       of the same data blocks. If that data is damaged in some way (cosmic rays,
>> @@ -68,7 +68,7 @@ change and could potentially break the incremental send use case, performing
>>   it by :ref:`btrfs property set<man-property-set>` requires force if that is
>>   really desired by user.
>>   
>> -.. note::
>> +.. note:: text
>>      The safety checks have been implemented in 5.14.2, any subvolumes previously
>>      received (with a valid *received_uuid*) and read-write status may exist and
>>      could still lead to problems with send/receive. You can use :ref:`btrfs subvolume show<man-subvolume-show>`
>> @@ -138,7 +138,7 @@ Mounting a read-write snapshot as read-only is possible and will not change the
>>   The name of the mounted subvolume is stored in file :file:`/proc/self/mountinfo` in
>>   the 4th column:
>>   
>> -.. code-block::
>> +.. code-block:: text
>>   
>>      27 21 0:19 /subv1 /mnt rw,relatime - btrfs /dev/sda rw,space_cache
>>                 ^^^^^^
>> @@ -151,7 +151,7 @@ then a snapshot is taken, then the cloned directory entry representing the
>>   subvolume becomes empty and the inode has number 2. All other files and
>>   directories in the target snapshot preserve their original inode numbers.
>>   
>> -.. note::
>> +.. note:: text
>>      Inode number is not a filesystem-wide unique identifier, some applications
>>      assume that. Please use pair *subvolumeid:inodenumber* for that purpose.
>>      The subvolume id can be read by :ref:`btrfs inspect-internal rootid<man-inspect-rootid>`
>> diff --git a/Documentation/ch-volume-management-intro.rst b/Documentation/ch-volume-management-intro.rst
>> index c93576c72586..15b44c9447b8 100644
>> --- a/Documentation/ch-volume-management-intro.rst
>> +++ b/Documentation/ch-volume-management-intro.rst
>> @@ -27,7 +27,7 @@ RAID level
>>           standard RAID levels. At the moment the supported ones are: RAID0, RAID1,
>>           RAID10, RAID5 and RAID6.
>>   
>> -.. _man-device-typical-use-cases:
>> +.. _man-device-typical-use-cases: none
> 
> This is a label for a reference, I doubt it needs a parameter.


  My intention is to fix only the code-block.
  I'll make sure it is, in v2.

> The rest looks ok, thanks.


Thanks !
Anand

