Return-Path: <linux-btrfs+bounces-1151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8756481FF4F
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EA428428D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2228D111A0;
	Fri, 29 Dec 2023 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RRk+m9U/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tfRwEm8c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064531118F;
	Fri, 29 Dec 2023 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8O72C005631;
	Fri, 29 Dec 2023 12:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ocEqttlfEqsRqffgDhKdgWACYH9dnc9uSvwUzppK0jQ=;
 b=RRk+m9U/ofTO99K3B8Y5w9OnMew68/sjWxdJPIrDSYK8Y2DCuH8zLg66s5ZnNS500N4t
 K631A00XjRbvfX8sxn6NDYwA05pUgVapjWmbTH9cM2CVv/1b/QkjouB5zr2JWlunqD18
 SiBce/WJfAgRvKOMVud28v4Ae8Y9/yZLF7urat/9cA4KBLu/U2m/zUAp0g5aGXZA4ih2
 LcDtAIjkhz6lc6JLw4OUVAOxC7gsGG56sTOLBOZXkupVxAWHz887f4a9I+8Fym8vJ1bb
 HlXBGCF5CjJcBR7CmC+f7w0VZN7aKuNg+p2jZT2+D6w3C7wkBIYrjhry9uBzijUlz6C/ Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v7f3a4wdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:08:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTBoBWd040737;
	Fri, 29 Dec 2023 12:08:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v73addnsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdsPlqzRVsJrXIH+N5yMjzlsW0qTIyy18TY4Zs3KgYgIkFxZE6PZisFSHMyuhvk7g9zMoWVLSNOf6KoQNTTwH+r1Qf6jE2OIT2xABPMqs71fwmjk+rCaWuZ0jjF+ZPnYptZJUz641BZ4zS4rPDjWwFpYrsA36YjTRxBecneSodYd5+DeYXnn2N4gTskTLjfQ+gws32s1j7rw+UgrDWRUVT6gpFePOKmJ5MCORFITEOTLoftTJORIomZT7fpimJQvAsPYSYGQzjpNDZyrtUltPlqYGfN4sVCW9MJcOGsBVkDry6SpLoJ/qdk2av7kK2F2GoP1HbaCeIBpf7jjjxj1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocEqttlfEqsRqffgDhKdgWACYH9dnc9uSvwUzppK0jQ=;
 b=H7dH6g3BsCWg2VR7gXUTOA5LUsGTEuysgBbCYRtxfdgv5dMBOOrwmHJS+cJhFIblcOukjbFAIZGwn7JLdGQBLqI1notW9M+PRvxNYAGwLpdbSCXKhhFiI285V9+4EZdWMzVxp06QB5yWDmJMv6sJxxNw2eDDc4eZsh06/vtbdnoYzk8zyS8mWAGJPpmGjHnqY3JBcEEM4YfQCRWqvSg974ebksR2tbYbd4F7+dqJsq440aG/osVuWMleG8FYYrVjHHkvr3YBhjPsT7RgxR5GYfHszp6C+cIRhuqrhS2EM32soqGFMzWMClnxeJmLXRS4OZ5azvdnbmFBo+x76qIOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocEqttlfEqsRqffgDhKdgWACYH9dnc9uSvwUzppK0jQ=;
 b=tfRwEm8c1IGhCJDgGtIiiqie7Ot0wSVZWp+94X331/wthnR64CDc4rVYQKgSXMztdZqr6qNKODnenJE0mxSNIUvp3XCx02A5GW8ZqaoYOblTPF+cDMV2oHdWEYZXGbYIJ8cOwDPzrtbo4IdU39/tATy4Q41LGulhtTEOKeyP67k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7347.namprd10.prod.outlook.com (2603:10b6:8:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.29; Fri, 29 Dec
 2023 12:08:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:08:08 +0000
Message-ID: <c46cac6b-2c60-3602-8c35-d6b304ffb0da@oracle.com>
Date: Fri, 29 Dec 2023 17:38:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 5/9] btrfs: add fstest for stripe-tree metadata with 4k
 write
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
 <20231213-btrfs-raid-v6-5-913738861069@wdc.com>
 <37f24bda-fe2c-fd82-38eb-d5d0e3e54842@oracle.com>
