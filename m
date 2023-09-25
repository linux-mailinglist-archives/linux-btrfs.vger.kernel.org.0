Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C847AE2AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 01:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjIYX5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 19:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIYX5R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 19:57:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1695EFB
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 16:57:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNEO3J018796;
        Mon, 25 Sep 2023 23:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yUXna6bdPRlamYGxzY3CUgIgPL0waOFBwE1B/+y7C4w=;
 b=MoC2bXLA3d5vrYv0Fi5wYVhElvcLXOClfPKK0wSWJvrnMCMfqfie388xcU+ZB7cKDaSx
 XvZK0j4gvC1EUq5qbsKuHLoOFJXiLo4FoqG32jiSFv5mQpARe1jyMzLGbJr26KWdIeoE
 e9qLOqcIMuMSyGB1aFfnOJX2E//oMtu0q2W7rU3JTGAmciFay7rfxmuivdj+U0tQPfB+
 hqf3TStAzMflztcew5sKB/t3G/+sf93rY6BmUMpD4dQ0OpeOWRFmKL/iRff1yGNZxOxJ
 k4vvF7/LRDwduL2y9hUJmj+39VXAef7/uLWCxNtydP/DdaiK1TXD+qMsugG4VfetWqEp 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbd5sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:57:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PMgTLc030607;
        Mon, 25 Sep 2023 23:57:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf536k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:57:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF1orieuzlr4RB168VOgEJ2wn5pEPCdfIzrDa/PlifEULdPYwYrr53VubkHjyHbporXfOTpDcgSQ6Wetdg3ZAPyGm8PPeVza1FWr1rGFvDOaRK+Lc8Ifxn3v58MzjT95CGqD1QX+Ivr02+qaxMe1AXCErGZb0xG/lewW+PF+1HxC8VBUymQHqcRLlR2PCBfayuSf059VR2x6MA+uUcbMj5a3SmgngmiVb1ghPmk6vzJXsb3C8Hime2uBRJRGYpkMz8IZQnLQnbJIQmn0HS2T5b6nQ8ydQsohZZS+SMAay9LB/UMAWRMyKjLXnSZk5mAKI4FPAlG7C5ps7tQ7nYNy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUXna6bdPRlamYGxzY3CUgIgPL0waOFBwE1B/+y7C4w=;
 b=gTx12jzdQxCUpYchqIjF06+l9g1FqYW+4gurQzibjV/km+UE+zcbvACJu00Ck13shsl/qxpqE5x88PRt73ZxOL7gXiO27xVCf/g3LEke1sLIkhpXgSYS7EDHBKHoCTGQ6cMPos2eacZX+p2blvwXJOv7q9r9IVmSZ28w+Lo6Dk5TvefWpa+599SndCNcjqxCCP0TsNs4pHQt08/JFbEOr76WnKYvdM60g5UxHz6opQknHSFjt7gr8HmhEDAjnsTSk0z54MuqZNYjsZ1C6x7fGzlRwZaRQSuZpVHIo3udCLQwUZSqMyJYS6CZgvS+MRZNxlxX9sJtfVhvExMxE7gycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUXna6bdPRlamYGxzY3CUgIgPL0waOFBwE1B/+y7C4w=;
 b=IlPwVwEzv5MjsdHVVgxP4zidc5w8EGRo44RiOaTiuiTWAXoT7IGYC5qqzBSAxRQZ+atH0ez5gkUDShZcCExFpx2oIeJ/6ACEsSGZlZ5DPd/B5IJVEdqPkxITW5GxSAx/f4hUlq5dClfkDXlxQoQa6APpEXkazCK0UgEQdqFne9E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 23:57:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:57:04 +0000
Message-ID: <757517d8-2f79-4897-7d43-5c12fd6274bd@oracle.com>
Date:   Tue, 26 Sep 2023 07:56:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2 v2] btrfs: reject device with CHANGING_FSID_V2 flag
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695244296.git.anand.jain@oracle.com>
 <20230925165806.GR13697@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230925165806.GR13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b9a3b1-ae0a-40fc-cf64-08dbbe231e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymFERH5eHILyvvPS6w1GiXVnvvKxpVpVGB57rFzjcgoQ7Xie2sx9R/bNBGW5/lkl+rOnNs7UaI2IWQ8SXK5ARCblJPtPPJShQnyHQ7OXtvBWpSSqBBP+awM6sdX2uI8WGFWpgtSjQY96o4mswjACTbecD2M5/4rKN8ZrzutTUBRbNjq9nJ/moQLeWW7C02BN4kTs5kF5Gd2ouTCvB+LyS9Koedu5qzZCDQSPr9q2+UaArXMkD77l8+q+C95rUEQoqrl+aCI8N1loMJuoKnCO0aCJDWad6GySkf7h9J5vUaCf/fkPkDH5Pe7gErfpU7jRy+aUUhxI4gghkFCQBQc+8X0jKXo3EhNvYS3y5SfKkbL+QaDwLrk3EjfD6WFQV/TO55cBEToAxv6DBTys5+lOOEDqh3WWEyxs/tFMGBJf3K/+nWtdynYF7cVE4K0LDDqi9ivm80PMzrfVede3qGGZJO/vlcX3TaDgUePbrL0k3jIA89BQalEFaPWGfPBTySLrnw6MS6zO0Tnt5KwiozvKhStX0tl8SfVlpFA6muGpdFGr3eVTwfNyP+COlYH9LNmOEMgwkVMoh5dlxusN5krtAuBy16Z9JFMCx1Fm3cFgK6qrHkvmBnS2P0msiHO9IV+UHgCG5sicis2400tJch7LQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(1800799009)(451199024)(186009)(31686004)(53546011)(6666004)(6486002)(6506007)(38100700002)(86362001)(36756003)(2906002)(31696002)(44832011)(8676002)(66556008)(5660300002)(478600001)(41300700001)(83380400001)(966005)(2616005)(8936002)(6512007)(4326008)(66946007)(316002)(26005)(6916009)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3FPSmlScGxCUE8wU1hGRHIrQ3YyS1J6cDU2dUdHTXRZd0ozVXpIZ3IyZUl6?=
 =?utf-8?B?WDF1QW5QQUpYOG9EVkVYNTZsS3dRci9DUEduajVaYXFadkppSm91QVR4Z2xw?=
 =?utf-8?B?L2NKNjdXdlk1OWxJdU9lZ3NmWk12MjBkZXByRk55UXZzWlc0NzJsVlVEV2po?=
 =?utf-8?B?d2wrdUZhVExDb1EzVFlnU2RReEFheGVDeTdnaUJjUkk1WU9JY05WVlpQVEJY?=
 =?utf-8?B?SUhpSVVJU2IwYzBsMFp6WndpcXJDZXM1aXM0WmNwTkFjei9uam9xck44RURN?=
 =?utf-8?B?amw2b1hGM1NWSFdyWXpZaHg0Q1piSmFlZ0F2L0ZEZlYrN0Y4eU5ZeW9xVS8y?=
 =?utf-8?B?VDBkUm9Iam1RUnlKNTA5TFhXT09qQzhFYmZwWCtMS01kRk5QOFlQbWNZVVA5?=
 =?utf-8?B?VHdhTVNBemZHVFJYNUM1NUVxMW5nb1hock5jL1EzNzd0cGdHeEk5Y3VtREUz?=
 =?utf-8?B?SEZ0VEk5VGpVMUc3d1BtMlF4V0REbFdFbVdlenk1dnFnT2lzM2Q4aUlqR00x?=
 =?utf-8?B?MEozaXNEdkdjRExLWmZvQnpyQkFOVXdiMlNqeGZEYkRheW9NZUtwLyt5bW9D?=
 =?utf-8?B?QmtzUE5vY0pUOEhSbk9EckZVRW9tWWlDQ2dYRUZNT2tINkdLWUEvcWRmc3pi?=
 =?utf-8?B?ZHVybVNUaTh0WTR3Wmw5UGJhQ0ttQ29GOTFOTHNQV1ZoSy8yT2hiMEtFVkho?=
 =?utf-8?B?bzFWa2toZ2U0ditXTEEyd29vU2NFTCt6OVExYk1meVZPWExFVW5rU2tBYWo3?=
 =?utf-8?B?YWNlU1hQOGdtRVRmbmg4NWpPMGo3MDgzTTZzTlZiVTRtMTBjT0VObmJpZE9s?=
 =?utf-8?B?ZSs3T1hFQTNUTElrbERuR29oT3l1aSs1Szg3Wk9MaWtpY29obm5qMUtHaHho?=
 =?utf-8?B?eGJEUktUUmdrVXZVV28xY01IMjAzbWN5ckJ0c3RGcGg3cmowN2puZ2xtUExY?=
 =?utf-8?B?aFFVUEE4TzBHOC9uM0J4bmZVeHhDQ3QzcjJmR3lVU2orMlBnWDV0MC9GbWVU?=
 =?utf-8?B?Z2xGUDZ2V25acmFWQ1oxUHhBbldCSm43Wm9TRktKbHhMK0ZtbzNmY2FQVDdC?=
 =?utf-8?B?RFhPZGtpeGtoU2NzaEVPN0xKU21sV24yTVpndUFqOVlrL3ltRWxqandXYW9O?=
 =?utf-8?B?S28wK3hNeXhpSzkwd1lvVHVFOUlLQjJRQ3pyZFdxRkZLdGhWSFc3Rmt2S2N2?=
 =?utf-8?B?TjVPSFpJSVAvNFVwaHl1aHVjQjRzLzEzQmtyL2VxajB5UEx4MUU1YlU2b2VF?=
 =?utf-8?B?bzVYOGFzM2swMFBpUVpHVXJMUlhxZGh3SVhDN1ZlR0xYVWJTbUkyWTNTeGsz?=
 =?utf-8?B?T1JpcDhFdUwyNmFNUndpTkxCbEhDWUU3MXoxcHZBbTJQTmMrREdvbjd4Q0s4?=
 =?utf-8?B?dXRKNG9GaFFhb1BiOXlNUmE3SEROYm5KNXRBVkQvVTc4UHRUTlJQUy9kdGdn?=
 =?utf-8?B?em5qdzdBNjBUNzZlOVBTQ2crQ1gxZVM3OTM4UElubUxPR1JHT0tvZzgxS1o4?=
 =?utf-8?B?MUVnbWN1SXYwTkE3QmxVRzgrVktFZWZRMWtxeTZMMks1VDlmMUNGSVQ3MEhN?=
 =?utf-8?B?bkFRKzdnSzVNNHNJN0g1dDA4QkRua2k2RHgwTDFoNkh3N1NRdFF1WTFscEE1?=
 =?utf-8?B?UC8zWjFhTXBUMFVlTnkvVHZKd2FYbmViK0hlRmxJaExFR1JoUk1qa0Y5MUlH?=
 =?utf-8?B?bFZMUFZoUmdqMHJkYVM3NUZEZXNwWmhEV2h1YXZLRkJDZzV6ZmJHWE13YkxN?=
 =?utf-8?B?ZjViU0hTNXd3VHAyTzVuRHY1TEZTTzVPWmplS1g0SDJGZmM0RGVNamlCQmt4?=
 =?utf-8?B?VTlqYUlBQUVTQ2s3QWZxSTh3dWgyMjRteEJiZzZNNDJuUXdvVkluU0V0MXdD?=
 =?utf-8?B?ZEM1M1ZVY2tCeXVYVDZRSUh3UDFKRGdkUHR0a215R3I5T2Q5ckY2TVVHUXEx?=
 =?utf-8?B?eHFHRHZ6bm13V0IzNUNvdkRXaXFUS2RXT0J0S1VtUTF1MTBENkZtZmdSQy93?=
 =?utf-8?B?UGl4K3lyR0hzYU93S1U0RXNTMGtydGpZSkNOd3RIK1hER2xpQmlvQjVKQ2E2?=
 =?utf-8?B?N3BUWGI1bGR1eEZ1MThPUmNLSVozTkIzRkZTOGE4T0ZZanhESGdJSTRYOGNo?=
 =?utf-8?Q?WMBpxnGZj/LQqV4G5TK7w0Vq5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5VHnTrC7sWn048HS/Dd2r/wApoXyRexYW2r+y1WWLta/qONE1njnlJZBmk+b+1k7d4TP1mScXN4J8rLH4uuVy1rK/WxfnsM3GJFzWDmLU7+6uFULHw7i/1C2FCY0SIga1YiDxi/3dPbe2L/y1fRBH/eCu5DDEJSrDP4GG5hbQ+94EZSXQcCsgUK8gPp6aOWAahKlwGcqMM/CDimFE5+O/E9771Z1DXghdiCi842AkP71XPt5CBPFIecXKZH5ahOMY2YCM7COotwYdhfQ5zWO/6ZU3dWpyff0WlcaPD51yTSIBqb/EjcNE7fiEww4YSC+CwDcRzcFb0dWlS4EzS8VD/VbQm/f16dOTuNy5mRKU33NmbuqwlqBK+ZWK/Or9nuGLizKXDf7bAj1tveyYj8+G7gdRPvxd+ZTsmylsm2TPOrbGUBIrwpJyRtVNMdfQtlTYumOjagg96+CLpSqVo6xbjg95H/ChYVms4tRk6tQYE+oaOmQ/joMUMx+BXszIjHBuZmReSNKU1SIhIcQ9H/c6SRmY0CSx5bxUf3958P5llk+ioL+TaC2jAzYP9M0YpjrylYYchgF04EGGhS+s+wJba+M1Db53Hh4sy18v515tUV1pz9DaaMGbIMf1Qu20e8G4xLshmBo9+Lbe/PK3Hqa9n1AWX7qP3NdesfLkwZfFa+psnCc789nB9Dkxk2Yqcz5QGQSKsF1o01JphhQrODmsxgK/BWS53IdanSX+CZwz8vMIPCYEfwanCSS5JWyxem8QOdGHRlbFy8VkwUE0OY1VDvffZ2uwrU/LssuIAUGKUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b9a3b1-ae0a-40fc-cf64-08dbbe231e13
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:57:04.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rxCVud3FEGogxnUUUi1IhnTi0pOxzuOewwG3mnLBu7Revb7KJzFg3Gx9CG5+T+VvCSX6KWyMyIq2Isg9Gz2kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_19,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250185
X-Proofpoint-GUID: DZ8cGBTwjOcSQxtu9BwlNfVVcmYgl7ID
X-Proofpoint-ORIG-GUID: DZ8cGBTwjOcSQxtu9BwlNfVVcmYgl7ID
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26/09/2023 00:58, David Sterba wrote:
> On Thu, Sep 21, 2023 at 05:51:12AM +0800, Anand Jain wrote:
>> v2: Splits the patch into two parts: one for the new code to reject
>> devices with CHANGING_FSID_V2 and the second to remove the unused code.
>>
>> The btrfs-progs code to reunite devices with the CHANGING_FSID_V2 flag,
>> which is ported from the kernel, can be found in the following btrfs-progs
>> patchset:
>>
>>   [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel
>>      btrfs-progs: tune use the latest bdev in fs_devices for super_copy
>>      btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
>>      btrfs-progs: recover from the failed btrfstune -m|M
>>      btrfs-progs: test btrfstune -m|M ability to fix previous failures
>>
>> Furthermore, when the kernel stops supporting the CHANGING_FSID_V2 flag,
>> we will need to update the btrfs-progs test case accordingly:
>>
>>      btrfs-progs: misc-tests/034-metadata-uuid remove kernel support
>>
>> v1:
>> https://lore.kernel.org/linux-btrfs/02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com
>>
>>
>> Anand Jain (2):
>>    btrfs: reject device with CHANGING_FSID_V2
>>    btrfs: remove unused code related to the CHANGING_FSID_V2 flag
> 


> Added to misc-next, thanks.

> I've updated the 2nd patch with some
> historical background.

Now much more complete! Thanks.

> The temp-fsid patch now does not apply cleanly,
> I'll do a refresh on top of this series. Once it's in for-next, please
> have a look. Thanks.

Sure. But, temp-fsid v4 still has a subvol mount bug, as reported
before. I have a fix that is in-memory only. I am trying to get a
reasonable list of fstests passed before sending it out. Guilherme
can add the super-block flag on top of this, although it is not
mandatory from the btrfs internals pov. I will send out the
in-memory based temp-fsid soon I get the fstests (with some fix)
working today.

Thanks, Anand
