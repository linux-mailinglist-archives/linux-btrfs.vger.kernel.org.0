Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26E7588505
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 02:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiHCAHC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 20:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHCAHB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 20:07:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28D632B
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 17:07:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272MiSJZ021042;
        Wed, 3 Aug 2022 00:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=P3fgVtPCJkDBTISLgNS0HaiyQoAg4zSNupj1/1kC57k=;
 b=Uk1mnc7pX7Tq4DBkFItNNdW98SL2GVY9LZgN+pI9bMCp31pxR04jSxdkRGBiQs47CUjw
 9dYtcqfXbpNSW/CKtAD4OnlgzLWAIn/nB9+FPhUrm/HWy9abWimx3Ew7K8ghVSG30hP8
 sF1tXlP+WnuXNTCIcGSlZFLKM6E6ngI3mzkFofZSUyjHxi3HR/9Nr8laHgpmbVCpziap
 1QfSwQ65P9uw6lX24MTa6lcsMNiaKst662gefGCFcbzggymFUk296XsWotatzyQBlpM3
 D+CoP3MonX0zR2ZrYETPLxwJlcgbuJXQj+fMaquZOUw/YSsnXyhpSyt2zN1NszKYrEgg Xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tggge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 00:06:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272M37C9010772;
        Wed, 3 Aug 2022 00:06:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32s9j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 00:06:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6wtlTNH/1haUUu6M9tgavaXzVP34KntKEk09mCx3hfUbXTGkfWtXY0K8NjbI0OlIsaZgWkSNzTEBuf5JVzwYUlzJXvriwd8pQRXD15jeQA4aUgpFaQabzXPRV5IBYPrhFcysB+XsfFyZWuOTWixRL4kIQZkqQ2KnjzpZY25X48m22lqkdcV7c20+yDWx7ZswUf9W28R7Fv1703ZjKBKadtYAr2+t5b80n628WoGOi+zfDwXQogyxlki+Zafnxh2llFHlGRIdT11cyQ7BRkNkCl3fppOfrWutBJp4crYEHfbk644jOvvQTE2AIPVjO1tMtkua8MIh0xrwVg+S3jH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3fgVtPCJkDBTISLgNS0HaiyQoAg4zSNupj1/1kC57k=;
 b=miL1u+yIkDiNOu8hMFB6jG2bmAG4sUw4SNBjnFG7PHMWyyKt3rlXzSw0a308wKGl8XstPaARv+Q0DiBDZWT25rZAtU9AooPJfJdNO3fze1gUAmJaPo8RQGO6WB9m9jh5S0qaORlW434XwGn7ya05O1jVCbGy/pTkTkS37CwlzJGwWeM/3uxgsZY/bj+za04rS3EExUO1JRvs/+iH0TKMkqgibsEJBGK7Xgxlnxetqx4vypVpf2gzOAGXuBZbK1E79p85/rimqObqJjVQD2KIxRuo2VlG0A85/uOBuLjGqv62e9cpW+KGtobv/CJtFzMCZZZTBe0mJBj4y412gqTQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3fgVtPCJkDBTISLgNS0HaiyQoAg4zSNupj1/1kC57k=;
 b=vxYxrICBnmPX5OHxNR4aQ2I6N5TfqRecuPzWg8bisxaSDozyg52DtLLEYExq87dhEH1R9fxVXKfowfyVptr3NV6hP990MLMzpooHj1IAe0M/jm/2e8FPxlq7h1AQMv03//57gxWsl7oQQ5c4BkGE/iZkHL6lPIUtfFxtmJCv7Aw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5869.namprd10.prod.outlook.com (2603:10b6:510:14b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 00:06:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 00:06:54 +0000
Message-ID: <cb79999e-a16c-294e-4dab-74c4be45b85e@oracle.com>
Date:   Wed, 3 Aug 2022 08:06:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] btrfs: add checksum implementation selection after
 mount
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1659443199.git.dsterba@suse.com>
 <cc590040e5393aad0294e3d7c592de991706cf2e.1659443199.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cc590040e5393aad0294e3d7c592de991706cf2e.1659443199.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9485739-d80b-4e46-3e24-08da74e4129b
