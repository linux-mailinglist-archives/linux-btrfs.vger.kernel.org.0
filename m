Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24947B5E6A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 02:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbjJCA52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 20:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjJCA51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 20:57:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9063EAD
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 17:57:24 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930i8pb005443;
        Tue, 3 Oct 2023 00:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=itJe1YrpX2FuK59AGCLv1Rdbz1+hO6L2ethWUf+yTRM=;
 b=hHGaFOHBQeiVx8oGq8lDmjYCBUU98CfoQ0s4fj1mmCRkAhGnS+kVDAliX0n0zhLvgkkd
 k7YYZGMPCQF+guK+u8oBKzvDwspWM2OR8m5McFbb+ryOAG+9F1XOUd1FdMspaDTMwq8E
 dAKjWZZWgI89fAdIucdpXoBb1+7q2HZnyRlTustfc8irjQT7Gwd2Dj30izOX/2OrsMds
 GGiOrbGq49rVlgQEA53WlzYQv+1ojNImvZhhIRDkOAN1/6iz306huZa7KDLE6f1fHfYP
 jtJJCh3qsbQsvFXOnPhFhQSn2KYxCK0+OmREmRJsApJGdjhhuCTJg4Ny/vQoSn1en3Vb 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqdun8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 00:57:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392NUIXn005975;
        Tue, 3 Oct 2023 00:57:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea459w1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 00:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2QkqvS3TQkztxXuPRNtsKZCRX8hRnJB1eUphy+u9oPxG8HPPj/nLlOK6JG0OAYZrk3gRDzQCp3/HygyRL6Yz85E+wZMHNjonaEcZ81c6ve5BZGMOIKV/PWAMbwIw1Yv1SKyIRC6OTKOX6wHRPZLglRwrePYWDfrsdKtET6wqDwbte3kRhXBriBeqkSG9wYvEzaLo5L/ASeZGNeLLjsG3heJjsbQon4XSZHXsl2+9E26MHe+djVFRBaPm1nIzHiw4mMWTGPf4hp5CLUThkL67FLKpFywFfsHLAx3sg2FBZl/kWUsXlKVvKIA4L5Uuhj55UCeWdpt+TYqB9M/qJi5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itJe1YrpX2FuK59AGCLv1Rdbz1+hO6L2ethWUf+yTRM=;
 b=oFHWuAyRpKvSyK9G6JPmDsNvoKl6nhZ7v4P/IsGxj7pXiT8WjUZAylXIZIeQVfBzX6S+mwSmO/MM2FcFTaeVYBcfLVMr9xXyZIRuBNA1epedhfpMZeX4ESTt7Og7ddMGSSfyU2ppzytz7XyA7N0dTMXhq+NR+qdglYx/IjFOJTiN6sLa5xXERW5TbXORZLQ2BbpYAM7q4bHByFLPIibuBL0n9FM+57NiJippvTJ1vR3opMSgGLDM2NLM6bP4P9g0WNezw5BR1f91haziPM8o86+Kwn6hDKDI4VyqIpiai6duuHVPNYVWZ7bFXA8GKWnrq+NgoyYGWdxEdwx65BfqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itJe1YrpX2FuK59AGCLv1Rdbz1+hO6L2ethWUf+yTRM=;
 b=tmnqRYCnRcnfA5+KF7+yWodhzi+muFd1CKE/jUx+fXKT7Kh52XuxaaNyxYwagaqz6iotvEDRWBqx6x4ac5kfxwXHhytlq53XCnok/jyFHVgOWRQ8OTgcRGTgbPFLeaS7o9orcLKOuBtIoSEz+eXqLrTpYVXfL0Rxs1IIDy1LAfs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 00:57:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 00:57:16 +0000
