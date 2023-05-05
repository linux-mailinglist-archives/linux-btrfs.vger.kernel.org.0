Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D306F7EF8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 10:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjEEIZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEEIXw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 04:23:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFF618FCE
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 01:23:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456YXhr011402;
        Fri, 5 May 2023 08:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=CnY9L+QS+yFdMJi4gPzmTw/R9hIzRviZWweZrOMSHPJeufA/4VpnxjEeJAks0p/ucf8L
 Z5VtxVYoS6rn6wR114ZYHfKkeLn9cT/ZbPdWr4PGc6+RJkNai/pm8jK/KAYzgvY9q+OL
 00EdGkCLOPsePvTYUMPLHFZiXA6KNutF8zo/XaoTlqBdp46FckHpBsj549PVB/z9XYbz
 BmXCUgAXvki1WRBQhjo/UQCOy/Z86m3jO7dztV2M5kOFcVxXsJjnz4ppqfT0WhV9l2C4
 +BV4O/bI1lqTM+xOV2Pk63H9aJ+2v1TPx2et7HT/l9mLH89LHDXE0EXdah3EiWLcxTxE /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fv570-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 08:23:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3457FYap026806;
        Fri, 5 May 2023 08:23:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spfvtc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 08:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIpGLUS+E/SBkCtY35ngr+EHrioC/pVu/wemAYy92zH+tUkwvQ9J3coDxBsVFcSqOAwpBu2kjFSouyA8iDfBACAEzf/O8NmcUwuiNqjnOpbUgXxXGpGTFkOxlsAEQ7C7eyZqfNjkgx2HFrXZbX3TVl7A+1yjYTLXdk5+Yj1xi3E3SoLI2T37dQqaBEaAMSc/eRZRLEuVduPFEQA4PS9zvnR/8Qp6iSVT0Gudt+Zrk4gOCAtdK2MDdlzb8piLuPCuv8IrGv3qiVB995CGVqDqLVXlkc9+wupFIND5OiYqFgViqiXjRVOm1nbhuUZ9g3qvoERN2vg7RZz7c8+is0PRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Sx1G6tny3PZVn6/4lgvTyt6SbQl+AyaCFqAnINxKhYEMdHVOq0dqqxrNBbjsUAtFhMuKKKodMQ230zC1y6vH8DxXhSC8YS02XFkj5ti1XpYnc9ebnQocimM3iPpP1O9GI7gvUU2dqQQlSzS7BfLB/pZsAC1Lvl431Zks450PByDNWqUip9cnqs7vH/bvyrLQq8nlJK24Aku//D5yKCX3UTPyIzVZvYygxw+oUyF9C409H9E4Ht5bShbZ0zJgiwqK3rT0Y+Ff3wKgK0X5mQHNZi+lbJfW4PeNnHf8ZLjpHv95M28n58FrQ4GQ2kkJDeWZAFn+jRtcqWgHQt32xs60ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Qzwm1wKJ/8IxFIzI3gLoyOTT2pdLoE3IVTDVmXAwWAKypcL7ybXWobuLQHtO8XJo/B+HObiuF4itZaMgR7PfRfQvYb0+cG/ctZZPIv44gzp9OZhbYXaoQChJSSRqrnwSLDdRaH0WxcmasfQ2ktxSeHo/5DYqmJZy+Fbo31cnlxQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7176.namprd10.prod.outlook.com (2603:10b6:8:f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:23:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 08:23:23 +0000
