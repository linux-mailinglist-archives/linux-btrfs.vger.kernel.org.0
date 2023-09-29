Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7EF7B2F6A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 11:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjI2JmW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjI2JmV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 05:42:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CC71A8;
        Fri, 29 Sep 2023 02:42:19 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9bYx023115;
        Fri, 29 Sep 2023 09:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0QMQ8DkehYDncF80NOP8xABX/B7oaUT4l8yv7qXhivE=;
 b=GjrkeJyxvov2/BA53G8UapD6WFsyIQORAdlA8vMOu1GlZNU3CiIpjT0PbmdQGEXutXzl
 RiFXOec9LXnJ+Ol3fkxCvHRt6lhA4qs8eSUSKa7jwEPsq/fT/f1y7KIVQtIyU1J7+lE4
 X6aQTZB9zttYVlzMdipY7i899QXVWawixewlKXqFIei3Vbx6FLJfGtI1Y2R4mE85JsEB
 Pv5C2nFxatL4K9n/pyY7dcB2CvBV9Jw0dVXEV2IGoUkcAOUNZQNyq+wiq14z4DWuNyas
 lTAIxsOXlYQdm2FRxEvo742fPg7LMpMrAcGULmA0Jp47qAhWuI2Us+73WAIKCNk6YHxX Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc6h4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:42:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7uCCI040712;
        Fri, 29 Sep 2023 09:42:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhbdt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpVs6lhrKzge6r8R6RC5hnDWY3l+ot42h7syDByFCK7mfV2BdYSJ2gq6ecb5tgoeYzSChT60OyCr5PJOtpe7UxYqpBV5+Yv5eMs8H8dTMDS1i/7BcRb0xkUC/hBsAcYT38Ke/Ovz4zuzSFL2KB94qT9YkflKc6umnPpbeeDCB88Lr17tfU6PHd3U7jcHSjEevBziemLgKeiZf5Skv/5XA50uIFkc3Z7/QDS5J7TBl6I4q6ORK4Er/jEyNwvXz/MXc95HR3Dd9M97vfIhRE2xV6x84U46G8naBb2Y6XfKq2JYy49euWlW/YWD59NQ3/AuvfjoD9WRqS50/N5SHtZqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QMQ8DkehYDncF80NOP8xABX/B7oaUT4l8yv7qXhivE=;
 b=fhZy+QA0W17ERhdZiI1ARY+vSfnkIGI/3vQw3HfhiKWhRCU4NkFrZ4hND/Ze7u7lQMQc75TRAFNfd+ZQAEr2VDuvKIZ//Bn4kSpYgbq4ZnU4hNnEP5YY25wHJ8oZ+ehTcVNADi/EpLCNysO7c24QBXVZFiDMHlAh4yXio2JfWVIfbb39RDoNoOZj9iHIgg+BB/WPWWI3h7bnHEPKnLFzw/yN/TrVmNwjNQMwJPI0QU82hYGFK06hFgcIlVVbhtrXWJXhUg3KBBc04hEoAmEYZ6RSe4xAnEkgMrTo1iIQIuspkvUIReqY+OPzrIJ6bSOHkGDnMUrTr4T99H5GwPrZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QMQ8DkehYDncF80NOP8xABX/B7oaUT4l8yv7qXhivE=;
 b=DbrnBqBNxBXDJq58cUQTeO9D3cDZ3S4KnrV8XIdYUNeXxa7/NU6yi6tcJVWuGJ+/vcGTL1ohsHpc3gAw8DnLv+6pjJhKCJBsN1NaIfEX1k8v213kucZ+Q9M0goIiGdLkjEFQxL8zvHOly80HabfIl1GOb4JMsSnb/1d03SWMewY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5161.namprd10.prod.outlook.com (2603:10b6:610:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 09:42:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 09:42:11 +0000
Message-ID: <9d06f5aa-9124-d3ed-5585-0c42988e155c@oracle.com>
Date:   Fri, 29 Sep 2023 17:42:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 6/6] btrfs: skip squota incompatible tests
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695942727.git.boris@bur.io>
 <32ac4b162efb7356eb02398446f9cc082344436f.1695942727.git.boris@bur.io>
 <ea2c732f-68be-74b1-f05e-218ebaa2b359@oracle.com>
