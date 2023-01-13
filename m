Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAC96694FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 12:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbjAMLGi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 06:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjAMLFp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 06:05:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADDC7827E
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 02:56:27 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D9kgUl028473;
        Fri, 13 Jan 2023 10:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uWukjo1R9JNLlD+lmVlnNPagusKTauHgTQV/FqiGfmQ=;
 b=tsFpsJNQQgJ9y0iPEI/GcZmBRAwhP12toain+031SKEzcHKLA6ZSm6EZt+QmXJCwzBen
 aMVKC27lDbD3fzYpiBPnNrpLlLgl815cjUYgH9gPA+S7WrmdV7UMkGLswHc/SqS9Q6TG
 q5JPkqlIwYrNJBOAcVEwYeBCiMNS5EmVzTf+wOhHYMhyvPqNnNg/zk3Uh8QWviS6PAfL
 SDZN1yjWEIxOVVEF/EWRrVi/+cglC6q2GIRqFqiA+c1Qj4+kG5sNmvLag90PJpcr1aB4
 CBxNXiOqueOEeiSthIbC6AD816zUSLQyFVRhs8oesYPDYxw2uJEGfPfwA7uJ76edLj6f 0Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0scmgf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 10:55:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DAW1Xr000836;
        Fri, 13 Jan 2023 10:55:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4dg2a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 10:55:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf1d9wp2/GUrLTZoR3ORlQWo3klJhiFX9B8GZit+H8SPlv1wZ/atiUrlRkQhj9yzYfr7Ezain+ainBYrGFLt/enaKzttA6tMY8aEVPw+R5to/iagn22rvfVoveSFfOkatpkMZM1x3Um1VaqQ8O3EhEI2l2rq+jOwzokUMSmLaKBtoWTROZZ0meowCxL2wW/1mplrNloSzMGldxaAOpDaXsoHwrD2gkxQHOt1jXsxoiSg6TrUVG9OCoYA41VeLrmFy6a1e0zbhot+V5DEcEer81gVtYuwP8giyi7Eu25I7Fhtm9E15UHd6OJR5FehCJsYQsARhgbWLdRN6kNc7TWVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWukjo1R9JNLlD+lmVlnNPagusKTauHgTQV/FqiGfmQ=;
 b=UbLnezprgPwqfZApxhe8MgpHPVkQWSxnt7UllhpaYVuH3Dh7z+e6TG5NV2t6TuG7HMEYtLz+MtFndSTWkBwB0w7W8JmRCcXoBkrDgn7hHcs0QgAjgyP0PvWQcpIm+y7ULG3BFWE1XVCQzjP6HK66ZKgWKx9ubeTTgyTaWyKR7mGod6aYbgxeklW9gXFiSZy592aS8f5SN5cB3ZvgruQ1NVN4EJk8tDdGq0+Tp2Jzx+bnsl7wFHsY5Kb93PyeIVFrJa0NU8E/h14AkWCcRUHCT7tQtIlTUgICXTaO25PHPpL0uUtwXORwNZHPw+6B84kaJPsIcO6ibnVhfvkEQ+rM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWukjo1R9JNLlD+lmVlnNPagusKTauHgTQV/FqiGfmQ=;
 b=PhOCqTwl+mIS7QmnkBkxjNMTVAKNERQ7ArTaJMPN/OycDo0wj88Zh/RckyvpLBhLHR9aIvwMUzVhSZKXcS82/6X4mTz74MiJyqZQwqn/qIFHTVNWEiyisfMj2WlhGPI3ylROz4AYV9bgRgSs5jaNwYi1zpnAZ9nwaChP8A8QQpA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5904.namprd10.prod.outlook.com (2603:10b6:8:84::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Fri, 13 Jan 2023 10:55:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%7]) with mapi id 15.20.6002.009; Fri, 13 Jan 2023
 10:55:50 +0000
