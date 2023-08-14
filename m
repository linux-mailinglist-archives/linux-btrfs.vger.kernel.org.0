Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C0777BD14
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjHNPbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjHNPbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:31:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D310DB
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:31:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECfjkX011034;
        Mon, 14 Aug 2023 15:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HifQUtdH/4gS9GILxkk0YjSXqFCUiOesPiiKkqseCgY=;
 b=axMYK8PvWGn7zj8bhP63UpNeyJmgS7SJ6jggl+8O6sHhp5EC2ZwxLgDW3w08Okrzo6H9
 2p2PwemleBTDUlcRPMjOPxI5Gq0izwPMeK2Ttca2yRu/Oo6SuZdPRti9h/A8kcqxOFl6
 Bjl14z4VhoCxXpDxnzvHU0LTyuz3dL/Pz7q4jNEXqOZ9wnK0WvkCGaMUncYVQjUf8WFQ
 a7vMoYMoukujDun99cZn0FddjPvAV6FFt6gbeWX1KFRvE7+YeRXHiTx+LlqhvJrjQBbj
 N+v5D3NTeWcbD+tJFHqfPnCAB+zo7GGrS1j1BMMCzupyBewVaR/CGejdTfZTRHsR50Xf cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349awvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 15:31:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EF0s55040344;
        Mon, 14 Aug 2023 15:31:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0pt3kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 15:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emUoQCn16qG2vgKTgzQ+8i1yFsHDrlM4sGEx0wsWJKZefUJIzQezihyLmq/KD2L/VMTd4KRNl7Ddi7rbsPrp3X4krW1TQV2gCwjNnHXx0o+QrSByaLf8b2B3ltfdpY6rVk04RTMy+mh3hrMI1qtqL33XFMZntHj1N7GvC2Wf8s6kVEvv6g6xeWO697Bft2l0Tp9Fahl8flB/IvYKgVFni6RA5R7fQt2Hv3XagUOcQC+jwknHZVX+Nz6xlJY3YNDaGYYOn4/AGigxsi/BZf8wYHGXmkcdZA3xz4+EvAdpQXInQJoq6LNxw76dFOTnoxYhvMFgJtEdKo6SyGw2aEcSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HifQUtdH/4gS9GILxkk0YjSXqFCUiOesPiiKkqseCgY=;
 b=h9QMQube4cmTHj/w0HsrHaNbxu1zwTIvk1N/jrr35pTNL2rVxREgkjdOW//el9RnuIXAL/LD1P55netZc7Zdl8sgzrmFxPoTTvtgwPNsSnXWHyBjpejElyxGyIeTROgSUjWdve0bsVYFXwPb5qbPwRi9l8Sd4HDoEbPaWavyE4ZujNRTgh9+DfN645Y3haaDengFtRwnWKV7oUeRbcWufet+E3SOD2s5vLP/QYLTYXQCP6RcWlHQHs/g4eCNNIkPZMKqYU5AyKdIgxbKn3qsaBwHinzpXjd4ymnsDacgnLB5wotWPGfwfs3wRyoNtcKYkDBMUsXexU2S3o7w9t7N7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HifQUtdH/4gS9GILxkk0YjSXqFCUiOesPiiKkqseCgY=;
 b=clZV1IairNHOOVn3RfNlqN/mcWRtVCLNDiZ9D/OwAqXmjP4przUE3qgteM+yvZw5J1Ju3jPEA5dHkwUdVVQPj1lg3rarUu36c5H4VxXz/eyFqUcn1usfcYRFvlT5KI9AjD0inTeENRBL4nWcTCsLc918pJEkpoEt9T3GaXNKdm4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB7425.namprd10.prod.outlook.com (2603:10b6:8:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:31:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:30:59 +0000
Message-ID: <88129abf-f0e6-b718-7899-130513a94573@oracle.com>
Date:   Mon, 14 Aug 2023 23:30:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 07/10] btrfs-progs: track num_devices per fs_devices
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690985783.git.anand.jain@oracle.com>
 <bef7d89c5e6564fcd621787a647fedfe72f94c0b.1690985783.git.anand.jain@oracle.com>
 <20230811174152.GX2420@twin.jikos.cz>
 <f0d3827b-f817-075a-24d7-82755156d114@oracle.com>
