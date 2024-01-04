Return-Path: <linux-btrfs+bounces-1210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD6823B44
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 04:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1286B288391
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 03:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F41F944;
	Thu,  4 Jan 2024 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M4idijfD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N+PBxUUd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C0F1EB35;
	Thu,  4 Jan 2024 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40427pId006510;
	Thu, 4 Jan 2024 03:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Dx7z3Z3C0v3P/rgolaVtkr8iChLUONEo1xoS1UPdOyY=;
 b=M4idijfDcmTKwdfSPPYEV29SDYwD5kZ4Qa1MiyGebl/8hru+3bqeLoZrO/6AERtNKIvo
 IP9P6zWyMuLVbiY+V5p94wTs9p1DBwvdZQAdUrfiRapXxDWNVXuB6+J8AewhumHZc+Y4
 i7mm1eW5Uv1ccMiq8Tx+b9rr+34HaXyhFObeJKB50iAAZ3K0T4pfl7mRYtNw+ZgfGqoG
 H0DfpnK2FYXtwuEu3Zb39IYldUFJ2+oxk/1HlBqaUBYL7ML514My63U9vaRrmk93qaVQ
 vvVEqh1YjzUYl6WKxpUSXQb4TokbZb6NDhX9GOr2j+vTNQLnnszp4UpkkXtoS52liWWU vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3va9t26c1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 03:42:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4043VRto029459;
	Thu, 4 Jan 2024 03:42:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdmuhr97u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 03:42:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNxyjfJZd0VdmYKnR9LYN3pXDJF/G1jIaqA3nmFXuEYa9HZlibuSuSig3uz59rUI+WXuJkGqqbOJKVkmsSQUUdV9WCOZo24TOoM9jH0nAVZkDb9PKuiG4GPU6qEtiWhhqqAjRvPO12BTOmHCg2ljZkqCK3jbu41HnawSB9Qmt899PAsuN/nT0AwZEC1FHbwluo0qpfyUQoZCBvi5FMFZfIddVpT7UxGogkVXSKOeovpeDQNED80GrkHLACUQ9RNEcoN1icwrmu3PNeItod7CBZWNQ3JBYUopOKnv9JdAURC8x+ujmndzrOunNNsQmWfgdx0C2f075BP1ka20skhFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx7z3Z3C0v3P/rgolaVtkr8iChLUONEo1xoS1UPdOyY=;
 b=Ce2eZzmjNRREaddjdv4tDzzmtUG31mO+CMdIjVTIcUR2/ci3SfQAZwZaMz4R8G87F7QqTG6LPkmVfVyrOPUB2Ulua4JVVTK3JxlwN8QkLbZHyg41/LkWip0UDzCE1dfjJ9UHPgbaH2O5ms47KErO43cbB5BitHqtNst1KsGC59Uaz38uE7rx12j6vuoff3vwUf+3pec1R8mHjpq9QwGMB3DBD5IjKjFJCEIzUpvXgnn3t5kEc/d3Fsd7XGAAbRox+mRtOCPm3VrONPObxipFqR0AsJz9PmCOKCPC/ev4cx4FP46rY/lg5ZAhdlUGQv15iKdYoSb4IDp8LckRNV7ISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx7z3Z3C0v3P/rgolaVtkr8iChLUONEo1xoS1UPdOyY=;
 b=N+PBxUUd4uP4GFit7hSgyUu8rRKKArOipMYIA7KADkEasvCj0GzBp2T2BAUAPTTCEk/WtGh/+A4BdyYX505Rmxe5KbfUH/C3BzisZpaoSDXEcMhjfaKQ0X9cyxdHjfjuYZF595yM7H6EU39aTfTdcAwTWSv5osox/ftCu+d4Dto=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 03:42:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 03:42:04 +0000
Message-ID: <c6dacda5-7a65-7297-89f7-8ceb591c8e07@oracle.com>
Date: Thu, 4 Jan 2024 11:41:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] btrfs: ref-verify: free ref cache before clearing mount
 opt
To: Fedor Pchelkin <pchelkin@ispras.ru>, Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com,
        syzbot+c563a3c79927971f950f@syzkaller.appspotmail.com
