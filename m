Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A96A3BC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 08:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjB0HgQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 02:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HgO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 02:36:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63AA1ABC7
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Feb 2023 23:36:12 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R6o7dc031870;
        Mon, 27 Feb 2023 07:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pM7q0kJRbXtZ1jyxv2k/35/oxaQMfdsHAhvmmqJui9g=;
 b=EuaI2kgFZgyMS8V9zQ7pmnBR3yBjZzOBtS6EAwGW4XTO7GllGsiw2HAJIOa6rzxoKiJH
 CV/S1jNtjk3I15YIXgHC4UezyTvSgoVHBlHRRn/jO++MwFM2DvlN5CSYZT+VnQYmsLS9
 hQHPNPM/G6Jiu4OrkaidBqfH+z/NYiWRLZUc1R8umUNPOYaVVEaVeJ3ONwrdbpmOf0BL
 D0qDeTCea/YTT6zcxZIpKt40K1Gh74+NUD4FTZHB6s4hPWG65CjufPsqYHYlb9AzZ4YE
 QHMrCFM2J+USm2vBKWykNo4qt2pQotAKhTUiTqybXKKrgkpqs1KhraMoWptzZcxY3+m+ oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6eag7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 07:36:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31R5gR7i029257;
        Mon, 27 Feb 2023 07:36:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8saxv24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 07:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9Gjqveb26Cs4U36OR6wP1QPDJiaK/hwQUCczgetYuGJG72wwEI0y3CFCvLKFiijN0FqCaAFYSFQ2Ta3is16lWnfryej+sVX2xERM9MltkrE0M+MSDaGk6S86GCAKW7c2f9M1YEfz90yAkOa62kShIc6hevp1Te1AuZra3spIX7eD0Ih/dZhq5+2nVriU6tLeMnQClerKOZiK83nwfVEBnJFTEwYYFC4KRuyF3TO+J6w6i1ZW/Zph1H1wpKemfyT6m4fBqwKT1yboPdj729kI1osulpfnfQsksX0Iz3pYcjqPvUYFuw0Bt4eWUssc6eyZwis9SosmWpCmA+zOUDD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM7q0kJRbXtZ1jyxv2k/35/oxaQMfdsHAhvmmqJui9g=;
 b=fxSxnK3cAs+l73TnnqOmDwzFgsu55tDXZDGCH2ItXLoNfg5VsUYIezhbVoESQE7Sy7R78y6BGUzfpXfM4XIpVXZyNCWJTN9ENLqFji+KGRUwrSzdreqKN8Ofxtt0jsncjaz7VyCuwZqljWHdnAGRSyGbkTi+XvmgyaiJNrDz9FrVJVbH+l/kaTzjuMEY3St3LZK6elHVJ10/7HZK7h/2Q3rgowAfcRd2lbjAfRceLK68CWLGEQVwT3hVnfYxlgvlwwWD/ohgpH2RNhyMhuXkh8hbY7NiGbD19ZDYnzN1tGztaisQYaZURbm9jqtsGzgoWYbRoDOUVBz2hZVIo7oZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM7q0kJRbXtZ1jyxv2k/35/oxaQMfdsHAhvmmqJui9g=;
 b=fo4hfRLVpTQ62zWuA8kk0GjPW25dwB+1YNd8Tjrj2r8dMAnfw+vtxBB9rKJJpJ9eTwz74AbQXhTFabwVlQlS/u+3a78OSmDg9rguoML3lEqIiV2ys8x6KEInkSVsWjIRTDteZtivLB/m4xLX+CEryGzx355yjzk1CEfk/AgVMTM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6185.namprd10.prod.outlook.com (2603:10b6:208:3bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.12; Mon, 27 Feb
 2023 07:36:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.014; Mon, 27 Feb 2023
 07:36:02 +0000
Message-ID: <02026707-320e-5c2d-b35e-23290dfc36cc@oracle.com>
Date:   Mon, 27 Feb 2023 15:35:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: move all btree initialization into
 btrfs_init_btree_inode
To:     Christoph Hellwig <hch@lst.de>, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com
References: <20230219181022.3499088-1-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230219181022.3499088-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: b38b1647-af29-4112-d812-08db18954690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPNNsBlYAE/iKnxFTVGvkuC9DutKlipK5Ut3dGymQ8fY+1xlAeTsdcz7OfpkgzM6zjbLfkv/PQfvyxF27EWeQJgq2vgkXJ1xakmAYDPyr+D+0r0itBJNPoG3EIpiFM5Ic/Yy8ckQNUVLG6yUFGgrooWUoqoIJLZLXpgVV2Q/AcuIMkPvT275afVTPboQvMeShV7+4EnFvQmJQrrY3lHPMWIeja4OpQWmoAUokN0GFjuk1t5iK/oSrhRJSBXh7oigT2/yUTPlxgb4MV1miokDaAiBGA80fu/2Jn6MgIe/QHUmuaRfw0F1FYbDoMUDlo4Peu2McAko3p0TBPpK6TZsJe8zqKDUw7fxQalskdgdBaeUgG6bLwpvlHfNr9cEwsErmMEutNC9i5LERrbT62brBY7oO51EDSE9y+9QYcLCVrQ73M5QcDIVcpN28+NtmyBz6tLd8SNz8KAgG+J7Ip5Mej7nrcuYGf8Bai9rJOLfBrASykTWrDnOYk8dm2QBfnkSK/AF3GjFlJDr5SHYG1uq53oQZGLyEv6tCNdsRtazxPbqTbU4RYoJ7YU4PhvNipM58L2MwzyAIGT5cm/0l7d1vNeNid+9ehgNxU8abfcMf3+d/hBJCv/S7n6NemocFt2oGiwDa93If3Ze89G/d/6cTLLIuDMR02eLM+vWc8SAiHzorSVUjPufBSfcXuyu9v3u3BwUBlq1Id1tTsgjks7FFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199018)(316002)(2906002)(31686004)(66899018)(83380400001)(44832011)(5660300002)(36756003)(66946007)(31696002)(41300700001)(8936002)(4326008)(66476007)(66556008)(8676002)(86362001)(38100700002)(6666004)(2616005)(966005)(6506007)(6512007)(186003)(26005)(53546011)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVJIWGo5K3NXMXpxVWlxZlkvSEJwb29PSUhsbjBRN2V5dmowaGx0c2RJeWFD?=
 =?utf-8?B?ZW8xT3IwdnI2WURyL2RFTGYwdU5zVm1vSkJ1T1ZwQzBFc1J4TjBFZnR6cG9H?=
 =?utf-8?B?azNDT2l2ZTRsOGhqV29QcTJDWUsyZjQ5dmZUUWM3bXlVOWk1eFhKbVJ2WnlO?=
 =?utf-8?B?ZklWVUpZNzYvWVViK2QyVWVCalE2OStXQlV6VnpYUTcwUDM4N1N3Wlp5WCtx?=
 =?utf-8?B?OHAydi9BaDJmRGZiZWdzZllxaHJmVGtmY0FGVnNQVnFSVnE5SnptbjdCL3dV?=
 =?utf-8?B?emJrZW9UbnhyNlU2U1Y5dlprLzg1YkkzNmtFSlJkbFZoZi9kdUFiK1ZkOGxF?=
 =?utf-8?B?K2FzQTFvVkEyelBsNHFSWGxmM1hXNTYwczJqL1ZRMG0vUGlYUk1QZ0VNMjlE?=
 =?utf-8?B?MFR6MjkzOElsVmoxSFhsY2hSdTVyRU9iaERaL2Q5WVhvR2lvc0ltcWljZ0Rn?=
 =?utf-8?B?MEVPSlRDUWkrNTUxdU5rUWdzNzlXRlRUaFc0RWc4VDZLRGlYOXFGMmpsbUdT?=
 =?utf-8?B?WFIxa1FOSWFBUkxiTE9tVUJ0aWlxN2tPQTdTUUJFZGRDTGVyckhSVVVLZ3RJ?=
 =?utf-8?B?bSt6OEcwaGpMelNiQ2R0a0pVeGNZcVN5Ryt0Uk5aMVdlWnBsYkkzU29RVTRT?=
 =?utf-8?B?dmdhMDZuMDFCSm1VOGtucTFBS0pIdGpDY0hJblJFK05HZThjWXlMRG1RaDdm?=
 =?utf-8?B?cU8vV2Z0ME1GRzdRMTIrKzJZckRNTWhTRzFvKzVYOGhTdG96RFl4QmJGRVlx?=
 =?utf-8?B?TzlJSjFNTlltVUR2cEF1R0tqWFg3SWE2eUVoWC92MEZGdmlPSXc3bmdJMCtS?=
 =?utf-8?B?VG04ZWwxdXRubnk0QUd4NjRNT29tU0ZDdTRiL1BpVkM2QkluaWhaRmlTUXcz?=
 =?utf-8?B?S1l6Q3REblpDbk4xbjZtSHp4SXBWc3dEZ2pZdXBCek5veEZTR2Q3RkFzRHFD?=
 =?utf-8?B?WnRUelpTZnQ1UUFzYVRnQkZTaWpjNlhlTm0vWHJJYnJGTzNBZmI3MElIdzMz?=
 =?utf-8?B?ZERNSmk5WEc5b0w3SzBHUHNrN1B1NnFmZEZxVENiU2kvNUo2Wm5yTlhWWnF6?=
 =?utf-8?B?MmF1VTJBaXFsNWNOS08zTC9Rcm5ucWxYQ1FCVTdnVDlJQkhrUXlzdGN5Z01p?=
 =?utf-8?B?VWN1N2RDbnBYZkZjRFloNE42cHA3c3MySlZOUXBmYUNrWlpHSW9tSWk0b2ps?=
 =?utf-8?B?MTNlOHdIQU1lN2NSK21UTE16aGRqSExoa1dTR1ZhZU40QVV2Y1hyYVBrV3JJ?=
 =?utf-8?B?QlFrKzZveUx1b1ZmR0JmUjM2YUh0dndpV09aK1duakJVcFE5dCtMdTRiNGRk?=
 =?utf-8?B?UWxBbWZ4TmEvZmdRUTdRZlFaN3h1QUxORG84SFlNTzdwNm9tdk5KMWhIRjdO?=
 =?utf-8?B?dmtOWk0yMHp6Zlh6bHUvanl4TE82UE4yK3ZmU2RIckZHTnJWb29BcnYrYVc1?=
 =?utf-8?B?WDZFL3hmM2pOQVVzZm1keGI4ZVJSRDRNaThuWXFnSEM0WURSSXFCSDk0Kzhp?=
 =?utf-8?B?bkhCSFVnVUxCcmU2OVFaTjBVRjZ2d3haN2UyVDJHakRGTStkeWVoYkpCT201?=
 =?utf-8?B?bHhVZlk1NklYY2RwaGRwN0hRYkV0NERmZk5aMWxMcE53Y1N5Ykp6SDR1Sm94?=
 =?utf-8?B?QmkvaDN4a0FDZFMycnYxMURqcXdkNWR5SjBTUjJiSUxjckF5TXNGdEU1eEVX?=
 =?utf-8?B?UW42RXBMc29hNTUzMU11Vk1mY0lwRzFIbVZpRTk0d1ZSNHZkVnZnY1FyRzJV?=
 =?utf-8?B?NDM2M3FzZVp6Yjg5VTBDaE16bUtBNHFpYWFya2cyQ2pMdlB6VHRCSWtiVDBz?=
 =?utf-8?B?Qm5oUjViYjhMNGlFdWVvbW5kdXZUb3czK3VmNEhiYktYV25MOGllZUFzM0lh?=
 =?utf-8?B?K2Y3UGtINkZpbEYrLzBXVk9pa2xaR21IQVlNSHdDdWJpazBZcVV5L0tYcXEz?=
 =?utf-8?B?MDF1NXA0UFJqZVhXS055QjFPTUJRWGxIL0wzaFUrZnZUSG9yQXZqcWJmdjFZ?=
 =?utf-8?B?dHh0MS9aQUVVL3plSmp0ZDd6RFAyUUg0cldBTzBHcVMwb0FxbnNSSjJjM1p3?=
 =?utf-8?B?aUEybkR6N1VvOThEQllZb1Y4UmpXcENNMHRZTTdIWmhzSWVtTkdWVEhZcDU0?=
 =?utf-8?Q?SsRCOx1I72/5NQyvYp0W2M+cS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: athEy89Wb1NiQ9yFOETthEtuOl8QcZ4qxLxMyJjzzH9bLlnXTYllJRNR0O3TWbssGXPlpE7Mntu2suECYvxbsHRt+C0tPmeS+e/ZylB9EBSEsiyfnH32WEnx9FaL/0bl3Wb7ahqPEdu7lkQAzne1Odc6t62GokmpYN/hbCQciUICEApZFh0l3rbKonJzCzlgHrcS4TlZBrXfm7xjQ0NaiEMc+YC4JaYrPDU9ezD7SH18B4j4sorDgiWw2LESTnFPe0akPhXNHSUQ7Wh02qhmTUssLWOBOG2hv4YQyNCAikAuvaKRuz/e5y4He9ZB2o7BgOsi7n5v4kR4qwNBNpvHQUhA03V0CDqTXOwng2jF4XPxO+K1ji+7qLRFm44uWHsliPke06Q9WuPHcKHXVD2elF+IlyJUYWZOPKOh8qgOwfXVDk8in0D5XDEaIl8DNWEUudfyGNnZlmZiBojRfce9yId9BhvZYIt5zdfIOda/sBOQ1usiaUTiCtCDxrnV8pps/WqVznHycXqf+Szm/30K93LxRzi0kUdZP4OEGJQxPZoBPH8RjMRSsh9nduYA0MaBkzOqlTwA8dosgypwZ3qpq3lUZdG2w+nek9jm4U3ULlunmX73PVINtESKWjO1o/lPR/NF82Q8TwhGAL8pmCxmClHjoY5huQl3ip21uzQI9EfM4L7bCOHrcX0/C3GN4K6gl+hZbugKMylyAt3XvWanWN5a0q48FNNP/EFRXCggaBiJQzLUggyzsps0t7JLvDu4547PA6i1/RE5ZHTQ4K9DaM61MB2YWYVGBOrz7NHJvQl3JXJXWJvNhZL2drUSYHWLOE+lyN8OffqnoZkyZk9t/VAsB7duBEvWchUFyzw68/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38b1647-af29-4112-d812-08db18954690
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 07:36:01.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nICfwJWP4aaE7CjKxmKl4gyeqGDWAuatu7Rf5fQeVJf6rGgZXWJox/VRVItcAyV0G76YqbKU4hAsV+6ajjsMHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270058
X-Proofpoint-ORIG-GUID: YF3sH_EcekznSZYqrARYQTEYPbpftNVJ
X-Proofpoint-GUID: YF3sH_EcekznSZYqrARYQTEYPbpftNVJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/20/23 02:10, Christoph Hellwig wrote:
> Move the remaining code that deals with initializing the btree
> inode into btrfs_init_btree_inode instead of splitting it between
> that helpers and its only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/disk-io.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b53f0e30ce2b3b..981973b40b065a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2125,11 +2125,16 @@ static void btrfs_init_balance(struct btrfs_fs_info *fs_info)
>   	atomic_set(&fs_info->reloc_cancel_req, 0);
>   }
>   
> -static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
> +static int btrfs_init_btree_inode(struct super_block *sb)
>   {
> -	struct inode *inode = fs_info->btree_inode;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>   	unsigned long hash = btrfs_inode_hash(BTRFS_BTREE_INODE_OBJECTID,
>   					      fs_info->tree_root);
> +	struct inode *inode;
> +
> +	inode = new_inode(sb);
> +	if (!inode)
> +		return -ENOMEM;
>   
>   	inode->i_ino = BTRFS_BTREE_INODE_OBJECTID;
>   	set_nlink(inode, 1);
> @@ -2140,6 +2145,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
>   	 */
>   	inode->i_size = OFFSET_MAX;
>   	inode->i_mapping->a_ops = &btree_aops;
> +	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
>   
>   	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
>   	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
> @@ -2152,6 +2158,8 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
>   	BTRFS_I(inode)->location.offset = 0;
>   	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
>   	__insert_inode_hash(inode, hash);
> +	fs_info->btree_inode = inode;
> +	return 0;
>   }
>   
>   static void btrfs_init_dev_replace_locks(struct btrfs_fs_info *fs_info)
> @@ -3351,13 +3359,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   		goto fail;
>   	}
>   
> -	fs_info->btree_inode = new_inode(sb);
> -	if (!fs_info->btree_inode) {
> -		err = -ENOMEM;
> +	err = btrfs_init_btree_inode(sb);
> +	if (err)
>   		goto fail;
> -	}
> -	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, GFP_NOFS);
> -	btrfs_init_btree_inode(fs_info);
>   
>   	invalidate_bdev(fs_devices->latest_dev->bdev);
>   

Dave,

  This patch is causing a regression, as reported here:

 
https://patchwork.kernel.org/project/linux-btrfs/patch/2de92bdcebd36e4119467797dedae8a9d97a9df3.1677314616.git.wqu@suse.com/

  There are many child functions in open_ctree() that rely on the default
  value of @err, which is -EINVAL, to return an error instead of ret.
  The issue is that @err is being overwritten by the return value of
  btrfs_init_btree_inode() in this patch.

  To fix this issue, please fold the following diff into the patch.

  Once that's done, you can add:


  Reviewed-by: Anand Jain <anand.jain@oracle.com>


diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 48368d4bc331..0e0c30fe6df6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3360,9 +3360,11 @@ int __cold open_ctree(struct super_block *sb, 
struct btrfs_fs_devices *fs_device
                 goto fail;
         }

-       err = btrfs_init_btree_inode(sb);
-       if (err)
+       ret = btrfs_init_btree_inode(sb);
+       if (ret) {
+               err = ret;
                 goto fail;
+       }

         invalidate_bdev(fs_devices->latest_dev->bdev);



