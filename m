Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06E52FE77A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 11:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbhAUKXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 05:23:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50646 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbhAUKW3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 05:22:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LAKHgO133615;
        Thu, 21 Jan 2021 10:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PnRUd49IwZSpmcPx8BUcY2b9CLCHCZcqnt/W/yngidQ=;
 b=XYSxwGSDuRdGK7NPgoc+5q8ABCp+KCUeLqvZuRN6YbJ84DoVYsBn6DoUijQ329TqF3vD
 XeHwHh5AUu5Gv+5NaT6hiyrVpMH2Ji42lOYI8ImTFwz+KAuEW32zk01DqY52103K1ds9
 wtIs8V0MdJlAdwJaVmmnSGY95he/+uMYAHRB75ro/ZUeYxUfIrfuj9ZghJ4o/0R/1yxs
 ymCn8j7C9Ros6RScD0q0Pw88t5k7euIOlq/baHl3oh//uAd4ItoOD2/G21ytqxn5Wb/y
 Pfch8pP4TI4C771wYpa8Edq+n6yB/3CSJRyYfjz/zUlPUnnnmjFzaBT5Yquy/nBpmX1Q XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3668qmxmvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 10:21:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LA9jfm084635;
        Thu, 21 Jan 2021 10:19:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3668repq4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 10:19:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+W1GOx7UtllShfk6MFh6gIG3XMToyCWonH3IAGsqJ7hkBqc7t4AzUiSZFdYz/kswbFLbDTKlhPlgAP37Is+cMC7vHPLAtch8JCJDb362rS8L91uDu9uAxCgq51b+PkIELAM3EGDT/D34IL+IsCy+5YG67YQXWKMx05zD1arY8lMgjB4rA54nbS690XY5L/woJ1tKJKznrsMJAZ9BsuXt97a5VPH/VCKrcG58tyrZDoxiZGOAcNS/+96SaNrgKiSy51ru485twWNBb48AyyG/pG+Wnh32zktpC8h/BgSZfMVPgCELZ95/yKexRcUya0CZObJGJ2MDralEBkx6qLcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnRUd49IwZSpmcPx8BUcY2b9CLCHCZcqnt/W/yngidQ=;
 b=Ie5b0qDvmiW4PwajJDadiPEIa56h2avnDpVLCT4WjBo6Ud/ohQ54YnChAWUjjNQaZfly0xwUiTrqvOCVl1OQSffzNeN62WnRtAceCBLdztiZlzHH16hSR55Cx345CeJya+N6Lc/+OHG4uAoQV+l6+hsbEQHB8g3HnRHmOmdlccUlBgQz6Us3YhaDng2Hg8rtA3giM+UJEvZW5BImWoACGQVPGJqMSbrAEvDZ9lidfC1JKP2hgqo+3vbKXgixqNMwtZvxrbakHpUS9DK5fw5GmtgEsD+LzXDBLOz7x2XLEIDhkOBDgBfxh2XJMD/ewRLqJNFpdIErjV19Xu94VMiWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnRUd49IwZSpmcPx8BUcY2b9CLCHCZcqnt/W/yngidQ=;
 b=QOYSNKY4wl8RxD/Bm7SZQdqGjmACwrPEAfQAu++RcJjdgrx3woDGcAOffbtJfKIosIULkwTmQJxUE6Tv2uGfRAIUKJ5IPNK5jSrl93vKMZO+sN4+ObqjjiSEV64dvpey0aLJGG8bVp6QTcDT851gQXyDlOhZOYrpNlXXpKe/ePI=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN6PR10MB1602.namprd10.prod.outlook.com (2603:10b6:405:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 21 Jan
 2021 10:19:24 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3784.012; Thu, 21 Jan 2021
 10:19:24 +0000
Subject: Re: [PATCH v4 2/3] btrfs: introduce new device-state read_preferred
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
References: <cover.1611114341.git.anand.jain@oracle.com>
 <151811057c559d9212c7fc55e9c9cbbad1f62f05.1611114341.git.anand.jain@oracle.com>
Message-ID: <68f27cf6-1c6c-2e93-7078-dfdc569dc4fa@oracle.com>
Date:   Thu, 21 Jan 2021 18:19:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <151811057c559d9212c7fc55e9c9cbbad1f62f05.1611114341.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.0 via Frontend Transport; Thu, 21 Jan 2021 10:19:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f5671ce-812a-4cec-4923-08d8bdf60649
X-MS-TrafficTypeDiagnostic: BN6PR10MB1602:
X-Microsoft-Antispam-PRVS: <BN6PR10MB1602AE92AAAD81A6687B45C1E5A19@BN6PR10MB1602.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOXNZo0AJCynh5T79S0fg4X9B+utxwgLSG5g8mXoTf+ms+Zi3+v+AbA+E0O6AhJmQEX8gTZ2mLSUJe9Nc9Yjq3iL+yJsGqnUCkLNqRyiqboQYliYI17DpBiYvE7675zxSal0MzNTS93uInfoFvLxbMFk2b8Hh8Gwxk1B7hcgJYYr1Yc7llxYjtGAG/AJoMWSb3RGFcrAde2DpDoB6+Mr/QzFFUIzWFvigkMLcrZDpCDZrsOZ5l+rWgih2kFbHTnq3csqQmeXcHQT5cjKIKyX/6Vn67eQPt1qXFwUDK1rWCJpQDESGdYz9aWQT+KdBb3YVpcLv6Nz76q2xpH8tby7XFO9qLq4irSj2Jq/MhsWVXM74JlFElwApIrbhiVOz6ZQ3Kngjgz5JRBO8GF+RY+F5hIEbPNM5CXdvmjha3vqBBQ6p0vAgmUAmTCr4KHgKagZ5C1eGgkEmCNK4fE3vyo8QAIFUnF54PPYQYZ6DNrGAYTAp18gFQAI4hjmpZC/Ej34
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(376002)(346002)(186003)(53546011)(16576012)(86362001)(26005)(16526019)(8936002)(8676002)(2906002)(6916009)(2616005)(44832011)(316002)(956004)(5660300002)(83380400001)(508600001)(66556008)(6486002)(4326008)(36756003)(66476007)(66946007)(31686004)(6666004)(31696002)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d1NTS0JuQVh3VGh2d3g3RDVPbHJqUjArTldsNmt1dzV6bHQvTTVMYlFDcEha?=
 =?utf-8?B?YWRMc1MwV3cvL3dxK1ZUWFFETjVHSHdBMi9LQVZmZitIczlqemJXWnNBdnhR?=
 =?utf-8?B?UmJnaVYyUHVteUhuL2J4cDJwblg3aE90Y205d0JOa2wzRTNvZnE2LzRFaWZl?=
 =?utf-8?B?ZXN6aHpCRmVuUTFxN1ZWMjQwZTY4eVp4OHJUVUtyRE1xc2Z5UmI3TlpVWG9W?=
 =?utf-8?B?c3pMN2tjU3JXblJWalRKei8wSE84R0dTRDZjV2Z5a0swM1NWZFA2eEJtZFo5?=
 =?utf-8?B?dWFiVmtqOVdaK2NuOTJhQVVRRTdsa3oxR2FEa2FqTTNjN0V4MUpWTmQyeXlH?=
 =?utf-8?B?Zzh0bXNWemtOQzJaUGRZalAvY0NjYTJibU8vaTBEcGNyaWZ2YlZWQWYwaHo4?=
 =?utf-8?B?MTVtNDMrTnY0aG5mNjNOeTB0VWV4Mk9PS21GSVNLL1NZZWhCS1h5UGxTSllu?=
 =?utf-8?B?am1TZzdTc1pSMTBSSmhqNUlFeExEaWh0ZUh0Vld5M05nalNLbzhVU3hDdVZI?=
 =?utf-8?B?QlNYeHkxaXZMZ3ZFZlNUQ2ZGUm1HZUJzUmdVVFVCYTJER1krTGE5YkFKOVlh?=
 =?utf-8?B?Y053MWVRUUFOY09QSjBJekFtNU1zanI2bkNSbE93OEFXZXY5V1RMOE9UeFZn?=
 =?utf-8?B?SjJ6YU8zeWNnZHNNS0ZuYWFlT2NLSXpLMFhzUzNpK2ZBQW5kQW1iQlNPdXcy?=
 =?utf-8?B?Mi82MFpweDNzRnNzRGVqaWNjSDVHYThIeTJIU1FjWE9nblpFbmx4Ymp5TllC?=
 =?utf-8?B?MnNwV285NWlxRThwQVZmSEVLNGswRzAzTFh6NjFUbFBONkozT2laYmhYUmE4?=
 =?utf-8?B?N1lTaFlVQmJhalNZbXk0aHhrclYrdGtibDhYdXAyUmtKc1BmVlg0UlRqenFx?=
 =?utf-8?B?aEVaY0NKejN2WTh5aDdUMWIyNVRqREUvU0wxM1VSNG03c1p1cjk2QXlhVFhE?=
 =?utf-8?B?TXVneEIzNFhPMUFYM3BlUWZCdE9MUDJDY0ZLY01xMTJtUThqaUI5bElXbko4?=
 =?utf-8?B?WE1uSGFDTGZxKytmMDJJRDU3aFA0MnR6RVRzY3ByZm9TTHRBK0RQMGp2SStQ?=
 =?utf-8?B?MGNqU0kxcXkxNHU3ZGZTUzlISHluRFdNN0xDbWM5QWJBaVNWekFOUzEyQ1lw?=
 =?utf-8?B?MzlMNy9yTmVBNUd6RVZPR3ovVGhKWW5OSmtIQkhkYzcwTEsyWjIvYlhHYlBX?=
 =?utf-8?B?bm5jSmhWMzNtR1BXTWQralFZYVpwNWxwTlVtOTBoWlhZbkdkYzJHN0R3OHpY?=
 =?utf-8?B?bkg5TWd6R0ZWUG9lclhMUUk3S3l4dTV0OW5lMGhHc2d3ZlR4RkF0ODF4QXV0?=
 =?utf-8?Q?jE/ThyFkYe1rTqz/QQTOUwHb8dNH1iPm2x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5671ce-812a-4cec-4923-08d8bdf60649
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 10:19:23.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jlN4bd+KShwGKGFxHizEf5h9QWxlVULlRlssGG+gRCeHJ0R+gUtldaRyEeUINmnVjXUMUFOvvVezVcA06gtbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1602
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210054
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20/1/21 3:52 pm, Anand Jain wrote:
> This is a preparatory patch and introduces a new device flag
> 'read_preferred', RW-able using sysfs interface.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com> > ---
> v4: -

There is rb from Josef for this patch in v3.
Could you please add it?

Thanks, Anand


> v2: C style fixes. Drop space in between '! test_bit' and extra lines
>      after it.
> 
>   fs/btrfs/sysfs.c   | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  1 +
>   2 files changed, 54 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 7c0324fe97b2..5888e15e3d14 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1422,11 +1422,64 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
>   }
>   BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
>   
> +static ssize_t btrfs_devinfo_read_pref_show(struct kobject *kobj,
> +					    struct kobj_attribute *a, char *buf)
> +{
> +	int val;
> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> +						   devid_kobj);
> +
> +	val = !!test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +}
> +
> +static ssize_t btrfs_devinfo_read_pref_store(struct kobject *kobj,
> +					     struct kobj_attribute *a,
> +					     const char *buf, size_t len)
> +{
> +	int ret;
> +	unsigned long val;
> +	struct btrfs_device *device;
> +
> +	ret = kstrtoul(skip_spaces(buf), 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
> +	/*
> +	 * lock is not required, the btrfs_device struct can't be freed while
> +	 * its kobject btrfs_device::devid_kobj is still open.
> +	 */
> +	device = container_of(kobj, struct btrfs_device, devid_kobj);
> +
> +	if (val &&
> +	    !test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state)) {
> +		set_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
> +		btrfs_info(device->fs_devices->fs_info,
> +			   "set read preferred on devid %llu (%d)",
> +			   device->devid, task_pid_nr(current));
> +	} else if (!val &&
> +		   test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state)) {
> +		clear_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
> +		btrfs_info(device->fs_devices->fs_info,
> +			   "reset read preferred on devid %llu (%d)",
> +			   device->devid, task_pid_nr(current));
> +	}
> +
> +	return len;
> +}
> +BTRFS_ATTR_RW(devid, read_preferred, btrfs_devinfo_read_pref_show,
> +	      btrfs_devinfo_read_pref_store);
> +
>   static struct attribute *devid_attrs[] = {
>   	BTRFS_ATTR_PTR(devid, in_fs_metadata),
>   	BTRFS_ATTR_PTR(devid, missing),
>   	BTRFS_ATTR_PTR(devid, replace_target),
>   	BTRFS_ATTR_PTR(devid, writeable),
> +	BTRFS_ATTR_PTR(devid, read_preferred),
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(devid);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 71ba1f0e93f4..ea786864b903 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -51,6 +51,7 @@ struct btrfs_io_geometry {
>   #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
>   #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
>   #define BTRFS_DEV_STATE_NO_READA	(5)
> +#define BTRFS_DEV_STATE_READ_PREFERRED	(6)
>   
>   struct btrfs_zoned_device_info;
>   
> 
