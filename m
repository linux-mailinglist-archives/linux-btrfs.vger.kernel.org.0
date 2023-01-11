Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C846656EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 10:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjAKJHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 04:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbjAKJGf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 04:06:35 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE2140BA
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 01:04:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEdeG21wPWSjUXWV4p53MMODqU9gQyqeBatMiMRoH5/MlzuxWthLbR1FkG7wxuYjk/paeNyuxvWXIVyniWz43QkIk/QBhEufbDkvIvQotoUCALq8oeV0wsnV06aH0mzZgNymbgPdzNGulFNS1I9wL82BvTODXSOOrZ4UHnKnJ7hDgcBBsClntjZhfdAUlaTnXQzWnFznt/uGjFCXkkpthTsO2mvOrjhTYOM/1eLBgc6FB8oE0P393QDurklyepnMEnQfzD4VdIImns9H2nGfXpHYfiBPSXlgR5StsOVvbd3GZDzmhBm9Yfi83lz9B4wYF4Y0OPxD0DKUJpHWkhiD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTWV74wa6NqU1nHOGm/tbscZTgREcHtSSbrQn1WpAC0=;
 b=GIR0O8f0MOezajFw1XIbexIjuE8rhmFFzpVmuB0nDrEy1gl06glazVLzvYlb5210wv5/y109MWi2L60G8mWRUs93pVeocyElUD0Ck3Oq87j8AQkJWMU9hIBPAuI2+eBSdJkzl5+bQdT8zQPzA1QPKBim2XwuxDPUBjlfFvxBuXDCGXt4Gk6gN09AqU1Np+CRpp3iLEp2NzHFWTIQayvo9Rlo2h11PAKz7Ly2c2P3MmbRWMG1l01pL+ZlCDfxnwtr9elJIjQg36abEsRBgWR1Fi1owuMQg8FLi/gDC1fXHHknDDjT+dQBiPJZALZ7/9WagE0XRDSrLKi7Tm1aMC+ySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTWV74wa6NqU1nHOGm/tbscZTgREcHtSSbrQn1WpAC0=;
 b=25x5eOgyJFnW1TjaCX02QLDxuvzMkvVWRVnndhky215DQTNkZJxu8Ab2CbnAdHHEvCfFb7Gc9Vg032AZyXUF0WvNarKI7knpfVsdiWdSr0DXL9SlcG5KA6te8LsYYgf3VAYG0dgPZp0HZ0ZIQajBZMrun+dwfcGqJ+0Qo8KAKFDkCmyDaEf6h4xM9Et0v5mDnVO7OT5j/+RfLPB4ytPYyMUQJWNTDdTHoVe2o90IkQ7YZfrjndWRSCtOtYekkHT24/aqzAQRgaqeh+isHB9jHPyv+nGvKdZwO7bKNMGKlOFgtoyF+DQMJSN+YVeefePF2b+48+WyZNrcUthHp5qQuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB8PR04MB7195.eurprd04.prod.outlook.com (2603:10a6:10:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 09:04:13 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%8]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 09:04:12 +0000
Message-ID: <3dbc53a4-b896-5eae-bac0-8903675d1a01@suse.com>
Date:   Wed, 11 Jan 2023 17:03:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
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
 <c9111b56-6c85-e40e-2e73-237ce3c27c6b@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: recurring corruption with latest kernels
