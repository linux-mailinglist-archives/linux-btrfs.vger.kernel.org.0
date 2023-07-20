Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471AB75A45D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 04:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGTC1W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 22:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGTC1U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 22:27:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26FB1FFE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 19:27:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K25gsb000537;
        Thu, 20 Jul 2023 02:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/yyfqV+8SrfBGywM9r905C/NXnzvivDyba8jUrd4pxw=;
 b=E72X00tFKQUvz7OF0tUK2vF0ZuKFPaMfdESXK8U2HzgZGJivdfflp9ndygX351qNLr/y
 sfbvamm7mR4zm+IOg6T89IA9EKP4LHSiGn+5ICzMYbEPbYmiRcXNqAcpgFitIGzGVy0c
 B8H/z6Hfw829g/qcmN4vu6CK7jyeVkPIBhkqhF6YGv9pYoLgsBMC7EwuQB+sR/Hl/Y+O
 5Lc5s/v74b7ZZAwztLIQnH3JA1byAEuOJnptzcPh1ZW6CXquonjcJZbwowTA1gQ4YW6z
 +LF8rM4w6WZW0gy5SytKNgbr+wqFzEyBiu+PvPMQT2BBQq+JTjjAY4TAiJnOY/CwcEyS Pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run78gr3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 02:27:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K19jwR023895;
        Thu, 20 Jul 2023 02:27:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw84d81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 02:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dyrnnjvd2eoZX3VnM7y8OLQX0lFvpChl04mepzte8oIpSNinSbXXu8no4iKqiw+AJn/tJ5g12E/hpa3ZHcsfrduuxF2EmU3mluQ6hO7X88xn9mlISOAgXOXyFZGv+pQkO4COT483h0+ek8tfP7r84YyjgR5KI9Xom/Ra8Eer4mDpUc13srUzXWGw1eMd1WvpbmbSzDdHlB6o93fvCGz1c6zYixhkPJCBq15h+aygZw/e4POYBLYIbMcu47S7GmuCS+yv47/9VRuOn5E4GZNYUtYs1xh67m4dQc0M+glVMeeO96ozUPh1hX1LUHcNC3OYGKPthkBb9EPfyLKFFomDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yyfqV+8SrfBGywM9r905C/NXnzvivDyba8jUrd4pxw=;
 b=WFq9vkTC889pZjKFWpiBPPlqzVsr++QRg32EgVZDfxG+gCsXGnseIM156ytwLEZ4Q3MKqfDp3bcq5mQeY2FeTePMV23xxeyxwyXBornvsxT/QfWyaTFQymQzP6OA/iNx5G9xKLhHPRBBRgeIMdFwT9VUs2YiTXFm+duhdGQfHWQ0s2hxhpGvctoOxj1lZKzwLz1yvUicajsALXyDuCNQwAPn5wuOq1Z5HHPluSAzxgamp6RptNzsBZ4eil4HPQ/jggxNzRb/Bj9qXfKMaDaIxV6MJrEXIEhE0LydpmYDhC6XACY39+9C+e2kmIReh0sEQa4LUxLH8hsoO378brNfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yyfqV+8SrfBGywM9r905C/NXnzvivDyba8jUrd4pxw=;
 b=VMqbm4yyL+K9QtEr4U3jYpzvl+ZuX70KoWwYlrTHLfvRnXcwU56QBqkhF6IZR+ZUr9NGFnugYll881JBBs9aTgxC5YmKQ8W9e1SjldcHR89UzFXl+wO9rdUhmxhEw6T2ZnnybWg++LKfMh12orGcL1HZyHX7TY2p3GiaHVcETlc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4253.namprd10.prod.outlook.com (2603:10b6:208:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 20 Jul
 2023 02:27:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 02:27:05 +0000
Message-ID: <b3517b3c-f966-53fe-3c70-8fa787755672@oracle.com>
Date:   Thu, 20 Jul 2023 10:26:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: RAID mount fails after upgrading to kernel 6.2.0
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>, linux-btrfs@vger.kernel.org
References: <B3M2YR.U71TM7CWM1P12@ericlevy.name>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <B3M2YR.U71TM7CWM1P12@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 600db1bb-534c-43db-c484-08db88c8cef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcbVt8Ys+4jtc4OwtHeta4VbrmJG/s3TOrb5Pb4pi4ZUFKC6t7zeLk18qBsuTdBwwOvaiOWc5Uj4vblclDPYCS9lcvYVC66L+o1Sg+OYL1/PJZ/QYOFNpBKSdFfThwcml3tLJRUbZO9tpC2Vlaf7fR1Oa+Rr7PFKWvBXKpVj/nB5RhcWZ068NUYOEwh+OJr7zsETiKJK/sRpWThWbKiz+EOF729wBjBzLQs1Ii444zs1Rox+8QGbVBIf2WNkWP6XjsflS72sMePthwUt9FDCb98YT9JzWP9OCJ4s9R+0WpZcx4/xBK658KKhxeP6jiasfn73MnAaaDK28lu8QKKAOllX2KmwbJwNIrIXfKnxbbrt5Cfc2bV1N1nyGN4QZ/xrBkdU7U4gbXaxMvxfUTd9dIWCpl4rQyFFQSFZUsJRFr2X8ktZVMh+Sgzjuz+Zi1DKHTEEekT4aTKS2lcWS+mwbJSbSWz5KwXokc9BzbgHTLxxYTQd7tC6Ppi+ALblKhmh87bIz97RYW2MR3ZR9KP0rJu5yod6u7Upgr6dEeT8Cc094ZLhxfYhi7d9XFfhs+e/P0dv0Wba8R251EtB/kDwf0BnSSq+70NfxVGgoITvIdfyeeZ582VBG82MPAOX6Q0N+PY8KWt449t+frpLcGJn7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(6512007)(6506007)(53546011)(26005)(31696002)(36756003)(8936002)(5660300002)(8676002)(66946007)(44832011)(86362001)(316002)(2906002)(66556008)(41300700001)(66476007)(38100700002)(6486002)(478600001)(2616005)(6666004)(83380400001)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXBacDc5TEFseDNlWHRvSFJkd1IxOWNVaGgvZGhXZEdablZRZnBEbC9aQ2lM?=
 =?utf-8?B?TEQ4emJGcEpJdC9saHdoR3FHMVNteUw1MTB6eFlVR1JycjQ3UGk5bHFzTStQ?=
 =?utf-8?B?Mk1OQm5MTjRFc1hFb2MvS3RtRlhYYUVLTDZpbCtNY3hObk9JK1RnblhuTjlo?=
 =?utf-8?B?SmlWcDVhcHBKRmdSVUhzZGtoanhvV2Yrb3RzNmtKcEZsTDVNZEpyQTB1RnZt?=
 =?utf-8?B?Z0ExRzdlWFFKWU1aMnlyQktZakdhVi9HOFdrS21wQTM5czZYZVZIUU40UTlM?=
 =?utf-8?B?Q2dDc2tncGhUQVVpQytCeWoxcm1Vd2lycVJsU05oS1o0aW9sM2s4ZEdoK3dh?=
 =?utf-8?B?aWx1eEM4WE5tU3ZEMFVEZzJLUUlpbGczTHQ2ZENwMjJZR2pGdTZTNDlzaDh6?=
 =?utf-8?B?WFVuZUhqTkUzbCtFLzBvZjlMUzBPMjZORWxKdkJWaTNUZXF0Y05POC9JSTdL?=
 =?utf-8?B?TUc0N0pYeld6NWd1cVU1WWpKVlA2RGExd082ZjNaVXBHUklIVXM0S1lTTkN2?=
 =?utf-8?B?RDVjQ2t5UnphWGpOakZobEVwNjJDTVEvSXhvTzl5ckYrdXlVVldjMUlLMkhX?=
 =?utf-8?B?U0Z0ZU9Bb2RWbWdnQTRxSzdNYXA0eEVrbFJBbnJSZ3pNanJlQVY4azhMQ2ZF?=
 =?utf-8?B?NnJST2FUUGRSWGpteGZHd2QzeDdBczNVS1FaNnhBTjZ1dGtlQ29oMEc5dE5U?=
 =?utf-8?B?OTFMUnVpRWNKaGR5N2JvaGVReEZFdFU3MGxxVm1RbWlFZEV6T2R6cjBHa2lB?=
 =?utf-8?B?MHhJMVhWN2hFR1dPRkpwNDZUMjNXVjhKL3FLSlFNMFJEWmhXbGo5cktSZjRB?=
 =?utf-8?B?NkpET0czSDZueGRKMlRKUVNBOHlFRkY4YUdDcnl6b1BtK21VRXkyNEZMMUcx?=
 =?utf-8?B?RWV4bnNCOEFQYnpaYk1YMWVISHpPTDJRenRHRzZZWFdMNUVFVUYyV0NjZnVo?=
 =?utf-8?B?MnVmeW9aWEtrSGw2aTZRYy9XaC9ZTGpqYWpDbUpZQ3RrSmo0VUVjcmNicXlQ?=
 =?utf-8?B?T0w3TjdjaHdPek1OVnhCS2xzNDlTMGkyTE9VaDVhSFJyV1RxbGVnY0Z5OFNn?=
 =?utf-8?B?eWRUYXpCajExRVNoY1BUZnp3L0J4MGJmZ1ZsY2VJYk5UMndVdDBKeXFXUHpy?=
 =?utf-8?B?WTArMGdsczZNeXd2akt5WExWQ29SREZEL0cvQy9OQmNwcXl4ZFpkdDJGOXB5?=
 =?utf-8?B?R0lDelU2ZUw5K0Z5U1NEbWlkS2hDOTB1OVNiczI2cjdLTVRSWWl1NjVyWkhz?=
 =?utf-8?B?d3R3UFllYmVIRmhYTjZ4bHMzSTBzVEVwNENjWVRmUHJDdzgxL1FML2hKMU92?=
 =?utf-8?B?blp0ZlJyS0x5Q2I4djRFbTl6d2IyL2RKcXRVcTNOZTFxbG0zMnlWR2dTZURW?=
 =?utf-8?B?anFaUmxiQXJoS0VrVjY5aU9NeUF2aTQ4ZTV6cmg2MVBuWkY3bUtVT2ErWlhX?=
 =?utf-8?B?c0NHcDJLS1pBUlFVcmxjcmN4S2RqZUhLMDRSYXBVUWZvbHlGanBISVA3Z3lv?=
 =?utf-8?B?anlnTERlL0pSNlpXNDVDdCtNeGVGTDJTeitTRG1VUk5MT3gzZEUrT0s1Ymp2?=
 =?utf-8?B?enlZazRGN2krMktJbmlsaEZRZmk2UXAxOTZ6T0xuRnpLUUhJdmxZMFpSYjVY?=
 =?utf-8?B?UWsrZ25aMDBrbGZNKzVrdWFCTUtnVnV2M0F5OHE4ZXNLd0tnVTl6UUViWWpN?=
 =?utf-8?B?Y29mbnZZcnFLQmdiNyt2V3dBMGhMZlpiSE9tbzVzamJKcmRHYnRmN1o3NU9v?=
 =?utf-8?B?YldtQ25Yam9xMXdzME9jMUt4ZG45V0dJRmNRMnB1a01lMFJLSUEvUXUxelVN?=
 =?utf-8?B?czYxSnJ4R25VOVJ0QzArL0tKcXhYMUZtL1R1SmpaTXM3aS9HU2EwRUxBdGJl?=
 =?utf-8?B?dkQ0aXowaVBTVk1ZbVlZelNQdzRmWTVqeHQ2dk5FV1Z5T1l4V0NjZ2V1NTJC?=
 =?utf-8?B?OXhEZ2JLS0JkcDV3ZHdTbDdBKzFFRGtxcFF6Z3VzVU5jRmY0WHhPQyszeHYw?=
 =?utf-8?B?R29nMXk4eTcyQjhHblM0ZFY5N2J1U3lZNFY5azl2czFDa2xGZW4rRHBzVDl5?=
 =?utf-8?B?VE9hQm5Gc1krZ2cxa0VHMXRZWktaMHlCQm5uNTVmckRrZi9TTVJWTEZONFly?=
 =?utf-8?Q?UiIOW7vXPLZib5dGdiFtgsfXe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n+dLg9bzW/7t4M3UPpsAJIua+xXVjEds7kajUmDW5ls8liNTlfvogJrFjedW6xMnSgPLpAl/NskegnBMGJ57ZYrRnSrIYZt2tP7Cv39KwCRIZaCwccOkicWBfYSDMVVydMkht2oEcqBq0Q9u+dhF5yGrDb1ya4//eMqqkaQLhpwtd+SiuglsyndQTxvyohsLbadmxb/vrqVKwMMqeWuH4WyfFZs7D52nAiTxu/yiHDscWtYPXtmCUNChl6E2ddl9u+PjfkKggmR/qVcOQQGYM7xmaWbERh0lgFdfki/doW0Kve5J9s76aIAqjajQyWx2or0MlXAxMTvLWbVYo52ECKv5rvBCHJ1GlR/4wr75Gu/4hmoOiFV6iX67Cs/R6wLSjOSkIxL1ITJd5b4KGFs6uDw6caAY6l2faKzr0qm+QLM66HM16rG0Cfd+rrtOMgF444SHY0Ci6ofnxMvzUB5rJXOVr3JITn2+3eu98eF5kVwV6veZwkmR+4lsoYncymzdDct95JboIfmusDNUGlud5yYppLasWmZDTq7KhBBBzJxsP6TKavYq3BLob3YYAIB8zNx5LmGN/ka1S5ofTMjbu4WYV5GtCn+zyV1o0mnklVu30WdTOkW0wm5ShUOTWO7ffj6OPOx715BVMPcUnoZRdjNcfgR2Uj7fbDwNPxa2thEyQFI/fm5xYeisgeTsK0EKq0EPHMUJZcfPQvE2eGqQBR5GURoj3n9X5xkDBJgjCk/Q4Ql7946vveCdRLTEpnPzHwJKImpxOMECQ/MUzJbBH3PwhxPsXTsqqVqvya/mHAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600db1bb-534c-43db-c484-08db88c8cef9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 02:27:05.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUbfQ9Or4uXn8QJwQxfbCqsVMjROznb9IDsT/xcMOoW7NRaKzLlQJ3N6CMHRSeCHp37KrfiTuPjsm7CdEK19sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200016
X-Proofpoint-ORIG-GUID: pGEZY4tsg_Nzc_1ZmMhGbGP7J1Af_P1L
X-Proofpoint-GUID: pGEZY4tsg_Nzc_1ZmMhGbGP7J1Af_P1L
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

On 20/07/2023 09:13, Eric Levy wrote:
> I recently performed a routine update on a Linux Mint system, version 
> 21.2 (Victoria). The update moved the kernel from 5.19.0 to 6.2.0. The 
> system includes a non-root mount that is Btrfs with RAID, which no 
> longer mounts. Error reporting is rather limited and opaque.
> 
> I am assuming the file system is healthy from the standpoint of the old 
> kernel, but I may need help understanding how to make it viable for the 
> new one.
> 
> Mounting from the command line prints the following:
> 
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdg, 
> missing codepage or helper program, or other error.
> 
> The following is extracted from the boot sequence recorded in the kernel 
> ring:
> 
> kernel: BTRFS error: device /dev/sdd belongs to fsid 
> c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already mounted
> kernel: BTRFS error: device /dev/sdf belongs to fsid 
> c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already mounted
> kernel: BTRFS info (device sde): using crc32c (crc32c-intel) checksum 
> algorithm
> kernel: BTRFS info (device sde): turning on async discard
> kernel: BTRFS info (device sde): disk space caching is enabled
> kernel: BTRFS error (device sde): devid 7 uuid 
> 2f62547b-067f-433c-bec1-b90e0c8cb75e is missing
> kernel: BTRFS error (device sde): failed to read the system array: -2
> kernel: BTRFS error (device sde): open_ctree failed
> mount[969]: mount: /mnt: wrong fs type, bad option, bad superblock on 
> /dev/sde, missing codepage or helper program, or other error.
> systemd[1]: mnt.mount: Mount process exited, code=exited, status=32/n/a


Looks like the fsid is already mounted. Could you please help check?

     cat /proc/self/mounts | grep btrfs

You could try a fresh scan and mount.

     umount  ..
     btrfs device scan
     mount ...

If this doesn't help. Can you share the output of:

     btrfs filesystem dump-super /dev/sd[a-g]  <-- basically all devices

Thanks.
