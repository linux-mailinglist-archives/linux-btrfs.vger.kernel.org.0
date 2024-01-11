Return-Path: <linux-btrfs+bounces-1383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2059182A6ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 05:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09AB1C23258
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 04:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864A1856;
	Thu, 11 Jan 2024 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="USjpvNlc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I0ZG9LI2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55F1110
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40B44Aot028609;
	Thu, 11 Jan 2024 04:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Sy+iYjua9JF5a76o3eog26wLUD0AKuk3u+agINgLsUQ=;
 b=USjpvNlcI4NTvycf8+h3X3AvOYivB/L8ci4heb1jE082eEUlDabIB6vhzFQVAalkxCG7
 hebUPMH3IWD7jvI96Qdry/gPk2kWysmVq5V/a9DyL+bZMVv9n4tzjEf2BP1Uguf7svM/
 6T4HaKmlgALumLn3EW+kTeggMOBF1bX/ypxWQqIZ421qo8UvSVt2MM1fwBENdXhJW7+M
 kNUnq9MC9+bcMkW2PvbfivX6gHVPdWTGRqV6SnECdzfe+9ZAA4giOit1YU4diUBAiUu1
 PBw/y6xDqj97y7WGrYN/HlzHEJeA/GimmzXFcV+vUB1GdkyzlZ14zctKCMTTevGSJn/K Mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vj4wwg85y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 04:20:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40B3sX2U008682;
	Thu, 11 Jan 2024 04:20:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuumjg78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 04:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSOotv22Da37zm8M5MURJGJkL4CzYEy58IjQpqzplY3d06ffRtyzJzmdP2AvmzHfHLZkAMHUTnRL946MbEHUOw5WWAY7x+fZfWWwB1CeXF3m822NXFZrj+XbvC37B8affJ38xvhCnziuYhSwlHoyv4dJP89OPIF7VXpMwxdw7Ogcg6aVXjtiUDXvIpRtlCOWwWOBklOjaCYRSPgRhvK1/GJmEeFZFgB4ziTr/Ov0DY7O7a/2XFe8WFM0O1Po3LHbNA0UB4hrYGWDsF1vurS2MTOCCgykoOfH48HZBJB0ItEca8qv7PrJGVsnHXP8KRuAuK/E0JnvYF6tAH6CgAph9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy+iYjua9JF5a76o3eog26wLUD0AKuk3u+agINgLsUQ=;
 b=EsBCnitT2dcNek+GyrR746/QHGIQPmT0nJqYmpjhzApZNgmEAJgSprPaH28Xr+2b3yPemzCL4V36q0KTJqtt/jBC1gXl1pvcMa8CNocpC1Zlw7g5Q5dz7ctu9bMoqevCwMp6mgj8i/xEflRX7Gu5fE1y3qT6YD/LEkBzYPZ2j5aZYY6SwDiE/girC+hCGe6WEdnTiAUAIFpHUva+slzB6bq1rWFtCcuv0Ofua1FkczaQzIXnfWOt7hesNnXnZXd8D00tt07h5vXiujnGhIPd9drutNvuE+H3hNjwJBsNmD7WiaIPV9yU2UWSgpWs0HIOU5RkhsJqvZ8fjzUXpTfUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sy+iYjua9JF5a76o3eog26wLUD0AKuk3u+agINgLsUQ=;
 b=I0ZG9LI2tHzrpoxEGDa+7wCwfvBcVvm3vl6BojdTP4SAwfzPZt4tzUUmLlR7mn9/KiBTyD+p9IV9zEDul0RK7ZjBdRpNdaM/hZkU6yIythOCdrAAZQEiUuNNzIu8A37EVZBnL+tOwz98/2AoyGLFhuobdKQgFO6T22k3aQLpV/4=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SA1PR10MB7662.namprd10.prod.outlook.com (2603:10b6:806:386::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 04:20:54 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 04:20:54 +0000
Message-ID: <765fe050-bd8d-43e3-875c-575465479693@oracle.com>
Date: Thu, 11 Jan 2024 12:20:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs-progs Documentation: placeholder for
 contents.rst file
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1704906806.git.anand.jain@oracle.com>
 <5563896f320e169cbd31f13eeba7ca2efb655d6a.1704906806.git.anand.jain@oracle.com>
 <20240110215204.GC31555@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240110215204.GC31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SA1PR10MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5e3179-12b1-45fa-2cc0-08dc125cb386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bJa/vlsufovGDKLYVarGsZYteBKgKrwWaW2xrUfS7jFWNPhC2Am+YYl86yj0WaSRBIQZqeL2UcP933nScY9r7/4K61n/0/hTJNLAdk06omUlyvkFlXyGdu5Ccp9lqPuBh+R4u94nIZOYB2nI8s/9iErQbshdZPN74M2I9KI4ZorLXp4m3pwfvDzwEfiQTAaQDH7p3D3IFiNzIyZWx+mAFKF3LvjOd/A3U9Jkrp48JA/W9UuFneT7eSNv5XGbxwjJ5Ws2BTsx/1Ziq44EGylGGdAnJQgN79dP67kDjCmA/tdRk7q27ofu3MVqZFg5Aq6BKktRT3+tDlnWmj/+j3F5787xCJ4GUeHINTD68fxD0CuvjOF4p+aMeGUD/79F5qUl1nvs4OTGk5ijKGZa1205Pv9U6ATjvebVVS/1HEd2W4ddiDuct+qGcP/hU4Yk4i4TuWEEFM3P77sRr0V8AQvAA+HfJ6SSwRIFzAMZtuczcu4ONLHM6/SQUuCmO0ayRUS+5yaPHXnJSlEroeVJWQmSjPy9NFl68TulFq5n+dLWM6SFiUOOP9WhN3F0NWk3Cw3ru51v4PLgb88YiIqgV1Gu9MGLZdiijzuoCPUA9Eu4aVwzl3SArufAXcO7KMOxBLW+GYEs+jyxWnJmJwOXCaBDmw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2906002)(5660300002)(478600001)(6666004)(6506007)(36756003)(44832011)(4326008)(8676002)(316002)(41300700001)(8936002)(6486002)(6916009)(66946007)(66476007)(66556008)(53546011)(6512007)(2616005)(31696002)(86362001)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tk9sWVdqNkp3a0VESE8rMHNtU0Y2THJDKzhZVzdXcTFQR2ZkQUQwUmQyeW93?=
 =?utf-8?B?VUtxTVhZOXpCN3lCNjdTQTBEcmE5T3FKcjladUt0NEduVTlRNDJyRVdGbFg3?=
 =?utf-8?B?R3htQ1Q3U1JyaG9HQ0NmL3NHclpNR0dkM01CVmJBeGZOcEVtUkRId2RjRk4r?=
 =?utf-8?B?UC8zd3VWYUpRTml0WGhWMm01NVliQ2RNTXpoMkYvTFo3WEhSQnJOcldNWWRG?=
 =?utf-8?B?YjMvQVE3OERaYkNhZTVNM2ZZV29wTFBXRHFHdEtzYThBRVZaQmhoaVlOS3BC?=
 =?utf-8?B?M0hFUDAxY3lzTVRkaE1FTGIwV0NUY1E0eGpRNW1pVmpyTE4yUVhIaFAwaTIy?=
 =?utf-8?B?Q01USE9BTnQrM0JjVHg4UGtFVU4wMGN4Smp3MUZLMmFnT3U3RlBUNFB2RnNu?=
 =?utf-8?B?VXZoYU5Eb2hKUm5SNUdWRHNDeWJSN0hpWWVNSjhxNjM2NlZ0Tm9CMTFCN3ZX?=
 =?utf-8?B?dXBGVDhYQk9ESTY0bTlPNHlCNXcxblVyM20zY042Zy9RZ3RvMlh1QjBCRzdW?=
 =?utf-8?B?WHVoZlJoUE1CbjFiWDFxQkhpclJFK0oxV1ZnRzZ2Wjd2VXBKTUVWT2NEWE5i?=
 =?utf-8?B?cytvK0hMTHY4d01ZVmJ4VWZwYmE1NDF3clA0b000UUI4Q2lGbHFJMW10TE5C?=
 =?utf-8?B?c29JQnFVUTlBbGVKZVlGS0dqalRMSXhEcS9ueXI5T1JQcllPcDM0NWxseHl6?=
 =?utf-8?B?eW9WUVVFQVZsYmZPeVlTWVpoeWlyRnhOMC8xMzJCbFdrNG1vUExuVkxCc3Fw?=
 =?utf-8?B?bXlpV0hYeXpZbk9GTUVNVTNSWlBmNmpMTW9HNWJ0Yy96dE5IUkdJOXBWeEV2?=
 =?utf-8?B?TFNmMkdnZHZFK3VZT2FmY3ZDeUhubC95TDl1NWovS1I1ZnZpRE93UmVWQ29W?=
 =?utf-8?B?R0hUd0syKzRhSTY1YVd3Rk9LbVRuT3dESXZybmhKcVVWMXVMc0xoQmh6M21u?=
 =?utf-8?B?VmpyVlM0YjF0cEZpa1dneEJUYitvMU1PZkF5Z0lLQjgrY2NYZXN2RUlkN0Vt?=
 =?utf-8?B?M04vVUJMczBlM1lodEpqU01yL00zd04zSm9ITGxBSXdZdXU5bTBuSjlYUFdi?=
 =?utf-8?B?Y2tKWTlFVnFxaU95T2lJRVNrVHA1ODdmM3BsM2h1Uk1ObWtSTTZ5RzVBeUVW?=
 =?utf-8?B?LzlFSTlaK2RsSGxoVVNrV2Q5MFhUZWMzb0FrMUdTbkRCUWhsK01wUTNFa0Nu?=
 =?utf-8?B?Z0kxRzE0M3pUZnBBZ1A5UGxaOXZpMkFxcFlkN25XdjQvZDZJYit1L1hySFUz?=
 =?utf-8?B?VGQ3a3hvREc5V3Bxd1ZGYkNJeHVkOU53STZYY0tWNnVTN0Y0WTFvbmFzc2pK?=
 =?utf-8?B?a040VkwwMkNkR0FVYVhpUVo1Rk5yYjd0blA0WXJFNnEzR2RzQmI4NnQ0Rzdi?=
 =?utf-8?B?bHF4NkZNTlcrcGl0aFBWVEtFaVRsUlBkb0pSU2hFSGxONDNqN3puaklHQ092?=
 =?utf-8?B?SFBNcmFOOUx0SmdCSklpa0JySDJISmoxZ3VpYVpYMWpMSHk2UVU5V2F4aHVj?=
 =?utf-8?B?b2NRWjdPVUVaTnRjZ1IzVnppZDRKRGd6WVdPRkFkcFlySlRLR2c0VjByWGEv?=
 =?utf-8?B?emduTUJYb2pPeUVkN0drNkpkazRZZ0x0TVE0SmttR1BFaDlDSXdaRWtGYldZ?=
 =?utf-8?B?eUg3ait2SVJ6Z28rbkJOZzM2VCtFWEovVGt6YjhVWG5iSTdLeVRHdUxoSmds?=
 =?utf-8?B?NzFJT3B1Q0d3enFxNzZiYjBsakVnSERpKzh1WGt0aC95SCtPTzd4K1Ewdnpm?=
 =?utf-8?B?UnVtYmlQM2N4dFNHN2FmT0NNSllndVFlRHQyWVFaK1dUdnY5ZEQwSThHS1Q1?=
 =?utf-8?B?WkZEeDJYWDBZVUtjZ29EemYzTFRkVzJqWFFtZmJsOEg5V2doY0VsMzF6VGNw?=
 =?utf-8?B?UjNiWENFbDd6TGU1c1FoVE9INlR0LzJNTEVIVXZ1dWJOcHlyOExNL1FqVlhW?=
 =?utf-8?B?aEJ5MFMvazVmdlMrTm5iVWwrZWUxMWlnSXpoV2RmdU9XczJlQjM1dmt3QW4z?=
 =?utf-8?B?Yk9TWWZ2ai9ZZ0NJbERTUGtNODE4VHBRLzRTaUtHRDFad0d3MU9Ka090ZGJv?=
 =?utf-8?B?T1JncVloRU1rbnhBRzJwcEpld0dnd0d4N1h5V2RHN3N6N1BoeVVXQlVxUUQx?=
 =?utf-8?Q?I5f+0sKTWxf0Iyz9mINSBrevO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M2w6d7+iChe62FzsL/HTv/UAu8E+Dkw6Zy2rMYStDgDMFYMYJZJJ44BCIGrCGByvGyP6/n5q5SCW3UCZ1C2RaKJ44AhvDy8VTkppnkv3HXRY5CZvNQXQWUFTuJImZR4cw+kRN/ubdU20aDookmO68/vJzpAFb5oAdAcTHUN5ws4yJI1FIkcJQ9VP7scaInjPaj8O7UBV85/3bcA7FCZTTuBkSGm7yKg62QK+LeFFsimmfA3mWn0/GCDM4JfqvzjHXrAhn92omvJ1aLDIfBsnAaKpB21mqkxgWlAJh1SjmXgiPswueWViIkaeOPfXg8Rae9mRmAoIUjpHFbE5X6W+i74P+HtDCYwihHrGl4CGAozS8GLmuUVXJMCX0zTKOOIPOAi1CWf+X66oURVfrQFOmYefx+BepdmUFTUzYXolDW80cLFTAI34U1M5xq0U/w7QUPb47wBAAPAKAUwYqvIPLC3h9XUkckNQwV84bM2IiwtZQc9rKqbIBrxkHq19Vhzh2a14PaP55Goxa2qL/XW+vx6lqdVpBR0vb0fWsjsNIL6zxa17J/yoma6bhyhaqOeAMgRC/LHqeGPXCbUEYSfTqDdgfUxPm4pIFQlGJso2KTc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5e3179-12b1-45fa-2cc0-08dc125cb386
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 04:20:54.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4oNWvYkHInJP4V7zUvH8xYLUtiYve454XlnsyHjcfLNExBzDn9Noft4DeA7SX6XVaAet8ib5PY0p2VWjoWP3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_14,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110032
X-Proofpoint-GUID: VJCH58s4cEj20zVsDyIJdYQYFtQIJ6d-
X-Proofpoint-ORIG-GUID: VJCH58s4cEj20zVsDyIJdYQYFtQIJ6d-