Message-ID: <69b8f1aa-0e42-f483-2b9e-a77eba8d05cb@oracle.com>
Date:   Tue, 3 Oct 2023 08:57:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] btrfs: add helper function find_fsid_by_disk
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695826320.git.anand.jain@oracle.com>
 <46a185408cb2307eb1f94250533c7d10a3a9d62a.1695826320.git.anand.jain@oracle.com>
 <20231002114543.GM13697@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231002114543.GM13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 8caa19ea-e710-4e83-7039-08dbc3abafe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8DmprHC+6HFLxzH5ypzmk2kdptIyb358yses2FiS0VuWDF0qa9jFAUcnH74vRYjE/ZYjyxJknPnWs+JYCqGKAnm0s0mvNASChhZ4dw5cBCUG/7CXWEcALqx412Z/hDIPGEz4j7s7bMKz5J51LcLiN/2OzGu5u5HF14g8+cCOkDiHd+fRfaCuCJdWqXYBQUvJzX8uwEp4D47f+Ad9WDuWmNAJx44w5SW265gIW3WeHYMI4ZbDtturauvZV0BHPWNRpfABqk/PSMEX8x/WT+YOBBbqv9pE9j4rPPjh4G76CKBIj/oryQ3TkeZ7WSt2hUsBL9Z08zw3fUcs/SLUv3iRzsyOU1pipm8Spx3xnKUTHp0DGbtp1jGwzMTliQYSUhmUpwgRzsmGKsasOHhKZ/uTg06075AKIOKSSm6pnm4yXk3evQQG+dgs3vaDzi1eK1nWyxSe3QyruYUjaxZbXrX3kQEbhnfr9MtEa59elvXFiEHxRGFb4oJvNoOV4Igl0oTeuffMsJ0GQYvDxH7eNbuJF+/x3sjkSrF7D8Fmz9TDJ2vI4ERMQ3pQE0GddXvB55Jeplf+ZLHQ07f7Pw24keHT7SwI8SOsA8nfGDABKDcCPFIi88AmolmXBFxomOz389I8rN8RzJlv/P4FTOvPKqogw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(26005)(53546011)(6666004)(6512007)(2616005)(6506007)(6486002)(38100700002)(86362001)(31696002)(36756003)(66556008)(6916009)(66946007)(316002)(66476007)(83380400001)(2906002)(5660300002)(44832011)(31686004)(41300700001)(4326008)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhiOW1maUhlQ0JBVlp4eGZpalo5QTlPSDhJVTRqVnlCN2VZYkpZd1lhODM0?=
 =?utf-8?B?RlhJR0J0QU54RGkrQVIxdkdIY0Z5RjdxeUh3SkI5V1lncWtwVmp3Wllvd1dl?=
 =?utf-8?B?R2V5NGxKQS9DaEc4M1EzeVlxUk9jZFVva29xR2FaQjBhVWsvNnJDUk1PdVU0?=
 =?utf-8?B?WFF3MWowdHo0Rk1KR2R1SFpJUTY5TmJHZnQrdVlVejR5TU9sL2VoZ0NDeS9x?=
 =?utf-8?B?cmpZOUxQMm02NllVSGRyY1FpL0p3aWZBU3hSTGpDR3dJR3ZIeXgyL3VUOGlq?=
 =?utf-8?B?Y3Q2WitPMkJyKzRCazFnR0xJd25tOHBZMzdINnNsVkx0My95RlRpclcrVzA2?=
 =?utf-8?B?TWsyWWhHbm0wZWowRU1HODlVMmhxV1F6S05LUUpPS2s1YncxV09abzV6ZkZs?=
 =?utf-8?B?TzRLZk5SZlE4MExaRmNtRlV4OXZJUnNLMjNadDRzV0xwMzA3aEkyNEV3cjJj?=
 =?utf-8?B?Wno3VXVydzVrc0h0Wm42MERHbVFuRzdRdkhiaDlJd3o1eS9LbVNDSFR2NnFV?=
 =?utf-8?B?NlE0dWtiNk5nSFZmRFdDbHltWGFkZVZDRHR5UzFSb3NoUTRDQmZOdkVnc0Mr?=
 =?utf-8?B?cU9Va1p2dHgvc2N5WDc3bGZIVUxmYWJoYkJVNFd0OXJuK3pJMXl1Sk1YT3Aw?=
 =?utf-8?B?dWpZTy9qRFJnNHFOQXdVWVloOEJHTGFKOEEwVmVNOXVFL2FPSCttT3BleDdB?=
 =?utf-8?B?cm5yVm1TMzczOE1QRmVPTStWRHdtdkhJNHZidnR6MGhhdVNTY1hjdFUvZkR5?=
 =?utf-8?B?UkVFbmhJbWh2b2ZnblBhaXVTVW16aG1FdS9LQm96WUUxa2VjSThoK0hESWdr?=
 =?utf-8?B?N2pDZmlZUmhzYy93SG1NRkhnZUtCRFhBeXNNemhCcHlQL3B2WldmWWFpdEh6?=
 =?utf-8?B?cHRrSXAvdlFqbjQwS2xVRjdtZE1CWlpXYitYU2trcmducUJmbGFKWDFtdHJh?=
 =?utf-8?B?bVV1RVoySjdHaEF0Z0Zyc2ZBbXVmQjFhWkxGQXlhQ05vSG9nbHU1RjBYSlo2?=
 =?utf-8?B?NUJRcXhlVjBlNmF6R2cvYVR6Zk5CaVRta09Mb0l2Z2szTE0rN1kyQXdtNXFp?=
 =?utf-8?B?K2hHNXNQZnVZcWNBZE0zY3VCTW1McE85T044YkFkbVErRnNwOVRmSStJOFVC?=
 =?utf-8?B?K3dZQWNoT1drK2JKZXg5WGZHUTBmNkRUeHhzYkJ3OTBSNFdjUVZLb3Fnempx?=
 =?utf-8?B?SVBaQ3BDTVlSNEtzdDhVK2hlbTN3WmgxQUpjL1d0RTNYRVJycmd2VW9CZkgz?=
 =?utf-8?B?WEluV0hyNXQzU2NndUQ5cHE3MklTWHBOQVNzcHZuYzA2MjFoVW91RzFkMVlo?=
 =?utf-8?B?ZTFNanBHcVAyN1BLbTNJa1RIUVpTYVVMdFVKZ2I2RTJsLzhQLzdSRDF3cnQv?=
 =?utf-8?B?bGZIVHRMYnhmZXRNYnRkbmRpaWZCRWYwV0ZRREU5My9rOGx2dkQ4Q25Ia01v?=
 =?utf-8?B?NlhwM2dxTnh5K21aL3lqUzhFWnQ2U1pnQnlVVWFjd1pJMjc4c1NBR1dUM1ZX?=
 =?utf-8?B?NzVpaElpTU1oUE5VYVFWWFN1ditDZWtTaitreWxiQ09adHc5cWVtLzl6M0NG?=
 =?utf-8?B?a1lSZDlYU0VKMEtDak1BQUtiQ1FGakRvSGdTb200bk95UjBCYmZhMFdrR1BG?=
 =?utf-8?B?ZThLeU5tWHBGUkVjUThwNXRER2RzMGFKaFBJUmtZdHhwVUVHT2d3OGVkMTdW?=
 =?utf-8?B?YUV1UlNlaGJGZXF0bzIrYkl0NHhYT2dsL2d3bi9mdTd5b1QxNlJvVHhhNFFl?=
 =?utf-8?B?YzJMQloxeHVTbk9kSmo3TGJwWFkwaXA1Wm4ySWxZM05mL3ZvcVJhL2hDUkRZ?=
 =?utf-8?B?N1NFTzAxcXNjZTRFZlZ5TFdLM1MzdkRkcTNzdEVQWmtYZGRtRVJoVVhFcmtS?=
 =?utf-8?B?MUxIRUZlVm50Mmx0UGRQc3Irb2ZqTXZHWExSMWFoZ0ErQlpDQkpkcVFYNUpU?=
 =?utf-8?B?QWlGcUcrN1lIZ2NlbVA4MDFqT0xOaWwyVStIMlJtOENaekVqNlMwN2ozRHo5?=
 =?utf-8?B?aldYQjdWSWVCOVZtdEV3YllGTDd1ZHVyZE9Mb2lRK0RocW43NHZ4TkhFRWN5?=
 =?utf-8?B?ME1ZaDIzQVcwSmd3R2RHQ2tvMDBEeU1jKzhLdDQwU0lUVGNRNldBcmF1ZklD?=
 =?utf-8?Q?V2ZnuktQY5X4aq8jW3Q2WIvP/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XESJwpT24NKFT+HP/YUCNgfTBehPp3iqJK4LVVe5YUFtGBOwN9MxtqH0SDd6QUYD9MUDGhFR3033E2Kye/bAawo+hTYUl3DCc/wxOrNeBheK6ztk3XcneeEiD4cHGxAQCxmbN42vZuWi67vlzaqWM2ampZJeC1lQPSGeKnRVl69EMju8UGVWBUER1TyNQKjkh/t4YzsWKHX0+UKbgVQsV2vlG8ikSSnVssD6qcExJUHcBFm4Ex+dsK4msaTLGnt4TFSNIZqd4bqND1F3zeCRqFbVfsBAjnZGytA6a2dpgoK/ubygaDepQmX7DXxkdgOp5ic2taPr8Caf5K1Dpdbp+h5illWAoeqLPzBWLRrc8nAoBFvhvPrn0it+eJYATzjvsBN527nobxQeknHem3RAYkI7tri14r8rwSCdyDc3955fUIeBRc+VYGldmQlifYgkR5YpKMs9YR3Q11GJ5eCpVrYUcSs9ocnyrqP17SZACcvIKsBqitm4pNlqtU5a2Sh/TqC63gglSZtaacPfaQY0U7n0qgzKV+HsTs0TymRzfJjEWU+7ttJjvK6bXfTXdWxxAu7HKz8tzM++uvMdT6pJ2Whs4jhyvcJpzFItmF4wSUhDEqApTV+Krc2VdPd4yCKb9qGHLj7lJy77zb4TukAxx+obHbKiW7aCLzlrqTxv8nIYgboHZ1DyMe6SyIgS+uKROX1Z4Qzni4CnOAHTScLj3x19lPcO5YgxXoKAnPctG6ObkegyIo/808LDEYhGe8m4zsYAAikQvlUx9rD7AwlTJ4y8MXerDAU4e733WOwS6jw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caa19ea-e710-4e83-7039-08dbc3abafe7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 00:57:16.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdpPsrj9ygB7Lf++cFj9uYeVSsAHBSNHLfaVa8Wu9AwSYfvFdRO743uaCsluXVJwaLZYVECdzrr5h3Skov67Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030005
X-Proofpoint-GUID: 3aVKxipBFXkhmrYKJI_QDbeccpTNwIVF
X-Proofpoint-ORIG-GUID: 3aVKxipBFXkhmrYKJI_QDbeccpTNwIVF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 02/10/2023 19:45, David Sterba wrote:
> On Thu, Sep 28, 2023 at 09:09:46AM +0800, Anand Jain wrote:
>> In preparation for adding support to mount multiple single-disk
>> btrfs filesystems with the same FSID, wrap find_fsid() into
>> find_fsid_by_disk().
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 298e5885ed06..39b5bc2521fb 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -553,6 +553,20 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
>>   	return ret;
>>   }
>>   
>> +static struct btrfs_fs_devices *find_fsid_by_disk(
> 
> A minor thing here, I think we don't want to use "disk" in the
> identifiers, it's been converted to 'device' where possible but there
> are still some references that could be related to on-disk structures so
> these can't be changed. In new API I'd prefer 'device'.

yeah. It should be device.

Thanks, Anand