In-Reply-To: <37f24bda-fe2c-fd82-38eb-d5d0e3e54842@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 524e83d4-1045-4035-7812-08dc0866d213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3SvE9OTbyMMraOlXMw8dMFqOzgGwGS/+2h6lTzwqhWo/Bjnk3EsZjeu5BAPztTy3HFhfEgOi3YLfq0yg765AqET1D7ZdFDFMi7uXCUxpDlA153cqd2KSQoPq3G6HZayXZEOP8ecvhEa4/Vp9CjaHoR9dghNJwJkSpnAjBXJT59dMFu1MOVTDvg9MYkH0f7XmFODPCnOXJBNcDPpVWkXzNrh/mnq7s/oRoZVgH5ZdBRoysp+ql/59StDL8GFLjbxyliOh+UAUus1x6II8I0AQj0IHuIaiDlvjoymcFxnzeN7d3pYpKEY8OkTlpsBpxCuuBBEhvOX2GWL+9Wfi+80egD0mM7GfjygQfsriudyR1Zz9NOlGHg9Bk27ZpzORGVk6tJX2yrWV3sa7crGiSirg0eCPAIItIaF/SJXtao7RMMYirxANjzmtRb9/GTljMxmERBXLFz4MYT0RQUWRbo6uYI0k62DgP/3p62T5CBSnwdav/8FdbE/vAF/nuOj67/aUfdxTVy2l4FI4vhfTVPVhsEfmEaUmHtNKf5fs3ZsDkz6xq2Rq+hFB0Co+MGQy2b8T8IARW4cdkD/67RE8XJjKZE7D4z1nguTQOUtzBC+Y9wo04g9FbG7s0Yf3HqmuIE5KpqUSe3WiT1cvFavphV1eDQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(44832011)(2906002)(66476007)(66556008)(66946007)(5660300002)(4744005)(4326008)(8676002)(8936002)(316002)(6506007)(110136005)(41300700001)(6486002)(6512007)(86362001)(31696002)(6666004)(478600001)(26005)(36756003)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3pNcGIzN3hTZmc5WFFiRFhFMGg4M3k4VFlrRkR6SGlTOE9SM1NBVTVKV1Nl?=
 =?utf-8?B?ZVZvb2N0Y2QvdUhEQTRuSnhaYVdlMHp3SkhCN1E3SVI1ZHpSVmxFZmhFZGln?=
 =?utf-8?B?SmZDYWZwbHlVYWIvWWlSZmZWZ05rZWdrRWZsTkptcjZjS240VktsWXBodWVX?=
 =?utf-8?B?SlhtUGgzbVhNVzJ0OHNiZzY4c1d2aTJmN2dseFFML1hDRXdHRVl1eHYrTGtG?=
 =?utf-8?B?b05DYUJoeC9taUJXNTVpanM2R1A2OGVhSFBJdmJhWEdKck81QkovSHdrZjRI?=
 =?utf-8?B?T1I1dEd5YlNMWUtoUVJQZkUvNjhjSFlsTE1ucTJoQXhOcCtxYVFVdUZ3K2sw?=
 =?utf-8?B?cC94b0cwZnVIVHJYTVVmMWhsWmd6M2ZyVkwweDBMc3Nkd2V4TFAwMFJyM3Za?=
 =?utf-8?B?ZTNKcisvcXJUaUJOUHNmb3cwT1ZWRm9TdVhXbTI1QUxmUUF5amJWTFo1ei9y?=
 =?utf-8?B?eTB4eHdhREMya25tY2pwWG4xMUNMU01rdlFwUno0b2Z0YnlORFhyRTJQVFFQ?=
 =?utf-8?B?QmMrWnB0THVmU1k5Y2lPZGdCMGE5SEpIdFRrQXpUL20yaVJrTXNMZ2hQbWRR?=
 =?utf-8?B?d1p2VXRrMjFUN0tFTzNGMzJYNVRZcGpXSVczcUh0ajdIQWREZGJVcXRSVTY4?=
 =?utf-8?B?YjMyYXlVbmtWK0h5TmZPbmlHbnJPT1RWUGpjd0daMXdlcGpKL1ZFa0JEbTdh?=
 =?utf-8?B?ZlNGWU1aMmRFNE9NQlhkTkcyeWsyWlFMeklYSlA0cVUwdmhPMTU2b01sekcz?=
 =?utf-8?B?TlBDNXBlYUpaVHVUYlRzd0VMbVc0SThCZ2ovdFdUS2JJSFpJeTJFQzQ0Y0FF?=
 =?utf-8?B?a0w1WFFiNXhpTTI1ZVp5YkFUMjRXaXUvalpsSlBuWDRUdU1sK2lBOEkxSzF1?=
 =?utf-8?B?T2NDVnhZemhYTWtHalR4N1pZVDdPclJFU0VlenNudlo5VVRKYmJhdVBBRURY?=
 =?utf-8?B?VXFZQnlCV3lsVFhSVW5kUGlDNUNxUGRkeUV2c0JxYmtscXB1U3VURFdYUnFW?=
 =?utf-8?B?d0xmTnF0OHlzejJPSk4yNzZiWXpiZ1RmUmFDaXFBdldQckwxM21vVFNOaEtY?=
 =?utf-8?B?L3AzT1JMRlduRU0yZzlCZWJBc2dTR0dOMUFUSk5UUFNaUXg2QXRvS2piQURG?=
 =?utf-8?B?bUtKNTgvazFmY203ZklHOVpwWkI2akZBOEZSK2NoZWhFU250d3hQU3hsMC9m?=
 =?utf-8?B?ZmZWWThDWWVCeW83eE9KOE9GMVJ5R0Z1MXlMZ2RvcEV6dmNFWTRpcTBkeVJy?=
 =?utf-8?B?bU0vdDIwUTVvU1JJcm5lS09PdTU2emdjTlJFSUF3S1hhZFBLNy9wMzNtZzlv?=
 =?utf-8?B?Z1dGMDBJRGhZMEUyWW81dS9tQnFYVStNOGx1OHErYXloUDNJUEVEckcwOHNX?=
 =?utf-8?B?V2pyTkF4N2dKdGdqQ1ZQR2ZvM1QzV0ZpVjE3MnErb1NIM2RBQWJUMzFSazhD?=
 =?utf-8?B?ZDF2MzZsMFJFZkJZckU0d2srNjQzV2NWcnpjNkNMb2lZa0htVkFoKzkvYno4?=
 =?utf-8?B?RHdmRW43VnlyVzVSMzJoUFBsLzV5M05FeUFIZEVZZVJjV3p1Q29sdVRDamxn?=
 =?utf-8?B?TmJ3d3g4dkJNOFVKekREYzhWRWtyUEh1aThNTk00c1FNQkRyV3FZNHlhd00x?=
 =?utf-8?B?cDBzM3lGS1U5RStmRS8xZzE4QTUvNGwxRGxTL0srNktuTjZibk1QNzdFR3dF?=
 =?utf-8?B?WmxHdWdTWDU0YmRTMkZDam82ZFJkTG5JZ2J5eEtQcXRhQWpFT1hDMjFzZmVT?=
 =?utf-8?B?SjBZL2xIalZHbCttWk85L01KSGtnUFRib2UwSUNiOXI1Vm9LdXVOUDl2NTZ6?=
 =?utf-8?B?NVNCTDM0a0N5dStMeXZzSHRRVEQvR1Vnd0U2UVQwMHV3am5lbGt0bmNpaEdq?=
 =?utf-8?B?NTI3ZWs3Z00yVjRsNE5vZXIwOEprTjhrQkNuc2FGNk8xSWFZQXlwc2dFdVE2?=
 =?utf-8?B?OXg0ZlZjOElidC9vemU5L0d5bDhhdTd6ZHJOSTNCUUtEUW92ckdHNFpuUVEx?=
 =?utf-8?B?UE1Vbmg3cGEzU3lURW5WTCtJNGQ5RFVsVmhGN3RWMlRkVWk5VURtYUloWkVm?=
 =?utf-8?B?cjhyU2JOdmF6L2NqWWN0WFkzUnBYNHJVbjVMdllqc1NlRzc3bTJOTUV6Y1Uz?=
 =?utf-8?Q?j1HdU1hlQt5FM4JNQMBhUyMf+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jTkWpdUvj6CMj69mrolITm7++/YpGEvq5uFd9+/Oy+A/vEzz+1Yp5s7T+1b8Z9c1wduHjEANt8bvGEgGZnZULT2OMjSBSGVCMQN9r2hzvdO6Vt7bLW+39EP0jP/9+s5DQrIZPZeOVadacwqiKXcUfUwiwLW4b6RtQx7kQbVNQrQFMTjhhseRSQQrZyP5aQl6O73/v5c/U6hhR3XWssC4qioSofnqOiET1Zol7H0gF7bdDnsmSqdvjyr3WtKeEjP+5kmpI7OUJW+Q5P8pJRRdkj2eRFWfGMkVTkKOW+EkDHOybHZCXnmqTG8RF8oQS8uBujvis1X7TWU4RQErW64HWA8MkFz+SOHaUyt20muOJzmCuJBGNFVvZqqb/gIOgxuuRyPyh56TXaej8657e7ZuL/4NwJgvWKHbkTOGl7qXJTNZEOV/QEth6Co+GsubRRXyaEbtMwKF+i+Wij1KKTZT5qJNBtXcmYXOQ8KEM8KVoiowabvhRrH2LYq4cYI7HDLf1xgRQC0JPNQEepuTZBQAy9Wyhun32YPb9Ot7rA+BwDcNfMvJe+6IA1rH7JCZVfSOkaIUqQuFcjolGdudI8VzFLsFJZyd+DzZyNyVR0wsRYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524e83d4-1045-4035-7812-08dc0866d213
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:08:08.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUA/moDKQh/eeGJTUwlfNngoVcwIPXia2QI9wgTTel+WSrXJRMwulK6T9pC0daaQuTM/ZsDLF1QwwCLrH683DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290096
X-Proofpoint-GUID: ECOSexeCOGNqDcEV-wJL42p-Imrymiq0
X-Proofpoint-ORIG-GUID: ECOSexeCOGNqDcEV-wJL42p-Imrymiq0


>> +test _get_page_size -eq 4096 || _notrun "this tests requires 4k 
>> pagesize"
>> +
> 
> I made the following changes, to make this test-case run.
> Also, in 30[5,6]
> 
> -----
> diff --git a/tests/btrfs/304 b/tests/btrfs/304
> index 05a4ae32639d..f1db52c1ba5c 100755
> --- a/tests/btrfs/304
> +++ b/tests/btrfs/304
> @@ -22,7 +22,7 @@ _require_btrfs_fs_feature "free_space_tree"
>   _require_btrfs_free_space_tree
>   _require_btrfs_no_compress
> 
> -test _get_page_size -eq 4096 || _notrun "this tests requires 4k pagesize"
> +test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k 
> pagesize"
> 
>   test_4k_write()
>   {
> -------

With the above fixed and the trailing white spaces fixed

Reviewed-by: Anand Jain <anand.jain@oracle.com>

for the patchset.

