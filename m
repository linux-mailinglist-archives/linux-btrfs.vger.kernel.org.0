Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8E436648
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhJUPdH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 11:33:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49968 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231861AbhJUPdH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 11:33:07 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LFIOuH017595;
        Thu, 21 Oct 2021 15:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VxRPllUbfMJw7ecCRjGkRQppxBO8qGfc7mbefopFkDU=;
 b=Tmx1+AtHc8NRWpG3vBswMgn16pw6loidO1Bs86pqJJ6lrZ7+4karC+M56b8hImM6cqTd
 KTw3x7yBYt4EzZgS3RFMqgxagKfyv5m4tSvlU6OccTib+AGyB+85PQDYr2o03gwaxqOs
 7/y7l4yhNZzwrT9lL0N5D8drITfn4asEGiIvKQtxtWkWOBGELSll1SqZXknNX0hX1nRr
 Q93BUpr0AvVL5QSjdFX+K8RSOQF9XvI7+ru1t5m4xfffCl8KMIIa/jcunYSEXye12dCZ
 UEH/lLF3dKBI6wRJdVfDBoy+Vhbc9MPyTFObrPrQRBrfrXFzAXrYQO8O6xeAB9Af0xOk tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj6y27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 15:30:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LF5fOg082110;
        Thu, 21 Oct 2021 15:30:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3020.oracle.com with ESMTP id 3br8gw847u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 15:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2WaqpzWkUb1xrmgRG95pgu9KrAfaasiSigBsAJ1xWQ0fqBQYwox0tC/1L5MDQM76yJGfLNint6R+0vK4kf4rrE6SjtcVXvu6StBsMxhxCwVW+eUnQ1v3wUbAY0OanRcbnMdFamwklIS2JCkbe/pprSfRqvhVo6ImeAp2PLdiCFpAUZvt2pfZ7bJBXyPxZNOZsNT+i2hwth2amT52EwjVdWG6XrSYJEpBDcKljfo4gvCY2YbTVERxf6PZkZK8VFnl+Ea9ZJIU5gyImtoaBRZXDH52MDfsF42wPHo8LFYWDk0P3F0KLcV94zHtd8X+y3unDnp7/Hp+I1nLWn1jYbA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxRPllUbfMJw7ecCRjGkRQppxBO8qGfc7mbefopFkDU=;
 b=ECj78TAQihSIiy9gunqwarnoPwGPkvP0lI0JQrW1+/u4qnAvA69QhFDnkQDSjSwsPWG6Hq8v1v+hCHuge1NnyJjVPcBlzM0nwAg/6dCkKF9ZY87/dGdgwAYyP7/xriZG6BDQC5k/shgK4ppDS0UdO+p9ZGNOR8hVEStHWUG2WJbaDifCrV+0lowo1R+QYeqLGbR62E0QpVJO7MrPRTzjtr0H0R6IGJSNP/Nki7RFswInex9qxhqz6JLUi8uzaoJyZ8RSVqsHZUZaQAeXgH/C1M96u6+/OIznNrKpS0fOy62+8DLRQyM6PeBD6MsqWSDsz1BQqFRkslIWyoz/5VSZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxRPllUbfMJw7ecCRjGkRQppxBO8qGfc7mbefopFkDU=;
 b=QSk05rE7S+OBTHw8w0LN70LgiBABO7QIzZTDoo4RDtrpZmvag0OhHeljeJ4wLB+CRjSzYQC0BfwliP+oDpvCtUQSbGVLfvN6XjDwipKTqtiflwxC0RnTupAJdR3Sk5HCCpJQXp6O1RH2hysbNRSrN9DTbE0l5DL1AZATsq9Suqs=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3839.namprd10.prod.outlook.com (2603:10b6:208:186::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 15:30:41 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 15:30:41 +0000
Message-ID: <a3d16075-7f7b-8bb5-0cee-41fa4be5ce0e@oracle.com>
Date:   Thu, 21 Oct 2021 23:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [btrfs] 0f80799866: WARNING:at_fs/sysfs/file.c:#sysfs_emit
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20211021133538.GA16330@xsang-OptiPlex-9020>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211021133538.GA16330@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR02CA0052.apcprd02.prod.outlook.com (2603:1096:4:196::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 21 Oct 2021 15:30:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09800bbf-b14c-4a7e-f65b-08d994a7bd2f
X-MS-TrafficTypeDiagnostic: MN2PR10MB3839:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3839FD9842292FEE87DB1852E5BF9@MN2PR10MB3839.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhamDQPDwMzCg+xs+YNyvoBdDwNh/YfwdLEtk6F18WiIssA+iRmioHSDo2ObIcOKb7jS4EP3R7Lp0xmQRkxqmaSVJhAdT10ly6Gj/3y8o0QWedAPI+AUyKwVrzVsIWYkOR17qXkGjukKYMQ4fEryvs6k+UHIwUhWXqSIw1FG/NlxmI3TIH/vQnqWrZRbcq8Xk39nmo/0toaW5b1YGX4T6QgGvR7sXYz3lPziNUW0pDDE7CyxQgbVa3+7GQ3HM0H25AUxj3YLumDZ/UX2BWGOa+akxWhakVlMb//Uy/CXbpV89Jqv5n/rfax23Sm9wuAFoyc1cotoLIO93qN/ZyW4fjvZCRWDVwaXf9i+kkWRpRBdX62UH1yjRnZIrfjDYWPWnumgmootQpEdYLtZb0gV9qjMkHMurVF6A3DSCBtWrH+mp3XEAIAh6e+c2BLG3PD86/LGNUfUVRhmZZxmPc8ibACPe+4M6fR3a4d/eb7MTFh3PT0qi4LCS7j165ernN9UtEbuCCdA+CbhdE2WIhyO7afZ93DeG+0hcMtKpQUBQg0Qr/BYur8bYo22Q8t2sMWMBFEHD4RQjhBP0m1SK6mHOPRWSqqWWWBh3Kx93Q+15+tc1qn0nq/hakQrCdsO2K/faIPYj7Kd4IV8BywsnP1GR/VQFqKBI7mPjl53QrRKByC84zx7hQCdszTsIaCAL6m8G3RQQaapsK2bW6CwMXuTxmTlKYfqBc/L7LsFkMU2TLsmmxk1hYjnKYg/K8zNAT5aAa/E3JSnNxZHuXgiwyji5tKK1m/0arxs85RkUEAxx1h4eSToj6CI2QWurpGGx4hFPBOITOzitV3inr44JVq8SBHyd6R1eJZ+N8HJLeBaapo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(83380400001)(186003)(4326008)(53546011)(316002)(36756003)(5660300002)(31686004)(31696002)(16576012)(45080400002)(2906002)(6666004)(26005)(54906003)(66556008)(66476007)(66946007)(8676002)(6486002)(966005)(2616005)(8936002)(956004)(38100700002)(6916009)(508600001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9MdFRtVGF2WmFCMEEvZ2tLVElhWFNRNk8wTWRIUFQ0ejc3R1FHTHJ4dURM?=
 =?utf-8?B?NThWMTk3RHd5T2g3V1NuWUdZR1ZFZWZjNDVSVmNyTm1RQjE4ZmpoaDlxWk9z?=
 =?utf-8?B?OEFuT1dxUUcrNnJ1WGZMaEFIQW5YVFMvdnhqQUxGZDZwMFc2eDljb2taNDFy?=
 =?utf-8?B?eVBVT0l4RHQ1UTlBcVNOdnFqaVFyaHZwdGUrV1VQZTQwOHpJYWo4NnI2NE54?=
 =?utf-8?B?eHlybXNvd2hGa0htOFRWTlYrT0ZBWlZVNW9Yc2F1MnZaeDNOMVZOUlZiRG1n?=
 =?utf-8?B?eGcwQ1RsRklYSFI5cWw5TzJWRTZYeTAwQm5YaERrYzZqMHhsNExiZlU0a3F3?=
 =?utf-8?B?VlB5UGJsMysrd2Z2YytqZVlDNXErdmcrdERUdmIyYzUrVUY3UE9wSlp2RUUw?=
 =?utf-8?B?NTdaOWVlOWI4SSsweVR1MTlPdkc3bHNGMXhWRnVNTy8vcWFYYnhUL2ptdjFw?=
 =?utf-8?B?RmxMRnRvQ0J2VkE4c1kvanFPUENJNXF4SEdjb0Y3MkhJVXNXamZxQ09qRStC?=
 =?utf-8?B?bGxObStWUlBMSW1uUFFvYmY0c0hJSktLd1FsV21UVFZ1U1JFeFpPL1BtWEtu?=
 =?utf-8?B?QzRVMXdNWEh3MDlqSEx3UWpkc3o2azBVc1RaT3hKY1QxZDV5T2JxdHFxSGZU?=
 =?utf-8?B?NHAwUjdDMDVuTXZKMW05ZUpLeEM0eGNwOFo0T29Db1ZnMElkUFl6OEZhWmFW?=
 =?utf-8?B?Z1lyNTJ3YmUvZU4rME1Iak1OelllaThpZ3dSMTRVdFk1NUEvSitMRFB2ZC9F?=
 =?utf-8?B?Z1NKL1pXbUk1bCtoTUtWTHFRM1RJaDdEc255Vnhvb1Z5OExSY1VpTkVHQVox?=
 =?utf-8?B?MSsvTVpVRXFKY2FkZURhZ0x2SGtpdWNrRzRxdEw1RXdDeDRERmlZaHZpWWRp?=
 =?utf-8?B?azlpY0s0THFuWXhqMGo5V3M3ZXVWUEVoVXAxcVNpVEZkdVpDNElJSUN1OVlP?=
 =?utf-8?B?bHVKbEZaQUU0S3IvcjBybHFBeklFaDlMZmlKNHZ0NjFaMEpBWDBQeWpzSWJy?=
 =?utf-8?B?L3RRRWU1Ym5KRmQ0RGJhbm8zQzlqN0lrUXN6Zk9YWHZybllUZWxXYlY4alFI?=
 =?utf-8?B?R1hOcW9CMVJ2cnVNVGEwV01XWTVqUGEzVGN3emhUcWdUUm9CUTl6ZjVuLzMv?=
 =?utf-8?B?VmVBM2h4NUhNVGpLTk5OTnRiTnozNk1YcC9ZUWZyNENEcHFid05QSFV1ak5v?=
 =?utf-8?B?UlVGcTZQQWI2dWxpSUpHVFQ1SjNjWTVtOUVVb0U4MFZOUW1jbmNHejdkL2JB?=
 =?utf-8?B?QjMzY3hqZ2FIaWZ6WExoNElxVnVLYkwvUm9UUnJPK3dmYzVUMzFFMGgxYyta?=
 =?utf-8?B?c0FBUzYrd3FtdXRBYk9KeFhnTmRMaCt5NG9KWlpyZHVJbjlVVzhtUmdVcElV?=
 =?utf-8?B?cUtkaVRvN1k1bjF3UmcxN1g0VDZINjVBOTc3cEhyRFBLQkJia2tsUjE4UXhL?=
 =?utf-8?B?RUc1WHNqckxIVzlsRURIVlYvN255RlZaNDFRWmgvKzcrK29pNVJqaGZiL3dr?=
 =?utf-8?B?ZWcwK3hXMUFqNW9oU0VHNDNNeEdCUVQyOVJjeFQvenN0bGtmaElxVHZqb1Ni?=
 =?utf-8?B?MW9CRUE3LzVSNzJiYlpieXdIZlZzQUJGRjU5Z0lyRVlLZEFVSmVsWmdOYW5Q?=
 =?utf-8?B?bWpnWEFwMlJpeG1BWU9LSzhVOGFhUlhLMHBpeFE0Y2FHeENSeFcvb1dKUk1K?=
 =?utf-8?B?cVNVMEJZWmxuVzU1NzVBYkYreHFzQ1FiMDRzZVZudzJjcGtiYzRVNkl6bW9P?=
 =?utf-8?Q?EXirBKYlYAS3JyEaqQzcNPfoXDqjqCPor06P3f5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09800bbf-b14c-4a7e-f65b-08d994a7bd2f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 15:30:41.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3839
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210079
X-Proofpoint-ORIG-GUID: s9RnWGj_xms7DxzXOeUyUlDncDeP-2nN
X-Proofpoint-GUID: s9RnWGj_xms7DxzXOeUyUlDncDeP-2nN
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/10/2021 21:35, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 0f807998661ecadb74638c18cbaff8785bb46f8d ("[PATCH 1/2] btrfs: sysfs convert scnprintf and snprintf to use sysfs_emit")
> url: https://github.com/0day-ci/linux/commits/Anand-Jain/provide-fsid-in-sysfs-devinfo/20211019-082356
> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
> 
> in testcase: boot
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------------------------------+------------+------------+
> |                                        | 00c9626f46 | 0f80799866 |
> +----------------------------------------+------------+------------+
> | boot_successes                         | 12         | 0          |
> | boot_failures                          | 0          | 12         |
> | WARNING:at_fs/sysfs/file.c:#sysfs_emit | 0          | 12         |
> | EIP:sysfs_emit                         | 0          | 12         |
> +----------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [ 17.140001][ T1] WARNING: CPU: 0 PID: 1 at fs/sysfs/file.c:737 sysfs_emit (fs/sysfs/file.c:737)
> [   17.141231][    T1] Modules linked in:
> [   17.141878][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc5-00151-g0f807998661e #2
> [   17.143180][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [ 17.144848][ T1] EIP: sysfs_emit (fs/sysfs/file.c:737)
> [ 17.145557][ T1] Code: e8 76 ec 66 00 83 c4 08 5b 5d c3 ba 01 00 00 00 b8 00 fa 50 cc e8 d1 a9 e2 ff 89 5c 24 04 c7 04 24 b1 88 c7 cb e8 da 0d 14 01 <0f> 0b b8 e8 f9 50 cc 31 c9 c7 04 24 01 00 00 00 ba 01 00 00 00 e8
> All code
> ========
>     0:	e8 76 ec 66 00       	callq  0x66ec7b
>     5:	83 c4 08             	add    $0x8,%esp
>     8:	5b                   	pop    %rbx
>     9:	5d                   	pop    %rbp
>     a:	c3                   	retq
>     b:	ba 01 00 00 00       	mov    $0x1,%edx
>    10:	b8 00 fa 50 cc       	mov    $0xcc50fa00,%eax
>    15:	e8 d1 a9 e2 ff       	callq  0xffffffffffe2a9eb
>    1a:	89 5c 24 04          	mov    %ebx,0x4(%rsp)
>    1e:	c7 04 24 b1 88 c7 cb 	movl   $0xcbc788b1,(%rsp)
>    25:	e8 da 0d 14 01       	callq  0x1140e04
>    2a:*	0f 0b                	ud2    		<-- trapping instruction
>    2c:	b8 e8 f9 50 cc       	mov    $0xcc50f9e8,%eax
>    31:	31 c9                	xor    %ecx,%ecx
>    33:	c7 04 24 01 00 00 00 	movl   $0x1,(%rsp)
>    3a:	ba 01 00 00 00       	mov    $0x1,%edx
>    3f:	e8                   	.byte 0xe8
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	b8 e8 f9 50 cc       	mov    $0xcc50f9e8,%eax
>     7:	31 c9                	xor    %ecx,%ecx
>     9:	c7 04 24 01 00 00 00 	movl   $0x1,(%rsp)
>    10:	ba 01 00 00 00       	mov    $0x1,%edx
>    15:	e8                   	.byte 0xe8
> [   17.148128][    T1] EAX: 00000020 EBX: cce568e0 ECX: 00000000 EDX: 00000000
> [   17.149078][    T1] ESI: cce54ae0 EDI: cce568e0 EBP: c181fed4 ESP: c181fec8
> [   17.150009][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010296
> [   17.151159][    T1] CR0: 80050033 CR2: 00000000 CR3: 0c709000 CR4: 000406d0
> [   17.152227][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   17.153237][    T1] DR6: fffe0ff0 DR7: 00000400
> [   17.153964][    T1] Call Trace:
> [ 17.154511][ T1] btrfs_init_sysfs (fs/btrfs/sysfs.c:1310 fs/btrfs/sysfs.c:2023)
> [ 17.155279][ T1] ? tracefs_create_instance_dir (fs/btrfs/super.c:2552)
> [ 17.156161][ T1] init_btrfs_fs (fs/btrfs/super.c:2558)
> [ 17.156848][ T1] do_one_initcall (init/main.c:1303)
> [ 17.157551][ T1] ? parse_args (kernel/params.c:153 kernel/params.c:188)
> [ 17.158265][ T1] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
> [ 17.159070][ T1] kernel_init_freeable (init/main.c:1375 init/main.c:1392 init/main.c:1411 init/main.c:1614)
> [ 17.163787][ T1] ? rest_init (init/main.c:1497)
> [ 17.171751][ T1] kernel_init (init/main.c:1507)
> [ 17.172549][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:740)
> [ 17.173320][ T1] ret_from_fork (arch/x86/entry/entry_32.S:775)
> [   17.174042][    T1] irq event stamp: 2402249
> [ 17.174752][ T1] hardirqs last enabled at (2402257): __up_console_sem (kernel/printk/printk.c:255 (discriminator 1))
> [ 17.176070][ T1] hardirqs last disabled at (2402272): __up_console_sem (kernel/printk/printk.c:253 (discriminator 1))
> [ 17.177397][ T1] softirqs last enabled at (2402270): __do_softirq (kernel/softirq.c:402 kernel/softirq.c:587)
> [ 17.178704][ T1] softirqs last disabled at (2402265): do_softirq_own_stack (arch/x86/kernel/irq_32.c:60 arch/x86/kernel/irq_32.c:149)
> [   17.180238][    T1] ---[ end trace c9e9be0944a14324 ]---
> [   17.181055][    T1] ------------[ cut here ]------------
> [   17.184298][    T1] invalid sysfs_emit: buf:cce568ed
> 
> 
> To reproduce:

  A modload is good enough to reproduce. Unfortunately, I didn't check
  the dmesg for Warnings during the hand testing.

  Fixed in V2.

Thanks, Anand

> 
>          # build kernel
> 	cd linux
> 	cp config-5.15.0-rc5-00151-g0f807998661e .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 
