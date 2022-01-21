Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB73495C99
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 10:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379692AbiAUJPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 04:15:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34316 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379694AbiAUJPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 04:15:53 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L7PYml001131;
        Fri, 21 Jan 2022 09:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RswM37kIUylG3bk6jMghi2WlSHec8Uf19C5x/r0fY1s=;
 b=ROb7OWmf4w9SeRkdTTTurXj4tSTzt7Ytfr4LeCppSpkXLZ+rx9uYfLzBG5tn0AWzcgJw
 anY31JkwTqEWAMYW70bQjjQtg4EZubjytJ9H/hwNiTmtkdyChrYGL7eTYNgLJhKOEQ66
 ka9mQqnFmcixnZ0d2xKGjwVIHyOvtvi0jcpuv/uNHTKpajenlpJBwwBBsryE4GlIEhUl
 fuCuk3+ocxHPWcoE/1WoX9ZBzox2R78pC6ekH84RIsqIj5Rq22lB00MRaFFyLoVglJG8
 vWxGwgak+KKvTW4jS/TXlvdLoDHG81Gfb6h8zZLvYx4zXoXduEgi5jdh+IEVLmvTWeFY hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhy9rs4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 09:15:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20L9AZJF136285;
        Fri, 21 Jan 2022 09:15:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by aserp3020.oracle.com with ESMTP id 3dqj0st0sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 09:15:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K75SiROZPaKvZnPziRIOSKYHRO5tBVaY2Uswcb52mxbCjwCkuFZhjz1RI9hdFLDeEVoEddsgU2jl+RbQo5PGufIeESCbVuQlVD2Dh+6mKFrU3s4kveimVM9hAoLWholJndrIabgzfGphTBp2qQ0yG5nfs/dIP/9trdWoE0qIL+hdLAiNjRXWfTfHmRVjXN7V2OrY54c2dqmTulrkVm/Cd/iiIRMvGMrk5wl+DsEvaoLnDsRJ6LwOS52vXbpra79GAZD5t/sMboV+wv7+Ev3uBgUQYUe+yvDPJnELMlBzlT/JaLbyi7UY5DR+xXV1+Swg+BHQ8fT0UXHSMr6rP5dfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RswM37kIUylG3bk6jMghi2WlSHec8Uf19C5x/r0fY1s=;
 b=GnEUp6lncyXXJfOkC65I5+X8CbYps+w2T+Q9WwXYsyWZ7Mok/OhsHkoX/FeLLAppZt7sMKTi+J8XfxrkZprtJQBB8jPY1trBHDn0bG8HRxBFKF/VV4wiK4XUhg4KK/eG7P0Jk2VNT8i519Ttv6xx30UX+o2oRszJWTpwucrWC1roaddlsEZQTt5R7vM2QrwP56UfK6qNZCXBJGAKs0/rli6YK5G/INWq03veHzFI+5kVJ6Az5ePzCR7VU56PPr3rMFFRE/9x6QWiFnbzpyYPKTZrxhghsK1/oOLMvhxNVBWNGWCEo4GG9BljOitjDHGObHnBOddLIGP4GxqPYFRHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RswM37kIUylG3bk6jMghi2WlSHec8Uf19C5x/r0fY1s=;
 b=krigvVypkAeoDARpBuCcV7xd+nMv/Bm3ItCJ8IaUGTRT4rB579PYgLXQ7aKiUZP7tpGlwITqRgjMzuYFdGIhRL3PSNoI+wvr0j0yxIrV4v2cCRhU82rx6X1tuKCBZi7ZtEY3NvEQHbVlk+1a0G7T8H8MZ4cz7j5ELiA3RgT/vAM=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by DM5PR1001MB2075.namprd10.prod.outlook.com (2603:10b6:4:2b::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 21 Jan
 2022 09:15:03 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 09:15:03 +0000
Message-ID: <36302c35-1b99-9e16-da6d-ebb33bb797d3@oracle.com>
Date:   Fri, 21 Jan 2022 17:14:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC] btrfs: sysfs: add <uuid>/debug/io_accounting/
 directory
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com
References: <20220121052445.37692-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220121052445.37692-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6cf3961-8dab-4c3a-b0ac-08d9dcbe81ed
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2075:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB207544DB63A9CE6724114B6FE55B9@DM5PR1001MB2075.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QgRGmyH29RQ+iGXGtI84F5Iwp1EYxdoUbFh/Kc0BgDMXO2DGIiOp7/aPvIF8k8wtOhrY2NX1VndNfNgk5PXy7kePvvavtmbjVOjA+7P22+QiaIFV046dQFyXQHdvMnWx49KR2Ntsn4KyYuH5VN3YNTCIiEKUaJGxvs2gaksc0WJjSISB2kZp91pn8uLlM3iGQCTrIBFdieIajvfXjGop7oRPQUNfxQ5drhZSc4x7vdfpayszvkMsj5CMT1sUKhisM6xPa/FsnHtneQue1rS1Y7Jf2rZSJo1RhfqRsxG/O+Yd9/P7zuCl7vul0W5oNC9Eqc12zEFk+tSzuY9kj5TAIh0Z2J7u/+ops0B+mIEJ8h0wqzfUeN6dra//kLox+U7n6EbYv1foIcw+cKKhJ120z4dfuH5MMS45TlUyxumLSzE8PpDHWfg6WOx+kYrKvRpDDoZ35lu3TxrBKeDUyalC2o/GtI41BgRkyN5iYv11DvcK6NUOImDP2QpKULbqrp75iVIMxdx175/n1HGWnrcS6lvnDGYoiW6k2OcKJpYAAQO4QXZUKDN/7q6GVI7ooUubRqddOiVHHgS63fgjZ5lt8HlFCeA8UoAVUy4yn60xyvaxEcnW9lbRmRUxFEk8tVwj8tNpQK2PFFcGn8vmUV4Ej9L9Rki8WP8LKms8wYBnzbah3MS1jukgjWs6AEb7pYC/4MiWZPDKQ5k0+x4MlAkLCRqtr0s5RGh469VFwPhp+bk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6506007)(6666004)(5660300002)(31686004)(86362001)(66946007)(53546011)(508600001)(66556008)(31696002)(36756003)(316002)(44832011)(26005)(66476007)(83380400001)(186003)(6486002)(8676002)(8936002)(6512007)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cksrZEN5MzFlK0xtWWxBb2J4eCthbVNwbXp5Y1FpVzFHWVhxZ2ZpUHdpSk9H?=
 =?utf-8?B?ODRzM1RVTnZIVFFPRXo5UDc5b3FzL1RRa0R6RHlJY2hxWUIvdDEvdXFGQzd1?=
 =?utf-8?B?V1c2dGQzSE5lQm5oT055YXh1N3FZaEpxK2grZyt5TmRnbDIyMVBzZlI3WnFP?=
 =?utf-8?B?RmdOMVlkeDFVMUczbjJrWURqUzNRWFRGTVQ3bkI2YlFIek1reVFwUzhsT2F6?=
 =?utf-8?B?SWJEWEk2YVBzQzdHaHpZclBiVFU5TUljY2F5SnYvZlkyci90Rkt5aXRpVkNv?=
 =?utf-8?B?Uk5SZFhPdjIzdU80dU94N3JYQ3NQOUFtRGxMTDc0ZWtZVWhpd3RNMExkNjZX?=
 =?utf-8?B?NS9zZ1c1TVBaY1BrNUExZGMzdVRhUXQreFA4U0FQWGJ2V3pLY3BPdDVPS3JE?=
 =?utf-8?B?UW9SYldPR1NYazM5QXQxRVBpQ0pEa0JpK0JtV2Z0SVlZaVNabTN4RS90MlJN?=
 =?utf-8?B?cXY0aUFqMWNneDVmWktDbHJ0Zk5KVVJUZ3R2Nmo1b2hWQ0kzU0VtVDlSQlRq?=
 =?utf-8?B?Q3FGdkpZVFhRNU9ObTdwaVp3TWh1b2d3SkRaRk1YckRNT2kyVjRZaVpuZ1FX?=
 =?utf-8?B?aW1neGxxb0EzWk0wYkRRcDFsQXRGeGlEMmRQWGlGRjJyT1ZoN3d4TGgwSWhs?=
 =?utf-8?B?dXpoV2ZwcFFhYTVzTklCMDdHWFdpdElFbkRyU0JQUU4zUGVSQWhpc2RNSU9o?=
 =?utf-8?B?cFJ5UTZ3UmR6ZStES0VORUdTcyt0amJQRFJwc3BzQXpFZDVETHUwRmMyMzZk?=
 =?utf-8?B?N1BzcVBCR3BRQ095UFh1WDdIUGJWNkV5NlpsSlQxRmpGMG5laHFGN2wyalJV?=
 =?utf-8?B?YllFdmswUjJhNzR6bm93VXkyaWpIVkFFcTJoWDYyQU5DYVdwd05IcW93WGV5?=
 =?utf-8?B?UVhUU3gzM0prcmNVR21YYldoeTZvR1dKWFBtY2ZUZFZubDlZWHZzb293SUZu?=
 =?utf-8?B?UXdjbHliK1YxbzcvTFR2aEJsZVI3RjVMNEM5clh3YkRkLzR4cVBTS0xKMThY?=
 =?utf-8?B?K3ZvSFB1aXg3b0NIR09taWl5S1BIbnRJMldrcTdGZ043Y1NtRHZMZEJFTXNG?=
 =?utf-8?B?dlJaV2tQOXVUS041L1J3UnBoOC9rWlRZZVlYc3lQOTgwYUlkUnNYYmsrNkJu?=
 =?utf-8?B?UkQrUS9ER3pyeGE5TGJWWTlBbFQwYllicmt2WFl0MTJEWC9wK05HT09jV1hF?=
 =?utf-8?B?bDZhUHY5UHMybHhsYmlqblBiTUxCMUlOSTNGYjVBYTdlREpjQ0lHcGhGZ0RJ?=
 =?utf-8?B?eFN2eHI0aTZDVTB0bkhEUWV1TzZuWWJUcGdCdStJS2RaRW1rc3NrYzJ4d21V?=
 =?utf-8?B?UlI2NmY2bnR3VmQzWERDdEIrd1RRRC9GeEhFTE5yVCtJYTk1S1MwY3E4T2Yw?=
 =?utf-8?B?MnhrV05BMHlHOEp6czcvT3RQQ0VUSWFHU3dXUE11WEVYL1QzSTdHVU5XelZ5?=
 =?utf-8?B?RVNEbVFtREJQOFNZQTkvRS9KeWxibjlDNTc0OCtGYUVzMjQwdVVaS2xFbUhT?=
 =?utf-8?B?TWptakdzRURXRFA4UDJVTER0ak1oU1BWTUhOQmFsZUhSNSszWGtUeDJiZDRq?=
 =?utf-8?B?bXhUWXR3cGl2dlZCaWp0cFoxSG9rRFRqN21HVzlCUW1IRVRiVGNYS0xnV0tk?=
 =?utf-8?B?bldwTEM1VkQzaFk3MlZkSTNXektWYUVZeHdhaHRQYTl1WjhXamNIL3VSSjdR?=
 =?utf-8?B?NmhINGpxK1RnQlFEUjRWSnU3ZEY1RWc4K1diWFNwZmR3MzVPd3ZJOG9Ma09U?=
 =?utf-8?B?bStLeTZyYXZPRHhKQnFUZU90TkxqNXU1QXpHcjE2ZTFoN1JaOTVYTFNwUUZr?=
 =?utf-8?B?aHcxQmxsd1E2VGpyNXVMVlZDRnlBYi9PbHRveFMycDdxbHpiQTJvN0dRUjls?=
 =?utf-8?B?UDhDWWl4R3EzUXVhbWxPZU0zZm1yZWhhSDhMUnZhKzM1YTdsRUNhRXJteGd5?=
 =?utf-8?B?TkxDOUlOSGJYYm9sbzVTY1NIQjJvUDBOSHl2S25sTng2S1hadjJpZmd5WDk4?=
 =?utf-8?B?dUNOMEdqL3lXWksrU2hyZ3VRU2dUd3pVa1hIc3A4bDVneXZrU0J3Z3RuTWZz?=
 =?utf-8?B?djFhc2JKQTRKcEFMVGJyL1lyaHE1YTBBaGUvMHBhR0tJTHd5OVZqNjBUYlFR?=
 =?utf-8?B?cjQxN0IwUXJaejJwaXlkejExZ3pqVDJpMk1IdXk3MWZhbFFvdGlrUGlGT3py?=
 =?utf-8?Q?o1Dr1mwhI3FoZbfos0zHSZM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cf3961-8dab-4c3a-b0ac-08d9dcbe81ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 09:15:03.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pk86rkhE4wGPb7/MeMPNy7YgEegJcNUSigPZ8p0bAO0QGO4zcbMg4QjwP55qnlDiUUnb/KtK3XXLyXkJRnCFtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2075
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210061
X-Proofpoint-GUID: 08xopA3oppe9keFFuLHTfDDgt61y3BjB
X-Proofpoint-ORIG-GUID: 08xopA3oppe9keFFuLHTfDDgt61y3BjB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/01/2022 13:24, Qu Wenruo wrote:
> [BACKGROUND]
> There is a series of btrfs autodefrag bugs in v5.16, that would cause
> way more IO than previous kernels.
> 
> Unfortunately there isn't any test case covering autodefrag, nor there
> is anyway to show the io accounting of a btrfs.
> 
> [WORKAROUND]
> I originally want to implement a dm target to do the io accounting for
> all filesystems, but can not find a good enough interface (the status
> interface has only 3 pre-defined workload).
> 
> Thus I turned to btrfs specific io accounting first.
> One thing specific to btrfs is its integrated volume management/RAID.
> 
> Without proper profiles specification, default profile will cause
> metadata IO to be accounted twice (DUP profile) and only data IO is
> accounted correctly.
> 
> So for btrfs this patch will introduce a new sysfs directory in
> /sys/fs/btrfs/<uuid>/debug/io_accounting/
> 
> And have the following files:
> 
> - meta_read:	Metadata bytes read
> - meta_write:	Metadata bytes written
> - data_read:	Data bytes read
> - data_write:	Data bytes written
> 		(including both zoned append and regular write)
> 
> And all these accounting is in logical address space, meaning profile
> will not affect the values.
> 
> All those values can be reset by simply "echo 0".
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> 
> - (To DM guys) Is there any good way to implement a dm target to do the IO
>    accounting?
>    A more generic one can help more filesystems.
> 
> - (To Btrfs guys) Is the sysfs interface fine?

  I am in for it. It can be a non debug feature IMO.
  More below.