X-MS-TrafficTypeDiagnostic: PH0PR10MB5869:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIwWuk0bcAJul8e466cAYB3jvyFqp4IlEXTR4qzFbTMEr3MNrkUKvsWf2noDmvjX0MlgPUtzK5GchaKIS1Vy+W27iKpqZ5eZxKmSgc60IpvwHTdOaWTNPxs8nwfmkUhRrpnKkU0zErmyHnvs8iLHkoA+sVpS2aHvb8Sg1B1PyMtUjOuBCqJZiqGKphTwp4rCUrWkhCw1YS5H9iZtaSsGnLohHkgXgccIm71G7ZJNHoVudhDa3UDe6aHpIH4wRfEaWAxLYHX3WOLdC3OzYT55jTlXqDFjDvBZiEyCwpgdVeIyWDI0qamp4O34rIqHv2z++d4GS3VlAA8gLTmfHfs66Aew90gVZ3sbXfhPTdlNgw1dEAKfPuTBBEFmWZX7jX43//GnQseB5uMqgKU3dZyljQKCZeQVFVH+OE7GRieYx0RqKroDPcm7Iu/7Z9mJ+cYZh0PfE/B7HEBNctdq2lele8DjGysQE3EjY/lQWspB9sC1xd0Js38m9Oi9YIF8QsY3IcE688+JI/0jzUbKvfPmaIwM0LrxdKScbdwluGIzw6Gq0dYKIXMjrLQBHIRzJpOhOEKdXeXKxfLQ9z7gcbojwIBwL07zxCxmMfxCXgxx9wFJCxJXbrKRCjZ/L16xs8Lqz1gVObt/y2ysuro+j8W0KnyW5HfcAtB/JG6xoM4WnynhsNY2OWxgFUEQZ7bb4YKiAtqRkzELydwQ675wLHGbACH16o8w92MW6vAHPc+HxMzjg7isvcvT5p/lyT6gO+m/1ee4Z8sdFQQTMPtiIeJd4On110KMK2XSve5iYPmZQdCWr6Mly1V7AmrShcToXAAnEOQS+Av5FF5UHBB8jLGQGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(366004)(396003)(346002)(2906002)(316002)(31696002)(5660300002)(8936002)(38100700002)(66556008)(86362001)(44832011)(66476007)(8676002)(66946007)(36756003)(6666004)(6506007)(41300700001)(53546011)(6512007)(2616005)(186003)(83380400001)(26005)(31686004)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHBNTHhkQ1dFREhnZEJKNXBkNUVldkZHK25jUnB5Rm5hZE92dVNTR2hIOE1M?=
 =?utf-8?B?ZXpWdWlKYmp6SkVwcUNHME9WNURyOHlNZlY1VlZkdDkxajRoU1VvOVRidC9a?=
 =?utf-8?B?TlpZL0RGYjdJbGlJRGl1a1cxMEhaRTZMVDNiZUdmcVcyUlp0bk9Zb280NEJP?=
 =?utf-8?B?aWlIMUhpUC9SWC9JQnFVeUl3QVRzdjJzRWI1a2hobGhYaWNyYXUvbmJoN3pT?=
 =?utf-8?B?UEZFZndvNWczWldscmx6Z1Y2L0ZxeGpaTUt1dXVLUzFOYmJxcUJoTjUxbVZH?=
 =?utf-8?B?NjVscjQzZDE1SUkzY0FVT1RBNmpDZ1hmb1dmOUFkNm1JYnJwdjNmdXhFeWx4?=
 =?utf-8?B?MTVsLzVjYUM2bTlGL1RISHhqQVhZdkEvUWdoTUdOTjFUV0IrUUhtZXpXYUla?=
 =?utf-8?B?R1ZmVys4NVNXSFVxQjhYeVlhazIxT0oxOWhORXN5VWZ4VXlOaVNOcTVBenFF?=
 =?utf-8?B?NHZYcDVsTDFYY3l1QzFIZFJPdXF4V0ZsMmNtVTFhdnRTbHhxS1VSdDhIbjI0?=
 =?utf-8?B?TWE3K005ZnNuTG94UVVSZzcvY0RPcXBHVVRPaFhvd1pZRE9FaWhFTkVxekQ1?=
 =?utf-8?B?Yk12c3JWMjQwWm4rYlhMUFh0eGt6ZzYrVEJlU1FvNm5uNzdRSFNVN2o0RzZw?=
 =?utf-8?B?Rng1QVpOclJ0N20vTzhxcGErS1A2NlZYemdPdDk1QWdwakVmSmtEZTgyeU9w?=
 =?utf-8?B?K1MxUUJXUkZ5bDhiSC9DaWJYL283amdHd0d4blZwYXJ2NVZ6d285dVdjdjh5?=
 =?utf-8?B?ajVadTkybER0WTV0bjNsWCs0NXM0cE1Pd2RLL1IwUTVWTEVaVVNlRnNsUjRn?=
 =?utf-8?B?Q3dtNW1LMkdrK05QMjB3c2YzZVBmY2pIVmVTS0hJcVVxak1IY0lHa3A4RGwz?=
 =?utf-8?B?SFBXczNGQWkzWkdML2N1d1QvS25kbkZtcVlUTmY2VEVIa3pWdTdBMWJ2U3B2?=
 =?utf-8?B?YnFNWFBsWHZWN05MWndiNk9mTFhFbnQxMW8wWTdKb3cvcTVkbWN6eUhEOVVs?=
 =?utf-8?B?dTl3NzFCUys2WjM0UGRNSlI2MzBlR1plMnhkNkpWQ0dqckhnTjBFa1VQRW1s?=
 =?utf-8?B?d3lQYmZhSU1HM3BSZU9LRXJLSExHZVRyU053clJPMXFPZmswOERDL29QV1F3?=
 =?utf-8?B?RlYzdFZnYXZheGJSMjJMVWRJdUdwUlQ1bEQ2TGM3Y2M3R25MZWIvQU9uZ1ly?=
 =?utf-8?B?N0c4SFVDSlQza0QyanZkY2xFY1JncEhocE83YUhQUnBleXRRNC95WXZnSVV2?=
 =?utf-8?B?eG1wdjhTZ3lXRk4wbVcvUE5aajBCRzVuVXVhUFpaV1FWM2dVRjljMS91K0Zm?=
 =?utf-8?B?MWRZcVJhRGQwRFEzMzdRWmNTQ1IzbFRTUURMS1FWVGdmTTd2NUtwU3ZhcDlp?=
 =?utf-8?B?T2F2ckltdVhnRGdtZ0RDQkVXZmJhV2x1MlJXMnRZNkR1cm9KWmplQkJwdEp0?=
 =?utf-8?B?QlBhT1FlSThlV3JZK3JBTnVuT1BwN1d0dzJRSzI0MlJsVVZRcDNQMld6YStH?=
 =?utf-8?B?dEsvblJVZWpKU1NXTU1EdDhVV1JqRzJaZWJBbVFqdmdqYlcxM3BhY3R6LzQw?=
 =?utf-8?B?RjFIMjV2SnFaTjZBSGhZWWdXczhFK1hIQ21XTzI3L1V3WHl3eVJ2QUJYYkVJ?=
 =?utf-8?B?QVJoWnl2R01MdXpTSEc5blJDNWdUREZvdUo3SWF6dW1FZGo1VXF1RUZYSXpM?=
 =?utf-8?B?UmlRRzBoTnVuTWY4WVdZRkp5WFJ6QTd4RDFrS1U5QXZuSCt6Qnppc1ZzUFRZ?=
 =?utf-8?B?cElkRXJTams1THN6cmpGWnJJcUcreGxkNm5rZ3lPTEVCMWpXMDVEdFd2eXBH?=
 =?utf-8?B?NEc0SG1uNW1ZNnBLSEE5NVRmRGVWN2s3UFVKcXZNUU9jcHR3YUxQTi9GeCtR?=
 =?utf-8?B?blFkaVVyN1dxQkIyT0F6SVpRWXVVU3ZrNldWcWdsVmlYRFArWkRwZDJyM0dK?=
 =?utf-8?B?cmRwRWFQOEM0RldKSW0zdklNY0dlbDdudzdGNkhMODJMZGp1Z0RtVHkzOFcw?=
 =?utf-8?B?QWs0aUFwZzU0aGQwb0ZCNlVPVXpHTW9KU0VENG1Pa1lzdmJhMTU3dG9CdHRt?=
 =?utf-8?B?SHozZkZUVXFMUnpNbTh2M2dJdW82NTNWMlg1YnRtT1RsaWc2TXdmcVJ3ZmQ3?=
 =?utf-8?Q?oV2kHboF5Xqjt7hSP45Ljvo0v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9485739-d80b-4e46-3e24-08da74e4129b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 00:06:54.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4hiAWT24ql08vvw1ZtoY6wrIG8er3o0kM/W4vtAUcbdwPUaYpu23VfrwrTn2A07TPJb99lu3PM+iPcCWYrADw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_15,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020114
