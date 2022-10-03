Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D15F3223
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Oct 2022 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJCOsT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Oct 2022 10:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJCOsR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Oct 2022 10:48:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134F2C64B
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Oct 2022 07:48:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293EYqR5024509;
        Mon, 3 Oct 2022 14:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=g6Y0O9MW28OsmpGWSEQSvxt2LBbh3do2RX5TSS9DlGg=;
 b=uip9chSXFG6YXa7J45dfyVzrpdBkLZEVbW5eo38oAH1SHVZ3HJc9T8sf3zLbmCThE6hu
 yTaCueUNLMOPBUaw8smsOZlBbLAZxOWZCeYKtXUzEoK5exxBls2JkOpX4uXVRn1L06kj
 zKYzr/bBXdgF+Idd3Wjr+Vw9iFjDM/yy8sz1dGMdb/cauOSaRUwqywzvlxBpmgTXAvtm
 ZNGQ2FZbkJnFN+PvcfEJqOfRoGup/YcGdU3qBWKA5LeDJ7dh2PS4CryyI1Dx6vi8eYA2
 kkDmQAal8LxQPvZ3lGDrsK2xJMwUxx5cZLj2K5XTYf0jwPjsKXRAuLwkUlx6c11etChi iA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxe3tkt5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 14:48:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 293DUTlv014777;
        Mon, 3 Oct 2022 14:48:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc03tjpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 14:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ1f7QXHJ4csxkRC+wTOCl8qa3LQREgXN58JqylOdY81ZfK5OdqYxGcoF3c06y2KG3jAUNAZGCyQyi8SfauYFQxxjk8j4yKUff+vEs6Tff+47Jm7OlvYF6LszldpsAOZ5nhpzl6PvN2VrSK9MTCa/C9K5qOJWYxDk6jcJ7W+uNwrmPq69Dqxq1LUBRBtzxj5/Qr8p0c4vE5QyCF/zO34xE3lvr1AYETB/siZUHH2Rl1YBsdzfU6BPX1OTSfr30SQLvHI0MDzn99UsAfOeT3R1KcBrjnkiCo9deZ6G+x2+jiwyAAVqmTon/4LyhLx90RunCjN/v/a+qezrmrNV3FPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6Y0O9MW28OsmpGWSEQSvxt2LBbh3do2RX5TSS9DlGg=;
 b=jguPODkF/eOoTDr0GIvpYUDjntBADoAZGZscCShRwHrR3JYsN8uFGQhWxc1N6WUKgF1WEalHipzdEGAKvHoxgbXsLr7PecqG7vzy1BJbjyl3Mf1ITZW2ORq5+TESIGBjjF4x1GjLmmjxkWvuIj7BVZVcxXaWlH6SimI4jxYNcv+GkKlEaTcJqLrkrLwmDxsBr7Pn8geDly/lG25dRCXIzk+ccuNE5vUYccn6A04QaAQ6Q43CxgTI1wirwNQgjKsfM0ADOjaLtBrECKaHgBV6lJf5SapWQxv8PnCq4XHO4W2kcngGhzujP18ddQWs5KTL7BTH/1ALKepwBlRDtB59Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6Y0O9MW28OsmpGWSEQSvxt2LBbh3do2RX5TSS9DlGg=;
 b=XGSiTUWEO/ESwC8f17g234cis7pc6k5zIYxXmIiwtWYsvthpFAhqKb2oJxORTK3j1VeeLjBPZM7V3Am3KAG3H/AJMn/MAKnExx3IP5xTMSzV8DgvE6tGAi7wQ88Dd6w199DmoQdwwMqx9SV8vfD4e3ir51dmcuBEngrWkYIpeSI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 14:48:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7%5]) with mapi id 15.20.5676.024; Mon, 3 Oct 2022
 14:48:07 +0000
Message-ID: <6a15fb3d-a769-1ffd-72b5-a3492b91919f@oracle.com>
Date:   Mon, 3 Oct 2022 22:48:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 3/5] btrfs-progs: separate block group tree from extent
 tree v2
