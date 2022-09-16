Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A685BAD2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiIPMOX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiIPMOK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 08:14:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178AB1BAB
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 05:13:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G8oHOi014472;
        Fri, 16 Sep 2022 12:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TMXCeD4wEbdaDinPGiKVkgXzi9wFtPP1C8ogGjepnhU=;
 b=utYl/N+aL+fsRmXMN0Inc/wVF/ojwT+6/VfY6KqtK4zZFAcpgSXrOIw/6mpZ2OD5Xlo0
 uWOF28p+oGqTHIu3W2p0+hRX2RFwmcfM3/WeiDGmx4SdZwxCozBL3XbQy1v9jMEv3gji
 et5/B7SLJOjYcallgoJaqHRq63DrPeJDWd8G6TrekZZ9Yk1qO3h6tlub4M0IqT5BmjT4
 9ajTchd0dSucGpR8BcWZvgTI2Rr0OZcFRjsMu3Fs4YZgGFNLN9Pl27DvAgt+ZMP7NkdE
 mrkoBBcX+ofaJb3iGUc+7oQbxcIAxpGX6L5TivSuADRHc7O6FHzkCJyGMe6DoXHh9fUG 6A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xbadeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 12:13:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28GBhuqi016023;
        Fri, 16 Sep 2022 12:13:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x966ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 12:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKK6fYfgHqWfT8WF6YIZoIt2p4jBcjIlJaYVRC0xnE73WRDGM4L1LkGDR2SKAzGVACErcQh7rYtk1MDDwjugiYO27nKtb6GqEtVYhdJUzSpnWvhsE8T58xR/vo272aoBHMPzQt0P5/7SMWi8tHjhpTZIoOiTTAWtfNNguIvPguUpmIaDolc4tRLEZYbvqqeKAZBRNA1oJXQcJdmeE8StSYTLjTGh7P9TGnP2nUbBRspb95c48uFHhMPDDasztKn02cEUosMMvpave+n+v3bRMmGesBh4mlip+qkUy+hqqcBHo+MlJbL1Y2t9vMA+qQBW+021dwJeackYgd+oZN7p1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMXCeD4wEbdaDinPGiKVkgXzi9wFtPP1C8ogGjepnhU=;
 b=GdcK+Df39/X3mKFCeMlEr6jqQeDV2ncgdUEdR7QDeN7Zcyuk4x7DZi+f55NQwCYD6zMNwufhl2N/1vwOK5ng3Du+kgwD1YVxFjEJkuoRyFdHylyDbV94IduNCYccZfdKoIUob+BtKkr112pR+tmm3vZf0YQVxy3h0ak+I7l74vqLAwsCJ7nJMEBSzlLFzCm394gTV69hk2XKA9nRETb2kkYN2I3DM5sYb1Ae0miQ981mvKEma1761ie6r7DQ1J0pKnYVy3fWAH/rj2jmqBkGg+RwImcgJZ5GyY4ULHsgV4X6b8vqQAgEu3HKR0YTx7SVyyWgqUUJscO54h7NFFVofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMXCeD4wEbdaDinPGiKVkgXzi9wFtPP1C8ogGjepnhU=;
 b=F1tBVtbBCtDNpCGvgI2/ilmdeXwqJW3RWp3C0leCKEl3ShwFXZ6oylCLs8EflbsnsoxIondEHnnoiByb87qkwFnMcFkyRv8iUWFkM0WHnrhi4u7clWb0vX4KcTa2GnTsezVt073iYfzuxQMrKCfz/bYmaNHmC+anquA9Vb9YetE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5291.namprd10.prod.outlook.com (2603:10b6:610:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 12:13:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 12:13:23 +0000
Message-ID: <2ba154b7-2ed8-d62c-8ef9-0a23eebc6fa0@oracle.com>
Date:   Fri, 16 Sep 2022 20:13:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 03/16] btrfs: move the printk helpers out of ctree.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <c7b5fc75e003087c09502050ab59d542a08e7da7.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c7b5fc75e003087c09502050ab59d542a08e7da7.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d15257e-41c3-4988-74b8-08da97dcd9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEKIV15MXiSokT+1ahsWro0PraTgGfOAX4+EsmbfK3QZY0HLmurZX7KFhStMKSMLifcWh0mFtaDiu2oxYVQmp0XbM2TODxc3vcED2PgVWPp0YY6jgbLKdoE/J3/bSj4IUrwrnPdO+4Ay+ojSVkv8X1iTz6HVEB0Ad1z9DP3iMzNCt6FFg9H8J6O5PyoLzQNLZfabxx0e0B1Pn4Cte9dw+1k3BzbphqYF+tnH7TyLHCMRBxDFkoW2PyUjcocLXVyzT49nwUV/h06H6cJaeAcHcfJvjiFKE8SamieP1h/AnQdUcPDU2Ga02vPQLXw22C0E1pN9cvqwitfKxzavMUF+ajqAn1yicTXXd9a86aVDcmurrDdn/isk3+LtZjs7rNx+fHX3FA0muJHsSUyPwF2Gaqs0UDHfyOuwzIOFYVyg1N8JPFI/vb5FGt849c9GYttD/E1ysxIZRqhRnGIR+NJGCoAZd/1ALX++4wRr/Uv6c1SO6rUJ6XKtr2tlvrfETEi+HApukSTPgwyXKA3k1Z+G+35SDvz444UgfbPGw4NAoNXok5hMN8S2DRlm9PNP+tlql+X29msqTVKWUlQh4Dj9nmBtIsR2ec5Uc5962AItgQD+L1ATEj/p/LHzqPySc456t8ikXQfZZh7mm+3v+BO69eB7dvjUQUua9loUC/au6ZW+tp6e2DZyDgHwMqpc0mqMM6W3dk+r93RYAcwiUkL3f0ZduSvusdrqFYFVoqYoM/yP01PnqiybdD0wuSUvWDEDARY65Nbhubfjw3PkuWbQvpxbD6qntN+5n/RHD6Ao2BE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(8676002)(316002)(8936002)(5660300002)(66476007)(86362001)(66556008)(31696002)(66946007)(38100700002)(41300700001)(53546011)(6666004)(6486002)(6506007)(478600001)(26005)(2616005)(186003)(6512007)(31686004)(36756003)(44832011)(4744005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uzc1dFJGU3VwbFc5SVIyOVhlb2ZHOEt1VmVwRUhyRDcvUUFVdEMrWXZ1anRN?=
 =?utf-8?B?VUdVU0J3RGFvN2o4dUFPKzI0ZUdUTk05a2h1ZFEyOVc2SmI2Uk54MnBocGdG?=
 =?utf-8?B?RDczZDg1NkQ4ZXdTUHBzWG0xY0F3Lzc1S1paOUpqc24vTUliY2paeXRKamVD?=
 =?utf-8?B?anliYkpZUkE3Vnp4VU5EZWxROStYZ21pMkk1ZlBXa0pNNWp5YUdPVVdFSXRm?=
 =?utf-8?B?RUg3dG9sa3VLMmlDKzhvWVBWL21MWmpDWGNpWkRVZVZoYXdJS1hoRFdtT1pk?=
 =?utf-8?B?UW5EL1lkdDlOTjAxK2VsSW1HMTdsVXNNM3YwRVJMZ0pwV0VkZkk3OCtYemhp?=
 =?utf-8?B?Nk1obHY5emxjZGlEcTNleTQrQjd5ZFdiOEFOUW95ZUw2SVBNWmV3NVljQUVU?=
 =?utf-8?B?NEdRWTNDdjlPZnZyZjlFVW5NYTVpZW83N2FVWGdHaG5rTWU1b0VBQjZiQWIw?=
 =?utf-8?B?cXE3Rkc3MGVzY0VtVHJ6bHY2dTQvdWcyMnZIOE1PZkI0UUxVLytIYkhFemFh?=
 =?utf-8?B?L1dNaWl1S2tGTUZtRHY4dGxBbExvd1pmay9SZGRKeTBFaHhHNTBCVDRLQ2pE?=
 =?utf-8?B?SDk0M1ZXZHF6RUZpeGxLdGZrZ3lSTzR0Q3NZOTc0bElzSHUyVHA5ek5QRkJv?=
 =?utf-8?B?Mlp4UjRiNS9ISFYvMGxTM3d1QzNBUFFyZTVabEl5VkdPdG14cmhUeG1QbXFO?=
 =?utf-8?B?amdPeWsvVjZKZzh0cVZlVVZEc0RMd01Ic0V3YXVuWTROdHh4ZTZNdklEcnN3?=
 =?utf-8?B?NWtRRVJPWVFFZEFqa1IrdTRuR0NUWmp6V2lnaVpYYlZWQ1ZoaEVablNlUDN6?=
 =?utf-8?B?UTFESUZjbU4rU1BLdFdIVm1xdWYwNVJ0NzYrdDBqb2lVUytyUUlST2YvYzNS?=
 =?utf-8?B?ZEFLc2lwZDJJUXBnQ0xITFdZNFNRd1R0YUJTcGcreFFYZDJiU1dVTFdFQjI0?=
 =?utf-8?B?QXhvNDF6Qnp3azB0OHdHZDJRbWlHRHc1T1ZDTHNOSlRkWWRlYURmejdQNjY1?=
 =?utf-8?B?RUcwem5sUHptVUVHU0V1MjVISTA0SHBCbkxBeUdXT3EwQ1VQVTNNdGF5NTdk?=
 =?utf-8?B?eUh1SmVyTmhqQzlYWGt5VFV3dWxjWUlBQzdkT1lCdHFuNnR3K2pFVFYzVlhD?=
 =?utf-8?B?enk1eS9iVDRFdnpZUlpESXVhWUJPaUIveTlGcnhkaUZoN0FKUEkyT3VpU2ZR?=
 =?utf-8?B?QS80RWRrbCtVSjdKOEJZQVU5TWRjamNuVVd5S2gyMFhJeVlvUDZtSXVzRGt0?=
 =?utf-8?B?S0R2WUkrMTd0UjhxUEltZzBmZ3pkSmxjMW1jWTRsZ3dmSUdER3UvNTVIbmJy?=
 =?utf-8?B?L2hjOGFYb0ljYW1uY0hxQ1VkUEFqUTVSRVUwVndlbEtYcHFKTHcyQVUyYXpX?=
 =?utf-8?B?OFFzWXUxL2Q0c3hVOGN1MUlDUC9KenFzZFJoa2YxOCt1V1ZTZ1FnV1cvWTlW?=
 =?utf-8?B?enBxZERLcEl0dUpTQm5TU1U2RkY3UGxjcE1nblpWUXVrYVMvalByM2YwZmo4?=
 =?utf-8?B?c3JJM3NhVzYwVG1DQWdubW5JdDZGZDAvSXhBaDk4Qm5lM25yS3o0K2xFYjVG?=
 =?utf-8?B?YStlQUo2ZFdpSDNFbnU1MWN0WnVVd1ZmMHhkcldKU2VHSENCQUF1bzgxdVZo?=
 =?utf-8?B?MWxMSW5RYyszTERQVUFqdzltWjJuTmRwK2V0Q3hMMmtDc2xPbFF2R1I0ZG5o?=
 =?utf-8?B?WFlNbElkaGJTV1o5NEtQVXh3TEJQdDY0RFIwWVRKSkFPVDFjVHZjd1E0ZFZX?=
 =?utf-8?B?QnBOdGUvOG44U3d2ZkhwNmR5V3V3K0crRGttSzkwQ2Jzcy8zaFA0eklPT3pn?=
 =?utf-8?B?VzJrczRPeVhWa3FML1FFTEdDM09lZHh6WS9ZelIvL29SVGZmeHJ1NUdES3ZJ?=
 =?utf-8?B?SWJSWDhKejVJZ2VVNDNNRS9LeVJLUmVoRG4xSndMRFhFRDIyakQ5N1U4UTY0?=
 =?utf-8?B?N1lBUVBnbjg5ODU0cWIyOTMwcHE3Wm5nZ0Qvc1ZaL1N1blRGNEhTeGExY3d4?=
 =?utf-8?B?d2Z0SmhNeFdkYW1FbktzdmJnNm1adjZ0M1ZtazBGbElPSlcwWlB4SHhiNUU2?=
 =?utf-8?B?c3Y4RGxocWcyK0E5SFRzR0lrT2JEdDJsQVgwZFdMT0tjOUxUNkUzYVZKc214?=
 =?utf-8?Q?wORhZXsytYfrz2MwtXAKMCW71?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d15257e-41c3-4988-74b8-08da97dcd9ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 12:13:23.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ID07/gzA0HY5iHA8Qtff40dFRzEa1jFiCjk3OVVYEI9AA4J8B1UW33kgeAn8E83/Ten+cbZeKP7CEz41udvoGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_06,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160090
X-Proofpoint-ORIG-GUID: uR976AGb2x5Bgc3R_UPXqCyGC-zsXmnJ
X-Proofpoint-GUID: uR976AGb2x5Bgc3R_UPXqCyGC-zsXmnJ
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 01:18, Josef Bacik wrote:
> We have a bunch of printk helpers that are in ctree.h.  These have
> nothing to do with ctree.c, so move them into their own header.
> Subsequent patches will cleanup the printk helpers.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
