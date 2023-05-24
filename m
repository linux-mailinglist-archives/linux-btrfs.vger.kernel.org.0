Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082A570F13F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 10:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbjEXInH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 04:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbjEXImj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 04:42:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B110D3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 01:42:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O8JsdL029434;
        Wed, 24 May 2023 08:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b2PIwPGFeZi3sZG/rZ4meLZ9GgEFhe2TFc3CAhbRbkk=;
 b=nNbdD/TIfU4wnNVuua3/tjYVY53vigPFytclp3Q/vNt1151AJJdFje2V3pKqu5Wz+TLJ
 39orU/k/r9BivemYlsXhybvUzmqAm3BEVtUGPLK3rRZAvw56GYWrBaByURqoqxRryK8/
 BnURX292ViWbhIngQbgYGLHVXy9+yF/HBEEY5Ejkk6ET1UHp8/w5bdlh2FBFi+F1t59/
 bPZ3joFdEOWsI1ScFt5M7DaxK8Ow/96+Wz+0L9iFzUuwEy/IY2QI2WbbvwlJ+9dYT98O
 SKMBTceW0932Xrd+5k7V9+s8jZuHnRF2k5sa/JjNoLDduQazj3re5DrGZDDbOOFtuzKm sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qseygg23j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 08:42:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34O8MU4p015726;
        Wed, 24 May 2023 08:42:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6kffye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 08:42:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9LFZdtJFdts24GoHYb3bM7/j1yMcHpxfrcklukyxRqUxL6Rv//zaLEKBd6xtqWFw5i47ucFF9aWsLTYq5Hlhqfvu3Ujy8O/1utz1aNapB/y9LVK5Kznn1LGo+QO/JZDzXrmA19gYSf3f4LOT6z0X1EhEF46rQ0AWGZ9Xebt71uyF3Ob/G8bBwIajrYfxmP/vdBmxRKBboXyNO8uX6VHBuLjig+0k6hy2NeoYC4kxDX2rrsSY/0deKk7MQ53IUGqLE0gLA5MrrXG8oywBacht7urABnjjtHQctlYWwWl6HbCAe3xai2WI95E2ZAdx7fyksCfNTaNZP9RMI+m8UqgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2PIwPGFeZi3sZG/rZ4meLZ9GgEFhe2TFc3CAhbRbkk=;
 b=CadKr+Lo15KMn14CDe+DQqL1giLnq6boRseCSTf/n04GPxIvgVebspdEL93hm9CL47NhbiVBmimqIjMZrH7HSJFfjToTyd12sOC5xmQA6q/NxJl5gS9z9dM2t3sXUXUJaTa3qjZjmIOeuSh0Lqqe0EK+Yv9MU83AceOKTWqTW6tzcDY9YlwHmgQHs+I2BVQjN88uosChpXKhBFl5zVVYuPO6k62l1Ne98HqqK5RhTYHFstJmdicsY+aFjBZBKdFGedmEs1AyYbiK+fd2syGdWPGq7wH0ZD4ZnfL51yCYQ2dNZzY2D+BKOe6cyJ8vLv57UYODyqtTx5nxgY7cFSBpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2PIwPGFeZi3sZG/rZ4meLZ9GgEFhe2TFc3CAhbRbkk=;
 b=wUq4gDUVli3564B2Zm+z+DihPwnZ80U2BY4InZCAMAYSFMzp1Fa+Idi9ch6HsSLOXeuQYvj3uJCUSfAO8zYrTv9Jpoyu2cCVyuuUgOcXgY8UBh610VC5e3KOfaswNq6zby9xVxEous+LyQhOtkG78yLrwhFFHUJ93G/FhOn6+T8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4610.namprd10.prod.outlook.com (2603:10b6:303:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 08:42:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 08:42:17 +0000
Message-ID: <838e827b-c0eb-0ed6-7414-c2aeef5a4298@oracle.com>
Date:   Wed, 24 May 2023 16:42:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/7] btrfs-progs: tune: add resume support for csum
 conversion
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684913599.git.wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1684913599.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0190.apcprd06.prod.outlook.com (2603:1096:4:1::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4ea8f6-f8ab-4251-5476-08db5c32c7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/dGb41Z/AOmMLB3SzflUbhFCDyRK6XEzSulI7pOnG9c7WaIjcrkAjwfHNtpjstTLVbcjLEbxFt3mTh5TwciKdaTJAAWiIlKvBBcISeb5xPI2GC/jxvgtuJgxRFIriv/0we8PIyPeju14atHnljSWxpvM9eGS3Vatx5Nh7yI2rz8wvIOFiirlMWGeEkh9ylwoAQWK2GjDuFqPtUmXa9PcBE7r9uNqodsFVTQwWifdLCjQHe/Aj/yzExoGoWt0LRYsKnjl43icmuslnyE2odZUzXjLawucO3jH9CHZ+xg9NNk+dSzd39cM+hYhO527JdPvDLA5NouSZrMph8meaE3YNkCtXV+FgtKaWF8AO3C7nQk6w7NqAt4sUaj+5rErGko1G/49McIGWtMRsnG7mkRCACAptzdFpEHLouaHz2U1yqsVg/JeSwCU/IHV5I9mrOj8ZhYngicyEuvAE/a02+QR2x9Hp6T+ofx7E2qCa/urT5DkNUrasROlANYTBJkNv/FRu1We6eLBj80St/lRP0kVJuUQVuJMrWggbS668VzEjIl+T1OtxcWFBorxZ4XaOzGZyTGKVTqlweGD6Pf92dwUIe1J4W1Y+MPxCS9otiO+tDdCP8olLeb0HKJQLUEkJQle5HWeH8wsqAydk1q45+oiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(6666004)(66476007)(66946007)(66556008)(31686004)(6506007)(53546011)(6512007)(31696002)(26005)(316002)(41300700001)(6486002)(478600001)(8676002)(8936002)(5660300002)(83380400001)(86362001)(36756003)(2616005)(38100700002)(44832011)(186003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkdzUExBR3NIdWF1cktveDZaNXNxTHZLbGtxSGQvUG9LNGd1TGUzaUZtNkc0?=
 =?utf-8?B?TEpPRE9XL0dtaUlhUE8wbnVFc25RRW1WOFFCOTBWYTk1akF1V1B6eXozc1JY?=
 =?utf-8?B?ZCtuc3NuaWF2NlBCczBKQ1lDbFhFZXdac0I0QSswamN2OG5SMDQwTHd2OUVQ?=
 =?utf-8?B?OVl4SUlmTWd3RCsxZXBTaVZYdE5uQ0V3aFp5VEpnZUtBbTNvWXl0SnFFUVZy?=
 =?utf-8?B?d2RaTnVwTVk2V1U0cHlxd1F5N09Hd3Y5TFFuaEpEazFlQ3oyRHU0Ym91dlB6?=
 =?utf-8?B?WDZBSG51STY4RVNMbStYNTZmTDdWbGtwcnBXTVQ0d2tKUWZWTDR5eUpieEFJ?=
 =?utf-8?B?T21nVVpVTFJpRVF2T1FVNVFWaktFZWVvY0FadVFXOG5UMXBneWt0QnVnWFRh?=
 =?utf-8?B?ZjE5S0ZNdVdPNjRQTDZTTENDQUk0VVY5cFBnUlFJTWpiYkhOVDZEeGVkR1pz?=
 =?utf-8?B?aFkwRWdNMnZSR3JEeEkzWi9jOVRKUlRpdWFsWUJRN3Jtc3g5Sm9wQ1hNNEVz?=
 =?utf-8?B?RzhjMDJnUUhDaExpS0gvdy96WXlRenNhUUlyb1JGYTk3V2ZmQmxCL1VPWnhJ?=
 =?utf-8?B?VVFCSzRnV2JoZWI0dzgwbjUvRFNzWVFvUjZBWkREVlpMRTVXTnhCRFZPSkdH?=
 =?utf-8?B?OWRDOEhNdlROcjZuQ2J5UVFNaHFoc2NvdlYwZWFNZVJIcjVYZ0FYWjdsQlZx?=
 =?utf-8?B?TU5KVHdFcGRmdmZmL1VpTnRhSE9BR2c1ejZhalpaUjRnZ0NuUzNsMm9DNXpt?=
 =?utf-8?B?cVVIUk15LzF0RUVnTVdSazg1RTUxaGlDWXo2Tmd0VGlOODB2eHlTdGxicjk0?=
 =?utf-8?B?cmRCUEphRlNmOXRwanNpR2FEK3dSalhwOTlqV1lJUGxVT2FVNDdDVXI3RDBk?=
 =?utf-8?B?WGNaYnp0ZGI2OWlVTFJBWU5jaGJPbzNWb08zd0FqVjRydERlVDZwTUZuN2l0?=
 =?utf-8?B?MlRzaVRKZlRkQk40QVR2dVdZcFZwSlNrcG9COVVwMEIvdllDYlBKS1VXZldS?=
 =?utf-8?B?K29EMnRZWmFydlJXWGRyazFVdXp6d2RGdldJQVBDN0U2NkdaSnJFZDMrRFdi?=
 =?utf-8?B?U01zNXYvZVRaUitWajV5cUtvRVg1ZWdFMURVQUx2RXhrdG1LbW5vb25YV1lp?=
 =?utf-8?B?R0RUWVZBNkcrcTQrYUJyVmJIbW5RODg1cDdrOHJJd1crZThhOFo3T2xxWjc1?=
 =?utf-8?B?UGoxWjNaTXNYbmxGd20yOEZXSENFWjdPb0FHOFJtcU5FaFZFNXJrSE1mL3VS?=
 =?utf-8?B?bDFKQlZqZEF0K2IzbkRzYk5tSTB2My9BNlFwZ3dlcXFsSk52Q1dWdVJTZkdO?=
 =?utf-8?B?Wmc5SXVTdUZQRjBydEVkeHI0YllFY0luT3NUallnaGFiQWZMQ200STk0WkNj?=
 =?utf-8?B?eFJwa3FsNU8yOS9SQW9GSWFOS0dXZWFYbUI5SzlUdDdxbmQyRzBxUHFCMWg5?=
 =?utf-8?B?aXArclNhN0xLbTZPdEtqVldzR2JKRFZpSHdjSzI0eC9nWjVucnhXK1dLQm85?=
 =?utf-8?B?QjdaRzNxNDUxdGdEdzByU2gxdzFrYkRlb1NCSEFFQytWNURRNG5RZTVYcjhG?=
 =?utf-8?B?SG80bUUwa3ZuVDdEZGhPZ1dvN3M2ck9RcVZaRkI3d3BlYnBIalRGYTc1MU9t?=
 =?utf-8?B?dHRiSmxTcFRwcXczYU5ZU2F4U1lkWGVtWEJNSGcxa05pRzFlWHF6OHJUVDQv?=
 =?utf-8?B?TVg4aFJtaUxnZkwweFY1MkVCa3lGZGlWSFQ4eWhqdldJMlpYajAvQnp3cW95?=
 =?utf-8?B?UU1nQStLVXE4VGlFaGFCaFBNbmRCWVcvK0NSQnowL0Q2WldXSWFhSXBnQkpP?=
 =?utf-8?B?Q1ZqWE9nZUlmYUdKRGRMRGUwaU5VMzdjNEd6SlloSHI4RHV1L3Zjejh1SEFE?=
 =?utf-8?B?aDlRb2xQSjlBUG05cktDSHRXbEE4b3VRMmpYQ2JzTDc0eDQ3dDY1VjVaNFhW?=
 =?utf-8?B?c25JcjVzcE5SbE8xWjZRNVJyMnk2SFVCdGFGbGp6NFNCVHU0T2x5cWFjQm5N?=
 =?utf-8?B?ZTVFQnd6QVNQcy9yMS9kVmNFY0htdzZNUzlzeWl1VVJPOEZMUTVnNDB4aith?=
 =?utf-8?B?dUduUnZoVTRGVXlhUytXRlUxeVZBVkJoTDdBS1hFYnV4MjZwMUlXVW1FeWFy?=
 =?utf-8?B?OTZpaVhXNVU1SWZwc0k1VkhFV2p5QXVFcU1CVzdIZHpLbFo3aWs0WVQ4bjNa?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TeH9L2vkpMRbk47vOvTBj7IFQ5eQQ6gtxIT5FDZXtbQTY5tO/cZoLyTN/R4j9H+0zbM+OuRIrcs8Jg9HE4+UQ1UalsSg+AtFPauz5C8H1yP/bpxDzkNAKZcorDyZmQa2H3X0XLeeFCRB1CUsnlVKhrLbm8xDzLwi6IpNw8Fl0eyiF665oTBy49eHpb9ZkAaRXsd91B6LbvLnbZ+2BzEMWMoJUAsNcK1WJ7wtUxD5d4KvNCH1ftxCYILYhQ9TzRS+lcongnvjHPvrcF1tMjDjX/fVpinB5GzWT4gbRdPTSfSL3G7he9E/jQ2EHGY7k0jTcBuZC2mJWg5w/u3amlr2oiG4Xwgerd6dpVSRLv+gFg0QV+h2hB/cU+3zeqhPaTEQ+h9OdxAE2MqGrq8KrmYPaL7GR9x2UzRy8ONB0OS2gtZVRLdyYQhxlfQ+MLa2yO/Vgr+J35I8xaC3TbrdgAd04QY97n4jMvln3SNHLvkzMz7P7BYg6CysH1w5OQb27i0nu5JsrK1fzxrW1EN/ELoVu61WZIZlf22GZYfD8Dzs65vp61JYYRF5o9/NB1hhKCH/CuFwB/fytSEF8ClhkQqsG8AWc4B6nhgsHVgl2Mt4js1BdQSdt8mCh1RyU4hoc9fHlY7gzbthyozdbqDjds17BLM/q+BNOBj81USDwL38uvkdnNFVL2FDUw5GWj4HSzKnaY0x4XMqERz63RmTpHoB8ixGJX1KA/P04lYqQvSt1B0UmQGTIAI4K+NoNDi1ZUQ8Tt97vovQNDz/gVEf0N7klUqplzAtJuYYAcZvEsrsh8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4ea8f6-f8ab-4251-5476-08db5c32c7c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:42:17.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6ssXc7wmqZ/ko3FcDD9uDspvDXEbjeIUiy0CQu1fCWr0AcHQFg3jCQZ3kEK2Ua5TGROWfE6ko/s4JQuWYTHsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_05,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=793 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240073
X-Proofpoint-GUID: BP4WxS4eZM4oqNGfJ3Z3ZN62ChbTOX_3
X-Proofpoint-ORIG-GUID: BP4WxS4eZM4oqNGfJ3Z3ZN62ChbTOX_3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Why not use the generation numbers "From" and "To" for converting
to the new checksum and keeping track of the generation number of
the most recent successful conversion?

Thanks, Anand


On 24/05/2023 15:41, Qu Wenruo wrote:
> [RESUME SUPPORT]
> This patchset adds the resume support for "btrfstune --csum".
> 
> The main part is in resume for data csum change, as we have 4 different
> status during data csum conversion.
> 
> Thankfully for data csum conversion, everything is protected by
> metadata COW and we can detect the current status by the existence of
> both old and new csum items, and their coverage.
> 
> For resume of metadata conversion, there is nothing we can really do but
> go through all the tree blocks and verify them against both new and old
> csum type.
> 
> [TESTING]
> For the tests, currently errors are injected after every possible
> transaction commit, and then resume from that interrupted status.
> So far the patchset passes all above tests.
> 
> But I'm not sure what's the better way to craft the test case.
> 
> Should we go log-writes? Or use pre-built images?
> 
> [TODO]
> - Test cases for resume
> 
> - Support for revert if errors are found
>    If we hit data csum mismatch and can not repair from any copy, then
>    we should revert back to the old csum.
> 
> - Support for pre-cautious metadata check
>    We'd better read and very metadata before rewriting them.
> 
> - Performance tuning
>    We want to take a balance between too frequent commit transaction
>    and too large transaction.
>    This is especially true for data csum objectid change and maybe
>    old data csum deletion.
> 
> - UI enhancement
>    A btrfs-convert like UI would be better.
> 
> 
> Qu Wenruo (7):
>    btrfs-progs: tune: implement resume support for metadata checksum
>    btrfs-progs: tune: implement resume support for generating new data
>      csum
>    btrfs-progs: tune: implement resume support for csum tree without any
>      new csum item
>    btrfs-progs: tune: implement resume support for empty csum tree
>    btrfs-progs: tune: implement resume support for half deleted old csums
>    btrfs-progs: tune: implement resume support for data csum objectid
>      change
>    btrfs-progs: tune: reject csum change if the fs is already using the
>      target csum type
> 
>   tune/change-csum.c | 461 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 418 insertions(+), 43 deletions(-)
> 