X-Proofpoint-GUID: VnZD4NgQQ4BSS2DS-KSENzGmdMbHh-qU
X-Proofpoint-ORIG-GUID: VnZD4NgQQ4BSS2DS-KSENzGmdMbHh-qU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/08/2022 20:28, David Sterba wrote:
> The sysfs file /sys/fs/btrfs/FSID/checksum shows the filesystem checksum
> and the crypto module implementing it. In the scenario when there's only
> the default generic implementation available during mount it's selected,
> even if there's an unloaded module with accelerated version.
> 
> This happens with sha256 that's often built-in so the crypto API may not
> trigger loading the modules and select the fastest implementation. Such
> filesystem could be left using in the generic for the whole time.
> Remount can't fix that and full umount/mount cycle may be impossible eg.
> for a root filesystem.
> 
> Allow writing strings to the sysfs checksum file that will trigger
> loading the crypto shash again and check if the found module is the
> desired one.
> 
> Possible values:
> 
> - default - select whatever is considered default by crypto subsystem,
>              either generic or accelerated
> - accel   - try loading an accelerated implementation (must not contain
>              "generic" in the name)
> - generic - load and select the generic implementation
> 
> A typical scenario, assuming sha256 is built-in:
> 
>    $ mkfs.btrfs --csum sha256
>    $ lsmod | grep sha256
>    $ mount /dev /mnt
>    $ cat ...FSID/checksum
>    sha256 (sha256-generic)
>    $ modprobe sha256
>    $ lsmod | grep sha256
>    sha256_ssse3
>    $ echo accel > ...FSID/checksum
>    sha256 (sha256-ni)

