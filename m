Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047477D46E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 07:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjJXF3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 01:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjJXF3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 01:29:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ADB118
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 22:29:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NMIqSN009058;
        Tue, 24 Oct 2023 05:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8m6cl8hPpAV2H7vY48bd1AaG3gVpBzN4qpKMM0UuZa4=;
 b=CDhV0xqV8xWbrW24BudIFX8ZfFIkIuHCLk0Gt3zmxYJxMQKOtCz+QXvwL5FdIaHnKN3a
 XRG07s+QiS+mqopqvRL+Bw/GMATRnMpPogTr8YErAm/ykZkWG/0qDyBHrYa6gprJwPtJ
 QDpKo2dOBD8Asy9WlaqXSTyZf4EnEqtvYtgnZ2jU0/feTIzWbsaQ2IUspyEsoIVTQx3/
 lMAHEAC3RsQ6k9dgxE9N07P64hNEaKyUYphURr7KvQ6BNEdBAhiVsBl4Y/6ySUg1rHG6
 qYLNOZ9mjfn9NubfN/xo3aPZRWVC7R4mHg62MKqy4XNqllCq8rwk05b5k4/DNjybhUPg Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52dvqvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 05:29:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39O2gNYg031095;
        Tue, 24 Oct 2023 05:29:04 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53bcy86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 05:29:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSZRDnGwvF0vgFQjLOYxPz9iVGYNaQOAtGEFxGSuk7AeKF1utLbCedxhxGPyY/0ZR8HlTkk+jGdE2LXACyackhxvoUZ3h5ZNxidgGVdUgTXxJG2iD3R15kdfuxiy/L7wN0f1sDyJaMel/wpOYw2Eu5JIUbsQjF1sCwO/FOjIUu2okFcBMFBUHfRDtxpNHuTE0/EF2Y/sKQ/HQNrYpV4hB00vATgELBGGUba0xLFJISeQGyRYqtE4w8CuyooBkHKXP+/zYK5z00SYj5Sj/BzaKxXC+VWRHlaFN1CfEMhp3vmFTz1xIZJZJHE7SKzWoIOjA+34S9S2OFpYASTDbiEUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m6cl8hPpAV2H7vY48bd1AaG3gVpBzN4qpKMM0UuZa4=;
 b=Z1vdczCjAbYHfmEHzaHNMtrzHjBQ/ypxqgBV9Zxkdh0yJ86lVkoeE0JwBLW6RZQUcqy0LwTJw1VZHO8Ul8N/jhpbXsI6YCEEpDmCFILfNco1kg3TVpPOddMG0/lxN5mmkQ2j/6VZvAwFvna5+q8ObsUFxf4AQA1/YH+k9JzyfR4HpRcbqzb/sjIFAp0UvIO/XnuBCN68Ygs7wea0IzQ1EGV9ty5Be3MUuqk6SkNGvmWSdT55zAfm6vlAXsT35hYyLaxCJqpzjOkgznmcWOmVKm79zCz/t7xIQwCd7gk6650GRULFJBqyQhy9Cx4bCjzzPnkolhit8JKyZ0NzzqH4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m6cl8hPpAV2H7vY48bd1AaG3gVpBzN4qpKMM0UuZa4=;
 b=byi0vz3VzFzXZB+nmmY2K6lEulTIqscyA22qR+Z1PluGgVUVBCvCSYVVC8hAn9wUK89OH3XnoKui1V1hZYYXGwcvTHTWwftMpCxSferBWZmJri/bqzH0bUAXhYUVIStn59gyOzGhUo65H756lHtJPwTDuH11HxuxNtYn6Y4Lipo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7598.namprd10.prod.outlook.com (2603:10b6:a03:540::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 05:29:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 05:29:02 +0000
Message-ID: <39c425f8-c403-4b92-9799-6bd957e0b796@oracle.com>
Date:   Tue, 24 Oct 2023 13:28:56 +0800
User-Agent: Mozilla Thunderbird
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 3/3] btrfs-progs: fsck-tests: add test image of
 out-of-order inline backref items
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1697945679.git.wqu@suse.com>
 <e260e8432e3ae5e09d012dce6bd6f96ff0569649.1697945679.git.wqu@suse.com>