In-Reply-To: <f0d3827b-f817-075a-24d7-82755156d114@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a4c806-3475-43c7-900e-08db9cdb760f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pOHgDNKKXMGg6U8eZwlB6HT1iyDrCWCXc6zX0bQDf8Y/u/6Y8m3oas5XFld8UEq+B5hm7Au3+44jwC5DyWBPd2EggTtwi76Kcb1yomjD0C8ttx31lqIqStAvzC5IrKFAUWyuiy7ZYHcxqI5iuMPQJ+guFs+hK5jt0Vwtcal2l15iysZIr9wTE6CAlSvL7+lhRabMSMYjzqmsrIMv94YgnMTpgvSvQVYyeG92RK5VWQ783gkBVIxDTYwML+nr/L3LzK9AVcHZDUG48bsDIJFstUP9cO3BkvKyZ9RaPfeCd0BZca1rQVCyHqrUu7/wWOpTh5HN7G0M8mwgmo4ygZPd40gEH5it6s5kMIGoy9OA0v3A/Qv9ckewUzgjqizwp8rI/l4hKJjGlWxq3nxlnb8D7f6k94pZCiXOuiNR8XRUc1SByzjK+di4RlJ4c11lhi4hAIwPJgDhrG5JcGgbZPBftErclGWHmk6gfByPQKFu++TXaU9yk7o0JAlq/oEbFVgXL9B32hRREpSjm2HYV5UQwqEFlAV0SWqOcw8A3LebofpceBGAba9JYPxfHVvOv+tRcpiQB0fw0BCWIqeGWlJKW4cWHiFADgCKCS+91F1F1+fPVpMibOosFItfDkon5cDzTTXDPe9hz04wu0ljALSNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(186006)(1800799006)(31686004)(53546011)(6486002)(6666004)(6506007)(6512007)(36756003)(31696002)(38100700002)(86362001)(83380400001)(2616005)(26005)(2906002)(478600001)(44832011)(5660300002)(66476007)(66946007)(8676002)(8936002)(4326008)(41300700001)(66556008)(316002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXF3ZGcrZzE4WDBKUFMxTTFvRUxpN3FLNVNaNlFmQlVnRWNxNytNQXVhRjJr?=
 =?utf-8?B?cHZpNXVyYy9MeDVYcDgycktQMmFTdCtXcHg1dkRaNDNUc05MUzR6Zk4ybmhK?=
 =?utf-8?B?bTB0blJkbEJnNExMd2RlN09CV0hTeVdkQXpEQlFJbjNna2FhVEJEZEMrMVVn?=
 =?utf-8?B?U01zanZZY2p1NXIyUXNLa2t6NUNPaElBUmtuR3NzK0dVellzOE9haVN6OGpI?=
 =?utf-8?B?N0s3TldzM1VSZ1VLLzBEV0lzQWxuN0VpYUtXN3dNbmJPOUZ5RnJOYTd3YzBL?=
 =?utf-8?B?L3pJcjJBb3RpS2dUaVozRlR2UkpkSUp0WVdaUEhWdmRpL2d1SStUeGJLZlc0?=
 =?utf-8?B?ckVFUU01TVozL2duQUgwSUUvSHVDWk9FNGpFTmt2czFma0gvSTl3dzhtZHVx?=
 =?utf-8?B?VEZabFJUdUZaMjhEakxOcndWN05XRzNWVTVTbkpuK0ZJTFdqNk9IR2hFODly?=
 =?utf-8?B?YlhMeWVCODAyZFlvMUlSSks4NDB3NzZ2QmRORmlPZ092M2VQV29QRm9oajl1?=
 =?utf-8?B?SzRyd2ZwbzZmd2VxdnFpTURsQm53YW93S2E2RG45a0JFUHhNeFB3ai9ORnRk?=
 =?utf-8?B?RU95eENvRTA0SzV5SGlkQnV6TWlnWmN4a3g1WWlkN2UrZERzcEd1R3ZDbW5M?=
 =?utf-8?B?eWtBRjI0WVVQT2VHYjBTekhpRnlheHNCbExIVlJVL0JyYXI1aC9QZjUydVRD?=
 =?utf-8?B?VzRPV0FpRjlXVEpKbnM0ZmFicEt5NEdJZUVjQzNuSjJzTDJYNnN3Q0NCMzF4?=
 =?utf-8?B?dE1xTGo4Ymcyb3IzZkIxajVTSDkxc0o3S25SbGx1RU1Qd2lCbGFKY1I1OW1B?=
 =?utf-8?B?amZRQ3ZMWmJldXVXc3lSNUF5cW1yeG40ODZublUreFoya05JQTZvbCtnb0RD?=
 =?utf-8?B?bWU2OEhlOG1hWG1SUDlSa2hXSkZQeDZ5WndsYWdXblF1QmZ2R0pnSmtsYXM1?=
 =?utf-8?B?R2hEWVNyVmxlYk82NUdXSzRFa1lRaC9zMFRYTWFvR2RndmJyOFI0U3dOKzYy?=
 =?utf-8?B?bFIxZjdnVTNWdE5kVHBWVWZTRHRCSG40OUVLR2Q5MlFrcXdtVzRtRXZTRHk1?=
 =?utf-8?B?RVRtendxRjErUHk2b1o3azViN04vYzRhcm1UUUlBSGRQcWFQSDRvendEUVBo?=
 =?utf-8?B?UExSRkRTR0dUTUp4VFRnNHRCRWoxUEJia0luSE1XV2lJTEpJSitGTUJ5TTBG?=
 =?utf-8?B?RC9Nb0t6WjFEbTFQSmZvVVRYU0l3aGgrMU5sQ3UxZ0d5Z25jc1psZEZ6bmhC?=
 =?utf-8?B?eEhwMmxFdUo3S0FvYnVCRmlONDU1VW9oRUhDRExlTkJETE1icXltSE1LZXNn?=
 =?utf-8?B?Nk1iZk8xQVZUZjlqTFFPYlh3bWtRS0hMYzNKYlcyMGJnN29jMVlxd0hpN2g4?=
 =?utf-8?B?ZE4zVm1ISk45WnlLZ3VLVkNRNEdmWnRyUmRmQkVRVnMwNGdYYk1DM2pud0ZF?=
 =?utf-8?B?a1JwWTVEN0JFek1NL1ovbnp6TWoyL0RIcEZxSDlIa3JmZTIzajJSYnZNWEpj?=
 =?utf-8?B?ZDN2ZzI1cmgrUEpDeE4rUjFTMlYvc1Nadm9FVFhWQ2sveFk4cG5wRVBScFo0?=
 =?utf-8?B?STlRMVFhNjRDWWRlL2RoWXE2dTduNnVIYUxxU1NxYjN6eWJSd0g2SC9ZQVhU?=
 =?utf-8?B?ZG1LWGNxaEdGSlNlYTRxVi9lTC9qUXQyRzJESnc5ZXlqTkRsK2QzNlFVZU90?=
 =?utf-8?B?eDJJdXVOOXNRZnNDL1NOcDU3aGl6emkwNjFEWUt3Z1JHMDNyZFhkcllvZitC?=
 =?utf-8?B?cFVKQkc0V3NySng4M0RvNlFYMVFsMnltakZ0VXpPYXI0ZUFEeWV2SlFvWnJI?=
 =?utf-8?B?eUg5T2thdHlCQmZNWU1zakVRTmg0b25BdEZTTitpdEJlT2dCYlZaT1hlV2dE?=
 =?utf-8?B?MzRZYmdXOUVFMDZ0SFdDcWxiTkppUitwSkxsWFNWV0RVNXNiazRqZlZGVjM4?=
 =?utf-8?B?T1p3UXRBdTBYa0xGbll1ekJlbVlaSWs4eU93TGlqUmdHbTk3SFBPWmRSR0FW?=
 =?utf-8?B?cmJqYXhnbXE2YnNVQVhZTmNoSE1Ea05ucGlSd2xBVWVJYUxxaEh1UjF4NW9s?=
 =?utf-8?B?NjJrcGcwWmVBRWNDQzN6Q0NlQkxPZ25mK1Z5OFBneUVYUjM4QkcxWmk2UjAw?=
 =?utf-8?B?djFIVXdCNllpVUtGS2lBWCtuSU5YczN3dzZLRG54WjNlYXRaelNqRTlzT0lO?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N2VOn0KGRknkHRVibD4+cTfluxCcYs4x+2HdCKDmPF7hNhUKq5dOhpSgV++r9fC4snAxVVdaz/dbgsWx4G/GxDYmPmaX6eLUF6TD/neFpgWMTOXSEDkZpxziQbaAslZ5PUUIq6LcyazpdEnI8Vt4GrezhOZpSJqthKJ8EnsHowJPKKKMSFDUsOQ+IS/yRhP9dXrOfL+388F7R/IrOxfVp7pyUK1Y/c+WRfNEKikY+Aseo86VLpXJxk6CP/ena5cXW1lB+koNRrNQ4MKqof2X0GzXWpnMhV/lMLAnqAYik41nuEG1pgf9gFfWhTWDInkKfovarojY9luHfCOJUnfPK07ELF37kiY+bqEJu6plP7M6JRb7Jv5e4c273QXslJmI39GVWygrbMh7aepLQ9UEcScykVNuv7ayYMz9O6eAbCTUUfd554MlId8rs2Vcrxg4zdioLc+Z8tJymKmtFRubUUhEXypyiHyeoRM7rkiTOxfsgJgZZt0guPtcrbdNRuJ/OYdM6VHsHMWOp0a/vqZwXJv2SpNsnvLLWQvKvT0Qv/cZNxxUOJ3rLWnNDlYjIX8XS7B7mwjH0/wdBuVmUQNz3OKmY4H0umkvqArMzvDwG0efMWUKQ0JEzylMeZcXINZuKfDJXIQCyCak6/elD7SMtZPU6/GrsVkyjlj26dl3yZ/9Lwf80cve5dz6rbY46KlvmHcNmpc8p4TO1+Y1GbyE35fcMpj3M1pM4oy85Vp9PDkaan7gm5cSlcyIxbDoixONfzkW1Emh4pj64vNP5shFPbSEWqkdlENluPZww0pxR84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a4c806-3475-43c7-900e-08db9cdb760f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:30:59.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gR08NaBtpRveTT8oyBY6cOIb0WPZwSLBBK2NAVSJaEML15gA6oEhboC0UL3m5CbOl1iHQatK9HCSAJsu31L7kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140144
X-Proofpoint-GUID: fB1MaDebBIOg2eJeGFN982GTEfGGhhjH
X-Proofpoint-ORIG-GUID: fB1MaDebBIOg2eJeGFN982GTEfGGhhjH
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/08/2023 19:16, Anand Jain wrote:
> 
> 
> On 12/8/23 01:41, David Sterba wrote:
>> On Thu, Aug 03, 2023 at 07:29:43AM +0800, Anand Jain wrote:
>>> Similar to the kernel we need to track the number of devices scanned
>>> per fs_devices. A preparation patch to fix incomplete fsid changing.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> Patch looks ok and makes sense but it crashes on segfault with test 001
>> in misc-tests. I haven't analyzed what exactly it is but given that
>> there's only one pointer dereference it must be it. Reverting the patch
>> makes it work (with the whole series applied), so I'll drop it for now
>> so you can have a look.
> 
> 
> Run the command: $ make clean-all to fix it.
> 
> It appears that the struct btrfs_fs_devices is used somewhere
> statically?, and it gets updated only with a clean compile.
> 
> Since this has not been integrated yet, would it be better for
> me to include it in the upcoming btrfs-progs patchset?
> 

This patch is now part of the new patchset in the ML.

  [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
port kernel



> Thanks, Anand

