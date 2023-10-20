Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851167D05EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 02:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346799AbjJTAoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 20:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346767AbjJTAoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 20:44:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9E611F;
        Thu, 19 Oct 2023 17:43:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKuT7P011471;
        Fri, 20 Oct 2023 00:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8OdtmPlazHnpRHndsJ+a3x77kjLaV+MUYhJYuBppgaY=;
 b=BSkydxal5vQBgR4SitoYjpT/5EgYKakPeh46x0UfYuoAdSi2qUkEXXQoK9eMts18DHlc
 4uRorBcmm5+dy9Vb/yBF7T/3koS4iGsCrCNNZxV+qnmZglHtTMkaP4T0LFhyc4moZlBX
 zfI2tTL70DC/9zy4dL2WObHGqVRRqjjxClHoYQRZBGMD0M32Z7V7vbEY3RcQ+H+7Bz5X
 fIQpq6KiDjgrdhC0eUV1r19gdN1ZilUR90gyo51gins3aZW3p6KWy7PwqcsSjog9aXEX
 SaegDr/M9FVqEkEfdJ0FTpHQBHmFM6oSSg67T1qOsn0JJMqtIDdhAYjQO/t26eYxSZ8F KQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubw807tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 00:43:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39JNUFoB014114;
        Fri, 20 Oct 2023 00:43:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tubwep6g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 00:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy2AvP9GTTXGFSQbyUXQA2sJZO2v+vtpr6BUT5OklR3sBsE3RWQe0g9jq+Bu8t7y5LgmBh0zbIQndTkLVhD6146zUxQ9esmc2MSBz0ymsfi2hZwY8yb9ZDpIg82suYs3QzGTTGzdgW2NvgvhiSWYjnJwElhyeEgffHei0dKUnLrUj7KjP1kvAbcAbI/Iu6fsyDsbNRBgGTji8zBsKh3GrCmCnLR4lh56Cyp5KDy7murTIn4TMRumvEnty9UYCc+QFcxXbwJQ90z2IH4s1OnX1Pi1v4MZHZveFL6C0BciASUaF63btOTyrdwkneAJPmEVyDh3bRYRoZbXkU5EVGG9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OdtmPlazHnpRHndsJ+a3x77kjLaV+MUYhJYuBppgaY=;
 b=FIJzJR4uijC1kgm4WYYcpOz9wQqQHEz9YQPd8v8x/lcRbKGhINRjhlgAT683Z0SyHa4TcBNrXA8UMqDtPEd2hvkvxrUjvyq3T+2Awngje8uHu1wjYESfzetjEm193uPvKZc29oVqRlp9HCCdDlvfTTR8+iPb8ipjH7ZdIimVmZT3W9eBNUyT4TCb58CimTkm+9EgO9Y9XNmFEriuRFNgyHxGuQieEGrnNJAnUmAwjs08H29Rcd05MDH0cvIyVpwUfW32CvMOW02Ea3bkaCJqwAzzx8hKnyMJ/AWleqbU/HJyFAUit084tBbNOIfoBSrGhMmMAXANsUsf9Fve1z8T9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OdtmPlazHnpRHndsJ+a3x77kjLaV+MUYhJYuBppgaY=;
 b=oLfcr29pUKXu4mCJP5ZuvXDKl/bKDSJi7YTiVSu8KAoMLyipQ3Rmyrd2WmDLosxXIFQ8T7JS2t7ZlKuy/26XYlu8b17pHhWt67Y24zYuAGsJln/LdXAqsAUyn0x+SipXe2jYNpW3xXGa4MfKXMNXXSAqTVaBeGiuUsIIPOPIwBY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6953.namprd10.prod.outlook.com (2603:10b6:806:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 00:43:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 00:43:44 +0000
Message-ID: <aa0d6706-377f-445a-87b3-fbbbd3803da1@oracle.com>
Date:   Fri, 20 Oct 2023 06:13:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/298: fix failure when added device supports trim
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        fdmanana@kernel.org
References: <ee1d17b6f4956c0638cb7faa6f9c92b7bf3c25ac.1697709904.git.fdmanana@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ee1d17b6f4956c0638cb7faa6f9c92b7bf3c25ac.1697709904.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 63567da1-ac8e-49f7-b582-08dbd1059cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFg/gOCmBItMWxR4zpENkR3sxz2OOMgewm3KddDXSgMtjlX4H2FK/Y4SJsT0FhuTxwAHwFcA+B6mJz2z/Bw/juBEioLMQ3jkqWBkhVSld83l64DqukinTCkppgn49SZ/47Jmltu6EyzhdJZL9sMA5efF6AgtKuqu++Ddv5z40yId8AyXUoCIdhrPoscjwPPkHVgQU9HnE+OzUlW8I0tMeDK+/Udulx2A257KDiJmLx1/QObIhydo6UyctwX9/9+7DTVFxKevEvLPwWljv+qgiIQVx+4Y1o0aJ8hqa1jamF3f3O+pnmLyyUd6ojnZhmuPjZeCL7UCic0yfej4vvRmfbHfRb4oHRL3Kjar8kr5xXjJbE+EvFJIga027bmf03ByEjGmvZ13w5DTy3iyV/3DSDsrUjv+VxwZWfdnW1qvVi5ZK/13HY+7xA8+Q/vdGdL2vubaRXYM86oFiGBBZXRbZMxXt5v2OFEJyEbM5ilvOozCGLFR/Ya4keOARzRRQtLIYhZEvnKr7qMfxNMWskirhJLr8ffw7X3gtHUP42mHhUVc54YLwhA5z3/fZqIAIcHjnbr90klJfbp6Ak7lcBGAAV+36kXAYtXActt9Dy+YWAWzKPDD2KL6BkHyIOvHDPVIuN5jd2jsGedRETZwynXDtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(86362001)(2906002)(19618925003)(31696002)(4326008)(41300700001)(66946007)(8676002)(44832011)(36756003)(6916009)(8936002)(66476007)(316002)(558084003)(2616005)(5660300002)(66556008)(4270600006)(6506007)(6512007)(38100700002)(6666004)(31686004)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFRxYmJHZ3VSQ0hmSDlET01BeFNSTVN4V2ZzREJOTmdBblRGWXpZam5TMlll?=
 =?utf-8?B?Wm41OVRqNFdMTEtOZ1JPeG40amJTQTVZamtyT1lVVUUxQ2VCcXM2MGNvd2VU?=
 =?utf-8?B?aGJwSHUrMUFpTExDZ3pFam8rTXlOSzZRK0JNNVdnaWJLZFlzM1pleEFuZXkz?=
 =?utf-8?B?cU9FV2FzTGVyVWhxNDU5WlExenNjSGVFdGdXT1FXUFE0RjlmRlZBTEZIQ3pl?=
 =?utf-8?B?MGdibkE4MWxGUEYzb1VZc0xEbUNHSzgvbjFsVkVSQ3h0SWV2OHFJa0ExT29M?=
 =?utf-8?B?RGR5NU9IQ1ZCQVhOUTdReldTdlQyVUxhTm5RT2trc3FWbnpZaElhZFFrL3ND?=
 =?utf-8?B?VmdBQmo3ZERuVUJ4NnhKZThMRTZFZXBUc0kwMmxlR1ArRDFBa2pUdXhhby9q?=
 =?utf-8?B?cXdQVjRTR1lsME1JMC9mTVhKUERrRjFseEV2MUxQSDRtVGJPTUExaDNtTXdq?=
 =?utf-8?B?RnJiS0lRTlQ0Vm1kNzJjeFNXaVB6T3pTeEVKdVNqbCtkdGpZVEdKWHhhWDRQ?=
 =?utf-8?B?RG1xTHVzbXFaTjd2VFVlTk9rQWZkc1c1OW4rQTR1UGVQNW9UdXlPK2podkN5?=
 =?utf-8?B?ajJHczJROW5GUDRlTEJzUVNrNlpNVVRpN1BMeUwvUFJaTkk0NEkwSEI2dExt?=
 =?utf-8?B?MDhmenRiNnpFeXluYTJnV2ExYlA2b21uTTQvNVpFRkhzdFZNM09iV09hdGpY?=
 =?utf-8?B?R2tLUFc4UUw5VlhtaHloaDRVemRqUHVPS0UwTnFYMHZ1TXpRalhzYkJZbzRF?=
 =?utf-8?B?Y1pMY0pJb0tINGVPRnAxWkRma25XODlZc2RWd08rVCt4ODN6aTVxRUxZUkgr?=
 =?utf-8?B?MHNnbTVRaXA2dnoraytFaVVGNmdVMVdFVXBTNFFSMWhwSHVXUGJYV3JTTk1C?=
 =?utf-8?B?TWhmdk5FelBXMnhwSlVXd0hHZEZUWkFXSjBGQTVrd3I4elhLSnNNOHNXMGpM?=
 =?utf-8?B?K2p2R29Wcm9vSUkxVERTM2pXWkx1K2loUXdhOWN4UG9lMjlnOG5tWUFMM21J?=
 =?utf-8?B?aEI1VVBvTnR0emF5eFhEQ2VpR1JacTBEYXBGZTNBRmxwRFFsZ2hrM2lrZW9G?=
 =?utf-8?B?elhLaDFsZFFyb1NQMUl6WXZZSUQvTHNjamJRTzl0NEJVL0xQeW10VHVBWlJp?=
 =?utf-8?B?anVVOC9xbkVsZldqckVOY09lUzNWenM0WktZalpETTlMMHVJaXBYVmlHT1hW?=
 =?utf-8?B?Z3o4eDFQL1lTb0dYa3ZTb2dQQ0FkNWpKeGJZTitTMFBTRno1YktSWWZ6b1J2?=
 =?utf-8?B?VHN2TmNsS0ZWNHBQV2RDZlpLcVdTVGY4UHBTRkVnQ2ljb01JZmNKT2o3aFpj?=
 =?utf-8?B?eGpZVm43cE9mQUdCNHgyS0M2TGdIaDN0d3BIZlRtcmtRdWdTQnkwTDg3VXpi?=
 =?utf-8?B?MEhzOVd5WXdZRmV3Y3NEUS9IV2NML1VsRjR6TDVHdVYxQ3d6ZnBBR1hlelll?=
 =?utf-8?B?NERPM3FTbTF5K1BNTG91YWpxMndxcEFlY0FwNjREWG00RWZwRENlb2F1amlm?=
 =?utf-8?B?ekUvVElobDhBMkI0MlhhR2x3V3JYVGtWWndFVnVQUGFoT05hT3hkSEN3YmV6?=
 =?utf-8?B?RTgyOW93dnZkSnRHTmVaZzQ5aDJ0bzEzYUVtSXdDNE55dGxnL2txdXlGeG01?=
 =?utf-8?B?aWZuUFloTldqTFcraVFVUG01QnBranRES3AwSzlSaUhCY0plY3ExL3llNmpq?=
 =?utf-8?B?bUorVmpyTUc4dDlaUzlHZ2Q2YzNHL29YZ2VndmFkZHJTdVVqL0k1OSsvZlZk?=
 =?utf-8?B?ckxzaWtNNGI1SjErY2ZWL1ZJRnlWWDJlZWIrbGFBWFBMYUNwZlZrVHBBTGJH?=
 =?utf-8?B?QTg4NGFTbWJONzdHYytoL2RjREI0ZThXcHdQNklpam0zYy9kay9BSkhxWmdK?=
 =?utf-8?B?R2VLeHhZRmVOZjcwb3E4cjZIQ1ZTMVRGaFNqemJpaWdpV1RqckloeHRzbFY2?=
 =?utf-8?B?TG9tUUZreE05aUxGOEovZlRVczhrWWd6Ym5DaTVVM2hwZVpmeUxWK0tjWFNu?=
 =?utf-8?B?SDNDa2NLalY5QW96VEhXNTVvTDVwdXV0bU5DTDdwcHlGcEVIbkY0TkdxNlJR?=
 =?utf-8?B?S2RuMTJGWDI5Ukl3K2FhcjNJV1NRMHV6RFJEelpSekJFUEs4U293RlFucHJI?=
 =?utf-8?B?SWdWWm4xVWtOc0tzSGY0N3pjR3I1WDBzMWlzVXJrUEVDQ1ZnNXg5SEFiOWh4?=
 =?utf-8?Q?TaCuuEjxXVOfsad/kxJhs0uWkjj3wgTyCXk7Dd6hIjG1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3HeBgBsuhZaF5FPZVLaKTfCBpy11C4x67Pu93Y4ObQtqOIlXSOWJcfU4MhmM74QsRzh94BAISiFWcj1vLIyVmw8dBm6Rfw6ab/8DcM3Q7tRh0/ne2ecjVXqqiOWPaceOtcXXEMoidtUhzDQIJtb6nxQRbl1FRDI/EqmVkE0O+1pSGwZHDPnH+6W5H2Fq5tiqc1vQK1lXkQkkfWjwVrXjJ4gjfkSJKcyxbgCOxf9aG0vpZTkDp5n7qSWO6a6REiE//ZIRT3MJ4UUJmNgee+JxeK/URVanq+nDWgh27KLfZW0qmUdzDlaf530iT8DAewUvG4ftiEdVkUNE2bZ5IZTNqFVEvBt1P3qJ9Zc5Whz2dgt9k6TUynQTrdX/JdB993X+bICXsrhX8ZIn7GT0Cjkv/avR1oqsPx4QonBGnCDsJGK+35dYVb59M2Npvne4K5wEhpmOklc4Sn3tp8HFcPF6fqHP143Z2C+ZRMJrMuZnf3U5ueH1hDTvehtBt7LzlGwG+svdjkN6hHOBAXX07g/nOwiS8X4qYPMi32G0nlR6nTb6AatzuTfztHBQ5w8PjV2e6z2w/rq+t16v4M/BbetXWAdTyUsKj/850sCKV4SEUjrBxIPpivZfserV4XRn979uJO14VYjbCoyqX3CSR1FRO+sNrhPyy5LQ81XpXvh3iXWrKR5HMnWeKe7ynLLyRPyWIcChIaeSERj+cpArIYkHEkuiVkROqJTOkCAMkez8sPWAmiRbcJahBvPwBJLtx5KKI+VYzE6Hf+DA4B7mLcuMr/nVvC7NLg9nKmih71dWWz9zG/T3+cJrX7B9TUuWt7eb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63567da1-ac8e-49f7-b582-08dbd1059cb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 00:43:44.1805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1qJ2dEpiGZcfzJFuQzvbOW7pvOKmQKtVigz1wh4QlUwB+EYxlVdADlt566ueU80JxflkogvkyPYz7LujxNNAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_23,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200004
X-Proofpoint-GUID: Kh8PQJC3IzD8Pq3JR31pLRKo58TSVy7F
X-Proofpoint-ORIG-GUID: Kh8PQJC3IzD8Pq3JR31pLRKo58TSVy7F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM


Reviewed-by: Anand Jain <anand.jain@oracle.com>


