Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC3B51F29E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 04:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiEICUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 May 2022 22:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiEICUG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 May 2022 22:20:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFA4D9F9
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 19:16:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2490cxZw010450;
        Mon, 9 May 2022 02:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/6TreNvUVX4PuqZibRcIihqnPCq7m4+W1wFzS+rlW3Y=;
 b=t8CLOb/EZQIo2t+jSzD2jXvr5huqd5JGpmh15U2KR14DrPeQMnuInxRezlv2XHMAjbyn
 VfVrqGi0aZ2iBPRLnxcnljx21+9f1YFF30OlKidOGXmblbFP2ujtrqqhYbP+nS2yeG3z
 DdYRZEyxQKOE2giSV6FqW5y+ZmX2uGtAalBGcnGO1PhcC/cLpB6BVjcsePDCzww65KOH
 Kg3it+nP1IryCrIh1wouP7Aj4U69cyAnpKt1eaSzethGesHX3A52xcZCWXitfkng4x6e
 Opo49q7LbqDdDlAgPd7Z9Z2f0/Fw7Gl7kZQes4vWXx9tN+VTE+ZbNaJgjLNaqtqXox0A YQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6c25ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 02:16:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2492BtTY029555;
        Mon, 9 May 2022 02:16:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf77jkty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 02:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu2NcQET5Cwf1HfA3t4sdNUA6CihPHo4VP1JCPiVfueJPTzNlazhR2MhkVESCktoVMKuyGBR25lVgRIr3HgoBuJeV3202SNhzW4dCAaKoANyOHCZEbIIJmb+k43MJrie7i9MyZui4Uhi2zBhMwzy5FUwkSuUSD/7L8jfpFqA72ljJLqAdqmlSvQHcunLnPYoihws9c4UODf79mX1LrU71aKq3pnTiNY3unEGkbwmoKcMWhlwpnLmdZlRPtKBcVCCIf0EzfKzYQeQYj8DzxSpW+Zbbl8d0b3kibM/rGM6awElbhBOoPCapfPWO80emFO4Ombetx/JiRzggpn1t4GS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6TreNvUVX4PuqZibRcIihqnPCq7m4+W1wFzS+rlW3Y=;
 b=f2W561V4mBVjeCCU9ES+ptK+UFErzXZri8IoFUKSac2icLjO7huUNlTsmxn6O44QP5CUZx4jVHtrLsen2PBFQdImmfoYq6oq7ecRHUpjdGODrQ0N89CqnLk7TT+Oc0o4uuG3CXMbMBaV9NZ+bw2PEtHcqCF84dKmChqHbP89zZwadTzIPJoKSsuzNbJ0jDCCKLVWv4UyP5Dvs1kiyOX9Z+fJ2IZqem2wmN3zWrZCklvsLJc+1sp5kSPU8rvcLTteqCZy+nYLIYL1tuufnJTM/AYrdyWRMUoGvs/85exBBBA3l9EN/rSR4cFpaURCY+3y97zN3PWFPG2+v8r5AWRxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6TreNvUVX4PuqZibRcIihqnPCq7m4+W1wFzS+rlW3Y=;
 b=y6NCh3y0YnxjunzFFwoTa0mrmPcB6HjOj5xu4BU+XpMyM588apwEYcJK7J3BNkpSeMWRdzy4mWjlqgRP4TYh7L1JsmMfXD22UEghoNfgH0VuTGCZe62CNTukm5eyNorKqow9afljWx2FX6fCfKkNS+cLB7eufq7Tgtn1AX35/M4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BYAPR10MB2454.namprd10.prod.outlook.com (2603:10b6:a02:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 02:16:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%8]) with mapi id 15.20.5227.018; Mon, 9 May 2022
 02:16:06 +0000
