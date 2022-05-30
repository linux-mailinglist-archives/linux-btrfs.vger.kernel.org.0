Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6D1537328
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 02:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiE3AvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 20:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiE3Au7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 20:50:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543726AE8;
        Sun, 29 May 2022 17:50:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24TLql37019990;
        Mon, 30 May 2022 00:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mDMQWbFOl5p+VZ4arfGa+vyyRxzgOi03uO7J7u9QgKk=;
 b=VXa2bDrgu1NA4hE92/xN0WOu/KdvXVL0IX5M1t71f7AJHQks95dbK7aUBLhI4tBsmgeZ
 /+XDRxw5k+ditRfwaLuGLSJckqBdxeR0Y9YWbGQ34Xx56bK9b1tW4Hb7k6aW5EtC9g7G
 s7Plj3StTv96OWkr0DJJadAlZ6V9YwguiEn3Wc54FwJ3H91QXIJDo1QGgrygbkgTDpOh
 t4jasZEM6AZFZd8jyX0r/Byi98LuCd4feU2smBTX+zkH/SshL3ASCaLkqLV4YJkuV6Vl
 j6tB7wbP0BWMU2/4QS0ADUNLLG7H9LirNU9V5gZ/znZ5MWvBgXzq0EVRBrmfNgPdJJSi vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xhsdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:50:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U0fSRY018707;
        Mon, 30 May 2022 00:50:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p08un5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHMiKslj8nleOQtqPbpJof/Hb5gynKrwV46o9wTS/nSuOXgoKFodODEsxJpwneMiJ9rGshoXH21yt6CPmdCWUuIVwDW4Z7Vm9EQH4smycZ6Mblhx7ctRFZEt0Pv1WXvS1hJdCXUVtQyyNDpDv1wUvPM9KErkRszrOkODy3ACk9ncJb93Sut1RQNozdudp2UAn9AbqP+Yn0ekgowEfRM7WJBt30qx8muU6CDbI2DBgGrEI9fCUEGiLwMJ/J82DL9k+RDS2F38jpx1W0UUDPUYHgnVVF1b9MasHCuBipA1CdxT/0HJjz8XuZskLls1qIkVX1IFCaGdiy0L4n/7lBev1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDMQWbFOl5p+VZ4arfGa+vyyRxzgOi03uO7J7u9QgKk=;
 b=TJFETj1P708UdiZPD9V+Ow3ez14Y8PbJKVJqNt+AY0ldkEP0h2EcGTX3I6w+XP1Ivd+HeL4cPBjRv1HCTn2LJunTMF4m7pAPfaY89rCMlp2haq6+Ad9Nww5Um1/6c/2WiRcIMcI7avo2tXzFYwHUfEoK8Xv+D2agmSbvS4zz8pSaklDQ/CHWjw5CELlzIx938XHbsbhK9U/291ugosUYqT4gGq8Rd5I8v9XGbjxknnNQBVm3YBQYeb6QA9TRforSSrajtgcB0t6nuG6Z01LDhqREaQlG4dwhZf0MXPrUI+AkzUUY314nvvMOoc7glxVp1aelZHYX1GTtsWQUNEZRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDMQWbFOl5p+VZ4arfGa+vyyRxzgOi03uO7J7u9QgKk=;
 b=Km+nBBpvrASqjsXOoXaZcigvLLW30C3nifxtq6pjERKDT/dVS56qXFhx8rfybVeMV+cHCsU8kS2B1HV4iQZDQrjPG1i8GMkvFKgGDvVpr22njMxmWd96u9sBpqA7LdRvPAm+VgNIV1syXgrETE7HhSehZAZ7VIxyOq2JFG4d3Ys=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4681.namprd10.prod.outlook.com (2603:10b6:806:fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 00:50:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f%3]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 00:50:49 +0000
