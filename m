Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A3D7B2F02
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 11:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjI2JPH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 05:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjI2JPF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 05:15:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B91B0;
        Fri, 29 Sep 2023 02:15:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK91Ro018353;
        Fri, 29 Sep 2023 09:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fvEHt5TSBpIsK8N7SOHGE5eu05XXS11aOQMAblop2ho=;
 b=mxIV6ozCF2fsbz67RdMkK2vxuQIBMilb/DqqwBJ6i35+a/rF+xrvZFgqiA0i54cD1AbK
 p1z/if/IXQvDEuP5TMLvzbZd5XF7WtfrBJE/IoGEvjrQShHfhmPU51TxADBDf7uoH8zW
 +NPQtuqp8gKx68fKKF6GgZ2mxxRKqXXvsIvEen0Ehtm3bjPbGyP3D5jIIOe32T8vAzvu
 TdBD8RSa4s8DHGLHzmYdtmQjs+H4z5tZxrGFzkIjJq48YHpvtnvrv/G90IUsCeq3q1Br
 TfyopJ+Tb/hav66CS82ipGFjkaSDFs1bH6hIy4TqOggjPuSN/RjiujeiE3gWWwiDFF4a tA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3xb52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:14:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T82JD8040856;
        Fri, 29 Sep 2023 09:14:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhamh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG3bm4HCCJ/f5qXcfEkcFOK4kG4G7kUfLN9MirUR7crpZv0QZIxzRf2Im+DX+TQPcOqEWzMYFwBYleLwo2yNwNzHB2i5u1ml9pAaw/zejHuHHC88FSgFVGc+/ejx8hDKNsnLpLloT+Ew9YUim6owImQ+7wxcR52SJVVyKsSajFU1gT1CKoIZE041A9eVi/Ub05h0Twq5+RG65vDppuQ7LIhhkHu4StzcufqRJcuRigx+/eb+NoVNHUyTfR+c04yeLNSqEHKUOwgC/VN2DCFFblBNznoPGnfXLU9LgnJR1DNmkVcFW4fWjFJ3TAAfYzRjGgC2Afhkecy/ahZ7td/ABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvEHt5TSBpIsK8N7SOHGE5eu05XXS11aOQMAblop2ho=;
 b=AjDTfWhgXO+/p8ur6OS/UcqVVdJ+s2S332hr2CZa6C2tsi+0t18u3PqfrCRa4mGc7C3RMTr62j7ftvdWNnc1RO23DsUc7UvQrzROfeYbmQqltUVs/veaKCGMZ6fGjdQbA10J03ziCBxjsx6Mv/40A65uEZJlHdfaJ8dDmr69t5F+g7vorEJEeVigoL62zj6nup6mWxjGTZQDLS7qHNS0d2nx92elSMSNGlMwC51WHr9BJ81iYOu5kSpLbi8GSUQpBcAGFECiqMthG1DYg/TTdh/8rTZqc+S4pO+wuE8ZAdyyNHKyr0bV8dboR8W8SkDn/+4Frd55r6DxY6ywjWwNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvEHt5TSBpIsK8N7SOHGE5eu05XXS11aOQMAblop2ho=;
 b=PNRSFi3byNWeVRyBnzAe27Xn339tk5maXpC80XEOvuMYQQIFoubECEOrbPSTHcrYGpQiaHUaeHOhMcXshce1ZNPuG4BDjnB4ap6YAgqgAcdhJ5qaxL/aM3SEd4A6RBMObV44lLO551CS+H1WcJD12PeH3eEq82VrSYopSKI/tYg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6890.namprd10.prod.outlook.com (2603:10b6:208:432::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 29 Sep
 2023 09:14:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 09:14:57 +0000
Message-ID: <b699fcef-a8c1-6651-7941-df6007e812d8@oracle.com>
Date:   Fri, 29 Sep 2023 17:14:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 4/6] btrfs: quota rescan helpers
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695942727.git.boris@bur.io>
 <1f8549eb7f043ab9071faf896121896e759daab7.1695942727.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <1f8549eb7f043ab9071faf896121896e759daab7.1695942727.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: ced15647-8e67-412d-9fc1-08dbc0cc8cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhNi2hamhRrQvH0sjxt8DVslA5SzvK87oQUR8VTVtnYdfywxVRZPv2DIiBekfX52wP9rgWku2029Hb/69TmzP4NZnoc2ur7V2afk5/HFpoaKSwDc63RV6hFJ3d01kuClM1rsGUruHaio0s0YCDZw5+CcwvbtPAtg82DuwcPg9qHbNtE4KI51qgfInfG1VIQQGKPbVKLat0jqmA7oCIZ7dJ90JyW0IZPhqfgDaqB0Jk6OOS21pVp5zMdH/1bkW6UJalqixuOw9EEJZ3MU1PXxs3PXODkuSTIjrqxeLmVeBHZPEiyL5lXVEP0rm5CqC4sbgRdj+blAMRr3J2LxqMRczN6r3x92p5aXa+f188tjdKTSMrSXQDbjQ9ZUM2Uo25KGRObudfNcWg2EX7Pwly1kNpAC0+2naxvAeFH2vj0E1RvUbdvQlJOZB7z79l9bIQUsgdr3m/5ajjyAlx77J8RiFQQ4kU+PN5sNqW4F9bbwJTlHoZBHpkc8lkyBejDhwcI30PO4CN2rxdv+KErNvf3BSg9/92h6b25Gxna6ieLIYlUD0+BNBDljw5lZchDmegmfni6yhK8IuMLr74qek4qhnQ8/pglSvIaItS1KChyIMSKbOiSqjzFRn9i3BWZ280xj6M59+gUW8n5AgufB+UNLbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(316002)(83380400001)(41300700001)(8936002)(8676002)(478600001)(6486002)(6506007)(66946007)(6666004)(26005)(6512007)(66556008)(53546011)(66476007)(2616005)(15650500001)(4744005)(2906002)(5660300002)(31696002)(86362001)(36756003)(38100700002)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2hweiszNDRHMVFTTmhDTFNVcmJqLzVwWXltNnRrL2RGRTFZWXQ4OTdFRGdH?=
 =?utf-8?B?c1g4MmthbzRHNUJhblFuRkRBMjh4eC94NW92bkVRaVJmMjI4QUJoQ1lmeGVT?=
 =?utf-8?B?dGE1U1BKd01aL2tXZWlld3diblVacXJmSEtNZjhVeTVDUGxXQ2I4TXdJU2N0?=
 =?utf-8?B?elJCSCsvUlFxNG9OMGVhczJtaVJTemZuOElicGZ5QTVMbzB3emhRMTgraXJS?=
 =?utf-8?B?Z0dxeTJvMWJaQUJBVy9BeWxLVFJDTmpJdHk4UjU5eHFiYjdnQ2hOa2JVZEIv?=
 =?utf-8?B?VEl4L1hRdUZmRzFEcURIZXJOS1BmRFRQSFZuUHIvbytYWWJ0UzJ6OVd4NnU1?=
 =?utf-8?B?K1dBQ0ttcmpOTE5wM0JBSEtMMldJR2MveWVqdzhBeDFaUGhQUlFQc09udkhT?=
 =?utf-8?B?Rk02RTF0b0paR0xaTzZ0YWFJN0tXaDdjd3pCbFRjV0lMWHFiWWY0anRYWEpu?=
 =?utf-8?B?TksvSEJZem5WOGc2WWFvK3ZjT0Q3VTIxcXlLTFQzYkNuQjlYUXhhdm5uOFdO?=
 =?utf-8?B?SFJqYzg3V0Q4cXpVaEtPNlZ5ZmZNQXdjOGpYa2hBQ1BPNWEwY1piVHRvTjM2?=
 =?utf-8?B?cDZtd0hWQjhTb2MyNDU2aXlEU1U0MHRjcHBwTjk0K2tUeW9CNDhOVkFNOVlt?=
 =?utf-8?B?ak81bWx4bnBFUXJ0emxQUVFtSGZ2Q2JWS3prU0hPL0tLRTladis3Zml6Tmkz?=
 =?utf-8?B?ajVXTERST3J5VWZUWU9KT3pWbnFRclhqK1J3SEdvajlrclZVaFYxNEpOdVdy?=
 =?utf-8?B?OTVtTEJJdnMvamhlQWM3VlNJeUplNmFTRG5aaVJyQWRxZm9FSGNoeFoxcFZW?=
 =?utf-8?B?SEg0VFR5cmVyNWNpYnVpZUdPSjVQWVhiR2xIdzlpbkgxS0pvOUpwSHlWcUlD?=
 =?utf-8?B?SUlvQllJdEU5TXVHZmJtOVRDYkhMM2ttWWxNQTU0eE5tcVMrVis2QzlZTUdw?=
 =?utf-8?B?QWhUZnQ1bGVacGtzQWhreVAyZGt2a2FXTkRxWisvNko3TENSQ09IV2phQVlX?=
 =?utf-8?B?YUxObDRMVkdFSWw4L2ZTRksvc1R6UFRFMVZlaDFOOFU1SnpHRjd1cUF3N050?=
 =?utf-8?B?S3RjSzkrejFSNHZYUEdod0JLcDcxS1NvZUo2RW1rR3gzNFFHWmhwTEdXWDVl?=
 =?utf-8?B?cG1HVHpic2pqZUNHbmwrNTZTMVFwYnkzRVFkN2NLenBFTER4Qk0wQVkxMkow?=
 =?utf-8?B?VlFsVnVmbktMTjc5VGVMTWd0MjFsQnZuZk1kZEpmNjJ5cXJ0RVdJMTh1U3kz?=
 =?utf-8?B?OEZmVkR6NGtlYmYzK1VpSHMxdXJiRmcxM3NlYnZpRlFaQVQvZ3JEWkVsTk00?=
 =?utf-8?B?b3l4TkZuM2F4c3JWSjJwNFd2SnVPL3hjQ0ltVTBWSStRczFMQWF3L3gyYWxz?=
 =?utf-8?B?STU0dHNHanRqWE41dmxEaFdJcmF5aFYvMGZaN0l4STE4WUlVaHhsb1k1K1Vn?=
 =?utf-8?B?MXVhV0VVVlFGOU90c0tZT0FuRXdNK0c3OUY3bGhMSXBmMjRuM1VQb0dvOFBn?=
 =?utf-8?B?N3hseng3cVd4OXljN0VIZGpoWUI4RzVWV3dGdHJHOVFlaFN0SG5jeUUrNVJI?=
 =?utf-8?B?QWFqMmNHK242KzhXckJxc3h0Yit3dHlPSkU1T3FyVzhpekN5aG9SWHUzU3gv?=
 =?utf-8?B?VE5yeE41MEw4UGREZ0k5VXdFUkI5RlFtcm04VVhJUklCWWpiTXBWUzQ3MjZn?=
 =?utf-8?B?OVJMaTIwT08ydk5tZVpaQ1lDclY1eUtXMDd3SlVpcTZVRlJCR1BZMWlZUGpp?=
 =?utf-8?B?ZmpNYWFMZzQ0aXpsTWYvVUsrclpFVTVYYTFKV3MxcDRJUmhJZGV3MzczMWNv?=
 =?utf-8?B?bkFjV0xiMlpSWkI2MnJTOTNMN24yZnVicU9ncExWL2MwbWNGQmZxaUpSdG40?=
 =?utf-8?B?cjA5QnJSazBsbXNWMTlTTUx3VFdMQWRDQjVLSUI5SktuWjhSYWkvYlFxRi8v?=
 =?utf-8?B?RkxDQjVFMExIaTE3NFRoZUdvU2NIYy9HaGgyTGsyYkx6UXFIcHZuNmlzU3hM?=
 =?utf-8?B?R1hzTXNzaEdqUDM2SDVBbXVtak9rQVhHeGorQ0RiRkdPUjYvNmFscUNPWFVv?=
 =?utf-8?B?WUJhR3VNZnZsaE0xaTNWNHpwS1dmcU5FL3Y0S09YMDVpS1ZNRnNxVlcwS3NG?=
 =?utf-8?Q?nMbmSS029VvKdwUzCJu7aRT4U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7H1eX4nvP0E7/gPBHIu6GNxkrqmzPEcYhDE4YWCww8qn/EPLdejPDRdhnMiIrbQImVtPoD4dFuobMK+YLMLgwX/hU/FQpOfBtTyXxshpqnIRVjMcusf10Uv6VCoDtNBPKtzs5FToR+s4o7yKPXh3NJv2ShFXLTw68LhBNDRyMSo+oUH0gleVyR9Be2k4n8SyfMozXUiYMcVaFh69wPn84WN/voeLzCxncqr8hSFGg6GwDFFVCf3aHW2z0iSsAenRz2ZNJLXxxY7EyR6WF9N1W/+aXUUVNrCgyCUnJFKkrXN5vEEmH0TeOUpeSxu+lbBFP6Bp7XLyO39wBj5C25dQ6cvxYcHG030/yvpJrHxwDt3rq6MNCrIhUzv5j7tiX/NiVzFjE1tIsocmXJtX+pvye5F1Jw3bT4wMGZoVXanXBq+r2UhBtn+16aZA/Uwl5zGfMPu1vrAjn365rJtCV6K7XKPB9WljyxC1HVq4JCBdSHo1gSDexuOaWU+uZCPXp26by3mv+lyp7TqOVIkmiVWQy3qehvcWs6XnxpXBMjjG7D6vyRjne2A5tkKt085WVP/bUzbLfSZM7Cut85rtA+kwbHGoGGqXfs8aTmzC2b8Kqc0se0pfdVExmAiJ4MwwzFlUN/so/Vjljg0AMTT2j4ajXbcC9DXsb30/CFEtBT+iXrxBCCmpIymAGFq8ia+szD6dVKy+UDe/neRjizAv/9w0qZDKHf+/FGMZnotDynlMyvZ4JSMGNEtX130NAzNcluv4XnORdbR4RZwLBmMBfsnmEKYRo8AdPANQn7z4JDnidaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced15647-8e67-412d-9fc1-08dbc0cc8cde
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:14:57.5902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cS/c7GL/8e/O5rFMMzO1Kw8MsQvqjVXTr48lDlZHGu2oLCDx/8mSIaI0K98gBl5d1496n/X7PQsv73aEGGpjAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290079
X-Proofpoint-ORIG-GUID: ZaAjTF44OU8GplAZFqH2_WHFDBWxbLcb
X-Proofpoint-GUID: ZaAjTF44OU8GplAZFqH2_WHFDBWxbLcb
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/09/2023 07:16, Boris Burkov wrote:
> Many btrfs tests explicitly trigger quota rescan. This is not a
> meaningful operation for simple quotas, so we wrap it in a helper that
> doesn't blow up quite so badly and lets us run those tests where the
> rescan is a qgroup detail.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Anand Jain <anand.jain@oracle.com>

> +_require_qgroup_rescan()
> +{
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT ||  _notrun "not able to run quota rescan"

Fixed line length to < 80 chars.

Thx, Anand
