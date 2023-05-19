Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CD5708F23
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 May 2023 07:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjESFFJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 01:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjESFFH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 01:05:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF6918D;
        Thu, 18 May 2023 22:05:06 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIwqSb018304;
        Fri, 19 May 2023 05:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5jxmb7oQXbxE3Pa6CzrNdm8b312SayaXSci18TEpZ4I=;
 b=AMz7HqTn58v9hSjnqthsdUGlOhom437K8yQ8hJAiQiOByChmtI8zUWtc3CNJ1zIfU/L4
 P/i1bCB2MORXSsH8Uq4Ytb0SQ4k2k4VqLgevlLSyzhNwc4DQbKijvEmB8c+6QjB72ecM
 cEeuPuDVfVVDqe4YSysTBw19cruhzJCBEKVNwB8M8iK3PJGo/HqQlRIcmwWuzH4CUdRQ
 KqbL3QX3Sq6xKDcsweVkrmUH428d+fSvf3GmYjKjqVoVeICgo8aVNoBiHSQ/QHtH9N9k
 XMn7ASIShqPMoxWGSWEKjiLg2gnmGypJuodFNgzvdYgr54n6JejETE7fIkNR0d/BkjYN WQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdsses-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 05:04:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34J1to0x024990;
        Fri, 19 May 2023 05:04:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107n484-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 05:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/HyTh6ifIRxBZTIlPAnQ/nHuRcLDZYVfMCOaYASGaTrikekbqOp6oqsqfbSoT5aDLiGX4Z30SwfZUxHLb+NHwuIv+lFxgSpbn1mUGl2TNW1parvLkKkZGBEKTi02aszxYDDjVbZEn5ZzWfU3lgyT7DLL4uVs1gx1Y5Ua0GfiqfSqtEEZRv1+Q6E47N3WeNrV2e1MquTgoi3Gezzs7yWMMXP9d/KhIu6ITY2QMguWr8erTrfE0fNDn+YG9lzlV1s82F339TsGO+M//NvKlTCMHjoEVJLpdEOf9l5RA0/v3Uhok3nOyQQLGsM6Yd8g+MgQ0CFyJAgXMLfIwI80Q5vJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jxmb7oQXbxE3Pa6CzrNdm8b312SayaXSci18TEpZ4I=;
 b=DtVHyepS1ggnEEHZwbJh3C9A0FFN0OYYneeeIBuiTLFz8HlwltN+Oxy24FJMl6gACEtBBmvO9rMd09TVEtftN4LrmkzV7ENe2rKqka2b8H9gMY6fZPyqiLeZgxe8ByLYAYvWOi+zzUfX8VHdVAhpoKY99o9H5jxG4tMPb2CRBkHrUAFSofNErE7XBsQf6TdMUegWY+ZSSrlf49cx4Hnzt5jH0RsHswQpxyZVos8CqdqGuPVEW89ieMDZJTR1cJjCQFOTdjHF/It/EeaTCPslViaeMZ143CFD6zRhJrNMJYIb/Dilm6fG1YfUCoch4fbhE5ofpB+IRfLy8LuGdBYqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxmb7oQXbxE3Pa6CzrNdm8b312SayaXSci18TEpZ4I=;
 b=NrZVBLVc3NMVEhAo3slS5PktRkFoagt0tDQzI57Mn7wNrEMbBoBnzT7HAUdtud5WyKfI2JAiETroynuhT6HyJpNnjOr61X9pm0omBXN0Zqs7JD9d0geqj7sWU4AFKKrzjZfWsuqFb7ACjBYDpYkelxcJXuHtqTvq3lfaC1ilQ1k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4133.namprd10.prod.outlook.com (2603:10b6:610:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 05:04:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 05:04:55 +0000
Message-ID: <966568ad-de9c-e395-1ee4-1b9028987df2@oracle.com>
Date:   Fri, 19 May 2023 13:04:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs/213: avoid occasional failure due to already
 finished balance
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <1e2924e9a604f781ad446ba8e2d789583e377837.1684408079.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <1e2924e9a604f781ad446ba8e2d789583e377837.1684408079.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cb7e4e-1166-45f8-3902-08db582695aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBnJUBJG0fIP8c2gmX2+V8GIYJNvf9k0RN4nUA6r6jrqMbw/f+zsq66Ywa59Eof1Q063Df6db5hmJi9DVoqfDh4qgrs6tneCwCPOt/jxGBBBM6nEzkUS+XBB+l1ekKDxFA0dRSBbgbbkhkLWYSyMBRZcTDQnF27pJkndTW6RY+oYvp3TVGPm/Bbbpa6oE7JrCn4BMVaw88Kz0NiSHaLZ9EN+2i+bgtOAZcXI7KqmJrk4avYd/ZuBaUb10ghlJJJsn1ejFbnIMT5oNdjaGAH/Qc1cXgV8jyuT7f3NWj3ecWctEKIHSzQmlCmsNytspo8RjeqeErO1BbSNBN4nGnz/EPX66wxJpvLP7NwmK2OjJG/algZdXZSyEzHRw/2Qcw2M/2OqdckXtb3rB4QYcgbyVMvsRxjRmDldqkowT4T5W0CYTrhRt9uLZQFvUgobjdPA7ftnI/kT2DoXcbw/mOkV8/C7jmrHMjFA/yOqGSFQ1+1nQ8Im6hIkRvSkgeRd+FGmrgNIcSpxSGTlJAUMtVXezThSEfUCN1Kuh3qwknf2b4rkmhADehEtkIm0mGwTiEqGXWzUwaGOOIZ41oixs2Vn9GQnwHXB/EBy2TvnW1gon1M1nckeQBMUozLGPp7K9rEwff1jLkALUeWzQlgUhAHeBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(86362001)(66476007)(8676002)(4326008)(41300700001)(8936002)(31686004)(66556008)(31696002)(38100700002)(316002)(66946007)(44832011)(36756003)(2906002)(478600001)(83380400001)(2616005)(6666004)(6486002)(26005)(5660300002)(6506007)(6512007)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVhEMWRkN3FVK2RHZlFyazhBS3llb1F3U2N4c01mWXEwdklIekdCdFpLcjJF?=
 =?utf-8?B?NERJbFVkOTZzdVcxUEFFZlpTbVZ3YVhWaXp1enhBZHNUcm00RjN2bmZTbzJH?=
 =?utf-8?B?QXpwbVB0MlRIOFl2bFB5OXRjUDhoK2lJYW9hbG5WUWFiT1BMOFpabkFDUVo4?=
 =?utf-8?B?NkN5UjFzZ1hMd21zSjVUaThRdWVHbU9DVHhES21wMHNNRnZhZ2hwa1JZU3hn?=
 =?utf-8?B?R1Zpc1htM3RxN3Bodkl5Tm43L0g3c0xXbkpYRG5VVTI3UnNTNXhhVFFITWZM?=
 =?utf-8?B?Q3gzUGNSQmxDZlRZeHd4aFVvQWkyOTBKOG1MSDZvazZDMzdBNFJVdEMzVVBY?=
 =?utf-8?B?R0tob0hneVRLTXVSZnBTN2VMemk1QXZQZ0EwK01GR3VRTUVUYUkyeGNvbmdG?=
 =?utf-8?B?cG9vQmNsVXRoaVFpNUdlVUtaRUN5YU5lUzM5WWh1VnRxR0g2YWVXSUhOVmVF?=
 =?utf-8?B?SXRsbXpERk1oY21ucDNzZWQ4Z1ZEdW91cWt2b2hxSTkrUGY3U0pPOTBFSWZF?=
 =?utf-8?B?MFNrWjBVN05sai9vbzJNdUJjSWEwSUdETWc4VlV0LzA0ZlRLcHExYy8xTkV6?=
 =?utf-8?B?NDhIQi9wZUI1UksxbXR3cE9pTDhOL1k1eXhYS1MwNi93QjhWUVh2L3RsanA2?=
 =?utf-8?B?MDJ5RlRZZkMzczA2WnFvaEdhamd4OHk3a25tOTJTbS9xeG5uakdRRGltUFky?=
 =?utf-8?B?RlJ3Qm9ZTUtpWE9tOGZMY2RQSGhleGFRMlNlVy9FQWt3MlFmcm1SNTRBYnA4?=
 =?utf-8?B?NFFMNVlMZGdib201WkRKL3hsZitkL0hPRHdLL0x4ZWpSZURNYm9TVDM4ZDMv?=
 =?utf-8?B?YXhqMldsanJnaTZxZjZPWVpXeC8xTi9pRU1HODdjTysyYU9DSW9KTk1Ub3Qr?=
 =?utf-8?B?RVV0bE5mQm5ZeUhLeE1ta1ltSDJiVmw1WXZRSE8waVRManlSTzFQdzJ0QTJP?=
 =?utf-8?B?K01sUlhYYWMrUEExOEVxK3JwalpHSGxNNTBTR01FY3JNYWFjeUdTZExBcGhm?=
 =?utf-8?B?NVNiN0htSG43ajAvTnlYZmtvVlprNm9UNjkzWEFnZlByaDFmK2RLQlFjNmJO?=
 =?utf-8?B?UzlTaHpCeUVtQ2gycUp1UlYrazg2dkhmaHpXS0RDL0FpQm5iMHpsQ1BmZnhV?=
 =?utf-8?B?OVJacnZDNStVOXpXYU93TXJKWksyQjI2VjZPMERaSWtHK3NKV0MxWTNyU0ZU?=
 =?utf-8?B?NHExNFdibjBrbW85MnJ6azVyeUVkUEkybmFlRXAxUi82NzJCL20wTTg3VUlB?=
 =?utf-8?B?MjUyV05xekZWMmtoWGFzU1FndU5nZTVmWUZuRlFPeGFYY3FmS2NWOGEraXI1?=
 =?utf-8?B?QlMwSzhvSnRNdVBSWnhPWDhtOCtJbDU4N1I2MmsxbEpPNEdwb3FhazJGbHNl?=
 =?utf-8?B?YnFpUXpjNll6dVZyZzg1enBVM2I1YzhmdTN4R09ubXRjL3VQZmxkY1NkUWRU?=
 =?utf-8?B?ekhOVU50TTA5QmJJZ2V6WFU3NkpSS1Zqc0Zma2hsUVlTV3p5WGpxUkN6Q1du?=
 =?utf-8?B?R0tGVFJ4ZHpRWUhxY2twQnp0N1lNaC9wY04wSGtLRUhLZmxyYTZMOHhpVHJx?=
 =?utf-8?B?c04yUlo2b1UxT2Y0RXhIQlU0am9NYnpsR0kvU0s0Q25scVF4LzJoRFhhVThH?=
 =?utf-8?B?SGVDLzg4YW1vLzhDVWMzTlpBOHc2OXNKK2VrT0ZBamFieU5pMTVoY2huUGRQ?=
 =?utf-8?B?MzNocmtmRGM2Vm1JVXp4cTlpTVhnMlg4bkZrMHBuV1g1YU0xSzc4SEx3RExB?=
 =?utf-8?B?Z3lNQ0hJcnIyc3hNcHlLRUZiTmdEeHZKMyt3S2gyZGh4VnZucTN2aktrSk1j?=
 =?utf-8?B?M2tVUnMySEQrQmhmWDZjOUwwWUtIdWxjMEtFS1BuYmdodkNjbUM2Wnlydzd6?=
 =?utf-8?B?UUp3aDJzdVQxMWlkcy9reVBPc2wzdTUyenBvU2lyK3lzYmVLdS9rY0NtU3NS?=
 =?utf-8?B?NzQ3MzU4b0wydU4yYmpYeUE1aWRvOEZLZStZaXhrN2Y2Z1FCM3NNbGZxSzNE?=
 =?utf-8?B?dnphRXRRZGJmQlZZVWIzb01rZmZrUG1XV3RLTHBjek1kc25yWlp6VmF5Yldu?=
 =?utf-8?B?bkZIUUllWCs2M1M0ZEswcktqWHBjY3BJdER1a1hUQjhid21SaG5UajNUU25X?=
 =?utf-8?Q?qqvg5lJGV3YZFGDiT44ZFgLtL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xCZ0Vt7uzETpxEZXfhdG89jxWlIMW1ND4QQ1DI64Dw8iWv4rdWTaPWbNbPsxeKlbCCdqIqCX8ty73cDAI8GUkp48RtGLYA5gUmS0kQ6AB7oHlnddIxb0LvPuc82Viq3y3Sa/BqjG5NskAehlFaeHvUeQaCSvIsAxEeUrlN4CpZwZfHnRFlyYHnLr4AUwmiXqFMlPIh8k8JEvQPLf06h8mEd0rJN8mBEc7gbhHrHzcNOhinf8+vQgSWj/iFisyAC3YdQYFT4nEE16D//XiUpRJRMZ/PzdzN5gkllYFabLP3VfhxSDjAF4GxLZp2lwT9EaS+l/XK4hAWsCJxsFC4Yi/5EDhFF8FWJfBPi38fomlyOyBNEcVh9GduPzlHhz6Vv91YiJ08y88biOu5LVeMF9beXMLpogvzY5Kczegwm9Xgd3mvb47rZOqaNT1Pt2J+I9z77WfWoxsJ8K2X1mdq4vNisfbJpPdBsEhBynfV7+vTfijWthb4Esus9KQnM1VPTaEQ63/Zz7wevJsUsZI/xa2Pmxu9arAn+i52mk2K2+0ft+p+elcoqOeq9d0d85vcEctZNug0EdTKtqt/6sRioq86bitBTPSva6BPUPK3N6rKQ5ThaFJ64McSXi63UVD/5/shemuY5pl0to39DYbySkrTEMsnz+5W/gZgi1B6WKp4+azBTwJmtQf6CL0pYzeumJLQqKjCoriI5+Gyi1nsa3PMkOyeN76JfBOHRJtYJ1dXKKiTBiovRlMfRQr91INK5RkJu81b/MN9N2Fdd2gWYwkYG4XsGOVW6SlLlpmBh7XY51idx7Pg8I7vLBalK2EOE7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cb7e4e-1166-45f8-3902-08db582695aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 05:04:54.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rK1YETqwU8bxfYj8gsSzJyZ5aB22BO8rTHzmR9WFfck3tRXnqhHfvCPeYzZk5ZEoBsXHAH/Tuv1Et8CKgwV/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190043
X-Proofpoint-GUID: 6gLpQAYqfQTS8KOWsKNX6RWsi-9yMyS3
X-Proofpoint-ORIG-GUID: 6gLpQAYqfQTS8KOWsKNX6RWsi-9yMyS3
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/5/23 19:08, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs/213 writes data, in 1M extents, for 4 seconds into a file, then
> triggers a balance and then after 2 seconds it tries to cancel the
> balance operation. More often than not, this works because the balance
> is still running after 2 seconds. However it also fails sporadically
> because balance has finished in less than 2 seconds, which is plausible
> since data and metadata are cached or other factors such as virtualized
> environment. When that's the case, it fails like this:
> 
>    $ ./check btrfs/213
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.4.0-rc1-btrfs-next-131+ #1 SMP PREEMPT_DYNAMIC Thu May 11 11:26:19 WEST 2023
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/213 51s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad)
>        --- tests/btrfs/213.out	2020-06-10 19:29:03.822519250 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad	2023-05-17 15:39:32.653727223 +0100
>        @@ -1,2 +1,3 @@
>         QA output created by 213
>        +ERROR: balance cancel on '/home/fdmanana/btrfs-tests/scratch_1' failed: Not in progress
>         Silence is golden
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/213.out /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad'  to see the entire diff)
>    Ran: btrfs/213
>    Failures: btrfs/213
>    Failed 1 of 1 tests
> 
> To make it much less likely that balance has already finished before we
> try to cancel it, unmount and mount again the filesystem before starting
> balance, to clear cached metadata and data, and also double the time we
> spend writing 1M data extents. Also ignore when the balance failed because
> it was already finished when we tried to cancel it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/213 | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/213 b/tests/btrfs/213
> index 8a10355c..cca0b3cc 100755
> --- a/tests/btrfs/213
> +++ b/tests/btrfs/213
> @@ -28,7 +28,7 @@ _require_xfs_io_command pwrite -D
>   _scratch_mkfs >> $seqres.full
>   _scratch_mount
>   
> -runtime=4
> +runtime=8
>   
>   # Create enough IO so that we need around $runtime seconds to relocate it.
>   #
> @@ -39,11 +39,18 @@ sleep $runtime
>   kill $write_pid
>   wait $write_pid
>   
> +# Unmount and mount again the fs to clear any cached data and metadata, so that
> +# it's less likely balance has already finished when we try to cancel it below.
> +_scratch_cycle_mount
> +
>   # Now balance should take at least $runtime seconds, we can cancel it at
>   # $runtime/2 to ensure a success cancel.
>   _run_btrfs_balance_start -d --bg "$SCRATCH_MNT"


> -sleep $(($runtime / 2))
> -$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
> +sleep $(($runtime / 4))
> +# It's possible that balance has already completed. It's unlikely but often
> +# it may happen due to virtualization, caching and other factors, so ignore
> +# any error about no balance currently running.
> +$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iv 'not in progress'

Cancel is an important step in this test case.
Why not call _notrun() if the test case fails to make sure
the balance is still in progress? This way, it provides
another opportunity to fix.

Thanks, Anand

>   
>   # Now check if we can finish relocating metadata, which should finish very
>   # quickly.

