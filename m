Return-Path: <linux-btrfs+bounces-1295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677AD82676E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 04:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22DBB21201
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 03:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2C279EF;
	Mon,  8 Jan 2024 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hwK+TZJK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NXDRdszP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AD479CC
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 03:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4083Kf4C011713;
	Mon, 8 Jan 2024 03:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VUaCrJG+/wGdkryVrD9dWXKwG6a3X2hbw9BElBs3Ltk=;
 b=hwK+TZJKMW4oxXsA7E7ERLcyTp7XMzUZUXWymcpAbCkhYWVj7CgfLrAa59NPPTnwsCFT
 +ICtiMCETbQEVhfgQAIUA2fS3fM9Qg4unZIln4Ge9zzp7AMCYLGcjF+XRdwvtn2wvPD8
 WqAPC61BqQz0x7wmXh0xD1wXIZp2FFmKtc7oHYbK+2qmdRyoVP2AYwl+CQ2mKnY1DXKL
 alUNV3gSTQvUiAbiafwyaEvWlDYkB1aEisGim3DbY9WVNtTqdKwp0tJWxYN4OEFwjAk1
 KoeB8nMF4cl0W4IA8D4qjYWxIpA6TIKFbmEA6CdIjnRvrDBT3Bwd0fd01QdmiW2QW+Tr Pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vg921g0dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jan 2024 03:33:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4081GWwE006670;
	Mon, 8 Jan 2024 03:33:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfur1hgft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jan 2024 03:33:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izKboza3eluG3Y28eRs8aKwhc2j2YWiZMKMC2iCq8lZ0KNLnVpsHKRv3b6ESUcEEOUtJqa6kMMVY9cpbCfOgtWqvhrn1WrRya9l565ufx46UIxgmkSpkRL/HbvdaaiWuSDxxJB30gSZQBtvMmy5Fo1kYQKViBD176bs/kwE0LLOLfnblt3G66cdcx0gFU4NV0JRcu2TS8rAvchex8+GR8W1Ud0pmM6BCEP3RbAm7erAw3q4KtrXAgh8oazdagqm2+j/Ez5HmUQD0cTOKIzzF+EFYBM2T2fLgF31DVXSrCx1GWwXZby6ydcdBQkNGh45kPVam4F9oKobyfMPJQJpXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUaCrJG+/wGdkryVrD9dWXKwG6a3X2hbw9BElBs3Ltk=;
 b=gPUPeyPUupa1Rmx0GEZMl/z8ox6/DOZVvxOiA6FqU6C/jZBviSaaU8YOlz90Z2+tW40vhRUeonkOEJF1pH8oSy31HffosQVXw/K7SqkGZQ8xS11/isBzqz4avZtYauIn7J2IbF0qn/wRn0yGn4rum1PPa3LagQr+lUevf/ewTPVjYV26cGhwN/yOtVHHcPW37DMvN3OuLKRD2TZxmyQcXilGDy2TOI16VLs+L7eGAir8WisQmuj+c30TNyu0vxG55rca1QU1s4w7LizYa+pMfdFbmITVQceTsfdCwNUvlpRtW85B+i3pKH1eJ27LTp9s6f9NWv7Dbzu1ShgalRX+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUaCrJG+/wGdkryVrD9dWXKwG6a3X2hbw9BElBs3Ltk=;
 b=NXDRdszP2NI6zzyNO2S/3bCZoU59YOufEzS88M0oaXMlIXHo7yzk/avyiPUFMkKCl0dNllr8fynMaZwo+vvAMJh8t4slGeOWkEV3+LWAvIHwqsLq28tUuGcMyMCsCx2CktxbNQ+uJVQE4XFT2LBS9S9iFF81bmx0sp6DUbpKtc4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4855.namprd10.prod.outlook.com (2603:10b6:408:122::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:33:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 03:33:52 +0000
Message-ID: <d9b9ef48-f75f-4367-b6d1-d10c32dca6ad@oracle.com>
Date: Mon, 8 Jan 2024 11:33:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove unused variable bio_offset from
 end_bbio_data_read()
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <69c652507c19ec6bff940dc1da1fe2b847cf9d24.1704679242.git.wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <69c652507c19ec6bff940dc1da1fe2b847cf9d24.1704679242.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7815c5-200a-46c9-86cd-08dc0ffaa290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	59hymo0C4hGwPQX4SfUg2j5dzBmzmCcBH78biB0sw80crVy63HU/1koo8PxR6MkNtgcAgfSjd+Ds7RpE3l5IuYmNPfEqEUXMiw3HwBF4eH7ovkZ3mlK8rxcZsMlhio1SB+CwMpmYb9cI9YP9HpJrC1LiZ5bkS6S60PnZRn0OaXBcUvGoFSqwzW14D5O9bLb54yDPxZrNk4dBXES8OB92/JUtS/IZsuyexBJX9ETWAaDcTIilfEkfA6SvkALr+nWLdW5kIwnWuy/nQuseLDxgQCIWklSj01kXa6PiN6Yw4nus9jEpVbTPkVrZGHlHNEMrOlmhDM1Xym68ETWJCX/vvzWe59kTrqg3hsKlzkpTX1rY/+5EyvJsIVTPyghh8fIvtyNMREP3/NgvHL/yZv7PnFEZpaYrw5XdmFr30DQNveRhs4+OMY8nCh0KMXUDjX4x0A2/geJQznnaHFgBo3mnil2TDIfma6gL/AmFSftHGPNdD8Pl4+fzw3fp5HSGdLgXVrdRx44UhmMHIu8fJOoHRtip/v8lDs5/R5V6SjnyipvAJZt3K54RX8ozp1C+hUdZ41aR2LihupHI8pv9B04AlF3e8+HpbDM4N9TNZQ2z14mljul2gG97lsKdk53stDw9CAt/6twqFP5RHxDkUJsB2w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(41300700001)(31686004)(2906002)(5660300002)(558084003)(6486002)(44832011)(36756003)(86362001)(6666004)(6512007)(6506007)(316002)(8676002)(8936002)(66946007)(66556008)(66476007)(31696002)(26005)(478600001)(4270600006)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmdYc3JmOUtGbjJxL1pJcFhRdjQrSE9oMzlkMFJOUC9FK2pNUXV6OHdrWDE4?=
 =?utf-8?B?bXNKV0kvbE5tWEw3TWNyOGUzelNQR2VCdFF5OXVrZlpDRTZxSjFqc1g2MTY4?=
 =?utf-8?B?KzR3bTNSU0VURmxCdEovekIxeWxWdFFtRTRZL25xSk4vZ0RnU2FOZFdGWVNH?=
 =?utf-8?B?TWt4VHkzZC80cURrRG9rUnRmYkw5M2IxeHNzNWtSSUd4Q3laUWVOZW1OczJW?=
 =?utf-8?B?T0txcE03aWp1Nm9nTFQ4QUpOMEhROStIeE1XdEtLSEtGZkZIeFgrdG5wUi9P?=
 =?utf-8?B?RE1iUlhtRkpKZ3hxR3FJUGk3aVJyaXlEbkxsT01tU0I5RFAwK3plei82Z3Y5?=
 =?utf-8?B?VzhqT1FMQUlGS3AwU0hvT2p3UFZZNTZHejIzNUVzeGNyQ01KMFpOd1hkZ0R0?=
 =?utf-8?B?NE1GN1RoZGk3MEFyVFBINUhvNnFlRWZrbkI4Q1RtT1NObEQ1dTBsNHY5R25z?=
 =?utf-8?B?T3YrRGdqUGozMU1TOC9sUi9seklGR2pZWE8zS3o4bDRLVU91VTJmT0srR2I2?=
 =?utf-8?B?NSsvUndqTGVTZTRZTnRoQnpWTXhzZW1tNUFyZDI3Y1kyNXVxUzZkc3FoZ1o5?=
 =?utf-8?B?eXR0YjRXTVgwczhuVHlXY3NCTXhPdzkzbllJeWY4QXF4eUIwZDRlRWRjS0g1?=
 =?utf-8?B?bnBxZkErOTBzQ2w0VTMxNHVOV2dicXE2NUlqcWlZV01DcVNic25SRzNnREQ3?=
 =?utf-8?B?SXBBcVlOdHg5VVl1UXczT3l6MnJvTjNpUjZTMGhUaHBTVFoxNW9Tb1BkWEI0?=
 =?utf-8?B?OWtTdnlGUHU3djdqVGdwOWUranc3S3FHM05tdVV5bUllUlIwMUd1UXJwUTJl?=
 =?utf-8?B?RmJYbzZZazRXcTNIRGV0dU9ZN3VQNnNmT0lja0hpak8rR2NCaElCUGlERVIx?=
 =?utf-8?B?bXdSSUw3QndvYUIwNlZxQXRFQll0SmpyOE92Z0M3WnlsbTNJTFk4Ynh3dnp2?=
 =?utf-8?B?RkFkOFEyNWs4Z09sK0RWdmJ0bHBxNm4wc2lxaU8wVlRQcjNYWlpTMk1FcWRN?=
 =?utf-8?B?SW02R0pBSy90RmpXRUx3Qk1wYmZybFhaMmJDeFlnTUlnaWZYaWJHeXMwUTB5?=
 =?utf-8?B?anNHVjBLQTNKWnUzeEdJSE1CY29oVjJ2cVdCc1IvVXFtOHh0ZUsyK282K1Yv?=
 =?utf-8?B?K0wzak5Zc2hWc3ljQVFycXhrdEpFenBySm84RnhaSm9USnZHTFFYUjJQMGJU?=
 =?utf-8?B?bXJaRFM4dVZPbVcxNjBPU3NaQUpKem44YWZYSkdWUXZGRlNKWEtyUlBpRXhr?=
 =?utf-8?B?bmFvRkVyN2pyRWNub1hKRXM3SXFLeS9iMEZIMzY3N2YxdUgvN0xtU2haWDUw?=
 =?utf-8?B?SXhoblhmbkVyOUk4cFdPL1JVMjl5YVozUnlpQWI4dHBWOVFRd1daTS8ydmVO?=
 =?utf-8?B?OW03RnVxR1VWcWN6d1RHQkZPc1hWaTduMitpbHp4WGRMemhiY05XTlFUNk44?=
 =?utf-8?B?dFFTdGZPZnR0NFdzL2Q0VmVZc05aQllUZjhKckRjSFgyanIxb1c1S1FtVVhC?=
 =?utf-8?B?MEZhKzc5TUVTZVZrOW1RUzFJS2hJWVRCWU5BWEhxUUVSMTlWUVlpdTJOelhz?=
 =?utf-8?B?ejl3Ym95UDBjVzZVb3c4MkRsUFRrL3drZzdxZXFxT3paQXZkaTlTMGxneUdK?=
 =?utf-8?B?aFZFbFk3U2Nkb3NnSlNwL1VZQUUwU0ZDcmZVQlB5QzhzaXZiT0F4ZTZJYlJO?=
 =?utf-8?B?WWVHNTZEQTVCWXpGMXA3TUlDYTJpelpkRnh6dERNTm81c2VncVVmOXV1VEpH?=
 =?utf-8?B?VklJaWR6K25RUHp1ZVRSWmNiTlI1SnZKcjg5TXhwV2NRQ3duc2J3R3dGWThP?=
 =?utf-8?B?cUdVam51UUNkZ1A2RkZ4K3ExYnVXNWZIOVppVEpSMjFQWm5USUZQU0F1U1cr?=
 =?utf-8?B?WTVZdUl4d1NtQkphcU1UZ28wVjYyQkhkQmpCZ0hNS2FKbVRjVkZSMFZucU1P?=
 =?utf-8?B?bFcwNmtzSVVVVWhCU1hqQmhWL3VVTExoSjF0L1B3NVQ0OFR5L0hNYVV3UnQ4?=
 =?utf-8?B?bUFic1k5dGpuS1E1dEZqN2JPMHVOM3hBVGw1blpNM1lpT2RHajUxVU1oYUsw?=
 =?utf-8?B?cmt6SS9RdlRlNzlNUExGaVFBLzNGR29CZzc4Vk00dXJvVUErQTVhYTFIdkNm?=
 =?utf-8?Q?36DIhQCi3kEGRKJ3CM8HJSGP2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cps0hTG5OfiWfeHnaGQoyjCe1B7y9kDeW2K8vwwCpbWoFdFtn00emqBT+xzCbMxnySA8b3lsinDaYr/xcKt6S6wqLtIEcq7srScLhWvoKBmLuE160I6AOWtG07MkEW7szLnqGY2M2/ai8MP+Lz8BuJTap+nQ2VGC+SmspMAIsyYl9WXzYQyPoMjPENX424wcj4OCfs3XLbE52QxqS3AxLde5fj58C4JlQPyVG8LuEYvHYEaeCn8ukRlqBEQvRSFQProBXTWsdYqeAw/xQzm4NFYWSMG8yCL6gE8WOKfM3m3C3UfGfmxECeeVUGUyESB+FBD9fkTf/zB5BLEWFLhZESaE3UQ9FaIf672GQ3X1hbcFsRXI2QvO91+3RFGnLlBDs8pKyXbxJMI3psT0ApZ/9zbCqTH+9pTPslYuF9x/vfJfTx85r6upSSebBDsVTVCPjeFIyg1DcyVlRKaBPXvjTgkHVN1T4z0PzjfFED7UYc1yb/aDEKrvu/aq4CAmUyVJv9e9eivHIg+rFeqLtu+RBfClnsIzxRMzDIexcuJNFwvEU85nqQceeg/bPMGjGSB9lwnSsKkToISmLZ1u2xU0IQwlyk50F8MH/MoMPTqiyqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7815c5-200a-46c9-86cd-08dc0ffaa290
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 03:33:52.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKuENq8FTdrmONrwBF0rWOBFBez6MM6brbS2FyTDNjaA2CSsfszTZm4chrTJrHjhc6eZd3a3AJjNEQ9Q0+IUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-07_15,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080026
X-Proofpoint-GUID: mZ1qy-Z1nyll15VZEmlELt7ENc2yYDNn
X-Proofpoint-ORIG-GUID: mZ1qy-Z1nyll15VZEmlELt7ENc2yYDNn

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand


