Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5B6757211
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 05:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGRDHZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 23:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjGRDHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 23:07:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9745AE60
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 20:07:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HKOQ3s015926;
        Tue, 18 Jul 2023 03:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=w0QAB+MkezeWJvMVc2FyMJ3fIDvUoioHNp6GL4BaF3o=;
 b=vear92UjPe/TW7PMtE4/wPacppD2C9XYh2ddHopjv5dQyDnUq6xC4gbxP3NMSVDck9bC
 yY1ugfHuvt1KVMsB4W3NdgvMWd4BnvQM6VH273tIjQFV5B/E10eDO4JLYbH6CsudIn4R
 n0NmtowdfOEL56vukUj5UMCX/xGKHp+G4i0OMKKVRwQ4kHNgBSF617cjbT0pLIfj5eon
 XoRQTiDm5Ypfpm71Tn+NYVZkwBDamk4Cx8rfdIOkVGbogg/6Vn+v1NDrKvGrZcvZRseb
 17DvW+VvDjzW/9429VTcW5CjV/gIEEihVULIYes63EAXdM1kiHiLBIoT4AKzRKpLksRN CQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a4386-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 03:07:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HNqRP9007802;
        Tue, 18 Jul 2023 03:07:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw48410-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 03:07:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBfNTRs+8CNBJGkpuTbDRFuxna11TbbN3kjRkFqPamEQUNKNVnftrj7l8+XMxeH+T7doItFNseoVR10RGsRtkbYuDwHbuU4e8fIyLlPssKAQiYznzXqR57+OU4rv+axMZrPZa3vGXsHnucSIuKIsIcLjddaY4qet6yTAnJ7hmQw3Xuevt5WgaO9lzgYZ+aFLpacHzV3BTYxfmCVLxnWIMzlLUZ67ugznW9FvqWTfJGhSayPQNu4dGjGOYfYoiTo1Vq1UiE07p1uBaiNAo2TqK0aWGajCtrMxaZCqNSTjXsltMSjxRt7SgnLkFUt5FgSz5XdxzK2IQ4ZBuOgQkSJyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0QAB+MkezeWJvMVc2FyMJ3fIDvUoioHNp6GL4BaF3o=;
 b=EJQKGosd5dGD6HP1rMwdKztevJ/aRdmU/7dnF+X8IN5cIdJe9GGp0mdWYQLmNygu2Afz5mei0H8kpnvbPKeGc/juRKK7XAAR8thouyctAezBBiN6EGZf4MPxBI3zOwJIOdkXCjACpw3agtx9qeZg24QiNPUuY8+QY0UpUNbrIK/bZTBkVykIK2a/IQEG5EFbtWt1RCtS5D3ztlg063cTTsSzmFHuGHGfVk8FrqINk6eYv6qVZvgmzh7gwt4l6ZoWEh1rrLdfSOPCOYLPOscwyW3jzRWzVE9tqHJpgLNxkMqfMoX8+WETaEC3qWInDWn+ELUDJUZS1+YkJs2sLGzzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0QAB+MkezeWJvMVc2FyMJ3fIDvUoioHNp6GL4BaF3o=;
 b=y2WiIf8rEJ4TjIOGJQlvH8fedyzgBL94XdPiQny9G5CFQtyYlGooKaKd6v3Wk4a5znHZT0nV/qe9HIRtGBSlDOVHZK+djpBMZrLeDs1HiC4Dt3h4RiZHsLlaCP+2Lu3j35a1WYnAcHDTcz+ciOM6DPYfPlanYBpVih7wSzfG4Gw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW6PR10MB7687.namprd10.prod.outlook.com (2603:10b6:303:244::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Tue, 18 Jul
 2023 03:07:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 03:07:15 +0000
Message-ID: <e067e64c-7c21-a1be-0bcf-f00a49cbf2ba@oracle.com>
Date:   Tue, 18 Jul 2023 11:07:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 04/10] btrfs-progs: docs: update btrfstune --device option
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1687943122.git.anand.jain@oracle.com>
 <8bfadf1467d7a5b7283d4bc4b5b00b7f070dd814.1687943122.git.anand.jain@oracle.com>
 <20230713184141.GB30916@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230713184141.GB30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW6PR10MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: b70c5b1b-5534-42de-2b86-08db873c16b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7FHsC/0Q+I7WNI97l19d+wOnlb9Df25b7A502SEbeptlaJriI+224h/ilQuwqLDAXYZSm3rwa8zf+rR75u7fr1H66UgcwcWtu8Sb82CdAoKG3gGA74oiyz5q2xyrDVVHF5pZCHjr2c9whAxUTUr2j0zU4FJiH0zRqqRmbm6v+yz7w44kk9/cfaTT+wpooGZO77qyx9y8eoBDvsKABKFuWbQJPLU3CmHRuIJjO2LOt6N2LCelROtA5xRdkyoKNNZVLKYblj7j1HbJ5seKOsdorgHOqjIa81BkNN8FFniGkUH8hZBqpnJ6GaQolEYdL/xMFVswsP5HVXmBQNDYLh91k/rrF3oheRE7hk1GceDgzog5RLqhIihroWewBJbPKZciGNKA4wfizpmChqvuhIwac1AWwCxGrfxzikmRTIfQAVB3C+AgKa72ZPP2cAV7ugWLDKhbbi2wc+MV8Dtcbt6IrxrOjdIzW9m2an65s+hnV7xUFLV1uM06iamcji0RSeFxk4phG7kqbrisSZbS6lyOmLsRUe2NUKvmwXzkkZ5gsV4J3Fo75zLr/m6j+kkRF4dm+pajvaTf6aVrdJKTAJey5g0XHiWt7yqggzYqLO68w+9+tJy0amHC01WD1YqkPtd1fVCmYuNx/MfUOg0t7sfhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(6486002)(6506007)(66556008)(26005)(186003)(53546011)(41300700001)(83380400001)(6512007)(31686004)(2616005)(478600001)(6666004)(44832011)(6916009)(5660300002)(4326008)(66476007)(38100700002)(316002)(66946007)(8936002)(8676002)(15650500001)(86362001)(31696002)(2906002)(36756003)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1VSUkZCNktNejdWMk44a3R5NXM4czNMbXhUNjlKUDdxSVFLNHFkQ2s5SldE?=
 =?utf-8?B?bUpETnRNSnpFdjJwNXFqS05Fdy85cEJOeVE1YkVJVXA5R0liMS8wd1dnalhS?=
 =?utf-8?B?cG00di9kNy9UdnpVaEc1bVBXNVdyR0dKMW9VMnBWSExVQVJuUU9GR2lBZUFq?=
 =?utf-8?B?WXUwalB4Wm9nWkttRFJvamgxeXJXQVV2K05yYmgxOWpuSkNhcnJDUjNSMXkr?=
 =?utf-8?B?eGxReW11cmNLT3FBUVFMWEhaU2FSUlFRNzJtNUZYa3FoazlCaWhNc1l1djZh?=
 =?utf-8?B?UTRNVFhneW9GTkFBMVdVaHZ2QmV6R1g1cVVIb0dBelNJdTdpaXlSaklJeWJU?=
 =?utf-8?B?ck1mK3NnYzNLdXpmeHBicEpvZkozcEJ4UWRyWTZLa2J0aVVWeUk2TlBSQTM5?=
 =?utf-8?B?RUpueVF4UENPem0xZ0psY3JJLzMwck40TkJka04xQ25ReS9oWm9RaENFNCs1?=
 =?utf-8?B?U2UvbzBoaGFQVnA2Vk85Vzl6QVpXckdoRlRROEhYMERqVllnWk8ySWdyNkxm?=
 =?utf-8?B?eUo5TVg3cUhvZkpxeUJHRUh2ZkZWRitYbU92NHFhZW9WbndXOU5VVkJ2cGJ3?=
 =?utf-8?B?K1FjMWNDL2hwZHBTNk5PWjQ1UXFRR2NCRWdobHltOXdQakFJSWxVMExNeVda?=
 =?utf-8?B?Z0xOVXFGdFd5MnlobE5Vbk04Qm1oMms3ZzZ0eGZtakdUZWFDbk1KemszbXhZ?=
 =?utf-8?B?SnZmUkFwSWpnaGplSnp6ZWR5R1pjWis0UCthQ2FDZm1jM1VFN09uZG5JU2wr?=
 =?utf-8?B?UnZWLzY4L3Y5ZEEzeHFlQUF2UzJDQlNIdHhPakpIWjd0R1luQ1hvbllwbVpS?=
 =?utf-8?B?REhqeTJZRitqUXVsWGw3TVQ2WFhjVy9JRlZGTmFSMSsxRWlTcHJjeEN4dDV1?=
 =?utf-8?B?bVpMYlAvc2JHQUE4U0grNnFkSkc1OHJXWVRLa2NMK3pzK1NxUVNDTW54RGRM?=
 =?utf-8?B?T1djMEpwSmU3dDJBb3gwMWJpZ3YrREV3cDNxYmdQb2FLcVlncmI2bG1JNnRG?=
 =?utf-8?B?VDNuTmhmbm56aXZDd3BJUkhVOTZjUHNoZU43NkNMTk84OXNmU3VQSWpYdVhY?=
 =?utf-8?B?bEFuM2lZdXZkZllFTUYrRGRZY3NFQWNkZTVHWE5Kdk14YjdreUZxUzNDTWI2?=
 =?utf-8?B?akZKQk9hYW9kYTlaU1B4SEg3NjBQZ0g4RU9OcGV2dUJteEpzWWxMWTV2a09M?=
 =?utf-8?B?MlkrcHdUZFZpdHNacnoyZStuaWtQU0xnUm0xVjUwRE9vK3BVOTI2d2M1L3N3?=
 =?utf-8?B?VzFzYXoralMwU0dINWRMYzdPMWc5SXcrSitUQUM4enRwdGZBUVgrZ0wyZzl2?=
 =?utf-8?B?bnFrdlllR1FsUDNxUXNPV1lyZWhpdnhVM3d0czRCUFpjbjJPay9TV3lucGw4?=
 =?utf-8?B?N3RrNEptL0JwL1JxYmUwSmJVbnV4S2lyWGk5ZndjbnF5Tmd0ZldpYTBjRklm?=
 =?utf-8?B?d0Z2NS94c296c2R4NWI5V2dseEdwTW1nRVRTQU1rQUl6M2NROTJ6SVptQk85?=
 =?utf-8?B?UWdGOG8wcUltQS81VTlwQWNqdEpDamMwVERHcFRTVEZJbEgwOG1lV1RET01J?=
 =?utf-8?B?bVR2STZyQnVrVUpuZ2dZTlJFTSt3QkI5M3lKaXlMYWpjblBzS2pKbTY1c3po?=
 =?utf-8?B?VmRjdHZ4dCtmWWkwVlhzbDVuM0FOQlQ3cHEvM2VZZms4QXZIa1BMT0oyYXVl?=
 =?utf-8?B?S08raTg3R2dwUEl5aXJyY1lOa0JReTdWeEhWd2VwN21uQnVrM2tpSHVMTXA3?=
 =?utf-8?B?ZlUzcHVWNEpKcmpKanAvWDZpbXZnVDlaUE5sNXZlemF3a3NmbjVodDl6S0FW?=
 =?utf-8?B?NkpKQW50VEEzdm5vTXhrVWl2WEsrcG1ta1VoRWNCOXNOV2c1eWx3a3g0bHEy?=
 =?utf-8?B?VVYrbzJkU2MwN2ppQnBQMDlOYlpSeU9VQXdONWoySUNDN3UxbzIrN1ZaaHFr?=
 =?utf-8?B?bWhEQ3JDY2FZdUE0dFNSbW8vU1BXY1MrbjlENUpPMkNmWEh2TVlEMWtHNGdG?=
 =?utf-8?B?U3NIMGN2ampoWWpYOUE0RDVTOFV6OU42Tnh6SVYvSFNTeklCTDJyZzdwTEV4?=
 =?utf-8?B?QVJZTU9pWFpzZmZ4YlREV0Z0SnZSbk5VTVQvRzMvSjJiclIxcHVBTFlZdVJY?=
 =?utf-8?Q?OtZPhRO0T4MncsZz0Pd8N9wYE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MuPLE4jxumvkpbrZ6gr/4j0TSq3uyMWtZjF5zORoMTquIbzJzwniF5vycGYU0P+Gj6CqgNd+OrVdevTb5ihX/7Hl9X+ZufvGoeJIYqdkgwcBeu4yY8W3QXTC3LCTRMlXJxaRzL9I8Hc7NJjeywXgfifqzD5GaTn0zU4d31o0fn9eUSBLwzfqzYsdZOUclSwgmwb+9aNXUQ3rUEDYN/H6yBMF844G6cFMVpUc5Vpm+hkGGuAGwy9jrY6ATBGdTypxXlT++XLNWwkHGhmcNGZjKNXzpkyZpapyjqgfat+ksmZ/b+xi0iWm5ZIc04OvsU9HecjKQrNgUpvKy2evBZTI8asN+IRaIH1sui9uXEuFlLlTyCej5/CLSmPotM2fEgn6hVCpIBLaCRD5wfW/EONrZS78GYL2R95nUfQMsJyfVKjs8wgGUVisdj1o31uDvIKpBATMQZLFPhwnwkOKXjiYg73Nl7lMN4SaYRKUEic6WydImuYSdSLtYfP9UmGsgZPbdzfnWD18L4c/kglRonVgTmRGO70Y3ZR8So3sgIKcCbK3sakcq+FuYOYIixyJ7Jooy5/NtRs0NEctwbtkrt3RGCBci1z2+eFL/phkR8hd90tq4ULWIFphtE8J/wSauPmjYTrUmX4HtsbnUkaIiazaV3Y2zJnxqipsm/Jlwo2GTgzTAEH2G5fyZcssTLDyYkeBlrwgcMxoo+dGXcO9VbfgzLQNAfDdj2Px9AmMHCCwUaJrJzUa0c1MfpEnBLKEEkkoeAE616ohOXvPB5GXD71fySI62H8UbjlBY0ZNVF6KbBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70c5b1b-5534-42de-2b86-08db873c16b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:07:15.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zidmh+kOf41LTevusuea7aw67bL9f3uIsBdBjAX6t3NWgdJu/iakD2kPDMkm8M5IiB995C0n+U4C8Z9TggpcAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180027
X-Proofpoint-ORIG-GUID: 0tUrIwWacf9Nk1fbHIDkq5n2nryOtDxK
X-Proofpoint-GUID: 0tUrIwWacf9Nk1fbHIDkq5n2nryOtDxK
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/07/2023 02:41, David Sterba wrote:
> On Wed, Jun 28, 2023 at 07:56:11PM +0800, Anand Jain wrote:
>> Update the Documentation/btrfstune.rst to carry the new --device
>> option.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   Documentation/btrfstune.rst | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
>> index 0510ad1f4c26..89f4494bbaf0 100644
>> --- a/Documentation/btrfstune.rst
>> +++ b/Documentation/btrfstune.rst
>> @@ -46,6 +46,9 @@ OPTIONS
>>           Allow dangerous changes, e.g. clear the seeding flag or change fsid.
>>           Make sure that you are aware of the dangers.
>>   
>> +--device
> 
> Options that take a value should also document it.

Oh. yes. Now added for both tune and check.

Thanks.

> 
>> +        List of block devices or regular files that are part of the filesystem.
>> +
>>   -m
>>           (since kernel: 5.0)
>>   
>> -- 
>> 2.31.1