I am not sure if I understand the use of slots 1 and 2 correctly.
As each checksum type can be either generic or accelerated, slot 0 is
the default which tells the preferred method. So slot0 is either
CSUM_GENERIC or CSUM_ACCEL. And by default, we prefer accelerated when
available or user requests. So I am still not getting the purpose of
slot1 and 2. Instead, overwriting slot0 will still do the job without
slot1 and 2.

> The crypto shash for all slots has the same lifetime as the mount, so
> it's not possible to unload the crypto module.

How does the update of the accelerated module work if a btrfs is a
non-root filesystem? Does it need a reboot?

-Anand


> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/sysfs.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index cc943b236c92..0044644056ed 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1100,7 +1100,91 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
>   			  crypto_shash_driver_name(fs_info->csum_shash[CSUM_DEFAULT]));
>   }
>   
> -BTRFS_ATTR(, checksum, btrfs_checksum_show);
> +static const char csum_impl[][8] = {
> +	[CSUM_DEFAULT]	= "default",
> +	[CSUM_GENERIC]	= "generic",
> +	[CSUM_ACCEL]	= "accel",
> +};
> +
> +static int select_checksum(struct btrfs_fs_info *fs_info, enum btrfs_csum_impl type)
> +{
> +	/* Already set */
> +	if (fs_info->csum_shash[CSUM_DEFAULT] == fs_info->csum_shash[type])
> +		return 0;
> +
> +	/* Allocate new if needed */
> +	if (!fs_info->csum_shash[type]) {
> +		const u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
> +		const char *csum_driver = btrfs_super_csum_driver(csum_type);
> +		struct crypto_shash *shash1, *tmp;
> +		char full_name[32];
> +		u32 mask = 0;
> +
> +		/*
> +		 * Generic must be requested explicitly, otherwise it could
> +		 * be accelerated implementation with highest priority.
> +		 */
> +		scnprintf(full_name, sizeof(full_name), "%s%s", csum_driver,
> +			  (type == CSUM_GENERIC ? "-generic" : ""));
> +
> +		shash1 = crypto_alloc_shash(full_name, 0, mask);
> +		if (IS_ERR(shash1))
> +			return PTR_ERR(shash1);
> +
> +		/* Accelerated requested but generic found */
> +		if (type != CSUM_GENERIC &&
> +		    strstr(crypto_shash_driver_name(shash1), "generic")) {
> +			crypto_free_shash(shash1);
> +			return -ENOENT;
> +		}
> +
> +		tmp = cmpxchg(&fs_info->csum_shash[type], NULL, shash1);
> +		if (tmp) {
> +			/* Something raced in */
> +			crypto_free_shash(shash1);
> +		}
> +	}
> +
> +	/* Select it */
> +	fs_info->csum_shash[CSUM_DEFAULT] = fs_info->csum_shash[type];
> +	return 0;
> +}
> +
> +static bool strmatch(const char *buffer, const char *string);
> +
> +static ssize_t btrfs_checksum_store(struct kobject *kobj,
> +				    struct kobj_attribute *a,
> +				    const char *buf, size_t len)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +
> +	if (!fs_info)
> +		return -EPERM;
> +
> +	/* Pick the best available, generic or accelerated */
> +	if (strmatch(buf, csum_impl[CSUM_DEFAULT])) {
> +		if (fs_info->csum_shash[CSUM_ACCEL]) {
> +			fs_info->csum_shash[CSUM_DEFAULT] =
> +				fs_info->csum_shash[CSUM_ACCEL];
> +			return len;
> +		}
> +		ASSERT(fs_info->csum_shash[CSUM_GENERIC]);
> +		fs_info->csum_shash[CSUM_DEFAULT] = fs_info->csum_shash[CSUM_GENERIC];
> +		return len;
> +	}
> +
> +	for (int i = 1; i < CSUM_COUNT; i++) {
> +		if (strmatch(buf, csum_impl[i])) {
> +			int ret;
> +
> +			ret = select_checksum(fs_info, i);
> +			return ret < 0 ? ret : len;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +BTRFS_ATTR_RW(, checksum, btrfs_checksum_show, btrfs_checksum_store);
>   
>   static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
>   		struct kobj_attribute *a, char *buf)

