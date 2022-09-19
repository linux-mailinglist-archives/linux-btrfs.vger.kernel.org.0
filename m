Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6500E5BCBC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiISM0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiISM0V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:26:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5892AC47
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:26:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBxSZe007393;
        Mon, 19 Sep 2022 12:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=s8xEPqcPvhhkj+Up12XAER057b2kxOfybllZcHIf6Qo=;
 b=Q5g5c4uhOpdwn0td/zbQl+p0kUax+D9epuFRDroNFChZFVdTGGHyYtzKy01oV6AEyORg
 dFd6BtAo1uTEf1SUvn5tyTPpXb5vjv7F1J0+cx9uLlzfD+mMp/B3Q5yNEq44EEYQIHmn
 ZSxpviT5Jp+h5VMuwapzf7LqCmRNf8n/QVEuiBz2uSEyy9Tw0b7PV4lERn5aLGEG4ktk
 /nj5ACOyCP2i2E1grUR2EP8sm1x1GPybO7gppZ4XvoZBn5pPKmWNKHLjnAnkXmgzfgRf
 kE/mtrAbqXbmdCQTa8JsApsGarBDGhzEFc1VOIHbbwNH6E/89EybakZB8Uu3iT3K9dhU YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m3m37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:26:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBTvLX009273;
        Mon, 19 Sep 2022 12:26:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3c7jxue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:26:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQGDmj1zl9u7G8qt9UMRxgLTu8eKkU+1UpMNWk4l7tgYD2jxloCdyClwK8QYeRNCwQVSq5gv8egMpOpwZPhkc2UJY9j2kg+ReiwpagXQtl5kgz8PQaA40DCqpYE069ko0J4Q1G+PzIt2B4fJSEtCoVWJ1PLeVaZOVmMYHuTjNRBGwDmH1/sV2OlUspQRhRTdQs6IWZIcSrNumpGEJ4Qk5nLleUZt1OT8/JwT07Q8P5G7U1HH1A4gE/RgoZXAd5lY7cMVYgBsWNn3Ni5CHvvQlO93PFns9ixW4sTeM0Gf5w1RSk6VPWfCyPMjwmMP2xXS3sQmvbwQuPnGgnJfUSey/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8xEPqcPvhhkj+Up12XAER057b2kxOfybllZcHIf6Qo=;
 b=McrCPvCwnTlBYQWBBxi6fb5FY1ChtSaDT+k6evv4C6kI/RHDywaBM3shxqDFFP2voLxysFSGd4Q4sBaEqzkIrAxaonQhyum9XtJQx/8I4i6Pboh1WoWOIgqem9VSjt1vmDeyUwE8xGBjbsA+JXhXtEGxFNlYhpgqaMvgmVu1RxJAi8zkS9RVP5Pt10LS9kSYq9PHWSEFK0RvP5SSL1gVtxmC1TiF1/47CnFwdeP/n3pZkmPRKgj3wdpQ/wMOUKzXbbZ6X6CtAiIYJZ/OUyi3bSZx2gqz7NOAf8cIYOobamnQJHCSdc4+4YkKrxans6wSe/m3zfeQY1Nf38YXGE4zLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8xEPqcPvhhkj+Up12XAER057b2kxOfybllZcHIf6Qo=;
 b=egS58M+IguXhBIG0inWJXUOFwcpweBVIgO1hzO8npmi2TdYwTOshL5GzveTBow6w87da4hesLo7xQEH9NsNlqTLRcD9AXgOFeOZIUMjxS3j8jqRfdN4vYqhBqK/ZHt10FfWNAGHIkr2Bq+ygDhSZ5VGV+MRnDscCjpagJBO/UJY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5731.namprd10.prod.outlook.com (2603:10b6:510:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 12:26:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:26:15 +0000
Message-ID: <c83b9a35-d246-1aea-177c-eaf1a8e70fe0@oracle.com>
Date:   Mon, 19 Sep 2022 20:26:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 08/16] btrfs: move incompat and compat flag helpers to
 fs.c
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <3aeef7d866611a84296b74ff0ee7938351c58d88.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3aeef7d866611a84296b74ff0ee7938351c58d88.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 829b192b-c9d9-48bd-d8c8-08da9a3a255f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pN+uD3UUmeIkOgO625dJh3nZDd9CdlBpLfAXMTRXsXnumzuwJeFNMjWvUnttSpP120O69JHgNrJ0rQX03dAb02//6l2AuqZCDgZ4sWf95/CLLF8Fu+IDDnEHpeV3GUeKX9GgvJVB4L/gPjlxEtRhpoij6FkyWvdESn9JQGVbnXaojkEPREEosYDnFXq5RqQ4MUMj94MEBN5sCKmPX6DU2HZ24WyTHBTT2LHYvPeZvtLh8QHYxZjYBoZOTyZ9QnksB/odC48XN5ArR5gkRIQTzilw7ZuYE0Y9xk/yj5uutEck0VugnEdMIftpX7MqSvdGYRGrL1B7p8MepnTNv9ly/q9F+8TU6m9RgdOBUePxKFmJPAOcG0xFK4A6u4MbXtpR/hT3wzZO5v+LcactKtS5xaSL8Is3j7Yl0RlXfuDrsjF6KN3NGGGdyg2pYLlOMZYcfEyua7DBAhE/2JPMdYdgeirEfmRjSlrBPH4dkZC4KEm+RWYqhrICzEtH6FIeV+XpcCKnMkuqGYSZm5nLj04TDphvaskPDKxrlRX3rUfMc1mcQ643Fr4SIaA+bsxB9Q1WybL8isx8lucHpcPJIL6RNguOu5/SePWs/4A0WFmsQWEvDseDmUVyfFjfOx48IIt7fkbyYQtDEKAXP20KNcwj4Mxk/iZ9Lk//g6w4c+YEs/oChPGDyu0rgWT9UfW5D8R7hr1nclD1B9bibYMBbh02sTxoKikXu8UnT7ND+x5tQyBZgTNk0dJylE3DZeZVonLhyY5znFWYBzp1eDe2mJYQnrcRP9oVyOy0JCSQCT1xW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(558084003)(36756003)(316002)(38100700002)(2906002)(8676002)(53546011)(66556008)(66476007)(66946007)(2616005)(186003)(31696002)(478600001)(86362001)(6486002)(6512007)(6666004)(26005)(6506007)(5660300002)(41300700001)(31686004)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2NxcmRXZ2hEeS9wQ1BYTzQ4blUrVFFGK3FoYWhXL08vS0ZrVGxVV3NKVXY1?=
 =?utf-8?B?MW1FRWdmdUpOL1ZJL3JTcE95cUJkcjFVamdTbERROUo5aFp5Y09wNU51c25F?=
 =?utf-8?B?a01FWk8zY3FzdGNDb2tTajh2K1pFQW9SczRTTlNBbVJoU04xRW8rZnJwcU5K?=
 =?utf-8?B?TVZ0VDhxWVZFM3dyQXNHTXo4a2NpR3MzUXAvRTl1T0JwMDV6T0xJZnNzQjVF?=
 =?utf-8?B?L1hrR1czWWJlbEwyRDB3amgzSEhHWm5pRG5mczdBS3FHbUtRM0QzRW45QTJU?=
 =?utf-8?B?OGt0cVNZR05kU3g3ZXA5OHkxa1V2dmpQcjdweVdLd2ZJRElpWnV0c0ZMMEFM?=
 =?utf-8?B?aGtWdzZ4Y2FGdlJ6ZHYreURRTzFUQUowbnF5Tk45S0RJY1RPWkRFY1dDZVJO?=
 =?utf-8?B?NE9HV3RJNG5xMS9zYWJJV0pnNVhmbVNrek9WWGlNYkNydmdQSTZ0eGFTRTBU?=
 =?utf-8?B?MlUvNlBKbURhd08xTWVSeTF2aTVPa3h6VXpNZjQxN28wQzczU0hOcFVLbTV2?=
 =?utf-8?B?WldJbkdBUUNlbGVrZ2N3WXprZVFsdU16MzIwY1NoVFZJOHFKNTd3TkE1c0ZY?=
 =?utf-8?B?N3dRV3IrMXpCQm9MSTBVbDg3RGxCZmNlRnFlOE80cEEwN1F2K3cvbU10cmNY?=
 =?utf-8?B?ak9RTFZ6aUFSa1haQ0VIMTJaK2Y3djNUTFhOY3d5dkZ3d0hIdndJN3phQWdq?=
 =?utf-8?B?K0x4UHlpd25YRVo3SitlbWlRVGdYN1dpV0dDTmY0bzNQOEo1QkpYY1VSenlp?=
 =?utf-8?B?bFY3Ulo1eGlzSk4wMkZGQXNuNEsrUEdkcS92ODFzT2tFUTBJYWZmeGZKc0JN?=
 =?utf-8?B?UGFrc05VODF5VmUxdVQraGlFSEtueVY3MzFQbjcyZHBGdG9scHhJeGVpYTR0?=
 =?utf-8?B?L1dkSEdzOVd2elZnTnhENGNPK2dnNWFzUEM1bmRWUFlidTRLbGlkRXdQZW0z?=
 =?utf-8?B?bjlLaUNNUEhmWVZ6Nm1EQTJHS3YycGYrNUtSeVhoMFZWWEc3Q21INStGRzJu?=
 =?utf-8?B?b1V5S21NSTkveldHcWFzdnhUeElhOE8wbDhZdytQdGZQSDNOY2sxSjBIem14?=
 =?utf-8?B?M3ZoN05mNzBCZjlRU3pkdHVTZ0VGdUN0M0hYZXMwc1lua1Bwb3NWVDhvaVYw?=
 =?utf-8?B?Zk9nOUc2VEtDamozNE85dHVGdWZ3bWVPUWtib0FTbUFBUThmL2FvYnRRZjF0?=
 =?utf-8?B?QnRQMGxQTnFuRFlOUG5rbGRCV0cwT3JDWG0yUHQ5eXVKdExOZWx4L3drNTRl?=
 =?utf-8?B?ZXJxNlU5TnRCaDRKekMrU1g2NzhpeXJqcTEzWFVRV1lDOUFKajZ5TU01R3d3?=
 =?utf-8?B?TG5BQy93MG1FMmljL21pQ1dEODQ2cXZMcDdPNjUvVTRzcnpOdWRTbzV0MGp6?=
 =?utf-8?B?VzVWemtobkVuTmFHNDRlNENkSFJ2OERWa3B4cVhRTUNkaUV2bFF5cU9Fc3or?=
 =?utf-8?B?WE90TFljdG1xb3NaYVN6UGF0S3hXbExpbHZZUzB0NEJ1UXFnd3gxMUdKZ1Nj?=
 =?utf-8?B?dXhOZXhyUSttZElMZU4vb1prOUhNei9YT3pUMTgwcWpIdDB5dnNlYTE3R0NG?=
 =?utf-8?B?ZmQrdktUeWJWa2JGZXFzWi9XU2pYK0RzdnhJTXlSbVFKZU1oN1B5SURuWVlR?=
 =?utf-8?B?WGVMYnlBellZYWdnUUd1cldsN2lSd0dGK1puSU5HMlNZQzczekdjRzU0NXNB?=
 =?utf-8?B?cmQvK2YxY2hYQjRqRHlPRTR1SktQRUxtSGNWSGo4ekpNc3lvL2JEelQ0SU0y?=
 =?utf-8?B?bTlrSE91OUNBNGNOcUY2bkFHKzd5ekNySERCSzNnSDZON3Zwb0VpRm5nVTc5?=
 =?utf-8?B?Q25nYWg3WllCZXVaTGtheG1zMDNweU5PbXpObm5mR3RTQldneFRkaDBTV0JR?=
 =?utf-8?B?U0txMGIyRWxHVVdUQ0VnK0kzR1lLZ3luZzg2NE1zVEc5VS9YVmJjb0g5Tk5j?=
 =?utf-8?B?b2NkbGY2S2JNZFcremVWc0ROVFVwcVpKa3RONFZDWnB6OU5sdTB1YnlvaE5P?=
 =?utf-8?B?OVVWK1gybTJ5bmZOLzJTS3g0MmIydHhraTArM1o5K3Y0OXdUNFk0ejRFY1R0?=
 =?utf-8?B?b2M2N2UwRlR5MlBGWnYya0xKMW9Xa1N4eWNLREFhT1g1ZWF6OFhXdjJ5MEhS?=
 =?utf-8?Q?JQzQCkjcFIMu94pDVkaWUJXYt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829b192b-c9d9-48bd-d8c8-08da9a3a255f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:26:15.5602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaY8SqyHH2p7XcYKyatHwaYu+X/jkAFg9Cmmtu71UhK2+IPw0tDFHLD5G62dVDAnFhuCimHKvXewWYnNyURd8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190083
X-Proofpoint-ORIG-GUID: zIDmu0WMvdMuF50e_dBnKTfgFLP-52xd
X-Proofpoint-GUID: zIDmu0WMvdMuF50e_dBnKTfgFLP-52xd
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/15/22 01:18, Josef Bacik wrote:
> These helpers use functions not defined in fs.h, move them to fs.c to
> keep the header clean.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