References: <20240103103128.30095-1-pchelkin@ispras.ru>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240103103128.30095-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 3deb782a-5c81-4458-379a-08dc0cd71def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Yjs7eQDPZcmO3gyA3gFKyNdnnIYIPqPVxkoc3pH70+/5UzeMqatYFsgp64at6969GzsVL9TbIardyfEUZypSALkxQsoYiqnxVxxsSTGWrlgMnCc7uo295jmCT1Y/K9TfNqmmEhITJoMaFCqspk39hYqLnDi47AmxIaGtsYUTepzKpaCTIGFWM9EtIsOMhJNq2NmGOXdha/lBZBFVX0MEEzjw1gexoYGIUuuwqZbG0SsyOb0wQGfltLl8ZoMOYbWCTsWDMY9zZyX01tEzrlZAxvSuAlIaUwuy//Ztxo+wI8w0RNzHNDpi7qmz3POLQQOanDHozHYL9yqJMDyb/iLxB7EeP+dYOaqpepu2LlNEXAFE34/IcA3FdwTlq1JeN2OxIraPOduRSngBKPbgdeXe+3ejaSQS3c82+FFJdBeObE45LfVul+qhHzB94ieS2h9C8jG/pQ5T4d8/3OmQcg0wZjscPRwtQEtYE054A5O7JET4k2GwwYzkKDwsIdl5GTpNj3UZTQWA3//os9ZLpiBzGKtEAqneDlexC8q3euRJex8hRK6UI409+HajWasx72uBOohzZHqS0Oe2h82GCElL0b52+f+nDvbZQ6XA35uYHEFnrr8NDtIoXbvIEi2APtVV6qZ5sbuXIYEzn4wpsqlv+Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(31696002)(36756003)(31686004)(86362001)(478600001)(6506007)(6512007)(26005)(2616005)(6666004)(4270600006)(6486002)(316002)(44832011)(5660300002)(66946007)(54906003)(110136005)(66556008)(66476007)(4326008)(8936002)(8676002)(2906002)(7416002)(41300700001)(558084003)(19618925003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bjcyUkhZL3RCakJTaFRzNmJmTVh6clhKSkk5V1FKUlZaR0tvYmRsN2NrWDZE?=
 =?utf-8?B?Z1NjSHhIYVBTbDJFakhOTW5rWGlqb0Vhb3Q5cVcvTDIrYy9OS1FpVEhIWnJQ?=
 =?utf-8?B?bjZMV1JWOCtwc2lJNm81VmgzQnVQTjlRWWt0eHphUVNTaVdsWERGOVVEQnEw?=
 =?utf-8?B?TWlVN0VNeEx6WStjSTdld1hJTEt5TThYU3VjdGtkMWtqU1VvU3lMZGJzckMv?=
 =?utf-8?B?T04zemlSWFFlWEh1WFRzaklHTzdEelAxTkZWbHNMUXZmcXk4K243UUZVbUJy?=
 =?utf-8?B?RVd1SFZIWS9EM084NXpObmxMMkl6WU03TUVTMVNDRDZoQ2dNU0IyczhPWU5M?=
 =?utf-8?B?WS83bG9PR0t2UGdxOE1URXlackwvb0ZVU095UDhZVlhsVCtmTGc3NHl6R1VD?=
 =?utf-8?B?VkNPMGJFdmgvc2FWRGdjemlYU1RoQ05lQWVpOVZYUy9Bd1dTNWJnR0Q2LzNH?=
 =?utf-8?B?UlVuWlFkV2l0Vm9nWmJZQWFxckdKR3BmUkUrTGVQV3lEazVDZExReUsvOUFY?=
 =?utf-8?B?b2IwTmRQL05pZmJVK3J4SENBWGd6VFNGendHOXJpL1lyc1VlbERvS0htYjlO?=
 =?utf-8?B?ejMxQnJDTGtVQVlXc2xySWVvR2tQM3JMU3NmUk54VysvckFyTUlLNDVnN0VI?=
 =?utf-8?B?U3V4dEFUMmxhZzBCRUNoQi8vdENvMit0cEtIZGk5WGRDaE40Y3JNTURjY0JM?=
 =?utf-8?B?YTMySG1pVlRwNmJ2WTZ4bHpBdS9mUGRyQjdkWEdZZUl2eUtiM0VDMDRWNmEx?=
 =?utf-8?B?T0d2WmZwdnNoVStGejFnb1VVd2g0ZDZtVXFudEU1RnRibG04ZkcvSFQxdWJE?=
 =?utf-8?B?a1NSMnlyaGdEOEhiK2FGSkttbjA0QXV6bk5UYkdHdTJtNWxTbW9hZEJzWXZE?=
 =?utf-8?B?SUt0d2VJWnJLZy9sUlVGUzc2eTV0ZUhOTFI4ZWVTb3QzSEhTUDRUU1RsbUsx?=
 =?utf-8?B?MDNIYS80b0lueWJjMXNMVnRXZmpCcEp2ZFl4Tnd0bTN4OU14bGJnUnVkZUt0?=
 =?utf-8?B?TXNodHA3THRtTk4rcjMwekZsZ20xWFBiMkJCTVEyazBJREI5M2laVjZ0ajZL?=
 =?utf-8?B?SStoT041Ym42dTFnMmNWSzJQNGk5SHEra3hrZGZDUXBRdytFRHJSekJ3OC9m?=
 =?utf-8?B?Q1NmVGZ0VUs2YjViRG02cDBxR0FrWnVQWUJTTHFVZ0JtbWNJc2tXYmNSZEhR?=
 =?utf-8?B?Z1VISXFjc0pzOHFDSWRWRlJUSE9lbHZZVnR5aXBuZDQ2eWNjOWUwS0ozWk90?=
 =?utf-8?B?LzFSaXdRTlQyem5RSXQvTDNOZ1NwSjlrUUVxV1M1ZDRZcURsMDhXK0E2SmZp?=
 =?utf-8?B?NjBhTWVhWWV5Vy9DbDF3RE5BTk5sTU1kWlRxTUZHVzZLak1ZRzNMeEVuV3hN?=
 =?utf-8?B?OVREZms5Vll6eDRjaUREb0JLNG9kUG9wZHR3N1FiUnd1azhLYnhqL0IyQ2dC?=
 =?utf-8?B?K3k4M0taYnNGREQzNVNMZlpKbnRqQnF6eTIxTFYxK2FEUjRkR1hBV25lWTBp?=
 =?utf-8?B?eC9XT3I2ekxYa1lveUpEVkRReldOYjN3V3dFMXo4dEptakNmendtL052MGow?=
 =?utf-8?B?YVJtNC9oRGZqRW9wL1RIQm9mUnBhbWR5dVdvYnpYRzFFWkNQVU1VNnExdkNy?=
 =?utf-8?B?SEhWL0duVUdCaUl1TmZwSWRLVm44bFB2TzBIVFE1WW1Qc3hCMXJQeFZvdEpR?=
 =?utf-8?B?a3kzYXQxd09yQjBrNzlKd3EzeGFzZ284TnlnV1FpbUt2azNBV3ZpSVhDK2I4?=
 =?utf-8?B?bEZFL2EveUJZTktKVXF3NlB0NGZrVXkvTm9sVnhFRTNTZWFpWWsyRit2b0xw?=
 =?utf-8?B?RUNjVmh2aTJUZmtJSkVMbHg4ak9FVFJvK3pZUW9qcWMvSithMktqN1U2NCt4?=
 =?utf-8?B?NjNXSFdlN2hDRnNqWDVubm9XZDVQSmlmWEZ1SGl1U1ZVdFlvbERDandVSjJS?=
 =?utf-8?B?MEdSOHFCYmJwTjZFWkptWUdNSjdYcVFHak9MZ0s1TVBWbS9qb05TUitjUEM4?=
 =?utf-8?B?ZDBwdVgzOFVSWERWbnVxZFBUM3pNbWV6YzMzUndITGtkYm9KdlVtWVlzWVVZ?=
 =?utf-8?B?TkhqUm5kdjV6cm42NjVCRjlkdXlKNzZpT0tFVGFLWWZYY2t2M3VrZVU0YUI0?=
 =?utf-8?Q?mEGBSbGEEyWuCv/vs5UU1JU1I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4fQ6B7Vdv87drWfXYOXmF7N55WkKU9f1sdI2hcGCe0JnwhRXvSdMKxtmy0rltNTczL20Bv/JvvhQNti3+a85lw2Mdt0vaJo4+I7DYifQs30vOTA239E/Iw56yPT6v4RuqXATj/iWKBUVSK22RT8RB/qZxfI7AkqTtffNnOcpYvZ26z/vtCmDdVJE8eels5A9t0ZY1sABkGe5eiWSSsGLyoGifL1rRyqdd3k5Kb6TI8u3GBBLuPkmxgjnhkTN+XBVQeRF7Tf1x6AS1P2R5jjJ6A5cGFyRzvf87cdUMcOkkTIH9E0RM7N6XSBYINATyrhVemqsIVGMQm8PQLY3cEavT+aAITraucROwkRICaAu0nDCenDJyLNoSTvalRKmRV9BWCkoj+VPXiGKyCL9FxRTjfcbsS8BxUs3DcBhvARbCsDl/e5hbCOv8ltDSUt9c4YGZnyFsEl6v+iHN1U7EqqeyXmJeH2Awgkv6WthoNfSMQnaDOzIkNG/a33epV2/5QQabw/I0cJIv/mggcQUhdWE/HmA3a9DJpgPaK+2xklVKFJkOkA2I4LUIoRlu7r5dWzFzUz9H8ybP6Bm1SOsHYA23P6SXJmkv3+CmRuURG7Ta+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3deb782a-5c81-4458-379a-08dc0cd71def
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 03:42:04.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzwKi7UyER+E1jJDE3+rOlsgbyKKbYkVQ6YfO8XYyEQyRIqh2zY3k/2AQTth+R+cpZ7Ft2/Zgq4tRhH0XpcYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_10,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=858
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040022
X-Proofpoint-GUID: m8EMNiDVj-ByaqaQUPe8iUzhtUA7is3q
X-Proofpoint-ORIG-GUID: m8EMNiDVj-ByaqaQUPe8iUzhtUA7is3q


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand

