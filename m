Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE48793F33
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbjIFOp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjIFOp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 10:45:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC2D1733;
        Wed,  6 Sep 2023 07:45:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386DgR5d031219;
        Wed, 6 Sep 2023 14:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=75UbpVtrDGkMgfx+4d3DnuzTPcLfrRNVHVsEtN3gkr4=;
 b=1L8o/cRfYmganKkKgkZoqecNG4gYIlhES3e7mh51jkGjVnDCLTFoGId/v1/swNPwGrpc
 UILDJ8tkSq8BZESKCcLcGg6Atv6Ft4IZwOdHiyufBhJPNtkplS+qHjSEkMMjrfTVBSiP
 8atAch81tyF32kZDg7gwXyTe9Wm9SXWNa2sMr9x0xSfcalQHI9kDD2izbYB+cG9kUeUP
 RfjDagxPvV46qGUfqRfL3GwMZ2w34mR69rfWfxoYhEkPWuDNj49kVgOYPpZrzKimu4VA
 YA41vEWcXkDvKmBJTXb1OivifhTXr0cdBHyjln4LUNAk8y5MdYylbuDZOqWTLp83GkIC iQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxthsr6et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 14:45:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386EFICa010454;
        Wed, 6 Sep 2023 14:45:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugck6k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 14:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVJcOmnBab/3Z9h9lAcOGkiVHIUe3QqGxYcFD7ZXYh8RcPm/sLigTpT2QfRgPSy6HENaV9D72QAgmiXM/oIn/wPLa0RtUFbXiHCBonGSe4AyEOtu5k5GN4SN4oNov2I94SEKXVXxw5TjURBn5SgtIOARyLoUeGeq4T35C71gHb7MoeKyZjxYRgpnM7uczlnm2sPCvh4mQZmiPbrsyVDUsOKCQ6/DXeo7nrYE5jeHqvfw0+GwDlobalMSkpJfXN1GhDxQVz3dDZpsmhWkkw+xGgTSOaFgnqA5y9WHKOwRixS21x7CQN6n18IcOuL7/7sIsyf/1dQ3pSocCo4zXSbelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75UbpVtrDGkMgfx+4d3DnuzTPcLfrRNVHVsEtN3gkr4=;
 b=Ifsnr3eWM4c1sXBwVhOINOaNDKeojVN0nVkxRVER/FmPHlnU5/mQzGtDQxSTtLMw0PYNzb7+iULLzlzYu7Ib3TUECuLAzokzw3lkoA25wWkW+aZeGBTEyMw9T6jgwHqsUT9/j6hFlU1li4Bv75fOmdIWkC+7xGAsvOJQdRWl36PRQCyghq07CP3AY9ME/J0OyfnfRKZvUz1VHWhhb/X+fEcdXOJaH/e3Sqrqxae7Lzol957tj2ZI762krb6Y42ntPaJiBSXC8Gk9XM94iZricowT1QQFr1Q72ZOqTlPIuL5ptydgngTGJXxEzgk+qznj6KPFGjga2hQZyD0GmfrzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75UbpVtrDGkMgfx+4d3DnuzTPcLfrRNVHVsEtN3gkr4=;
 b=LHCu/uh9KQimFqSNTDgxAj3WjpaJrtD2d6dvsHcgjaklPCj4BUNJUnbsXwz8soSJo2t0F4cPbsC/MT5GCcEXsJ9e72lJn5/99f1ft+ygB3bY0FVCI6WzeEJsz5dnEDT4CGI7219oVCzjDA4ThJhW/m/SRjyc8tr/knfwjhD5gVc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5815.namprd10.prod.outlook.com (2603:10b6:510:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:45:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 14:45:30 +0000
Message-ID: <e63f7f76-c039-1bfd-84ea-b8e76be39a86@oracle.com>
Date:   Wed, 6 Sep 2023 22:45:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] btrfs: Add test for the single-dev feature
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, kernel@gpiccoli.net, kernel-dev@igalia.com,
        Josef Bacik <josef@toxicpanda.com>
References: <20230905200826.3605083-1-gpiccoli@igalia.com>
 <20230906141733.GC1877831@perftesting>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230906141733.GC1877831@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbe969d-11e7-4020-3975-08dbaee7ea98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jEFKH6gh6STKn8MGEEkWYI2SkbPkI6Aojz/MVU6MyqVHBO43sPCIryIncFBfwdMMK4l0/sGi2Qq9haY0rG+yFPRAUkjmSMd8fydleuuFIN99WlAyDVE2PxvgxbmsPdxiUHwSMA7E6/mEG+qjY8SsCdsRHfr8JZepUvPu1dNw75doeCAFgh6YKWM7ew5ggcHHgS0ZIkyMSkve3zqhLMKLAhm1hNVAdDdjhLF3PyBEZxpgu3m/aD0HI4dmGy9k2aQ12iaKNbOZlOnS3Gpz1r/APkbNJLiBdARVyo90fd8IYXyo6ewv4b4+zwmH510kjrIHdnLtRM7Tf8y+9Tw+WnYjhIA/Vr0WvfI8WFUhNsIqSQn8ZIr68hYk+5AWtH5qtSKpVWiZz8T0WIhrkKlgdvV2DpUDjWG+lu7gTZ3xH6n9MuZlzHs7GNFZJHxWIl0rBSiSM7eZt52U6DW+j15CoW2gO37J1+vG0QyKjPtCCmK4jEd8bCxhqMrYW4nvQcEic59l0CYipSCUwk5ih2AwWf0JxdAV73BO6I3BdGVHN+96TWATVCZlhmLCMHrqj5DU4i+U1ViBZ7Wj92AcY1oYGSAF6PWKnrnExcO7XLJF5VpDiGwwZMYY31pXKpEyqf/V1dP1XyjB+6tgE60claOf0F6ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(1800799009)(186009)(451199024)(83380400001)(38100700002)(36756003)(2906002)(66476007)(66556008)(316002)(6512007)(6916009)(41300700001)(86362001)(66946007)(31696002)(6486002)(6506007)(6666004)(478600001)(8936002)(8676002)(5660300002)(31686004)(44832011)(2616005)(4326008)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2k2L3ZjaUlKM1Zvd2NHMGxzMHg4aTI1d2FQNmd0dG9KZGJoMkExcHArK3dV?=
 =?utf-8?B?WSsvRk8wbzdsTlRGZVNqQjJ3NkJSKzg2VGFLajEvMU5kVEhKakd5UlNaTXUx?=
 =?utf-8?B?NFpmUWhuSzBZNkN6RUROTE50ME9SYXFUZG8waTFoKytCM0F1RDNaMUlaVUNI?=
 =?utf-8?B?cUd2bXRJVyttTTBoVXpEKzVaM1JWNS9JRVhOc05US1ExZU5NcEZFQk1IY1kr?=
 =?utf-8?B?MldQZGhIYnlqNy9iV3RiVW9wMEsxOENOQ1FKK0FRNjhjWWl0eVlGb2EvUWwy?=
 =?utf-8?B?b0NTT01nUnArREl3QnRtakZPRnhCNFNLYW90RzdIN2JzamtQUWt3TUZnL1VF?=
 =?utf-8?B?Qmk2NUo0MXZxUk9ydURldGpxaHZBMU1ScE5tdUZsWElPTVUxVmJod01pNUFj?=
 =?utf-8?B?ZjdLMldSMmJZc0RrMjRML3hqNlhsdk81MGhESnVQVUxxTHl4NnVSbW0wdnZh?=
 =?utf-8?B?K21iSDJuSGZvQVZUSGdhUjN1aFdFRjNSUUk4YkpaRVNCNlNrRTJvcEh1WE5Z?=
 =?utf-8?B?OFdKOUl3ZUxKL3ZFM3k5T2Y2L2pjc2N1VUpIaTdiZzZNT1ByakhWd1dDTVZr?=
 =?utf-8?B?WDFFSTMraVpHSXIwazEyanRMYlNOWEp0bXQ2YThFM014Zk5MazlsL1g4dVVm?=
 =?utf-8?B?dnNXL1o0ZC9ZZ29rRUlmYldwNStJMlp6UE9YV0RGdlhoZ3BYcGlNc3d5N2Vw?=
 =?utf-8?B?TXU5YnBwZ29EVmZVUml5UUlsU3QzZkM4WGhpTUFOVGNkUEx6YnFpZno3UVlv?=
 =?utf-8?B?TUQzc1Vtckc5MkpWeXc2eWRvYmFoQTdUN0VmekFqc1ZORGJaRmdaN3B6b0s3?=
 =?utf-8?B?N05UY0tvdFJBOE95QlJiOTdjZUJLTzhYSE43MWRWenJLT2U3eHV2WkRySHo1?=
 =?utf-8?B?WkZpbE9tRHNrVkp6RkFwNWNBb3MwbzBtRnQ5OTBoWWY1V0k1am5YazRWcjJz?=
 =?utf-8?B?a0pDbzJJVklZeUhSN1I4V0lqSWpLd2xtMWZ1UWJnV3VzZUpLOE1sVkpsTzZ3?=
 =?utf-8?B?aW9JWHR2NU03U0hoUktkdHZwMmlVdW13YTIwSUkwQlFNWmxBejBMTkhvZ0o2?=
 =?utf-8?B?ZWFnMHA1R1QwSmtJQ3ZyYXBDV2I0NW1NaURBc0I3Y3cvWWY1Mnk1TEpEeDhV?=
 =?utf-8?B?NjczcE9vUHZ3M25OME0rTTJ5NGpqSkZEWnJrVUExdXJ1bjlwaVltN29kWTN6?=
 =?utf-8?B?eW5ZU0V1NUxNV21Gck4yZHh2clFrb29RdjNTRFJPcjluY1lZbS9qd3I4Q2RL?=
 =?utf-8?B?SWxpWFZRenVFeXQ1eWtDMXVzUGdwMEQxbXhCMTRHQ2tJWFpxdnArbmVIc2Q5?=
 =?utf-8?B?Wkg1NE1NaHhlTTk3N0wzRE1ZUXVZRXpXM1FDcHByNUNaK0NROW9qb3VlQkk3?=
 =?utf-8?B?VnR3d3poZWRBaFVsendva0hlZElUUWdlWk9TNTZTZVVCM2lQbFVDVWdHYk01?=
 =?utf-8?B?cW5LckdNK2J1dXJYYW41NUNaZmVKODdyMTJ4R2RWd3IyQW5hWkFPcXgycFBW?=
 =?utf-8?B?QlJHZkhCK2R3NTdMaTNtSllKTHcvVm5YbDVJcnpGMitFTUF2VE5pNWlsWXJR?=
 =?utf-8?B?ZldUN0tLeCt6bmdpUTJ2MjlLMHppQjZZbUw3TW1OellxMFZzTXFVeXRXOTNv?=
 =?utf-8?B?OGFnUW1YWXJLL1JESVFjekY4YzNWWjU2dGtWTytoOFRqaG1OL2Z2TEVJQTY5?=
 =?utf-8?B?ek5JSlkyRUQ3dFFPYnNTOEpLVmozMHpzdzBjMGNzdStqZ3Nrbno1YVJmajUr?=
 =?utf-8?B?eHBoS0cxbkR1R3JGcktYTkhYMEZoaHZyM2JyUHpZMkRob1h1NHpJU3g3MXpG?=
 =?utf-8?B?NkQ2R293a3g2MTFkRnh1TStzQS9Zd3ltazBPVitaVmtmK0F0WWh6NmRSbXhL?=
 =?utf-8?B?aEZqc1pkTFBUUFI2aS8zWks0eWY4a1FxV0d4ckV1YitrUzRDK2tFWWJ4eXlG?=
 =?utf-8?B?bGNtTUlrN0kzZVV6M1pmUWhrL3JUUkhmbzFHZEt2Vm1aOTEyUlZ5YXkyUStM?=
 =?utf-8?B?R01sUjlrNTA4YktnYWJMcXVaTnpVNXBHUkVtaHlJdVorUTVPMCs2Ty93NkpU?=
 =?utf-8?B?cGd0aU5pWDV2cy9SWDJyMkNpQWtRMVh0eXBnR0JWcWw4bjFxSEhGaHZhdjl5?=
 =?utf-8?B?QnZqNHVaWTI3blQyZmFWRGQ5UVFsUSt5M0FsQ1dEZVZWT1hsdDZXdGdwTHpm?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: utifOUK+PBXgKoIsd5qHV0U//gmU7Wa+OZDHC+rYpy4yuMVswxuYWA5HunQmthSR3kaOt2H3eUP/im28wDrbQgR09Wi3VlAebHt9Q9+cR/zzHSyx2aygv2I+ygwvK0nOxa+cSl3GlvnPqcVp0aZxAUZ7N9QLsEBNxIdcumJwk45CVSxNoiCfU2paMNva1Bmem61X/rdZ5JChKSudtNyxzBaE6Ce1EFY4e0JxU4Tbs+J2tY6HXE2+H3/Kb7Bie39J2W8kjVfpUv9Cxsrd24XFCRbPNjMyI9FFWDB5CQjUuwGedT44dCVg8+fuJLMi02+T49p0p/Cr/oQR/akX1WyuiGxNRK/It1PzfhxXZTVnzgjCEzxIcZSDzLcLxON83iL7OkuJEoC4a5Ku9olkjmC69ykDcg5oI52MKXasjN4/r/xzl2iMOIEAsmzq4ucEFJmTu9RgrRu7FZ2Lhj6dEsy10OU85vitWNFCUVDh+ToTN0BQYfrIUUmRBHXNflF3IUgmjU9gBgy0nJ3FZVp07vLyBYOGHnhDrfpSs4/GP38KVmy2axvBrkojLd8lVj2gJ/GDth4f5q5UFFJuv297nNAqd+TjIh2oI+SSQAW+zL6rbMRcyd8pkhYBFJ7ln5t3Edb8+uhc6sWeGnr9zm1QRMJAeOUCo2YhVz+dGznGj1Yg2WJJ+KB4wZtmxDcgSfoIx128Gnc0tK0HtgfnGtyVy6Grafuoc3EqOVw+9VaDg9Zy396YHbrgF3v6qUFp0zdYVhSQGvIemx20u4npLVXBPZd5QGNtcdk5dJMglNY+QeXnJ37EXeztXvkXFNS7/sDyivNRqJZwQnI43eEkaNFuqPewXZWJfdiEeJBJ0HXFwDb412zAyERnD0KeRsgjkFdpwMxJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbe969d-11e7-4020-3975-08dbaee7ea98
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:45:30.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aL4LJGFrcdWhLwct2pjS3F+blBN4kMvr+WKwAYlX88u1Vt658cJjuA9QCmi1VbjIMj/AF9U9zIHfjaJJInrRdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060128
X-Proofpoint-ORIG-GUID: 4zYzTNQdB_r6bzmDUSRZqMA0PpmfG6Ky
X-Proofpoint-GUID: 4zYzTNQdB_r6bzmDUSRZqMA0PpmfG6Ky
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Further to Josef's review.


>> diff --git a/tests/btrfs/301 b/tests/btrfs/301
>> new file mode 100755
>> index 000000000000..5f8abdbe157a
>> --- /dev/null
>> +++ b/tests/btrfs/301
>> @@ -0,0 +1,94 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2023 Guilherme G. Piccoli (Igalia S.L.).  All Rights Reserved.
>> +#
>> +# FS QA Test 301
>> +#
>> +# Test for the btrfs single-dev feature - both mkfs and btrfstune are
>> +# validated, as well as explicitly unsupported commands, like device
>> +# removal / replacement.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto mkfs quick
>> +. ./common/filter
> 
> Normally we group all the require'd stuff together
>> +_supported_fs btrfs
>> +

>> +_require_btrfs_mkfs_feature single-dev
>> +_require_btrfs_fs_feature single_dev

>> +
>> +_require_scratch_dev_pool 2
>> +_scratch_dev_pool_get 1
>> +_spare_dev_get
>> +
>> +_require_command "$BTRFS_TUNE_PROG" btrfstune
>> +_require_command "$WIPEFS_PROG" wipefs
>> +
>> +# Helper to mount a btrfs fs
>> +# Arg 1: device
>> +# Arg 2: mount point
>> +mount_btrfs()
>> +{
>> +	$MOUNT_PROG -t btrfs $1 $2
>> +	[ $? -ne 0 ] && _fail "mounting $1 on $2 failed"
>> +}
>> +

