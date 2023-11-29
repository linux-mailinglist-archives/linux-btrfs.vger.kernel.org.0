Return-Path: <linux-btrfs+bounces-437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 615E27FD753
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 14:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0B2B217D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AB1DFE9;
	Wed, 29 Nov 2023 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OarpDIzL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O/fCUSj5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3210E6
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 05:00:13 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATChoTh005463;
	Wed, 29 Nov 2023 13:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vAw2jjROz7UaU3/PQCVbpJdaaQZOWqyLM5onSIhJZiQ=;
 b=OarpDIzLOmo/75FhFIynsGpsyVb256xn1U2Gp7oQM1kuFM7c+peCIotDlp5M3FbEE9Nz
 FvPMTeTT9PVkodwh1gxcs6RCal50Ud0IAN/NIQKbIvhzyoLWFfksKpnmP8iAXA9EXRA1
 HT+Q6ksyDF+ABpYS7Vs6azWFSmQ4lMt2A3QqgrVWM+iBs8iBkpRCDmqxNwZ1VD88MNDo
 AWCEbde+4DYLw/dmBVfC0pwHGbjTzbPhdtxgbm/R/p4rlqT0WZHwPB5y1QV01UOxDP7d
 ms226UBOz6yaGxPMH7o1ilgcC9G5x7DxIc7wgd5i9bQ0TxIqLpZEXKqqUmwisfzltlij Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8yd8s7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 13:00:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATBQrHt027211;
	Wed, 29 Nov 2023 13:00:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c8aayw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 13:00:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI2HpLYJ4NvwKqe94HE6ZnJbAnZDfpl0dEhpyrCwvL50xuzNY6ZYw5/Jr9QqM1ELkIr/YDWVUPl8Bi2akf6ZunYEp0GoJwU1R3PZUTSjE1kogzotTgxoz5/A2PLhUMnX94zqKU3UD4lv3TLzuoT4NWMLECfMcMY4ANbsIpE42VXCUtKk90SZ0kxxXdsANlpcTLAa2XpOphCWRf0zkvqps/4CBM1EvMXW/1JmxOPt25t/33mImZf+zT+Wzb3JDnkHocY1ABRxxVNyLK4myrAS/nmJ8jbYs+KIzULKP3TGMPC9K26Oa5DM6GqBGGYIraIxP4QpvUz+NCrO/kdmxMUo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAw2jjROz7UaU3/PQCVbpJdaaQZOWqyLM5onSIhJZiQ=;
 b=Qj2WrdRlrECUkz+mrRf5k2VWgg/lQLRE6kZoxHKHrM1ovGx2u6dzWkalKSTx6Z/i7pOP3K/UnJQDRmWWtEcj8FhGXSJ//W5v9l+su4e2OFshi0o9wdFBvY8NKbB0qub34PBT1nAVF+8r92tlTq+dp3kvAh9htFT56xCM3bLsv553TZuJFTtg1z8Foh5I2wBym5BKLnxSFKjbT019Ei4uTIRhK4cYESitt4pnsPNSSP9yQ8nSkGRUgeEswk9o3vPpxCYGFIIJzeI0k427a96FWhvimlAK4F4PD+dTonDdbu4n1SH4FgHE9YD+HrjFcOVSwL445m3nofaEAdJFPe+I9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAw2jjROz7UaU3/PQCVbpJdaaQZOWqyLM5onSIhJZiQ=;
 b=O/fCUSj5GfFW3mm6BLnczG58ffp6mLHtlz3WjzOolS3IGOIgxTK2XOgP4wHskr6Yr41k/W8mxQqiOjefZUkqSo+92FOCGGh0gaiu79edNn+peTgHJmJUMOlk6LY60nUKOAmlpl2SdbHYs5XtiOoB3BJ4iNkznmQqLQBsF2SJk9s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4570.namprd10.prod.outlook.com (2603:10b6:806:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 13:00:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 13:00:03 +0000
Message-ID: <3e4cd111-e5a8-6ffd-eb82-0312b6ae739c@oracle.com>
Date: Wed, 29 Nov 2023 20:59:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 00/19] btrfs: convert to the new mount API
Content-Language: en-US
To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1700673401.git.josef@toxicpanda.com>
 <20231128211504.GN18929@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231128211504.GN18929@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: ec912ee1-c396-4209-7854-08dbf0db1a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4U5Gr5zJnL7QeHPSrwwQnd97NSk/DZfCn1GoqiMBjc94C3X8Y/idvJN6AzzfpFmku4nNuEdEInv5nI4m+ThKVhdqQDOeyiCzTFv0w+gg+5PWd0UwjGs3JzOTE3mKZ0gJE29DEAz6opku96Tth8ykedIPM6y9ez8by/TIKNdb80cepRNfRRR8+Qy3q2Wh8tyPczb6Iv414xPsvvNKBPm7vkpz6Sja3N1HHLaRoXymsIxQEJIKQV+0hK/X6KDgU+mmqvEVqnXXHgJsoZlw6fVoOHfB4Jf2DjLe7x2hysgFOCXmdsoamXbrO8r++JeUFbegpE63uP8TTyNfgaAr4QbxAjdDabc6IQ4feihRh4SHwBfiFsGoqHv8aprCrvcPZZaq9gAL4a1V/WKO+v+5qkfOdzjREq3CjkgUJh6dRuBuXb68GM2o0xHignOyU62GBMVuZ4Qhbo3iVs2pmwuKTXibZuDNhUjJLAIkWHBOdeAAVZB8xLckUGk5J0HV9T4YKlRxjIqjyj+VUFO+JJ5weEIaqhuA/H/vWCgkF8FbItQHzKhtmQp4517CjEUNO6NcXPWS65qR5uS50Y9Ifi8CpHfJPh5yA172L2DjXhyVjkZ38shE8cLu5YSWvOP3rKpi3QQVEHfGl31OfdhG/9oDgsudaA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(31686004)(38100700002)(83380400001)(2906002)(86362001)(5660300002)(44832011)(31696002)(8676002)(4326008)(8936002)(66946007)(316002)(6916009)(66556008)(66476007)(6486002)(41300700001)(478600001)(6666004)(53546011)(6506007)(6512007)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmU0bldmWUw0OGdKMmFtTVg1RDhqanJjZVh5ZVhYTmdKcFVtVUhLU2hHWWxP?=
 =?utf-8?B?TnJyNzZ2b3hpWFdaRFZXbkdJSkU0aGNrcEFsRjVzK3h3RDIza0lhU04rVnBY?=
 =?utf-8?B?QngwSFNNVW5rR3FYazBoMUhXbWNyUlJiVDdpWkh4Z0hPMktJYVA0eldDTmR3?=
 =?utf-8?B?TlFJVWFMdVdMNlJ1VXNqNnhvNFg0bWRWSGN0bkw1dDY5STZPdDZ1OHdSS3pQ?=
 =?utf-8?B?SSt1UCtONmsvYjI0NWdWWnNNZGlrSkNVZFYrWHpDejRNTitLNEZXR1hLMlY5?=
 =?utf-8?B?VEl3S3RsaGtXY2gxZ0ZEUloydlp4TnVXMmx5eFFHWWV0NHVIcGl3eXhiT2Ev?=
 =?utf-8?B?NTA5U1NXY1NqQThvN1JiYnpTSjVXMXdQUkNKbmVWTFVqNHRibzBGc25xM0lm?=
 =?utf-8?B?YU15UzN0VlVxMy9nbmdQb0ZZK3pxSWdpdnJKcERWeDBjbWlxMThiNTNvcllW?=
 =?utf-8?B?V0w5bCtKVkszV2UxeXhUODIzdHd1VmxSK2x0N0VoQ1RLQnMvVzc2TU16bHlu?=
 =?utf-8?B?eGd3Q0JTbXVxVVNzeDErSjJtZm84OEU1Vy9ESmFNYTZOL3hNOE5GYWNpUTV4?=
 =?utf-8?B?OTRNWFhCM2JpdWxLd3pWbnFTekRmbnVRVFFLdm92VlFWcDAwVVh2N1BWYkNC?=
 =?utf-8?B?czVPRUJPRk45K2pwZjRlSkl1SzNhL3dEeC9nSm10dkhLSXphZ2ZybWgxckgx?=
 =?utf-8?B?VDM0V3lwYmxJRDE3QWlXZjBjNTVPVTExMjMzRWs0ZW1ibkNmREN2cWFObUVn?=
 =?utf-8?B?WFA5YWhXdGJzYnFnMmQ3MzNSeWM0ZmdnTW40NHdGS1duUTdtQlpTWUFodzVa?=
 =?utf-8?B?UnNGZCt1a0FiNWx2OG1pTzg1U1BheW9lR2JoRkhiU1JvQmhrZmlJMGZkM1Va?=
 =?utf-8?B?UVVUU0lzTkZDakJnVnZRUHVxYVRlbmlVa3dBUVJoajZDSFErdHVuTVluNk9q?=
 =?utf-8?B?VExIMmp2WUdoeXFkR3JwbUtuWm1nWkMwTFBZRnRXTFFZVXdkSXBIbk9CaTgr?=
 =?utf-8?B?ODJLc2VtR1ovb2NXTHFsTmd1eTN2MjU3NWFHNmpCamMyWEpUWVRWU2dReTds?=
 =?utf-8?B?OVR0SjA3bFZqMzVoN2xxaWJNZ3NMd2Z5TU1jYld6SnQySDZzUlQ5bElNYUU1?=
 =?utf-8?B?UjYvR3lLcTRsSkwwY0pvTkI2YVNaTDFIMEpteTJ6MkRRcDI0QzR5RTJGdWlV?=
 =?utf-8?B?ZnpnUGlPN3laM0lNcFZCaW9tM1l5dDNVN25uejlDT214WXEvZFZIMTJnaDVk?=
 =?utf-8?B?bDI4SXdJYnd3UFZWTU1kOU1hQUFobWNyODc0RmdLVU1UK2lxYVgzZTBHQXha?=
 =?utf-8?B?L0ltUlVCR2NHbllCS2YwQjgyTXdVd3dOQlVkTUw5YkN6M3E1VElJMU5PNW1I?=
 =?utf-8?B?MHJQb21jOWQrdkRGRTBKQ1J6dkpleGVGTHZoR01EYTVCamVSWWN1Nk1uTVpK?=
 =?utf-8?B?S3VaeTFEZXVMODlXSFpNMDk5WUNxeVhvbzN4R3VVbXZOd2haM2tGek9VOUl6?=
 =?utf-8?B?ckp5cVdLSWlxSzhBV0Z5bG5NcEIrVTNMd3phZkhIUEtneHlUZTE1SzMwRlFF?=
 =?utf-8?B?Zms5Y1FFVTRXN0dhL0xCbnFRSXVSWVU3Rm9uZVBnc0JhdHJWNnNMZG1BMTdn?=
 =?utf-8?B?dWNncnZjc2Q5cXNOcEVlTmN6THZUN0g4MVNhcDFYOGI2amhPRlRTb0VxcktZ?=
 =?utf-8?B?ZVdVS1lCVjFJT010TnFFWHozbzZzb3JUTVZ5SURnbHliM3JTV3JNLzN3Wjlw?=
 =?utf-8?B?ZU81U2lxMW45M0Y1NFJpazZNdnQ1Mlk3RzN5S2d0R1NZNnhDYzE0UjYzMzJI?=
 =?utf-8?B?WmVHWk1zZXZzbis0UDJTK2RoSzlOM05MaTVIQUlraW5WSzcvV05YL1FPejZR?=
 =?utf-8?B?U1c3VjZ1aTdYazNsTUdmaXZqSWJPNkZBTFFCQTVNdVEyZ2Fpc3Z4RE5LL053?=
 =?utf-8?B?cXNDNUsxVDREbjhiTjNXNHR3eEN1b2lram1sWXgxbDhMTUdXcjVaUHRQK3Zj?=
 =?utf-8?B?RHBOQk9ockNxQnUyRnhKZ1VoY09ERGZmeDN4QWM4RU13enJ5Zm1JVXEvYWxH?=
 =?utf-8?B?RjlDY1dDZStCWUZnanFCa1JoNytrQ3V0TDlPMlZodDFCYzZYNWg2MHF2c2dz?=
 =?utf-8?Q?nWashS7GWCaRq+nakIdCHppcY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IbXmFogsjt7NFuEtvBGABaIVmJ0EHgFIpMyO71supF+jIT1kkyJ47y5freGi+IrxVOhqJC0dwQ+jAkbxr6werAjPmjgASYXs4wODgc929kppEfMwV2wL7k2CAPt5Rcma3K9HSD+v4YtjSJyvyBBHLQ4Gqb3sY3piiBpD9iKVIXid08Exp+9eEGiBfuUQFiuIPH0/FjI6VlVooa8tiijyaFg1984c/bHzghJmBr4MkXR45mgM3XhfHXFytMAuxeJBIDyFMQSdWR6xioJJkDRqoVCZwjtOjFLhnnANp/uzoJRY5W1d8T3pLjwyGsTIswHjcSC+O5b5vFgvYtEr6Kh5VDnS4OyVknOwkosEkmWsN9fN/Ekr4UFYLvxBsXffvigSdwsZHGxt4mZeyXGNazQl6bKfkJr+q/otmeXeKFor6OwoBypdIhiXxaq/4I6yJ9nj+xpOHRpsG7FsNR7FwNtY1QqNe3KBVN0wFjkxDQzSDZir3fb4CdROiUQOxXEnzzK5U4LIgbEcQAoTGQLwTibJlLN8v20ndGzaQm0bpEKANUr6KzH/RPqTl4BzelbPQxyKQ0vb5LiF7ED0aoj9+5+f37t5OdZhM4B3JtOibpW7FUf+BZib7Tw9As0+O3jkmEj+dpMMOpLYr6B91dUTOxL1G4cLUtyisKmICbiaDKVD42mjUPfBjGW2bwGK8Q/Q5LgeaIkKAiTwcW5PKJt/kIr0WiuGM3po6waedPOxlR9nIac2pMFJMFZx+MWnHc51zdfgRMYJ0swke4ssIK5eCMfuheI4hyUIjLKoFGtY6xx3pG370Zl4mqYFHhIKRjWS7l70SpnH8BWws+QCuWs8QyMbPg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec912ee1-c396-4209-7854-08dbf0db1a45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:00:03.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIgFMFs7KSmgfZTzOCEqnZ04/a4hxKd7qJ5B4T6nGno8eTZ2aDSnLoHhdWunWCYo88uKUEU8Rx9TPDRT5uwiHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290098
