Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07C7A1893
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjIOIXw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 04:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjIOIXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 04:23:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E053AB7
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 01:22:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EKxStP032048;
        Fri, 15 Sep 2023 08:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aWe9eohgHRxT6CKZhioQKRELN1n3mEVDBAAvi6tlGzU=;
 b=yN/HMyDEeo9LRGMt26bh2QtW4Jx9zOqB1fZ7YBBMPBujuoNVcbZXoz6DTOdHUoejTNde
 cIYHkdWQSgoesVOTJJBu3/E0OADKQTyoo+/lmbtLhXYVJ0AhQlcY4hKYlg2o668SAleM
 FhsLRRNlKR7tsznUadl4LBVoZz+vt361d7OUQPFsIgat9fv/nOv4zxLoy06ugt4Kqlhu
 Zp05fgtP6cdsSzl35D417fb1h8bhwPhoh2VP0IaXDlbhiPLGdyQ1g/fNqioaQ5/1A/lo
 3EUjxUng0HCzeOZDz6qQ1Q2ySIfpDsniw7N5ZYr944DgMToDs3F/RkkDQCwIPByanh9c eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7hf8kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 08:22:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38F6iEAj007335;
        Fri, 15 Sep 2023 08:22:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5ahnw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 08:22:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh7JVxS8lSa6NkQqgg4SpgdMa2/LToe8km1JmrnOSftsBirsqAx/ib9OHzq8dbIWQbuv2AKctLz+O07+WuVJLkTtXPveO+RPV2k0GOB5KjJtjYbBbUW2Z3UYdkxth2DnfdjLGdFsmxZS89q6NqpllMyUQewGYbHo+j67yhzV9dmXL1g8TURQsamowlL9tcHRj+WcAcP2nzRT7nvjKp81LttchDyrNlBKrWLjoc3wLFFLVkmnuDFkkLMqcG3MyrNwcEekYJyijRjWlF58Y7h6EmQmXEm9UU4onS4Tjui6BEbf1vmYFzQwfl4fYOkD5+325tchSlCcg70YJyovR/LUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWe9eohgHRxT6CKZhioQKRELN1n3mEVDBAAvi6tlGzU=;
 b=Ia/+uQK8YtCfV3VFBHI62xvubGU6kfQIBeTtqn9zdBnjv/MIytobBS5TgeELLMs9g5dqnZ4APseopJrQ2jvt8FHRY3WKtjrPHgxMX+tp3VpwfNbzMBlIotYGwjd6CAeOlDHOGvhY1bwtN1RiLfaoT65p4nXmrbzu1BCnD7Gu0XGujCeZn5wsuuIKuYWBLS/oau7egBR4axKqd5Hzhsv7P/y+uDaQ7HVGu0+7+J0IJWJ8kG1URKbgjdfb3xs/NK01TzlNjFpK4HrsXblZOOP64J1KXdfE7xjC5uVi/sOFB7MimNbG9q6Uk2ckLTKx0kGZG/vubFdYY0797sDzFA81Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWe9eohgHRxT6CKZhioQKRELN1n3mEVDBAAvi6tlGzU=;
 b=J+QSQrATW8WHCRZOBaoA5iW2s9HKNLLd9u3i2iTr8OUUgVYo3z/a4ifILwB1fQzYEh/dygYkGcXU9kiIGKWw7/ScfpFwWgpkbAC1Cs97DTJbFnj8e5RVxBsSvNQFETe12baxphslGpmCr4e3873MKWv9ydU0mRb8JqAvamebFug=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4193.namprd10.prod.outlook.com (2603:10b6:a03:202::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 08:22:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 08:22:24 +0000
Message-ID: <89644c59-181b-a9d3-1140-8e74328b36bc@oracle.com>
Date:   Fri, 15 Sep 2023 16:22:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bug report] btrfs: scan but don't register device on single
 device filesystem
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-btrfs@vger.kernel.org
References: <32e15558-0a3f-418a-b3ae-8cfbddbff7af@moroto.mountain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <32e15558-0a3f-418a-b3ae-8cfbddbff7af@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: d06001ac-ca1b-4207-5102-08dbb5c4e3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQi8ntkuU6f/uuXDxQSe8okYf95DX/AQStOD5GOCVkutdEvuA7tYtlN0qtzHYaROekfK0GkkS8GQ93Zm9J4wJf0ZM4OwKk7Rmy5vFwAidnalr9oVWwlr88CpJAv8JKk5aLAuFv3ZyQJMh70YIOMNovdFut0C4lDswk1srR0/u0us6W6R7Z4xvCvtFcwG+eEcjOixqCqrjKi9LRdUAlSQWHmQ8zme7/b1zoNnwrF88flgVTXtE3sPlyCu6rjdsa4drzot7NSEI++ouX9BjFT6CS3raCZmky/7KqltNcpohw0YK01kakbXiKjS8aeFCZLeuoEIc2hqeVWXqPPQwbYfYf4sBqQknsKQ6vFB++O3Qq1ItgjmATGWUXBONq/xW03aDOlWK8PaMT1+1yhzUMSMrkCGdrfSnnzHpfBYgZdEd59JAUWPShraEuV2KV8y886mpQlvwdLoMh+seB2zNfjA1/wwWpVcPdCBEGC3ObMN8mVbtAKgWptAX8IYyMMVJjhllqKCnrNCpNm39QnKZ2UO1Zzd1yqcLBW1yuOacD+33qbOemvgTelvaBrU3tL8tpIvL11HiFn9WPP2EZ4URq7fDpHU0zKRXYyNhvUg3/Yww/gBDhO1EguVueClJQTWL5V7L/ARzT/rlx9UziGUsuHsgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(186009)(1800799009)(451199024)(6666004)(66476007)(66556008)(66946007)(44832011)(6506007)(6486002)(6512007)(6916009)(316002)(478600001)(31686004)(41300700001)(4326008)(8936002)(8676002)(5660300002)(26005)(36756003)(38100700002)(2906002)(2616005)(31696002)(86362001)(4744005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUFjL0VPVUZUREJPMkx3K1JPWitqQ1RFMnZZZ09SeHc4L3NRaDNkd0FDNDE5?=
 =?utf-8?B?a1I4aEVOaXc5ajhPb3dTaXBJTkRJSGE1eUNpa2ZHcVE2VVJWdDZLc0xHM1hs?=
 =?utf-8?B?YzFZb0RLU1dKVGkrcU84ZnE1UFZnVkgyOFQxZ2NTckc0dnpWaGdubUt1TXJx?=
 =?utf-8?B?S0M0eERJYXNpWjFWYlFqYnJ3MFdraE9ORGQramxTY1dzWVVpZ1g4ZTZGU1oz?=
 =?utf-8?B?ZG5QRkZxb0N6eVhMYXlHcncrL1lvWEFEMGtXT3JHcmpSMndINE5PcEd2NG9u?=
 =?utf-8?B?MHppY2M3MjR5VkxFaUxyNmoycHVPSmM4NVpDQzZoYk5TN2RhM0UxTldEYnlk?=
 =?utf-8?B?Y0RxdkJKNUdWMXJJMFhmWnRiSEpKNDJOZVVYdVZMMjl3ekdDOFhMcVZ6Q2ZC?=
 =?utf-8?B?K0hjcGtwR2NMVGtLa1dLVkhEQVJiVHFzYWZXUkFoSVBsa2xzeFVCcjB1NkJC?=
 =?utf-8?B?T0tJMGRJelpIUjU5M2xhQzg5QUg4TjNhRzZNMGkvUGxJTGRNZnlWMC9oYUoz?=
 =?utf-8?B?WlRicXc2a2I4eVNtSVh2aXVGN2RKL3JFMVpUQjhtYituTXVCUmFTRmV6WGRi?=
 =?utf-8?B?djdSaTFmZ0VrSEd1dldMRnRjMXZOV1NRZHhKNDNaeUo1L3FUVSt1SDdFNlZS?=
 =?utf-8?B?WHJCeS9tanNzY1hjT2c1M3dpSW5sYWJDaTFmbk1PcmZXcWRJaVl3TmJmRVky?=
 =?utf-8?B?M0FYVlFvcitpaEpGdDdDYTQrWG1jemE5M2xVK0t2d0JsRWRKQjFoSFg0d0U0?=
 =?utf-8?B?Y0twcE1WbVViV2Y1Nmc1NXZaTGNkenNvM0QydDJ0L2xIVk9IL0VINzVtWFVu?=
 =?utf-8?B?R0hqMHBTSEpKMmE5RHZEMDFJUU92b2NmMVZBaVlDano1Um40aVpmUjZnU1FP?=
 =?utf-8?B?VEg1NzJJV3FER3BwK0tlQ1YrdTdzc3Zmem1VZzJ1R1BJMkJoT21WZndWR2M3?=
 =?utf-8?B?YVRub2dYTHhFS0MvVmZUQ1R0eFI4TytBUUYxOE1hS0ZGSStuQ3llQUozVkZI?=
 =?utf-8?B?UHl6RlFUSlljS3owSDI3YjFpeDJGeUFWMW5jUmJ6K1dRZzlTNnFHdWg5eGo0?=
 =?utf-8?B?NURXbjBpSk00YUM5NVJ0S3BRTVFDVS9KZ1NFRUdrcy93UVRvM1FXSGtvUUZW?=
 =?utf-8?B?RHhXZE0zSDRUa1ZiVW5ySGNjNEZHUjh6TUZrVm1XbUZaRGZmeXRBYlJxcW9S?=
 =?utf-8?B?NmVheklqYW1qZWdrSjBzQnlTa3piczNKTUFTN2tVc3d5QytMM3RESWdQV3p3?=
 =?utf-8?B?Qnl3RmtZY0Z2MHV2TVluYSs4aVErcE5BVGVHWFVIZGFTaC9EYUVvNDltVkR5?=
 =?utf-8?B?SzZMMGx3a0xBMjR0WmdiRkZnTm82d0pqN3JxbDJDUktIT1RQMEdUaC9WK3oz?=
 =?utf-8?B?ellTYUlmdWRZOTBLS3VDdlVhd29zZzR4T3pWWkpHdkVWL1ZJTHY5UndrS0cz?=
 =?utf-8?B?Ny9NUTB2ejE4R215Vk51Ym53Sk1WdW84elJDbDJNSUYvSVd5eFd3S1YrdGgz?=
 =?utf-8?B?V1BYRGFQeFo5YUlJUHVzbDNiWWtEQ2pVRDIwTVlMUXBVYkhnRk5TdEl0Umsz?=
 =?utf-8?B?MDB1M3FpRTllWDYva1pUV2lla3RUYnZoblRXNnhzUDV6K2c2UHpMUFhZQnpj?=
 =?utf-8?B?RUFnTDFNN3l2ajhwamM1TG5SWnA1bHZhOUllOFBnTmtiMFpuVnpJVE5pYWEz?=
 =?utf-8?B?ejBvV2J2U2IzTTZzc284bWNZTVRNR0RVWUY5ZnV3MUNZNG04QkhtTUNpa21U?=
 =?utf-8?B?VXhoRXUwY2dZNkZQRVhwbnFGc0pqTExoeXpuVUg4UlVET0FrN0ZTZS9BQk5z?=
 =?utf-8?B?cWNiVXVIY2tLem51VzlwRm1IVDRyMWRQa2xHaFBzUytSOVB3RGpSNGtTbVRz?=
 =?utf-8?B?d2tRUFhUTmZ2V2VPWXUrOGhFT2dTblN2dmdNWWU3R3RIRzhXYy9NQTQzbURh?=
 =?utf-8?B?WGtsSWlwcW4relJ6MjlIdXBMOVF6REUrdlc0aVpkeWhFVGhjQXd5NmkweWk1?=
 =?utf-8?B?WHdBcEpxcExIcytHSFlMOUFDVEdoUWlldkZ4c3RQMnlGcDBYL1pmcnVBalQ5?=
 =?utf-8?B?d1dRbktJamI3dDUwZ2VrVUFDejRla2JNRHdWTEJLRXh0eXJZam1kR3Y3V1ds?=
 =?utf-8?B?N0kyeTdRVWE0NXFYY3NDUjU5ckNYN05QdFQwc0Y3bnVmTXk2a2c2Y3pxb2s1?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZDqBCYFD6z4c/InFAUVeCDETAwYi88CyztTx4P4IVMAG6hOoy/M31gbHK9UFHGv80JUlqULJp4JhAEUwobnnIiNWRs6OjEMAoID+UMb6af303MKlssymobo6u4UJiYsNVghVe8mGQfGeP/rwVRVJD9LPXb+du2haew71FVuuvIp2vjyMY4cTC9tfp8jHTDUq04BzJY56TvAaKYmAikmjZaCnRzViI64U//KbOU+ukZkUNIn+kvoLQ1tqokVELtw71Lw5Dk6goqsmBT+j6XTi8xqW1zBi9ElwsRmiUIbi1W66PcRtJHOpPdbNNjCYelhPyZk+UDg/2F91THo19E4JO5EhkEVoDiKuj4Yp9yX8+sWEllFdlv5dbgnumtyDvlVE2AfQOcesTLXaLb/javrZLdeo6fwWuktCdqh/fjqyVqMCMB9qPrWUOEFutFzbeecy1fqervFDW/G2kLeGRIU39g1WQVB+wKjZM7l8xj/Do6Ws47oOC/tlMiZ5QLqSEhdUwOv8iRrzow0n+BWgiHQO/anXmovuvaZaRD7LKZh+BREw74egULIqGHdwFbsJHPaOj3l/SUZ8XYIC4TyTVvuK5NX+fu/DhZX6csxNf1eFzN5TXw0HSUFtzGWJB/IQxfTo/31/EKPp6i/iSOPMFoFomsKu4FRSbCk1ypOF6RBtwAgXJyLJhC4mKpWNJrl3qQ8OlQimrjKbvoMP7YaL982UjpnC6xoFofKOjzEunZysEkjGDd+RZ7RZ0tkIRyJ6dUyzmQubrF/UFlKklakNSJC3cxb38PcRJFdI9FqAkO5MzoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06001ac-ca1b-4207-5102-08dbb5c4e3bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:22:24.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cZng7awbRJmWSzUI5GIrRewBjMDcYaQk2qC5PMenvFM8gZ3NCKxsZvq53Xd1YVsPD0kfljJCXdjLldVeWrD9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=919 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150072
X-Proofpoint-ORIG-GUID: V5XanUmPEUBZ5z6nXV9a9FIThMLPH7ON
X-Proofpoint-GUID: V5XanUmPEUBZ5z6nXV9a9FIThMLPH7ON
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Thanks for the report.

> 
> fs/btrfs/volumes.c
>      1411         if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>      1412             !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
>      1413                 dev_t        devt;
>      1414
>      1415                 ret = lookup_bdev(path, &devt);
>      1416                 if (ret) {
>      1417                         btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>      1418                         path, ret);
> 
> Should this goto?
> 
>      1419                 }
> --> 1420                 btrfs_free_stale_devices(devt, NULL);
>                                                    ^^^^
> Uninitialized if lookup_bdev() fails.

  We have to call btrfs_free_stale_devices() under the 'else' part;
  its the only one using devt.

  I have sent out the fix.

[PATCH] btrfs: fix smatch static checker warning in btrfs_scan_one_device


-Anand