>> +SPARE_MNT="${TEST_DIR}/${seq}/spare_mnt"

Please use small case for test local variables.

spare_mnt=="${TEST_DIR}/${seq}/spare_mnt"


Thanks, Anand



>> +mkdir -p $SPARE_MNT
>> +
>> +
>> +# Part 1
>> +# First test involves a mkfs with single-dev feature enabled.
>> +# If it succeeds and mounting that FS *twice* also succeeds,
>> +# we're good and continue.
>> +$WIPEFS_PROG -a $SCRATCH_DEV >> $seqres.full 2>&1
>> +$WIPEFS_PROG -a $SPARE_DEV >> $seqres.full 2>&1
>> +
>> +_scratch_mkfs "-b 300M -O single-dev" >> $seqres.full 2>&1

>> +dd if=$SCRATCH_DEV of=$SPARE_DEV bs=300M count=1 conv=fsync >> $seqres.full 2>&1
>> +
>> +mount_btrfs $SCRATCH_DEV $SCRATCH_MNT
> 

> You can just use _scratch_mount here, since you want to handle failures just
> 
> _scratch_mount || _fail "failed to mount scratch mount"
> 
>> +mount_btrfs $SPARE_DEV $SPARE_MNT
> 
> Instead use _mount here
> 
> _mount $SPARE_DEV $SPARE_MNT || _fail "failed to mount spare dev"
> 
>> +
>> +$UMOUNT_PROG $SPARE_MNT
>> +$UMOUNT_PROG $SCRATCH_MNT
> 
> _scratch_unmount
> 



