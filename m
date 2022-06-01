Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68A6539AC9
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 03:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbiFABem (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 21:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiFABej (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 21:34:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D165B3F9
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 18:34:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VNxDK6018453;
        Wed, 1 Jun 2022 01:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Wrg0doaPEmFMws1KaG5PXLC2Z7RVi9Xya5A64dbPFnk=;
 b=fSdaNteSHl5N9Ux2tERsyMX3Z8OhNi3x11q/iOO2+pM8/dqst98bRpPk1YdI8XL8uzGl
 WeiTsKEhZzVV+ygF5l3n+QvLBDujOhgYPIJydBGopkLzwbX4z4FAeH+SYdbMKgGR9/Dr
 ByjhD2bC+9wSfqCXWNCinchXR0cuVYyULqaMygJhoRW7W+9Jt8I68rjC8TUNosG2ISwu
 X2KlfIXRh8ou2x7p182nZ4FVax/qJp3U2l5fpMCcN0YDgOChx4130TiAA+pMcAk10Bh0
 5UfyAtY01clMu5gy8QoAOHAsntkECeKxxP+ZhQhR5hPFyGhyCEbjH942aYPPmNzruVCn rQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc7kpckn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 01:34:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25119uWC039053;
        Wed, 1 Jun 2022 01:34:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8ht8ep8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 01:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGFWhwnruWq7p3JMlQb42gpMilbV3KowjbSgucIp919xokq4+Ec8yzF+3DNBy9lmyCB2zjs7GMw0jZ+gw7MG7C9VtsblSd0ufI/e7YR9IP4Ril6D7SyxFIu5Y8Tril36AFblUDlkipeJBFMEbcBUrHxg5l64njZ1ts+vusLUha8WZg1l6TAuzSn1RV9/kQcKrx2JO33zWmPC+iRy60aJSrpjJWmfTXEC/LGWlGVBSYN0Ci990+6pHqvd2WDvQzyqwNO2Y9J0PZgRvkLSGnC9wT6/MZu2TDWw8fbf8qLEe2ETzu+liY8DcUpnbNTg4bpzcJDg7mDmo9bMKBxCK8D75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wrg0doaPEmFMws1KaG5PXLC2Z7RVi9Xya5A64dbPFnk=;
 b=a38wZL0/ugW7eIVmRFzxATqCmEIbEMEKqgz1pVX/+HW1hJpUZP7ZgQiRZcAz60Pjnn3DQ2nfgRl4g+2LabZdoAuTvVMM/5+EN98/+firukVi1Xc0oeagsqBFATQvVicI5ZsM00dUw/ct8bf9evG+7RXTrw4GaXO0W6KNqASpmwjgG7obqmfXMl2IBo03kO7pu2hc9E3MZvdtP6Pu+MksvxaDWVnrrHtV7oG/9ZonqRxQCkhkLCIxMxFMbYTuKOi9xGaC8f44sOrg8O72EZleSwrE0GXqb+17RfXR6Nf3QADzvk61Nsu8Yg5suuq7PGJYlJzChbkBxXkqSgV8hOA39A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wrg0doaPEmFMws1KaG5PXLC2Z7RVi9Xya5A64dbPFnk=;
 b=RfMArytqHsWN5MxLcYpxvpt5GHP8Ba2R2S4q8Q5tuAiZD7Qe+juTFyIRAKGaoKFg+w4VfHg1kFiqCIkPCYW8gEmf0qMk+ibcQWOTU2KJQVDq6O5UQ0W76Od8d+A4a4leGVtnklyX1nCEEQBEbBX1hTXcebLHKJlyi30V9gRfQjM=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB5858.namprd10.prod.outlook.com (2603:10b6:a03:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 01:34:30 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a150:6600:64f4:b606]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a150:6600:64f4:b606%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 01:34:30 +0000
Message-ID: <be347268-b093-498b-77ff-6600b03abf74@oracle.com>
Date:   Wed, 1 Jun 2022 07:04:20 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 04/12] btrfs: add assertions when deleting batches of
 delayed items
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1654009356.git.fdmanana@suse.com>
 <cfcaa0d48b19913fee8598e0899f1b6f132b0cce.1654009356.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cfcaa0d48b19913fee8598e0899f1b6f132b0cce.1654009356.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7208ad7a-b57c-4bc3-945c-08da436edf65
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5858:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5858A29624A138EB68151D4AE5DF9@SJ0PR10MB5858.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sojw5dPMoZ5q1emQq33Vh7KLY+CkVn1/Ct9EY7/w4eZInnk5sqQEb+iIEL3pTHPnOVhfPGibKAGdzwIvjG2pTOJ/LfG07g5qDD5AnzSHuNlHYqraO5Z3AeoCX9ePi5yjSTgkkfTGnnj6VP/VpO++oZfIataCgktdheI34B1I7/ihXsswA2kkrCHwJtvdWmLv7fbo4+11igfqNsiYiDvTV4LY+eunIWlbvVZs7W5j2MVpusKRwIiztEWwu9Jx/XJSx9k3Rd9l0D6AdSyefU+TPNX1DmcmaurZGxw/Ql2KUsv6giYpZPsBQik9q2FSGcdGwPPxviV9YST4AbQuA/ooMJXJz5GD4XvSXm0LUp7CxOZGZ3oH9TYPP9/kA9LQNwOd9Aa4GjB49RWE2ULokJwBfnDmh8RubFtWpe+2xkvidsJUEYytK2JDUSYAhSjzaCZI9wmSzLYjEXPE/1Wni+QHjlTLotWiaCtQVgI1BiZDHpu/+yDc2HHLJf2JeDyQc9ME619S2pLuq3Fyy0AmQl4l0kDC77Yybuz9Dy8nS06NfhWGXgHS5jSw+elL6kd4Qkac+unZvLkLGzWLzY3k1rmQKrRPmPJkNZzIWrEWR2gHtmb216ziVloVd3GCkhlnag/VCxnw4zBWJw70uVj0IY+e8IQG6xrUm8mK+VF2ouv2acWGz5TvqjXO52Nr0RUTHqlR4/624Rgv5L0J7t2gX/OVs5se2aTsvnzYs+ILvjBiN1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6666004)(6486002)(5660300002)(508600001)(38100700002)(44832011)(8936002)(2616005)(31696002)(86362001)(83380400001)(6506007)(53546011)(186003)(6512007)(36756003)(316002)(66946007)(8676002)(31686004)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1lJaHZzNzBBeVpNVWplRkp5c3lpb0RNOGVKSHFkVmdORFpEMEVmL2JjNUUx?=
 =?utf-8?B?QWdqQXFPeTJJdmM2aGhnYmhGQlczcUtsd1E1UFZtUTlrdmZUTDFDS0ZGcXdo?=
 =?utf-8?B?NURlK2dGR2hDRHJlalRqM1I3NlFrRU5YYm40N2lNWVFKQTZ0VjBEY084VDlN?=
 =?utf-8?B?V0thSG9BNmV5dGdUMXA4K3JyQkU0dzRqY0cxcmVVQlNwR2tjLzFnSWN4Zm5B?=
 =?utf-8?B?WmlNL2gvVkNQWEIxUlBrV0ExVjFxQW9qeDZBSWwyTDNXWUJvQlBsQTE0cHAz?=
 =?utf-8?B?amhlSVBmMk5rdmRxNVR2RXJCRklVKzRzTzJ5bzZTNzNSb3B3VHc0UkVUOXNp?=
 =?utf-8?B?MlpFdStRSXBqNklYUUl4V3hQZ0tMNUZYOVZocHEveFRwaXZnWndidGlKS3Iz?=
 =?utf-8?B?cW8vRmtlV0s4S05mMGh4cml3cXoyOEd5dTdnSEFLc1dyOTRDSnZqTzZoWXRq?=
 =?utf-8?B?dHNFaFh0ZmJ0RDJYMEVnd2RGL21KK1VFMlQ5M3RjektIUkVHdFRyYmZzMDZk?=
 =?utf-8?B?V3FHd0xRN04yRS9zQVZUWmNRVVZHY2YzY1RtUXgzOUNzTmhxZmFlRUhORVdB?=
 =?utf-8?B?a2RBS25Jdm5Sc3dMNndMUmx6QTNrNmJpNUVvaVVZdmlqN0h5SHErajFVZnRm?=
 =?utf-8?B?RE1LVHhLZENqdVdXdEIzZ015bGJBTllzM2pDWXJuKzhoTXlvOHF0N2tyY3pF?=
 =?utf-8?B?UnlhY3ZIVzhOODlENUtuNkc1M0hZQ1hFakU2cUtUQjFRcnJkcVVVYlo1THRL?=
 =?utf-8?B?emEvNS9ZVldBOERvRVBxTlRwVjQ3ZjVWdEgxejBmK2Y4SnNnR3graGYydTBK?=
 =?utf-8?B?ZFIxQ0NkY25wT08wQm5hb3dtdWZqazVBU1BNVGxQZHRKVmN3TnJnSHV3YVBm?=
 =?utf-8?B?aXdkM0U5My80dDhIVVVuRC9lWGZFM0JUa0s5bDR0dTkzbXM1ZjRsYzRDanla?=
 =?utf-8?B?azRKeHJPejRDS0tnS0FLQVlTd1IybWR4TFQxYmpmNzRKN3ExcytXRnZ6QXhB?=
 =?utf-8?B?NUEyMVJReFVTOVQvMnpFb3ZzNk1GYnZnc2M4cjd6emo2Rm8wOGNxR001aU5J?=
 =?utf-8?B?WWxZWDZudlRSK0RPNjNZWWNJdXJTMVBkWXFnS0s4bzdORnBZOFhMYjUweWVK?=
 =?utf-8?B?SHpFS05ZRjRZTk5yUXdvUEZpU3dYY044WWEvMzkvbHVZMVNwSlNMT0x5YzRW?=
 =?utf-8?B?enNaUUFtUDNZZ25qZ1RrZjcxclJEZWtvZFZBc2JVbjBFdE5veWxWVklFRWdR?=
 =?utf-8?B?RGRmcEdzY0FaWmhaTlRyanhTaXJIYnNwRlZEZEx5d05BejArN1BNRUovS3Y2?=
 =?utf-8?B?bXBLMzlmV3ZqSXQ5Zm4rWHZEUG0rNy9GMXMyV3piZ25Wc3Y0Z1gzRWNvVkN5?=
 =?utf-8?B?NmFJY3Y0NnA0N1lVRkgzejhwYUI5UWQ1R0N5R3c2QVhLQTNXemlTN3Nvc3lh?=
 =?utf-8?B?SExyMURTaWw1ZmRxSzY2SmtNWmdDZVFUYVh5cGN1cm4vNGc0TUo4T0xRT2cv?=
 =?utf-8?B?T2c5UjFOalB5S0xUdDliakNoRFc1d29iREVrUnZzMURldjdDb2Z2ZEQ5blZ3?=
 =?utf-8?B?V2x2Zit5NzhuVjJNc0ROSDBQV1c2UUNaS25QNDBYcnpQVlg0T2JtQ1dlMjVm?=
 =?utf-8?B?NzFRbGNzaG5DeURDb2xkdUtBcU4vemNnclU0YWRkYmhCYlVLcFlmU25OOXpa?=
 =?utf-8?B?VHNGSGJpMUord0VLTVJZa3owU3h6cXpjTGZJVVM5VmtWdy9NcDBJaGg4OTJS?=
 =?utf-8?B?UzBPTnIwMmtwVy81MjMrazN0STlucnZIc0g3QnZEaitCZitQazBNUk1DN3I0?=
 =?utf-8?B?RDJDakQ3ZWd0bXpXLzdZTnJaMjViV2RRaFRDbFB3MGVZWUE1TlczT0huN0Z6?=
 =?utf-8?B?KzZDS2hkSWZ6blI5RE0rTU1oMFRURWxwZEg3U3AzaUhrVzBLNVNPTUJ4RzV1?=
 =?utf-8?B?RU5RbzVCeVo2NmQ4cjNzRWJNMVZaUGJ6VXdnRDhOUDlYeU5tQmw1bXNKeFJD?=
 =?utf-8?B?NUg4MEkvSGtPcXFVaFBYVU43dlZGSzBidFcyVTRJNHBiOGswNjNoOWhRSTgy?=
 =?utf-8?B?Vnp0MzBuZjhMWERiOW4xdkxuN3p0M2tKNDR0dzRxbjBzdzZQN1lDNWhjeHJs?=
 =?utf-8?B?OTRtdW84aTJWcVZZVlFWMUpNcFVjWUdQNFRJdXhMdU9LM21pQURUR2R3NVF1?=
 =?utf-8?B?NHBacDdvcDZhV3Fmazk5SWpZbzY3WWpOd1Fycm5FMjJuSG1TeHA1dGVIRnMr?=
 =?utf-8?B?UndPK3BtK3VYd3VZcHVZemlPdVdUT1NNS0s5OFFmZ0U1dFN3NFF6RHNzdVV0?=
 =?utf-8?B?VCtvUng5SlhzdFdqMis1VHdGcW1Jd0crTmZqSitQTzJ3YUxCSEtScVFrbVhv?=
 =?utf-8?Q?nzFSmzlRlotmfy3cH4OHZTStODh9XNlgpEC1lsUhzkKuq?=
