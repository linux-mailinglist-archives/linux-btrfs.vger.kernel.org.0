Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A380665664
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 09:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjAKIpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 03:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbjAKIov (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 03:44:51 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1535CE3A
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 00:44:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKCBDmo+GlG1fMAYMyzcsP4kxQOPX+17fwJqUvdDQx6jab6UOyooFXu+AFGGlUFI0kO899G0jXEOeE7cvUVOD3qaWZS48feJuoyBMJTCYhMKf5+Kj3+MGepjN2WdUkYcDtMYIzSw6STjWQ1QhfmkOuT9t2ndhg8N+aVR3SMNkxVmwqk8r8WozqrQwYO0Iddc5C97pr4ulnmWbp6dyc6D+WyDDDG/ea2/U3esqX0DCaiWpjN3pbZKiWX9yS9JavoNDcA1IayP6ek6ZoN3ht5kSBXiEi+OhjQsQjkE7yff5UlK23gfekcgmjukncZrJbn4PGh1nwGCRmJ0wpV7DqxrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qly3BC6PwN4wrITskC4pGbnWO6FYJaAzsrdWB6CpAN4=;
 b=ET70ltRHHkGl1EsjjuGCZaMfoonVnoKS1Qj1DYxApDGLwERI5zM8it0kTnI7KLGG3KI9cpjnw7CgjSxgTlJvRbg5Bwa7578mRbkMoVAdjiB5KcCtrb+GVG+GTGkFCjdU9Gw9w+tQLyaaOtWc9abVV93Wh+OdqCjTAXy3JY1AS+H1qMyVngQUhP1iHiURZYZyE/3wHb78k2MmaWu9YaSJZ/Mzcf1wLVwPE/HyVOdiAKxu6cjWUqp23PV78xgt/WFKIN2US3mzczx0qbVoNpDN/j9cCLAaugc65YTb/ENaTjs1K4P9QglG93hvvX4vxvZsjQcuC1Ikybd7heVPznr/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qly3BC6PwN4wrITskC4pGbnWO6FYJaAzsrdWB6CpAN4=;
 b=SMLnseJejlGvZ9jhuo0ocRQFpKpT1o09LTMcT2jEjCQJpE6YU46KJKOC75Seq4bi/cSs486zdGf1BdqOSYdFoUGJSLkEfNzKXo8fhHi2808GPCjYIzD5dTASSdlaTBgyUJMoM9q/xmHFcgrXC+hTjgQrRYsQjwOAsyowf5m9gZ1Uy0YvegnoPdhgfvBcTXavbcx3qXBkdTpdPuzPxMpjwze3eVouQWTuWZ3KkW9OCDWg5Bziyaw7ZVEdtvMji6s8NG7EwXmSF423/YXSLaTLLG9j9Rcq25e9hE/59VtIwQByiwrIj67YRBKLm+Imro22XJbmC1YTooqzCFtBsuJ1Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PAXPR04MB8490.eurprd04.prod.outlook.com (2603:10a6:102:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 08:44:33 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::8d51:14ac:adfd:2d9b]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::8d51:14ac:adfd:2d9b%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 08:44:33 +0000
Message-ID: <c9111b56-6c85-e40e-2e73-237ce3c27c6b@suse.com>
Date:   Wed, 11 Jan 2023 09:44:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: recurring corruption with latest kernels
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Oliver Neukum <oneukum@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <148b838a-897a-90d6-7e6b-564238d58eb0@suse.com>
 <ddc034c6-655d-c3f1-8d69-544b743b7ac9@gmx.com>
 <3dbe35f1-0815-73d9-f53e-86aacabf13e8@suse.com>
 <4531be20-470e-9984-6535-fd822c6c157e@gmx.com>
 <f6987484-b084-c6f8-31b4-dd2e3f3eb9d5@suse.com>
 <5ce6e59d-6c79-4d15-aa8a-990a299cd20c@gmx.com>
 <8fd4dbff-7d67-00b2-6f2f-7c87efb1da13@suse.com>
 <507d0831-36d8-edbc-a362-323762b9d7b2@gmx.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <507d0831-36d8-edbc-a362-323762b9d7b2@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::6) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PAXPR04MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cc4012-caad-4221-50a2-08daf3b00fec
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2YDeUdF09PGgb9G+Fuyh4SF7Ov9N82i5oIUjHEnFACIOPYrO2EcX5zQiJfITI/8C+WXXzSEMj4us32K3jgi+z6euR96xeC8b1YYimefznA9fIDsb8YQAsjnAsQt4meMHYjcf5lJeCUQllr6AP0rgyM1hxj4ViNeQRl5qwn0jpmClpSXgestDTM+sarmTWRJojyCb2aSM79AsyQLr1NgNF5yLCMerhMnkmSipMZzcO5SL9bwGTjjpvGGBiJqXi7cg3d+ikvMPqpTF8P5TiDkCTLPl3w1fTlk8Oc8tmGMVRZ3MxGf3rY5fKxs07Dtn/jpIk+SMhx2ZxCRwURnmKStl91gY0lmO24/Li9l39+3/U0Gr24dybZkOhQLaw5ArsCD2dxln/vRJZ50oH2cHljilwIln0bwkzc0V+d+P+U6lfFClZ1JYfZBoSnsREc3B1GSc319EbJ0Tidtu5M1zPk2A6F/JPGLpCzhr3COSNhoiPazi6fOTHYJJZ/vPpg8O50ncTLddUloOapX7itX6uL/3jfyOGGY9lD/bwlHBebHF9axlwkd9EDF/j+au2Q2hC2giuvrKF/78Hi/sByB00Y8xcDGXqAvvKIo5GjPQFPCnz4k972CSFNQTqhJ+HUExOiTCX73gRbyfcLQAQ1vJNQgVLQm7fNnel+llYxXixnQPz/7CSgJykf3FOu3s6faqcyaNWr+hSzrpcJ1/qrS2KFAHLXGXXbTFX5C+ZhAu4u3FYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(6506007)(2906002)(36756003)(8676002)(53546011)(5660300002)(8936002)(83380400001)(31686004)(38100700002)(6512007)(41300700001)(478600001)(6486002)(186003)(66476007)(66946007)(66556008)(86362001)(31696002)(2616005)(110136005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T01HWTU4WWltaHRYTHgza21HS2F3WFF1QkswTU85NGZRM29MUjgvK0hJOFJz?=
 =?utf-8?B?d2lIZXd5T28xMzlIUzNrVWY5RENSNElrSTFib0taMFdXR2hSK2FIdHdHZ05M?=
 =?utf-8?B?d1loMW5sUEYwTTE4UnpuSGJxRWpiRFgrUWVmMFNRVG55b3drMklNU2JvUkI0?=
 =?utf-8?B?OWo2NW9uK2IvVmp2SHBWV1ZRb0ZVUkxLVSswMkdCYUQvZ3JLSkxBL1Q5ZjdR?=
 =?utf-8?B?WFBsR0lZNzNreFVoczZCbzRZQ1V6TTA5Q0FFRzVIOWlqNmRBK0JZSmZpTVZ4?=
 =?utf-8?B?bXlBUVZaVGRzd29ZYjhNQWhlTEx1WFNJakxlaGlVNmNnT2s3VjJ5LzU1R3do?=
 =?utf-8?B?bE9EVmh5RkhHSGVMV1ZwUE1zS2N5cUZGOTZybDJORG5QMExNVlBrWUpTTndT?=
 =?utf-8?B?RktXWHNocjFFMzVtY1psNndPMVI5aSttNjFaamExLzViZmxDZHNUTjNYMFFK?=
 =?utf-8?B?dURjWjR6cERJYllxaUxna0JjN25sVWlwS0hRdGxCZW1sbExqeXlITkkyL2RN?=
 =?utf-8?B?TFNNTUF2Q1NWRjk0Y2tteGlXU01YS0tIRHlqMXZPYUxpZUx0bkVOSHFJNHF3?=
 =?utf-8?B?L0lTWDFwNWxuV0NDeDI2UWRCdUhpWmJtZ0ZKZ1lpd05lSkx6MzJEU09oOCs3?=
 =?utf-8?B?TnFPVGlKZEZFMjlzdHJoYm5xNmNKUG5DOWFSVk83cHUrN3BaWS9vYk9UMjk0?=
 =?utf-8?B?REJQREl6TWN5Q1hTcHBqbzJtRFRrRjZmckViL3hXWGdtRmZBVU0rbktPdXdC?=
 =?utf-8?B?bVQzclhiaFlienYxb3FEb04xbFV1MFhaQXR6QW1tYlRWSGcydUtCSkFhRGI2?=
 =?utf-8?B?NUpDTzBLd3BhdlZxVEVtRmFodUZ4bFVQVHVQZ2UwN3RHZXJFWmpmckxlVWIr?=
 =?utf-8?B?eVN2d0s4REx6MURFSFMwRktaWnU4Y1RPV2c0ZVhUOG1iU0tmTjhRREl5TjdD?=
 =?utf-8?B?N295V0FJZ3VCLy8vOW9GL1BYVk5WNlhYQXUvbUl5TlltS1RKOWZsenBLNEZs?=
 =?utf-8?B?c3dWY0dQVEJlMkRES0lkRkNPRmR2T1kvSEoralFtQ3lZNmFVcFFLZnFLSkx1?=
 =?utf-8?B?Y0xuQmU1NURoek5mbTE3REZ0WUR3akVBd0wxbFNLQVI4MW1YejIzL1dRYXV3?=
 =?utf-8?B?WUIvUVB3VHBqOGlkYldzazJwNUhIeDlSNVNPV1NRU2QzemxNT0JuM1NDYWNh?=
 =?utf-8?B?WGtjZGg5SHZaZDgzZmFmbXlIdktPMTMwenROWFlVa0ljZXd6KzhubGQwUUh5?=
 =?utf-8?B?NmRVMllJZUhVSTI3U0FNUWdOUS9aUHBpZTBkSGUxNExtem1MTUtmNUF0WndF?=
 =?utf-8?B?eWozWkJTTThyZjVhQkdtRVZiSGV5djFHMmpOMUV4dU9NM3J6YzVJU1RmNXNn?=
 =?utf-8?B?Q0xJalcyYy9UaS9hTldWNmE0WnFBbVY2OUdXTmI5SFBkRjZTMi9vNWxqUGVZ?=
 =?utf-8?B?dUN3K2hJU0dzME9ic3ZMVWg2cHR5bzJrVXEyN0RKZDdKTFpHa3FrQU11bnAr?=
 =?utf-8?B?L3c2dVBjZzV0cEpyWHpCaFBFWEh5Sm9paVFra1VjRkZmRDhnc2Fzd0loWFFI?=
 =?utf-8?B?dW0zeXRaSTZFS1k5SkFneUIvUjJCamtEcHpKeStzaEEyUDlmdlBXQSt2eGNI?=
 =?utf-8?B?T0UvRlEzaDU0OUhxL1NreEJVVURpQm9ScUxOWFpPTk92ZTA3TUJ2aUluV2o4?=
 =?utf-8?B?UWZGcGdMS2tWSWE0OFFkeXBJamV1czloOUlhSWJaZ0ZDejN2ZjJSY1A0SlBY?=
 =?utf-8?B?KzZUY1UzdkIvN0JBRFJOVzlnN0d5dUthN1NMSjl6RnRrOWtOekw0SlRlMzNE?=
 =?utf-8?B?UzRpRTQxSEM3RW5LK1EyaytFWm5xR0VUZVhDVmF5cXB5VVJ5Vmo0Y0xsT3ky?=
 =?utf-8?B?bXJlc2VNeDU4aWxuUlZQTW02VndQWHg0c0JNU0hIUEF1ZXNjeTExK2o5a2FU?=
 =?utf-8?B?dzZPS0dKMUloMk5lM3o5Q1REalpiR2IyaDd5RGZmdURqRGhxaCtyK2NDVHJG?=
 =?utf-8?B?VmwwZlAxaHpVWnBnRFV3WjBoc3hxQVBkc1U5ek11RjRoV010L1lkWjFtOUUw?=
 =?utf-8?B?cTc5MHFBQ0tCMENWK00zWmc1dS95VnNNWlJrc2hmRW91V2o2cHVRSjRESUZX?=
 =?utf-8?B?d2hFeGFFUElVTEd4R2hSZVNUWmpFY2RVMnYrbWhlT1NmazNxOERvRGpuT0M2?=
 =?utf-8?Q?xcif9UF+DjkS9A1vzQJpWz74G17nqMGDgS6OhT7jPtit?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cc4012-caad-4221-50a2-08daf3b00fec
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 08:44:33.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBxdmB+Tu3QXTlEccWAWHuzvj+bgtvIHdXDf79wHG6z5TBaSnILq3LMlL1QWw/F6UPkZvOzHSAktD9U94+zIIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8490
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.01.23 23:58, Qu Wenruo wrote:
> 
> 
> On 2023/1/10 22:42, Oliver Neukum wrote:
>> On 28.12.22 00:20, Qu Wenruo wrote:
>>
>>> --clear-space-cache is an independent option, no need to --repair.
>>
>> Hi,
>>
>> I tried that with v6.2-rc2 now.
>> It does not help. The corruption persists and the fs tends to
>> go into read-only.
> 
> OK, it looks like you're using RAID0, which can cause false level mismatch error (without any error message).
> 
> Unfortunately the fix is only merged into v6.2-rc3, not rc2.

Hi,

so I should test with 1d854e4fbabb0cb12ca4a7fcd784eb67a65de5f8 ("btrfs: fix false alert on bad tree level check")?

As far as I know I am not using RAID 0, but apparently I am using
snapshots as a root fs. I had not knon that rolling back an update
would carry those long term consequences. mounts:

linux:/home/oneukum # mount
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
devtmpfs on /dev type devtmpfs (rw,nosuid,size=4096k,nr_inodes=1767591,mode=755,inode64)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,inode64)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,size=2837632k,nr_inodes=819200,mode=755,inode64)
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
bpf on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
/dev/nvme0n1p2 on / type btrfs (rw,relatime,ssd,space_cache,subvolid=266,subvol=/@/.snapshots/1/snapshot)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=29,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=785)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
fusectl on /sys/fs/fuse/connections type fusectl (rw,nosuid,nodev,noexec,relatime)
configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)
ramfs on /run/credentials/systemd-sysctl.service type ramfs (ro,nosuid,nodev,noexec,relatime,mode=700)
ramfs on /run/credentials/systemd-tmpfiles-setup-dev.service type ramfs (ro,nosuid,nodev,noexec,relatime,mode=700)
/dev/nvme0n1p2 on /.snapshots type btrfs (rw,relatime,ssd,space_cache,subvolid=265,subvol=/@/.snapshots)
/dev/nvme0n1p2 on /boot/grub2/i386-pc type btrfs (rw,relatime,ssd,space_cache,subvolid=264,subvol=/@/boot/grub2/i386-pc)
/dev/nvme0n1p2 on /opt type btrfs (rw,relatime,ssd,space_cache,subvolid=262,subvol=/@/opt)
/dev/nvme0n1p2 on /boot/grub2/x86_64-efi type btrfs (rw,relatime,ssd,space_cache,subvolid=263,subvol=/@/boot/grub2/x86_64-efi)
/dev/nvme0n1p2 on /srv type btrfs (rw,relatime,ssd,space_cache,subvolid=260,subvol=/@/srv)
/dev/nvme0n1p2 on /tmp type btrfs (rw,relatime,ssd,space_cache,subvolid=259,subvol=/@/tmp)
/dev/nvme0n1p2 on /root type btrfs (rw,relatime,ssd,space_cache,subvolid=261,subvol=/@/root)
/dev/nvme0n1p2 on /usr/local type btrfs (rw,relatime,ssd,space_cache,subvolid=258,subvol=/@/usr/local)
/dev/nvme0n1p2 on /var type btrfs (rw,relatime,ssd,space_cache,subvolid=257,subvol=/@/var)
/dev/nvme0n1p3 on /home type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/nvme0n1p1 on /boot/efi type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

	Regards
		Oliver