>> +
>> +
>> +# Part 2
>> +# Second test is similar to the first with the difference we
>> +# run mkfs with no single-dev mention, and make use of btrfstune
>> +# to set such feature.
>> +$WIPEFS_PROG -a $SCRATCH_DEV >> $seqres.full 2>&1
>> +$WIPEFS_PROG -a $SPARE_DEV >> $seqres.full 2>&1
>> +
>> +_scratch_mkfs "-b 300M" >> $seqres.full 2>&1
>> +$BTRFS_TUNE_PROG --convert-to-single-device $SCRATCH_DEV
>> +dd if=$SCRATCH_DEV of=$SPARE_DEV bs=300M count=1 conv=fsync >> $seqres.full 2>&1
>> +
>> +mount_btrfs $SCRATCH_DEV $SCRATCH_MNT
> 
> _scratch_mount
> 
>> +mount_btrfs $SPARE_DEV $SPARE_MNT
> 
> _mount
> 
>> +
>> +$UMOUNT_PROG $SPARE_MNT
>> +$UMOUNT_PROG $SCRATCH_MNT
> 
> _scratch_unmount
> 
>> +
>> +
>> +# Part 3
>> +# Final part attempts to run some single-dev unsupported commands,
>> +# like device replace/remove - it they fail, test succeeds!
>> +mount_btrfs $SCRATCH_DEV $SCRATCH_MNT
> 
> _scratch_mount
> 
>> +
>> +$BTRFS_UTIL_PROG device replace start $SCRATCH_DEV $SCRATCH_DEV $SCRATCH_MNT 2>&1 \
>> +	| _filter_scratch
>> +
>> +$BTRFS_UTIL_PROG device remove $SCRATCH_DEV $SCRATCH_MNT 2>&1 \
>> +	| _filter_scratch
>> +
>> +$UMOUNT_PROG $SCRATCH_MNT
> 
> _scratch_unmount
> 
>> +
>> +_spare_dev_put
>> +_scratch_dev_pool_put 1
>> +
>> +# success, all done
>> +status=0
>> +echo "Finished"
> 
> Don't need this bit.  Thanks,
> 
> Josef