X-Proofpoint-ORIG-GUID: Sfe98zPs1RgvEpUsdsiIVOvkoS_SBp6m
X-Proofpoint-GUID: Sfe98zPs1RgvEpUsdsiIVOvkoS_SBp6m

On 29/11/2023 05:15, David Sterba wrote:
> On Wed, Nov 22, 2023 at 12:17:36PM -0500, Josef Bacik wrote:
>> v2->v3:
>> - Fixed up the various review comments from Dave and Anand.
>> - Added a patch to drop the deprecated mount options we currently have.
> 
> I finished review of v3, there were some changes missing from my v2
> comments, I also did some renames and comment updates. Patches moved
> from topic branch to misc-next, thanks.
Apologies for the delayed review.

The renaming of check_options() should have been in patch 2/19
instead of patch 14/19, avoids confusion in the function stack.

For now, except for the patches listed here [1],
the remaining ones have been reviewed.

   Reviewed-by: Anand Jain <anand.jain@oracle.com>


   fs: indicate request originates from old mount api
   btrfs: split out the mount option validation code into its own helper
   btrfs: set default compress type at btrfs_init_fs_info time
   btrfs: move space cache settings into open_ctree
   btrfs: do not allow free space tree rebuild on extent tree v2
   btrfs: split out ro->rw and rw->ro helpers into their own functions
   btrfs: add a NOSPACECACHE mount option flag
   btrfs: add fs_parameter definitions

[1] {
   btrfs: add parse_param callback for the new mount api
   btrfs: add fs context handling functions
   btrfs: add reconfigure callback for fs_context
   btrfs: add get_tree callback for new mount API
   btrfs: handle the ro->rw transition for mounting different subovls
   btrfs: switch to the new mount API
   }

   btrfs: move the device specific mount options to super.c
   btrfs: remove old mount API code
   btrfs: move one shot mount option clearing to super.c
   btrfs: set clear_cache if we use usebackuproot
   btrfs: remove code for inode_cache and recovery mount options