Content-Language: en-US
In-Reply-To: <e260e8432e3ae5e09d012dce6bd6f96ff0569649.1697945679.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c165e9f-0135-4ded-ca30-08dbd45221ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9rsP96EZheldRdGpDXoWVWQ/kIMcQ5EWhjZ8jCka3DJDD+ndGCo8hl6PxgKcL8e/a4E6S5g6sVRRW3OcwnB18SxlzZV11teO8oqsU8FuYicUbIZJT0Pyw5EhqQq64eNwC3Tk4p1jgPthc1ESwPeheg5HGFeqEbYrwZD+eReUkBlSivDraj7DpzZ7M1EMhs5riRyTqO9TUSUUjlm4BK05zln22t0MQ6L+8Vjo+b+6yXsUdAjG8dm6SupnIThHsr6G5VTTXjTJkz4/yKWaTSiorXwgLfbhBcj5QWIMIgyWinx0ykHQsXH8gPRYnik/gsEWQNyEorHKhC5EtDQQW1g+RdLwLLtulnQB9rRR9Tmo0+31UDURjqmg3+UAOiGOE+mBKn7gLgRrFf94IvzE3PN9WQWtXgshp/hD0B1UGIbs0bGz52/NweZy/rLDkm5YIMidGBzFUGqjMhcmteG/307OR0/qre0wnKGt+WGpC143uGIR7K9K4L45etTqCc1wj3TzKcB8LjH6LhlZWxDeb0ZRNlsOATBGbV88GuZBIGKCUL6rH5d5v/bjP4V4w8J4b4lJZ9TXW+D6/VDAjeaav+TJfheps9MW9kQ4DaWRWrAETzJnyEMun8s5tcTesJdBwf9lkerMk+pGxNfisCyC2YrNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(8936002)(2906002)(558084003)(44832011)(8676002)(26005)(2616005)(36756003)(38100700002)(6506007)(6512007)(316002)(478600001)(31696002)(6486002)(5660300002)(6666004)(66476007)(86362001)(41300700001)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVBmcTJ5M0h3RmlPM0RsQ1lucXRrd2h0VHc4RDhERFM4REQzanhyZFVnZXh5?=
 =?utf-8?B?UDJ2eFQ3SWdmZndaTU1OcFloUEYyMjdqQnhqeTJTK29LTHJDU1VVOFZEc0lu?=
 =?utf-8?B?T3pwN0V4YzhBQ1VXM1laVXJHYlhxSjc0NnI3UTdieG9kZFBSdWlMMENwZW41?=
 =?utf-8?B?MXFPOEw1YnRWa1FKdHVnRC9VRkhCcTdjZUtmUXBvWXpXVUxoMnhUVmRNcUpG?=
 =?utf-8?B?dUdvdVVyTEdGTWpaWFZPTkJtcVlpVkk0dEhWdFloUEdVdGVodXAvelRLVnlL?=
 =?utf-8?B?c2E1TnpwR3ArQ3B1UGN2TWxIUUVMazJFTVN0ZHVyZnhoZU80WDNSNVprV0xR?=
 =?utf-8?B?ODFxVkx4Rk1RYU51K2VzdUR4Z1pTYTA2dWk3c0MvTFBZNUtYT3Rhc1ViRTMx?=
 =?utf-8?B?Q3VmbEdFT3QyRWMwNVVYSStuTzI4MjNadHkwbVhmdk9XSXgyTkFpYWVCRjdw?=
 =?utf-8?B?NTdLbGpDSXEraGlXRmlDNldyN1V4elhlUkZKWnhNUStodElOSVpLLytQU0Ro?=
 =?utf-8?B?SEJEUkw2SERubUxQb1lMVzRzL1IzN1VDUzdLdm52T0ZHcWFYTy9QNFFPNXZD?=
 =?utf-8?B?Rm5LTDk5T2JycW1WRE03TjZ5TkV0RnZjNDRJZ2Z6RC9VQWRveGdndnVGalhq?=
 =?utf-8?B?Y3pscVRYT3pmYVVOeWFjMUkwaXZ4aWlXSUZSTVgvZ0pZR250L1Y3MDgxZElD?=
 =?utf-8?B?YlQreStjNHdjd051VkVYcnUwUHNTOFFvUXRjcmZqQjczQ2pEKythZmcvUHkr?=
 =?utf-8?B?Rm9mQ2Znc0NpTHhENXh6OXZML1FmZWJhUG9yR2dKNW1RcDRRY0VKbEZTQnFN?=
 =?utf-8?B?RkdJVzQvNEtIa2lGV3lWUU5FeUJ6RktkRlRFRTlONTNweExsQ3UxVGFENlE3?=
 =?utf-8?B?aGpHOWZLaXZmcnFhSUpreDNwdkdUc0t4QS9YeFkrNDFVWEVGelhDTEswL1Zu?=
 =?utf-8?B?aFB4OXRCUkJkTkJvQktlUG1LMDZ4cFQ2UCtDV1pRaFRUak8zVi9ONGl2MEpj?=
 =?utf-8?B?WVk1MzFPRTRvV0MyTnhNdjJEQ1NkVldScEV0YTlIcll2d1F3WXFoZ011aHZm?=
 =?utf-8?B?THBISDM2WUpZajBWbG5zZU1SdlN5WkpPTXV1NktneGE3WnVqVGE0a0E1T2lh?=
 =?utf-8?B?d05aYkdhMU1hck40bTV2S2R2N0JrNVpsMXFEYmN6Vm5oRFJkMzVzc3hjSkto?=
 =?utf-8?B?SWZlL0ZxRXduUjkwZWpLdS90UnpLNkh1UkgrOTBUS0NFc1AvTXkzZUN2VExK?=
 =?utf-8?B?dTN0aytaOWlMc2lPOGpXZFR5aWp3RlhvNXJCdFlySjRWMjR3M2MyRWtaYU9u?=
 =?utf-8?B?Qzk0WjhtUTE1ZTZjT3N3M1dHVDFQSXZHNEZiTXZKMzJBZmhPc1I2enB6WElo?=
 =?utf-8?B?ODFvSjc1aWRyemFrTlVxMDFiREdkQkRSZGhzcDB6QVJ4Smg4ck8rbFhFVVlP?=
 =?utf-8?B?OVMyMW40UGl4YVc3bnluTDdNK2xBL2xNQ2Vmb3h6blVINjhpc01TOUpEdjlk?=
 =?utf-8?B?dHVQQk53emsvMzhKOTNPb3ZuUjdvbVJFak1pbVZiUzh0dDZoREZPUzlSM2xV?=
 =?utf-8?B?bGZROWZOS0NFR3cvT05WUktqczZ0M0c5S3YzWERzTFovektQS2RZMjlzNWJB?=
 =?utf-8?B?aXBSa1pBaitRTXJiWmhKQ1N3WFpYcEIzaHpneXd3dkFjT3diL05EcGZVSDVC?=
 =?utf-8?B?WjFTa2ZadWhUTTB2WEkySVJxMTZLOTVWM1VoMHBFbFIvbjZMUE1jdy9zQmpr?=
 =?utf-8?B?TmJBaFFzektaWTN2Qm03bjUzOFB2LzV3Y1VOUVRCYjU0RG5kT3N5U0JYTGZh?=
 =?utf-8?B?MjQzaXNwVWlBVVdzTURwZzk3OXJzODZPdEsvOGM2MEUvUHd2OE9ZeEpVUDk5?=
 =?utf-8?B?SEVFMEhoMkd4NGZxdlRFNkVxOEQ2Sk5TWWRxZG9DblZROXovdW5BRElFRWJt?=
 =?utf-8?B?S1ZTL0VxOENha25ReDRtMFQ5L0ZGbVRyME5yRHNzNmNxbUhqRllJaElETDVs?=
 =?utf-8?B?YlcybEJmY1N1ODB5L0NoZHNoRnJJNGkyM2FPV1pzMkU5SERiZEZ2T252RVBT?=
 =?utf-8?B?czZqKzB3cDBLdStLZXQ5Q0RQMk41b0F2Q3BJcFh3UUxHT3ZWbGNRZkdjOWsr?=
 =?utf-8?Q?9Ogvw3HeTGRZy14GEPUOxrtN0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bnbbJcMhEIlb9rZxIfdBgbjqZ+4YaX6j1cTj/5ANaxvJIDQjEEy4RPdzbjfZctwCjNU0aUBerukAVtSSGSsndCeZzKZ+s5UPSlEDdTgxqeie4JamX2yCrc8h63ZQWka6TCXym0qAd0ZK+tnrVuUTAVQ0v+cXGMGbF+no/omDy5gRl7Ssi8sZI2FlbfDH0t1Ah0BTlXjXcwi6JZ8RHmkGNbeG/PxSIm+VhvN/iBRzZbS7ZuOf4k9oarliiSKhldUDeNm0ELet7lVEIjKhmWexvSwkybCOXgQhbfwnSFirzc0T+m/xblYp/BHhlYHC2OgVWgD2y0HlnySkfqA8La6hFsxYwuRL1ONFtG8reI2G+0xI38Z78bAjJlogqmmtCRZB2UCW+txeqQEb1g3ncQbb7srmQykcr5IqeAKT7M1eX2Z8yWTza7VW3DUSXHMViuqK1OGkL68sfkcle/uydZPF7G96Yd9odUBhXbDHa4bVC9thNarN6kxHAwldKnMv0l2yxfnoWhX4dE/yZ/dfGRNxj4cHYoIl+bunwUwTJqLvp1RywWXOglSeAEsfJ5Evopdy3bX144TgXALIQCOS8OGW2eNdzO5rc+CMr5zd6/JlTne9g9PHnM0jFjLNGj1hUWvp8/3pMVIY5RATcWL2tN5nzWgJ2pPGjvGzEy3PUhIKszYHve197MfgQ1tKBAb8kG/qpenQ9w0cn/zc/q+vxMlVBGkEdJUfHC6ZqUJicQxMLQLXz6/dJb2ISOOmEO0N3wfIhCl7jWyp5UIh3m+cdtMEJuh5STjt+EQVTGZJn0IRf3o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c165e9f-0135-4ded-ca30-08dbd45221ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 05:29:02.7758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGIkGr9cUhkGbykgi8vUAKFUETArUW0AIg6KrweLfNP4KTjy2IkeMBi0agi3vGD06xbDDva2/H1vM7v7SNnVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_04,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=974 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240045
X-Proofpoint-ORIG-GUID: zTZYP_wKj5S3HJ9wpyq-a1eVQHF_v5pM
X-Proofpoint-GUID: zTZYP_wKj5S3HJ9wpyq-a1eVQHF_v5pM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




>   .../btrfs_image.xz                            | Bin 0 -> 2264 bytes

check_all_images() won't find  btrfs_image.xz image.


         for image in $(find "$dir" \( -iname '*.img' -o \
                                 -iname '*.img.xz' -o    \
                                 -iname '*.raw' -o       \
                                 -iname '*.raw.xz' \) | sort)





What's your plan to test lomem mode?



Thanks, Anand