Message-ID: <77090cfd-e80d-67a8-e215-aa610f00f7de@oracle.com>
Date:   Mon, 30 May 2022 06:20:39 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 08/10] btrfs: test repair with sectors corrupted in
 multiple mirrors
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-9-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220527081915.2024853-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8459bf0c-8beb-4190-3fbb-08da41d67061
X-MS-TrafficTypeDiagnostic: SA2PR10MB4681:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB46819C6980C6514074DC2E02E5DD9@SA2PR10MB4681.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cy+muoFtulnjep64KQzSa/pGKqxhFp+nEHt5ht6jHMSgOXYCrATgDvyEFsMP8Yx/vge+20wmRIjAsle7RJasED1iiCu6mv2LdKsK1ApQUirwsYU18ggkSE8gMC7RwAEyjCjANVD/fe4FDQTFgp4bZKuwpduNfXTboCy3dK8JpUckMOa6lB/4Nhr8F+W9Rk3yNjtf7QsinfHD1usPS7RmP+/csrWsBX5yc+7QeVxzBxWvP+YV/RLFjaFzW9k4fre7iROkA73UhQZ8070TYIGIlO4jOBTjskbWsTTYuspk5gpOn3qStG83HPa+s1MCJtQA/6F10N/J8zviVyvswzF0XtLeg5mkdDUYJty0YEKLfKbjlpiwjukJlfu++TZEHkQ3xIpZcrm1PqCwAszpdqWIPrRFyAxWMEP1H124Ok/ZwjeW7aQx2IOAQeIrdh7VpNwHoikH7y3ApGd6rABZ0B0gbSBHsbQDM4PXv3erFuXwhyS/lFsdt3CpwJPatszeYhtcMr8UTN4XOIyLoWbBpeMXkxazTgWsnSoEy21sRledP5o6bEAahLR+IS6dode+Sks+zJs0A+oe5WbzKNt5AymhYX7qQ6H6QtUso/zPKuBJHxRwPUc9iAqEwyEZnfVwlqqn37K60cvuCseaxSxvusfRNKPSPR9ew2P646O3aOt3Vxngn6vfZmbwD8s5ytXEnvgcKu3Jtmp32RwAWYC/x691+7BQBwHqU8fHau1oh/IDCV9fg0hp2sFSCzv8RCLJol0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(66476007)(66556008)(4326008)(8676002)(6486002)(186003)(83380400001)(508600001)(31696002)(86362001)(8936002)(6512007)(38100700002)(2616005)(53546011)(6506007)(44832011)(6666004)(2906002)(36756003)(31686004)(316002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0I1blpDVU9JaTA1cHBrSUNFcGJ4RjQwSERiT3lac1p0dEpjVDA5aHR0clpD?=
 =?utf-8?B?VnBwWmZmYjEzR2RhcWYzenZLMEIyZ0JmNUI4KzR5NlRZalRmR21LY0FxMXZt?=
 =?utf-8?B?bVhvU1g2cmgzNGRqeUNwckpoSzRwekpNR3FZQkxtaExnSXVZTFc1TUhuaTZM?=
 =?utf-8?B?UkJDeGtJcWNTVW5UaTlDRk9lTE9MN002Tys4dzRrTGJJTTBZRTQzd0dXZUV6?=
 =?utf-8?B?aWdHZENIN25rQXhuc1IxckJKdGJaMU1VcUJjWEt1ejhHdUFlazdXNnJGVHVT?=
 =?utf-8?B?ZWl0b0lIOUF6SHU0TnV2N2dVanVRRkYvbGx6bXBzWXl0bm9TcnRmZkdFTUxy?=
 =?utf-8?B?dnA4OGNqa0E3d01tdUQyR0g5STZjQWxMcnFSWXRkTTBkVHFMVHlSdlVOR1h0?=
 =?utf-8?B?T0plMVlhRTFLNnI0T3JBUFZjQ0IwVkdBelRzTkVKc3k4QWMydFRRUVhnNDJI?=
 =?utf-8?B?Qnl1M2ZwN0RTTldWbHNSeXgvNUxwUDhJV2ZTUk1XVGovcEV1TW9TVmdUVUJT?=
 =?utf-8?B?eGhjQTZiQjMxc2lnb1hHbWVEMjdjNk13Um5oQ3VaUEVLaTdBY0kzVVJsOE00?=
 =?utf-8?B?bjJIVnB0eGRxbFpXY0h1QkhtVGxxNUViMW04UlEyWkpVQXhwTHhaTzlCdGF6?=
 =?utf-8?B?QjdHWUtwK0lkYjVFcllHUUM4bTF0aHpQNll4TVFRcTBjWFQ2cFlvQkozbjZM?=
 =?utf-8?B?UGZkQjluV0dCWEMwUXNEck1IeXZkSEpzdEptejVOLzBWbHVveEY2bGJHU21m?=
 =?utf-8?B?Y3ZXTk1tc1ZycWlVdTF2djNReWM5L1VldVNneUFyK1Zuc1JjRHJOd0I3Mmdh?=
 =?utf-8?B?U3VzRm1GUTZWWVk0dzhkWkUzQ3ovMUpSY3ZKR2VwL3hnOTIrcWRnVWxuWUh5?=
 =?utf-8?B?MmFuUUhGUHhleGtpd01jMnBUQ0FPKy9kdmhOZGxDZlB6NGhpRmtaTCtxTjJH?=
 =?utf-8?B?dFd5TGFBY1JyTWtZMmVtR1RuVTlOY3Y0empuTVR5SVZIcVA3NlJmVERHWDVy?=
 =?utf-8?B?TDdjajNJQ3pKQStmWks5MHJNQjBiMHpOa3NaR2dhdm5BNzlMRlluSVpReTE2?=
 =?utf-8?B?WWpjV1dFVzUxQWh1eWRCZ1poRE83T3hNcndLRTlMTWVXMFF5V05tN201N0U1?=
 =?utf-8?B?UmFOTnB4cmtRbzhZUnhUTHoxWUdDYXVTdVh6YnA0djdveTFrZHp2bU9PVzM3?=
 =?utf-8?B?d2Z1NjlqdlZQMit5dFhlYTBOMDBVV3pwUVIvcDY5MzlNck9MOWJaWm1SOHNG?=
 =?utf-8?B?R2piSHRYOVdZbTNZUWdlWEFxLzg0MXdqc1NnSkZ5a3k3S3BKSUsxMENrNUVD?=
 =?utf-8?B?N2oxcFdWdEZSc1JrOWFLbGd6bmdleWJodU90TkxHRGpQa3RUbkY5cW5kVmlV?=
 =?utf-8?B?SDlMVThiTmJXMEg0bXRwZWo4TStab1p2U1NKWGF0b1IzOUZLOFJtVjFxeElW?=
 =?utf-8?B?K0VZYUwzOG15WVQ4Y3B4YVpjN1hRbmpGeGdFc1NxemtwRURBakdOQjczZG1Q?=
 =?utf-8?B?T3dqbnZzNVpZOFBrR24raDBhTjE3a3JIWkJmbW55ZkJUZUhpdDltOEFIR20z?=
 =?utf-8?B?Ung3WGRpNFBraEczMlhUSG9UTjk2QXBLMDFFV0E3ZDk1cEVObFVwb1ViN20z?=
 =?utf-8?B?V3NSUVZUdTMzbEdRZU96WFI2VEh6KzNhWEthUkx6MHRKZis5Z240Ti81UkxQ?=
 =?utf-8?B?VHRkYUprbzFRYXk0QUM1TUlOeDNlSk5YVFZhL256b0RwY3I0VkxPekUvUjRu?=
 =?utf-8?B?MTJVZXBhMElzVUlRdHhWM2RmZDdvZUMwbWxBekY3QlpmOG5CUEN5bHQwWGF2?=
 =?utf-8?B?YnNKK3RNNXBZQk52MWZKcENhK3ZJajFJQjdGWE5vM2VqLzEvNFpwa3g0SnUx?=
 =?utf-8?B?NFVJaFJXdWZxSkFEY01RUGp2M0Evd3BGZ2Y0SkVZa0F4dlNGcGE3UzAwZFRy?=
 =?utf-8?B?R092NERiL1BoeDVESituMStwOGdlR1J1cXFLOUJEcVZhREpFamc2djhpNkFO?=
 =?utf-8?B?NUUzSVhPSkJTOEJpMUNSM2RkT0JkTUg2Qi9VNFBLVmlqaDRBS2ZJZ1ZudzJW?=
 =?utf-8?B?N2lFa3Z3cmN2c3ppM2F6SkFKRnNzOXdqS2daSkg2djA3MnVpQXI4ckd5Y29R?=
 =?utf-8?B?WGFJd29YQ1lzeExnSnNqU1NiTUhKd2Q4QStZeis4VFVpaFlMSzVDVjRuN2l1?=
 =?utf-8?B?M09ZcjZJb1E5b0tTeEltN2tnWmNXQTJURVJ4RVRRTzA4Sm5TR2NPZ2d1S3RB?=
 =?utf-8?B?NlNXR1l6REluc2tWNm9Ya2RkYUtpZ01xakhxSmZWYmVRTGNvTkxXMjljMkh2?=
 =?utf-8?B?MDRKQzFJb0J5NGdZaG5FV0lEZWkyR1BZdGRUalFnZ0w4QnVGbDJNU0tsKzVK?=
 =?utf-8?Q?qZ4Pg4wYo8/JNpCP9K6hS58L/ekiRu5+1hK+T4tpZLFaU?=
X-MS-Exchange-AntiSpam-MessageData-1: kWUs5hFEt6NqB6AtnCpTQc5N+XIDAPCGW30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8459bf0c-8beb-4190-3fbb-08da41d67061
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 00:50:49.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l360DfwPwKwpu+2EGtC7ylUbufgPNROtwd7LMJ1PedZMldc7ZDzp9Am5dVueN/o+neK16XxP3oyDvAQz+Kx9YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4681
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_07:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300003
X-Proofpoint-GUID: 5KUFVy219Sh2gmBTh_YKGYNNAZ-k7tBu
X-Proofpoint-ORIG-GUID: 5KUFVy219Sh2gmBTh_YKGYNNAZ-k7tBu
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


On 5/27/22 13:49, Christoph Hellwig wrote:
> Test that repair handles the case where it needs to read from more than
> a single mirror on the raid1c3 profile.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/265     | 85 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/265.out | 75 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 160 insertions(+)
>   create mode 100755 tests/btrfs/265
>   create mode 100644 tests/btrfs/265.out
> 
> diff --git a/tests/btrfs/265 b/tests/btrfs/265
> new file mode 100755
> index 00000000..b75d9c84
> --- /dev/null
> +++ b/tests/btrfs/265
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> +# Copyright (c) 2022 Christoph Hellwig.
> +#
> +# FS QA Test 265
> +#
> +# Test that btrfs raid repair on a raid1c3 profile can repair corruption on two
> +# mirrors for the same logical offset.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick read_repair
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +_scratch_dev_pool_get 3
> +# step 1, create a raid1 btrfs which contains one 128k file.
> +echo "step 1......mkfs.btrfs"
> +
> +mkfs_opts="-d raid1c3 -b 1G"
> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> +
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" \
> +	"$SCRATCH_MNT/foobar" | \
> +	_filter_xfs_io_offset
> +
> +# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
> +# one in $SCRATCH_DEV_POOL
> +echo "step 2......corrupt file extent"
> +
> +# ensure btrfs-map-logical sees the tree updates
> +sync
> +
> +logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +
> +physical1=$(_btrfs_get_physical ${logical} 1)
> +devpath1=$(_btrfs_get_device_path ${logical} 1)
> +
> +physical2=$(_btrfs_get_physical ${logical} 2)
> +devpath2=$(_btrfs_get_device_path ${logical} 2)
> +
> +_scratch_unmount
> +
> +echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
> +	>> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbf -b 64K $physical1 64K" $devpath1 \
> +	> /dev/null
> +
> +echo " corrupt stripe #2, devpath $devpath2 physical $physical2" \
> +	>> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbf -b 64K $physical2 64K" $devpath2 \
> +	> /dev/null
> +
> +_scratch_mount
> +
> +# step 3, 128k dio read (this read can repair bad copy)
> +echo "step 3......repair the bad copy"
> +
> +_btrfs_direct_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 128K
> +_btrfs_direct_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 128K
> +
> +_scratch_unmount
> +

> +echo "step 4......check if the repair worked"
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
> +	_filter_xfs_io_offset


> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/265.out b/tests/btrfs/265.out
> new file mode 100644
> index 00000000..c62c7a39
> --- /dev/null
> +++ b/tests/btrfs/265.out
> @@ -0,0 +1,75 @@
> +QA output created by 265
> +step 1......mkfs.btrfs
> +wrote 131072/131072 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt file extent
> +step 3......repair the bad copy
> +step 4......check if the repair worked
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

