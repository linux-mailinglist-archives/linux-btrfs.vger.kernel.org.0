Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD41465E80
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 08:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355720AbhLBHNO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 02:13:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11326 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230521AbhLBHNN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Dec 2021 02:13:13 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B26oBLw018239;
        Thu, 2 Dec 2021 07:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ywjdVAw765TXoIuIehAW1qtBoJRR46YP36oOOKHkC7Q=;
 b=x85HpIpgaQg+YNIHjOAnqmhqL66Cz3bbgaKLAjub4JaLJpZFFDVmWC4BIJn+/6Q4uRfZ
 QcdxlrqEdP5rkWoKsHJAjHl7yplonGgVp8BT4FSQ6Hbw3ezT31wBEwpec1Tx+kXGqTpY
 oX3lAu0Rtpg8t+6maPCEnULW809r+/64V8rY4YKxiBbMnQczN6n6Y9UxCl2tB12BbyIZ
 Mp3D/+XH+kyj65Qc2OxDI5OdlWgOyBt3dsfAJp2Q7/jIlvp1PmE5jyJCsn/zO0e4u9sZ
 sOcPkZYR/143Z28hAps+sBbI2Q0WP828B9ceTbGBFVUd4DdlNV1TYOrCozaBJGLgu/OC Yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasymwmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 07:09:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B275mlw084881;
        Thu, 2 Dec 2021 07:09:48 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by aserp3020.oracle.com with ESMTP id 3cnhvfxemk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 07:09:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqny0uYRPgfnaC0qrZWliYDeaQcyaPPuqpJxxjf0+oP5krN0NH0IEXBdwZ1X0rKvK61DQtuSX2coiGLWAHe1tIh6IXOX0IKgFPmyPrn++gvS5MRoxH0Sh7DY10JDXWp/IVdz5vtzuS39zfi2N19CdyEsWWZjwHusT3xDRZseLZPk2DbuyPcP1TIYIGyaf4vgyIPhgKSz5VVeIy68U0erwajcJFFeIBxn1A08kN0tjoteeMKi6C3pQWk6fehwTXtQuV4iqA9fh6OIC4O2gZ80g6Lu78yIVvMsMWdGTTXlxix9YRie2aBnXJP/ONCX7b1bZk2NkOp7cJCb5sZz2r6daQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywjdVAw765TXoIuIehAW1qtBoJRR46YP36oOOKHkC7Q=;
 b=hdmoVSV0AaC5XXnvYe8J7inBurCK/NkR7PuZ5mryfVmiEXoOm/+UBHTP/DjNkVeMgWNIOZ8i6FXYKH3kvfY7y1DxH+Y4UdCk6U0Fb+7AfTTcCF23kQmmTvr/0+D4D2atBrVDIRrTJMYn8cQbcpPZPo5EnQz4L5ZksJNs4gV3cWuA3UgQKvF9TDfR8QyBvgVQ629sM+ERpcZxoEQBLcbm5KDFYN3EuP0jRUUt5/FQujKRGZMfS71HwmJLP1YxUoVDdgkWtkh1NEkkV8HPVurSdYITfyj4HIRO9Y2aCTcayU55/sMdioyf4VCmQzomiYXflAH5xj9si2khOsfdi28/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywjdVAw765TXoIuIehAW1qtBoJRR46YP36oOOKHkC7Q=;
 b=aI3q9lDOYjPC4SDmBU+mfHn/+pdx9LSKhaV3G46kw68kwPhro3snORwOnnNQdZXSf37d80xdJOba6Dq8adg7roxrA6Zy74AB3um9dFNYlmWltm25/d5ulSA/73HGJr52odXLJgEIB1LG4zz+UWT5FCJjMY8vb8St0o35iVDOkzQ=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2916.namprd10.prod.outlook.com (2603:10b6:208:77::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 2 Dec
 2021 07:09:46 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 07:09:46 +0000
Message-ID: <fdd4a2c9-00dd-430c-0537-d43734337845@oracle.com>
Date:   Thu, 2 Dec 2021 15:09:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] btrfs: free device if we fail to open it
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <7cfd63a1232900565abf487e82b7aa4af5fbca29.1638393521.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7cfd63a1232900565abf487e82b7aa4af5fbca29.1638393521.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0143.apcprd06.prod.outlook.com
 (2603:1096:1:1f::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR06CA0143.apcprd06.prod.outlook.com (2603:1096:1:1f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend Transport; Thu, 2 Dec 2021 07:09:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d93a4a69-b694-468f-3f6f-08d9b562b86f
X-MS-TrafficTypeDiagnostic: BL0PR10MB2916:
X-Microsoft-Antispam-PRVS: <BL0PR10MB29160216309B79535D3FB142E5699@BL0PR10MB2916.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuwLoZA0591kWEHgtsgBsOgpgn3cfl5hWXjcrEI5TtU/6ZAheY8yKDB8imZYFzUDIm5THKgq25UHFoV0U96rvbl1hxhpvEpbvQMFgdZqOqVHV9EzNojVSysDgTq0B1RZQx1w3zTnO/zNdCb8BzUKdCNGOTUYrk3ZaaahyDRoIF1vQJquJ4JDCLj5fFdfCfMzox2d9WoqXGMQtACQRq1tjauqm/pXD11lvxy3DBeu0WxEj8RLnmmZIMnmS9GAl3BeaDr1VLoF/ctpUGNlFPd1bzJTRJnOZlzvXWSdCteLwujID05+TsgxlYNo62RBJ5SVnECEHBMjg2yxJe4gChvlS8HUsQs7twqmTmRhfkmKhq3wasW2uqPxbg8KoGsNz037RDoEFWh+JCWqbpmBjCEZxsJW/jev73Vj8kDF/X9HhkIyUpkD44No83SzIb+czWla8wMBoJqRbTI6Hdpl67NG5Fsz/6WKpQWa6MJX0HHsMRdwdQGX1ij4cDlvOaQErJ1/iUCcyw8q3SsUjupoc281IW8ZaqNnRIrkqpcJ5mRv2ew88WpCztY7sgwJCTXsLdGCdzrWfqG3917cx2EHX9L/OUSxvWTlrzpTpFj8N9o+KdoeReumR/y01lWBn0/npTXBLh5No2Z2KwzOMtzb79Wz/XnAr63G2GTXNYS2ExsylIp0PtkGTKRv0SiuTemk1SoeFotgGhmPM3oF8AfoAxvMleSoz3Qv2t/4VIib/+dd+tuwrOnB+avSJXjnT0vy3BNfPN0Eq5d4l6xMXb+GhdiW+DlRSGqJ7MoleTWwUxw4hbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(16576012)(316002)(53546011)(36756003)(5660300002)(2906002)(86362001)(38100700002)(66476007)(66946007)(26005)(6666004)(83380400001)(31696002)(31686004)(66556008)(956004)(2616005)(6486002)(186003)(8676002)(508600001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW5KZDFXS3h5eDlXNGd0NG1hRFpTSXRmVFRYbm5RazNYYWJBUXl1NFB1V0VV?=
 =?utf-8?B?QmxSa0trbitoOG9kcUx2Y0NCWmlHY043TVQ0TEFFZm52RXhLQ1V2REVDWmRL?=
 =?utf-8?B?djM1ZVpqWmx1b2NhYlFsWVMwaDF2OWRkOWxHZEo3UVZjaGFKK2NWOTJ3bFVv?=
 =?utf-8?B?V2pnZEV4U3d0UFBLY0lOYUh5cS9NS0ZMdWlkYVFPL3J3SGhIRlNwRFZPdExv?=
 =?utf-8?B?OVkrOGRaVWNFbzBmRmg0TEUzbXlJYkNhcVovekZwc1V6dzBDRUNpTUpSLy9a?=
 =?utf-8?B?ZXhhT2FHbThwcW1FbDlqOU4wQnBlQmZWd1JYUmljSWJQamJqRHI0TWs5KzVj?=
 =?utf-8?B?MkcrVTkxcjNvU1BJbUFMSFo4aCtJMG95Y0tXLzl5c1NUWWhzbktIbXUwNXFx?=
 =?utf-8?B?V3Y1M1UzaHNZOVdGN3VKZjkzeHZxTkV1SVBma3JXZXRKb2Z6M3ZIZm0yWnM4?=
 =?utf-8?B?OElXQjl0Wm1maFNIT0plclV4TlZ6OUlzbDNwMGhJMnQ4emhKSDdUTU9NamxZ?=
 =?utf-8?B?a21VRzFmMGkxWDVwREIwVGpJeStLUUYwWlRpWG5Kak1OSjNpem5HeXpWWnVB?=
 =?utf-8?B?ZitPYmdPQ3A1U2pKRCtLKzRkRXhvR1VjOHl0b2NrQm4rZ04yQU8xNGNCMnR4?=
 =?utf-8?B?R0Y2Y0k2RHNqRDd6OGtSLzZyNU8xMTlNZ0d5QSt3amN1Z1c0K1B1SnA5Umhu?=
 =?utf-8?B?OGFXbUtVRzlQMWdIQ3VNbFZaaW9KUmJSZXY1ZWR4ZzFMSjk5THZJaW0xK3RS?=
 =?utf-8?B?WW9TQ0JCVXY5SUZWb3ZHOUlRUjBxNEkrM1NheHlpc2xyMWlpNys4eURuOE56?=
 =?utf-8?B?Vi9pVm8zdEZiVnNjK1o2MzRaR0NXaGY5NDFnZURKSzEzbXNuUTBMVW1EaTRY?=
 =?utf-8?B?Y1pMLzUyS3UranlTSWVmeXpHSWdjdlZhUG9XWVQxZ3gwMTJuVFhYWmJvZHZz?=
 =?utf-8?B?dDRCSUNlWXYxL01CRUxJc0VNdnNFNnFmZnU5bS8vZlhNeVpLRjJ1cVkzamtZ?=
 =?utf-8?B?dk9kNWxvbUtQQnd2N3BQb1piNlNrQkxGRE5Uc0t6bjhZRzJIUXArVi9YeTNy?=
 =?utf-8?B?MTFpTlJneitEQldiUWNyYmExWk92Y2xrdmI5c256UU1ReDlPRE54bERQZ1dz?=
 =?utf-8?B?VkpEZGtIZSszNngwOHpxVTBLTko0TXFNN0xyT1QyL0xmbWhqNG96ZkpkWkNS?=
 =?utf-8?B?THZ6NnpVWVV5WFZPUTRoSGdLM0hoeHNPR2VrenIyUkZYZVlvcEk3WVBwVURK?=
 =?utf-8?B?RE8yTHNnSWMwUHc1WHRBbDBVdlBiMDVGaE56N3UxbmtQcCtLUlNlNjdNQnUy?=
 =?utf-8?B?a1lTUGc4aG1zRjRveFBLbjhjdjdKWXpNNHlOMFhaOUxSQkQ5VEkyOWttZlg0?=
 =?utf-8?B?Nk5OeUlDb0I0VFpkSWZJK3c4anB0akJ2UFlQRExMbE9wNTFCSHZBUTB4ODhh?=
 =?utf-8?B?SXZHYllFbndkUjZ0VVBmYnBib045TGJNRzQwZGthMEpWRFBFdnBqWDE3RlNM?=
 =?utf-8?B?WmZDSE5iSDZpdmtkSGFJVmZCdlNYRDR6K1poRm9DelJ1bXVOZmVRMmp6bVQx?=
 =?utf-8?B?WnUrM3hmMmJab213NlRNLzgyN216cUsvNDNLZTBpTkFzYXI4QVNkWUcxSGVF?=
 =?utf-8?B?dVNNZXFiZFNZTytrV1NmRko3Z2tGNEtKcEh2RFM4OVI4TS80dEtZc1Z5RlZp?=
 =?utf-8?B?bGhzekozUGRrZGtyUEtnMHJVWWlENVdOVjVnSTJjemtnOC95RjZYSVhsQzRp?=
 =?utf-8?B?YlpSU1l0ZytTalpsRWZuWThRVndMa291NHJHZjBpajlzRDlFZHA5L2R3U1px?=
 =?utf-8?B?S1lNYit2U3V5TGh0WmVNSVJxZjZQR2ZJTkg2cTNtN2ZydzFvUS85WVRvc1RP?=
 =?utf-8?B?Um5sVFpBYlQ5c2VDUUJwY05tUWRQQmVWcTdBUkQ5dysrV3FqS1d5QjFzRjZv?=
 =?utf-8?B?NDlDQXpYaURrVjJpUHE1cGorcUdGelhJK3VyY1JTcnI3R1E3ZjRlZ25QVzQy?=
 =?utf-8?B?dUxSS05WNCtnU0tYWWhwYXh6Y05iemVlc1lPNER2K09KcWUyeWV6N1dLUys4?=
 =?utf-8?B?WDc1YzdyWVQ4dnF5OURaUFF0VFZUcFYvT0ZXeG92RDVuN2IvSXhwcWFQbEMz?=
 =?utf-8?B?dFQrQWpOWi9pQ3h0OC90OVBQZzNaQVVxdVhGYytuWlZJN0QwcjB0UDJvMjUr?=
 =?utf-8?Q?h/zlFjsyry1qNNMpeJS4sAk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93a4a69-b694-468f-3f6f-08d9b562b86f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 07:09:45.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OV/vV6sis09+mHGmD8qKSOc7DjYwnYuZvc8PfdmmKbjxi1AzwxVmZPRZh/73ES9+SooiYcUOejn2FwEQ8379GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2916
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112020040
X-Proofpoint-GUID: 6RdYgb_Gi2Me4QPXhBQYDtNDPOVRIw0R
X-Proofpoint-ORIG-GUID: 6RdYgb_Gi2Me4QPXhBQYDtNDPOVRIw0R
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/12/2021 05:18, Josef Bacik wrote:
> We've been having transient failures of btrfs/197 because sometimes we
> don't show a missing device.

> This turned out to be because I use LVM for my devices, and sometimes we
> race with udev and get the "/dev/dm-#" device registered as a device in
> the fs_devices list instead of "/dev/mapper/vg0-lv#" device.
>  Thus when
> the test adds a device to the existing mount it doesn't find the old
> device in the original fs_devices list and remove it properly.

  The above para is confusing. It can go. IMHO. The device path shouldn't
  matter as we depend on the bdev to compare in the device add thread.

2637         bdev = blkdev_get_by_path(device_path, FMODE_WRITE | 
FMODE_EXCL,
2638                                   fs_info->bdev_holder);
::
2657         list_for_each_entry_rcu(device, &fs_devices->devices, 
dev_list) {
2658                 if (device->bdev == bdev) {
2659                         ret = -EEXIST;
2660                         rcu_read_unlock();
2661                         goto error;
2662                 }
2663         }


> This is fine in general, because when we open the devices we check the
> UUID, and properly skip using the device that we added to the other file
> system.  However we do not remove it from our fs_devices,

Hmm, context/thread is missing. Like, is it during device add or during 
mkfs/dev-scan?

AFAIK btrfs_free_stale_devices() checks and handles the removing of 
stale devices in the fs_devices in both the contexts/threads device-add, 
mkfs (device-scan).

  For example:

$ alias cnt_free_stale_devices="bpftrace -e 
'kprobe:btrfs_free_stale_devices { @ = count(); }'"

New FSID on 2 devices, we call free_stale_devices():

$ cnt_free_stale_devices -c 'mkfs.btrfs -fq -draid1 -mraid1 
/dev/vg/scratch0 /dev/vg/scratch1'
Attaching 1 probe...

@: 2

  We do it only when there is a new fsid/device added to the fs_devices.

For example:

Clean up the fs_devices:
$ cnt_free_stale_devices -c 'btrfs dev scan --forget'
Attaching 1 probe...

@: 1

Now mounting devices are new to the fs_devices list, so call 
free_stale_devices().

$ cnt_free_stale_devices -c 'mount -o device=/dev/vg/scratch0 
/dev/vg/scratch1 /btrfs'
Attaching 1 probe...

@: 2

$ umount /btrfs

Below we didn't call free_stale_devices() because these two devices are 
already in the appropriate fs_devices.

$ cnt_free_stale_devices -c 'mount -o device=/dev/vg/scratch0 
/dev/vg/scratch1 /btrfs'
Attaching 1 probe...

@: 0

$

To me, it looks to be working correctly.

> so when we get
> the device info we still see this old device and think that everything
> is ok.


> We have a check for -ENODATA coming back from reading the super off of
> the device to catch the wipefs case, but we don't catch literally any
> other error where the device is no longer valid and thus do not remove
> the device.
> 

> Fix this to not special case an empty device when reading the super
> block, and simply remove any device we are unable to open.
> 
> With this fix we properly print out missing devices in the test case,
> and after 500 iterations I'm no longer able to reproduce the problem,
> whereas I could usually reproduce within 200 iterations.
> 

commit 7f551d969037 ("btrfs: free alien device after device add")
fixed the case we weren't freeing the stale device in the device-add 
context.

However, here I don't understand the thread/context we are missing to 
free the stale device here.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/disk-io.c | 2 +-
>   fs/btrfs/volumes.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5c598e124c25..fa34b8807f8d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3924,7 +3924,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>   	super = page_address(page);
>   	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
>   		btrfs_release_disk_super(super);
> -		return ERR_PTR(-ENODATA);
> +		return ERR_PTR(-EINVAL);
>   	}

  I think you are removing ENODATA because it is going away in the 
parent function. And, we don't reach this condition in the test case 
btrfs/197.
  Instead, we fail here at line 645 below and, we return -EINVAL;

  645         if (memcmp(device->uuid, disk_super->dev_item.uuid, 
BTRFS_UUID_SIZE))
  646                 goto error_free_page;
  647

  687 error_free_page:
  688         btrfs_release_disk_super(disk_super);
  689         blkdev_put(bdev, flags);
  690
  691         return -EINVAL;

function stack carries the return code to the parent open_fs_devices().

open_fs_devices()
  btrfs_open_one_device()
   btrfs_get_bdev_and_sb()
    btrfs_read_dev_super()
     btrfs_read_dev_one_super()



>   	if (btrfs_super_bytenr(super) != bytenr_orig) {
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f38c230111be..890153dd2a2b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1223,7 +1223,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>   		if (ret == 0 &&
>   		    (!latest_dev || device->generation > latest_dev->generation)) {
>   			latest_dev = device;
> -		} else if (ret == -ENODATA) {
> +		} else if (ret) {
>   			fs_devices->num_devices--;
>   			list_del(&device->dev_list);
>   			btrfs_free_device(device);
> 

There are many other cases, for example including -EACCES (from 
blkdev_get_by_path()) (I haven't checked other error codes). For which, 
calling btrfs_free_device() is inappropriate.

To be safer, how about just checking for error codes explicitly for 
-EINVAL? as we could probably free the device when it is -EINVAL.

Thanks, Anand

