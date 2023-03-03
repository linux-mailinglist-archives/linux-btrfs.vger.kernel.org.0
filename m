Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C8E6A938D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 10:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjCCJQh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 04:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCCJQc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 04:16:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24B624CB0
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 01:16:31 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3233i5c3032688;
        Fri, 3 Mar 2023 09:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=E6DPakre8DZzh8oJ6g4Ljsk55DuPTMBjUjwE3NqIaR0=;
 b=2PKmKtdoxGb1qnGr/YXkJt0HJFaNOTyBPmQTbwCGFApfvpivfCJv5NMK5IwKxvbBMSua
 YiBORsGdLQtTu/Lk1WpsPhdBDdrGHoUfFv5uweO7kqoT0yjxqn+gjYvRXSPUSHOXPW7s
 9l4HdrgJrM+80APjGYlZE5YACxyM5AKkuk7cLoSuM1Q9cHG808vWfirZmsUIkGaV9DKT
 QjAGeoblTztRSRsy7rrrnfytWlr2toKBHIY4qRjvDG9XmqOVMPZu5ZTSfM25MivKz9cd
 7b304Xpgz+GmFfOUey6JTV0sGCvBP9sFyWHHgEknZ/4jEB0zc8n8Lfhxn/dCxwap6ZzJ fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2e090-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:16:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3237WBfm002214;
        Fri, 3 Mar 2023 09:16:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sayseh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYvZ6bfR+3R/RBN5MDO0jnla4qKnay7KV9nblOlvkYR5lFL1/CdCIm4Mti08hkzPUywKtGkcXlk38LtcS36BcruY9cAFvwv0Wzmd0Zao26n6ycycmqggJfQzbNHWdeh+dRCDPHjrLyvctBzPPQKaCWFILcC/s9+X9AI+n+AMUf9AtJz5oJUJ1HVRAEUM3b9SalAuwYqFk7hQlGnnRZFMKTByjTeKEbw5cahKuABPqTYdMGRUynlAN66I9yDWSDCUNoE3VxjsCiDYHigHFHVgg6DmROvN1DgTKyOkJrwfFYSEgBUQy2xVsRGWEmMMD5cE02G8beUcOzb6+IHAPg/rAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6DPakre8DZzh8oJ6g4Ljsk55DuPTMBjUjwE3NqIaR0=;
 b=Id418w8s5ZJBVaQIbQU0tnkkjFounN6RnRMzJqEiAAWUZFLh0w1j/KgQ0NGwF2vHec7iaUZOeZMuB8R5XRtGtixBixdjmdNWMKiR9GtW0vJ+B0cLrCciVhi9rCm6gpnJDtLnCJ6cq7FvmfELmII2ywBaWxxldcWGOlk4RcUhgy7nltC4zJhXfAckI9XzIFx+Mf8CWzPl9gE8Qtcc7BXVc7u2tVBrG2RF3BEnSAL/hnqIVw4GCF1IlJfpVrgH7zOMVuWm6CyS0ZIlhvB/Ey/PCzFhSQdF567ns5cvPq4es7L3XtPLXUGcgcO+kq1Wx56EKRSb3tqO4tg/x97fFc9JXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6DPakre8DZzh8oJ6g4Ljsk55DuPTMBjUjwE3NqIaR0=;
 b=l/Tkj7Bp0jz/MH4Pm0Bi4nTWGQEnXFREYvyctZtIBwnQAcgvCtKtWSMERY0C6gyhxpycM4aCGZU817G/3z9ICRkl4EZcP31c5SJTQJIDDCOqxR/N0a5Fcn2ul+4zQGq8Dx/liLgmVXBT/yKN+c4MDLNDB8Q78HXQX/9ehrd9mws=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Fri, 3 Mar
 2023 09:16:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 09:16:21 +0000
