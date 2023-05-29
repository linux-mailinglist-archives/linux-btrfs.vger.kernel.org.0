Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5802371482B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 12:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjE2Kq0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 06:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjE2KqY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 06:46:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3968C4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 03:46:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T7TP5R001561;
        Mon, 29 May 2023 10:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fj5xcl5rjry7WIEuaM7Y06Dh/eMUkMq+SgrqH6IKQ+0=;
 b=BLjioTq0vzTgbwV1HfZ5iZYsDYjl7k+tIedafA0fvZaNEHY5nEEI6hf0OBC66PVGyBeh
 NSXhmIegDwdnDTvZvChVbWAzg4h7DCCayl7BswjysSSVosn6uWPYmZ78TBvE0fcjlewJ
 DEeGsf2O/Jc3VprtOGcYQ3LZlOq4AbgwpVOUXsuTWqNtd2vpvzzkqCiILKUSJ31qxEIb
 BsXFoYbSWyzKmK604nPEExw4ircUAezCM2q3DCEjHKOBkJB89pMfnlvlUaEXnnORcwhx
 qPYCwXg7KfPXDxqun6VIGZJQIUP82x7WEXEUjLNhaFsUkmPatsP7lnitrjVp/keKdPYW iQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjgqhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 10:46:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34T8fwTG029973;
        Mon, 29 May 2023 10:46:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a37av3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 10:46:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nooWzXQMKWRqtBaIk9ZSiRlJXkF1AxUVq4U32Gn0mmBK0x5pJzWUvJoPyCjcbrKs1IPX0CjSLSbTq9DrGkXermTstQ9S3yzUzQYmFNNVLMg+TPMpoOTr4o+qtOAl2t1q1feijkXe/VykFE6yA18QFrhI1psH8gwRa7OhHLeiXulFJCb525ws80adTkvHgKhEteUlfLOGDvH4U/wy9F81t6pFlvkIfYsJu47LzDv8wrItd8bJjHNjagmOW+JpMHuxh8QK9psLD0TWt4UFfQN2ikyo6kzvChkrD7w9YPJlcv5cn4VUO++iV6FyIIRyQQGzPQf/pt/ELMBd3JnNjTmgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fj5xcl5rjry7WIEuaM7Y06Dh/eMUkMq+SgrqH6IKQ+0=;
 b=NiqBkZ3D75dvsDTfqCdZwAjMAz/X2MUc6E+v55MnDdqgjvBd1yifT9XNMJ7dn/G4qhwdkMmFqn0jNpZKeNxLpixVQU5atxC58E3LAJ+G5lWTT+6a1H9naihviWQpVmTGlTToHrytt29gq06zy5Ld+xkq3mz1+r4mdVoWyleAGpN6gMFKFu2uNcO0oyg9HASrVGMOLOMkjRqFUsFFRLa/6Htad1EGmjwjoBN/khqJG3Hbdr8684d2SW4Nq3RDHWstQYYY1n0WcS0DK/IRpdNDdDOLMemECn/byfhDv2Ea5B2wdLpY8RpiX3TyzfbQggjImtFW0QiadPGFcKu33dfdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj5xcl5rjry7WIEuaM7Y06Dh/eMUkMq+SgrqH6IKQ+0=;
 b=VXSXiDf302PO/ip+QoE+X3qleDTac3/XAt+RV9GEwtggNcz3yWrnPyt6YLWthTluAnN9Dpb7ssUPprUZ3lvo3eml1cPY+PXTUNzD7Ua/onaBJ/VVGn4PnBX1a0UWdT9wvXtJq8V2/O60uTVOc2nM/q30va72EvVePY3I4mDT6jI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB7719.namprd10.prod.outlook.com (2603:10b6:510:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 10:46:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 10:46:15 +0000
Message-ID: <ae1f5ded-3c2c-c5d5-9aea-9531e2b72624@oracle.com>
Date:   Mon, 29 May 2023 18:46:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] btrfs-progs: convert: follow the default free space
 tree setting
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <bd49c49f1e1c8b816b5e1b7d0adc0461d2737601.1685344169.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <bd49c49f1e1c8b816b5e1b7d0adc0461d2737601.1685344169.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4261d4ed-e0ce-4e1d-6b85-08db6031ed29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: URwz1SEYZ09ccpZaOCJi5SGPsoBbk0MBS+reQBNFQwsVgIn/8En25+YbwcI5yyB9B4zwwcp/jq9hogM/yaL3wLWYA1lXrLsb3uSdSclu1eP0NQXp2m2jPJTHTJPCjfgaWUtoMsul3Ce/7SnKUhe3LKl9MsTYZH76deAn32bOrjjVJbb0vK6iT64RIEW3nwr86BlNlLURu+SnOsiuWLHLydbuXdCmn4cgiCa642As3QiSH0wBwqcqBZMvS90Iai1/X4hFOE2AfVgK1upZibhk6/4bPH63xDUtVOOwrSQ8gNgTqSpX8bf1WJ1fgAW32CJCjQC0823KkZwNyhg4c+eARTowhag4671y65J8NEaaWsyPI9EpAfBDXJ0enbkLDBoXLarxZ/mdu/G/uecJEIkcEVcSRsKThfD+nkKDSK/A1kdFMs6LmuWWv5GrDC0CBJuiMfDT0LrXupS+UhfrKyjI9bKjoTQuHdwu58mZVDjqo9bDZLNj95ulu9xtg/pHC6XElHCTnfLuWvgRBqGQKbfwgKHPrTfUuFy7HXjFfUMlttwA0ooR5pARF4FnZbHm8w6W8mARL8l8up1N7/PALRrMHgrSSl9+eKWq5LihUBts2KtKWWLzHjegziwNwtzE1tsl7/teAIV9NcaYH3CCL3o0AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199021)(31696002)(6486002)(86362001)(41300700001)(6666004)(316002)(66476007)(66556008)(66946007)(36756003)(44832011)(5660300002)(186003)(2906002)(478600001)(31686004)(53546011)(6506007)(6512007)(26005)(2616005)(83380400001)(8676002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjMrMGpJNE9KbWQxK2tTNU9QYzBXdjFFdFp0ZUJjV29NVzczd3JRaGtIWFlJ?=
 =?utf-8?B?QlNubHFhOUZ0QnlHeTZ0Wm83aWNEVFpXZzl3Z0IwSG1aNE1sVEMvajR5cWJy?=
 =?utf-8?B?L0h4SHBFTXZsNlR0K2dJZTlHU29pemxoTGUzdTd6ZnZxOXNIN25kQml0dlRj?=
 =?utf-8?B?ejNrVVZneGtkZmwxVDVodkxKWmRkKzVodzZOM1lrbmZoc202bG5VTEJvRUlI?=
 =?utf-8?B?eG1uZm9ka2g2VUZFdHNGSmxZWDBlaHFCMTZRUEI2TjMyNHFQNWJTd3dzR0lm?=
 =?utf-8?B?YUxMcHNjTjJ5c0J3bEJEcERKTVNyQmRRT1VSbk9VSVc0NDZSa3BSeU5Qc0Nn?=
 =?utf-8?B?NlpnMFoxRHM1S01wSWJiaWtXcWlYRmw0YzhPTHhWQlRDZ282dUhXOHFEelJV?=
 =?utf-8?B?dXRaaWxjWVA2clk2RmJ2M1l2bTRBazJ2S3VkTkdIZndRVjU4Z1dhN1F2N21h?=
 =?utf-8?B?d0E0bHVoK1dsWW9idWVmaXhtcHV4dnRYZjVtT3AvckprU2swcUFyZmt0OERR?=
 =?utf-8?B?Z3JPa2VkNG9BaWdnTXdpNlBBZFlKa1pKZkZRbXdZTnZGRXFCdnUxZWpESFFI?=
 =?utf-8?B?VTE4aHBTRDBLU1lxRDRsUGl1RUdBSzVTdEFoWEIxVzlLYnYva0ZWTVR0VzNy?=
 =?utf-8?B?aXFvdHM3UGY0dWVDTitvM1Fla2JJanZ4TXA4MnZXek9RWU1JTXpKZUd1NFky?=
 =?utf-8?B?Q01sTnFxVThPYnBFeUpUL29nbTBIQkppWjlXL2RVcFlaaURrVkZCQjNYN1pR?=
 =?utf-8?B?TjBoM29sc0pxZU45bnBkSFUyK1ZWdHZmT0FnSEhTR3NDNElwZ252cUhEN0Jk?=
 =?utf-8?B?d0ExZk5zNDkwSW12SGZmOVo0QWFrN2MwelE1VFJkNGQ0QkkyVHpxVzlVbGVR?=
 =?utf-8?B?ODA3a0JWcDhmRlFpNGdEclNTWmpzUDdBemZpU0JCVnBQb1pLOVpqSXpLM0R0?=
 =?utf-8?B?eWx3NUNvTlI1OWM1RkNjK1ZRdmJRa1BUMUM0ejdRSGN4cW9MWDlnRElQanF5?=
 =?utf-8?B?c1Z2U2xUbHVEZ2p5aXN1MitmZkVvdm9Ddzl1aGd6c0YvK1o4MnZrcEM5Zm45?=
 =?utf-8?B?dzdFMUpiWlUvNGIrbCtmdC9Fc09ZK21SQXhPSkV4Uyt5OXJBSWREK2NjaU54?=
 =?utf-8?B?bmpvajZQemlsZWd1TS93cjVtTS9TY2lmT3g1aHc1cElwUFZyRTRIUDVCMThy?=
 =?utf-8?B?SlNsU0crWDFGa0N0VlptT21CZTRqQjVydkVUZko5c2lORmJxL3k0U1M5OVRW?=
 =?utf-8?B?LyttRjNtTDJDQnRRWGlDU0VPMHRHQkxKdVFOSXExMHU2dVJOZDNpU05LcFA4?=
 =?utf-8?B?OEZwUklkVzRVWkpibDMwaE9ZWC8ra3hpWEgyR3JicE9KK2Z3SkxzRDUvQWl0?=
 =?utf-8?B?OXJYZE91bVdTR01LNWZCSHg2RWsyQk05eXA0akRGTysxZDlRLzF3M21idmg1?=
 =?utf-8?B?NFVyVFlFQmR3ZXZyc0RSaFdBS0liOXJXYyt1cVJldDRFdHdTUXVLa0Zua0hv?=
 =?utf-8?B?RTJwbFZNODJ4VUgvaWx0eGd6WnRudWR2cFZ3eXFvTDFWM3hxZjFIQ1pjYXZz?=
 =?utf-8?B?ZVVETXM4QUhEeXFIaFo0RkhrT05lWE5NV2ZDNU5kcndEQmxDWmdYSEF6NmNy?=
 =?utf-8?B?TWVZRG81QjNaLzhJYVJwbmhCN283Ym90R2pEbXVNanl5Q2NkT0V2dlhPLzJx?=
 =?utf-8?B?MmRmTEtKLzFFTHhUSXhNN3BBNUpBZU91T3RvR2cwMTFTYWdvM2dFcXlTZUtS?=
 =?utf-8?B?Szh3U3BSeHhITEZ0RGw0VlV0OXIwYmc4bFpxd2dCODB4Zkp4Rkd4WkR2d3JD?=
 =?utf-8?B?QklCMUZqeHlqWngray8vQ0VMNDV1Y0t0Y1c5Y1psSFdKdThUREVkTitjejJo?=
 =?utf-8?B?a0VlV2UwREpnS3hkYytCY01STTJOamhkK3pyME00WlZodVI1Z3h1WElPOXd5?=
 =?utf-8?B?MmF1ZGxkUzI2WWxuWGtSbXpRZDdEbFlaQnRra3FMOHRBazZjaWc0bGZUS0ln?=
 =?utf-8?B?QXZYS3h5a0YwMHlETlVGYkV5OHYxYXRLWk1DRnlsUUNsV3IwZTdLU3dOQmRO?=
 =?utf-8?B?L3ZOdDJRNTV5RElrZ2JnQmxxYm80VUQrUWxhVFU3VXVPd3VjcEl0ZWJjcjRH?=
 =?utf-8?Q?wlF3DKsazsnl6wp89t1Hr1wNL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qfZ+NDBq4T5uPvrkf1rgKP+du0Wt6sk1iBXmwEhh2YFPCxmVqEuX6nkmX5iii6KtTEVHq+i8LzuzyWAAVT+DZ+4nYEjkl3pbi4/5d5BwdPG8z7JDI0jl7VZWSIiIaTmqXgVXupyxjMCbrvnORxTfEc6WDJmR5ocKq82F4Zs0gOdSSwE0yNQAIsKALlegMB6Vr4MBQsc4R5wXh6idMT6sg+BX+XSs78B6goqZnt3H4loI6Eu13or+QXd+HC2H26uipbiWoGXoFG5olFLee8fd0siOLylRB5TYSkY8uaD+FFVoa762J/0ds+RfXjnanORibp00dJMYtGNzzRjC9qUrjSgIEnISkuotU97/o/J3OE19yi5R26PI6/St5/EQM8lNqiAiiizLxQmRqpZYlfmua7pf1kpO+sJx/UQSMO6DwJlLbOM5Fu1k4lDSAXKo8UiYcr3gwaJ7ceVOTLJqC4aBACcfPD1fxz3oNcyQ3oc3BpnGvjUwAo9acPg2Y4HLfMoW6XjUjh5y07d+vefDPcOe260aHtEunuattEHwMrB1kXFRn7dplUWS+dRw7QjNdz4ykuf0GfncmDtPJR2vNVBCrP5lyUJq3LxD6XIZ1V2reiKDjX3PzJBVEFx9X6gJOFddTRwj3uBqDoKJJwR3sAgvqU5U6ylwCFwR2M8bTF61xBR/SIwijknTVCqCoc5YjdXMTSbmr2Fe38P3IWwN9N9egPPkzz3xPY7idPtD+I69KxTdqDtamaEF931yqfKaOzsr4zcW2DBFdkqcqTS8l00x2ZGRC9MdapSzbZUZ6KrSlXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4261d4ed-e0ce-4e1d-6b85-08db6031ed29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 10:46:15.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imskV0Y9FKUkkw02X0v6wtzbztjUnwC36hQp++kWxPy6TfsHrf16VlM77xcja2DWH7Z/T1yuuA83YPy3WMdmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_07,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290092
X-Proofpoint-ORIG-GUID: Gv1nYC68MSAXlkakoS1XXYAusd724xmE
X-Proofpoint-GUID: Gv1nYC68MSAXlkakoS1XXYAusd724xmE
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/05/2023 15:10, Qu Wenruo wrote:
> [BUG]
> We got some test failures related to btrfs-convert with subpage, e.g.
> btrfs/012, the failure would cause the following dmesg:
> 
>   BTRFS warning (device nvme0n1p7): v1 space cache is not supported for page size 16384 with sectorsize 4096
>   BTRFS error (device nvme0n1p7): open_ctree failed
> 
> [CAUSE]
> v1 space cache has tons of hardcoded PAGE_SIZE usage, and considering v2
> space cache is going to replace it (which is already the new default
> since v5.15 btrfs-progs), thus for btrfs subpage support, we just simply
> reject the v1 space cache, and utilize v2 space cache when possible.
> 
> But there is special catch in btrfs-convert, although we're specifying
> v2 space cache as the new default for btrfs-convert, it doesn't really
> follow the specification at all.
> 
> Thus the converted btrfs will still go v1 space cache.
> 
> [FIX]
> It can be a huge change to btrfs-convert to make the initial btrfs image
> to support v2 cache.
> 
> Thus this patch would change the fs at the final stage, just before we
> finalize the btrfs.
> 
> This patch would drop all the v1 cache created, then call
> btrfs_create_free_space_tree() to populate the free space tree and
> commit the superblock with needed compat_ro flags.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


