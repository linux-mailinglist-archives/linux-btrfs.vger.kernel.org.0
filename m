Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1E6E8B7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Apr 2023 09:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjDTHcf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Apr 2023 03:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDTHce (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Apr 2023 03:32:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FBE2727
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Apr 2023 00:32:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JL4dLC011018;
        Thu, 20 Apr 2023 07:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QiI34LcmUlcebGdBQnpfZd40YBGZM9gc8B//97elBD0=;
 b=OnO7y4PZfvy0PRf1MxzYwlfZ7PKYpc1CWPbXezogtmmic+SE5MjqdeyVHWGH8Yl2eQor
 2m0kMb31U6r10Xc9H2Ox6eu1L/zgxTKc9AUyxR6krGixh0OGKHZ5UFg/4TMHYneMgHyF
 dVzqk35Yoz7xGi5hWIPgjmdAPk8kPUe84oHVdjur0Q48MKqlkWp671GOgpSNdSW2wNnt
 Ex8v4hXrKNXl/MgnrtE7bYQURvNyscqrSgkjRZ5Ox+P2hVWgjr1otZBA5oxYFIu6eg/9
 W2/qPTnzUsT69XwK1evwZzcp2kiqpIZwX2fPHke6TRZ9jiGHIH/7jAoVdNL8Y7MaEJ9o lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyktat255-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 07:32:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33K66fOm015648;
        Thu, 20 Apr 2023 07:32:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcdxqad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 07:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpdSioNwEr6TBjrfCXgIOE9ECqKklQ+DgCp8q3mHyif0+ioZyfJHdLqlIoy7IQG5Vy9roEx/1ZYRwU704cxNM4pQIrUKj2AMYWKxoqeyZ/p3hj/tZzkf0pZWo2HkkJY3ZCSlYyk0h9gtD/iZdDl6N/PBd4XQ1bDwm6gNza42rVfs4lXMr0u7TIdAcVwi+ieSX6Bmj7m9f2MxNEyj6WAgllcFeVfB6gW3MZp7xJgWQp0QSCZLxt0bNec2e1HQVZGqq8mCxw/jhWGJvJrWeja08Ul7tE5PEr3HY/TuezG0ruY7ePTO3lZKgZqUvPH7FjMZbCtxkDrZmwhuDFxJSY0cIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiI34LcmUlcebGdBQnpfZd40YBGZM9gc8B//97elBD0=;
 b=XWvoeWeuVtAZ/+cLQRjYzW00UojC6zyozXtqiPVv68oIf5pJFtx1DciuBFW1icQzzsioPWTMqFjsVfMEtpEDXwq8Y6e6p48I2TfMKWeEaF34UstAaExlpDx4aLQem9jspkqk8v2qvQSQKFyKvopT2jdF1/dadtRK8ehTOK4/MJyg/d0ORXvcPjOLT0ddwisgHca0LpLZRJo9aDWtPOKfAafoVjm/3wIaBS+/KCH5vraV++9v55t8JZx/wLJxo7dTedH2hUbiS991tHXyVSDyxZSFXZD48t8m9JkIuedPoTL1WS1Nq5M61cALFVd3y91MQuq9u74vfy7Tc2cVXElPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiI34LcmUlcebGdBQnpfZd40YBGZM9gc8B//97elBD0=;
 b=mYia/WYdWc+Ppv778DvLLG9T2h83r7ZPa25fSOWNJ7UwYvAeMzh5lqTxSkzC+iszt2/da90Sr6Ev9Hw0NiuhJXzHFxGqC0f8g/HH03/0aHe3HQEueLQ3CdRleJv/k+XGalrbvK4JhBhOrz2mXsIoB+vxdWOo1BQ69i+TMrSvoq0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7150.namprd10.prod.outlook.com (2603:10b6:8:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 07:32:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 07:32:26 +0000
Message-ID: <2ae74cf6-7778-5dad-3b5e-57ad04cc64ee@oracle.com>
Date:   Thu, 20 Apr 2023 15:25:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] btrfs-progs: fix race window during mkfs
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <eda4915edce8006a1578082817733a9af74a9b97.1678860378.git.wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <eda4915edce8006a1578082817733a9af74a9b97.1678860378.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: c287e97a-281e-4bef-b37e-08db417163a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MDur9U4ZeX4igipcrJ7+0Vlfnm0iTIqs7WAmDGb/fvqySAUgtFExR3JlrY8EKB+ZZ5h2/QA/WeZjApYOB4RyDv16KXjZILaAZbP7jcz0pQPibUrYZWmVgGYAQ2LxRRINs9R9RD3QoLgipr38pkucs7EVBUSLKoz/oRjbWE+udaF1xXuTa1QMhitf1dCyO2HclxvB2jDu9e+PgLs9FPjsztpbbq69NCpi7JbmNlztdttSPF+2yx2ldTtgaSKyKtCpQRjFv4OLWPUEBGg5rr031GSYQZjwUfnYLcKLd7SXoX2rFYZb+654TPFOWZ+sTCjkp48seMjQFNDAMZoZHP6jZGT5T8rRiYyFT1LpFaQLKNyN0Jw7Gd9L6FNuCaQ63piYmKM50Hq7T2zhaHa6qm9YjvoNGRHI+Ns6oNJPtovEmGNjayhQJuC+mRSluqGtFVUqpMMYNgiUidpmFX03jZ6pY/UJBO9ojHn+xC70Dqts8n6fAm4aWcgHStTUsHtZjEL6wLHmCXXEGwXy+ThfxiqctotvVIqfK2Yiwyovs1ZWs0E/gz2DUGHsAaleVeP5n7XAYPYLe6JtCbId/JuRm5BkKOX1rN/Jm3RQov2XU5/oZK0fpvcFZ+NsAT3GuZY/E2LXlqEa+MK+kWk0+DDZNkxAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(38100700002)(36756003)(8936002)(8676002)(5660300002)(44832011)(2906002)(86362001)(31696002)(478600001)(6486002)(6666004)(31686004)(186003)(2616005)(6506007)(66946007)(66476007)(6512007)(53546011)(316002)(83380400001)(66556008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVlLQ25FTzRDMkE5eUU5dnVmc3N3bnU1STJqUE1pamNONU5MUjl2V0FrenFE?=
 =?utf-8?B?VjVQWEZiVXFXMjN6L2hvaHJlQVkwb1A3RFdxdjhpbWZkUm01UnFIaW9rWEFm?=
 =?utf-8?B?ejg2Y003ZnRQNUd0eWcrdFpuenZ3VVdjSHN5bmoxdnArczhzWFMycGl5dGFy?=
 =?utf-8?B?TW94Z0dBOTFnUFo0UWFJYkVPaFBxZFVWbXVYSS9PZk9zZEhHVWRlTHlvOWU5?=
 =?utf-8?B?WHpjeXlNTHlSZERQSFVYdDBlb3dxenBwKzVjYW12dy9MdmdCZjhOclpldXdh?=
 =?utf-8?B?bDk5dlFrV21ScWtUSnBOZllvOWdFODl5Y1BhSkxYa2srZkEvRmdZbkJ6T2E3?=
 =?utf-8?B?cjM3RjdEN2xrYUdBV1ZOWm1ZWWZaeGZhLzBXWHVyb205UTdQaHpQRmZ5TGZ6?=
 =?utf-8?B?QkFEMjltZXhFUk9NKzJFYU04Q00rQWZxNGk4YWVTS2Z1S2lCN1B0Y25ZL0hs?=
 =?utf-8?B?T3kxNFBlMjBwTTNMTFNSUkd4MzJqUTJNNjZaQ01jcXhlcnVBcG1ucFo3dUhM?=
 =?utf-8?B?UTBSQ1ZXZGZmVXB1Tm1zeUVjcklEVmpzNzUzOUFKWkVzMkRvd21xVWx4b0Ev?=
 =?utf-8?B?WFJQZ0QyR3ExdHg0NWNTQ0duZTFYUlFkOUxCQjI0aStRZVdNRHJDbjF1Zzg5?=
 =?utf-8?B?cS9BQTVCUTloWTBhQlFEbHNBTzRDWjVSc2xva1hKRTl3QzhRK2pQT2xoZU1D?=
 =?utf-8?B?d244Z1VrSHkveGZtaW1KTjRkRGRNd1lYaGtaV252TEhYTktlLzNad0VTTGE2?=
 =?utf-8?B?TWtZb0pBQzF1OFN1cnJldjY4QUJTeExibDFjWlRVTjBWVUd4TnFpSkNWRC81?=
 =?utf-8?B?K3lZRC9sbSs1bGh4SXB6ZFNJN2JPdXMrWTNoenZ6RGJMNS9CQ2NjODdnRFJq?=
 =?utf-8?B?SS9FaFN3WTEwcUZ3TWNISDB0NkVWMXlYbCsrV3paeHlqb1NJMU5rZDJCMldi?=
 =?utf-8?B?cW5rOWIvS2wxWCtEVEtuWVpvc1hlREoxTFlTYW1xNHBZS2YycGNSeGlBOXVO?=
 =?utf-8?B?dURaZlZlL296NmhnaTkvMUoyRCs4TVhrZjhJYStTaWFibmtjdnF2V29oZVN4?=
 =?utf-8?B?R0huQ0dMU3RuTi81QktoYlIxM1ZUazYybm4yQ1g2NGM0eHJDV290Syt4TGFF?=
 =?utf-8?B?bTVUWkdoQVFqaE5IS2t3RDg3aU5FczFyVzJNYVJaemIvbG9CbXY5VGVVWXNy?=
 =?utf-8?B?UXhyT1oxeHI0NW5TejJkOHgxVHFYZDlIKzdreXhFTVlscmY1eFpkcG4wZkZo?=
 =?utf-8?B?dmlJL0JMSnZabmpsaFR0bEd2VHhHbGdwQWNWS09uL1NxOFNxOU1qbVhkdU5k?=
 =?utf-8?B?bU1kaXc3dFlkb1BRM1p6S0ZiVTQvMnh1U04xYlp5M2h0cnBNWkhvaHFEdENh?=
 =?utf-8?B?TUdjbzJ3dGZoS3BLeVR6Z2h4dXJvcWdsVloyRTNFY2NXYXk1aC83OEg5MURj?=
 =?utf-8?B?VXYwYjJCbE9mb1Nnclh0UGhzeGV4bEJKSVdRMlc1WUhJQmZERGYxdUdGN0VI?=
 =?utf-8?B?VjFUZjNRSjhaMkpyOHZIR2JhZ3YvVkZhdU5HYkhhbW8wR1gwdUVUbkoyN3pt?=
 =?utf-8?B?KzQ4SUJKTEhPUjNINmNlbWtneDR6SExRWkRYRzdRSWJGRkgvQ3pTVk0xREFN?=
 =?utf-8?B?OUE4N0k5YTlsMXUvbkh6V1MwZkhpMVhlcHFTZUdOVXU1YXI0NmJKRmx1WThC?=
 =?utf-8?B?eWIrT0JnNzNkbzBHVHh4K05qdTZqWjJRb1ZSanUvQjAvR0JCVUFzWDJ6U2NJ?=
 =?utf-8?B?Q1QvS0VST1VndGZITDFWRGhIWlQ0a1NMaXFhQUlDNjAzbnN6VGZ0SndXN01x?=
 =?utf-8?B?VEdTREtlM0t5ay9jYnZ5VUJXV0Q4T2R2d0tFOEpEQTdCOWE0REJYMUtkZmVh?=
 =?utf-8?B?d0srWitLS1JuM1hoSXgyUVFRVnY5SnRqcTM0QXNOME8rNFU3ZWd6R2cyUXda?=
 =?utf-8?B?d2llRDM4LzFrYXJBMFlzRGIwR0FZZzRBcUJ0RXJMYWlhTUQzd1krN25TRFhx?=
 =?utf-8?B?N2R0T2VnY3lsSHdwUFVYYU9rTFROYlM4WmJNMDdWOE80Zzh5U2FwcU1CNnNy?=
 =?utf-8?B?aUw2RlZuTFNSUSt6MEUvNEQ0NnhETzdUQjNhVEtQcGR1V3dKK2JIaktUc25n?=
 =?utf-8?B?U2lqWWlDU2ZnUkZsRjhVcUFTSGwyM0JjT0xkaVM4Q282TlYwQkwvd3RlK0th?=
 =?utf-8?Q?D7JDjjXgRpXD32kzbDemBmDup8cstu/l9KCFP3vz3EeS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TFywzvL2QaDwmzl5s8x198HK69ytT9EibiiiOoI3SmM/DFq6xR0iKqx2DINOMEk8qBATajQR0rZ0XUDcINe5GyUgQLacqqMpFYKKdy22kp5WPGtDfFPdYV+F1S2shUkenFklGA1RxMsO6eZWJb6pw0al6lIp/XZyIz7dKJFuIEQJX9E53Uis99XbwaEeWZfUJilyHIB9QGDtUgBZXf9nUCzkEcbYlSYOryybW5m4j/pilwD9CpxLsVwvILGBqtBh+P9aIDNXSWLlqfcGczJSo7L3FDrR1dXnTIkf2A0I2HRORPjkkdreO9X6WBdBebrKNPWd20e9vtuy6PuL1YAFbLtGI6Fz2dsbbUuWvhIAixP0YtSgkOQhU1ibIHbZ6bAuxHY6Z2E5US/wnaQSltxh+yzCiI37Au+VZEGp3jHHVxCERAe4TcG0bTg43QHzsFuScW1PnxopRVdvnBq2OTD7F5dgSRj/QTfFf+5PhapkicPw5h3jcZ7ULzsK4IyRwcXrJP5Rx1xjpQbXskM7DVVQzOTCMDxl3OrsO7rhDaTblTgBPRIPEd7w5KpR/VAtMBdCWqoy3TXe5sR/2nEO8cXpANAVP8dqTjj59Q2fvBV9UIgSiR9QPcpZ1P0CQhiyERTbCf1QKpkvNkvtqzbCqYU/BtXq5+kegwVMXU38vzEZWFZeG/QYR1IYSWQTztEEFic04pWzIoA5IL28CTvx5Hc5RY0Z/al2HhBQN+SnTlgAMfp0t+okvJx1jJu84TKXbi6iFe93J+oQS1AuGy397yiy9WtYv4fS6dOkm+FYxmPZkxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c287e97a-281e-4bef-b37e-08db417163a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 07:32:26.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xod13ZRgE6BjQux/qGLyl6CTPVV4SNy4WkADhSq3QsXX7vzo3kQmgpBZ0th0QNp3Iz7HwNItHeRF/iOm/oggmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_04,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200060
X-Proofpoint-ORIG-GUID: oXHT8f8LlismmeFoEtH5XYL9678_exXX
X-Proofpoint-GUID: oXHT8f8LlismmeFoEtH5XYL9678_exXX
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/3/23 14:06, Qu Wenruo wrote:
> [BUG]
> There is an internal bug report that, after mkfs.btrfs there is a chance
> that no /dev/disk/by-uuid/<uuid> soft link is not created at all.
> 
> [CAUSE]
> That uuid soft link is created by udev, which listens inotify
> IN_CLOSE_WRITE events from all block devices.
> 
> After such IN_CLOSE_WRITE event is triggered, udev would *disable*
> inotify for that block device, and do a blkid scan on it.
> After the blkid scan is done, re-enable the inotify listening.
> 
> This means normally mkfs tools should open the fd, do all the writes,
> and close the fd after everything is done.
> 
> But unfortunately for mkfs.btrfs, it's not the case, we have a lot of
> phases seperated by different close() calls:
> 
>    open_ctree() would open fds of each involved device
>    and close them at close_ctree()
>    Only after close_ctree() we have a valid superblock -\
>                                                         |
> |<------- A -------->|<--------- B --------->|<------- C ------->|
>            |                      |
>            |                      `- open a new fd for make_btrfs()
>            |                         and close it before open_ctree()
>            |                         The device contains invalid sb.
>            |
>            `- open a new fd for each device, then call
>               btrfs_prepare_device(), then close the fd.
>               The device would contain no valid superblock.
> 
> If at the close() of phase A udev event is triggered, while doing udev
> scan we go into phase C (but before the new valid super blocks written),
> udev would only see no superblock or invalid superblock.
> 
> Then phase C finished, udev resume its inotify listening, but at this
> timing mkfs is finished, while udev only see the premature data from
> phase A, and missed the IN_CLOSE_WRITE events from phase C.
> 
> [FIX]
> Instead of open and close a new fd for each device, re-use the fd opened
> during prepare_one_device(), and close all the fds until close_ctree()
> is called.
> 
> By this, although we may still have race between close_ctree() and
> explicit close() calls, at least udev can always see the properly
> written super blocks.
> 
> To compensate the change, some extra cleanups are made:
> 
> - Do not touch @device_count
>    Which makes later prepare_ctx iteration much easier.
> 
> - Remove top-level @fd variable
>    Instead go with prepare_ctx[i].fd.
> 
> - Do not open with O_RDWR in test_dev_for_mkfs()
>    as test_dev_for_mkfs() would close the fd, if we go O_RDWR, it can
>    cause the udev race.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Sorry, I missed this earlier. Thanks for the nice fix and cleanup!

Reviewed-by: Anand Jain <anand.jain@oracle.com>