Message-ID: <981a54b2-884e-0426-22e7-f8a332d7b331@oracle.com>
Date:   Mon, 9 May 2022 07:45:55 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: allow defrag to convert inline extents to regular
 extents
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <c26d8d377147d3a80e352ee31e432591c28e3f4b.1651905487.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c26d8d377147d3a80e352ee31e432591c28e3f4b.1651905487.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::35) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d7d0599-8e22-43e4-a0ee-08da3161dfb3
X-MS-TrafficTypeDiagnostic: BYAPR10MB2454:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB24541D98C74CB4EA6734BABDE5C69@BYAPR10MB2454.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCoFu+e/coQDq/yCFX+25mQMKRiXe8uk8CQAdfGnAlizuR4/R3kTlvciRNeTWvWV4OrH59UYwzRnuvw8JFkgAHZOawWG9UpaGPQ/k2ll5leD/Ec7MdxS+2C1iQLV9jeDK5Y8A0F4SToSnd9budj7LtMm+MIm4cr0xU+SqQNx/eQkAFu3Pcg3vGWYljyMd9/dbW48ZW4iYj0dcOVmMey4QdZgsc53CTEfglZyCCcu9tXMChPixO4POuehG8wB01A81cu+C/8Eh3AzJoP1Bg8laFNIifRV5+8Cn1yq9oIuGcFJm/IpCVB5XTo8ILXnKdn9bldIzD5KgkAFBLr8rVx1qNR6lio91KCbgiMf002tTsGLTWE84WiZriDv8ExVvnZPpuNpF/8UbOZnqrYH/6/WjYzAeaYC5z4K8DUKOLeExx4e4JfB6ILSQH4QZRrWBWAxvs/0PAvS+0C/9s1WqaG6KOnaYRT40XtiyaRYU0Yf24vQhpsN/MdYQD7zPPMYWolxQlXRjq/HN/QLS6wQFD+XAtjrcO/No2BLnFuRDuoLDAj6UomFlbVynjjBMvaLnfh81mNjTtPswuNZcQUVVcXlwt5cJJHKqePEys8XkL6zXqhBPOvL/D7YTf9Ln6styJPs/vNkv1NbjCZhUxTcyCJMrnShKY/Xdh1l66VolMKYG8oaTfikCeeYN2tBsgqEViaNJYj3OYHAMyUi+5PDSaKcw4uYkxMSNbyHSBOc51n9sV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2616005)(5660300002)(53546011)(36756003)(6506007)(83380400001)(31686004)(8936002)(6512007)(6666004)(508600001)(66946007)(66556008)(6486002)(66476007)(44832011)(316002)(8676002)(31696002)(2906002)(186003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nkx0TmpodG1iWkhQSXRKdFFCcGE0WVBETUhIL051WkVhcWRkWi9qa0tyZFdS?=
 =?utf-8?B?UXZ6VXRtdC9zR3VEd1ZuVWhEcDRLeFNxWXBYWEV3K3VMUUNNOTUwUzRxSlFM?=
 =?utf-8?B?QkFWNU9rWFVDeDVQV2NXcFdqUnFxRzlveTUvSFhxTVYxeEVKOWpEeGxJdUF1?=
 =?utf-8?B?QVJpVWdEZWsvVkxJR0R0ajdNTzV3bVI2Rk5HSXpSQUppUHpaaXRsWFFmVVpn?=
 =?utf-8?B?aXVMTmlCNTJyNDRFSVRjMk9qZVh0aU1jOXNuSUtWQWJCcno4SHpBYmc3U1Fp?=
 =?utf-8?B?QWFKOHhCcWNicVVaOXcvYjJSZ3B3TnMvcGFSMXV4LzNBN3g3czVwejJqNDJh?=
 =?utf-8?B?M1o5OVVsUzZYZTFaSDQ3RHIzVUdYTEx5SG93RzlnSWJpZ3ZQLzA0dDdORjI3?=
 =?utf-8?B?cVNxNm5vZHhyOEY4dEVEZmtZNExVc3ZXckZSU1djRS9IdXplUFdMRlF0YlN2?=
 =?utf-8?B?TzY5cEp6d3c4VUJ0R2FXcnhrT0t1bzRjNmFhSHJTM05IMHJxS2xCLzV0YkFm?=
 =?utf-8?B?bkhhNG9tdWFkZ3k1TnJ0L0l1cTlESi9wNHNoeEN0NmZOMnZ2bitESmt5SzF2?=
 =?utf-8?B?TXVWS3gvdGtYcXlpcTRyRHZscStpL254K25hSiswMm16NTJaWDZnZDFRVzY0?=
 =?utf-8?B?cEZ5cXpaQVoxTXhhQVBXUWd1K1ZObllmVUFKNjFDTnFiMHpTeDkwaE1YTVNM?=
 =?utf-8?B?cHV0cmE1bTl4WkVNMlhaWmx5bVBMK2NlTEEvOC93dkZ4Tkd0QnMyajZPb1dF?=
 =?utf-8?B?azVCQzdpUXhZMlJlVVF2dWxqNG1KU3lPY0xkRFdpWnJkYVRUOGhlQVR6Y2ZQ?=
 =?utf-8?B?VGRTNFBkWFFiSWZzNDMycDU5eGZoalRuQmU5aWZQSXhjOXR1UC93dDFNdHZn?=
 =?utf-8?B?Wm8xQ1N5MnZHYjIwUU9OakhmWVFXanRUSHRQc1ZIUjBOQkRUeWJaQkNJZ2hP?=
 =?utf-8?B?NjBVZU5LRThOdFRiMG5JQmNuREsxcVdSRk9zc0d3K1dxZkcrU2owa3ZvakRi?=
 =?utf-8?B?NUlHdTZBV2c5MzVaMXNkY3FNTUQvSVp4bUYxczU1RkZQbWcrNjFVb3FJT0py?=
 =?utf-8?B?UVNCcFRLV0NRTk14WE5FMlVMYWxUT202L2poYTFtU1RiSTNwZjRmT2xlcDBh?=
 =?utf-8?B?TFV5SnlFZkZLQWdDb2hMamt6TDJaQjduZzFXUnVpcDhnNVQrZmhhSVoyUkQw?=
 =?utf-8?B?T0FLM0ZNVWFoN1JMODhrdmdvUDhPUkZJd0FVMlZUOWxJNEF6WU5CQzMxOC9r?=
 =?utf-8?B?WDNYSXoyMzk5SjFJQjl2SGdRY1h0SlRHcU9GWlFkT0VKQ0JZa2tEdE9oZjEx?=
 =?utf-8?B?NFJPSkdQako5MXNrSnc2NWlVRE1IUyszbWNCaUlhbmhKckcvYVN4VEUzRGt1?=
 =?utf-8?B?dDROd1h2ZkJvZDhSdk1SUUNUWXBteVpoRTRiSnhwSW9BVjEzY3d1NjJ5NllI?=
 =?utf-8?B?OGhBcVdLUFJNZ01DWG1qUjhBVU90UlRPZEdSZnNtN3FGUmhrYmNjcWpJYk9M?=
 =?utf-8?B?VjE3Y1Bydys1bHlXWHpYSUVyZ1VhMlpjaUczZEQydEF1enVHOCtXeFZDc2x6?=
 =?utf-8?B?dC90MjJsL3Z1MHpTbHpMMnBGUjYvenBGMjlwTVY5SUpJMUNzU1k5S3BEY01P?=
 =?utf-8?B?WXNKSzFROGpHWFlsbXFWY1poSzBNRlp4NGJnZEhzSmJOQlBzQTJxaVo1TklT?=
 =?utf-8?B?V1lnem5JaFJEUWs5L2ZLTko4TDlpKzhGWXc2V1hzK2ZqenVlMExWTjZTUXdT?=
 =?utf-8?B?aDhXZ0tzOWs5Qm84N3ZCZko1OWNqbUV0a3Z5MmJsYzEyckQ1SEJRb3kwd0VY?=
 =?utf-8?B?UkI5VS9TS0ZtTHRFbThsdFR6OEFpRUV0dmNrc1hKejFMK0x4RVkxWFJhREVq?=
 =?utf-8?B?MzRIN0ZmbG55dG5jT2J5bjFpVjRvVzZyK0F5bmx6VUN2ajdaZFZVRElQeFUy?=
 =?utf-8?B?aVJHK082NmFZQXRYVm8zU3BsMkxhVWhaWHhJODRveDNWRDkrM1RPR2VUSWEx?=
 =?utf-8?B?SDhvellrd3lRZHg5UU1UK0RJTExEZ2ZHcllJTG1teDJ1VUhSMFo2QTdFSVVr?=
 =?utf-8?B?SnpDQTdoam1LWi9iWHVuaElMc0gvK3VNTUd2V2lnY2UwcEt4bmJ6MnFsSWt3?=
 =?utf-8?B?Q1duMy9xU2s3Uy9ibEszait0U2hnb1UrcXFsUVk1SmFFemNPMWczdUxxWkR1?=
 =?utf-8?B?amVDRFFmcEJ0YlZDNDM1ejJWMnAwa2lKalhDYTBxcnFtR04rN1lndzloTGdN?=
 =?utf-8?B?enlVRFVrZ3NKNDZDSER5dW50dHRtbWJYR3IxWjBwZXZWb3hBU2JTNCswR09N?=
 =?utf-8?B?eTB1NE9pMmdSSSttSWd6NnVpc3NGY2RXQXBGVnpqMGtGdnNJeUJpMlpjNTRy?=
 =?utf-8?Q?MfFhnexOMtYKBDLGBuWRQZ1wB5dC26is0CST7WdtdaqW4?=
X-MS-Exchange-AntiSpam-MessageData-1: VPwtYlDga4AsShUvEIxHC3C2Hzy49aRdNq8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7d0599-8e22-43e4-a0ee-08da3161dfb3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 02:16:06.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJNQN7hgwHVQrQ0PX1RihXfVjpBYObPRzh/QMX70v7AqrmMjLPyKN41s5WqZUM9DcKEYHSC0sj7h3gmlGot9tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2454
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_09:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090010
X-Proofpoint-ORIG-GUID: lGIDx_BbkUzRdEBp5muulgLLuUflzccm
X-Proofpoint-GUID: lGIDx_BbkUzRdEBp5muulgLLuUflzccm
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/7/22 12:09, Qu Wenruo wrote:
> Btrfs defaults to max_inline=2K to make small writes inlined into
> metadata.
> 
> The default value is always a win, as even DUP/RAID1/RAID10 doubles the
> metadata usage, it should still cause less physical space used compared
> to a 4K regular extents.
> 
> But since the introduce of RAID1C3 and RAID1C4 it's no longer the case,
> users may find inlined extents causing too much space wasted, and want
> to convert those inlined extents back to regular extents.
> 
> Unfortunately defrag will unconditionally skip all inline extents, no
> matter if the user is trying to converting them back to regular extents.
> 
> So this patch will add a small exception for defrag_collect_targets() to
> allow defragging inline extents, if and only if the inlined extents are
> larger than max_inline, allowing users to convert them to regular ones.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ioctl.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9d8e46815ee4..852c49565ab2 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1420,8 +1420,19 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>   		if (!em)
>   			break;
>   
> -		/* Skip hole/inline/preallocated extents */
> -		if (em->block_start >= EXTENT_MAP_LAST_BYTE ||
> +		/*
> +		 * If the file extent is an inlined one, we may still want to
> +		 * defrag it (fallthrough) if it will cause a regular extent.
> +		 * This is for users who want to convert inline extents to
> +		 * regular ones through max_inline= mount option.
> +		 */
> +		if (em->block_start == EXTENT_MAP_INLINE &&
> +		    em->len <= inode->root->fs_info->max_inline)
> +			goto next;
> +
> +		/* Skip hole/delalloc/preallocated extents */
> +		if (em->block_start == EXTENT_MAP_HOLE ||
> +		    em->block_start == EXTENT_MAP_DELALLOC ||
>   		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>   			goto next;
>   
> @@ -1480,6 +1491,15 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>   		if (em->len >= get_extent_max_capacity(em))
>   			goto next;
>   


> +		/*
> +		 * For inline extent it should be the first extent and it
> +		 * should not have a next extent.
> +		 * If the inlined extent passed all above checks, just add it
> +		 * for defrag, and be converted to regular extents.
> +		 */
> +		if (em->block_start == EXTENT_MAP_INLINE)
> +			goto add;
> +
>   		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
>   						extent_thresh, newer_than, locked);
>   		if (!next_mergeable) {
Why not also let the inline extent have the next_mergeable checked?
So the new regular extent will defrag. No?

-Anand
