Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B9C7B647A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 10:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbjJCIj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjJCIjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 04:39:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0405D124
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 01:39:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930jHKb028510;
        Tue, 3 Oct 2023 08:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5eBezy2KY5SHmjbMOKZnKlproFC9ZbS0J7FMZeaCPU4=;
 b=d3eNFLr0KZQjzCFKfqSF53qVNecZfBMAYINA1VlADfOjwroluUW9SFI55zTr+JD52ahF
 OTH6ShBV8dkE+miK0g8jU3x3UCmC86eAVTDJXfMz9l37anTzsPlHKVwiSL86XvZf6WGl
 DdaTWIvJJStHb0XYF3SWKbCyDIGKjDc5z9inKrf1x5cQvYBwf5i5y/to3Ylv36u/xVbx
 dhMrrocSQ5nOSbYRQ3G91pzPEKwW5qH/Yx/JK8GXZ1N+EY9zEWPybWA8fMqv+HTRhfym
 +6Yq8fLUSav74GtO9jBiL080tGmRUDLseQpWtBlMd3Js7P5YH9ic3jOk5TzRgT+YFgBi ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbv4mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 08:39:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39385qo0008665;
        Tue, 3 Oct 2023 08:39:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea466597-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 08:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFHWGI9mf1L/6xDvvRnNmVqHPYd1N1NJyhTQqm/B+7sdzMaLdkqFlWqnhwN7e5bOWZ3FPfbq1RLVBHDDWEGlyItaEDu7zV12+65G5XL5aXW8sI8yd5ZVTYsEj6T2jqjR8vk6JLffREhB+queEr0j3fRzcZZ0oLn2KTcoBEG3DppuWZZpxdWp9JFft+UbK5Cf1gMRqKpu9miyagiHRutvCm5sHYQFLuLNTulKqMX+1i9tWQx9+kpqDnvUwDPcqPIgT4RBUxW6fbcrzakRGfVnIwsioYhOfH6PviU75grB1g+1izBYHHBQOe4ul7ImcK8sIwdnNKf6CajA+fVGJBVwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eBezy2KY5SHmjbMOKZnKlproFC9ZbS0J7FMZeaCPU4=;
 b=f/qbYBGWd5/pLhArvxXdr9BN3qJQNcohhWjMlzBRJg5/GNeFOAaVlMF07XbP1TTu7XCx7+aMzr6fblArHsNer7xfqJ0gH90NuW5OZDbutDgUhg4xT/tHAqpcCQGWSg5h5TccjqsL6nntKB35KZ4RTTtCr2sMI0uHDqQK9n1p2D7VOQyc80x2UvjjwT5eCavXQwji5j3S6kgjb1twu24huCBOolt4pKRGWdYjiKwoLi0fkd6Jltv67fXXGFtCn/hxpkrbDF687OiSBYMX0juoSjHNMsQxOti/OZQk+asccNsCAhWQb7h1+qA1qpT4YZHcKfiafMiTCmlDC3mo8sc2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eBezy2KY5SHmjbMOKZnKlproFC9ZbS0J7FMZeaCPU4=;
 b=e0HUiqINNPb1unNNWgI3XgwZoAtEXVprCj9iaCZ31rBwIcSv+3mG2y5wFy6uVKHKMVXxN4OUlbQmEhUpRSdJFcMsnwWE53pFCtcJBA8ndbOLWO8dhNyqHNS/uvTq3c7gtDCbHtWKhhdUvOeqq5pSwgItLCGVIVhDH2QpBzty5F4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4229.namprd10.prod.outlook.com (2603:10b6:610:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 08:38:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 08:38:58 +0000
Message-ID: <086c2106-2743-f1f7-dfc4-85a9403be47a@oracle.com>
Date:   Tue, 3 Oct 2023 16:38:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/4] btrfs-progs: test btrfstune -m|M ability to fix
 previous failures
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1694749532.git.anand.jain@oracle.com>
 <db8c6de3dfda46d9e3c0dbebc7f10a898f8be112.1694749532.git.anand.jain@oracle.com>
 <20231002171945.GY13697@twin.jikos.cz>
 <a488ca32-0546-a7a0-62c5-9e1f3b301aa4@oracle.com>
