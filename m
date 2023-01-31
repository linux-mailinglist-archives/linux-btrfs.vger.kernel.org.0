Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C8682B2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Jan 2023 12:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjAaLL7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Jan 2023 06:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjAaLL6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Jan 2023 06:11:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D35768A
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 03:11:56 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V7wwMA024134;
        Tue, 31 Jan 2023 11:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3xb27HL7CtPMHR53PrC4eGZtN24CTcrNxAVRm3iU+wY=;
 b=zFx4zZQZ/QCh/304O0W0oaCd/0Fa1z/KH3hMLtA50XpSa7QDPqnTd2EL3+LuwvhGlKwI
 e6I5rcf6LXa20BBG+U7QrQ+FLdcCTJnThui0UoC76kTq0/wS3lC4WoJkNwNl9B4vURYG
 DSBpK0rBf2ggnO36xU9kpuxNlU/1TDfwtBf+DAhY2FwIlXxPNhKb3eVnXhjMP6UK48Wf
 YPkpAW09SbrO5aiCaYgQRdSnW4dQDlF5onKacuqkdcpQs7fxgYZ8RiJ6kpTYNpzggQ8I
 QmywTxpcfZ8Erlh8TQoTAUD4lstDEdY5whI7YVxbJGWx5j5+y40UKi+0PX3B+puLMxmO Pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvrjw867-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 11:11:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30V9hvPi027778;
        Tue, 31 Jan 2023 11:11:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5cta15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 11:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJtUuV9O0lQZKl9XJ2XUSRmYaOKVzaNhpu79J/s/dE0/0X8nWQSC5TWzz6TgTLhnctJPMujq+V6HqYasxHEKs6q/QWx/wEeMVR/OyqVNf9p5LvicRpnHV+3+TG9380su/1vEvlG4b+WGe+aCZmzsaDCdpncdv/MIGeuu9kYzsA8t8iANbHtMqd8Abg6sK8Cr0Gn0eKWypnQAzAqK3EqfjG/cplGpu/3wck6DATWgHghTw7he2mhu4hTURzpHxKUOsETOa/bzIycwoL1GoVnTkjGrdMJlx5HB4alTZf2TBW+0MwvjobmfyJ9K6ptRKJbXSwL+ksxYRdyIvAJDE+Y9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xb27HL7CtPMHR53PrC4eGZtN24CTcrNxAVRm3iU+wY=;
 b=jhXSDMOXharPkJ1JU+g4M6NyK60sS+Lrqqr+BSz4SPP3ZIcxD843fpkgnEtrYOp1WnSO2izCg1MyDJa7qMxRbG+ANzohM5yUKPvb0JEhu0IRQNf7r+dt7nH5lH1KYw4F6r/L7v0+xVTrWVyM2ONok+9YSeXfHelrgkNrXx8sfxhKNaFo+4kNX8uLRPwXEJBM+QuZTy174z35G93W1HSHliN0PHbIoEA0tBShnqyWWYfjZp39yEAYmvSqU0xYJZ6HJLjeyl4kTg2mPXJuBG2G7Fvb90vZXu+bFMQJ5AVrWs0vWSF+njr7/bkIQPySAW+pkpZYgyc6e+yEe2h2j1jfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xb27HL7CtPMHR53PrC4eGZtN24CTcrNxAVRm3iU+wY=;
 b=Le3gIuAJzEqPxBeASNpB5Sk4jNwPGjSQ1xk5J/2mfeND+tWW+Xc4r5jt+F62zLwYHE57Pvvp4K57FW45lhX4HJqygKOWowf5qf3WYXtrLXg+yI/G/YiiU8JYKDCRCb6whQ6nJgCZWT9BbW+F27aM931YQG3AIZb1BnZyfiYwpF8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5792.namprd10.prod.outlook.com (2603:10b6:303:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19; Tue, 31 Jan
 2023 11:11:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.021; Tue, 31 Jan 2023
 11:11:51 +0000
Message-ID: <4fd172e0-bfe5-681d-8e81-bc5955922456@oracle.com>
Date:   Tue, 31 Jan 2023 19:11:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: restore assertion failure to the code line where
 it happens
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230127133202.16220-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230127133202.16220-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: cf08d4c6-e8cc-4918-48b2-08db037bf3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Op7RA+4ej9E6IeZXR4ZN7YtekwbMkDP08oL/rCwlkyxSEg4uTaMhZOLzWaoEkORvTii0JXMBvmYEUCHtFCpTYf0RW7YavokE9WPyVA19O//KKM/vj7FPUPoAzNIPPDUzg19ujTOSRcOugprjdop+PbzYmm+y+kjYutnyeuCXRVoJyf+l3OFxlr1EMGRMM6dG7LGCW8CvlgYPcy1Le9IDrMT1Hv7BK/zHTBo18DOhb3UcEowJ4GTVHc0sX+pAUKYD1Z/ZIjvwaCAmFgLzV3QKyS9FnK2qN7pPewkc8ufhIWE2lmjRooMQnYQ8pDuHJn9gP9X8dUNyD7aF0AdCSPn9OysH4ZE99UvIkBhPRmzQBeJoHQUwSgPHHc7gajnHuuSuhstzNfPB8SoUspc5zcGFXhUtNErEC3KCZuzb5pmSONQU5PkcyOyQoI5vOjMUIx3U6EbIGAkBQkC3p9yV1Bho+bPcwV4A1ynNlToQ44elwFb/lKiOwHN5N8M+ez8IgsrvWE8gCp7Ltizt+MOLszdZgecgUcDXpgR/zSwMmV13SsY6iB3w8LE71uOuSJu2VC6B5zj6twL1zulSsyAG6icnigNEBS/pgnYn20plk+A4iBLlCrGTofs9h0ii5+RAqMnRxkuwiwu2paMXivzP80GINTjLZyUc6XrTrZwTFT3qvDovyDj9FBwfOggVDhIa0+n+6/8IrKrn6rY4BdV69BiqdeMOiUoLqr/Zo5NiADjIids=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199018)(5660300002)(31696002)(36756003)(44832011)(2906002)(38100700002)(86362001)(31686004)(2616005)(478600001)(6512007)(186003)(53546011)(6506007)(83380400001)(26005)(6486002)(316002)(66476007)(6666004)(66946007)(8676002)(66556008)(8936002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVkrbTBZaEVjcDJlbDMvTlRRVEtJSWZJZ05vUGY0eDhCTzFMc0F3bDZSaHdn?=
 =?utf-8?B?WE1BS2dEOE1yWUFBd28vbW1uVGdXZTNPTFJRS1k2bSs2QlZlbmJocm9QNUNG?=
 =?utf-8?B?SHBNcW1BQ1JGY3U0dG5ZRFhzVGxRZGdKYjBvYkh5QWdTdUV0cTUwNzFSSjh6?=
 =?utf-8?B?TkljSE9wOGdkUnhNczhBMmI2TGZzSjN5dk1VK0dmV09EdXg4blZBa1lyVG1S?=
 =?utf-8?B?bDRwQWFiQ2lFUEczMWV6T2c2V3dXRFVaaHlOcFRBNnpIVkFONWRUbDdycVg3?=
 =?utf-8?B?QUpnOEVjbER4S3VrTU85bTRQNlk2RUhib2N1d0lWWlRjaFdGSjhJa1lMUmFh?=
 =?utf-8?B?YWZRbHR1Qm85N252U2RSMmlJZVhIS1BCOWlCSEVBOUZ2WWpZeFllSDFQZVhD?=
 =?utf-8?B?M1pzWkNvM3huWkV5SDc5WVp5THpYeHJPYnF3bksvNTdXTDIvWHlRU21FNXdP?=
 =?utf-8?B?eUJOUldkbFNZZmo1d29mOFJqNU4wdlNpZ01lUEVITGlUTzZYUXRFL0t3RkV4?=
 =?utf-8?B?R2hrYWJtRFppMjhIcWJ6MUw4aUVZWHNJelZjemVrNCt1VkxOcEUzNndRanEw?=
 =?utf-8?B?aWgrcC9xMXllTjJlY05jV01WZXpjbXIzbXBCQVBWeFRtcjRKOXhOa2JsQktE?=
 =?utf-8?B?SERDR2dXTzJGNW80OEV1N2F1djJnT2p6WitrdGQzMmI0T2N6SGticWthbkxh?=
 =?utf-8?B?SVAvZWN1RzlmRW1CNTVkVXlreVFPMTlnOHJXM0NxUE5ueFg4RkFnWWlSUWF0?=
 =?utf-8?B?NDZoUE5ITFJlaFo5SStibUNtUnhDNjBmL3RKMHE4bDRvZncxbVROUjNjTmVa?=
 =?utf-8?B?eEx5ZU9tWERKTXNFMUFVYlJWRFNlcVgyOG1EdjN6V2UyR0pNdS83bnFzVUkv?=
 =?utf-8?B?ZXo1Tm1kMWxFKzZzTkpmMGhRZWQwaTd5U2JmZFZxdHIwemlRaFplYWRSS3FH?=
 =?utf-8?B?d2ExM2hhdnNyNllmU2ZjNTBiZ0JSeTM0US8yOWcydFhwSkJtdExBRkRNbEs5?=
 =?utf-8?B?amJuQm5sQnVRck9iOWltSlpiQUZJQWdJK1VQMHVOdEtyU1VzTHpKWkc1czI0?=
 =?utf-8?B?NkZkV3YzNkxnZFdKUGkxaVd0SW9ZbUYvVkNUbjRpdVoybHI1L0prNkVyUjVY?=
 =?utf-8?B?dnk0cXM0clUwWkdERHNNMHI0eTRFcWJ0T1lrU041MUdRUHFVOXFQS1ByZTI1?=
 =?utf-8?B?Q1loZnFQUjRScXh3am1aME5IWjQ4WG5GNkJqdnR5cXkxUWxkaEVvQm5kbHQ0?=
 =?utf-8?B?NUNlWnE3d2VudER5ZGhZcGVxUEJxUFhxWWJpT0REa0puZDUzTTFPd3NDYXVZ?=
 =?utf-8?B?L014eDltZnVVNGZIYTA4ankwakNsRlFpR0FBMFhRU2hxckE0cDUveHI5WDMz?=
 =?utf-8?B?K21hZWFVMUxXdGltK21xZ0hYTWxnSnZzeTdFSDB3Q056UUNhdnJ2M1lVNyt3?=
 =?utf-8?B?dFo5bExIeE51ZzNVT05SNUwyUXQzeGlPN29wa2lVcEZ5bzRJb3U5Yy9nYnY4?=
 =?utf-8?B?UFcyR1NuaE0xQ3Mrb2hqYk9sNUQ1TnlqT2NNU1IxenhlQ0ExemUrTlAvUjAy?=
 =?utf-8?B?QXFCbktrUTV4bEdEZDdrU3N6UlVtWnpLWnFtMlVicUc0TU9NN1h1MTJMaUZy?=
 =?utf-8?B?bDNvMjFITEh1a3drZjR2bmRXd0JKQ3V6NXdIWmZBemxXMHVtS3dHWlN4bU1Q?=
 =?utf-8?B?WllLZEZpT24rYTZXdThhOFltZFZSMkZnRThGOXR3MElsRmhJV0xUREpPWWJD?=
 =?utf-8?B?K0ZWL3FDV1dtTkZTcUo1clVoTk1lWGRSVHNCZ0NsU25sVUZHTjZsNFJpdW1G?=
 =?utf-8?B?Y2RoaC9FTkFybHo1Szd6SFl5bU9tTmZWKzc0MTVOemhuWThGNVZvRzQ4OHJP?=
 =?utf-8?B?Q0hvemk3WHR2K2lNaVl5N0xrUVArUzZHOUdKUHNoc0Q1VWhjcVhNUGFuZk8y?=
 =?utf-8?B?MzdITVBKUDYvNVBTR2VYRFowVmw1djBndnV2NThidWc3MHE5MjduKy80MG9a?=
 =?utf-8?B?YUxiczZ1ais1eXFxTWJud0xnZ1A1ODZ1Z3Z5cklpZTNSZGVFdEIyZlJGN1Nq?=
 =?utf-8?B?cmFMN1V3M244b1JjNVlrbTJpVUtrTS9tQXFCRXNOdUJtYXM1MWd1Ykdyc2li?=
 =?utf-8?Q?HqBZ0OxEW9iL+DHgR9+w0V30Y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 09y2Zd3yBqFz+ykeDbEQjMJjN2HdSGnHjukwRr0abzjJabnaCuW6Ana2QWn0f+FRmrv+G5T7htWqPZ5OYZo/f3bwO9S+vaEEfKrmpgIR7mAkIYoyO2xRHdHiG2HUM0dWfFYeV6Y8EILMvhF98V0hQ7NhSnGVoTjQm5V+V5lR4WgGiwM8oEFLOd1Vg5y0Po6EzQqS8HfSQeq1zxQ0Sxd91mda/p5jj2/fDizd8TQjRE9yVV3yQ+3Ctkvee6AgDy8fC9yZMJvgfjyuTvmsaFlQnElrZu599N8lWfunk7fGgq0iniFZ955SCveZcdLzhuWukU3P+gEmRCFxJKtu2QH7DEDbJ0QTJ9YzxNk3vDm2MtYycYfHOH/6Jh7YK0f92VTJvaFrItGXrELmOE27W1PJogs3fSjKjPdXj8ZXfxIY0WdK9ZFGSSam9eCs24cjuPINRG+E7PsN/51V9IOPsW5a9srfOZ4VgbojsFQHXZbAmaXn1IUvitlbJFijeC4aJ1BMr4SdXIPGRRISZBO1FfwJesMvjEgBBV8FOa5gb0zGSBxXh7nO9++dK/6fu3v5MT7kz98wIN0XPpMUmzY41ZXv57fGUmVmfn+k5HAgILolqygHIefadnUrTCeG7KALH/4hBi2uLe3rodn5xTMg2ulZuxp33H3JFrlCQdRaqp8Nn5QGZDQiGwmHusd6wD1H1PIs0ic8jqNtjA8fGqqTLK7TRe5jVQzei7pPueWdI+HZJPXf6yYU/AW22LE1DIUQm6ToQso7lEa4HrfmzvFPsWWvWulz56Umtzu5SZLWa1rmlFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf08d4c6-e8cc-4918-48b2-08db037bf3f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 11:11:51.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEB4eOHGhjk8AirCDhECMpqWOgGhVWyNmAORn2uxPmq078PExrElS71y8Z6kCHGzem/6CH8DlCIs4y9TDSvT2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_06,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310098
X-Proofpoint-GUID: PHg4f8eVNvQFyzqekUyE-WPPxOzGCbbq
X-Proofpoint-ORIG-GUID: PHg4f8eVNvQFyzqekUyE-WPPxOzGCbbq
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/27/23 21:32, David Sterba wrote:
> In commit 083bd7e54e8e ("btrfs: move the printk and assert helpers to
> messages.c") btrfs_assertfail got un-inlined. This means that assertion
> failures would all report as messages.c:259 as below, so make it inline
> again.
> 
>    [403.246730] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4259
>    [403.247935] ------------[ cut here ]------------
>    [403.248405] kernel BUG at fs/btrfs/messages.c:259!


Hmm. We have the line number shown from the assert as block-group.c:4259 
here.

messages.c:259 is from the BUG() called by btrfs_assertfail().

Commit 083bd7e54e8e didn't introduce it. Here is some random example of 
calling the ASSERT() from 2015.

------------------------
commit 67c5e7d464bc466471b05e027abe8a6b29687ebd
<snap>
     [181631.208236] BTRFS: assertion failed: 0, file: 
fs/btrfs/volumes.c, line: 2622
     [181631.220591] ------------[ cut here ]------------
     [181631.222959] kernel BUG at fs/btrfs/ctree.h:4062!
------------------------



>   #ifdef CONFIG_BTRFS_ASSERT
> -void __cold btrfs_assertfail(const char *expr, const char *file, int line);

> +static inline void __cold __noreturn btrfs_assertfail(const char *expr,

Further, this won't make all the calls to btrfs_assertfail() as inline 
unless __always_inline is used.

Thanks, Anand