> ---
>   fs/btrfs/ctree.h   | 11 +++++++
>   fs/btrfs/disk-io.c |  1 +
>   fs/btrfs/sysfs.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.c | 24 +++++++++++++++
>   4 files changed, 113 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b4a9b1c58d22..3983bceaef7f 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1035,10 +1035,21 @@ struct btrfs_fs_info {
>   #ifdef CONFIG_BTRFS_DEBUG
>   	struct kobject *debug_kobj;
>   	struct kobject *discard_debug_kobj;
> +	struct kobject *io_accounting_debug_kobj;
>   	struct list_head allocated_roots;
>   
>   	spinlock_t eb_leak_lock;
>   	struct list_head allocated_ebs;
> +
> +	spinlock_t io_accounting_lock;
> +	/*
> +	 * The IO accounting unit are all in byte, and are in logical address
> +	 * space, which is before the RAID/DUP mapping.
> +	 */
> +	u64 meta_read;
> +	u64 meta_write;
> +	u64 data_read;
> +	u64 data_write;
>   #endif
>   };
>   
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 87a5addbedf6..41b56fde6e97 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3065,6 +3065,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   	INIT_LIST_HEAD(&fs_info->allocated_roots);
>   	INIT_LIST_HEAD(&fs_info->allocated_ebs);
>   	spin_lock_init(&fs_info->eb_leak_lock);
> +	spin_lock_init(&fs_info->io_accounting_lock);
>   #endif
>   	extent_map_tree_init(&fs_info->mapping_tree);
>   	btrfs_init_block_rsv(&fs_info->global_block_rsv,
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index beb7f72d50b8..dfdef93bdeab 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -40,6 +40,7 @@
>    * btrfs_debug_feature_attrs		/sys/fs/btrfs/debug
>    * btrfs_debug_mount_attrs		/sys/fs/btrfs/<uuid>/debug
>    * discard_debug_attrs			/sys/fs/btrfs/<uuid>/debug/discard
> + * io_accounting_debug_attrs		/sys/fs/btrfs/<uuid>/debug/io_accounting
>    */
>   
>   struct btrfs_feature_attr {
> @@ -616,6 +617,62 @@ static const struct attribute_group btrfs_debug_feature_attr_group = {
>   	.attrs = btrfs_debug_feature_attrs,
>   };
>   
> +/* IO accounting */
> +#define io_accounting_to_fs_info(_kobj)	to_fs_info((_kobj)->parent->parent)
> +
> +#define DECLARE_IO_ACCOUNTING_OPS(name)					\
> +static ssize_t io_accounting_##name##_show(struct kobject *kobj,	\
> +					   struct kobj_attribute *a,	\
> +					   char *buf)			\
> +{									\
> +	struct btrfs_fs_info *fs_info = io_accounting_to_fs_info(kobj);	\
> +	u64 result;							\
> +									\
> +	spin_lock(&fs_info->io_accounting_lock);			\
> +	result = fs_info->name;						\
> +	spin_unlock(&fs_info->io_accounting_lock);			\
> +	return sysfs_emit(buf, "%llu\n", result);			\
> +}									\
> +static ssize_t io_accounting_##name##_store(struct kobject *kobj,	\
> +					    struct kobj_attribute *a,	\
> +					    const char *buf,		\
> +					    size_t count) 		\
> +{									\
> +	struct btrfs_fs_info *fs_info = io_accounting_to_fs_info(kobj);	\
> +	u64 value;							\
> +	int ret;							\
> +									\
> +	ret = kstrtoull(skip_spaces(buf), 0, &value);			\
> +	if (ret)							\
> +		return ret;						\
> +	spin_lock(&fs_info->io_accounting_lock);			\
> +	fs_info->name = value;						\
> +	spin_unlock(&fs_info->io_accounting_lock);			\
> +	return count;							\
> +}
> +
> +DECLARE_IO_ACCOUNTING_OPS(meta_read);
> +DECLARE_IO_ACCOUNTING_OPS(meta_write);
> +DECLARE_IO_ACCOUNTING_OPS(data_read);
> +DECLARE_IO_ACCOUNTING_OPS(data_write);
> +
> +BTRFS_ATTR_RW(io_accounting, meta_read, io_accounting_meta_read_show,
> +	      io_accounting_meta_read_store);
> +BTRFS_ATTR_RW(io_accounting, meta_write, io_accounting_meta_write_show,
> +	      io_accounting_meta_write_store);
> +BTRFS_ATTR_RW(io_accounting, data_read, io_accounting_data_read_show,
> +	      io_accounting_data_read_store);
> +BTRFS_ATTR_RW(io_accounting, data_write, io_accounting_data_write_show,
> +	      io_accounting_data_write_store);
> +
> +static const struct attribute *io_accounting_debug_attrs[] = {
> +	BTRFS_ATTR_PTR(io_accounting, meta_read),
> +	BTRFS_ATTR_PTR(io_accounting, meta_write),
> +	BTRFS_ATTR_PTR(io_accounting, data_read),
> +	BTRFS_ATTR_PTR(io_accounting, data_write),
> +	NULL,
> +};
> +
>   #endif
>   
>   static ssize_t btrfs_show_u64(u64 *value_ptr, spinlock_t *lock, char *buf)
> @@ -1219,6 +1276,12 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
>   		kobject_del(fs_info->discard_debug_kobj);
>   		kobject_put(fs_info->discard_debug_kobj);
>   	}
> +	if (fs_info->io_accounting_debug_kobj) {
> +		sysfs_remove_files(fs_info->io_accounting_debug_kobj,
> +				   io_accounting_debug_attrs);
> +		kobject_del(fs_info->io_accounting_debug_kobj);
> +		kobject_put(fs_info->io_accounting_debug_kobj);
> +	}
>   	if (fs_info->debug_kobj) {
>   		sysfs_remove_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
>   		kobject_del(fs_info->debug_kobj);
> @@ -1804,6 +1867,20 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
>   				   discard_debug_attrs);
>   	if (error)
>   		goto failure;
> +
> +	/* io_accounting directory */
> +	fs_info->io_accounting_debug_kobj =
> +		kobject_create_and_add("io_accounting",fs_info->debug_kobj);
> +	if (!fs_info->io_accounting_debug_kobj) {
> +		error = -ENOMEM;
> +		goto failure;
> +	}
> +
> +	error = sysfs_create_files(fs_info->io_accounting_debug_kobj,
> +				   io_accounting_debug_attrs);
> +	if (error)
> +		goto failure;
> +
>   #endif
>   
>   	error = addrm_unknown_feature_attrs(fs_info, true);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 2332e3026efa..58f2ec0a611a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6763,6 +6763,29 @@ static void bioc_error(struct btrfs_io_context *bioc, struct bio *bio, u64 logic
>   	}
>   }
>   
> +static void update_io_accounting(struct btrfs_fs_info *fs_info, struct bio *bio)
> +{
> +	u32 length = bio->bi_iter.bi_size;
> +	bool metadata = bio->bi_opf & REQ_META;
> +
> +#ifdef	CONFIG_BTRFS_DEBUG
> +	spin_lock(&fs_info->io_accounting_lock);
> +	if (bio_op(bio) == REQ_OP_READ) {
> +		if (metadata)
> +			fs_info->meta_read += length;
> +		else
> +			fs_info->data_read += length;
> +	} else {
> +		if (metadata)
> +			fs_info->meta_write += length;
> +		else
> +			fs_info->data_write += length;
> +	}
> +	spin_unlock(&fs_info->io_accounting_lock);
> +#endif
> +	return;
> +}
> +
>   blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>   			   int mirror_num)
>   {
> @@ -6776,6 +6799,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 >
>   	int total_devs;
>   	struct btrfs_io_context *bioc = NULL;
>   
> +	update_io_accounting(fs_info, bio);

  Generally, speaking accounting should go at the end of IO.
  Other than that looks good.

  Also, need a way to reset the values.

Thanks, Anand

>   	length = bio->bi_iter.bi_size;
>   	map_length = length;
>   