To:     Qu Wenruo <wqu@suse.com>
References: <cover.1660024949.git.wqu@suse.com>
 <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1660024949.git.wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1660024949.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: b582bc16-a021-4055-a84c-08daa54e4897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Et+0ZF2Atkb9EdZI8QN5bSw54WxZFmDbL+ZP9LL1CPs47QNN0x4Qta7WmjPtCAsJT/B3q3dFi2vANIgzKTTGzZjuDdTfHt73m98W1wbE/sPFAa62Q0U5i4xXuxUGiMK4+3qZ+Y3991jKP2x2BGxJ38BzWyp8OTdZb0ayWhM8s3gNvQDfYXL+4/wlqSu5H69VfCI7DxnFnVLIR5W4MxGUTzndU1rE15XCs/UX4sy7L1okZH8SZEoqTXw6LVgt1pD3sjH3cdmPJOfoPOhJ1r/m0tVUjla5DfOB7PsouEHda1EgQbvdw1TAuDEEA3Ri3i14DklgXnn94K5TXmnk/cOK6jofOtICx7wLPa4fUeJ7mSatc+lS/9JiiIIJjqbZBa4OpuTXth3h4WIwo5evy9WQ/nQegy2ArNGnTzuP/XflEK4If641DBV7r+XOB9/VP6H7s4wnSSQrbcNuHUGBLVUETx7Ljtr/XM3fmVrdjhDBzZEvgQAMEEs/2YL/ZChLVyyqt6M7Cp/88d9S4j9NWX9Ou/4YzOu7ptwtDWeDvjhxFH1CzL2MbpzqkFSjkQMHa5lQy3iNmHzTLEWprDPdxy5agEvC4oohOOo5QjBt1r07zxCtKGSGkqoEdkVDpSKpBDMuf6NW+8LSs5ubME/LsgQojAr1doAMQCLi7AP9SfPcV2t/qs48CdRJ/CcqBRjlM4Mq+nMgonzCSE/FVB6U29wUyZfZBMr2HogVJxzhsJ2i8hMGmPBFJTQRXA8G5FlogZSw+Yk56308zflEDlYJItwfeAlWmCUQeF0SYkZ8uok/vwHV5zNsPVn4tG3TZ/6aRmR0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(6916009)(26005)(6512007)(6666004)(6506007)(41300700001)(53546011)(31696002)(86362001)(66476007)(66556008)(66946007)(8676002)(4326008)(83380400001)(36756003)(316002)(186003)(2616005)(8936002)(31686004)(30864003)(44832011)(6486002)(966005)(5660300002)(2906002)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDZJd2wzMHhXQkRWd0tKdy90M2RqV3gzd0k2cXVXL3VBZytET0hjZC9aMVBp?=
 =?utf-8?B?T0ZZV2VRTjdxQ1V5T2JTTDNtOVFwd3pTdnNxQ2cweWxWa2ZZS0lIYVhreEtK?=
 =?utf-8?B?K0VXNW5Ic0FlZUk0cVJGdU9JNmNSNllleU9FeFZrb1VGdjFPTVVMWjk5SUNE?=
 =?utf-8?B?czI1SUVCMkxiRjRWV1BEMEVpNUhGdFlLdlZQdGlZdDN3M3U3Q290TUg4TElP?=
 =?utf-8?B?Q3VBZ3UyZmszWTJvUlJxeU1NNXREQWFlMStMZE5VanVIWkFlU1djQjExQ010?=
 =?utf-8?B?S1RIM0FJWFVtQkJKYldSSHJHOTZXcnNwV3lRU3dTNyt6bnlWZ2tkSm9mQ0M3?=
 =?utf-8?B?MFhCbnRwMnErMVRVbWVGYXV0L0JRNEJvRWdKaWJXc2dMdnN1NHVpeEViQ2ZO?=
 =?utf-8?B?azFnbnNEeWhUWCtlK1p5SGRac3laUlYzcnl5RWdiV1c4UU9mdGk4K3NCdGtW?=
 =?utf-8?B?TUExcW4wc3VFWXpUMkdLMW9nVFF6V2FKUHlyVFZ1TUxtR0JoUHNRc25kYk5N?=
 =?utf-8?B?eDdIRENsRHkxVVlrNW1yN2o4L1poWkRnRURoWUZRQmxCNTRuNWpYRUdpTDFl?=
 =?utf-8?B?dlQyUE5RMjErWWZISTdEN0lVWHBMcXE4d0Zpd1ZWM1Zyb0dXaFpKTlVZRGZX?=
 =?utf-8?B?TTF3MWtKVmNhcFBSdXo0akc2WHBCVi9pWlNqUkRuMFEzQ25DVzNGU1VMUEk2?=
 =?utf-8?B?T1VPcnEzMnJEdnpIK0hkNW9JQ3FldkorbDFLZ0ZjUEdSR2Y3VURnMGdCY2xN?=
 =?utf-8?B?UTNJSkZYY2crRUo1TFpKYkpwUFFMSytQbGRvbDJLQVZYcEdKRjNWblVTcDkw?=
 =?utf-8?B?MlNTcjRkVk1EQWowWmZWSEMzSUVIZ1UwNXRWaWdnZ0dRT1lkenBpbU5waDRi?=
 =?utf-8?B?elVYY2VQWjFnZHAzVTNFUjc4YzZjRXY2TURXUVRDbElmSjkrV0ZMdTlLT2lE?=
 =?utf-8?B?NTFqbmNVd2NMSll1QklaSmFML3p3Tm0vS2F2aWdUc08yZUdjRVNsNGVWZkp1?=
 =?utf-8?B?Z1NBWm0vTGZ4Mld1cndmeHpWVEdqKzhjTm4yb2h2T2hRODlJay91NDhMdUJz?=
 =?utf-8?B?REJzeXBSU2ZjRXNZZ1ZLdGwyUGdkWFZ3RDI1bUYzZ25Xci9ycUVzOGw1dDVm?=
 =?utf-8?B?N2hqem1ZaUw0SUhSOFpWV1UyUzI0WXlvc0FLblJ1Rzd2Nlc4ZjMzb3BaMEQ4?=
 =?utf-8?B?T0VkZm9PRW9sc2dDbzdmaU43b0FueGtidVNZajBDOXdyY0dnN3lsWlZ6cHIz?=
 =?utf-8?B?RG1mclhBVGJweklvVDBhcnpybExUZk00MWdCQVk1UmhhWU5tcVRoak9pVnV3?=
 =?utf-8?B?VTVQcXFZSzJOZ0ppVnpMQnU4MGI0REhUYk1XWkJkL0RBSFlrQUNReWUrVmFK?=
 =?utf-8?B?dlpLTTI5MXg5b1VNSTZqV3JMSHVDUmhBVFdESzdXQmZNbzMweTFyMmVBNFBw?=
 =?utf-8?B?WWlvUkxqOTh4OU5pQUdhK1RESFlHYm5qcUxYcHVWc2ZoUFVZTVg4L0xOTzhv?=
 =?utf-8?B?VVFqMGFLcTdITnp4a2krZWt6KzF2WEt4MVFnVmUrNTVLcFZoMXp2WUlpYVF3?=
 =?utf-8?B?bGFNYi9LRkhVanJ1eVU0dE9kQjZsdkg5ZHpXOEl1OTRtZzl2Mk9DclJNK0Qw?=
 =?utf-8?B?WEFyYU4vekhVVzJSVVJCcmxZaTJWNHczR2VWNkFWRWIxdFVaczlFY0d3NERj?=
 =?utf-8?B?Z3NmR0s4ZkpvL1Y0UkRValJxai9sbHRWNVhFMlhBTHB2RjUvNGxVNHZibFEx?=
 =?utf-8?B?Y0NvdTdxcUdncTlzNDNjbE9jeXo5R21PRE4wZTZ6REhaSmFpVFlYMjFudEN3?=
 =?utf-8?B?QTc0VG1sZ3lnRVRqQjQ5bWVQR1RZUXJCRkNOMDZNV2p4WDNWV3k5b0pyb2VS?=
 =?utf-8?B?ZVpObFJaQzQyUVZXcTVWQ3VycTFMVnFwblkxeWVabFk4NHNVVGRRZ3hNNnhU?=
 =?utf-8?B?MjZaV3diSms4KzJiamJHcTAwYkxrcEhUMVVGc1BkNy9vVWlWMm5tbVZaeWNq?=
 =?utf-8?B?blYwbWJKMWp3eU1CaFUxZVBqbWlFb1ZhNkczMFcwQzk0alY1cEp2bThPLzBW?=
 =?utf-8?B?TDNSZkRDanNXNDlRSHlRNTVZdkdXRTVCSGIxSHBkdVo2Vkx3bEU5RlcrbnBT?=
 =?utf-8?Q?TZQ4M6ImnOVwxDwyw5wIOg7t7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b582bc16-a021-4055-a84c-08daa54e4897
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 14:48:07.3245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lFHFO593EhdyxJxoBHbFPZgVicx1oqgptRXwnGpAeQ4b0qP0j0/DDF/RQgeIlVYCUTyFJ2s4G0zvj8eRm60mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210030088
X-Proofpoint-ORIG-GUID: JwA2uAGCfs6MHQ1tY-9HlkxiLX-rFyKi
X-Proofpoint-GUID: JwA2uAGCfs6MHQ1tY-9HlkxiLX-rFyKi
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