In-Reply-To: <ea2c732f-68be-74b1-f05e-218ebaa2b359@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: bf57d981-396c-439f-d33b-08dbc0d05abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bd05I2Llx0Gv7ZLu042eJxSYVzbFdKcfN9ctmFsQTkPVEffaIkon//AT3ZvLsRMkYU1ekt4dFnvk8SS+cYzWrqbtF5hKAv5cauWmMgdA3OwafAQ0D52IQbTXtvDXxdQMGj/ghx64QS7q0ui4smWzGDB8hr1nyCvI4nZcLo3rWyoGCHJ496/1sji0VIjGbBtH5j2NbXHMg60LSMFVqmP7So6v1G+fC0s1jphgWE3+6hxgFYzoD2b1a/DIUuIAtDZLbTdvx6IkH86R982EYtFLFzJnM77QlclNjLcJVTNNGtudzZwWlv9bEuU/4q1oUFrf8Ot3v9isBxI0rjbCgtV6ARoBHf46aVaxc/O2bQRG92PhurY3BAeXivpFUoyVsXeHf1UdFnZjQffi7+YdRHlej8JKwFDWnwg5N7aBHfNSrhBZZhtFAEhKFQndEfuEZp60nhR7v/fjZHtwYrFmNjBHUOfTk4louTkvg5Mz9gbi2smBhYJgdfvgtI3hKtDJrzRLLr9HcelPXpqMMebmUKLHLAx7kRRP4p4HNHBN0jEP7Mh54Y968FF927xbRKR+TnePfYyAxnLcd+P0Q5z8XL5+5L2jZaY9RYKETdQN83mujqGyeI9HEsgJ6dYRSIxeyYV9aHvZNIv7XkMxeS19jPgyXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(6666004)(6506007)(6486002)(53546011)(83380400001)(86362001)(31696002)(38100700002)(36756003)(2616005)(26005)(2906002)(44832011)(8676002)(8936002)(31686004)(41300700001)(66946007)(316002)(66476007)(5660300002)(478600001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHpBTld2UlBURWFrOUJKVVlXMlpvRU1LVDFXakdqSXZ4em8wVVVaNVVZNHVV?=
 =?utf-8?B?VHRpUWZRRUFwSWxFZ08rTzJoaGpKWlJpNkc4STJxbUJ0M3ZvdnhuanE5KzRN?=
 =?utf-8?B?STA3VlBDK1VhV3FEM1pTdjJ0NnRhZHlHSkExMi96b1NybjluUjh5MkxRTXYy?=
 =?utf-8?B?eFdGUml4K3FqVVlWSVl3bWdSb3czQ0NrKy9zbUswTHRJWkpoTFhMN1dVZWRa?=
 =?utf-8?B?WHlyR0hibHhFS3hMN3dTazNQKzNDcjJ4TFlJcW02RlF6RHRrRHZRUFR4bFV5?=
 =?utf-8?B?aUFiSCs0bmdoTFRnMzlKVVhXL3IwZE5UV3E4RXcwTVBFKysrZ1FuczliT3VN?=
 =?utf-8?B?ZFJxZVNGdjBmUTBxekQxKyt6c0xXZ01vUmhjSmFobGkzU2F2M1F5NVBpaVNM?=
 =?utf-8?B?RkZMMkYzK010M1JucWljWlVuWVRhNG1Lek5xWXd1b3ZUbm1hTTJrbXJvSmJC?=
 =?utf-8?B?TlcrK252bGxndnIxSDRlL0hZbytISWM0VWxXSkVOMythSVBYalF1aG9nbnBY?=
 =?utf-8?B?Q3pxWXlxTTRlRGVSbVBXNHNleGxtdG4yMm83Nnp1dzMrbFNyL1QwYWJmc3o1?=
 =?utf-8?B?bjl4Tm40SStRazdZMnNRdnUyd2llcTR0VWs3VUprRHQ0U3RudmkrdFNRTGI0?=
 =?utf-8?B?Qy83MjVpcUR1N3hPTm50OHhrZVlld3YwVUtzWGo5VldGb0FVQUw2TEtTN3RQ?=
 =?utf-8?B?Y3gzb0UrVWRha0xFazk0MUFIN01Ca1dOMXBoUWs0ZzAyTUtVUXhYNnJzUUFL?=
 =?utf-8?B?RzRtMjlUaXA5ZGF4eDhta3AraUpaTkVsSXM1QW9lSnVuSVFWYTZWTGRKSlpG?=
 =?utf-8?B?b1BSbm9OdElmempLWlNQcWxCcXpSWGpsTEt5OE5xVzZpaFU0Rlg0cWpWbk1E?=
 =?utf-8?B?aUhBdG5TY1AyZzczK1gvZE1rTEhCV0JVa0tvem5GMmcxbWEwNWRUS1Z2Zloy?=
 =?utf-8?B?cUVib051RmVLSGJIWXQ4bldCd25KRzlCZ01lUi9OTC9uSTJXTjlpTlhPejVF?=
 =?utf-8?B?MEthSWpqdDNIV3poSnBnTWgzR09VNEoxSkxWVFNJdFdwZGtVYW9EdXpzZDh1?=
 =?utf-8?B?Q0loTDFYRTB3Mm9iUzBodjJ4UmVMNnVaOFhtV1YxYy9OYXdDaXZyWXlFME1K?=
 =?utf-8?B?NXlsMzhGaWdBQjJ1elZFTmxIRENGQisraExiL0V3Rmd0NzM0RTIxOUhqNmFO?=
 =?utf-8?B?VldaUnFpZGdYQWZZNDNHNkhpTkVMZkZBWEFvQzg0WlJOdmUreVFIU2lPU3RO?=
 =?utf-8?B?cGk0VDF3eHcrWmFSSXV5RjBrZ2luSTRLdEJWejVYK0dyKzF0L1h2WjFWS2t2?=
 =?utf-8?B?U3BwTklsWEJNZ3QwMklHVEwwNUZ3cTVlQkpJb3FsM1VxM1p5RVoxOGVSUy9O?=
 =?utf-8?B?ZGxNL0dMQ2Q0YWNHN1ZjckFOcjU3UWRYMVE4OHdXazBVMnFlVVVvN25OeWh4?=
 =?utf-8?B?SmFkZzNzMUUydDZVeG9WMWd2c0ozakJPWmJPQkx0UDlsQ0pLM0N6YVRpd201?=
 =?utf-8?B?STk3YWpSVFFYaWNURGJockJVTE9jSnE5aU5sMFVvUmx0d0RYRDRrQ3ZEVUln?=
 =?utf-8?B?WEF1UmpPV1cxNnJIT0MwbzF2WjFuUG5lOGFMaG5EYzk0dTBpMm8wZjQ1dmpj?=
 =?utf-8?B?SVJUT2ltVkl3M1NRR21FMWEwemIyRmtNK1REeCtybmJjampEMGpkVC91YXNR?=
 =?utf-8?B?T0RoWkFyMlpDY2IvbWZ3cjR3ejV6UFk2UjY1UXhqNkhBakwvNDNpVzJLQzJB?=
 =?utf-8?B?ZHpYU1ZLdjNyTXRxNUlDaEdJR0RWLyt4WUJ5WnhqZEhEQUdLUjJiYlZMRlBB?=
 =?utf-8?B?SDdKVG5lRXlJZ0pvTUtkOWd5UldGOTdKM3M2SFQzYThyWTdjM2ZaQzNONXgw?=
 =?utf-8?B?dUZUcytoTTZSeDNZMU9xcjYvMzQ0NDJjNWVVdTNTRWo0SDkxU2NyNmt6OWZN?=
 =?utf-8?B?R2xpcEU3T285QVZQT2ZkMk0vU0c1NE1sTmRwMU5VZ2lydjIreCtnVVFhR29F?=
 =?utf-8?B?N1VVaXorbnlKLzdCSUFRQzZ0MWU1QjI0TzNEWGdxZUo0WGI4aS9yWHB5K21P?=
 =?utf-8?B?OFNLT3JEanpCZDF1em1uK3hOZklpekFsa0gyVGJ3T3lNQjYzemFXblY2WWI4?=
 =?utf-8?Q?iPDNYqpwBnwZgvhAQ1kCumQAA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LUJkMKzzj/5F0U8mzY00OS/uopPnjK5ev8/1Wp5q2o5li6OmrFvSw2FR6qZRrn44w6Ekh5irUhwj2qCEB/rc1H15ZyfJBjwYADJiI8c+jsI5f91ndUBp9AG4wxTkIxZ1uPZSAFFrml6j1sNZbPW6HLqAuWz8mgPIS0XUes/S52P+PUl+VXJAaOEY7QcZDrOt/cQkf1osIVmwJaedkjoEQ4HsLRQQgRP5ChLs/IL5WXjuhqKhGFuKkhYToBlBQ4Ds3UiqsunddNINIwr3hY1BXBgM5TdEY9E+BBnv0sat4Fs42eFv4QjQ8KdHZQxkm92xALK8Yt105Ic83bKUPWvsY/eoPiIQXHBqI6n8LxO3aJkV7XPzIhdYM1bo4LOcm2XLsFbGdnPIYyNHMhMgLwzrTKmWodu9lc+YDggwlA/L7T/vIHlge3owQTLYfIFgjWQP9eKz1dyB84Ucbsnu3lgm3Me/9t626Q18GaGE+pHpXpQcQw1066Z/bd5HvzxWK9meQo8JU3B7MV5xU/6rKcwE46nTOBDu6XDWaETYJrjSbC/gBGALarsBzwhgBe55l2Qgg7eblJQnZXffc6Leb9Rs8dbtipRXOpiO9JHNpTWMX4XSu83bPxjDOgUNUc3XBdJ8bx9qv+mT+jpBkkbAXVygcG7A1YXmTDH7Tr36tPle+9vwssVy7KPI8F2No4a7wAM82bF+wk1L1NyWw0XYHHGU5szKW7QRkMYy6HSVF6fmd5VKNfb3lspt/hdbEOMxq/I+E1rExSYW/pJGRouO5CMC+BKpo8VYD/J+vWrTKO6YGRQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf57d981-396c-439f-d33b-08dbc0d05abf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:42:11.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvIDYYzrHYCJV1W1sihFdRJjjvFQemLkOaS08eD07gA3itbN/jA02ORdgb64OYpc4U7M8QKtIzKsloYOXfaqUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290083
