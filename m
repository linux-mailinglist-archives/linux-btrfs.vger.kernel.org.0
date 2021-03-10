Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4464334CB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 00:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhCJXlW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 18:41:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37022 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhCJXlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 18:41:03 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ANdjwM050796;
        Wed, 10 Mar 2021 23:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=67QKvZn5tR4iSRkYfHejDJdA/hsiQnSpZluizrRbEko=;
 b=BkCyAy6zxBRHJLRUeAbZ5Sai4i03TO08ib6VE8wRo0Hm/0ui3qpG2UELK8//d44+7Bf7
 QFDUOq1tXTnuKWCXDponXtaR3v2asFUpW7ObEzzg7DiOtnmRDMb8+KjvaCeYhQu2Khww
 cc9u4o2b8Y544ml7Hu2so0ns2iBtoFafhJUEhG0TcBrK5c7RVEYueIZj1qNJ83eYQLdu
 4wzBQ60uhDlcK27z8VV8YzNGWONV7/j59zxvEQL8Lw9qk/IZHadZgOvP4fIwwiFhXK1I
 WBWcooSybQGzCExp8TnylDqKkaMNsTldBOp79iQzZ87ShxrK19rImbG1tjLqgq8gi/6A jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 373y8bvyyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 23:40:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ANZP1j025160;
        Wed, 10 Mar 2021 23:40:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3020.oracle.com with ESMTP id 374kgu2pv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 23:40:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/mYaYmEKUDrZhxWObvPliCHc87/ZwI1iRcCYWa5jVYBtjeb7fy304Sx9sH4EEJrXqyd8HWl00eArhP+zUIXI2GYjbQUxVsvcIodKtUmTgPsUHLZU3srchE2z9Lu0VX3IvBA3orh1kpc9MDrqorB5uioyAAXTSnWWshHJZcQcJO4DANuDo0Y854drWRgwZjiwyRTQfI5Bl+R0oFF83lKMGzG0ObHhWJzzHQWp/ZsCAtwJjOEafauL4NWTB5aAZwmuzrLFabV9/+z6CgWAri4DxkZV5jKmAJxheld4MU15lQ67UKvz6gkyDkH3TI6OGAjxbMdzRvG2CzxeapytHMbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67QKvZn5tR4iSRkYfHejDJdA/hsiQnSpZluizrRbEko=;
 b=MMpzv/XrflaSrMXN1Rbq4icVSHUuk71oz2nmVYygX2OLW6ogNyRw+fBnPOeWMdYEzDd7Fuc0PMNyX3+2kivY6OxbMewVkSzhsT0mYvG88XkjY210DCPEhRwVzWhlu2SWgU2Yu+VbAkizoeDYJSBddfCH5xD7/PUxFfhDBpz6be/8S5ctRcqyS9j4NoYyOBtrkqPEoOWvTr2YEqskkDaRlsqVw4Ycf78fskft3EjXIhVXrLgcmAEw9c8j6+a+aKTVp4jU+sTHjZEQYIXPvMd7nrmu8GnCFK1xlCZ04TYjUUl5JtEwUIUWEfeSeaslU2AsFMSXF01Wxk5wSYl4NuQ0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67QKvZn5tR4iSRkYfHejDJdA/hsiQnSpZluizrRbEko=;
 b=K7vXouxurFfvBYH/zy5d+Ulnp/LBBdVZ7OoczjT6D+oeDunHj30dlrVuoGGpqOMQiFQeDzyFX48FDh2RrOV6mEcQsyaqQjdEZX7qwNsBi6ZsF6bgv2DWBqtLkL235E0a5nVUYLoCHEyEDikKMESz61g1UXrxm22xomrSYXHHW7w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Wed, 10 Mar
 2021 23:40:55 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 23:40:55 +0000
