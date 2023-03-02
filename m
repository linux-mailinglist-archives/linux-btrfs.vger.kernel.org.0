Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74C76A7C21
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 08:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCBH5C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 02:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBH5B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 02:57:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D6834300
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 23:57:00 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3227lW7R020293;
        Thu, 2 Mar 2023 07:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AIhXrZswEckkILdevu8lQTkWKl5SWi+HB5mI9H+rU5U=;
 b=wjyLXfagM3+KtmfdnmTqPePLT0hiVfvZyKpkhxwu8vLeEau0l8g7WiGkyWZ34HM4eGos
 m+8OJCdJrAh6vn+9OTvSOip8MFQsW1eMU1q9xqFI4tZssnxr/gWDZro/qTmRTzdRaSwM
 FFjPbGCNQCBasB41HGQBv67qWXXlQf7vrNwf0LhtNu9TjQM2FPuGxdtlbMLtXqV2AwOa
 ySjfFHHShvtmcsJyt/eEbHBtWbQib0ArlsonKR+dunkjSl1UMkCdfbU+5FLRy5399til
 cx91pZCxWCq2LiR+49M3W9smtGU1LuWDuN7kg4xn6Q5VyWctmwZjQP1jYYo0PEQTWwEo Ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2b12e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 07:56:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3226jU1C031513;
        Thu, 2 Mar 2023 07:56:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sgg7qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 07:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMFgw1+0zvGxDxF2n3g6Iq4vwC458qmLRQNRf2sYjuNst3CyOhg5gxvFj7fuX0sdLEZ5N4jjpvz8q43P84z1Q0pXdXZ/uaAqt8Y2JkOcul+nDNixK3WSmGJqHQyfiyJYt64e5erUpMq3bxFlWkvE3xOwwNG51oJ09KAGtGDUC/aKk+x1Z6i34nq14GfOHbvc4fiOde2DKVX/VHVJQqBwPZXsCs+aLOrOz8O9FeRluV5PoEj4Jtb6XD2bIb2IDkyToWb44M3YWNW74Uy6B2YMQ6pMjtBAm9KqzwZFjXnCbuHekPktO1PnXTOg3CqFUyWjnc7mXX2cOWf6jSFvVdHcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIhXrZswEckkILdevu8lQTkWKl5SWi+HB5mI9H+rU5U=;
 b=TJn/O792XuXLqgAbsLasXfAGPYuUQV2cC2MnJGsLzgFMP142PvgpNjlQl6vq2MzOJD0yMaLdBySY0BruariAHekbQ459qGjBj7Q61dEpYHgfxcDOKw39KEZZTjZTcsI+1u5Y2s4R6efk2Z1fva9QWx9lwVa+99VfJiHFEhsATgYyZ4tQdp6TJKhsK4jdNFP1ikFF1TWdQ8wMpVw9q7I2hVOeFhJCiWT4qVXmZhk+Z+dqMcDBDS1mnGmVArbRuKgl58FwOR0k8yZt792huRkFzXMqrdDMsq3hAoqBYFAOXEd7viFnZ62/6yVUtSZg2b4ogSz4exNkW274mvRgQVxG3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIhXrZswEckkILdevu8lQTkWKl5SWi+HB5mI9H+rU5U=;
 b=tqQaqp6SyqD/QtlWqCmiuMsrSiAcX3ES01tXyIU3AnIBu4ttlHcXraDKvJBkoMJ2aIM5WLNJhGXIvaRzUzlyeMhBkKTkqS0Uydpud7Rs2rqy7a9qPEuUiDAiwD3i58MILUWdJJB8sDXlM78SZckk+eC3Ul6heJsx+mk1JeMNWCw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.14; Thu, 2 Mar
 2023 07:56:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 07:56:52 +0000
