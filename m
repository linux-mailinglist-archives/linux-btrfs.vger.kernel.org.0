Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC55BCC18
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiISMo6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiISMoh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:44:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22FB1FA
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:44:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBx7bQ020247;
        Mon, 19 Sep 2022 12:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1uE0CwtDWZFiDRg8nPMilSZfRF8CsjELRYtNLialmgw=;
 b=bptnDOe9JuitwrLjEwZPrgpqCqVPS5dTpCXrlek9LIks0V6Xt93N80bGirJrLyvTD463
 yAHa+M/6xVQZ1/KLZmbaZnnQ8Di84Izkbhl415gqKycIEKDFZdCt5Ieu3uPfwyB8wFYf
 M/6SxTBC6vRtNXWiZoykwexTGyXuVNB610okt+a03Z7NzBCsYU5yebMFjOaU+3T3xzfT
 QC2jiW/3cKP7m9mmyUA+TnWZxOIlO0xQ21Vf8BO8LKYp+DmOSdCwiDWrT4v9opvG6hjd
 TjO3MWDCVnS9136ViSK77XZnY46wogTjtKQVGQ4hctDDzQLBe5O7tZHNK94Su9G9WwwW bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rbpq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:44:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBkrM7018985;
        Mon, 19 Sep 2022 12:44:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d0v1c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXaq7/jIj6xTQV4pmR/svRqIUGLH5u3cvfvjjVFlLe5Nuv4P/fVM8r/1ew/TjoeqWV7Q9glNo10oTJNQiiIJx27ZA4FKNsvNRhXElj2KDwqQASon7ePGR8PPdRw0Z/B00F5z4QAsJD4fa8AOgzbR5jXurH03LY3FzElzJ+xFT9W6hf1WVXfGT9vTrUY8m5fSrTSiW5+/hh0xS/lIhENeTsGZ/ks/YUyUVQRTC69aqJL/AoSAZYOuQ8FhYETR0lyH7YCO7irWqZH+baL1TkJfub/4wWgSa7aCSt4YDq+kuH840rmv0qFwNL2muwBEr2aR0pLW0bY4mOLkI2umYRBU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uE0CwtDWZFiDRg8nPMilSZfRF8CsjELRYtNLialmgw=;
 b=On8azVMTFoNuO0UruOHq4XOzS2hQBuAc3d1ijSCOtHD5sM94F0n9ZHLYpHYqcVlg283ZhutyCX8yUE/ytJTKv/zGcj6lGBhaOfFJuvwGyZPgaP5uQTQA4sO/lC0WfEqmiQMekDTS+t2qugi8E8oE5cHZNj8amAwSHX+S77sl4ME/IHpnPMwUROcZ0lj8Nae6zhlBV7hf8Dt4nVMLyH1PAzeGkWg5LxmGARU2yhNTqSUFM/RxuexupUdDtTNDwpB8Br8/3V06++SX4GNxAJx+XKRiPkTKzB9en8aeI1IjPmPzdKgNh274tqyiIPf7OyAfwikf9NTKvNqu8JxHeaBvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uE0CwtDWZFiDRg8nPMilSZfRF8CsjELRYtNLialmgw=;
 b=G7dQz4XBhev5HURpogN+2uHsAz9bQbTQAHAuQDAkgFvkCFwGK5lJlbxbZZQdYieYC/+3ufrr/SAUHXDsDxTZobCfaVogCHT19Ndl5WQqeBOi+DVdiavBJ3pssMCDCEBwNeBQ9z2js7z5HXnOIJ2Bg/KMEPIlJgE5AJ2ZmTUVsmQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6919.namprd10.prod.outlook.com (2603:10b6:8:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 12:44:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:44:28 +0000
Message-ID: <acf2868f-c423-3aec-709b-5dbc4e78673c@oracle.com>
Date:   Mon, 19 Sep 2022 20:44:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 13/16] btrfs: move the compat/incompat flag masks to fs.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <ab63f545063c7003c5ed94c3d8d6102275f785e6.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ab63f545063c7003c5ed94c3d8d6102275f785e6.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: a67f7685-a710-461e-e2b1-08da9a3cb0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEZG4878k3mnuyhRr+1OswIL58on9+z4BhjZ7A8viCIrSjWMH5SUIyDeXxPtZ7+IFch9moaqf6EUxd3ayAohCcjkPNeHpW7ksORxXVW5Ln3lLD+IykN8ied+X8A4IDQgPCphL8zHVp1d5AI+MfkSNMVk4x+tinsszDU5OjhPnOowm7qhE1B+Lf/PhzTM9zEpGVmgt6cYfx+c5mI6eFySmddugZRv66iaP+XJP/rs0yAPYjevN4twGhvdk7+XghYP5V/pk7O4i28zP0veWKGZvDXsPX1s9qx2Yr4cDavm0xVpAuUXCgRd2mEn2VzYhGLyBe6xvI86ziAVsr90rCcHtckDnitMRO+NhvC8YfLWILECzRI7IcFsxRSPwDFnCpmdqkC2Hg4ZYBamSIptu8mucGZfP8EhQZgvH0OjophEv4CidtbzmyOqOWPiuW+678SPfB4xrtyAllwjwcqrt4m7LOECwo4ptivislH+eazewmhhiaPGrdZzrau9TCpzZH29GgajKFSSDTwnGpcOlk9Z6/5T9CVZVb09JJJl8LNXQ3aIHo2NmiB150CPcEZO4ym3j30PnvsQ4yY6kyfJ0Dm3aYjIv+JKtfNUZM1uDF13mTgdpqNGRL9KRENemEWcsi0dv1KpLi96WcQRkS0vHaoyXE9ChJ7yRpIEp6oeYXMTfW49aECmYywx2kHgbSAMv6f6WooFkM1pIDoYECbuQ4dWTbdBgFiObd4xE6IYKvFhOl5Xx9rD29ieFQ0CN7s/znb5w3hvZUMEo7Xievt/LwvCL/tKopBYcTR9se0x1X9Isg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(31696002)(86362001)(558084003)(36756003)(38100700002)(316002)(6486002)(5660300002)(66476007)(41300700001)(478600001)(8936002)(66556008)(2906002)(8676002)(44832011)(66946007)(6506007)(26005)(6666004)(6512007)(186003)(53546011)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXVudjZQbUNuVDVjQzlnNGdpVkdvKzBZc3NsRmE1S01yZlVKT01lMCtPTmQy?=
 =?utf-8?B?dlZFYW9nVHBTc1ZwZk5kdURvNnFNTXpTSkVRQ2tFUkpqMkFsNzdoa3VJWE9W?=
 =?utf-8?B?OG9vaStDQkgrRFBFTWxxTFJ1YWVZZVpubDlCZEhsdVpGLy94TzZrRCtkNDVm?=
 =?utf-8?B?V1hQdnpNYXBaQ1ZOaUhMbEhGNWg2UHorSDJnYmJBMEhZWVNiamFlb2xnVEZs?=
 =?utf-8?B?cE1KMWRQblMxWDQ1dHE4bE45anU5NkNodGJlcnJlRjBTVTVqc2xLNjg4QkEv?=
 =?utf-8?B?M0dYWlBNZGgxaFNPR1hkVk1wbVJxV3NmSGpDQnBxbVNQQmhRQ1k3b25Ca3Z3?=
 =?utf-8?B?N2IyL0ViNWN1S1Nqc2p6emlSQ1NrZm1WTTBQbThJd3hIaExDbE1nVExzR25v?=
 =?utf-8?B?THBRME84MzBpM0JiNmQ1bmRGVkZMNG9IV3lDaHF5QWZLMDJBWmZ5b3M1ZWlH?=
 =?utf-8?B?Z3pxQ2tjOEI3UzhnRnFBcTMzT284a0NLY2hWS1hHR2tKa3l1UG9WUG5CRjVS?=
 =?utf-8?B?SXlLdTM3dGR1VUpJUnQ5K05NYVB3OVNCaW8wcDhyck1OVXk1clI5d3BvMGFs?=
 =?utf-8?B?YVBXT0lYVno0bmsxUjVCUUNaY1lZdWdYeWh6YURmU3dibUNLb25PbEhySThx?=
 =?utf-8?B?OG42MnFjWGNFUE9CWUIxVlpJcVpXYmMxOE04UGJzN3FHZjBMRnVWY0hkbDVo?=
 =?utf-8?B?Z0ZTb1psUlBhd2pwb1ZtTGNsTlhwRlBxNXZ0WjdpeTQzSTJwS3V4Y3JJMVlC?=
 =?utf-8?B?UUJNUGRic1Y4ZHRkUlhhcmNYTExUeWtpMThtYS9CMWVORkFFWU1WVWhzVy90?=
 =?utf-8?B?TzdyK21yejBHWENCeW15czc3MHpJSEVEcW5pWldZeVV3NzdRdkJhaXprem5N?=
 =?utf-8?B?c1FPMC9teUZQbnl4US9WTjVGV0pGeSs4d3ljVkFqcUl1TXFJZXJ4TlFrcjVx?=
 =?utf-8?B?VDFQUVZCYkdTR3JJL3JpSThsa1BsZjJLczhCdXpxc3BCRjY5VUJZYVh5YW05?=
 =?utf-8?B?aXN4WTdDZ3dKdEhDMWFzVzBxaWtpMmd6M2tlb2JxeVNMTHI3WklZMmZsQkJ4?=
 =?utf-8?B?elFrUnNQTEp4SDdBREFGdkZoRmtVMktMUlBXVklTelhYV21aSzRrQUl1MDZy?=
 =?utf-8?B?Uk1ybEpBY2g0ejAzaEY4dXpFYWJBTGJ0bStsWWRlUktnMmpyYkJ1aG43M2F5?=
 =?utf-8?B?dmIzTXI0TnlVNVN6UE9UM0N0NHd5SVlFaVo4d1BuMStmVmw2YXFlVlZEemdn?=
 =?utf-8?B?KzJaUFFyU01FY1lXZ0J3c05zSGc4bzlqVGZ6b0QrK0xJYjZxSXF4bmNlSWJ6?=
 =?utf-8?B?ckM4MzhpT0R3NzFNUU5NdnlJeFVFenNPVEVSNnJsOW5EdXZMYmhldjlwYk05?=
 =?utf-8?B?TUp2NVNUeHQ1YU1SUmxJQVpGd3VlZ0w4WCtqaUx5RThBeE5LaDN1dXhPZjJP?=
 =?utf-8?B?a3d5SlVHaFFacUdoTGZwV2JBcktrdEEzZmR4REdIeThWalFhNjJRc3Y1Ylg0?=
 =?utf-8?B?YWNWYWVnMG9SRnZFUGNUZk4vWkM4NzQzNzAwY1FhaXRyaGltSzZQL0M3dmdE?=
 =?utf-8?B?b1pUNFFTYnhHWlV1aW1SRGExdG8xVlBlcTU2SG1lY3FIM2NWNjlQQnBuY2xa?=
 =?utf-8?B?bTRLc0lpVk14b2hxaXU5RlY1enhRLzJ5bjNydmFRd1l5TndhNm8xZEVuOHA2?=
 =?utf-8?B?RzU2ZE8yK0dDOHF2cTkzNGtsNGdBbVIwVTNjRFAvTUc5TUpBY21BUFZXa2NM?=
 =?utf-8?B?eVVsNGw1a0R1VWZRc05oOEkvL05uTkV0TS9IVjc4eTgzYnBST2thTldFMkV4?=
 =?utf-8?B?NUZEUTRmWHlzMFBvM3ZPWFFPUldsSEd0b0w3anc0aHpEcjkwcTh1K0tSQk9L?=
 =?utf-8?B?UUdISGhMWUZLK000YnE5WlMwU0Q1N3RLWFpuejNsQURQaGF5T0lmZ2E4eG05?=
 =?utf-8?B?eldOUmdIbE9xOXdCVUJieHpYRGRvaXkzeTdZa3VXMEZrUDJibE5GM1ZBRnlI?=
 =?utf-8?B?Y2tVdnZQZU5OQjF5TFB0NTNqNVpOdHFRZTdPYytPbFFQSnpFSmxReUtGQWlp?=
 =?utf-8?B?MEtiZEhQamdlZnZJRWluRU5oNmc3MEJ6ZjhQMVJtWHZOUTNWOW1JQ0wrckdN?=
 =?utf-8?Q?c5comHqHxjbSkkHEcHJ+zeQqg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67f7685-a710-461e-e2b1-08da9a3cb0ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:44:28.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVyUeLLiQZFbzm9ukjADuOab+9ocUrpjtqebtC1EiDK5+R3BwkWRSQW8o50M+o/GjU//Ug6Yu0/pEWIK8EeoDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190086
X-Proofpoint-GUID: K4wOfrXUqK1bHnFc6vCEz9w-qwugAyUQ
X-Proofpoint-ORIG-GUID: K4wOfrXUqK1bHnFc6vCEz9w-qwugAyUQ
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/15/22 01:18, Josef Bacik wrote:
> This is fs wide information, move it out of ctree.h into fs.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



