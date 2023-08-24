Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA687870FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbjHXOBO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 10:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241391AbjHXOA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 10:00:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F28319BA
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 07:00:54 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OAotBr011750;
        Thu, 24 Aug 2023 14:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ia+qrqtWcWXN5AaKwah4g1k07BRQeEweUPGMtvQ2gno=;
 b=JE0wL+nOCqlAvdPSrpM41cTTUh+RxKJA9F714yxkrQc9WkitIaQWQw69lONO7PXbh18r
 m2OINHZwIoJ3J0JOTkIse/R7o1DEeQFh3mwDN9VPdNXGpq+aKrbrWuv+LzB/rhc6BpfU
 1D39ae5a3lFrAEhx7UXfmH0S52RZsoMOdMJsRRO80aF8JgyCB7IbUCwCG5VhvdR3hsKY
 dI6dGGMKCUhprC1J3hA4dYGPbMtFrgPcZTyLbZ0324Km2m7+Snk5zZ3kkU3pemOhYATH
 vHxr/39fmHj4mPCmnp4ct04TetV7uOz3+HowRoKjJa+Ud+LHRpd2Agr7ceOUj5WXS0Ci mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yu49x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 14:00:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OCTVDR033256;
        Thu, 24 Aug 2023 14:00:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywh1p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 14:00:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3kETSL5eu7aqo2UZJgiCtoEkvTJQtUROXvE4+mk/FMt2pI9B+asdKJfI1MXUH+tsRIYB6wP3aqoWiwO0KT2J5XjntqEJ9gTIlrY1CffM4nYS4h4aMkQvGOSf/m5PnPGMJPnfJEHQk/2biKYf4XOiIvDz3ub/sIN8mrb7vb8QcFYByCqyOztWGNrIY1K0iEIM0kOxIYE6fQr4NepGVGmltsj/8x/hc0nkbTcTM+nmO0RFF13oVz56NvkROglN+36KrRszVET9j2Dq4S1/Q13Z/ujm+B1x18Ng9CL4tuq6Ncj/CaM11X2gZFKqO1vWt4UMNHMrq1v6ZqTAy++OrKNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia+qrqtWcWXN5AaKwah4g1k07BRQeEweUPGMtvQ2gno=;
 b=OM7gRZSx8sQC+478r0tBdALB8eUSoKXZlVP5RaCtJIY6m7qAdwhh9tuzj9p812kGJczS1AG6WNF/cBdXu3YWIGq9tN+5HWbThmbNwaMXFkEh/4KcSFYlPMSzTJxGg1kLUhFKTESfFOUuzeia5J8EVgb2x5ZMy+mpHSnVfVfu9POKnbCUSPKjNwp0HP3ydjWhxXupDGK+CZzbU/BaKKwp7SRG6InGwtw2tcqOOjMiZtHqAm4ueT2UYrIWu0T8bA58Fs9azD4Wuwg4VQ1hBcRYt/mr8ws7EMJwNgv3rhUUy0clU7kYr/1Yu12UPRLadSRhbRuFXOGRnLQr4TCReEO9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia+qrqtWcWXN5AaKwah4g1k07BRQeEweUPGMtvQ2gno=;
 b=FmkhMrWNvFUL/PA/8g98FSA9epyhvRF6IU+WOsYeaW33TqqBwLx4RnKON8VnLihohUxA8y6EseSW/hxWsQsXzznQMSy3qjQnKGaLNwut30ieS6poIm1aFjuipO5YjnL/0Tbyaz3n8MR5nCyHtZOKeUrgUHeToXhJUDsXp8WRB0s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4442.namprd10.prod.outlook.com (2603:10b6:806:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 14:00:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 14:00:48 +0000
Message-ID: <e05b1f73-5823-2f2a-84ae-e4a612c07e30@oracle.com>
Date:   Thu, 24 Aug 2023 22:00:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 16/16] btrfs-progs: test btrfstune -m|M ability to fix
 previous failures
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1692018849.git.anand.jain@oracle.com>
 <af8ae1adbb827a1de806af25a63622b19d6765de.1692018849.git.anand.jain@oracle.com>
 <20230823201029.GK2420@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230823201029.GK2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: bf223afe-de0b-4cc2-e589-08dba4aa84c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFIvQgsk4m6PZFWp+G9oqGq2s2VltmlNxKn18oSSKw8fkZ/+6cW+q1UJRhLQ3eRHYST0ep6ttZYBD0C2kQiA0R5n+1McrPJCV9L5qqrVoRnYDO74iIPd/Vg7M+9nlWaFVeyRQ30AUteDONI9o4Ek1WuhkAqDF/IPX6R92CclSV/AduTC44wE7XDoblM2IKHtAGSc2JNaG3hYucssPfcOfC48QhhHvwmOZGztxipDMM93BmfDBALq+LQKa4k9nGcQqjC/ZmNYRY0YKR0C/+4MJYRhIrJQSX4n8hliVZPrs4FFNQfVd4wzj63w0Wh02hzmmzVOk4WFgRvmzAjjx+/frgh12miTRXY4lUpXUQLNUPUTo7IP0fMtBcs8UBHfxKRL5s0x2liuCBkI8a1ukjFyO4WSGvzaK7mwzoFwHqd85SbsWLo/T0c79zWwF2EaHIibld/Bxc2xMOgt3QKXpNzFU9JFhYJcRIZPBmyb/fqInV/otKyoEgFVYePZ2Y+JZx8J5o192ZbT8WfvtuGqcDvV+P92rtm8vL8gALnhbyRCIQJmTCRNRyk1nCyXpH7OG5tPlT13ygQh07EvPYAvYBjTbc0Jvejh32M/N/w9lv9wdD1hxPdWZPqHz8mhFfdjOBvewBqZ3gfLVBK7hvr7LkOoLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(186009)(1800799009)(451199024)(66946007)(26005)(83380400001)(6512007)(53546011)(2616005)(41300700001)(66556008)(66476007)(2906002)(316002)(6916009)(5660300002)(44832011)(8936002)(8676002)(4326008)(478600001)(6486002)(6506007)(6666004)(31696002)(86362001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FERFB5bmVZdE1pVHNrYTJYb1BHbndsd1JhREp6OGo0TnY2U2RGb1lZajI1?=
 =?utf-8?B?UHBNeGhBU0VXa3RXK0ZuQVJOUkVLN1g5OXpaVDFXMlp3SUVuV29xVnJja2ZW?=
 =?utf-8?B?SDFLcWRMenYycVY5RHhwUWIvUlQzZEN2NzYreTFXZHRRZ3lNR3FkMHV0b1dC?=
 =?utf-8?B?MDZLYmdVaHZDa09DWW5SNVYxVEw5YW1zbW9aUUR0VXdscGFRVWtnV1ZCRGp3?=
 =?utf-8?B?QUJZK0JHMzVtMlRnbW1DMXNEN0ZSQXRKK2pxU2VyamkxSmJTaEI0aEJqL2Ev?=
 =?utf-8?B?WVNWNzNpcncxT3E1VVF2Ty81bTRlM1dHS0ZVTXVwbmtWSlhtc2pNN240QXpV?=
 =?utf-8?B?ZTFKQ0tpajUxMU5pYmlhbStIblBEN05pWTJIWHF3UFVZb2NwTGQ1RWdxbXpT?=
 =?utf-8?B?aWVXS0lNZWlTK2lmQ0VHalBobkFjczF1UzJMODBhZ0srdWFnMXlXNTFnNWtO?=
 =?utf-8?B?dHB5WWxnUUV3anA4c1pCWCt5bjZ3eWFrYzR4R3JwQzUrdzF6RVhLMmF0a2ty?=
 =?utf-8?B?WWdQSndFUDRBQlF1N3J3bWhiQXdnL0RIUU1NVGhTNzRIdGp2a01la0h4c2lo?=
 =?utf-8?B?eVpPb3NPcXg3UEJiUmhjZmkyZVJObmR1cDFTclJXOFd6L1NVSllxOGFrSnFR?=
 =?utf-8?B?Vi90eVl6THpNYW5lMmNRa3liM3YyU2xiMkx6SVlmTm5yYjhzYWQwbGdqZVdH?=
 =?utf-8?B?blRPUWdnS2JnOEJVSkU0T0tjWDNyR0RIcVFmRzFaVkRra2F0bTY2eGFpN3hC?=
 =?utf-8?B?SFYzVUl5N3BQZ3JETm5QUnR5SlAxLzVYOWtmejF3N2NzMkFGWFJyYWRrZitS?=
 =?utf-8?B?MjdBL0hjZWZmR3RsQ2lxQXFRUjBKRVF3QlFTQ2ZWb0QvN2hsYkpac3VKVGV0?=
 =?utf-8?B?dVIrd0xhcTFSL0F0WVF6SWNGZ1JtSGVZOVMxUDFtQkhJVVdRdDVpd1l6aFNu?=
 =?utf-8?B?dXp5a01xaUdUQ01GNURONjJ3UVRENEhnV3lxTFp0WjV1N1c0ZU9HQ2k5V1lN?=
 =?utf-8?B?MVoxb0RuWHpuSXZRYVdzMEg5dlpldjlXSU12eXZpdG9IUHJENkxLRmhDQTZX?=
 =?utf-8?B?aTkxVGxYM2hsWXl4WDRuTzBVclFNU05rZTJXcUlDaVdCeWovdGtlcWxnMllU?=
 =?utf-8?B?MHVnS3hoWW1BNWZSRUlVejRTZUZpZXNFK2UzWStQT2M2aFdzemhBTUxKdk1z?=
 =?utf-8?B?SHdyam12RnpjOVdkT2lOTWJwekdKYlRQOHU2TGF0bXZaeng3RllJNmppNFBS?=
 =?utf-8?B?a0JhWmtlN2d0ZjhERE5IQWZTS05qYzc3UjhmaEY3Tjd1SERWS21zb2R0aW9G?=
 =?utf-8?B?WW5sTVRleDV2MTFUaGZBZkFUSjI5RXhlYjhzWkpxT1FNZkozUmZUR3Z0MlFY?=
 =?utf-8?B?REVUakxqV285QVBjWW1yU29Sa0x4N2ZjVGU4OFNLWUNXZHpEcEoydGRZUVpu?=
 =?utf-8?B?Vjh1YlNqQWIwZ2RTRFlGWUtxMDhSTnQxVGFEcGhrR0plaEtJVlM0bFJEbWJq?=
 =?utf-8?B?a1ZYM3dFcTc2T3RUVnNMMjMweEd6Z1VTQkE2VTdLR05nNlFsNk5nSU95eWFJ?=
 =?utf-8?B?Wm11K0ltb0xJeEQ4SnF0MHBiK3hteVNyd0d4T3VLUEZ3LzVsMHVkbWxvaC9P?=
 =?utf-8?B?MmZWNjJQdWN1Z3ZhMGdDcTh0QnYyMCsyak1EdDd5ZHQvTW02TXlCa1hEbkNX?=
 =?utf-8?B?bWxDZE1sR3diaWZ1aVdSNGZFL1E5YnQ5UjM1QXV6NTVUOE9mcmd0WDJoMXhB?=
 =?utf-8?B?V3BkeTRoNlZIYUU1TGFsSEV3a2tHYmRvMC9sMFpyN3oxbWhaNFJJakpEa1JF?=
 =?utf-8?B?QUtHc3RTSC9zazZ4R09Ha3d2U2w1WHVvUkcwaklmc1RleERTWi9hMkM5SDJS?=
 =?utf-8?B?dnV1UE9oelNMMnZJS2RaUkk2S0xuQkJXNXZ0Sk9JaWRZT2JVMW5tMVhaYW5h?=
 =?utf-8?B?ZjYzZHIxc0EraFBJZWxQTHdtRWFjRVEyVW1tTWh4MWtlejNQNXZuUXEzdnVL?=
 =?utf-8?B?RmxtOTNBZk5aUXI5VnJJMUkvS1BBNHhJSnFxZzdiUXgyTjJZRFAzOE01TkFo?=
 =?utf-8?B?SHFWUFVVbFZoVGE0QWNFOHAzWWlHMnRaUFlMY1BJT0pIaDkrM0JCVjBvUjhF?=
 =?utf-8?B?VDltQ2NKRncwRGUxNjQ5M2xJaE84R056ejhERGQzZjhKRE4ydDJaeVgyK1cv?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5fwivPK2hrV4w9FF/hLSgJhIXj/rtvgJDQ8KGz5K2Hxnk6zkyB72WitPMYKqRBWkvWnQRLNTVK5tVi2qCTB9YdWdbXwiURWazlJ7qwIiQA1lO1qYDhI07kaofIRdctqtb4h9hZhH8GANEJaVlnxGNUbfJoQrCiA5izsWcM5gORxcTfL53Fks3bVt8viLnqXZywHAKAYwJaDyaIbQm/QWushktRKxaz920YZq68QVaRfAXSyEUoEFCARJCgsujeAAxZWrP8KwqB3jiN/DD4tNZLkoY1eRXRVScw0FixASdO/mnWczdvR/uNWfqrvB280lWbwt0G4dJlBoaMqamSw0dr0a0WbRoHRFvUyqTan1I4zKt5sWqt0KS2qva0eX7K4wIazbfa5zG09oX41YbMT5Xmxf8qmIqE1iPcRNzmw5ERnp/U8AVfSH3/kPCJ2VFej6HqNO7zU/H6ngy/Yu43ZI+LCu/pUAA56ZFrJFZyGiK3fWEANTowd9TMbzAqSnnxPpK2PwSpfTwWfjeO2jzIM5D+PdI+QxDfxmVv7d9lE62pSjmeNgdsCmC5x7CKBIS42aoxY8UF1TY3goFZfvpaH7plIJ5BLDmZqJXfN6TCl8HhOG1/Erp/ob5VUFYrAZxU30wfRl4fpsDY3tY97+Ubnu0Edp+9Cj4Cbok1TJqRUNkJom/J4JD0mZGSibDlR/4ZqzU/YptbN4km0Z96D9noEAm73P2jmxhDRyyZJZxOMF1gTkIbaMNX6oaHBAKbpW5FvdPKglpcE/Y1HxKWqY45O7KLNJFp+j4sfAqgmPKYieFzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf223afe-de0b-4cc2-e589-08dba4aa84c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 14:00:48.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d63uyhRtNbqvA3pzn3w8YMmWsCswMHdWAFRZnesZNvawVdPymE168SWuQ9xwI2uwxwB3Lko2TTZv7kDo4zwhNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_10,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240116
X-Proofpoint-GUID: 4T23pvt70Gd6vye80ncLYifHgZNhlYOl
X-Proofpoint-ORIG-GUID: 4T23pvt70Gd6vye80ncLYifHgZNhlYOl
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/08/2023 04:10, David Sterba wrote:
> On Mon, Aug 14, 2023 at 11:28:12PM +0800, Anand Jain wrote:
>> The misc-test/034-metadata_uuid test case, has four sets of disk images to
>> simulate failed writes during btrfstune -m|M operations. As of now, this
>> tests kernel only. Update the test case to verify btrfstune -m|M's
>> capacity to recover from the same scenarios.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/misc-tests/034-metadata-uuid/test.sh | 70 ++++++++++++++++------
>>   1 file changed, 53 insertions(+), 17 deletions(-)
>>
>> diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
>> index f2daa76304de..6aa1cdcb47ae 100755
>> --- a/tests/misc-tests/034-metadata-uuid/test.sh
>> +++ b/tests/misc-tests/034-metadata-uuid/test.sh
>> @@ -195,13 +195,42 @@ check_multi_fsid_unchanged() {
>>   	check_flag_cleared "$1" "$2"
>>   }
>>   
>> -failure_recovery() {
>> +failure_recovery_progs() {
>> +	local image1
>> +	local image2
>> +	local loop1
>> +	local loop2
>> +	local devcount
>> +
>> +	image1=$(extract_image "$1")
>> +	image2=$(extract_image "$2")
>> +	loop1=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image1")
>> +	loop2=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image2")
>> +
>> +	run_check $SUDO_HELPER udevadm settle
>> +

>> +	# Scan to make sure btrfs detects both devices before trying to mount >> +	#run_check "$TOP/btrfstune" -m --noscan --device="$loop1" "$loop2"
> 
> Why is this line here? It looks like a valid command line and then it's
> confusing. If there's some condition like that you want to require
> scanning then put it to comment and explain it, e.g. "we can't use
> --noscan here because ...".

My bad. Those two comment lines shouldn't be here, and it's okay to
remove them.
It was taken from the patchset that added the --device and --noscan
options. I'll clean it up.

Thanks, Anand

>> +	run_check "$TOP/btrfstune" -m "$loop2"
>> +
>> +	# perform any specific check
>> +	"$3" "$loop1" "$loop2"
>> +
>> +	# cleanup
>> +	run_check $SUDO_HELPER losetup -d "$loop1"
>> +	run_check $SUDO_HELPER losetup -d "$loop2"
>> +	rm -f -- "$image1" "$image2"
>> +}