In-Reply-To: <c9111b56-6c85-e40e-2e73-237ce3c27c6b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB8PR04MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc9d77d-45dc-4c26-7dd5-08daf3b2ce96
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmA+PdR7SToRNgaHGmULZ/1OmtO90Ng4eZgn6dPw7nYxcnwwziJiQoJZbZKKwoGBZ0VuzerSA81jnU2OxKzgdk/x6G2UnleEJGeapk9/apKdfaG/q6oboh4qQjAsd//iXlf+V+EfsCG3yZLYUsUGV7pszqz+jJq7rCuaMl+Y404C0EfB1hpe3p4s//jm883vzxmZdG2m2bonAc8J01GqUj/JD29QuxaD+VGODK9Wx5jsj+J39fyO9aFRpby8XJARfmzlzCvd5bpR4d2WAtKHE7rWzodj0+uLT50kRab6M9NTrLqiE1STQOLEHOvBs1kiYBTn8zMVZ0yp72rUEbnn8DtjK7UKZG43c82vUM9YJ+6uhxvdPr5+AYMwBbm3jRHw5PkGHzwRBV0Kx/KYABwfV+BqvUY4qiuKzq1oV+wFmEY1jwF71/X1yzJxd/jfMOS2zljZXgy87lHZS1fKKW8gYw9Mf95BCVM3vAE+9W376oxj6AyLX3DUl5wjQxYrNJ+H6Hjf4vFLTIg21SvWoC3U8QB6H55z+wLH5aZVwmoSN1tW/vXGy0a08ZF35/MgqIqwJH8lOz8pUvOU0WVpvPfLx/sZXZawyuJDZ7OggXB1MahSYDT8KfHVbAuGlU6weZT2sa1EEk6oR5wtATxawcLOkwNUgkwY9/FzImUHFahA318ihyjD3RCEOpM2BgrYzDesOzD6t7AQhZLyhj0RiV8kVl7j4cr9vs6rY0wDrfRiBRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(8676002)(66946007)(66556008)(66476007)(316002)(110136005)(2906002)(5660300002)(8936002)(41300700001)(36756003)(53546011)(83380400001)(31696002)(6666004)(6486002)(478600001)(6506007)(38100700002)(2616005)(6512007)(86362001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFRDK1FFNzk4aTVsamplR2ttT0xwVHRKQTVsWXduZllTY0Q4VWxEQ3FXTSt1?=
 =?utf-8?B?NWhFK29CVFVyS21TYXVxSUdNMklTc2x2SzBiWC9HMW5YcW1ubnhTNGY3ZDNj?=
 =?utf-8?B?QVZHbXZjUEdoMUU4emswN2FTQ1NtM1JkR1hpNTlBNldMbkwraDFIZmNFWkJS?=
 =?utf-8?B?MHdBWWJjWGFPOGxjRHljTjBCVGtycG9MRGlFeXBiRjRpOG9Xai9yN3lPeGF5?=
 =?utf-8?B?Q2NrQUR1RFQ5cU5jLzQycUN3VDlGTTNFUkd3NWRLMlR5U2Rnb1ZzemliS082?=
 =?utf-8?B?SDhUejArSEpkSWJJNUpIWmt5Ykl4RmxhYm16b3RvUFlGWHVVWHgzRm1KOVM4?=
 =?utf-8?B?WmRYeHZWRDl3SGxpeGZzNGZLKzN0RVZUNVVSSTBzV0JoMXdYYis4MGw5b0hZ?=
 =?utf-8?B?OEVwTklpU3JyUFg1cDhnUU1SNkN4TTF2R1FGZEJlZkNGVElUVi8wNFlBdVZY?=
 =?utf-8?B?eXlTRCtUR2UrL3ovOGdVVy83SDBrTHMxSmg1ci8xQjBGY1RNR2JJUldzd3dY?=
 =?utf-8?B?ZVdOa1pQODFIU1VtZytjc0hSZzJldzkveWNOeStSK1N5TG5kdFVpVGdsUDFN?=
 =?utf-8?B?bXdPbVJxazRUNDlnVGJRYzRyRmdLeGNjM2FzdDdzL1pRKzA4MEp6cU9SOWNC?=
 =?utf-8?B?QW40RGdabEdaVDV5S0Z2WFQyRnROL0pxTEJ6L1JsT1h0M2FRc1pBaHJmU0pm?=
 =?utf-8?B?K1Y1bk1XcHErYldSYWdtakQxcXVzZmhRY0h4MlB1UThtRVQ0ZXhuanhEME5X?=
 =?utf-8?B?V1dwNnd3TStOWDNJQlhSak1sem1yc0xiU29kTWFzQ2ZtVnNqRUFzU1F5L1E5?=
 =?utf-8?B?Z1BSQ0c1VGNBNy9BTy9WcCtyOEtLSGZHclhjZWRtRWR6VVJDMDJyTEliQ1pO?=
 =?utf-8?B?TU9lWWhYeEFTSVBkRC9NUVdBZGw0N3NGcm9jQ28wSnR6T05reGYxYkRBY3BK?=
 =?utf-8?B?aFN6dzBPUFRKK1JGdTZjNVhSbHdaNERNNFRFNGVEc01ySVV6M3hLMjlLd3ZQ?=
 =?utf-8?B?MVZ2bUZXTTVWNnN0TlFSN2VMSlFZeXErRzNZc01sZnhkcDZ3eDhNNVNWa0dR?=
 =?utf-8?B?M05BZUZBUzVBTFFKODg5RG4xMGhFWitpK1RKT2FBdEcrVkQ5UDVOdDNCN0lJ?=
 =?utf-8?B?SExwcXNCTTdSSnlsUWdoTkFhTkRMSTdGbjZsUFlnTzdxTzBCSEZjMVZNSjJZ?=
 =?utf-8?B?aU45UHQyclBGWWVpcUJWdU56b3BPZTIvMDlsQUR5Q01EZEV0Q3MyVm9raTBP?=
 =?utf-8?B?UnF2c3IrVkRIK0laUmR5SVV2WHp4Q1ZBVDlwQ0JNQzBzcW1DN0p5TlZGZXJZ?=
 =?utf-8?B?aTkvWnc4dGZld1pkS2ZqTjRXUFVTY1E1WGdzaE0wSFZ6TVduWVJiWTNGellS?=
 =?utf-8?B?Mk9LWjNkOFVSK284TEd1Y2tqc1VsSzNQSkwvcUpaUzZnT01XalI3T3lmTXFs?=
 =?utf-8?B?clFNeDhOZzhNZEZac1hJQ3ptSml1Qjd6enFkL3FiM05UbnRVSTZuSk5ZYmNT?=
 =?utf-8?B?em5Ra2hCTSt0QmhtKzJid2N1WDVBazhzQzZsNUJLUFJPU2tKSG1NTkpJS2VS?=
 =?utf-8?B?Vkx6TFVYbnUvVWx4enpsM3FPMGw2S2dDdXdkZytLL2M3Qmk0SEhUNERSZDJB?=
 =?utf-8?B?K0ZrQW4vbXc3bDhkNHFURHJ0ZzJoRHNwT2RpcW13UG9SZTFZaXFSQ3BsOTE0?=
 =?utf-8?B?RHZSZjNZY0JLZk14Y21hZzQvL1dtTzcrVVlaM0RCSm1ud2lMY3g1UnBiYy9L?=
 =?utf-8?B?emtCR0srY2FWTnpjVForMFIrNGxrV2FSL3lvdGEzdE5NSldSdU1qWi9sMi9a?=
 =?utf-8?B?RzVpQndCNkhyMUhRRlh5c0U5REpUVjNzL1dkNk56NHpUWm44RWtHZTBqQTZv?=
 =?utf-8?B?VmtMWVk2Z05uVjlhMEpEN1N4bFZtT2RtTXFSdXBxNlAzemhCZlJ0Mnp6bU5F?=
 =?utf-8?B?ZnhSd0NSRmxTcDlzYlZFcEhtbDRMYzRiVHdlRWNZc0dDZ1VHelIvNkZEUCtP?=
 =?utf-8?B?VklZd0s3SUNIYy9KTGdpc2NnUG9jbHhvdFdvWmp2MllhTlRPdDZVMVNwS3Va?=
 =?utf-8?B?ZHR6c2RraUFtVkpEaEJ0UWRzMmRpZGlJR0RPV09Renk1blNXSzF2TnNPVzla?=
 =?utf-8?B?K3pBaDNQakZQbzVMM3R6RHYrUERVdmUvalhMTWJyNUYxUEdSVEY3MmVLN094?=
 =?utf-8?Q?w5AiUmngyHtKPOcRl4ngsYM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc9d77d-45dc-4c26-7dd5-08daf3b2ce96
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:04:12.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gE06hh15FL9cxZ/FOKgimceOFWYYYzN/1nFhdO+zlxnqYjDrI6qWZpaD8X+1TcBw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 16:44, Oliver Neukum wrote:
> 
> 
> On 10.01.23 23:58, Qu Wenruo wrote:
>>
>>
>> On 2023/1/10 22:42, Oliver Neukum wrote:
>>> On 28.12.22 00:20, Qu Wenruo wrote:
>>>
>>>> --clear-space-cache is an independent option, no need to --repair.
>>>
>>> Hi,
>>>
>>> I tried that with v6.2-rc2 now.
>>> It does not help. The corruption persists and the fs tends to
>>> go into read-only.
>>
>> OK, it looks like you're using RAID0, which can cause false level 
>> mismatch error (without any error message).
>>
>> Unfortunately the fix is only merged into v6.2-rc3, not rc2.
> 
> Hi,
> 
> so I should test with 1d854e4fbabb0cb12ca4a7fcd784eb67a65de5f8 ("btrfs: 
> fix false alert on bad tree level check")?

Yes, currently your log shows no obvious errors (except the known qgroup 
warnings).

Thus I'm wondering if it's the level mismatch (as it doesn't output any 
level mismatch message).

> 
> As far as I know I am not using RAID 0, but apparently I am using
> snapshots as a root fs. I had not knon that rolling back an update
> would carry those long term consequences. mounts:

As long as you have already tried "btrfs check" from an liveCD, then you 
can rule out any on-disk corruption.

And since the false level mismatch is the only thing that matches the 
symptom for now, I still recommend to try that fix first (better go 
-rc3, which has extra error messages to help debug).

Furthermore, if you can still hit the randome RO flips, I'll add extra 
debug patches.

Thanks,
Qu
> 
> linux:/home/oneukum # mount
> proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
> sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
> devtmpfs on /dev type devtmpfs 
> (rw,nosuid,size=4096k,nr_inodes=1767591,mode=755,inode64)
> securityfs on /sys/kernel/security type securityfs 
> (rw,nosuid,nodev,noexec,relatime)
> tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,inode64)
> devpts on /dev/pts type devpts 
> (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
> tmpfs on /run type tmpfs 
> (rw,nosuid,nodev,size=2837632k,nr_inodes=819200,mode=755,inode64)
> cgroup2 on /sys/fs/cgroup type cgroup2 
> (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
> pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
> efivarfs on /sys/firmware/efi/efivars type efivarfs 
> (rw,nosuid,nodev,noexec,relatime)
> bpf on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
> /dev/nvme0n1p2 on / type btrfs 
> (rw,relatime,ssd,space_cache,subvolid=266,subvol=/@/.snapshots/1/snapshot)
> systemd-1 on /proc/sys/fs/binfmt_misc type autofs 
> (rw,relatime,fd=29,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=785)
> mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
> hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
> debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
> tracefs on /sys/kernel/tracing type tracefs 
> (rw,nosuid,nodev,noexec,relatime)
> fusectl on /sys/fs/fuse/connections type fusectl 
> (rw,nosuid,nodev,noexec,relatime)
> configfs on /sys/kernel/config type configfs 
> (rw,nosuid,nodev,noexec,relatime)
> ramfs on /run/credentials/systemd-sysctl.service type ramfs 
> (ro,nosuid,nodev,noexec,relatime,mode=700)
> ramfs on /run/credentials/systemd-tmpfiles-setup-dev.service type ramfs 
> (ro,nosuid,nodev,noexec,relatime,mode=700)
> /dev/nvme0n1p2 on /.snapshots type btrfs 
> (rw,relatime,ssd,space_cache,subvolid=265,subvol=/@/.snapshots)
> /dev/nvme0n1p2 on /boot/grub2/i386-pc type btrfs 
> (rw,relatime,ssd,space_cache,subvolid=264,subvol=/@/boot/grub2/i386-pc)
> /dev/nvme0n1p2 on /opt type btrfs 
> (rw,relatime,ssd,space_cache,subvolid=262,subvol=/@/opt)
> /dev/nvme0n1p2 on /boot/grub2/x86_64-efi type btrfs 
> (rw,relatime,ssd,space_cache,subvolid=263,subvol=/@/boot/grub2/x86_64-efi)
> /dev/nvme0n1p2 on /srv type btrfs 
> (rw,relatime,ssd,space_cache,subvolid=260,subvol=/@/srv)
> /dev/nvme0n1p2 on /tmp type btrfs 
> (rw,relatime,ssd,space_cache,subvolid=259,subvol=/@/tmp)
> /dev/nvme0n1p2 on /root type btrfs 
> (rw,relatime,ssd,space_cache,subvolid=261,subvol=/@/root)
> /dev/nvme0n1p2 on /usr/local type btrfs 
> (rw,relatime,ssd,space_cache,subvolid=258,subvol=/@/usr/local)
> /dev/nvme0n1p2 on /var type btrfs 
> (rw,relatime,ssd,space_cache,subvolid=257,subvol=/@/var)
> /dev/nvme0n1p3 on /home type xfs 
> (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> /dev/nvme0n1p1 on /boot/efi type vfat 
> (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
> 
>      Regards
>          Oliver
> 