In-Reply-To: <a488ca32-0546-a7a0-62c5-9e1f3b301aa4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ce2fbc-568c-4616-0097-08dbc3ec2fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/+Ro4Vv43r6WEhNvlttM+ZQNgFwO8JPteGci3Os+Z0iCgG9/WDJqpPKFlUAyy7AF7zQMzej0+Kaye5dmINR4UYf3hVxKv7jTP5Vv8Y6y9p2KkP+Dp2pivKSfMA0rMLPWcfW5VhfkhQ/K4Jw0qrs75r60+68ZK2kEAUeNzMzDN57Li3bmFhyseFhkaMxTXZuJTXvHQUf8usG9vi5mI0lIlHI87GzZ0uWbzJnfyWysqrjmDWOzNcqHkEeXJgmsdWLGgPi1dbetb1qLfCyn1eHkJcBhqTpB204gGoO+YTgX6h16b7UQFiQhmZHf3p/5PlvA05zeliiRSuqvAULKE119n9t3QAx90a/3ATJYol/nJThjM4Hv7DNRZL6zwmCkGsGPdUyGDXM7w5rZAVq5fMiFBoQTB42rS3IR/mTwHM3Akasrp/uLSdHHEfUznE9Wide4nECLvD8MRaucfIaHydadrOXiprtg9UEvlmf+5ye3bOXdELj+iwXrNzxt0ZDueqzVW1SmMkx70LB01YZT460gwGSTUS4/ht8Yp+eFw1QoGllmXjC16VbKizgjkvrBGGEEvLkMDUbjtURUAGd1r79dBbL0pzWMuNy+/54HUkfPaSFdw5v8xeIjO4woBeXRK9AbltWPe92U7fI8AI7RZwbQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2616005)(5660300002)(26005)(6666004)(8676002)(4326008)(8936002)(31686004)(478600001)(86362001)(31696002)(6486002)(38100700002)(66556008)(66946007)(66476007)(316002)(6916009)(53546011)(6512007)(6506007)(2906002)(36756003)(83380400001)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFVQ1huM0IwWFMwbkJIVHZ6NmhTUFUrOTZkT2tETjgrM2JKdzR2VVo1bDR3?=
 =?utf-8?B?a3lZOXQ2ZkozSkUxczFneGgzTkQwcmR3cGdpZk1NYTZEU2djaFUrWjh0V2Fu?=
 =?utf-8?B?QkFYMkY5RkhTKzRqVUFFQUgwYjhibFA0QnVoTjFtUlVnKy9KSjRKVzk0S0pz?=
 =?utf-8?B?UUJIYkRZcnFTdENRNFlPMStsNTlZdTBtRkZHZGdoWjlGZTFpb1IvRXhHY3NF?=
 =?utf-8?B?UG53aUtIdVRJblRvMUpNV3N3RnUvQlJ1WFo3eFdsNXowRWNOUjNVZnNDN0Ja?=
 =?utf-8?B?VTVwSktFd2dXaUV0TVY1UitQRHh5QXlKKzlwTWE5Vmo2Z0toRjFETUFkRFo4?=
 =?utf-8?B?dE53QXNRU3F6OVFWL1R0NXFhQk5lWHc1SDFNTGxPR292c0RtWDRjL3ZHK0du?=
 =?utf-8?B?dmxKbndzQWFsbVFFb2dwTFdZYVhCcy9hRFUrTENSUmcwWHl3NGkrTXVtbkZh?=
 =?utf-8?B?ZERiNlBZWmdNWmk5THNBeDBQeTRzWFJ5em1OZnhpcDhBeTQrRE5KRnl5OUdz?=
 =?utf-8?B?WVVtSVZrRkI2emhIdmNFa1d2dFlUV0NGd0FoU0NPeDFRaVdneXlwQldxTkh5?=
 =?utf-8?B?V0c0Q2V0V3o3dDg0VnFwSDRSRzZSK0JKRG9STklBYTZiS0NNNVlrMUxBMHdo?=
 =?utf-8?B?cTlOZmY2aDVlREZqY0hKOXgvSzFWcUhuajl2LzZEUGQ5TUVBRGpRTVRTNE5o?=
 =?utf-8?B?MjFGT1dDbm9DWlB2Y1NLU1lBYUtUM0Fwa1Bsam5Xa3JuZUZUeFgyUDUyejlD?=
 =?utf-8?B?NE9TZXpyV2JvOTNYamZQMlU2U2IvTHVNY1hrWkFUVW1pMDdyL0IvR3Z6RDg1?=
 =?utf-8?B?bGFibjJlbTBWa0Q0RUYwVUttbFdqTWp2SU43Zi9wRUViZXpRK3JHOHhUOXdX?=
 =?utf-8?B?UXJTcDlEMHU5QUJ0WFkzeEtKZEE0UmZzayt5TEdlb21NRlc3dS9uazdpM1NR?=
 =?utf-8?B?RWwwcTFRNU0zTUwvSVR3OFdjcVdZa0piWGhidEJrYlBXTGpONjMyaktWS2xz?=
 =?utf-8?B?VFFQWlk1M1hsWGQyUUdzdlFDWlJZVUI2d052T05UbnRHaTh2NDVvaXhXbVk5?=
 =?utf-8?B?ZFp4bWZpS0JRMzhJMUhTU3ZldHdsVHVyM1BIWVlMY3dkNGNEOEk1MVk1TjZW?=
 =?utf-8?B?MUtVNW83WXRBY1E2MTM5UUpqa2RSZUc2NzAxdnJYYkIzYlJ3bnhKNDMrWU84?=
 =?utf-8?B?OTZVdmwxSDM1Z2t1VU1qUnRGaGtQWkMwNGh0QitKUVFxU2hiNTNFdmd5cFVD?=
 =?utf-8?B?d2lHRENsTUkxS1VTV1R0Y2NSejFScDNJMnp3WTVVbzNJUmg4OWtPaVJwcEhs?=
 =?utf-8?B?UkdWNDN6T3ZsdCswWDBhZWRBTmxwbmsvOVRSWDdlbmNUNis3bDZBeDdyTEl6?=
 =?utf-8?B?aCtwREhFQ21BNzAyc3M3ZzExUi9yRlE5bWxGdkRveERUZEVYalN3UklFZzRG?=
 =?utf-8?B?cWJ6eGh1NXd0SFVFdHdjV01MOTBMUWlrUU9IQ3FsM2c2YmZxVHQzNklXTFNO?=
 =?utf-8?B?MVFKUGMxODEzRERvRmNiR2x1azVicXY3Sm54WmYwOU9WM1pFZmRMTG1hdERx?=
 =?utf-8?B?NGt0Mzd5NG1rUXgzRVhjRVBRYUIxeXRyejlnTXpLV2lsdkdsRmszcHh2TEhC?=
 =?utf-8?B?ZDVOQUdoUDdxMXprZ0g3emp1clY0bUg2ZHgybFFTZjZSQXJ6RzJxTXJ2V1VK?=
 =?utf-8?B?ekxVMkpIdzN6SEJKV2xCekdTYUtiZ2ZNOGl2dUZTZWJSV0F2Rno0MW5GVW41?=
 =?utf-8?B?TU80bzNqYk5ZcXU5T2lKeWNvVlRYVlVZcFRrZURWY2ZDV1VQU0l2ZGVlQkhE?=
 =?utf-8?B?VmFzK0RqNDhuN3MwbENLVWtZQzNwMnM1eFhJUkQ3UDhldWdTMkRVZnJNa1B5?=
 =?utf-8?B?dVFKNEZsRUNRY0JrdzVTeWl5RVFpbVhYMDVwREN1OGZqYzlPVVpwV0NTcm1Y?=
 =?utf-8?B?TElIb2wwT3dmS2hOSkhCME96RDNwVG9xZTNHcC9qNzdoV3h5ZUJ5cHZQbFFk?=
 =?utf-8?B?ZlRpeHV1dEtNMlBuKzhaNlRLeFhuZmZYTkU3TnZGRFdabXFYQ3RZT0dNYmxk?=
 =?utf-8?B?SUFjNVBLMndyWmk2SUVNRVIzRlFPbXRPQnhOZGp0aXBqUHhKMjdIdFV1ZXBW?=
 =?utf-8?Q?+iUMzOxggWQINhhFf05VzErve?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BA61elQDARc3yjujTxjJ8okT9n5ERd2JashUUSx6MLMYoUKGXMAu6mUo1Ps69Hog/z+HW46VvZglXiBNMbEzmZA7cdcwwkerUq1krxQyl2l08jPE/ddMPBDCkcM8WKqtjpCrIBOTHwdDvp7OqC6UYrWXXD3mpxPYCQCO9ltNZGYL/2kgpyTgofupo6ICnikCVqzKIxqwUwxTaSBfhsavRw6aGgntu9EwuuHuLDC0Hp1cq2vcxiasMZcEO8azmIkg0Y1KW9CuF0xgCrr5qY2mC/K23tEWGYJJ6IgMYw8sf8JSBWIdQ+6daznz0t3uHcCEV4LcDAG+t2xn3uWoc0/J1VJ8XzCgxqTq/Ws3TO2NhvgaMS87iRUYstjOooW3jHWiucahlwAsMU9XB18Gm9IBo5XeRSmE2vwsg3jaYY+TPDavJyHcondD8jEjQvT1pph3Xz70CxT9dKfEhIv7ZHXsVHj5MwEqCWUoFAcpS7pgdP+Onn9qkvIE18aj+eyzzGBNx3mHHuXQRWPFJVtFz2D6QxicV3olcIzz9eV7JNON1Uv1+NcDnCYwRZYeed3ku4jUGFjF2YuXzR3CKZnVCYgKrRgATgvm2IvxS4JvJphMWiSYyUz7EG/S4MUK9Rrv/zJ57argT+YO4755YlBdwT6JMIk5hKie2sDVoaJpLcHT8qCq7IIB+QLetExAUjN2iMStFRphzLNBpUx+Y7/n6heLa0rnv+GLGRTXIbhblPcwUGB+XZl0aWypbJXnn4uWlm5gBa/IJiyYnaT6pLnfStLvJFhqhyr4LunIkYwfgJ52hYYYZ+LEvYugsuFE6MQjtddw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ce2fbc-568c-4616-0097-08dbc3ec2fc8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 08:38:58.6954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5gbTLvvfcwNhIKdnEexFxhwINz0sRM00LagA4m8K7aQip1+8fIXQ8ExKKP0Y3l+UzPf+Z+EJIPj4a9ovxm61A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030056