This patch is causing regressions; now can't mkfs with extent-tree-v2.


$ mkfs.btrfs -f -O block-group-tree  /dev/nvme0n1
btrfs-progs v5.19.1
See http://btrfs.wiki.kernel.org for more information.

ERROR: superblock magic doesn't match
ERROR: illegal nodesize 16384 (not equal to 4096 for mixed block group)



$ mkfs.btrfs -f -O extent-tree-v2  /dev/nvme0n1
btrfs-progs v5.19.1
See http://btrfs.wiki.kernel.org for more information.

ERROR: superblock magic doesn't match
NOTE: several default settings have changed in version 5.15, please make 
sure
       this does not affect your deployments:
       - DUP for metadata (-m dup)
       - enabled no-holes (-O no-holes)
       - enabled free-space-tree (-R free-space-tree)

Unable to find block group for 0
Unable to find block group for 0
Unable to find block group for 0
ERROR: no space to allocate metadata chunk
ERROR: failed to create default block groups: -28




On 09/08/2022 14:03, Qu Wenruo wrote:
> Block group tree feature is completely a standalone feature, and it has
> been over 5 years before the initial introduction to solve the long
> mount time.
> 
> I don't really want to waste another 5 years waiting for a feature which
> may or may not work, but definitely not properly reviewed for its
> preparation patches.
> 
> So this patch will separate the block group tree feature into a
> standalone compat RO feature.
> 
> There is a catch, in mkfs create_block_group_tree(), current
> tree-checker only accepts block group item with valid chunk_objectid,
> but the existing code from extent-tree-v2 didn't properly initialize it.
> 
> This patch will also fix above mentioned problem so kernel can mount it
> correctly.
> 
> Now mkfs/fsck should be able to handle the fs with block group tree.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   check/main.c               |  8 ++------
>   common/fsfeatures.c        |  8 ++++++++
>   common/fsfeatures.h        |  2 ++
>   kernel-shared/ctree.h      |  9 ++++++++-
>   kernel-shared/disk-io.c    |  4 ++--
>   kernel-shared/disk-io.h    |  2 +-
>   kernel-shared/print-tree.c |  5 ++---
>   mkfs/common.c              | 31 ++++++++++++++++++++++++-------
>   mkfs/main.c                |  3 ++-
>   9 files changed, 51 insertions(+), 21 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 4f7ab8b29309..02abbd5289f9 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -6293,7 +6293,7 @@ static int check_type_with_root(u64 rootid, u8 key_type)
>   			goto err;
>   		break;
>   	case BTRFS_BLOCK_GROUP_ITEM_KEY:
> -		if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2)) {
> +		if (btrfs_fs_compat_ro(gfs_info, BLOCK_GROUP_TREE)) {
>   			if (rootid != BTRFS_BLOCK_GROUP_TREE_OBJECTID)
>   				goto err;
>   		} else if (rootid != BTRFS_EXTENT_TREE_OBJECTID) {
> @@ -9071,10 +9071,6 @@ again:
>   	ret = load_super_root(&normal_trees, gfs_info->chunk_root);
>   	if (ret < 0)
>   		goto out;
> -	ret = load_super_root(&normal_trees, gfs_info->block_group_root);
> -	if (ret < 0)
> -		goto out;
> -
>   	ret = parse_tree_roots(&normal_trees, &dropping_trees);
>   	if (ret < 0)
>   		goto out;
> @@ -9574,7 +9570,7 @@ again:
>   	 * If we are extent tree v2 then we can reint the block group root as
>   	 * well.
>   	 */
> -	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2)) {
> +	if (btrfs_fs_compat_ro(gfs_info, BLOCK_GROUP_TREE)) {
>   		ret = btrfs_fsck_reinit_root(trans, gfs_info->block_group_root);
>   		if (ret) {
>   			fprintf(stderr, "block group initialization failed\n");
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 23a92c21a2cc..90704959b13b 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -172,6 +172,14 @@ static const struct btrfs_feature runtime_features[] = {
>   		VERSION_TO_STRING2(safe, 4,9),
>   		VERSION_TO_STRING2(default, 5,15),
>   		.desc		= "free space tree (space_cache=v2)"
> +	}, {
> +		.name		= "block-group-tree",
> +		.flag		= BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
> +		.sysfs_name = "block_group_tree",
> +		VERSION_TO_STRING2(compat, 6,0),
> +		VERSION_NULL(safe),
> +		VERSION_NULL(default),
> +		.desc		= "block group tree to reduce mount time"
>   	},
>   	/* Keep this one last */
>   	{
> diff --git a/common/fsfeatures.h b/common/fsfeatures.h
> index 9e39c667b900..a8d77fd4da05 100644
> --- a/common/fsfeatures.h
> +++ b/common/fsfeatures.h
> @@ -45,6 +45,8 @@
>   
>   #define BTRFS_RUNTIME_FEATURE_QUOTA		(1ULL << 0)
>   #define BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE	(1ULL << 1)
> +#define BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE	(1ULL << 2)
> +
>   
>   void btrfs_list_all_fs_features(u64 mask_disallowed);
>   void btrfs_list_all_runtime_features(u64 mask_disallowed);
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index c12076202577..d8909b3fdf20 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -479,6 +479,12 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
>    */
>   #define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
>   
> +/*
> + * Save all block group items into a dedicated block group tree, to greatly
> + * reduce mount time for large fs.
> + */
> +#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 5)
> +
>   #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
>   #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
>   #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
> @@ -508,7 +514,8 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
>    */
>   #define BTRFS_FEATURE_COMPAT_RO_SUPP			\
>   	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
> -	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID)
> +	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID| \
> +	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
>   
>   #if EXPERIMENTAL
>   #define BTRFS_FEATURE_INCOMPAT_SUPP			\
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index 80db5976cc3f..6eeb5ecd1d59 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -1203,7 +1203,7 @@ static int load_important_roots(struct btrfs_fs_info *fs_info,
>   		backup = sb->super_roots + index;
>   	}
>   
> -	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> +	if (!btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
>   		free(fs_info->block_group_root);
>   		fs_info->block_group_root = NULL;
>   		goto tree_root;
> @@ -1256,7 +1256,7 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
>   	if (ret)
>   		return ret;
>   
> -	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> +	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
>   		ret = find_and_setup_root(root, fs_info,
>   				BTRFS_BLOCK_GROUP_TREE_OBJECTID,
>   				fs_info->block_group_root);
> diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
> index bba97fc1a814..6c8eaa2bd13d 100644
> --- a/kernel-shared/disk-io.h
> +++ b/kernel-shared/disk-io.h
> @@ -232,7 +232,7 @@ int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
>   static inline struct btrfs_root *btrfs_block_group_root(
>   						struct btrfs_fs_info *fs_info)
>   {
> -	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> +	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
>   		return fs_info->block_group_root;
>   	return btrfs_extent_root(fs_info, 0);
>   }
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index bffe30b405c7..b2ee77c2fb73 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -1668,6 +1668,7 @@ struct readable_flag_entry {
>   static struct readable_flag_entry compat_ro_flags_array[] = {
>   	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE),
>   	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE_VALID),
> +	DEF_COMPAT_RO_FLAG_ENTRY(BLOCK_GROUP_TREE),
>   };
>   static const int compat_ro_flags_num = sizeof(compat_ro_flags_array) /
>   				       sizeof(struct readable_flag_entry);
> @@ -1754,9 +1755,7 @@ static void print_readable_compat_ro_flag(u64 flag)
>   	 */
>   	return __print_readable_flag(flag, compat_ro_flags_array,
>   				     compat_ro_flags_num,
> -				     BTRFS_FEATURE_COMPAT_RO_SUPP |
> -				     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
> -				     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID);
> +				     BTRFS_FEATURE_COMPAT_RO_SUPP);
>   }
>   
>   static void print_readable_incompat_flag(u64 flag)
> diff --git a/mkfs/common.c b/mkfs/common.c
> index b72338551dfb..cb616f13ef9b 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -75,6 +75,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
>   	int blk;
>   	int i;
>   	u8 uuid[BTRFS_UUID_SIZE];
> +	bool block_group_tree = !!(cfg->runtime_features &
> +				   BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE);
>   
>   	memset(buf->data + sizeof(struct btrfs_header), 0,
>   		cfg->nodesize - sizeof(struct btrfs_header));
> @@ -101,6 +103,9 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
>   		if (blk == MKFS_ROOT_TREE || blk == MKFS_CHUNK_TREE)
>   			continue;
>   
> +		if (!block_group_tree && blk == MKFS_BLOCK_GROUP_TREE)
> +			continue;
> +
>   		btrfs_set_root_bytenr(&root_item, cfg->blocks[blk]);
>   		btrfs_set_disk_key_objectid(&disk_key,
>   			reference_root_table[blk]);
> @@ -216,7 +221,8 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
>   
>   	memset(buf->data + sizeof(struct btrfs_header), 0,
>   		cfg->nodesize - sizeof(struct btrfs_header));
> -	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used, 0,
> +	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used,
> +			       BTRFS_FIRST_CHUNK_TREE_OBJECTID,
>   			       cfg->leaf_data_size -
>   			       sizeof(struct btrfs_block_group_item));
>   	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
> @@ -357,6 +363,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>   	u32 array_size;
>   	u32 item_size;
>   	u64 total_used = 0;
> +	u64 ro_flags = 0;
>   	int skinny_metadata = !!(cfg->features &
>   				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
>   	u64 num_bytes;
> @@ -365,6 +372,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>   	bool add_block_group = true;
>   	bool free_space_tree = !!(cfg->runtime_features &
>   				  BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE);
> +	bool block_group_tree = !!(cfg->runtime_features &
> +				   BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE);
>   	bool extent_tree_v2 = !!(cfg->features &
>   				 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
>   
> @@ -372,8 +381,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>   	       sizeof(enum btrfs_mkfs_block) * ARRAY_SIZE(default_blocks));
>   	blocks_nr = ARRAY_SIZE(default_blocks);
>   
> -	/* Extent tree v2 needs an extra block for block group tree.*/
> -	if (extent_tree_v2) {
> +	/*
> +	 * Add one new block for block group tree.
> +	 * And for block group tree, we don't need to add block group item
> +	 * into extent tree, the item will be handled in block group tree
> +	 * initialization.
> +	 */
> +	if (block_group_tree) {
>   		mkfs_blocks_add(blocks, &blocks_nr, MKFS_BLOCK_GROUP_TREE);
>   		add_block_group = false;
>   	}
> @@ -433,12 +447,15 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>   		btrfs_set_super_cache_generation(&super, -1);
>   	btrfs_set_super_incompat_flags(&super, cfg->features);
>   	if (free_space_tree) {
> -		u64 ro_flags = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
> -			BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID;
> +		ro_flags |= (BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
> +			     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID);
>   
> -		btrfs_set_super_compat_ro_flags(&super, ro_flags);
>   		btrfs_set_super_cache_generation(&super, 0);
>   	}
> +	if (block_group_tree)
> +		ro_flags |= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE;
> +	btrfs_set_super_compat_ro_flags(&super, ro_flags);
> +
>   	if (extent_tree_v2)
>   		btrfs_set_super_nr_global_roots(&super, 1);
>   
> @@ -695,7 +712,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>   			goto out;
>   	}
>   
> -	if (extent_tree_v2) {
> +	if (block_group_tree) {
>   		ret = create_block_group_tree(fd, cfg, buf,
>   					      system_group_offset,
>   					      system_group_size, total_used);
> diff --git a/mkfs/main.c b/mkfs/main.c
> index ce096d362171..518ce0fd7523 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -299,7 +299,8 @@ static int recow_roots(struct btrfs_trans_handle *trans,
>   	ret = __recow_root(trans, info->dev_root);
>   	if (ret)
>   		return ret;
> -        if (btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
> +
> +	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE)) {
>   		ret = __recow_root(trans, info->block_group_root);
>   		if (ret)
>   			return ret;