X-Proofpoint-GUID: fXwCHwJS6oAwcHBo3uPpet-lunrhX2fB
X-Proofpoint-ORIG-GUID: fXwCHwJS6oAwcHBo3uPpet-lunrhX2fB
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/09/2023 17:37, Anand Jain wrote:
> 
>> diff --git a/tests/btrfs/057 b/tests/btrfs/057
>> index 782d854a0..e932a6572 100755
>> --- a/tests/btrfs/057
>> +++ b/tests/btrfs/057
>> @@ -15,6 +15,7 @@ _begin_fstest auto quick
>>   # real QA test starts here
>>   _supported_fs btrfs
>>   _require_scratch
>> +_require_qgroup_rescan
>>   _scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
> 
> It appears that there is an issue with rescan's stdout and stderr , 
> causing the failure. Please consider sending a fixup which apply
> on top of this.
> 
> 
> btrfs/057 4s ... - output mismatch (see 
> /xfstests-dev/results//btrfs/057.out.bad)
>      --- tests/btrfs/057.out    2023-02-20 12:32:31.399005973 +0800
>      +++ /xfstests-dev/results//btrfs/057.out.bad    2023-09-29 
> 17:31:24.462334654 +0800
>      @@ -1,2 +1,3 @@
>       QA output created by 057
>      +quota rescan started
>       Silence is golden
>      ...
>      (Run 'diff -u /xfstests-dev/tests/btrfs/057.out 
> /xfstests-dev/results//btrfs/057.out.bad'  to see the entire diff)
> 
> Thanks, Anand

And btrfs/022 as well.

btrfs/022 3s ... - output mismatch (see 
/xfstests-dev/results//btrfs/022.out.bad)
     --- tests/btrfs/022.out	2023-02-20 12:32:31.394980330 +0800
     +++ /xfstests-dev/results//btrfs/022.out.bad	2023-09-29 
17:41:18.393742664 +0800
     @@ -1,2 +1,3 @@
      QA output created by 022
     +quota rescan started
      Silence is golden
     ...
     (Run 'diff -u /xfstests-dev/tests/btrfs/022.out 
/xfstests-dev/results//btrfs/022.out.bad'  to see the entire diff)



