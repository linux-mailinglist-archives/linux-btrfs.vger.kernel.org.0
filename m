Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CBF7BF030
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 03:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379240AbjJJBXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 21:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379241AbjJJBXR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 21:23:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5280CE4
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 18:23:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399NxXvU012712;
        Tue, 10 Oct 2023 01:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QmvnICQgwePthbXAuQvlqh7eVAhaflbphsdiMzeF7bw=;
 b=hVzYFpNq77pBUmMJL7K45XkbDGbpxY+PENBHnkpjdruYOG42/yq6bgWDItHZ0IA3zJr3
 O7drScAX5o0hYgUX5hXHcamAcsUI3W6RtQG1dZTcZ8ZKGqvlyq1ZaKP3bj5N6AGmJWWH
 zY0ZWvwfPr4J+6/XIiUYsLD0oOJjpUbxnycRWGpMsloijJP4+XTpbnagPVE20TVpf2uJ
 ggjkFIxFfwxiU/5cH0SFvtmaiBCOO1z1xtBlAbgN9MnXI8I62PzvyWxpUIzMpSCjMgQp
 9rrSwGKDwVIr6iY1Dv/a7tkIYngzGeS/H27kV5z0jjpUTCESGfSj1uTX/i6MU7X/ZyTh nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvukwn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:22:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399NCeWM004728;
        Tue, 10 Oct 2023 01:22:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws5ryy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IALtnA7inG+NAoMuBZEujsH6N7jyxzMDbEs6KaJyeS2lR2n3zpTa/9RFQf2fecEW6ZaD0BzYcgslu3V5SgQ3m6eILkZ+CtdNScCa3l3jn7RdpqVkUXd3hyp0rtzDSUjz4PoP3UZNtm9pHTRYnO8YJvt7Wcyoz9FsF+v5/vW+GtE3r5xM0gbVEFQpMk6wQfqjz/39TpcKvo10otQ6Ygifr+/M5C7e+w5AyWLXUl3fcVYcgKtuPZFOVFNC/zsc81GDimr6qmIHPD9EUgARzHayQOxDVcK3bqdhbyzp3CsVQ8Mkwe6iUz2Y/O6Bk/M2LX0CtsgxXtCX6yChC5XAiSGF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmvnICQgwePthbXAuQvlqh7eVAhaflbphsdiMzeF7bw=;
 b=I+u3jplyAxqfHycNmBICfVI3SZHE43XS+U99NVQtk+EC4XXHy9VN+j3s9q3wYyktadx98TqGzsByBBTIu4fQWE8a4OvKewD2eZtX8U8iu7J7PYn1DLH2dzIr20fCTpsXQDicQsIvmx9bDPrwcVxgA9JduKLmlRa869bebHfYOAtAClp6ShzIwAXEDbkjlznCnxK25UJIkLjRLrlGSIRyD8gobVtvGIRorTfKzpjYy4cNMXUFjrPNuUCGWyXRJPgp5hbga0G+24s1S2IHpzaXXLNKWEPL1rhrPe/STxJ7g+LFozIH/Be2iPu5qVSXbKMJhKYTItjvyl0YUd3N1JoJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmvnICQgwePthbXAuQvlqh7eVAhaflbphsdiMzeF7bw=;
 b=Ousmnqm8g3IxknSC6GJX/thy7zh/arg/Mb0rbnoqjmmpWgCV80y8Sm5Xr9jH7pU9NPrX/c110IZf8hfis+uHgBjxMqMuNBTuXb1j7WkKgzs5EQBRmsnfm/dktYMxREL45bKsXbAtpLyb5BrtXZkjIeIMPopes0tY/hHh74gaCt8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6322.namprd10.prod.outlook.com (2603:10b6:303:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 01:22:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 01:22:54 +0000
Message-ID: <fd61f24c-8840-4e1c-9ce5-923be7f98dde@oracle.com>
Date:   Tue, 10 Oct 2023 06:52:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for
 clones
To:     dsterba@suse.cz
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1696431315.git.anand.jain@oracle.com>
 <20231006150755.GH28758@twin.jikos.cz>
 <9cfb8122-4956-4032-b9ab-2eea8bb19415@oracle.com>
 <dfb5e1fd-6eb3-b0bd-d5c6-0f5f9179eec4@igalia.com>
 <a17167c2-fea3-4f48-b381-d72585b35845@oracle.com>
 <20231009235910.GY28758@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231009235910.GY28758@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 18af4d41-3140-4c5d-d899-08dbc92f6d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLerYqd67YVN+w2jQltFpSMi/RAuwe53yNk0ktZ4OFHBvDt/dWDnhCNgerdKQFubWyITl6m82IsbcEHnx0nF8bxyEpyvY1gvlTYsVVJfYf6TWfpEs0tatRbbgiESCX3egrSgZB31dJbggB/ld/pOAXyFkM0IvryYbp6KA9f6pV4pV5B6hgMOUFaYhsSjhMtmTRSPYaggzkMSXdKwWLRpVbtmlGplO52TOumlc7yePc+kLKBHtTu7knw4z7LGf5HDAIw2WVkqkzmc+/Y7VZXWGF7jWi9naGQpRhIql6fDif09KXd+qXjZneqQNEUXDuDZNDCFuVI0tVYe/2HRx1hTpL/GllNTPMcLL1SBvJzeyeuPwkhRth99wXMnYlH41CApGDKirVVIP6oGZBn171CIUGoPgN3l0ckjCDwDdKLXGvoWaq0FzpgM8Lw5hogkfTJt4knxu4utk/4G2/PQFqYur7ZX9fjeXqjKyaGplZvzOhjOJHvrPsOSkGetfNnXU0WsLYTQFg7z7ztKDfZ/ASzqnvSaNCrbpBWUV6p6bnntmwLk0WnCmLMNQZTyVY8I8PkVInT+hZTk7w7LuyTWwerdtLFVekr1+pwmmUk/rbNMppvxU2HpR6VX/UWmvrwA3byXD8oWZM4wsA1+DqKJB/MUAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31696002)(86362001)(38100700002)(36756003)(31686004)(6512007)(53546011)(478600001)(6486002)(2906002)(41300700001)(44832011)(6506007)(5660300002)(8676002)(6666004)(4326008)(8936002)(2616005)(83380400001)(66476007)(66556008)(6916009)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5kdTNVSzQzN0xWZ21LM0pPTXJRZXJLSlc2c0dKMzJZSEVIRFA0a0J1UTFG?=
 =?utf-8?B?cGZPUnAzYUJFZ1k4cUlNcmx1ZXFrNXpvc0NoZmpEMVR1MHY2Wk02ZlRNTFpp?=
 =?utf-8?B?YWk3WHJLdnlmVFRJV3hnNWNXUjRXTjJzNUd6OVZHYWQzYVlGaTZScEQzOXNX?=
 =?utf-8?B?WTJyNnZqM1BBdTEvN0NNV3Exb3ZabkJiUHpwRjNQOTVQMzJDRiszcUlTSHVl?=
 =?utf-8?B?dDB5TXExcCtNRExtMmtpclBKOWdscnR1SUlncUhsQlo0WUIwZVdjbExjRFlD?=
 =?utf-8?B?WHgrVktZRzdpdzJkSWdTamJZeFRORUtabVgxTEhoZnY3N1U5b1EyZjQ4d0NB?=
 =?utf-8?B?eFVwNkozYm92Y3BoSU9vMWJ4SitoZkVMTFJYSTAvM2V2cUNEUEtONFMwYUdt?=
 =?utf-8?B?SG95aUdhZ0ZVY2dnUEt3ZitvLzV4dWl0R052c2dpYURibXFiNnhSenpYZW5h?=
 =?utf-8?B?dnd1TDIwemU2NmREc00rdEZJVXMzSUFtS09XQjhqeHNvSjN1Ukp3SjEvUyty?=
 =?utf-8?B?WDR2QVdWK1VmajhHbUcvenVLM1FhbXkweGtkWkdiZVRjSit0cXF3aWd0a2NF?=
 =?utf-8?B?c2RkdzhhZHpTNWF2ZjZVSDBGeWcwc002a2poUXdsaXp3YTl0Q1VJdjRaQjVq?=
 =?utf-8?B?YUcrb2dkRFRzM3pKUno3NDdaczI1YnhLNVVNVDVuaEZHWXdNMFVGMVdtTEV5?=
 =?utf-8?B?blY2MWJPWnArc2JKZmU1ektwQ0ZGclNEWTdzUjdPZUZ2UWhsN3R0RWJHRmFL?=
 =?utf-8?B?eTBkMTVyV05ST2g0T3k2Ky92Vzd1eWthUVFMUzN1VFp0aUJza0tvM0gyd2xH?=
 =?utf-8?B?cmtDMW5LSzFaNlBQM25sQVp5czd5VmFaOS9sdjU0REJPWUgwcWxlSGJpVkhr?=
 =?utf-8?B?Q05Lc3FUcnJTV290WXNTR2lNVjU4WERiSjhFZ3kvN0FiL21GUG5rMytTUG4x?=
 =?utf-8?B?Wm9aY1l2RmE3VjFJL2JyNVpjRnNQNlR1ZHVOeEdwQmhHN2t1SUEwZlBRdHdt?=
 =?utf-8?B?b1FkRXJhM1hnWGtRNFQwOERJZlNzMTNRd1FPenYxNDgvK0tiWjdJMHZQSEwz?=
 =?utf-8?B?YjVYVlZIV0RXbWVSSmEvYnR0cnBDWjBSc0R4SlJOa0o5T0U2WW5xcityNnE4?=
 =?utf-8?B?VmIvUkpMV2dYeEQwTmZpV0p5VTlocXV0c1RzbEtaVTlaV3V5K08zRm0rR3hs?=
 =?utf-8?B?d01lMFQxa3pYSWM2NVN5ZHJoLzBTNy9ZUzkxSnB1SGdLL3VjdTcyWXJ2elNE?=
 =?utf-8?B?eUxlUlNSMkpTbWNFMmJNWUtvQ3I2UXBrWDhOSHhha3Q0QkNLZmNxZU5idjRz?=
 =?utf-8?B?ZTZNQ0ZFRXF1ZzJ3em9ha2ZnckFseVQ0L1liRjFWVzYxS1gyUzVRQjRxQVVo?=
 =?utf-8?B?ZnZYOU0zNHFXZmFHQWN3YmFDMTR2SFhYa0ZaWE1MREE0aHBsMDZVU3ZtY2lB?=
 =?utf-8?B?aUxRaE1GZmdZeUd0SVl1ejAyRDdVRmdmRWxxNGZEUGFoa0VOZG5TYlBxQkRt?=
 =?utf-8?B?U3JJMy9XYmpuRWFYRTM4YkU2OVV5NkNiZTc1OEdIMU9nVCtpczVRMk1QR1Ex?=
 =?utf-8?B?aXorUlp3OXFOUnk2bTB4TGdzNXdlRDlIVldoTGovbjJQT3lGRmphRk16Uy84?=
 =?utf-8?B?eXk3bTBLK1hpcHlTOFAvQytNWnkyaW1nclJRUmc3M3U2Q1hkYTF3cFM2dk9J?=
 =?utf-8?B?dnlMV2t4eTR5Z3RYYUZnbDZvcTFtSkpiWTgvMzgvcWpNL0JOWnR5bFM2VkVC?=
 =?utf-8?B?eWt2RmxCN1Q3bGF2cGpyVzU4OWp1ZjFJdDhXSGZyc2w1Y1VXaHlUL2phNlhw?=
 =?utf-8?B?UEdCTFhBcS9ySHlFajBIS05MaVBjNE9salNhUXFlNXpzVmV3bUFBayt4TktF?=
 =?utf-8?B?VnRXOUVTd3ZiNVg1T2NndjZCMGY1LzJlM3BWNGhrZFR6S0FXbGRXUVhzMDBi?=
 =?utf-8?B?TzNYblJub0tCblFHbnNqYTBKdEJpajdkM1phTFo2YjA0clJKY3VVb3VIdnNJ?=
 =?utf-8?B?cGZXN1diMWdWaFVUamlkaGp3dGYyUnV2azArMWdvbDc3OVNHR2c5M0Z2ZnFv?=
 =?utf-8?B?TWlkVWFjV0YrZEtPVERnRDd4TGhmZ1VWZ3hKYmxpTkhLWU0vL2haMDZJTnZQ?=
 =?utf-8?B?R1EwcDVMNWMxY0U3cGI1azVHQ3V5NUNORVl2clhZSTVzTkNRdXd2NUEzbWdk?=
 =?utf-8?Q?6oY/LRYhffAH+uQiiOzAHa39tqjpnU9g63zhq0sK8cMO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1cIUmB3+ehBoswhHtHn4Ds1twWqpf8LiL3xITuYYxxDQegr9Kz8RqZ9FMypOJWd//E+ozC9P1iX6JEPNk/ow+jRe8hRmyco89NFNvwCaRyMqi4reoJjt9lb8jlrWwWGU9i4J6FdXSY3hPPtnYuaIydEDi1tVOb68fxJ1kDICLP2qlufRI5iDzcOeUNXKOrvcST91cbGo0eMlfM6/mJhwIvmCfyGqluMKCT3mXv4CoTt+YF3FBLTwVHalZJfLrRE2V5rHhqUbi7MbaCcIqtbJD8yYWjiqtWtaLH7OfJUu2SjbRSItZAk4/DBirmMoGcfOowhKQVZHXRxVs6lLoPBHV9rpEMlTJgn3AC2W33FYnQEJKVXl2VUh03iKef7YimCWr+TDD0TGYb9q4TeutSLELgx822s8nTeaAa6XZ5eJpnI3fyouwCg1XkzfKNoBjKVm1TJ5ac1m0T1pp3/P9nDtZx1CFfsJhXTLErOEWdAd8sKwIgbuCFlarXxHCxWXMUmX62w412rPhwjSrnhqkzxvK8Vgwcud9D2qJjIc6ayX9sO1m3AJDsn/GQj8Fuqp6zqFY4RNBt1XuDXezTn9S4YX2XnBZfJbMXZcyNSeyu9CIyt+tbWQmj3hHY/UtjKM69l7km9BBYQVdjDOJ/4VP0MqbFuf5rmW7ritkWimp1aXJMqtRGm+vzEdyN7ooJilGIKo1oYkKtXsyEJ39XdpBvXboS4iv7DDvfe9NKSqeVQNQA+U9uIrWg4Nh0q3M/i7p9ZV1KT1G1cTQLIqXhctjVRWMoOG8OgPQBbeFZtigSAFAXSJb4zEyRMk/Jau5PEuohZH2pMQF4epfdvQPY/OK3MmQg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18af4d41-3140-4c5d-d899-08dbc92f6d31
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 01:22:53.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRATzcXpt7BRmX4HSW8TK15fr/xikZfLO8SxyLKiVP89EVR95Xb4fORyJAE8PPyk7k2gorJgKsDkv+kshQ1GTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=991 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100008
X-Proofpoint-ORIG-GUID: n1UNd_YtCgB0funVvYrTSN9wZSw2XN5z
X-Proofpoint-GUID: n1UNd_YtCgB0funVvYrTSN9wZSw2XN5z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/10/23 05:29, David Sterba wrote:
> On Mon, Oct 09, 2023 at 01:37:22PM +0530, Anand Jain wrote:
>>>> Can Guilherme send an RFC patch for feedback from others and
>>>> copy suggested-by. Because, I haven't found a compelling reason
>>>> for the restriction, except to improve the user experience.
>>
>> My comments about the superblock flag are above.
>>
>> User experiences are subjective, so we need others to comment;
>> an RFC will help.
> 
> A few things changed, the incompat bit was supposed to prevent
> accidentally duplicated fsids but with your recent changes this is safe.
> This would need to let Guilherme check if the A/B use case still works
> but this seems to be so as I'm reading the changelog.
> 


> In a controlled environment the incompat bit will not bring much value
> other than yet another sanity check preventing some user error, > but
> related only to the multiple devices.


Agreed. Anyway, the kernel would continue to fail the mount of the
duplicate-fsid for a multi-device filesystem.

And

    $ mkfs.btrfs -U <duplicate-fsid> /dev/sda1 /dev/sda2 ..

for a multi-device filesystem will also fail.

Therefore, the only avenue for the user to make a mistake is
by using dd to copy for a multi-device setup.

Thanks, Anand