X-MS-Exchange-AntiSpam-MessageData-1: hTGycYs95IkM4R6Lf2TDbNX2pKZSzxH6iak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7208ad7a-b57c-4bc3-945c-08da436edf65
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 01:34:30.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrQKFjR98YNOp9SRlMqfKOC9aimI/wePdREzRs/x8+fFXKbn1Hrdrm3P5t1dSciEYjMud7XELsVZv6ACOLh/iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5858
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010004
X-Proofpoint-GUID: m83es4HHik5lhlcLCVXJuScKkWuXS8Uc
X-Proofpoint-ORIG-GUID: m83es4HHik5lhlcLCVXJuScKkWuXS8Uc
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/31/22 20:36, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are a few impossible cases that btrfs_batch_delete_items() tries to
> deal with:
> 
> 1) Getting a path pointing to a NULL leaf;
> 2) The leaf slot is pointing beyond the last item in the leaf;
> 3) We can't find a single item to delete.
> 
> The first case is impossible because the given path was returned by a
> successful call to btrfs_search_slot(). Replace the BUG_ON() with an
> ASSERT for this.
> 
> The second case is impossible because we are always called when a delayed
> item matches an item in the given leaf. So add an ASSERT() for that and
> if that condition is not satisfied, trigger a warning and return an error.
> 
> The third case is impossible exactly because of the same reason as the
> second case. The given delayed item matches one item in the leaf, so we
> know that our batch always has at least one item. Add an ASSERT to check
> that, trigger a warning if that expectation fails and return an error.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

