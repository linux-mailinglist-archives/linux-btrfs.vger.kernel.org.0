Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25265BCBD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiISMa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiISMaY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:30:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB22217050
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:30:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBx4cK020073;
        Mon, 19 Sep 2022 12:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=axw9jDeqn1jepEyN8Ffa8OIDqrZLESHjxONIpTKijd8=;
 b=VVgcQEnUu2xI8wR6K1C+oLAT+2yF17Q4dZ6Qtv8FN0/bn1G14crx3kngEdeD8Y5GZhev
 SviFo+v6+Y+aEFEfQ9pCy9FhqTLGitsJMI/BmFQeqizU2QAVNX9r+kRb0a1va8tJjSL6
 lQTgTcbm7dgwsb2RCbGIYF3iFs5mf7loB3Uuy/HA/UPsqMa3MAYGyLToZgU4Y+6mztGV
 Is+HAR1v440WCa46Tv8xmYFqeQioD2iPy3+Wpm+7Rc6rRjU2Pjs9iPJgIUwB87duckAb
 FiuFaHwKuk/FC+SiJ/JZq0ip9djOlVtCHn04yxNIHyCMBACOxR7W2omzrzGpDsZFlRmC cQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rbnrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:30:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBarZK019025;
        Mon, 19 Sep 2022 12:30:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d0ud2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:30:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8IKG4S1klZptTyNNrCmDfauvjBiQw8Gw9/x5tuFhs6SJGvG/dZ5Sh8C0/l526H4H/mm1ZuEqnfQv+RqMHbw/APyiaj9HOHpaoFH3eTSKO0LY+O5448d1QNh+L0ES3VH5CrJH3dSlDJBmLCr83bKJE/vheuWhTK8jws/sGfTa2Yap2LwW8HBV5Bw9e0ObVi420nC8SvKFScKlOO4Sz2XszXkD67XoavY3oOrKSIXxDPoIbqzWOrdL8Tp3wl0Nm/7J30SJsmpycTK5fSuk/iL3M4t4zuDXfNlvRsS1Ontw+2yA3NsAEuSi4B46R/FrIoV9CkBcPO1QqBoFlMIer2jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axw9jDeqn1jepEyN8Ffa8OIDqrZLESHjxONIpTKijd8=;
 b=PAXDSbKQA/x4rkBRBWgd+wur8GT1qcGyA2x6+meWLhjhSYPzQXgCd1NVdcyRazIJs6BS+3gLV+ad07o0PxTw4LqGUJKloXNGsEm9H6dzRPDNDfk7u6h3T98y5jj+B2xKTkoOw+m4gW5JXuCkss17CArL9FxVsSmJgrHK/ZOhzXenuQgH5eUPHkxIt9anJ81gqYiU6b1manqjqrimt45sqAcyMzOOJU+oBlaXNR6rU+tuPoOku/zFUd7C7AXISvshOOppE6nQX7fwOlU2eZbJ9Fbqppq/5GzGQ8G8HoLdXED9iUcVFGOohUDnDL/zLEJMbXczgeFkYdThXPuY8jpIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axw9jDeqn1jepEyN8Ffa8OIDqrZLESHjxONIpTKijd8=;
 b=mCXfMb2UIqsMuO3kD0BlDTbnxqWLa6YUZU9bcgVo2sCAV7jyPipZ04PmXU/epYXmj1Kzn40EAgnWJSpGASRy/wCHip9MJXErJ4RCKITWWmTqvt/q5mY+ViN5T3LbBQA1wD+NsWokvf8Ajz+x65WZ77snpGIm1F5Y17RUi/ehRFE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4389.namprd10.prod.outlook.com (2603:10b6:610:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 12:30:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:30:18 +0000
Message-ID: <a374a77e-a3cd-4eab-808f-ffbe0579a283@oracle.com>
Date:   Mon, 19 Sep 2022 20:30:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 11/16] btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <14fb62f9388bc8f8a129a74f82abe5e7978d41fe.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <14fb62f9388bc8f8a129a74f82abe5e7978d41fe.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b0db6a-80c3-4de1-339f-08da9a3ab5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1j72Or0vsSvA2lPgIV9IzGOBxqdiOCxYOW4dF0as+16bnjJBcrSBd9r3u5Ig372BcXaxxGhrpi1gzY4qyMrM3ZqQLzFewxCEhkMl8TMpntnkbLVkRl1RclR47/MRDZe7RUqdZ0LxfnDVWsI6/BwCuOSkK2xJNH5UapefaMahGhMPPAUR9ynGIYEsDkq7hkmrUOT2eD/pV4Skg28XFMgo+SKi7gf1F32ETrpOfJHhM9OECETaCFDOY0QAJANrykMPx9UEMiz95AuhDGCHK++pnemxuQyTa5t+pA9Bwm5KGfTdfpKfy0Redw3u5lfdHYWb8n8yiT0tlwjVN3B42iRehVNQr5nA9Pa9S8Xh/irlvoD2o2xai4Xn+0n4xTq6xjDTyVQ6BVGXGRrCLj9y0MVIZQju22xZOx6T/vgPUgXucxRMBq1Hk8Sj94CKQCr+ZW208VL0mXsuj0kgW/JBd8bFr6tqzn7kb3M3fgTRcI76ZKCTtKzws2Jik+VjM2u+OVzFT8r/tRVOSGh0T33nrnNPzXIhZ7PHy9ozQoKCESHajVTcFndlCNPTaxFCHQHQ5WjJPA+kUcXYTUW4aTmsHpkQyZ7YTHsW0M+Iu/GcqvQNh8Zx9V8X0EW1k12eyfZ6g/7+opIRKQie44nF+9E9dKrlJoGNeoEOGFPFGxOb13/WW+hnTeleTs+8CRk66qoQ3h/PNQLMUh6a4nrkZ4xpqnh4N6FFo73XNWr4FOJotQhnNw0sqdEkcC4WzkajkJpZ8zPdyJLlPmhT2Z1wkCGT/5tQc5fhOXlyK4oymZkw/H8Mhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(26005)(6512007)(41300700001)(6506007)(53546011)(36756003)(6666004)(186003)(8936002)(8676002)(83380400001)(31696002)(316002)(86362001)(38100700002)(2616005)(66476007)(66556008)(66946007)(6486002)(478600001)(44832011)(31686004)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnczT09qdEhNT3VhazY1YW9kUldqUk5XZ2dDdVc1M1dEU1YweVJGS2V6RXdI?=
 =?utf-8?B?ajFhenJHTXM5cysyT0RtWEFncVByOEtabmZYc0NjQTMreHgvbkhkY0ZSaS9F?=
 =?utf-8?B?QmNkUFhEUXB0TWdBVTYzUGl4aTJnbWt1dHd4ZGE2Zi9Dc2ZnalpvTmNXcGN6?=
 =?utf-8?B?U0p1TW9UM0JsWUE3Tm83N1FiRmxyTmVCWG8yb3p3WEdaTjcyZ0tSaGFaMTJB?=
 =?utf-8?B?cHlpc1JhZjR4bDY2OWJmZDBTNEIwRWtsZHRqbW50WEpTbFhsWFBCUkdqMFAy?=
 =?utf-8?B?YnREdzlrYjl3RGl2M2ZhMXAxakZyZmFWUlBwYk8vV3V3THlYdEQ0Zm5iK251?=
 =?utf-8?B?WXRFYjBKV3hjOERyQnJ0MnA1VjVUUFFvRW93K0ZqZ1JrVWpJZzJmbXB1b0Q0?=
 =?utf-8?B?WXFpa3FrMkxmUW0vSXNGdU9YOXVPQjlqM01mdHFRdm5QR3ZGbnBqVldaWGJl?=
 =?utf-8?B?MjkrVU1LTzFiYm5sYVNCMjBEM0VOTldMUXZEWmt5RGJzWHNrUEgvSjh5cVkw?=
 =?utf-8?B?RVVBQW5CNEx4UTdYS05nNWpOWGIxVURTYng2YmhTaTJKT0RBeVR4SWVWb3VK?=
 =?utf-8?B?dW82bUUzSFl4UktrSGY2T25hSDZDdlRZSktrWnI1b1Fwd1JyRjliWElXQmRD?=
 =?utf-8?B?RUpyQTJlekV6dTJyWEpYZFBhU0hhVFVTRVl4d1JjUFp4ak9vSDhFREduUUFv?=
 =?utf-8?B?cnlXZ1lxMEJPV2U0L3Jma1pPOUVORWhuL3BoS21BR0ZiL0FDNjhYbThhK0lw?=
 =?utf-8?B?UU1HVVR5V2V4aTkrY21hSDhTbzU1Q0R5RjRnUVlkM29STTNDQ0N4VHNsbDFm?=
 =?utf-8?B?VVdRUjhwMjJ6OHl6cDVOT2d6RGFWaGVuKzF0dERQYm5rWktXczdmTnBXNmxK?=
 =?utf-8?B?SVRXOWZLZy9BZDN0cWphcENzakRlbFBOWkpJcy9tNnVSajVNSUt1Sjhrd05M?=
 =?utf-8?B?aVlyRzYvSVFMSi9nLzJQSGJqY0NhWnZ5L2xpdWNkMlJLdjJTMW8zV0wwNTQv?=
 =?utf-8?B?QnFVSGc0dDNXVDNkdHc1MkRNSkxaMjlaWW5MaE1TbjcxU1ZxUlNQTXlySGdP?=
 =?utf-8?B?eER4ZUdwVnVJSVdkamJXL21ITjB1aTBSVTlJckNnT3d3QTVVRjB1QTNYWFZ3?=
 =?utf-8?B?Y2pVYnNXZUlRZWZvTmZoYzc1L2xCNUV6RG1qYWIzUFdBM3JLVjUvZjVzMmR2?=
 =?utf-8?B?VVhmVk5EM3FlaWc4RVZBWlVoVU85M1dodm5XQWllRnZIVm5FQ21JZmc1RGJC?=
 =?utf-8?B?eVk1Q2NtOFY4eUwzY29OWFJPdTdnT1NsaWFWSHdUanlGQmhSSXhvZW92RmFO?=
 =?utf-8?B?UUdvcjhLZkxxMjBqL1k3T2pJcVY3Y1d6NFVvNGczT1pNUlh5UnhQRUlOTjNa?=
 =?utf-8?B?UXA5Qzg3cjhhdWxHV3RsV2cxQlF5OStBUGNjbW8zWFBNWDNqT0ZxMVJ1Sk9i?=
 =?utf-8?B?eFJiZndKME9zbWhKcnlEQWtyK1I4L0RNNFNvYTFlaEtBWkwwUGtzV1R1MW95?=
 =?utf-8?B?V2JWOUJSQVVZYUNaM3U2OXdFSFl3UnhFcURIc1FIRmFMcVB1QWN6a0QxMXZU?=
 =?utf-8?B?UHIxL0dXcWdHU01QWUZyN0RlWTdZV1FLQTlJUWN1cUtuZERndnJKbzlFQ3p0?=
 =?utf-8?B?KzlIcWZKRlZ5d21pNEJNNlBHMmxIY0ZzZ0FjOFJ1TkVLbFllQ3FaMksxYmdH?=
 =?utf-8?B?cHV5aEZLUkFzTUd5OGtwWUYxd29PWVcvRUdudG5kRDg5VE1ySTlqV295QU5q?=
 =?utf-8?B?RUlFS3RPY2UreGpRWEhLa3NHVzRhclpZWHplTFN5cnppRzJVV1lwU0ZGSW9K?=
 =?utf-8?B?ZW91Qi9lOXlCcitNWGtJT2wyQzM0WmZqY2k3ak1xSGpuemRZTGtCTlhQU3FN?=
 =?utf-8?B?ajNNdzd1NmcvME82Q0pwTVdOOEc5SU5GSTJSaHhxeGxraE1oOXJ4UEZMWG9X?=
 =?utf-8?B?L1I2SzdicmFHRVp0SUlyWWw4QjVzcGdoM3dzZDFrYmh5L2JQOGMyZHI1Ynph?=
 =?utf-8?B?bk5mVlphdDZvODBJbzhmTWdOVTF1OTh2NW9CZWJCUHgzZWF4V0FwVDZoTlFz?=
 =?utf-8?B?WnZ4V0k3WGorM1VoSUxQUlBMWUJuY3BRTnpuTHhVRTFzUGFJZG1xSjVKTHFE?=
 =?utf-8?Q?UmPTm7Upd+24IaGaZ1VMfRFq6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b0db6a-80c3-4de1-339f-08da9a3ab5f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:30:18.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzhJKL6NJSmjDLDqbRUSQsfre+vFWhXiRp9MGyLJHl6HDLGNhHBBC98F/Fq+K56tIqmCh9c2mgizgk5FiL/Ipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190084
X-Proofpoint-GUID: -OhWkys-4qNcqzPFnTax6lunC1ujhE3k
X-Proofpoint-ORIG-GUID: -OhWkys-4qNcqzPFnTax6lunC1ujhE3k
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
> Currently we are only using fs_info->pending_changes to indicate that we
> need a transaction commit.  The original users for this were removed
> years ago, so this is the only remaining reason to have this field.  Add
> a flag so we can remove this code.
> 

The following #defines are unused. Why not remove them?

#define btrfs_test_pending(info, opt)  \
        test_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
#define btrfs_set_pending(info, opt)   \
        set_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
#define btrfs_clear_pending(info, opt) \
        clear_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)



Thanks, Anand





> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/fs.h          | 3 +++
>   fs/btrfs/super.c       | 3 ++-
>   fs/btrfs/sysfs.c       | 4 ++--
>   fs/btrfs/transaction.c | 2 ++
>   4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index c7eb21768b66..6181657bdc90 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -90,6 +90,9 @@ enum {
>   	/* Indicate we have to finish a zone to do next allocation. */
>   	BTRFS_FS_NEED_ZONE_FINISH,
>   
> +	/* Indicate that we want to commit the transaction. */
> +	BTRFS_FS_NEED_TRANS_COMMIT,
> +
>   #if BITS_PER_LONG == 32
>   	/* Indicate if we have error/warn message printed on 32bit systems */
>   	BTRFS_FS_32BIT_ERROR,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2865676b8327..63a639056882 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1547,7 +1547,8 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
>   			 * Exit unless we have some pending changes
>   			 * that need to go through commit
>   			 */
> -			if (fs_info->pending_changes == 0)
> +			if (!test_bit(BTRFS_FS_NEED_TRANS_COMMIT,
> +				      &fs_info->flags))
>   				return 0;
>   			/*
>   			 * A non-blocking test if the fs is frozen. We must not
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 4acff123fe66..6a7ab762a543 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -250,7 +250,7 @@ static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
>   	/*
>   	 * We don't want to do full transaction commit from inside sysfs
>   	 */
> -	btrfs_set_pending(fs_info, COMMIT);
> +	set_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
>   	wake_up_process(fs_info->transaction_kthread);
>   
>   	return count;
> @@ -961,7 +961,7 @@ static ssize_t btrfs_label_store(struct kobject *kobj,
>   	/*
>   	 * We don't want to do full transaction commit from inside sysfs
>   	 */
> -	btrfs_set_pending(fs_info, COMMIT);
> +	set_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
>   	wake_up_process(fs_info->transaction_kthread);
>   
>   	return len;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index bae77fb05e2b..7b6b68ab089a 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2104,6 +2104,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	ASSERT(refcount_read(&trans->use_count) == 1);
>   	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
>   
> +	clear_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
> +
>   	/* Stop the commit early if ->aborted is set */
>   	if (TRANS_ABORTED(cur_trans)) {
>   		ret = cur_trans->aborted;

