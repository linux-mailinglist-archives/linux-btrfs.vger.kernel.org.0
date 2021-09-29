Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096FC41C4E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 14:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbhI2MqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 08:46:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31708 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343839AbhI2MqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 08:46:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TC9cfn008682;
        Wed, 29 Sep 2021 12:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Bmwzrzg2UYH2at5BTstK8j9Ev55MvKRQx8Cp5qyp0Qs=;
 b=Uzzov1py2ZRdToVlL6B5lOoQ/Oy1qREca1UgIRhGUDHRcA/DVZzskoxQnqkTBtgrRUfY
 c8aHgxFjzafb2u46zGXJxwWXl7RLROlFIEiiAmEAnbU3LKmyqXxU2MQ0bE4GnzTNVfWV
 0Mfs/gHrzyDDTGe26dPMsDvBKWVuB/KqiWwwWTd5vy5MeqNSoCzHaGsoaQNmJfrocmDg
 yPjzekRaPLW3CAcvbuMnSPg0wtO5+z4BOgtCPxtmTuuCE/Dwp2KAnDNuJZ0+I8YLkF7X
 Pl5R7cmWDqEhfhgx/RvUfxBrBbo+YYk4i0skEZvLCUYeu3yLiMY0VseQQFu5l+3g4JwS dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bchepjg07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 12:44:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TCaBWQ135325;
        Wed, 29 Sep 2021 12:44:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3020.oracle.com with ESMTP id 3bc3ce4wpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 12:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWmfVITEx1+6OzGkNYAAkNN9tzRZvUIW+V0OXg+eVUR0eA8jX1G8+dFnQvIrni0TNqh48MZqHX8BEhd+/cMDB40WVAnbgGeHqDRkjkzJTDhAAOOY9ifM2sLlqMHF/q1K24udTfY5PWDuB4COlxngrpRrz3KP4nUtsBDVQwKMRIJlhAf8j2RD+TDSoD+iTcw/MCs2/8yPx7/Xeno5ag+JRrlARwJw5IuI8lSx77n9oCAWAKaF5dHVnph7C9NuXdPRqmZNeKVUaLrL9UvB/y+imDl/unDW9GhFDV4+ly2eDiNtG1VflqMiYzFzIgX/WSRmed2/+SAIoMyZi6GjLyc3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Bmwzrzg2UYH2at5BTstK8j9Ev55MvKRQx8Cp5qyp0Qs=;
 b=TMs/2rNsbq1w42SeVq+ST/1SiIGOmxQNYth5hasbaMc7xkrMvlL49vPurYDD4mQ6xXd8DjWCLthXwk5NxXB424Dhsm2zfReCAg0tcgWUJk1CB9yYcg6WAUZbiyQm96ezCVEWzn3SnkCAQw68P1ZpsSPGCObbHjYGSlxtMCQkFbRAzZfyW3669RtUHmjSBNwAehOP3I/7yPgVbZQ9D+QORGB68N9X05jjTrXb8ba7H59tLwvGDoFhkOw7ELv4Ztr94c2d9wSCd5GDbLWAqjEPpNSo3k1Lo3W69/oBa+Uur4yOkJMkYipFI5F+DXiS3GjGFRc5y+zoOfNqH4FYpWb0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmwzrzg2UYH2at5BTstK8j9Ev55MvKRQx8Cp5qyp0Qs=;
 b=kQGUTLQczg3ltnUfLokqRyjmiv+s9CoRvV67qVvqETLwqunv7qV4R8A8lZzoOoI1JWmLyq++1RkjYK+xiZqqanHn0SL+nF1bR5ooBB2pIt2GmK9+PYRkc+8Xy7lYnI1SIapGXmV3bqKTK1og3n8gnTSOcTV/16h015LEVff0Ik4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 12:44:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 12:44:15 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: Ignore path device during device scan
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210928123730.393551-1-nborisov@suse.com>
 <50f82537-0ccc-701d-215a-f45c20c0827b@oracle.com>
 <9330f390-f561-7358-f932-46fd580f98e5@suse.com>
 <036be5f7-642b-60b4-f862-7541e65c0551@oracle.com>
 <42ce59f6-4458-5cf9-351e-7fa81d62ebf5@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c2828ccd-80a2-a7c9-0282-bb58046375c3@oracle.com>