X-Proofpoint-GUID: x3B1-t88Mal8uxAimkDq0n8pxBU0vge2
X-Proofpoint-ORIG-GUID: x3B1-t88Mal8uxAimkDq0n8pxBU0vge2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/10/23 16:00, Anand Jain wrote:
> 
> 
> On 3/10/23 01:19, David Sterba wrote:
>> On Fri, Sep 15, 2023 at 12:08:59PM +0800, Anand Jain wrote:
>>> The misc-test/034-metadata_uuid test case, has four sets of disk 
>>> images to
>>> simulate failed writes during btrfstune -m|M operations. As of now, this
>>> tests kernel only. Update the test case to verify btrfstune -m|M's
>>> capacity to recover from the same scenarios.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> With all the problems fixed, the test still fails.  I'm not sure which 
>> case it
>> is:
>>
>> ====== RUN CHECK root_helper losetup --find --show ./disk1.raw.restored
>> /dev/loop0
>> ====== RUN CHECK root_helper losetup --find --show ./disk2.raw.restored
>> /dev/loop1
>> ====== RUN CHECK root_helper udevadm settle
>> ====== RUN CHECK root_helper /labs/dsterba/gits/btrfs-progs/btrfstune 
>> -m /dev/loop1
>> parent transid verify failed on 30425088 wanted 6 found 4
>> parent transid verify failed on 30441472 wanted 6 found 4
>> Error writing to device 1
>> ERROR: failed to write tree block 30457856: Operation not permitted
>> ERROR: btrfstune failed
>> failed: root_helper /labs/dsterba/gits/btrfs-progs/btrfstune -m 
>> /dev/loop1
>> test failed for case 034-metadata-uuid
>>
>> Looks like a write that's beyond the device limit. I'll keep the patches
>> and tests in devel so you can have a look.
> 
> 
> As a root user, your devel branch passes here.
> 
> (Generally, I have been using the following command as root:)
> 
>   $ make TEST=034* test-misc
>   [LD] fssum
>   [LD] fsstress
>   [TEST] misc-tests.sh
>   [TEST/misc] 034-metadata-uuid
>   Scanning /btrfs-progs/tests/misc-tests-results.txt
> 
> Let me try as a non-root user.
> 
> Also, could you please make sure that all the 
> 'tests/misc-tests/034-metadata-uuid/*.restored' files are removed before 
> starting the test case?

This pass as non-root.

$ sudo make TEST=034* test-misc
     [LD]     fssum
     [LD]     fsstress
     [TEST]   misc-tests.sh
     [TEST/misc]   034-metadata-uuid
Scanning /btrfs-progs/tests/misc-tests-results.txt

So I think there might be some stale *restored images; Could you pls check.

Thanks, Anand