On 1/11/24 05:52, David Sterba wrote:
> On Wed, Jan 10, 2024 at 10:55:23PM +0530, Anand Jain wrote:
>> Sphinx error:
>> master file btrfs-progs/Documentation/contents.rst not found
>> make[1]: *** [Makefile:37: man] Error 2
>> make: *** [Makefile:502: build-Documentation] Error 2
>>
>> This build error is seen on version 1.7.6-3 of the sphinx-build.
>>
>> For now, to circumvent the build error, create a placeholder file
>> named contents.rst using the Makefile also add its cleanup.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Added to devel, thanks.
> 
>> ---
>>   .gitignore                | 1 +
>>   Documentation/Makefile.in | 8 ++++++++
>>   Makefile                  | 7 +++++++
>>   3 files changed, 16 insertions(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 26f1940d5546..bb719b41d200 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -79,5 +79,6 @@
>>   
>>   /Documentation/Makefile
>>   /Documentation/_build
>> +/Documentation/contents.rst
>>   
>>   *.patch
>> diff --git a/Documentation/Makefile.in b/Documentation/Makefile.in
>> index ffc253863ba8..2c036eef00fa 100644
>> --- a/Documentation/Makefile.in
>> +++ b/Documentation/Makefile.in
>> @@ -28,6 +28,12 @@ man5dir = $(mandir)/man5
>>   man8dir = $(mandir)/man8
>>   
>>   .PHONY: all man help
>> +.PHONY: contents.rst
>> +
>> +contents.rst:
>> +	@if [ "$$(sphinx-build --version | cut -d' ' -f2)" \< "1.7.7" ]; then \
>> +		touch contents.rst; \
>> +	fi
>>   
>>   # Build manual pages by default
>>   
>> @@ -53,6 +59,8 @@ uninstall:
>>   clean:
>>   	$(QUIET_RM)$(RM) -rf $(BUILDDIR)/*
>>   	$(QUIET_RM)$(RM) -df -- $(BUILDDIR)
>> +	$(QUIET_RM)$(RM) -f contents.rst
>> +
>>   
>>   # Catch-all target: route all unknown targets to Sphinx using the new
>>   # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).



>> diff --git a/Makefile b/Makefile
>> index 374f59b99150..a031b0726a9c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -417,6 +417,12 @@ endif
>>   .PHONY: $(CLEANDIRS)
>>   .PHONY: all install clean
>>   .PHONY: FORCE
>> +.PHONY: contents.rst
>> +
>> +contents.rst:
>> +	@if [ "$$(sphinx-build --version | cut -d' ' -f2)" \< "1.7.7" ]; then \
>> +		touch Documentation/contents.rst; \
>> +	fi
>>   

  And we don't' need this either. I'll send a fixup based
  on your devel.

>>   # Create all the static targets
>>   static_objects = $(patsubst %.o, %.static.o, $(objects))
>> @@ -910,6 +916,7 @@ endif
>>   clean-doc:
>>   	@echo "Cleaning Documentation"
>>   	$(Q)$(MAKE) $(MAKEOPTS) -C Documentation clean
>> +	$(Q)$(RM) -f -- Documentation/contents.rst
> 
> You don't need to remove the file again, it's in the clean: target in
> the documentation directory.

Thanks!, Anand