Date:   Wed, 29 Sep 2021 20:44:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <42ce59f6-4458-5cf9-351e-7fa81d62ebf5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0138.apcprd03.prod.outlook.com
 (2603:1096:4:c8::11) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR03CA0138.apcprd03.prod.outlook.com (2603:1096:4:c8::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Wed, 29 Sep 2021 12:44:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a15d87b-de2f-41c0-b7bd-08d98346d8c5
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:
X-Microsoft-Antispam-PRVS: <BLAPR10MB515644A2CF4F048BBBCC89FAE5A99@BLAPR10MB5156.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xn02gptuNMYI6HtNW9b5MN1Qy/frMe7wxKnLe1+rugr9b15gPNb1yZKq8EwaXP+3Br+rgSav+rlUddivqguxYVQVdyqbB0n6gHMTF6Wn3HsPy4tdTwtOy0h4AW87qgGMySVYnW1+bMwPICguFbi5tMTSVs/O1PLVEQzBy8jqWEAwJrnB6u2w2551r6Movrg+bfuSRjmZ3wq8s3YKBduh98cUtV4QM52MV/jSzdc1Z98laQ9KKu8FJxhisU5f9/HdjNpSjHU+O75po+o+Zpzgvaqp2VEgoZ1nXNf0y7qAF4iCrQTqLvt2SHhKxexCfnO1nCsSInpQTdoP9GCd8EHhGucUFbLrw4ohxQ+25lbw/gW3FFkTdHJJbsSOpO2yffyuTkL7v4npAKtapIqe4oSekAWGFn52H3/EoshJ5As57sTISaktNGsboGYWIrkYFncbR0QA1gW2tWW54YEiw5neiW+J8LdMS+Kj91RrTVMJbKnYSxSclYLe2gdr5hcax+yQmityVM5tuebdMfFFO1BmzDS3xYxT/onpg3ze1Tua8dTQH7IaFMND/FcNDiV4r1qVuLMUhbBCVEX2Q+7I1NIRLCVflOBuTiYsCDpT8QHbozNytgsxbsmnAkY3cWz7xS0MaA7qrhRROZXc026b91P/GSloLrOJy0VvJxgwpLJ9pJBzQiw4kca95WwWASvFt4j32LDpLP6db6RxqCRrnmnMTAuxBSpvhwVITPXs7wUYQbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(2906002)(6486002)(8936002)(38100700002)(26005)(2616005)(44832011)(31696002)(8676002)(6666004)(16576012)(508600001)(86362001)(316002)(31686004)(956004)(4744005)(66476007)(186003)(5660300002)(36756003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lCbnVKMi9pL1Zhc2UvRWlsNWE2SzJLdkM2QkNxRnJHaTN0b05hYmNrSHdl?=
 =?utf-8?B?OVF6OTFlSWV1c296elRGMmNySGNMZ0dtR1RGK0lQSHYrSzdzVXZRK25oLy9H?=
 =?utf-8?B?Wjc0Z3lXS3JMZHRlRjhnN0NIUWxxU2JqZG9CQjFqemgydzM1NlJTWnp2U3Fn?=
 =?utf-8?B?dXlTcnpPUUI2aG03djNXeWRTYjgvbnVGcWhvYzBXbVlRZ1BxU0hjSGEzZHlB?=
 =?utf-8?B?eDUzUjlVVDBnTUdCM3ZISnNLTE9ja3FOb3BoNjRibi9WS0lqUmNJYVZmTWEv?=
 =?utf-8?B?K2VFaGw4bCtpeWpuNjFRY25EaUYzWEEwelYzakVuSitVWS9ya25ZVE5ReTUz?=
 =?utf-8?B?cHFseTFBSjVvMWFFQmRtS0xuQ1JJeHRSUGg4Rnc5U3pKOFl5eFo2YXBCVnJ1?=
 =?utf-8?B?WTVRRElBSVA4YXdxNlVabjVqTmxqMWJVb1E0ZFArc3pGdmhSR3VScEpZYmhB?=
 =?utf-8?B?MFFlcjVhNVo3dENLYm85U0lyTXJwek5YbDFEQjVSazF5MmUrYjFxS3VrN29X?=
 =?utf-8?B?NUMyOXBwVHpkcVJ2UlU2YlJxTWNra0lFMWRMUkNSUjdXUHhwWHNBWU90ZlBH?=
 =?utf-8?B?TXkrUC9oSDQ4WGdCeXBOMGxySzk2WHRidU1McE5KcW5oSk9SSktVZDhuYnpF?=
 =?utf-8?B?MytybEd3QkNES0ZjWWJqejZ2Q1Y1bmgxRkdNYXV5RjBPd25QanhWWkR3RTRQ?=
 =?utf-8?B?NnFuZmpsRFBWS3ZTS0Y4WG9RdDQySU1hemNaN3h4ZzdFeDhCd2o3QlNBdmZS?=
 =?utf-8?B?a0tBUWt4cXp0enZZNDB0OU9JRXZpbW00blhoeTBKbEN6QzdNV2FHV2JpbUUz?=
 =?utf-8?B?SEk4MGx0SVhPRUlVNnNXbmdXYnlxejZVa1ZPZWYyZFNsU29CNmJzMEFsYjVM?=
 =?utf-8?B?WXVGbmdaNUFVd3hrUlU0VWkwaFVTQk8yZkJ5LzA1V2FTYk5xKzVIOGtDSHlY?=
 =?utf-8?B?SXRMVlppYjE5Rm9IZmxYWkY3d3hyMVJieTlWRFFDZDNLTXkxMGZSWTJKck1P?=
 =?utf-8?B?eFFqR1NCOC9zUVN3V2JIdlhHTThQTi9BQmxXSWVkZ0RFQ2FMOXdSL3hOSENW?=
 =?utf-8?B?aWlWeXduU05JNkpoZ0NmVEduZzFqMk9RNTFBeGNxQmJBTnN4cXNxRW5ldHVT?=
 =?utf-8?B?ZnlTZHVPejNQVlRUc2QwZDhrcnJsVzFZRWFWMlNzZ3puUVVqZVVoZDMwcmc4?=
 =?utf-8?B?OVJDTEcvSy9HeENqTHREQTdRNm9tSk55WU90R2tPbC9sVXExWFRwVlJQQzRn?=
 =?utf-8?B?dGUvK3Bnb1RvaXJRYTk5V2oxM0UwSWQyTHlFSDhMOFV6NjBOUkpsZ2R2U1Nt?=
 =?utf-8?B?SjRjbVY3ZzU4NmNUcmhIQ291NS9TcHB0cWF3dnZhVDRwZ0JiZnZtVHdQRFMy?=
 =?utf-8?B?aU9nZDZYM0N0cjIrSGdFSXNtN1ExNVNUV1ZNK0FwRnlOOGExMEw5VmJlbHdQ?=
 =?utf-8?B?SW4zU0djZzZlZEhVTC8xTXF4OSthNEtmN1ZJOGlVTVFkaDB4dGoxcWZZRGtR?=
 =?utf-8?B?elJZL2ZJbVJjckROWUF4RWc1WTg4bHZUWFdsTktBREF3cEw2ZzFIVnN5MFFG?=
 =?utf-8?B?RGE5N2prbEd3bnR2RHFEb2huSTh5ZDFaWUhnR044OWJDSXhmNXpuWGthTVc3?=
 =?utf-8?B?eUR4eCsrdGxFSE52c0h4bDIxR1FoMWFSVXRTUVN3R2RvdzJyZytLcHRZcnhT?=
 =?utf-8?B?aUE2c25IR1VxOTQzNGpyZ3JyU1JVc3hveW8yc2g4Z2o5N2JpdE0wTnlNcGRk?=
 =?utf-8?Q?8Twkv5CQu3y0CqTmT4j5vqrWGE58MQHlITj80pk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a15d87b-de2f-41c0-b7bd-08d98346d8c5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:44:15.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqNoZ8D/t17+52QGxxeQu8NmkHbY9wKbx4mP4tucy98pAkiNu6QSXrGTZXX3UUcI5OpboKmlE0Iki5INpqpvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10121 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290078
X-Proofpoint-ORIG-GUID: 9ePTkCvq2LogCM3SYeavoZW3IlRegJ_e
X-Proofpoint-GUID: 9ePTkCvq2LogCM3SYeavoZW3IlRegJ_e
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



>>> flap means going up and down. The gist is that btrfs fi show would show
>>> the latest device being scanned, which in the case of multipath device
>>> could be any of the paths.

   But why the problem is only when a device flaps? Or it doesn't matter?

>>   Do you mean 'btrfs fi show' shows a device of the multi-path however,
>>   'btrfs fi show -m' shows the correct multi-path device?
> 
> Yes, that's a problem purely in btrfs-progs, as the path devices are
> opened exclusively for the purpose of multiapth.

  Ok. All parts of the test case is with an unmounted btrfs, I am 
clarified, now.