LGTM

Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/delayed-inode.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 66779ab3ed4a..bb9955e74a51 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -790,20 +790,23 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
>   				    struct btrfs_delayed_item *item)
>   {
>   	struct btrfs_delayed_item *curr, *next;
> -	struct extent_buffer *leaf;
> +	struct extent_buffer *leaf = path->nodes[0];
>   	struct btrfs_key key;
>   	struct list_head head;
>   	int nitems, i, last_item;
>   	int ret = 0;
>   
> -	BUG_ON(!path->nodes[0]);
> -
> -	leaf = path->nodes[0];
> +	ASSERT(leaf != NULL);
>   
>   	i = path->slots[0];
>   	last_item = btrfs_header_nritems(leaf) - 1;
> -	if (i > last_item)
> -		return -ENOENT;	/* FIXME: Is errno suitable? */
> +	/*
> +	 * Our caller always gives us a path pointing to an existing item, so
> +	 * this can not happen.
> +	 */
> +	ASSERT(i <= last_item);
> +	if (WARN_ON(i > last_item))
> +		return -ENOENT;
>   
>   	next = item;
>   	INIT_LIST_HEAD(&head);
> @@ -830,8 +833,13 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
>   		btrfs_item_key_to_cpu(leaf, &key, i);
>   	}
>   
> -	if (!nitems)
> -		return 0;
> +	/*
> +	 * Our caller always gives us a path pointing to an existing item, so
> +	 * this can not happen.
> +	 */
> +	ASSERT(nitems >= 1);
> +	if (nitems < 1)
> +		return -ENOENT;
>   
>   	ret = btrfs_del_items(trans, root, path, path->slots[0], nitems);
>   	if (ret)

