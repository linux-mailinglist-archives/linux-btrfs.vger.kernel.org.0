Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5813E58851C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 02:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiHCAWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 20:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHCAWW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 20:22:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270DA371A5
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 17:22:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272Mi1T3018302;
        Wed, 3 Aug 2022 00:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kq2HODsHWz/nIxMGJESYNreuGepLfnQgxi3soFSMWQc=;
 b=Ao5Pdp8nSIHqxZEHt6bOumvsVrDTyy4EFS1Jm/9BY2K5h2MWt3HkCE5GpIazSdZyUJ0O
 nS+lSMgsO+bjfRdzOyB9hp1/6BHf/BRzqsXqMnoT5DJE1nSB8sPXxo1FEmoYy1KUGYnX
 vdssDpPmblSJlW96ScvnWbqW/TSVn2JVK2RpGNPFpk7phOYocuKJdt4UvXxy4iQKAZDo
 HVt2bzwSND7YOtL+siijHyLok4NaNXf2SNdAXLdYCOzJR9q3ab/BExlMM3UtDTZUQmXv
 DBnXichDh1uWhsuXp48NJFmtg1I+ZOXtWScmhLqQx7fzg2bkf09m1UQL5u968JSfA3Ww mQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9ra8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 00:22:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272NJ8iT007338;
        Wed, 3 Aug 2022 00:22:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32k5e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 00:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km0gOyePsPMYKf70ufoWjxn57X+cfSyp2d55tOY73jc6pBqRwQLTkdiHCCjhQTuq1gr+Qpip4auOVPPX1dZgq0Cda8IxCCSNPu9KD2OKuFrdLkR7epar20EQdVzDteNUfNiuVFBsuEltHo7jIcASdc6oHogDH/IxQKGtS+FFweQQx+icSlai3mCfLhAgj3uF68i+XsfKDBE4EBCB+SKdX2+0O4FznV8Ooj/lnHPI90cKcPjw0hSEKeogb5RH5Fe3Lj7qLuRc477aYEqwJAVwQ8TnnIid1VleGtfz6Weo65ZCP7XKMD7+EkhzKmUy7DSw7vq4GIIbLpHOhN23gce19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq2HODsHWz/nIxMGJESYNreuGepLfnQgxi3soFSMWQc=;
 b=JHD7J13wVSmXKr90TlDbkUisgyTbdh38Qy9zob3Z7L9c/mxiMLmRs4y6hXQSi7rj7VfCq9AD3oOCpWCxnhwk/ozlW1BuWgoJ+MGvdm5EsBbNLR1PSpjjC43+MQK/qF09udfBbA1FgoyyNAPJQDvmbWLueGCXk8tjbh6gHtrYcLmMm5a58video14RtEPUHCqZYqYAciDJOgbaEgRBnBFs2h5sAWaNGwpRiwGxKCNGURebePFICicikoHtZL0B1jFwDScLW+31e+IozmR6q0+xTmmPmasJ8n/xh82s3L+2V5UewbLFfnfBozvREu0Op4PoMrJ/ap5gf6cAsIsXWTnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq2HODsHWz/nIxMGJESYNreuGepLfnQgxi3soFSMWQc=;
 b=M9/nV7jgKfs+7K9+BVD8/V/Q8lqoVE5hc+44baDtUqjZTXlLTLRTQe2M4VmHqOM48kDT8bQUyjMYnLkaOuWnLNOmdkyPrIKhINjmof5ET3luasRm8FjfSYyINphoaLkMWlfMyD33QjLBfLcZFBhVTtmxm1ChxyMxoT6q5c+tdBo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN8PR10MB3634.namprd10.prod.outlook.com (2603:10b6:408:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Wed, 3 Aug
 2022 00:22:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 00:22:12 +0000
Message-ID: <e9c54ed3-7dc9-e185-491c-aca6b0afe244@oracle.com>
Date:   Wed, 3 Aug 2022 08:22:05 +0800
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
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13fbab53-183c-428f-aa6c-08da74e63597
X-MS-TrafficTypeDiagnostic: BN8PR10MB3634:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhOhvltX7Qe8a0I4E7lkK7ngG6UBT49v2MwkZiZnYmobTXOH8swOLi5IlJBubfBMGFq287zlOI7ivO2G1pfNQ1V0KkIWf/Y5cds2YkfEXuBhm6/UexB6upTpfRTftKEgVQKhBBmgln71T+vtgrkg5X977h9avCWL2Mq8bZ7q9zkuZeDrRB7w92yHWWvllq0ADMMLBYa0lmja6Z2O0IpI4gb+BjG6E07kI4eNKV1jf233kn+GcJgkDoNkHEPbdCyr5XnlGzn9jI/wzJ0/mqbbLCsbFGBvWLXYLcM90cBn15Aibd80K4qOys/c5rf4bqjWGLZGxK9XzxteJ+fJc3CdIfghVQ3LL/2b5zgcxR4wMHOjDArqH7BJFsk/dNWy1aeh8F5hxeYoqYYygaQaEYlVTO2+v991oPQSfOk4U+U6InbwGBAHiCQzMsCDpCke6fDIar63FFrnvxPi0lcPAxngicyVqHPpD/RPlRh/A3c2LE1H7J5Y0Xkdn5Ei0sl9S1GHntUYOEPDWTapcD1ByV7/HHpz5akPCDnl+KO6KgDQC1GjKCYnYX9a7jv9DM9ksI5q+2q5cBCmpyqZjplLDb/247vRT9PBln627IKN5qOueztXEa6iKQUJ4Lmia+yHzs8QMCdL7KHiBdayr44FqhAukaPqdUj8/tVxLhb3WjI4i5Kyi1RXqQtIkKo2WiKICDn0spgV0yqHxfjt9yMydZmjPM+G7iMm/NoDdxYglaoyGNk2BcOpHx9nowuU2qvLc38eJkjFLGaVAC2Yc/gtBCvQIx5OJfuxwubQiLY6ryZ+fboVKU3YEQKP98eb7wyQfNiscvdQznU2WEoIWaWwuOz0Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(376002)(396003)(136003)(186003)(41300700001)(6666004)(2906002)(26005)(6512007)(53546011)(2616005)(6506007)(31696002)(38100700002)(83380400001)(86362001)(8936002)(6486002)(5660300002)(8676002)(66476007)(36756003)(66556008)(66946007)(478600001)(316002)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFN2OVova25SbHd3UWZReWExREdMN29jWjloU21COGM2SW1jNjhkSXprNUxq?=
 =?utf-8?B?bm4vcTdYSVpWa0xIQ20wTi83dzM1RElZTWZUTmdWZWdTUW82WkRPSkJheU1w?=
 =?utf-8?B?RjFvY3Jacnd0WDhLMzdwT1N1MFhMNTNJRUQvbVlMc2xBN2ppQnRoaW1CcDdC?=
 =?utf-8?B?dVZ6aCs5RS9rZDFycEJscGxwUmcrL2hGTUM0ZUZEZzM0UGU4d3JVVU1ZZHRV?=
 =?utf-8?B?N3poaEg3ZTh0QytiUTVvTmJYekZhV0x6UWlnUmdlVm1IK2lhU0FVSFFaL0Ji?=
 =?utf-8?B?WVI1WG1Kb3huZWd2M2s3U1p1OGZQQkhWK3d6NXJLVkNxUWxkSno4aEVyYnlV?=
 =?utf-8?B?QWdyOHJXUzc2QW84TzBZaTF3dndJSFhKYnZWRXhwVGxyRDlnaGw0UzVZUkpI?=
 =?utf-8?B?V0gveHY5YzdnVWJtaGRBNnVtT0VXQjBlcXV6QlVzdXkzZGJsKzllNmFNc3hq?=
 =?utf-8?B?UFdITHBTSGRSaW5VclJjMEpiTGllM1hDTCs1SHZBMWE5N1BvQ1dOaEVDYUVo?=
 =?utf-8?B?VEQ4REc5WmhqQ2lwSVZmWDBnbmZzOGgxQnQ4NVZzWm9zODhVRk1lSHB4NDYw?=
 =?utf-8?B?ZWhMUnovRG1uaHhUdHRTL3pYL2FZUG50SStkaTJjS2tXOERXT0ZMdEVmQXhJ?=
 =?utf-8?B?OGpzd0p6cTQwUEV4VXR1MDViOExBRk1GNG0yUGFuY29JZHNIWXo4MW1TYTlH?=
 =?utf-8?B?bWRSS21qL3J2ems0Z053QVpKYjRIYzYvZjB2VlUrbUF2dVVQd3o1UlZ6OG9L?=
 =?utf-8?B?NFFWZytRVHJQZ2J5eFArRWoxR1ZJL2VaNk1OdTh6eGV3YnNNbCs4R3FUemNq?=
 =?utf-8?B?UlpQUlVCbHZ6dndqN0lVRWlnOWcyOWNKUXQ0eVdBM1NveCtVaHo0TWcvRkh1?=
 =?utf-8?B?cG10VzAwQ3VkU2pmRHlNYlhyTzNtNUx4c2ZwSWQ0NkdZdkQyVVVSeHF3TnN2?=
 =?utf-8?B?MFBFU3RudGRRdzE0eHoxWFhzcXVVZTJFWms3YVRUVTRQYnlaZDNWVE1ESlor?=
 =?utf-8?B?S0syK2RMcER1Q3ZlT2IrRzhGZWJuam0xOFZqelR5NjR3Q2lvUGJ5TnVjaTBt?=
 =?utf-8?B?aWdUQzRUczJnYUtFVDNNYm4vVFY0M2w2czBSd2JINkUyYjBKbEgwekl0SjY5?=
 =?utf-8?B?VVZsUlllaEs1a0NBY3ZmcXFubTJMSlJIQ3A2MWQ3ZnNXdHQvc2h0dGhlRmlU?=
 =?utf-8?B?NU11L1kyMXBFdG9yZU5BV296ZkVQNmtSS1Z6RmxvemNIZnZBeVo2LzAyWGJX?=
 =?utf-8?B?aE5aMlRwZUFZMU9Lbll2Ni9MZ1VsR21zUVBicDVoN3ZEMlhDMTZuMTVsamVD?=
 =?utf-8?B?YVVHWjZtV0JjRTZOZmpKbUxiMTRvbUJaanNQWU16OVAzSEEwdllMUzJoS25u?=
 =?utf-8?B?OFREelBocmhPU1JCcHNOU0dIc1ZmOTRtUEJuTURHOXlad0g1b2NNbFptNWli?=
 =?utf-8?B?clpNWjdLOGJuZHBEWWpKK2lTTnpybnRhNVY5TkdyR3R1VCtyRDJsc1A1UHlB?=
 =?utf-8?B?ajlQNktrV2VocFFOUjB0aE5zb1hJWmlzSUVHeHVrbjM2NzUwdWJPV0hkN215?=
 =?utf-8?B?M3NwL2l4SjdKRlc1bVJPSTlWY1krRnVZd1RIN2pIdWVDWURTVEt5UENYbkM2?=
 =?utf-8?B?dzZ3NXZNWVBqbkhsWU5MQjV4MXNORDZaYmZsZC9LbkhIUkVzN1ZOSUdUaWZs?=
 =?utf-8?B?dXhQcmpDN29wNGY1TEZZeks1YXZPSGl2dVQrVjFUSnIxVlJYeXVuVGVVaGd0?=
 =?utf-8?B?YjZzT1F6YndHUVI4cmhUWTVVcmtqVlF3amRjTnZnbHd0RHNwVG1kak5Hb29M?=
 =?utf-8?B?YUUyU2tDUEJUaVJUeFJFNnZEenpmalBoN1lNRE16YldlRUh5aHpoSVNFaDBL?=
 =?utf-8?B?Nlc4NDVSUDRoZFczYU5VSld3Z1UzbUQrZCtya3lXRWUxcTBtelc2NzY1eTVO?=
 =?utf-8?B?SGsvRmNyZ0VMdGtyTXRwNVM2a0NIcHl2VmNSclo3U3Fabm9tLzBDVy9lajFL?=
 =?utf-8?B?MHEySFNkUmVTcHJkdE43SjFBSHZkTzY4ZzV2ejRIZ1RSU3VidmZja1hrOVBh?=
 =?utf-8?B?dWpMSGhJcG1DakVCUzVDUzFCYW9lR1I3Q1o3UTEwMmw2UG4yN0ZTYjhoYWFY?=
 =?utf-8?Q?6teLSw0Gs13dq4HdZrYNgJI7d?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fbab53-183c-428f-aa6c-08da74e63597
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 00:22:11.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuje/iwxdqOzmWzBT4yIXf8USVk3JuWqHlJw9y9Al+XyCVOEIe0j0whM0lfakMgdHdayVH8qzcXAcVpVjvBUTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_15,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020115
X-Proofpoint-ORIG-GUID: EdaxKR79oUUg80pu6lUmaCD0UdaFGbKb
X-Proofpoint-GUID: EdaxKR79oUUg80pu6lUmaCD0UdaFGbKb
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
> and the crypto module implementing it.


> In the scenario when there's only
> the default generic implementation available during mount it's selected,
> even if there's an unloaded module with accelerated version.

> This happens with sha256 that's often built-in so the crypto API may not
> trigger loading the modules and select the fastest implementation.

Hmm ok.
What happens in the scenario if the accelerated module is loaded? Will 
the crypto API use the accelerated module?

- Anand

> Such
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
> 
> The crypto shash for all slots has the same lifetime as the mount, so
> it's not possible to unload the crypto module.
> 
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