Subject: Re: [PATCH] fstest: random read fio test for read policy
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org
References: <746eadd73fb847050f1dc3a6c47756259c73e73d.1614005115.git.anand.jain@oracle.com>
Message-ID: <f2b105b4-f351-8860-66f7-a4b123b28cec@oracle.com>
Date:   Thu, 11 Mar 2021 07:40:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <746eadd73fb847050f1dc3a6c47756259c73e73d.1614005115.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SGAP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::25)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SGAP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 23:40:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56d07750-318b-4124-8187-08d8e41df325
X-MS-TrafficTypeDiagnostic: BLAPR10MB5171:
X-Microsoft-Antispam-PRVS: <BLAPR10MB517156D71DF907189C62A9B4E5919@BLAPR10MB5171.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:305;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40kwvDg8WLcULNP8ATcHcNhibjwXbIBBe3o6mXnMpnHhYT45tPlZV905eOeME3XfRmaYQLaarggellgziXZtuZbO5dMTXCc7loqRHRsdjRpnOXgq/qm11OOoIw/23TEnIfZ0resoULA27zxEtda8DVn6MdWvivRnlLw8r0NRK7LQl85m99GmSi0tAcCreKltYjaqP5gd7K8ISxG/52WdWamJfAk5HhtOgY3k8eESL1nk0Q1IB3Q21+i8TQZZGH1g4ZfV7Z0mqbCnf8ziFvLJ/r7bdfQcHonlVSEgb94Sy06XQ+R7Xu4D0FAqhXN7jQBglucsXbJLm60coHcmoekwed+JM8R6s3qcs0vOl5YoFWYP4U86esQbZiRD9JXfSBaUeeQvcm/i0k0+LfCL5R9NLKP82QoopeW6TAFAIJLYv8sRVaOqAUXMLWBS88QUNPdDXQHPIxnVKX3cVQ3Gqt8EIZwUcNncWwqYDIaR2pva9Mvi92DlLAu+I8XlJiomyq6Gqd6Pc5MlNait96ECA2Vb28WR+EEqHgH92C3l39S1usW9/5O52S1P1r7HyXcgOzmJVzAUuRvT96WD8lsYcEN34ExujpA5+Zu9Ap9HsFUyLgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(346002)(396003)(16526019)(186003)(478600001)(8676002)(4326008)(83380400001)(2906002)(6916009)(26005)(316002)(956004)(6666004)(44832011)(66946007)(31686004)(36756003)(16576012)(5660300002)(53546011)(86362001)(6486002)(66556008)(66476007)(8936002)(31696002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Tm9OL20wcWF4WUlEZFRiUDNleVBESk85YlNyMGpRNk9MdjdyVW9RQnhCdk51?=
 =?utf-8?B?ajByYmtFbXQrV1FKU3lGMG5NNnI5SEVvY2JhNDN3Yy9BbUI1ckUwdXNlcHN4?=
 =?utf-8?B?TFQ3NUpsRVM4OVRmcERab0RidWI3eU9ieVlhWUdHL2JHVmJKU0tZSHczMnRs?=
 =?utf-8?B?T0VtSGt6RjkrTHBXdDZuNDZSa1VLNGRuQUFUWWtGaTNQZTA1VWN5a2NjdkVQ?=
 =?utf-8?B?c3p0RkNyVkpIYmxlUmo5TGhyeGZObjQxWWoxbW9vRTB0cFlNR1k5TmUxendq?=
 =?utf-8?B?dXNCTmg0WTI4NGhKMU5mcTA4TnRyL2ZWWTRMODVDRGcybXBrc2NPT0FvekdB?=
 =?utf-8?B?TGQxN2p5UU5meUVJZGszRVBhL212YnBzQm5LSllhSFhGWTJVSjFsVks2MmdU?=
 =?utf-8?B?bE1UektLR25PWlg0ZmlqbmxzTFMxSCt0UWtxTEY2WDNIUVpXd3d1bGM1S25l?=
 =?utf-8?B?UWZyWFR1N29DMm1ZR2RjeWNXb2ltK0twbmZyTUN3Sks2NVRwcGtDUnh3SENF?=
 =?utf-8?B?S2ltak85WmVQaHJoMFlLa3NMeVhkYUZMWlg4WkM1cmsrVnAxdnRJUkc1d2FP?=
 =?utf-8?B?RVp0M0g1bHMzRTVXYTZ3NTRDVDIwS0J6cnlaQlF1QXdyMlNiSzhDRUFSU3I2?=
 =?utf-8?B?dS9jRHRuS1BTMTNXSUZMN0NGdUFBSkR5UjllbkhjSlcrMFh2eSsrMG1xNlRt?=
 =?utf-8?B?a0ZKZkxWeWlEUFJUVlFkUzVKdlFRc3prZ0hpLy81ZDVNYXlqTW5EVjU3V0Zu?=
 =?utf-8?B?cVdhcS9iOFNzdktKUWFrZHBWL1RWQ2M1ZzRjT3VpWXJSSlo5WEVmY1pBWUhZ?=
 =?utf-8?B?VEdZN3BDSmlIOUNwUm9pa09CSnhaSHF0TURGQkVmdHFXMldQREc3MkRQQkcw?=
 =?utf-8?B?MkFYZkNSeXFzSklSb3RLTHkzYjRRQ1B6bnhpQTV0VnlOZlNWNVVhcXluM3ZN?=
 =?utf-8?B?R200MVA3Z0d4VXVRTU15UmxydXRCV2VhK3pEYzhIRjlNdnUyVHNPNEplNVQr?=
 =?utf-8?B?cVh0YzFEeGVOZTIwbTUwaklCRkxGNm9oaVhUdFA1Rkx2aDl1cmJjSjFEQjRU?=
 =?utf-8?B?QXE2cCt5d3pvVDNhYjdkcnNmQm8wbDErTzZUeTRuQ2t0QU4zZXJrVktJM1Y5?=
 =?utf-8?B?ODRrMXlXbE1TSjBNOE15SlRjUTBQUkhUWkp5c0EwR2NLcjFFaGt5ZzJwbk1W?=
 =?utf-8?B?NE1vbU1TQnRsK2drWFlBdUZ2YklVczNMMU5LMVhwK3RWSFNpTEdpVXpleTJO?=
 =?utf-8?B?ZVNrWGFndVZwbGJKYzgyRzVieFE5NjFUQ3k3TEw5T0x1N0Q2aVBOZitzM0I5?=
 =?utf-8?B?ZmU0UWNkUkdLQVkwQjVDL1pWeThvSHE3WWtndTJNdmY5SWhCNHJhT2VWUGZi?=
 =?utf-8?B?Z3lEVWxmNVJsUGNFS2xUaXJDMWxMTmRUVytjVzlzenBtR1owZnFydFE5VDlr?=
 =?utf-8?B?L0djTTlnZkJFa3g3MFp0dE4wRTlueGF6K3dyeE9ldGNqc2tJeVVaYmJIRi8x?=
 =?utf-8?B?bjRlaVc1dzJnbGwyN24rTFdQclhNem9MQytYaHBzZml2NTZBbUZRUGk0RWVM?=
 =?utf-8?B?N1BoY3BNTitzOHJFN2YycE1lM2ZjUzZqSEIwOFA3VGJqLzYrSmJpUWRISWU3?=
 =?utf-8?B?cGN6cXE1TlBFc0xCQit1ZWl0VGZYd2crODU2dWZ6SmJHQXdMQzhQell4Y3Jr?=
 =?utf-8?B?dWxlOXRHMTh2aGZveFFJZHgyNFNIS1BEd3Vna0lQbFFtT203RUw1WlhvV2I4?=
 =?utf-8?Q?ldeUdDHFEfKf/U7LoSzGDHASIdeERHyH4EKkMX+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d07750-318b-4124-8187-08d8e41df325
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 23:40:55.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hci7fLftwmIXDjCi6zrI0mCP8PpDQz32dKRXcTldOsEvtuJRvp5Vneq5n/qrnA298w9DhLvAyr9xXlY6g6/viw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100114
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi,

  How about a review of this test case or suggest any better ideas?
  If we are ok with this, I will be adding 2 other types of workloads
  that we need to test read policies.

Thanks, Anand

On 22/2/21 10:48 pm, Anand Jain wrote:
> This test case runs fio for raid1/10/1c3/1c4 profiles and all the
> available read policies in the system. At the end of the test case,
> a comparative summary of the result is in the $seqresfull-file.
> 
> LOAD_FACTOR parameter controls the fio scalability. For the
> LOAD_FACTOR = 1 (default), this runs fio for file size = 1G and num
> of jobs = 1, which approximately takes 65s to finish.
> 
> There are two objectives of this test case. 1. by default, with
> LOAD_FACTOR = 1, it sanity tests the read policies. And 2. Run the
> test case individually with a larger LOAD_FACTOR. For example, 10
> for the comparative study of the read policy performance.
> 
> I find tests/btrfs as the placeholder for this test case. As it
> contains many things which are btrfs specific and didn't fit well
> under perf.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   tests/btrfs/231     | 145 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/231.out |   2 +
>   tests/btrfs/group   |   1 +
>   3 files changed, 148 insertions(+)
>   create mode 100755 tests/btrfs/231
>   create mode 100644 tests/btrfs/231.out
> 
> diff --git a/tests/btrfs/231 b/tests/btrfs/231
> new file mode 100755
> index 000000000000..c08b5826f60a
> --- /dev/null
> +++ b/tests/btrfs/231
> @@ -0,0 +1,145 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Anand Jain.  All Rights Reserved.
> +#
> +# FS QA Test 231
> +#
> +# Random read fio test for raid1(10)(c3)(c4) with available
> +# read policy.
> +#
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +fio_config=$tmp.fio
> +fio_results=$tmp.fio_out
> +
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_dev_pool 4
> +
> +njob=$LOAD_FACTOR
> +size=$LOAD_FACTOR
> +_require_scratch_size $(($size * 2 * 1024 * 1024))
> +echo size=$size njob=$njob >> $seqres.full
> +
> +make_fio_config()
> +{
> +	#Set direct IO to true, help to avoid buffered IO so that read happens
> +	#from the devices.
> +	cat >$fio_config <<EOF
> +[global]
> +bs=64K
> +iodepth=64
> +direct=1
> +invalidate=1
> +allrandrepeat=1
> +ioengine=libaio
> +group_reporting
> +size=${size}G
> +rw=randread
> +EOF
> +}
> +#time_based
> +#runtime=5
> +
> +make_fio_config
> +for job in $(seq 0 $njob); do
> +	echo "[foo$job]" >> $fio_config
> +	echo  "filename=$SCRATCH_MNT/$job/file" >> $fio_config
> +done
> +_require_fio $fio_config
> +cat $fio_config >> $seqres.full
> +
> +work()
> +{
> + 	raid=$1
> +
> +	echo ------------- profile: $raid ---------- >> $seqres.full
> +	echo >> $seqres.full
> +	_scratch_pool_mkfs $raid >> $seqres.full 2>&1
> +	_scratch_mount
> +
> +	fsid=$($BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | grep uuid: | \
> +	     $AWK_PROG '{print $4}')
> +	readpolicy_path="/sys/fs/btrfs/$fsid/read_policy"
> +	policies=$(cat $readpolicy_path | sed 's/\[//g' | sed 's/\]//g')
> +
> +	for policy in $policies; do
> +		echo $policy > $readpolicy_path || _fail "Fail to set readpolicy"
> +		echo -n "activating readpolicy: " >> $seqres.full
> +		cat $readpolicy_path >> $seqres.full
> +		echo >> $seqres.full
> +
> +		> $fio_results
> +		$FIO_PROG --output=$fio_results $fio_config
> +		cat $fio_results >> $seqres.full
> +	done
> +
> +	_scratch_unmount
> +	_scratch_dev_pool_put
> +}
> +
> +_scratch_dev_pool_get 2
> +work "-m raid1 -d single"
> +
> +_scratch_dev_pool_get 2
> +work "-m raid1 -d raid1"
> +
> +_scratch_dev_pool_get 4
> +work "-m raid10 -d raid10"
> +
> +_scratch_dev_pool_get 3
> +work "-m raid1c3 -d raid1c3"
> +
> +_scratch_dev_pool_get 4
> +work "-m raid1c4 -d raid1c4"
> +
> +
> +# Now benchmark the raw device performance
> +> $fio_config
> +make_fio_config
> +_scratch_dev_pool_get 4
> +for dev in $SCRATCH_DEV_POOL; do
> +	echo "[$dev]" >> $fio_config
> +	echo  "filename=$dev" >> $fio_config
> +done
> +_require_fio $fio_config
> +cat $fio_config >> $seqres.full
> +
> +echo ------------- profile: raw disk ---------- >> $seqres.full
> +echo >> $seqres.full
> +> $fio_results
> +$FIO_PROG --output=$fio_results $fio_config
> +cat $fio_results >> $seqres.full
> +
> +echo >> $seqres.full
> +echo ===== Summary ====== >> $seqres.full
> +cat $seqres.full | egrep -A1 "Run status|Disk stats|profile:|readpolicy" >> $seqres.full
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/231.out b/tests/btrfs/231.out
> new file mode 100644
> index 000000000000..a31b87a289bf
> --- /dev/null
> +++ b/tests/btrfs/231.out
> @@ -0,0 +1,2 @@
> +QA output created by 231
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index a7c6598326c4..7f449d1db99e 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -233,3 +233,4 @@
>   228 auto quick volume
>   229 auto quick send clone
>   230 auto quick qgroup limit
> +231 other
> 