Message-ID: <14e7c804-bd76-fbab-ba1c-2366e0f4cb81@oracle.com>
Date:   Fri, 13 Jan 2023 18:55:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v3] btrfs: update fs features sysfs directory
 asynchronously
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <86ceb095fdfec9fe86dfb8efdd354a298fb685ff.1673583926.git.wqu@suse.com>
 <60287dfa-10bc-0e29-c152-5facaf548065@oracle.com>
 <92b702ba-8323-7acd-6e41-a307387325d9@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <92b702ba-8323-7acd-6e41-a307387325d9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: c7440f67-adb7-47ea-b913-08daf554bb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ui48/qJMcpaBdXV6qf19ilf6hoGYsN/dAfAI6PMrwwcouMiKdnm2LI2nSY+lk3w0Qd6i5YU+vLUobT6q188fF3XZ+FjMKGGOqLkSv7sWTa/7/LHMxdObrYgZCiKsmQBDM23+yHySUKME6Eiaij2VSdfsTMRx/YkWYUKhqqmaexIC3np3nLqzc/mMDSMwxbUhCC1cIm4b4OOOJ33/P/4JKYLKpTImp/auJPm9vQ8ZTxXF/dDJReDgeYJdq52uUPfKYYBAGKId/nCCyyPHqsBhVP3tz1XciQlMvUwAdxziC9kU03MnN5yHc/gPGocazXXOQvq4jZoS7QdalsugpStwpiPnaSj87VY7+z7o5Y1BKC92Fo4qyWkjHKxJtgGlczCPRYR+k+TXn87NrvF5jEu7Z+efFpKHpwWaH5K3aTHbcudoDKiXShRLATqWcVeEvL6/YF/cVMFl7K958GSjS0RqrdSkybek+vWfpi9IraraLm4h+KtK4aFgl4DUtAfyPWrZukWGQuSQD/3FIP6BdkjYAz5u87d3m/+oGzUvpo6ssvIB8g4Uj3FpeGjX83rjN/UyMmJ7x5ECvt6J89vltniR7OpZlExn1M02qQBOfGrj0zbbiUehKqrV+R6Ik24uYBcyeUfW0Ae4ZGhdrAs0VCy1Af2/OhTRZ5YZrH0u7nQwIJAMeTAqOLTj6z/vuHYF2PFQgj1eiyIHY7ob8o9amAJdTC/gC1sqElQXUfWBDT+Qhsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(83380400001)(31696002)(38100700002)(86362001)(2906002)(44832011)(15650500001)(41300700001)(5660300002)(8936002)(6666004)(53546011)(6506007)(478600001)(2616005)(6512007)(186003)(26005)(6486002)(316002)(8676002)(66476007)(66946007)(66556008)(110136005)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkFjUUozcFhXdGpTeDFhbW1EMWJHeWpsMGpLTmZ6UDZmOEVTSzQ5bmNQZWNk?=
 =?utf-8?B?bTBxRGxQNVh3VG9WaVBtV0hKMjBjQ0xuMW1vQ0l6T2Q3QllYRG1mVVdJUGYv?=
 =?utf-8?B?OCtiM0c4MVVjQ29CZm01L0laUDB3blRtcElBUjZNaFZJY21wWUhFTHFZQy93?=
 =?utf-8?B?azMzWVMxZTNkdUZ5MWR4allvVVFtRE9mbW1VODFuUHByMnVaM3JsVFdZcmMw?=
 =?utf-8?B?eGVLcGZ1MVlCZGgwOXJsK2JxM1IvelhKUmV5VkJWbnJORlFDY2R2VkRkRmwy?=
 =?utf-8?B?TWUyU2xYYWtRbGpIOGdvYmU1U09Wcjd5bVd6SzNRNldWamUxR3RFejNreEFP?=
 =?utf-8?B?dEhYTnc3cXVFMGo1b2Q1a1ZUK1FXQXlVTlZTeFppNDh6bGZwTjQranlhSG96?=
 =?utf-8?B?OHAyR252TE4vY0RUWXlQYTV4SERPME9BdG9ubzNjZXNTYVJ3Sk9mS3Q2cVRH?=
 =?utf-8?B?dHB4NEVybWIyYzBZZHE1SzN4VWJPVDZlQ2M0VUM4cTFxRjl2OTJUVVQzTnIw?=
 =?utf-8?B?NW5icGV4N0pCWHdxb1JNKzRETk10WjlRR3FWMHBvb2dBbVFkYytpNHRwc1Fu?=
 =?utf-8?B?VVgrVnZNY2Y0em04NkRrdDFSZVNyWkowYTRzc3EwVmRpa3U1b2p6bGpMWnZx?=
 =?utf-8?B?ZnQzWHpTdzQvaElLMmFBZHpJMXkyaTdTRm0xclc5NXZwZWovYWFRa0JBR3M2?=
 =?utf-8?B?TXNLMjRLamNyNkFtVWpCa2JCaUFjbjd5T3k5c0dsUkVwc1hySWliNHlWejkz?=
 =?utf-8?B?WlBja0oxRUxnSDlHRyt3MHlEUEVWKzNEbWFDandrVUdFNE1MSUVHbG5BZnZT?=
 =?utf-8?B?Uzd5TmVuRTNMbzEwQUR2VnlNMEhmN2tVNkZnT2ZsMXI3cUlKTWI4NnVTQ1RT?=
 =?utf-8?B?QjVMVytUbGlxQkNPWHRRa3FXNFFBTzNmMU9ETnpydm5malJPTElQUDJYNjhB?=
 =?utf-8?B?SFJNcjBiTWxDZHdRa1lLUEVudnJMeHA2RkIxZnpPNTJhbkNZcTVjRW9DR0xP?=
 =?utf-8?B?U0lSV0JlY05Ib2MrN0tZZlZqN1cyYUd1NWRFY2JhdmhtNXFnQ2lMRFczcjNk?=
 =?utf-8?B?Q3FvS2szQm13aW04aHFuNXJaMjBFaVhWWTd6OGRLRCtqdUJwczNBaTQ2eGgy?=
 =?utf-8?B?QmpEalpLVnAyVm9hN0pBL3FTU283TklKNEk0VTd0QXVuT2FGNGV2cThyeHpL?=
 =?utf-8?B?WWVvRXBFaE5kRFVUTlVOcGhTVFpkVERaZ1BrdTlMM05CemxmdjJLSCs0VXdR?=
 =?utf-8?B?bml6YmY5WjRwVVdtZnRFR2NkRHJNZUlNNHV0emlVQno1bVNDMDA1SW53eFpZ?=
 =?utf-8?B?LzFoWkphSlVmQzJuQ0tTQTZVUFFqTjUybndKQmg2cjNwWS9NQTFBMW5pWCt2?=
 =?utf-8?B?d2JkcHphRU14TC95ZlFTbFFRRFN1TGxhUS93UW1mam92V0JXajVpdmdBbElv?=
 =?utf-8?B?QW9MdDhma2JDNkdvWUpWcXFiNVBCaE9XdHNsV0pZL2w3WU16T08vbSs0dkVY?=
 =?utf-8?B?K0dHcWJ1NGFYbFdKT0VqbGlydUdZRVdrNUJJVzFuNnlKTEc5THBQWFdKTlF4?=
 =?utf-8?B?Ynd4djNKa1k5alUva0lzR2E0aExPaVpkcTFIZGtyWUgrbWVzbUI1aUo2Q3A0?=
 =?utf-8?B?aWJveFNYNEFEb1dWS0hCTHU3QUR3NlIxNjh3N0JnZGdOZXBxOGZHdUpEV3Nm?=
 =?utf-8?B?enlyWkJweXV3VXI4WWNuU0ZxcS9xVXZRa1BUbjlPT0xZcXc1TElUbTFrWTUy?=
 =?utf-8?B?ZlVPRlJ3SEhFSGR2UTRPS0VmbFN4M3dWbi9uL3FrdWhiUlk4bFNEUG5KRy95?=
 =?utf-8?B?UU1jYU1QbHJOVkRkaFF4WkF0OHM0TW1qdENyL1VtaGtEZzVvQzNrUmJOaWMr?=
 =?utf-8?B?V1ZHY2IrQnFGOTZmcjFpK2YzZHlkbmVVZnVSdXlWaFJ1R2tyUk0xanE5dG1Q?=
 =?utf-8?B?NzN0UWVPanB0VisyaEphbWxCM0RJc3RwckQrVU8ya0ZaQWJuZjNkc2ZjSjJi?=
 =?utf-8?B?Y2QrQ2RoZGRhZVpQUTdDMkl2OGNqQkVUMzFNR1MvOGM3ZzhaZXJ6K00zQU1s?=
 =?utf-8?B?NXRoUW9DSEM1d0FDaGlpNm1JWXozMFhuY2hOcUhjOGJTT3A1bHBwb0dkRmV3?=
 =?utf-8?Q?Pb8cZP8WjDNn4Gg85v3KBX4CT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TDqjNb004m31d5ZyNqQ6Ww9d4BDxFgk+GQHK8XVk+Sd7WmXmxepot/RUFaUTEq8OAuTCXF8rO/UB3FFvVjpZoH/pWjZTOjfaU6FFhKtM9++86L+CZ7zFMAJ2T+T5GerY1wuAc5PWO2it4VKa4tNdzc9+Dohu1YRCvIQu2N0hDLGbCTCyh6sIG6wC2j5gXO2Nn+OTrMWP9fLw8L0KBXhJDcUaHbXklI35s3gPyiASX0aHyfY8RBQOSmYoGdk7kk+1MOeBO1XJWLb+Lf0k6RoDBdcynmi9GdHCeTeA0AMEhG79W49jdveMW7lRIKrf7KZwyR3+vFyaDLR9OjEH3f9BUE6bU+yz3yXNh8B8+rrbccpMpgKs33+Oyyg+Y15DZUAe/IWEnKdsFtiY0CmbtKaq+pSc+Jg4IwzQnrFReOtgQsUKT9/47vB7rbPZqqz+o0i1+lLRFZGFjzbFIn5ZrUF6wzLfR3Voe8wXf3ey9VACC6q8qCI+MVmSxWs7bQ6KaijxE7M7ocCbtha6ihPYJgTquAiitwwIOd7WZw4GtZjIMq3bgHMrsZuQ3hucRtH8/0L52oM8IB22+yjVtIFVNNmnmnXS/+LPc97tioqplnvqfEO0+tiCRd1tO1eHzB3UHPEXetQIp3VtBPKBhCJgVP2LNaa3XEJPNhqslZOG34tKVvCfw1ic8DiBqku53W38Q58AIBYTjrfvoCvjP7kpoBYxGH0Ihzw+/ok7DVlbA9bPCyJ4loK2n7TMiSu0qxHS3EBWSvFdc1tIzHuBkHDyqwU5KQ/qZHkip24LTsroTVX2/DnbLdiHvYG8axn58QXUxIQM
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7440f67-adb7-47ea-b913-08daf554bb6f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 10:55:49.9877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+U/IzNHLCkvO//jVeVhnkh5pRB8gG5vudSBbbL7t2ANs62pvM5LoUu0Tei+tp+P1603Kq+QheEGY/Dv1BD3bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_04,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130075
X-Proofpoint-GUID: Ot4d5Vw7sY71KbAixsz1xIBtCW8wr-eo
X-Proofpoint-ORIG-GUID: Ot4d5Vw7sY71KbAixsz1xIBtCW8wr-eo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/13/23 18:06, Qu Wenruo wrote:
> 
> 
> On 2023/1/13 17:24, Anand Jain wrote:
> [...]
>>>           spin_lock(&fs_info->super_lock);
>>>           features = btrfs_super_incompat_flags(disk_super);
>>>           if (!(features & flag)) {
>>> @@ -25,17 +27,20 @@ void __btrfs_set_fs_incompat(struct btrfs_fs_info 
>>> *fs_info, u64 flag,
>>>           }
>>>           spin_unlock(&fs_info->super_lock);
>>>       }
>>> +    return changed;
>>>   }
>>
>>
>>   Why not something like below
>>
>>   if there is something changed
>>   ::
>>      set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags)
>>
>>   and return void.
> 
> That indeed sounds better.
>>
>>
>>
> [...]
>>> +    if (test_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags) &&
>>> +        fs_info->cleaner_kthread)
>>> +        wake_up_process(fs_info->cleaner_kthread);
>>> +
>>
>> Why not just wake cleaner_kthred at the end of super writes if 
>> successful? Would it be too delayed?
> 
> Because at UNBLOCKED state, it's no difference, no matter if it's at 
> super writeback or just like this timing.
> 
> In fact, doing it earlier is better, as it makes us to have higher 
> chance to get the update reflected before btrfs_commit_transaction() to 
> return.
> 

  Hmm. Ok.
>> And
>>
>> How does it behave in simultaneous or consecutive feature change 
>> requests? Would it be consistent?
> 
> The change only happens at cleaner thread (which is either woken at the 
> interval, or woken up by the commit transaction).
> 
> And the update itself is checking all features, thus even if there is 
> concurrency, either we updated multiple changes at once, or the change 
> missed the current transaction and went to the next one.

  OK. Thanks for checking.

-Anand


> 
>>
>>
>>
>>>       ret = btrfs_write_and_wait_transaction(trans);
>>>       if (ret) {
>>>           btrfs_handle_fs_error(fs_info, ret,
>>>
>>
>> -Anand
>>
>>