Message-ID: <b3dfa482-7fd5-16e8-2bce-8393814954c9@oracle.com>
Date:   Fri, 3 Mar 2023 17:16:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 08/10] btrfs: store a pointer to a btrfs_bio in struct
 btrfs_bio_ctrl
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-9-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230301134244.1378533-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 2945705a-9a34-40b4-af05-08db1bc7f433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqlVjpDygohcdqAhXQa1WxKcDP1xFxvm/tSqgzPHgu1emq4cdc8bajpsZpAo0ngJ68/Gtewd23ATqidMr/M7YrUnyq4kEvJTCB+LzXzSBxbyo0S9kaZ+y83kCFz/b6rPVObQDiooYBgkvcYESCDuUgALa1ss4vhMagsICz+5G8ej6pNm29FbJhtQSCb5Yva83aAej8g08sOnjjIkTyTFX6uOtde9XNSztxRXRgzNJlG1IerKfDfsgA3UOuHDvgartjKmcaB+QZaRZvVh+/PfHItAWg8tgZ/Py8rObXm8MM3TFm8Gez+zPujIcjI+IfqcqSCkZJ2jWU7dgOIlEChw4OtCDMSDcJv3+1URRn6sR17CJBUD9iidtQwq9Mr6d/WVavxYnF1xUlvlgBmXkuNwXSj3X/r+xQs4wIlz7syMJajJ9u9fCMhSB4xMjOkZCKV7UOIvsWPs2mMhQvH9SV7X0nnPJTZcT5wwRmJy70GwdpL+bbcW4e1A7PnhYZ9g2W+u5GcSkQO+nrM+RYYgVzfK63GOsg9UlDHyTFWCNSNmIup7wksbuIK52u3oyY2Y+DVGoBPjfAdZfzsNxJAbLogKDwfsXSsJyobhjXPfKXWxpXiHdrmf/gdIXrdZPfXlns/d7WmhhamAzoMuhObdw2gjcDBUis4RZAltnWwGu8gJ6mYyA4Q7nDg5IIjuxjcAx2XlRI7MwNyDj+mAxAIpUZDFQNZ48oFA+jtpQsNZngQpGqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(36756003)(6512007)(6666004)(53546011)(26005)(6506007)(6486002)(2616005)(186003)(41300700001)(4326008)(110136005)(316002)(66946007)(44832011)(2906002)(8676002)(478600001)(5660300002)(31696002)(38100700002)(8936002)(86362001)(558084003)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUMwd2pZd0FCcmp0M1QraUlld2VhblVHU1lzcTI2UGxIYlNPVU1kVzhVenpo?=
 =?utf-8?B?VUxHSnhZbGFvZlYrUWQ2Uk5FTXJBQm5VQ3c4QnR5RllFV3FzS0trbVZJSHdp?=
 =?utf-8?B?bHhSUWpXUGVpS0NBUGVkUHdCU1l3eG1QL2hyM2NLVWt1S1hGa25nL0hKa0VI?=
 =?utf-8?B?NndNR20vdUVCQm44Z28yTXBVbi91ZXZCck5PVEd1cmJ1TDVzYk1OakNrblho?=
 =?utf-8?B?VmE4Snp5L0VSZUNBWHl2OTZMdXl0NktvTHR0TWZ3cW9NdWtnbmNvdTZYQzRt?=
 =?utf-8?B?SHBpZTZIN09RYTJxejF6MWtrMWRrcGJXeHNyUjJtcVNicXk0ZkZKaDljRFFk?=
 =?utf-8?B?QTA4WmpnK0dBY3FMZklHK3g5NVFKNzVyZW1lMXY0RzV1Z05OUk0zbmxoWlU3?=
 =?utf-8?B?SDA2clRMeGc4MWNkQ1gzUDNBUVowQ284T2hmVUdjRTdnclNNZTc2VHpTMEtZ?=
 =?utf-8?B?dWh0SWhvZnNYMlV5ZEpNcldFZ25Wc2diQkdMTDNsc0d3dWZvQzcxNXFHVmJF?=
 =?utf-8?B?a1BXYVR6Ti95NFkyRDdKbTJjaVB5algwWlk0U2tLakNTVnpOcTEvZWNFSW91?=
 =?utf-8?B?VFVSVG9BYWtQbTR3NWlPdkhlOCtFM296Wis4SGFOaFlrVFpjb3R3akNKaFRZ?=
 =?utf-8?B?Vm9CK1poV1Q1SkhDRlgyN2ZQODBROUg3NUZ6VDNXd0l3MHBzYWQ3QW42c3JL?=
 =?utf-8?B?ZWdTMTM4N3VPcm45WVlza2xZRGJKNzFNQXJYeWp4bkY1SE1pWWxlRmZMSEJI?=
 =?utf-8?B?eXZmUTJLTGVKTzFDZ2x2d1NQbDVTTUxPcXRpb1pZdGZVS0lXSHQ4Zll3ZlVt?=
 =?utf-8?B?TGFwYzBhanJxRTBNQUFQZFoxam81RnRuV0pGV2FKTG9aNDNFaWY2NzJ4ZmN0?=
 =?utf-8?B?cXI1emNhV2VhNjh0eTYyOWVoM2l4aGZhb0N2d0RxYjZkMmUvR2xES3gxYWF5?=
 =?utf-8?B?R1lwazdHS2lHU0EzYXlOeUFpcW5FWEpheWlqQUorMzBhSGVyOXhhSGh0dFB2?=
 =?utf-8?B?Uk9DZENDR1BITjVIdEQwQThWV29abXB3cnMxVUFOUnI0VDFuN0FjYUlwVGVP?=
 =?utf-8?B?U0lGU3p3MVFNQ0xSdGNpMWp5MmIyQUlwbmJGSDl6WDU1Nk5QaWhlQmxyeVhz?=
 =?utf-8?B?NWRUVndWeElxNXN1ZzhTcnBGYjl4YVQyYTUvNHl3c1FzTzFuVjQrc2xydVBR?=
 =?utf-8?B?ZlVkc08xL1B3N3BaMnBxbmpaelVCY0ZQNnh2Nk5uSHUvMHRsNjJNUU5JeU5Q?=
 =?utf-8?B?RktLWFQrajdCZ2N3RTFyZW8wcHdOYitsck03MEpjYzMyVDdqWEtyNkNsa0FW?=
 =?utf-8?B?aUFQa3p4bU5Dc1JPTXhvYmlFR2dQdUx6ZlJKSDNjYzVhbFRHNmZvWTRoSUtZ?=
 =?utf-8?B?a1N2c244SWhSUHlGRTRGSTM5Z2txMjRwNG4rZlFXbGlhM1NIQ3FPdUF5SDhN?=
 =?utf-8?B?M200dXhzMk92b1A1SURrOCtqcThqZU1YY0UxV0MyV2s5eDluUzFkUnJ2eXpw?=
 =?utf-8?B?QVl6bVU0MFg5QTRSMCtrV1B5TmY3WmNCeCtxemxUeGJGbit6S3hOQ3dvQmJX?=
 =?utf-8?B?cXFJV3VYNXFTMUVkalAycHlyZG5yL1dlMnlscWRtZ0pzQkxva2lkcERVYkhC?=
 =?utf-8?B?ZG1xQnpEVkk0Tkt5V3M3QzZ5aEE0ZXU3NHNwTmdZQzFEeXB1TjFHKzlQa0xT?=
 =?utf-8?B?OHFTTWI1WEZCYnBUWDIrM0ZuejRGYXJYT3Q5bHVtUmk3Q1R4UmJjWk5YRzZH?=
 =?utf-8?B?MS9BeTJwbElXUnVOUURJY0RZSW95SitPQytkS3ZiWjdWVlQveTJ1bk9nT2tD?=
 =?utf-8?B?eUJaSXdrQ1YyU2s2YTJxUlJBcCtPTkxHWjNOa1FNVlNMQzYrekRCcGU5am9G?=
 =?utf-8?B?M2VralNvaWtoZjRuWGVmMFQ0c3BuZlZPazlVbDZqZDNmczVKY0VmMWhIWVU1?=
 =?utf-8?B?Z1lac2FQczFvOXlpK2tiQk1ySnVWWm9Yb0hmdTFHMlVTbTRCZEVucko5RVQ4?=
 =?utf-8?B?WHNUTnhpc0NBSmdTWXVJNkprR2wvYm4yWHJYRnlncUNoQWJOMVREWVd3OHZk?=
 =?utf-8?B?NDJCQ2xHSmtzVG9RMjNxaXZRMXFtVnROVmJHZytSTW1pNXVsZ24rTURSY0pn?=
 =?utf-8?Q?68chcf4eX3rrz2soKTwLrX2fr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aaK3cVNj6zWp70CN+ScykYZzE4WKIq3ReFtO0RFiRgvNqPFjmNucUfSgZcaFK9+RuHjkb9YeNHLPtJ/bdNDl5bq1s7K8FNpQKZntMK67fdh9Mb118VJIdJkL8fv+BVSGbnlEkzq7Bh7u8wjUDlnMPmCHb4ixbxCX+LkXw7FP6xePICyEYiFsP5JWlLrdSH6Dcgqhq/9D/UKMVa0MbsSXVrJWInAhFIjXGDByONsIGdUB27wwCQLPKGNGHGFZE0sH8H76Uz0kypr75I6bjQsQ0L9NVB7Pv200Evt9nzIZvnHeQD8NcjZL/JNAS2504PZvjbFcB7DoObMacngmnWc9PIsKvcGZd9b0e7ZjDxqZ1M9Y3UOPg+clwlLfFx13sMgON1R3gNVk05ZDHMNNrlwObDAU1J84Ihn5b5BEo5HTzJKHv72nUpNsFVi/jBo9ZgUbtmpbceNu3JmujlVIo8xgaX1Cu/WMfYLIe1yxTOPH0Sfo7mrn3n40yRSFsyXaPc17N99ea6f79HGHjSVySCNXRrd/82/ZLMLLZhN96erUGrzz/xiQhdDukdRd7+AlvoxhXcI+oElLfup5BdcEyv801qkePECJoS5mPBHzwGtbLkCnySe+CKpYJKWmxCQGQJZmsM4Fk5C63aWCNI/CDVbgY61F7jQVbFFW70NlZDBBDc0huww580gYeUTqbZCIRGgwyPm0ZTvWtHtlv2TBhZcaWUso+on62NfFNiYR42FqbyE5EEESncALHrkhwWic5q3yt+CEQsxhxyQh0bSwgQHJBwoYWqfQSSUujyMuxRxkzcK2qoyEx9ICP/vBdfNuxITPBGMOnGnvAie43utf3yhVCDm0ZwUd6h4NQ0n/cvYT858=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2945705a-9a34-40b4-af05-08db1bc7f433
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 09:16:21.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMJR6QZ2lsvFxQe3SDQWweWabYgKM45vVaiDA/S/23fvI7UE2W0tax1CEir7oaN6UM5MEjoOY+HhZEF1BgJajQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030082
X-Proofpoint-GUID: JBg08T7jF7ZngnTBo6ibZ0--01EIXtHa
X-Proofpoint-ORIG-GUID: JBg08T7jF7ZngnTBo6ibZ0--01EIXtHa
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2023 21:42, Christoph Hellwig wrote:
> The bio in struct btrfs_bio_ctrl must be a btrfs_bio, so store a pointer
> to the btrfs_bio for better type checking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