Message-ID: <d9f66223-3487-34ec-e800-f24bbd0998ba@oracle.com>
Date:   Fri, 5 May 2023 16:23:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/9] btrfs: fix space cache inconsistency after error
 loading it from disk
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1683196407.git.fdmanana@suse.com>
 <4f6a98cfcca190f03b9a729d7cf9c191c29032da.1683196407.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4f6a98cfcca190f03b9a729d7cf9c191c29032da.1683196407.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 982a8d4e-bffa-4ff1-ddee-08db4d41fdb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ojf1ycYT69QWAl/WeG2jzQB4IKSdWkIEQyNvhcI1RtF2Pi/G2yIoAMyiBhsEAX/ffZTaLRFq6j6o88Vze9EJO1Dj56edSFIfqQcEdaRGLxQz6nIImgN4W3sJoiSc+UNdJBCN5DGMQgbTPcZ6xGSDkH7hh/A5wWeBC0a6m1P8qKj8PV7E+Cx/oeE817eFIHNWLxZtZzGLMwcVuVoj6wBaFNFScpzUdvaROuQ0oPDV0I00cDERelYxqvFVzZY6HCLConAkbFkhnHIfhE8QoXvGZVwxvsE4yOVVYGb7d2d0AJpbhYYURcARoqKeZimBxqgRVkYelPLcs5MoPSXz4yPAZ8UR3WrIFq7OJKaTn3VVVHrmJTZYaxxjxcNaOsFr5Yw0x3UtzNDPz1WdtZa9B1G0uS89p68+HW+p/4Z7Eq8RrgT/KXCIKV4THtDrnBzqu9KwjojEWXw24BT7Wf2yIXUqxKFnXfM2GCZeL6/Xd+XaHGWqFw/O/le20jQbDlOMM8206LtFDTzPuzQRNazOpR3D7SFBh0RPQxcPgbk0J7LkgNKcrB7C+4R53OM4rJiE3040dAw6C6V+vGcqbHMN4su1YpXRyPAIIEyw0uWjBI1e9hWbfAm7EraQJk0K9YszbxPaKhnJlpbPV1r7pPr1T30wyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(44832011)(66946007)(41300700001)(66556008)(66476007)(5660300002)(8936002)(8676002)(6512007)(26005)(6506007)(31686004)(478600001)(316002)(6486002)(6666004)(19618925003)(2906002)(4270600006)(2616005)(186003)(31696002)(558084003)(86362001)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhWNUFzd0hwSUdaamNkeVZRRk5FRTd1Nlo5dy9UcnVaZGk4Y1BqaXVuczR0?=
 =?utf-8?B?WlFhRDY1dEFTY0tnUXlEU0NKWFVQSzRuWjR4NmpsNEJTeVlPanhneTFMazZ3?=
 =?utf-8?B?TXNocE9hOSt1OXM4WkRuWnZCTmhEMlBSRHBWMVFSOXhyczZvN0d0R1pOUVBT?=
 =?utf-8?B?bnJ1NTUzeWs5OXRMelpLTGNmUW5vNGtjejVOazMzdm1qcS8velBMTXJPQ1Zm?=
 =?utf-8?B?UEhqTkxrZURWV1pSSU9xanVYVEc4bkkzb2tKRWxaTnBPQTduOGp3UzdyOUJV?=
 =?utf-8?B?Ujk5UFFvdjR3MURUdFNBVkU0SE5JSzJwa2RlaC9zOWhRYnl3bmdMbnpWRy9I?=
 =?utf-8?B?R1cwYkgyS2xBMSt5NXdKcTdEUDhERXhFQzcxODlrQmhDVXpaZWVsaVhvdjNr?=
 =?utf-8?B?RDEvUkpSeDREMVFrMEhkODVnMlU5akpUTVFWUG1XV05reUJzTjQray9DL1BQ?=
 =?utf-8?B?VW85eTQveGR1THMwWFdHdTVwc0l5b1c1eTNBRzB0OUpWQXB2bjV2RlRmNmhw?=
 =?utf-8?B?NVBGRDRqSXVxbkVOSVJFa2Z2UjZ6WjFsdXNubkpNVlZlK1d4MGVmb3dBTFNH?=
 =?utf-8?B?c2lWZ1FMbllTZ29ybzVIcUdZdC9hei9RNlUwVDk4NHVXOW1xYVI3dlVLNHdG?=
 =?utf-8?B?eDhwMStKelg4WlF0c1h3dmZVK1MwMzl5N2dnSDd6dkoyelA4Qm5oUzREZEdC?=
 =?utf-8?B?Vk5ZNHdpQnd3Wkh3aVU4c1VIa0EwaU1iZkN2eHZCSXlFMzlGSnRFTXE1UDcr?=
 =?utf-8?B?NXpPV3lZeVlja3U2cnNVRmFMeVZyUnRBYjVnaGpuK3Vkb0kraU42dllyc3kr?=
 =?utf-8?B?SU5vdkpWOCsrb0dXVHBwTGREU1VtOHo0K21FMHBqSmNMcVppYWRuQlVZdW9i?=
 =?utf-8?B?Z1prRWJmM3ZOcW12U2ZrckNwck1zenR6OVlONmRFM2NGejNkZ0gwK25vMldp?=
 =?utf-8?B?bmdLZDYrSytrYWlTMTloZ2lUanZIZCtzNjZuMnlZMEdzdUx1NUZFdHJIcVlj?=
 =?utf-8?B?dDBxTUhwZUdYZjNheEVZY3ZHaFlVVDFMTWs0MEtNd1JSTG10M1FPWEthSkpK?=
 =?utf-8?B?T0dVMStnK25SSTRycnFTU3JRWjVVUHN6Qm9tdTlhd01hQmplMXdWRk9BaDJG?=
 =?utf-8?B?aXpZL1ZpU29JRjA1WHF6TC8wYVorWktNZG9vai8vVEFiNU5QN3Rib3R2VHNi?=
 =?utf-8?B?OGh1S2l5aEwxdSt1YS9tTWpoVXRJckREcXdUWG1icnVMUmQxWjNRaWFnZnRt?=
 =?utf-8?B?ZjYxTVd2UlAyNlRNVFRhbnkwdWVwc2I1eW1yYmVPenFhMVVQMVA5OC9IN2Qz?=
 =?utf-8?B?ZmxsYWFzc1hoVUs1amV4ajR3R042UVFGelA4Z3lYQ1ZUeVhZOUpMZ1lPY092?=
 =?utf-8?B?M1JiWU80amVhVnBYbTBDNXBEbGtqYUNxc2F5Q2ZlNHk5dkYweWttK1VHL3Vp?=
 =?utf-8?B?dTE3czFKM2ZScmpFcnJSOENtVGMwU2tqSVBDNmU1SzFyWG9nYURJbkRVaE5L?=
 =?utf-8?B?eGt3NGlzNDVubXBNZ1FaK1hqRkprYzJaVVlCcDIyeUE4RlJrS1FmTmpXOVhx?=
 =?utf-8?B?TXNraVdOSEd1bEFoWTBQbWIzMWhkVlZ0Ukgva0JuUlVtby9XMWRZMVVkRW5p?=
 =?utf-8?B?bDlDT1gvdGl2MUY2UmF0Y1haRVZXSmF3c3djUVBTcXhLejZrUkdNZjBkajJz?=
 =?utf-8?B?U3R0QlhGNHdTbHhVbERid2NCL0syaXFnV2htcVQ0cHcvei9WL21mRE1DZ2tV?=
 =?utf-8?B?QmU3ZUtSR2o4NVd0ekdINU1aTjlaK3g5RUVRb2NnaitsNWNLK3hMdG9rR2xJ?=
 =?utf-8?B?eXk1OGQvdmdGY25TUWozOUY0dTZ6VWI3RGpKRXd5VnFjdndKandCOGNNZDQx?=
 =?utf-8?B?ZWdFcFNJTEp0VVNvZ0ErNWV3U2prb3NzcW1aZHpqNk5yZmVHemFpNEtoeUpu?=
 =?utf-8?B?Ykwyc3cvem5SenJ0Ym9rWkJtM1pMWDUxSjhub05tL1ptNXd2MytPcXhoREoy?=
 =?utf-8?B?UktLUG5sMkQxQnB3OCt5SjQ5ak9FaitxdnpBK3VUTjZnYWxGZDJ6SGNXVnhM?=
 =?utf-8?B?N25lRXEyS3VVODlmb1dmVkUwem9nMHgwbG1MSGJDeXpwUkRzbnlXQ1JuNVJ6?=
 =?utf-8?Q?N6nFyXvVeU2sKhDyOXG3pydXO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eoWv2LOn+OZt3iTDWrEt7eMawexEtfA42ftqwmvYUdxMlhG7mUKcy3OXtFgJL9GBnXzMtlEtnIv9LV9l8r0TpW2Qgl+7PZSo0P/5Eo0XHEvwfu3trIJ/rY7f+DtT7DWcmoRboUwxi/Ab2PsJRJoHsQuE7TzaLz/yskUNqd5MevzP29fU2tupVZ8HAyfYzLUh616HKMzHfjp6A4mzzQyNvPm8SeHZzKbYLz90tyqJswGehDr8phD19/1gPa2x2Pq9jozpmeimg3d1iLMzGBX27ataFAGMwkhJbs4Dg0APkWbsYpE2ah5YDMcsxslXuSyMkHMYejDQQc+O+fNgMINjj4e3MAR+GXW9SrmJxH+uXNXDSCxtZlBG+46R40K1x456b6azbL65BqKRl1yYC4XjR2+Y6hBeZ4HoP/kzN98W/7RTOQabVNGSA+agGQFJOh8Auzh4wernWbV0WBxKU3wNvEnpfV4gI77fjgU3fq/GrEsCa1lWPUvJ5sGSog9+M1qrzu5w0Jw2UQikP4GGI7ZyN0BcxPpzGrmc8v3xBEwv5854wWToZXQdEA5IM1pEaxooefuCgf8+0y7CgZKwCNXIW8sWnDum1wpvHbgNLJnraaEjgo2IoDNikgX2E/lB7pMvcej98ADkJ36dcI8V12DEbDNl+eTJ8SJ5GFK8HvY0r1ihiRI5SmQSeRhRGrCiI7Buf+64fjtmMcloZa1mX8Cq0I0nYm8xb6ATilRznobWulBvSU1ulpWpzsm3tlbalH760l0UzuEPt0aMJ4gB84cJXAYBriEpfL85shoieDI+sf0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982a8d4e-bffa-4ff1-ddee-08db4d41fdb1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:23:23.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ9aq04fSy3xIdsEvM3f0uJvSypwo92ZIcgI/iTfAe5iIChZZWXR5qrFW3ECKkWcJc00dmOOJPVULvJBftzcsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050070
X-Proofpoint-GUID: cuhuOqvpQxtrU2_2kFpYjeiTVYzupYYO
X-Proofpoint-ORIG-GUID: cuhuOqvpQxtrU2_2kFpYjeiTVYzupYYO
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