Message-ID: <806267ad-efdf-a6ab-d338-de822a8e8fb1@oracle.com>
Date:   Thu, 2 Mar 2023 15:56:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2] btrfs: handle missing chunk mapping more gracefully
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
 <057a597a-d4df-3b76-1d72-8b60fd683a7f@oracle.com>
 <b435b22b-10fa-e212-7167-fd023efef07f@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b435b22b-10fa-e212-7167-fd023efef07f@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aad253e-5ae1-4b61-4fda-08db1af3af6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDoZ2ZB0LlQ+lMnSwXwkFeFK9CDTG6r6u2ubu23LXymRAPzSQunqVuydJSuxhHcJyPNXkaSVjse1EWqddHfR/4Sd2tXqKGfkEpiP0eaSWjdiz7UJ4bQ+X/9xlZfYfryX+j6AjbT30EE5n+p7VFD/NEzJY1MLMOo1A0xeVGSBykOgKJ8xjGXiNNKuJcnJ0+vg8R66tbZoCpRW/kgnTJo281AvsMqYDOXYDwxMH+ltIkMwGB/tuhKaAc+e7FFWzKHDeA8WiPpHGqy+ao2u6PuzA0L+A/vvQ+bMRve8ME7RxDqyLUHCY9UXNK/GXj91zyScoxZkjWqIoagvlMFjawqwfUkDk+B19mJ/5TX/AQo1ZT9ad97c/ldPqnLI8wsgCuwjQbqMYesvRnMIH+KXqLzuuh6gGxBmMpybECpahNCU+8YyBp/1tjHvcZU8q8VgCtrxrcl1+7o8HVbndRaN3Hc+j2AzXB1EG45XJBTcYG4TfLRiaSbVrRvvAs6erbWjV2kyVCfPPC5za/HtmRw25uN1BdOrQQ+e75uepW3fqr5Lczn2/o1Fkmqt9P/WihNAnEZVIy25YH3ijB7fFHCDPVTrFRikEujcDt7ovUlnkP0LsFFffzKfiGR5XE0GJOAi9v1BO93PboVYjS5D4FPpXD27JGbndVPXR3gh6HmH874F86sT1ah8bqolsDt37Lm6tAdnys2WaxAZiJ2q6nzw04EtvKU5IUXaNQ4SfExm6hjB0Ug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199018)(2616005)(36756003)(186003)(316002)(110136005)(66946007)(8676002)(66556008)(66476007)(86362001)(6486002)(38100700002)(478600001)(53546011)(6666004)(2906002)(6512007)(6506007)(26005)(31696002)(8936002)(41300700001)(44832011)(5660300002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVVQUEzNVVkREc0MW0vSGpxclk5ZUFReld2R25kZGIzeXNMZ0JRZUVWMGZn?=
 =?utf-8?B?Tk12dlhwUFpJRktWS00wV01uTUR2Q3c1d2hZc3BsRHI4ZldKNTJlZS9sb1Qz?=
 =?utf-8?B?dzhYK3BDUmJWRHBLajFOdmprbzhVcVZURi9GZ2Q5SDZ2R0xzcDVxVVBubllD?=
 =?utf-8?B?ZkRvbEF3QU1JS0xkMnZmZW1abTM2eFNlTVlsTjlYQkVxMkZyWE5UaXVvdkFr?=
 =?utf-8?B?UXR3ZHZHNEVRcHRydjYvb2JpUXM4c0RzRkhSc1lSSWhsOUljcHFDYlU5QlJP?=
 =?utf-8?B?ZnVKNjRXQjBVRVFDNC94dHBsamMzYm9yTGxMb3FXZnNlLy95K29qeFlnK2xv?=
 =?utf-8?B?UWNLUUJwWnY1WGpkNmsvaEUwU3dRWkNQQThPZUNERHdhSitvNlJRSnZ1VHlG?=
 =?utf-8?B?OEtmZWxUb0JnOTN3eW94RHhyVFpQNk1FMktKQmNkUzZlOGZVSThvK2ZNQ29k?=
 =?utf-8?B?b2FRQTc5QUl5eEY1MlNrc1RiRkE4Q2huRTZwVWNyNjQrU3UwclZ1MUVtaUdC?=
 =?utf-8?B?QUN5NUZERUtJUFYvcTVkc1NicEJsUHEzVmw3eXB6UkROZC9CSmZOdFBlSld1?=
 =?utf-8?B?Z3R1RllGSXRMbThyK1ZoNWMxeEFFTjFlREV5T0xEc2hFQ1RnQ042TytBc1VQ?=
 =?utf-8?B?R1MyNzF0bVcrb0JJbHAvOVNHKzhDWHQwWDgrYU0wY0VOUUxCQXRyRkR4RS9p?=
 =?utf-8?B?WXl4d2RZMFRNcXkvZ2tuZWR5bnV5SnRzL29SL0pEQVdqcWY2VFQxR1Y2cDFQ?=
 =?utf-8?B?WHJJeFRGUnJsT0FQUVlDNVRxY0hvVmdhWnpxQzRkSHloQzBUdzl1dytWSFEy?=
 =?utf-8?B?bDZJRndxNjVvODBKYWVpMXlSUW8yZWRLUkpaNUtLVUNuV3BMNWRnRVBVVmtw?=
 =?utf-8?B?V1JWTjM2alh4TExoQ1FZbDlyZnFFeTNUSlhqdWd1ZTdDTm1BR0o4YkNPUXl1?=
 =?utf-8?B?elFpSXkrQW1QT09JUG5IQjJnTU1LbCt5dExlbFJONHF4akdjQjMyR2l3UlJy?=
 =?utf-8?B?UzZJYnBWUGlCTXB3NHJsK3p6OFBJTmpQVWZKOVpBUmZKb3M0MTlFejRzdHZo?=
 =?utf-8?B?QmNqeU5jV0crRStCNk9IdjlFSHVJSGw5NTRKNktsRHR2UjhUS1g2REtsaDJ3?=
 =?utf-8?B?aWg4RkNTeWgvNmJ1RjJhSWZrV0xudlVLMzByekhxTEQrZmtmZmtCdENJSFBF?=
 =?utf-8?B?SmtTMWtHYTdrVkNVWGVIL3pGWWhqWDE1ZmQxMlZnL1Vyb1RIcDZ3c0xSNHg3?=
 =?utf-8?B?Q3VKdjNsVDI0RDZXdElPT2NaaHBZWXhVZ3piVnZvSENjaEhEeHRDWDRJa0dk?=
 =?utf-8?B?cHdQRDhiTGxac1RCNXZUNDFZcVN4UTlUS2tqWFdmVFJQcENXRStueGI1SWxk?=
 =?utf-8?B?a1RROTlPTWx6dm1wZXRoaXprQ3ErdG03cXNqNDUwY1lUU2NTeGRZdW5UM0JE?=
 =?utf-8?B?dkhJK2Y2bHFNb0hGOFhDQ3BhSzZNYVN2QmJQeXFXdGVRSWI3cGNhV2tjRjJM?=
 =?utf-8?B?OFUrQWZnMU8vWTROMXVMczZsb0FtSFZYSVFIS01OTlIxQW9OUzlsVkdJMGFB?=
 =?utf-8?B?QUNqTHJBcnlyelFLWHZueE1WcjZyclltRUkraDVlRjJmRDcvY0lrVGN0NjNX?=
 =?utf-8?B?ZnhRbVR0aERsT2dlbStpNjRYU3pYL24rSzd5TENBWHlidlNjT1h1R0V5bkNB?=
 =?utf-8?B?NnFoYWg5MGJlaUE1eFgxOXlVOEUwSDFSSlNTZFp0UFJxSm4xdHhrTThpTUx0?=
 =?utf-8?B?Rm9zMFN2UjVDWHlRei9WVmJQWUR1SHdySEJXbERobC91SUlReWlWL3VmL3hQ?=
 =?utf-8?B?SHBZTmIyNlc1Q2FaVk5QMlBGTlhpZ3JUY0Q3c1h4YXhVemRGMmtZa1JtMjJy?=
 =?utf-8?B?ZHdqVzFzZTM3SFJ4SkxhRXJZdFBYUDAxKzJZSSsvTS9zNjRWNWVIa3JOeGgw?=
 =?utf-8?B?ME5rSnhhSm5HY1VReEhIN2NIOGJMZTJPTzgyZHlJRXJxSUROQmZWZ1lxOUg0?=
 =?utf-8?B?RzNEcWNqUmlVVWErQnV2QnRlMVdBaXovMmJNTzhoaFo0UlBJK2VJaHZMeFRa?=
 =?utf-8?B?U3gvTy9VOHFIMHhtbk9NRFNpNTA2TTMwUjBZTUk4QmxJTWxTZjFVd2UweFlG?=
 =?utf-8?Q?PpW2z18y7KjI25d9QbutSJQKj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +xUTdaWLttnoL4u82VIKydbk8MGYp9xwq60uOaT1fYOywraw2qt6uJcxxHQUuPTSBWHVh3vgNFPH4N4448HdxlfWu64gsqoXN/RnrvTVLosQ5A33Iuvto8difx2fyKXxsTpt/VPLYGXJTDgJe+567T5wc81Z73DQRsL2Ot/rPYOUwOVqfu3nz2TDp18iKkcz0tY07yYIVEqUAP11zsejJKMYUMB3hU3tJiFfZ2Smp5XEfsFdpXwWEBQ7P6O1RItwxusCtanE8DGQF22kczgRHAGYpQyWs3a/HwckYf2TOLqIQkdtvESzEu2THyqydhkH6/YSk0H5sQN0lSJZjmFlfNjQ44mJt8c0V2VES9HW4w7lQ1TGix+UzhxuoGLNtCgUKypUfCn0DcM7ULRsg3hhG095CrODAJamatT4TrbTAKUlLv62ApVdz2equryj/grQuoCi4BnOlB9cbJdkXwD1bdQ0FAVLydGWUl4KfxWn4dprR2DemKooRVss5d2xYZkluLqrDw9ZkOS5cQ0RyC4ZU6pNJS5hsmC1iI9RNM8Ux5ec31/Dt0a+VKEHNcK2c/z/FSDPMxAd02xOxWZ1PbTj2I1xLU/5sxtMUh7nqVLrB9E/VRNYh1Tb7+jik5Rk6NsJSsiuOszS7io94PUni4JaQPFE2OOimxjeVJ77ozAnMPGTRZt2laOGJCc03OHs7eybfs2JkS3dIzsJPWT4zwh+CTVupSdBcUCZ5+nArGHPieLm0pTGf76uGDYzCdVvmuKL9nD2HMN1kl+BbMG+yJ8A1oYzphVMPBC41xm9oLBcpR/LU2Yo1kqa9wd8Tzo2WJau
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aad253e-5ae1-4b61-4fda-08db1af3af6d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 07:56:52.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LldzMwK3XIaVaf9MnSYK1bwGqzuw5UecJJSQ7C59nhKecAmpf24QKbscoGqBh7AEIk6goa02N8SfVgGSoCAlaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_04,2023-03-02_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020067
X-Proofpoint-GUID: g_qnA1esQG0BryVdl7NvC9XXhWN0NWZX
X-Proofpoint-ORIG-GUID: g_qnA1esQG0BryVdl7NvC9XXhWN0NWZX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/23 14:49, Qu Wenruo wrote:
> 
> 
> On 2023/3/2 14:12, Anand Jain wrote:
>> On 3/2/23 09:54, Qu Wenruo wrote:
>>> [BUG]
>>> During my scrub rework, I did a stupid thing like this:
>>>
>>>          bio->bi_iter.bi_sector = stripe->logical;
>>>          btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
>>>
>>> Above bi_sector assignment is using logical address directly, which
>>> lacks ">> SECTOR_SHIFT".
>>>
>>> This results a read on a range which has no chunk mapping.
>>>
>>> This results the following crash:
>>>
>>>   BTRFS critical (device dm-1): unable to find logical 11274289152 
>>> length 65536
>>>   assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
>>>   ------------[ cut here ]------------
>>>
>>> Sure this is all my fault, but this shows a possible problem in real
>>> world, that some bitflip in file extents/tree block can point to
>>> unmapped ranges, and trigger above ASSERT(), or if CONFIG_BTRFS_ASSERT
>>> is not configured, cause invalid pointer.
>>>
>>> [PROBLEMS]
>>> In above call chain, we just don't handle the possible error from
>>> btrfs_get_chunk_map() inside __btrfs_map_block().
>>>
>>> [FIX]
>>> The fix is pretty straightforward, just replace the ASSERT() with proper
>>> error handling.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Rebased to latest misc-next
>>>    The error path in bio.c is already fixed, thus only need to replace
>>>    the ASSERT() in __btrfs_map_block().
>>> ---
>>>   fs/btrfs/volumes.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 4d479ac233a4..93bc45001e68 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -6242,7 +6242,8 @@ int __btrfs_map_block(struct btrfs_fs_info 
>>> *fs_info, enum btrfs_map_op op,
>>>           return -EINVAL;
>>>       em = btrfs_get_chunk_map(fs_info, logical, *length);
>>> -    ASSERT(!IS_ERR(em));
>>> +    if (IS_ERR(em))
>>> +        return PTR_ERR(em);
>>
>>
>> Consider adding btrfs_err_rl() here.
>> Except for scrub_find_good_copy(), the other functions do not report
>> such errors.
>> Furthermore, scrub_find_good_copy() lack sufficient details for
>> effective debugging in the event of an issue.
> 
> Function btrfs_get_chunk_map() would already output an error message.

Ah. Right..

Reviewed-by: Anand Jain <anand.jain@oracle.com>



