Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A1E6532D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 16:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiLUPAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 10:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiLUPAS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 10:00:18 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D72BDE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 07:00:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4dDQvDSDXChWtoXBvpdVbFKYu6gy9ilH9yGphbCVvHSy8YMIUf4wmjPMNzwehPPo3VeviuK/mKjtTk/1VIa0BWNb6XfWEBV6ZC0IPprnYd5b97xRa2TeH+Dv6zJFI2F3eMwNwA/w0o03u6ixDOe5kaBwLa5fg6O84heAY+Vi2g47G8nkl1SPtjbGkqMVSxxmkcsP4dDWCMLfQVStYJ8gp13mRgmzb9fDJALjs4hmHUO21PV5cEDl9ZlCS6vwYdNYOgxhVHQ/5hqwDluXgW/tVhDfEEFT7U+gmorOYoi5PHKWy4Rh6TYxarg3inYDawFCwnfp9a4v+hkUJj4RuvSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR3Iq1edINySHiea9Vav4Ooan6Kjx93nBhXm/kICMvY=;
 b=c2EP/utPbY3NW7klZvWplSPO9Olhe4SwNFlXblAg2Zz7HG8q7+1nuKTvk+/BncakpBZ+klRrnvMUnRV3Jl8bpGDQVdpe3wqR2jB1E4nGpxqku5lZKYXCZCJiS5yinbKRl79EzSUNVHH8mJkZ0CQQAyMVnJbdSL7xkyy4GJyERZSkTzfFgLnESA79fHn36RW+5rxl/TKY553oljJDRETc4fwOwUs5QU5grDelcN8mRNtw3IeDnTL6oxeSW6EW8ztBrfXi3Stvx0eYI2OY9jZ5Nn3WrhmKAJavpt280yHYFptq7kh6w8mCmG4G+CpT6707m9NvTvScnbWIxaQBGiKJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR3Iq1edINySHiea9Vav4Ooan6Kjx93nBhXm/kICMvY=;
 b=ODXoumb7uF1C6eaG52d/oEwIPKj3+Oh+ROKjAfGu7NEALrbU1tyRcuGZ/XLpF3//PsYCvUWd2Kgo8ktHt6G6AzW74uKidXaAoNKg/O+i8rgSsFLbZyqku2BKGatcLIGhCclTpXR0Q38JgEdXN/wJ3V/bHQR39yO7wQOET5+0GZ2zIK5p4TAM4g26DBTT7PIH8dQse11GoADiE6brKn1exLhSHCQZ8W0lUrodLWeppooYmIO5nJmlQJMb/gBqSeGwcZQp8cHjxXXJo1nnzvJbf8edPldJWyLE24G0AHcAh+8u+aFP8l/I8SwMFmMWpw+h7mhPayNmxit45LaMQmOSwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM9PR04MB8699.eurprd04.prod.outlook.com (2603:10a6:20b:43e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 15:00:06 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::8d51:14ac:adfd:2d9b]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::8d51:14ac:adfd:2d9b%4]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 15:00:05 +0000
Message-ID: <3dbe35f1-0815-73d9-f53e-86aacabf13e8@suse.com>
Date:   Wed, 21 Dec 2022 16:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: recurring corruption with latest kernels
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Oliver Neukum <oneukum@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <148b838a-897a-90d6-7e6b-564238d58eb0@suse.com>
 <ddc034c6-655d-c3f1-8d69-544b743b7ac9@gmx.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ddc034c6-655d-c3f1-8d69-544b743b7ac9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::17) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM9PR04MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fb61fa-87b1-4a65-b5a3-08dae3640b32
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6t7VMEsT768j2dEuptkEA085eShtge1k03IzNGEDfYXRoLYMl2NEPB+IFg1ghXNMlZOSTCeohXYFqYGMUzT+nK9AzBmG2S0fpfh7fI3WligeNAnhlGzNRd+djpYGJpSsj93dV89bXE59qwOEQIeCnvpOX2jBSdaypDbXlwvtLp5riwEQ/DY3ZaQDH3p0RrveaQjHxCytDLETO7HalGDVy9vAMhgtUyPZX2aw0fyYxL0y/LwNwAw28FNS+Rp9Z7WaJNKFL6VvApmM9VAQAwYTzhOYQRiQG3pH7NqH05fJtguh9c+Ox6u+9OAkcwDDkK15mGgSzjc5M2KbosVb3T1M0cnsF6lhhsvTGM450WUxkHXfZzbm8Nky14jPqN+cxKftZc3sQzF53oN8zJzZnJMYYN66PgJH+tiF4BNKb53OtdD+QOJIVvWi2vQTcmmLz0xoCIgo2ETx9WvKKTMCGc6Euv8C4miMWpWvjzOdu/43z+OnTDwkNDhSuQYgxJDvDRjhVCgc48CThzvRH0CpsrxhbsEmIvy6Jgd0O4koDi1qOE8qAon3TcabAied85OIDrGw5ziNvBvnOupCTDKCMW9eXoXA/J0HYo8DvuCGdnoyAhk/zKOYOyrmIdSiI+5T8nmiXGH6nmnLY4BXzNy7fi93YUGDhKolpQdzZW+Obm+WRmEMBxyLlvq6ibD1oxpahoxxYwccE+b2GEt1Nz7MgeCLnyicprlrmCAExfIX3QwjQddek7Q727WtQv+0CX3VbIzt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(41300700001)(8676002)(38100700002)(36756003)(5660300002)(2906002)(4001150100001)(53546011)(83380400001)(30864003)(8936002)(6506007)(31686004)(66476007)(966005)(478600001)(6486002)(66556008)(316002)(6512007)(86362001)(66946007)(31696002)(2616005)(110136005)(186003)(45080400002)(43740500002)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJvQko4VDJpQzFUTDE1M28zSGhlWGhQaWthUUprdnFJdDFoODZEV3VSMG1z?=
 =?utf-8?B?bkxZTVg0bm1qdGJha0lwWVExcEZoem1FWmMwVGxsVkp5dHdzRHZ0TWx1RU5l?=
 =?utf-8?B?UGJIUUlPNVBTQVRZZkRoSEtoR2I2TXVlYVFqd3dFeEx6SGVpWkl1TFpJbG9S?=
 =?utf-8?B?b3pHMVp5S29Ld1ArdTEzUjZ4V2VWd2JDZ2E2TlFaN0VvMEpsOXVTWnE3VldD?=
 =?utf-8?B?b21aMGJXN21ncm1yNEZwbk9yL1gzUnFpRWViSHFjaTdpbWpDV3BMczREWnNp?=
 =?utf-8?B?MjI1aHo3OWVnbVJYbTJvUGhMclBXZ05yNE9iTFF4bmRTb251U2twZWdjcjUz?=
 =?utf-8?B?OGtZNTJGWk96Rlh6a044SlhiaEZDRHFxWHlqbU5PRDZHcnNlTldwRmVpYjZS?=
 =?utf-8?B?VVpMVXF5R3JzTzhFZkxoY2NwbjJyQnpiM1pkc0ZPaDl5MHI0bGFNRm4zTEtt?=
 =?utf-8?B?R3dxNWdRQ3Yrd2ZMVU9UMitjMllsckZRMWVzeS9yK3V1M3pLY3M0MVNyMkFQ?=
 =?utf-8?B?cHN2dEVNTVpQelRWYjlNcHl3SXJ4bkx3aUNBbmJSVXdhWHlQRlJ1YkxVUDNF?=
 =?utf-8?B?LzU2cUlSaS9Wc2FMRGJkZ080Rms3dFY4L1A2S1cvdnhJRGhjeVBOeGh5QllX?=
 =?utf-8?B?WUVocGdXYXlIWjUwS3EwelJBRDQ4WFNjczZBeDl2SHZMTVJPek9na2F3WkZn?=
 =?utf-8?B?UzR4S1RNL1FjT2Z5ejhKVXpYdGIzSzZmTEpPT2VYNC9Eb1BTNzNsbkZKMGQw?=
 =?utf-8?B?K3Bvd3lWSFF4U3NZRkFPTlAveGpOS0pTWE9hYjhjeXRWU1hXMC9aTXNhTlBq?=
 =?utf-8?B?UDZJNGJySG0ybk9Sa3lpOW5SeDMzM1pZQlhvRkJUbVpoalN6Y0RXVldZNjY1?=
 =?utf-8?B?R05SWXZ2OThpcFBtQXFNd0hzODZhNFVWS3dMU0lpNzNqUnY5a2hiQ2Z6TjhO?=
 =?utf-8?B?V0FWb2wvcFF0WGt0NEJVWklLSHQ4SGJBaXdvdjk5SkJ2MXZaaEljSnRFbDBV?=
 =?utf-8?B?WjVCUVN2K0lRWlhsMmVWWUZkRnE2Slh4OWFxSmlnUTJSc2x3SmY3aE9VWUhB?=
 =?utf-8?B?Z25scFFkZDV1OWh6cFBuelRjT1FpWW5HN0ErUHk0OUwrZ3lEdlJZOHdiRnF0?=
 =?utf-8?B?bi9oTjZIQ0c3VGdPQURPV1gzT0tkVHU4NlAzT0s1TXpKUmVWNy80TE1MS29C?=
 =?utf-8?B?eUh0U2hQUDFONGpMOGlPUGlUZTl4VHhsOTEydFVmVDV4WjJtRDcwSnRIQStF?=
 =?utf-8?B?Y0Ztd2FsWkdDQlRNZGJ0Z3JNZklWSlFFQVhIR05sV3crNVZQM3dlNUtCVmh0?=
 =?utf-8?B?K2VKTUNPWmJ4QXJ2dXNFbmd2cE5OQXFUK05teXJZY000V0dvc3dlRlFRSUhN?=
 =?utf-8?B?ZGNCOWF5ZjFIWmlqVkJiN3Bzck9wN0pZMnpIRkl4N09HZit0K2JhUnllcWIz?=
 =?utf-8?B?c1pZaDJGeG45Z3pCemF5YkYyOXNaT0E4TDQrcVZHZnhFZXBEeW54WTZaTEkx?=
 =?utf-8?B?eFZQU1JLMmFIN0czbnZuVEc4NE5vRmFpL29nTUIyZy90UTdGbElGR1JYWXJX?=
 =?utf-8?B?U240QmkxdkV3WTlobFVZRVd2ODVMUlNYUzVHQW53N3EzcXBTZW1kditjRmJQ?=
 =?utf-8?B?V3duKzFrS0F3VVFHVE56Mmg0M0Vnamhqem9Ga25sOThiRkZLZjdMVU5YcWVq?=
 =?utf-8?B?Y0FBNjZwS3FCbTh3Q3kyU1hRWWRFd0E2MjdteXM3UEVSY01XaDdEMWYxcnRn?=
 =?utf-8?B?ZTBxTmxITHVULzNMaWczTWlyS2tmbzFjZmNneEhQUUhreXd0SnNEZjVicnZL?=
 =?utf-8?B?Ymt1eFloMzdoWjlUR1RUOHcxTE1oNmZIYWJ0TEwxdmE1WC9KbEVoTWdMVUE4?=
 =?utf-8?B?OGs0ekZQR0oxQ2lVZkRLRkgzMGhwSXJ6ZzVteWJyaVlka2k4WDFrM2UvdWdL?=
 =?utf-8?B?UVBtN3owR3RqQW9kOTh5a0JCd0ZoRDRpL0FFZFlsZEp2U2Z1OE1wclJyQ1kz?=
 =?utf-8?B?TkxaRHB0c2NWWVF3V3ZiVWpuWlRaN2Q5OXhqaHV1ak43NkdCOWxzQXVVSHRW?=
 =?utf-8?B?QzNxL1FtcmVWMDdsREdSR3V1NWRJaDhra1NrRG1aRU5jVy9QVFcwY0VRcktl?=
 =?utf-8?B?RmYzWEozMnFTeG11WmNsWU1yUTFUdk5nNUR3ZDRFbllYMzdkTmhPNVJDd2tN?=
 =?utf-8?Q?/5GMw7mSEte7/6JtTHxwJ7OmqgFySgByno4IwkUga1a4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fb61fa-87b1-4a65-b5a3-08dae3640b32
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 15:00:05.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCjRrXcfFShUCots4RXYWQUwIoKG4SklElceA1DfDXBceNrJULavgsEU+MutRbsEwBf7kicoV7ge2d1imxcnbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8699
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.12.22 02:29, Qu Wenruo wrote:

Hi,

I am sorry that I did not include full dmesg. I am afraid I cannot recover it now.
However, the issue has reoccured, albeit without a full warning. I am including
a full dmesg.
I find it quite uninformative. Any suggestions on debug option I should
enable?

> Please give a full dmesg, not just the WARNING, which is useless in this particular case.
> 
>>
>> Upon check I am getting an error in pass 7.
> 
> And fulll btrfs check --readonly output.
>

Here you are (of this time):

	Regards
		Oliver

Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: 6b557439-a722-46c6-b9fa-e3395a5f4d40
Rescan hasn't been initialized, a difference in qgroup accounting is expected
Counts for qgroup id: 0/257 are different
our:		referenced 27094540288 referenced compressed 27094540288
disk:		referenced 27127427072 referenced compressed 27127427072
diff:		referenced -32886784 referenced compressed -32886784
our:		exclusive 27094540288 exclusive compressed 27094540288
disk:		exclusive 27127427072 exclusive compressed 27127427072
diff:		exclusive -32886784 exclusive compressed -32886784
Counts for qgroup id: 0/259 are different
our:		referenced 1518755840 referenced compressed 1518755840
disk:		referenced 1530195968 referenced compressed 1530195968
diff:		referenced -11440128 referenced compressed -11440128
our:		exclusive 1518755840 exclusive compressed 1518755840
disk:		exclusive 1530195968 exclusive compressed 1530195968
diff:		exclusive -11440128 exclusive compressed -11440128
found 154172760064 bytes used, no error found
total csum bytes: 123424284
total tree bytes: 791822336
total fs tree bytes: 586547200
total extent tree bytes: 54788096
btree space waste bytes: 134346049
file data blocks allocated: 153505906688
  referenced 153221865472
  
Mounted filesystems:

sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
devtmpfs on /dev type devtmpfs (rw,nosuid,noexec,size=4096k,nr_inodes=1048576,mode=755)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,size=2839752k,nr_inodes=819200,mode=755)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,size=4096k,nr_inodes=1024,mode=755)
cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,name=systemd)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
bpf on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,net_cls,net_prio)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,hugetlb)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/rdma type cgroup (rw,nosuid,nodev,noexec,relatime,rdma)
/dev/nvme0n1p2 on / type btrfs (rw,relatime,ssd,discard=async,space_cache,subvolid=266,subvol=/@/.snapshots/1/snapshot)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=32,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=17828)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)
fusectl on /sys/fs/fuse/connections type fusectl (rw,nosuid,nodev,noexec,relatime)
/dev/nvme0n1p2 on /.snapshots type btrfs (rw,relatime,ssd,discard=async,space_cache,subvolid=265,subvol=/@/.snapshots)
/dev/nvme0n1p2 on /opt type btrfs (rw,relatime,ssd,discard=async,space_cache,subvolid=262,subvol=/@/opt)
/dev/nvme0n1p2 on /boot/grub2/i386-pc type btrfs (rw,relatime,ssd,discard=async,space_cache,subvolid=264,subvol=/@/boot/grub2/i386-pc)
/dev/nvme0n1p2 on /boot/grub2/x86_64-efi type btrfs (rw,relatime,ssd,discard=async,space_cache,subvolid=263,subvol=/@/boot/grub2/x86_64-efi)
/dev/nvme0n1p2 on /srv type btrfs (rw,relatime,ssd,discard=async,space_cache,subvolid=260,subvol=/@/srv)
/dev/nvme0n1p2 on /usr/local type btrfs (rw,relatime,ssd,discard=async,space_cache,subvolid=258,subvol=/@/usr/local)
/dev/nvme0n1p2 on /tmp type btrfs (rw,relatime,ssd,discard=async,space_cache,subvolid=259,subvol=/@/tmp)
/dev/nvme0n1p2 on /root type btrfs (rw,relatime,ssd,discard=async,space_cache,subvolid=261,subvol=/@/root)
/dev/nvme0n1p2 on /var type btrfs (rw,relatime,ssd,discard=async,space_cache,subvolid=257,subvol=/@/var)
/dev/nvme0n1p1 on /boot/efi type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
/dev/nvme0n1p3 on /home type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
tmpfs on /run/user/1000 type tmpfs (rw,nosuid,nodev,relatime,size=1419872k,nr_inodes=354968,mode=700,uid=1000,gid=100)
gvfsd-fuse on /run/user/1000/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,relatime,user_id=1000,group_id=100)
portal on /run/user/1000/doc type fuse.portal (rw,nosuid,nodev,relatime,user_id=1000,group_id=100)
tracefs on /sys/kernel/debug/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /run/user/0 type tmpfs (rw,nosuid,nodev,relatime,size=1419872k,nr_inodes=354968,mode=700)

dmesg:

[    0.000000] Linux version 6.1.0-59.40-default+ (oneukum@linux.fritz.box) (gcc (SUSE Linux) 7.5.0, GNU ld (GNU Binutils; SUSE Linux Enterprise 15) 2.37.20211103-150100.7.37) #336 SMP PREEMPT_DYNAMIC Thu Dec 15 10:54:17 CET 2022
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.1.0-59.40-default+ root=UUID=6b557439-a722-46c6-b9fa-e3395a5f4d40 splash=silent resume=/dev/disk/by-id/nvme-SKHynix_HFS512GD9TNI-L2B0B_CS0AN73541VA1AL6G-part4 quiet mitigations=auto
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009c00000-0x0000000009cd0fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000009cd1000-0x0000000009efffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000009f0b000-0x00000000b7fa2fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b7fa3000-0x00000000bb77dfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bb77e000-0x00000000bbb6cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bbb6d000-0x00000000bbb6dfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bbb6e000-0x00000000bd77dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bd77e000-0x00000000bd7fdfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bd7fe000-0x00000000beffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf000000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000003beffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0xaa7a8018-0xaa7b6057] usable ==> usable
[    0.000000] e820: update [mem 0xaa7a8018-0xaa7b6057] usable ==> usable
[    0.000000] e820: update [mem 0xaa799018-0xaa7a7057] usable ==> usable
[    0.000000] e820: update [mem 0xaa799018-0xaa7a7057] usable ==> usable
[    0.000000] e820: update [mem 0xaa78b018-0xaa798457] usable ==> usable
[    0.000000] e820: update [mem 0xaa78b018-0xaa798457] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009bfffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009c00000-0x0000000009cd0fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000009cd1000-0x0000000009efffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009f00000-0x0000000009f0afff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000009f0b000-0x00000000aa78b017] usable
[    0.000000] reserve setup_data: [mem 0x00000000aa78b018-0x00000000aa798457] usable
[    0.000000] reserve setup_data: [mem 0x00000000aa798458-0x00000000aa799017] usable
[    0.000000] reserve setup_data: [mem 0x00000000aa799018-0x00000000aa7a7057] usable
[    0.000000] reserve setup_data: [mem 0x00000000aa7a7058-0x00000000aa7a8017] usable
[    0.000000] reserve setup_data: [mem 0x00000000aa7a8018-0x00000000aa7b6057] usable
[    0.000000] reserve setup_data: [mem 0x00000000aa7b6058-0x00000000b7fa2fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000b7fa3000-0x00000000bb77dfff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000bb77e000-0x00000000bbb6cfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000bbb6d000-0x00000000bbb6dfff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000bbb6e000-0x00000000bd77dfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000bd77e000-0x00000000bd7fdfff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000bd7fe000-0x00000000beffffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000bf000000-0x00000000bfffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000003beffffff] usable
[    0.000000] efi: EFI v2.70 by Lenovo
[    0.000000] efi: ACPI=0xbd7fd000 ACPI 2.0=0xbd7fd014 TPMFinalLog=0xbd62d000 SMBIOS=0xb9ed8000 SMBIOS 3.0=0xb9ecb000 MEMATTR=0xb452c018 ESRT=0xb8a70000 RNG=0xbd7fc018 TPMEventLog=0xaa7b9018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem48: MMIO range=[0xfd200000-0xfd2fffff] (1MB) from e820 map
[    0.000000] e820: remove [mem 0xfd200000-0xfd2fffff] reserved
[    0.000000] efi: Not removing mem49: MMIO range=[0xfed80000-0xfed80fff] (4KB) from e820 map
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS R12ET55W(1.25 ) 07/06/2020
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2295.465 MHz processor
[    0.000015] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000018] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000029] last_pfn = 0x3bf000 max_arch_pfn = 0x400000000
[    0.000035] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000481] last_pfn = 0xbf000 max_arch_pfn = 0x400000000
[    0.005047] esrt: Reserving ESRT space from 0x00000000b8a70000 to 0x00000000b8a700b0.
[    0.005058] Using GB pages for direct mapping
[    0.005367] Secure boot disabled
[    0.005367] RAMDISK: [mem 0x3f28d000-0x3fffafff]
[    0.005374] ACPI: Early table checksum verification disabled
[    0.005377] ACPI: RSDP 0x00000000BD7FD014 000024 (v02 LENOVO)
[    0.005382] ACPI: XSDT 0x00000000BD7FB188 0000EC (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005389] ACPI: FACP 0x00000000B8AA0000 00010C (v05 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005395] ACPI: DSDT 0x00000000B8A8D000 00DCD0 (v01 LENOVO TP-R12   00001190 INTL 20120711)
[    0.005399] ACPI: FACS 0x00000000BD61C000 000040
[    0.005402] ACPI: SSDT 0x00000000B9EE2000 000CD6 (v01 LENOVO UsbCTabl 00000001 INTL 20120711)
[    0.005405] ACPI: SSDT 0x00000000B9EDC000 005419 (v02 LENOVO TP-R12   00000002 MSFT 02000002)
[    0.005409] ACPI: SSDT 0x00000000B9EAC000 000651 (v02 LENOVO Tpm2Tabl 00001000 INTL 20120711)
[    0.005412] ACPI: TPM2 0x00000000B9EAB000 000034 (v03 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005416] ACPI: SSDT 0x00000000B9EAA000 000924 (v01 LENOVO WmiTable 00000001 INTL 20120711)
[    0.005419] ACPI: MSDM 0x00000000B9E85000 000055 (v03 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005422] ACPI: SLIC 0x00000000B9CA8000 000176 (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005426] ACPI: BATB 0x00000000B9CA7000 00004A (v02 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005429] ACPI: HPET 0x00000000B8A9F000 000038 (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005432] ACPI: APIC 0x00000000B8A9E000 000138 (v02 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005436] ACPI: MCFG 0x00000000B8A9D000 00003C (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005439] ACPI: SBST 0x00000000B8A9C000 000030 (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005442] ACPI: WSMT 0x00000000B8A9B000 000028 (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005445] ACPI: VFCT 0x00000000B8A7F000 00D484 (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005449] ACPI: IVRS 0x00000000B8A7E000 00013E (v02 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005452] ACPI: SSDT 0x00000000B8A7C000 00119C (v01 LENOVO TP-R12   00000001 AMD  00000001)
[    0.005455] ACPI: CRAT 0x00000000B8A7B000 000810 (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005458] ACPI: CDIT 0x00000000B8A7A000 000029 (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005462] ACPI: FPDT 0x00000000B8A79000 000034 (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005465] ACPI: SSDT 0x00000000B8A73000 000C5D (v01 LENOVO TP-R12   00000001 INTL 20120711)
[    0.005468] ACPI: SSDT 0x00000000B8A71000 001134 (v01 LENOVO TP-R12   00000001 INTL 20120711)
[    0.005472] ACPI: SSDT 0x00000000B8A6E000 001DCC (v01 LENOVO TP-R12   00000001 INTL 20120711)
[    0.005475] ACPI: BGRT 0x00000000B8A6D000 000038 (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005478] ACPI: UEFI 0x00000000BD61B000 0000B2 (v01 LENOVO TP-R12   00001190 PTEC 00000002)
[    0.005481] ACPI: Reserving FACP table memory at [mem 0xb8aa0000-0xb8aa010b]
[    0.005483] ACPI: Reserving DSDT table memory at [mem 0xb8a8d000-0xb8a9accf]
[    0.005484] ACPI: Reserving FACS table memory at [mem 0xbd61c000-0xbd61c03f]
[    0.005485] ACPI: Reserving SSDT table memory at [mem 0xb9ee2000-0xb9ee2cd5]
[    0.005487] ACPI: Reserving SSDT table memory at [mem 0xb9edc000-0xb9ee1418]
[    0.005488] ACPI: Reserving SSDT table memory at [mem 0xb9eac000-0xb9eac650]
[    0.005489] ACPI: Reserving TPM2 table memory at [mem 0xb9eab000-0xb9eab033]
[    0.005490] ACPI: Reserving SSDT table memory at [mem 0xb9eaa000-0xb9eaa923]
[    0.005491] ACPI: Reserving MSDM table memory at [mem 0xb9e85000-0xb9e85054]
[    0.005492] ACPI: Reserving SLIC table memory at [mem 0xb9ca8000-0xb9ca8175]
[    0.005493] ACPI: Reserving BATB table memory at [mem 0xb9ca7000-0xb9ca7049]
[    0.005494] ACPI: Reserving HPET table memory at [mem 0xb8a9f000-0xb8a9f037]
[    0.005495] ACPI: Reserving APIC table memory at [mem 0xb8a9e000-0xb8a9e137]
[    0.005496] ACPI: Reserving MCFG table memory at [mem 0xb8a9d000-0xb8a9d03b]
[    0.005497] ACPI: Reserving SBST table memory at [mem 0xb8a9c000-0xb8a9c02f]
[    0.005498] ACPI: Reserving WSMT table memory at [mem 0xb8a9b000-0xb8a9b027]
[    0.005499] ACPI: Reserving VFCT table memory at [mem 0xb8a7f000-0xb8a8c483]
[    0.005501] ACPI: Reserving IVRS table memory at [mem 0xb8a7e000-0xb8a7e13d]
[    0.005502] ACPI: Reserving SSDT table memory at [mem 0xb8a7c000-0xb8a7d19b]
[    0.005503] ACPI: Reserving CRAT table memory at [mem 0xb8a7b000-0xb8a7b80f]
[    0.005504] ACPI: Reserving CDIT table memory at [mem 0xb8a7a000-0xb8a7a028]
[    0.005505] ACPI: Reserving FPDT table memory at [mem 0xb8a79000-0xb8a79033]
[    0.005506] ACPI: Reserving SSDT table memory at [mem 0xb8a73000-0xb8a73c5c]
[    0.005507] ACPI: Reserving SSDT table memory at [mem 0xb8a71000-0xb8a72133]
[    0.005508] ACPI: Reserving SSDT table memory at [mem 0xb8a6e000-0xb8a6fdcb]
[    0.005509] ACPI: Reserving BGRT table memory at [mem 0xb8a6d000-0xb8a6d037]
[    0.005510] ACPI: Reserving UEFI table memory at [mem 0xbd61b000-0xbd61b0b1]
[    0.005648] No NUMA configuration found
[    0.005649] Faking a node at [mem 0x0000000000000000-0x00000003beffffff]
[    0.005659] NODE_DATA(0) allocated [mem 0x3befd5000-0x3beffffff]
[    0.005918] Zone ranges:
[    0.005918]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005920]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005922]   Normal   [mem 0x0000000100000000-0x00000003beffffff]
[    0.005924]   Device   empty
[    0.005925] Movable zone start for each node
[    0.005928] Early memory node ranges
[    0.005928]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.005930]   node   0: [mem 0x0000000000100000-0x0000000009bfffff]
[    0.005931]   node   0: [mem 0x0000000009cd1000-0x0000000009efffff]
[    0.005932]   node   0: [mem 0x0000000009f0b000-0x00000000b7fa2fff]
[    0.005933]   node   0: [mem 0x00000000bd7fe000-0x00000000beffffff]
[    0.005934]   node   0: [mem 0x0000000100000000-0x00000003beffffff]
[    0.005937] Initmem setup node 0 [mem 0x0000000000001000-0x00000003beffffff]
[    0.005943] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005976] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.006272] On node 0, zone DMA32: 209 pages in unavailable ranges
[    0.015019] On node 0, zone DMA32: 11 pages in unavailable ranges
[    0.015427] On node 0, zone DMA32: 22619 pages in unavailable ranges
[    0.015916] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.015978] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.016122] ACPI: PM-Timer IO Port: 0x408
[    0.016134] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.016135] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.016136] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.016138] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.016139] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.016140] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.016140] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.016141] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.016142] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.016143] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.016144] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.016145] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.016146] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.016147] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.016148] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.016149] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.016169] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0-23
[    0.016177] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 24-55
[    0.016180] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.016182] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.016186] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.016188] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.016200] e820: update [mem 0xb43bd000-0xb444dfff] usable ==> reserved
[    0.016216] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
[    0.016240] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.016243] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.016244] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.016245] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.016247] PM: hibernation: Registered nosave memory: [mem 0x09c00000-0x09cd0fff]
[    0.016248] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0x09f0afff]
[    0.016250] PM: hibernation: Registered nosave memory: [mem 0xaa78b000-0xaa78bfff]
[    0.016252] PM: hibernation: Registered nosave memory: [mem 0xaa798000-0xaa798fff]
[    0.016253] PM: hibernation: Registered nosave memory: [mem 0xaa799000-0xaa799fff]
[    0.016255] PM: hibernation: Registered nosave memory: [mem 0xaa7a7000-0xaa7a7fff]
[    0.016256] PM: hibernation: Registered nosave memory: [mem 0xaa7a8000-0xaa7a8fff]
[    0.016257] PM: hibernation: Registered nosave memory: [mem 0xaa7b6000-0xaa7b6fff]
[    0.016259] PM: hibernation: Registered nosave memory: [mem 0xb43bd000-0xb444dfff]
[    0.016261] PM: hibernation: Registered nosave memory: [mem 0xb7fa3000-0xbb77dfff]
[    0.016262] PM: hibernation: Registered nosave memory: [mem 0xbb77e000-0xbbb6cfff]
[    0.016263] PM: hibernation: Registered nosave memory: [mem 0xbbb6d000-0xbbb6dfff]
[    0.016264] PM: hibernation: Registered nosave memory: [mem 0xbbb6e000-0xbd77dfff]
[    0.016265] PM: hibernation: Registered nosave memory: [mem 0xbd77e000-0xbd7fdfff]
[    0.016266] PM: hibernation: Registered nosave memory: [mem 0xbf000000-0xbfffffff]
[    0.016267] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfed7ffff]
[    0.016268] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed80fff]
[    0.016269] PM: hibernation: Registered nosave memory: [mem 0xfed81000-0xffffffff]
[    0.016271] [mem 0xc0000000-0xfed7ffff] available for PCI devices
[    0.016272] Booting paravirtualized kernel on bare hardware
[    0.016276] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.020928] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.021851] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u262144
[    0.021862] pcpu-alloc: s221184 r8192 d28672 u262144 alloc=1*2097152
[    0.021865] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15
[    0.021907] Fallback order for Node 0: 0
[    0.021911] Built 1 zonelists, mobility grouping on.  Total pages: 3581869
[    0.021913] Policy zone: Normal
[    0.021914] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.1.0-59.40-default+ root=UUID=6b557439-a722-46c6-b9fa-e3395a5f4d40 splash=silent resume=/dev/disk/by-id/nvme-SKHynix_HFS512GD9TNI-L2B0B_CS0AN73541VA1AL6G-part4 quiet mitigations=auto
[    0.021990] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.1.0-59.40-default+ splash=silent", will be passed to user space.
[    0.024916] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.026275] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.026345] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.026396] software IO TLB: area num 16.
[    0.066766] Memory: 3039044K/14555548K available (14336K kernel code, 2879K rwdata, 5936K rodata, 3812K init, 5356K bss, 425300K reserved, 0K cma-reserved)
[    0.066918] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.066933] ftrace: allocating 43849 entries in 172 pages
[    0.074730] ftrace: allocated 172 pages with 4 groups
[    0.075546] Dynamic Preempt: none
[    0.075601] rcu: Preemptible hierarchical RCU implementation.
[    0.075602] rcu: 	RCU event tracing is enabled.
[    0.075602] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.075604] 	Trampoline variant of Tasks RCU enabled.
[    0.075604] 	Rude variant of Tasks RCU enabled.
[    0.075605] 	Tracing variant of Tasks RCU enabled.
[    0.075606] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.075606] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.079490] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
[    0.079698] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.079849] Console: colour dummy device 80x25
[    0.079851] printk: console [tty0] enabled
[    0.079895] ACPI: Core revision 20221020
[    0.080110] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.080136] APIC: Switch to symmetric I/O mode setup
[    0.081574] AMD-Vi: ivrs, add hid:PNPD0040, uid:, rdevid:152
[    0.081576] AMD-Vi: Using global IVHD EFR:0x4f77ef22294ada, EFR2:0x0
[    0.081972] Switched APIC routing to physical flat.
[    0.082934] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.100144] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2116792ff7e, max_idle_ns: 440795303466 ns
[    0.100156] Calibrating delay loop (skipped), value calculated using timer frequency.. 4590.93 BogoMIPS (lpj=9181860)
[    0.100159] pid_max: default: 32768 minimum: 301
[    0.102543] LSM: initializing lsm=lockdown,capability,integrity,apparmor
[    0.102577] AppArmor: AppArmor initialized
[    0.102654] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.102702] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.103124] LVT offset 1 assigned for vector 0xf9
[    0.103169] LVT offset 2 assigned for vector 0xf4
[    0.103184] process: using mwait in idle threads
[    0.103185] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.103186] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.103191] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.103193] Spectre V2 : Mitigation: Retpolines
[    0.103194] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.103195] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.103196] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.103196] RETBleed: Mitigation: untrained return thunk
[    0.103198] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.103200] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.110767] Freeing SMP alternatives memory: 36K
[    0.222124] smpboot: CPU0: AMD Ryzen 7 PRO 3700U w/ Radeon Vega Mobile Gfx (family: 0x17, model: 0x18, stepping: 0x1)
[    0.222258] cblist_init_generic: Setting adjustable number of callback queues.
[    0.222262] cblist_init_generic: Setting shift to 4 and lim to 1.
[    0.222277] cblist_init_generic: Setting shift to 4 and lim to 1.
[    0.222292] cblist_init_generic: Setting shift to 4 and lim to 1.
[    0.222309] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.222330] ... version:                0
[    0.222331] ... bit width:              48
[    0.222332] ... generic registers:      6
[    0.222332] ... value mask:             0000ffffffffffff
[    0.222333] ... max period:             00007fffffffffff
[    0.222334] ... fixed-purpose events:   0
[    0.222335] ... event mask:             000000000000003f
[    0.222426] rcu: Hierarchical SRCU implementation.
[    0.222427] rcu: 	Max phase no-delay instances is 1000.
[    0.222722] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.222872] smp: Bringing up secondary CPUs ...
[    0.222969] x86: Booting SMP configuration:
[    0.222971] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.236190] smp: Brought up 1 node, 8 CPUs
[    0.236190] smpboot: Max logical packages: 2
[    0.236190] smpboot: Total of 8 processors activated (36727.44 BogoMIPS)
[    0.269748] node 0 deferred pages initialised in 32ms
[    0.269753] devtmpfs: initialized
[    0.269753] x86/mm: Memory block size: 128MB
[    0.272795] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0afff] (45056 bytes)
[    0.272795] ACPI: PM: Registering ACPI NVS region [mem 0xbb77e000-0xbbb6cfff] (4124672 bytes)
[    0.272795] ACPI: PM: Registering ACPI NVS region [mem 0xbbb6e000-0xbd77dfff] (29425664 bytes)
[    0.272795] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.272795] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.272837] pinctrl core: initialized pinctrl subsystem
[    0.272970] PM: RTC time: 08:50:59, date: 2022-12-21
[    0.273619] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.273737] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    0.273746] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.273750] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.273760] audit: initializing netlink subsys (disabled)
[    0.273767] audit: type=2000 audit(1671612659.192:1): state=initialized audit_enabled=0 res=1
[    0.273767] thermal_sys: Registered thermal governor 'fair_share'
[    0.273767] thermal_sys: Registered thermal governor 'bang_bang'
[    0.273767] thermal_sys: Registered thermal governor 'step_wise'
[    0.273767] thermal_sys: Registered thermal governor 'user_space'
[    0.273767] cpuidle: using governor ladder
[    0.273767] cpuidle: using governor menu
[    0.273767] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.273767] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.273767] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.273767] PCI: not using MMCONFIG
[    0.273767] PCI: Using configuration type 1 for base access
[    0.273767] PCI: Using configuration type 1 for extended access
[    0.273767] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.273767] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.273767] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.273767] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.273767] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.273767] ACPI: Added _OSI(Module Device)
[    0.273767] ACPI: Added _OSI(Processor Device)
[    0.273767] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.273767] ACPI: Added _OSI(Processor Aggregator Device)
[    0.292210] ACPI: 9 ACPI AML tables successfully acquired and loaded
[    0.294235] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.301626] ACPI: EC: EC started
[    0.301628] ACPI: EC: interrupt blocked
[    0.301876] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.301879] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle transactions
[    0.301881] ACPI: Interpreter enabled
[    0.301903] ACPI: PM: (supports S0 S3 S4 S5)
[    0.301904] ACPI: Using IOAPIC for interrupt routing
[    0.302617] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.302968] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in ACPI motherboard resources
[    0.302978] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.302979] PCI: Using E820 reservations for host bridge windows
[    0.303261] ACPI: Enabled 2 GPEs in block 00 to 1F
[    0.304624] ACPI: \_SB_.PCI0.GPP1.PXSX.WRST: New power resource
[    0.305289] ACPI: \_SB_.PCI0.GP17.XHC0.PUBS: New power resource
[    0.339985] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.339993] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.340104] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR DPC]
[    0.340317] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.340319] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.340332] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.341337] PCI host bridge to bus 0000:00
[    0.341339] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.341342] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xf7ffffff window]
[    0.341344] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfdffffff window]
[    0.341346] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.341347] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.341349] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.341366] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
[    0.341473] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
[    0.341582] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.341670] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400
[    0.341705] pci 0000:00:01.2: enabling Extended Tags
[    0.341763] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.341911] pci 0000:00:01.3: [1022:15d3] type 01 class 0x060400
[    0.341945] pci 0000:00:01.3: enabling Extended Tags
[    0.342002] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.342150] pci 0000:00:01.4: [1022:15d3] type 01 class 0x060400
[    0.342186] pci 0000:00:01.4: enabling Extended Tags
[    0.342246] pci 0000:00:01.4: PME# supported from D0 D3hot D3cold
[    0.342400] pci 0000:00:01.6: [1022:15d3] type 01 class 0x060400
[    0.342434] pci 0000:00:01.6: enabling Extended Tags
[    0.342490] pci 0000:00:01.6: PME# supported from D0 D3hot D3cold
[    0.342635] pci 0000:00:01.7: [1022:15d3] type 01 class 0x060400
[    0.342670] pci 0000:00:01.7: enabling Extended Tags
[    0.342727] pci 0000:00:01.7: PME# supported from D0 D3hot D3cold
[    0.342885] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.342968] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
[    0.343002] pci 0000:00:08.1: enabling Extended Tags
[    0.343049] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.343217] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.343351] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.343545] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
[    0.343589] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
[    0.343630] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
[    0.343672] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
[    0.343713] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
[    0.343755] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
[    0.343798] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
[    0.343839] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
[    0.344120] pci 0000:01:00.0: [8086:2526] type 00 class 0x028000
[    0.344201] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[    0.344387] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.344836] pci 0000:00:01.2: PCI bridge to [bus 01]
[    0.344842] pci 0000:00:01.2:   bridge window [mem 0xd0a00000-0xd0afffff]
[    0.344958] pci 0000:02:00.0: [1c5c:1639] type 00 class 0x010802
[    0.344975] pci 0000:02:00.0: reg 0x10: [mem 0xd0900000-0xd0903fff 64bit]
[    0.344984] pci 0000:02:00.0: reg 0x18: [mem 0xd0905000-0xd0905fff]
[    0.344992] pci 0000:02:00.0: reg 0x1c: [mem 0xd0904000-0xd0904fff]
[    0.345244] pci 0000:00:01.3: PCI bridge to [bus 02]
[    0.345250] pci 0000:00:01.3:   bridge window [mem 0xd0900000-0xd09fffff]
[    0.345306] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.345325] pci 0000:03:00.0: reg 0x10: [io  0x3400-0x34ff]
[    0.345350] pci 0000:03:00.0: reg 0x18: [mem 0xd0814000-0xd0814fff 64bit]
[    0.345366] pci 0000:03:00.0: reg 0x20: [mem 0xd0800000-0xd0803fff 64bit]
[    0.345476] pci 0000:03:00.0: supports D1 D2
[    0.345478] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.345652] pci 0000:03:00.1: [10ec:816a] type 00 class 0x070002
[    0.345668] pci 0000:03:00.1: reg 0x10: [io  0x3200-0x32ff]
[    0.345688] pci 0000:03:00.1: reg 0x18: [mem 0xd0815000-0xd0815fff 64bit]
[    0.345701] pci 0000:03:00.1: reg 0x20: [mem 0xd0804000-0xd0807fff 64bit]
[    0.345801] pci 0000:03:00.1: supports D1 D2
[    0.345802] pci 0000:03:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.345944] pci 0000:03:00.2: [10ec:816b] type 00 class 0x070002
[    0.345960] pci 0000:03:00.2: reg 0x10: [io  0x3100-0x31ff]
[    0.345980] pci 0000:03:00.2: reg 0x18: [mem 0xd0816000-0xd0816fff 64bit]
[    0.345993] pci 0000:03:00.2: reg 0x20: [mem 0xd0808000-0xd080bfff 64bit]
[    0.346092] pci 0000:03:00.2: supports D1 D2
[    0.346094] pci 0000:03:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.346239] pci 0000:03:00.3: [10ec:816c] type 00 class 0x0c0701
[    0.346255] pci 0000:03:00.3: reg 0x10: [io  0x3000-0x30ff]
[    0.346275] pci 0000:03:00.3: reg 0x18: [mem 0xd0817000-0xd0817fff 64bit]
[    0.346288] pci 0000:03:00.3: reg 0x20: [mem 0xd080c000-0xd080ffff 64bit]
[    0.346388] pci 0000:03:00.3: supports D1 D2
[    0.346389] pci 0000:03:00.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.346533] pci 0000:03:00.4: [10ec:816d] type 00 class 0x0c0320
[    0.346552] pci 0000:03:00.4: reg 0x10: [mem 0xd0818000-0xd0818fff]
[    0.346577] pci 0000:03:00.4: reg 0x18: [mem 0xd0810000-0xd0813fff 64bit]
[    0.346697] pci 0000:03:00.4: PME# supported from D0 D3cold
[    0.346883] pci 0000:00:01.4: PCI bridge to [bus 03]
[    0.346888] pci 0000:00:01.4:   bridge window [io  0x3000-0x3fff]
[    0.346890] pci 0000:00:01.4:   bridge window [mem 0xd0800000-0xd08fffff]
[    0.346947] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.346963] pci 0000:04:00.0: reg 0x10: [io  0x2000-0x20ff]
[    0.346983] pci 0000:04:00.0: reg 0x18: [mem 0xd0704000-0xd0704fff 64bit]
[    0.346996] pci 0000:04:00.0: reg 0x20: [mem 0xd0700000-0xd0703fff 64bit]
[    0.347104] pci 0000:04:00.0: supports D1 D2
[    0.347105] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.347292] pci 0000:00:01.6: PCI bridge to [bus 04]
[    0.347296] pci 0000:00:01.6:   bridge window [io  0x2000-0x2fff]
[    0.347299] pci 0000:00:01.6:   bridge window [mem 0xd0700000-0xd07fffff]
[    0.347353] pci 0000:05:00.0: [10ec:522a] type 00 class 0xff0000
[    0.347369] pci 0000:05:00.0: reg 0x10: [mem 0xd0600000-0xd0600fff]
[    0.347489] pci 0000:05:00.0: supports D1 D2
[    0.347491] pci 0000:05:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.347650] pci 0000:00:01.7: PCI bridge to [bus 05]
[    0.347656] pci 0000:00:01.7:   bridge window [mem 0xd0600000-0xd06fffff]
[    0.347762] pci 0000:06:00.0: [1002:15d8] type 00 class 0x030000
[    0.347780] pci 0000:06:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.347791] pci 0000:06:00.0: reg 0x18: [mem 0xd0000000-0xd01fffff 64bit pref]
[    0.347799] pci 0000:06:00.0: reg 0x20: [io  0x1000-0x10ff]
[    0.347807] pci 0000:06:00.0: reg 0x24: [mem 0xd0500000-0xd057ffff]
[    0.347821] pci 0000:06:00.0: enabling Extended Tags
[    0.347839] pci 0000:06:00.0: BAR 0: assigned to efifb
[    0.347907] pci 0000:06:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.348069] pci 0000:06:00.1: [1002:15de] type 00 class 0x040300
[    0.348081] pci 0000:06:00.1: reg 0x10: [mem 0xd05c8000-0xd05cbfff]
[    0.348114] pci 0000:06:00.1: enabling Extended Tags
[    0.348173] pci 0000:06:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.348240] pci 0000:06:00.2: [1022:15df] type 00 class 0x108000
[    0.348261] pci 0000:06:00.2: reg 0x18: [mem 0xd0400000-0xd04fffff]
[    0.348276] pci 0000:06:00.2: reg 0x24: [mem 0xd05cc000-0xd05cdfff]
[    0.348287] pci 0000:06:00.2: enabling Extended Tags
[    0.348423] pci 0000:06:00.3: [1022:15e0] type 00 class 0x0c0330
[    0.348440] pci 0000:06:00.3: reg 0x10: [mem 0xd0200000-0xd02fffff 64bit]
[    0.348478] pci 0000:06:00.3: enabling Extended Tags
[    0.348528] pci 0000:06:00.3: PME# supported from D0 D3hot D3cold
[    0.348634] pci 0000:06:00.4: [1022:15e1] type 00 class 0x0c0330
[    0.348651] pci 0000:06:00.4: reg 0x10: [mem 0xd0300000-0xd03fffff 64bit]
[    0.348689] pci 0000:06:00.4: enabling Extended Tags
[    0.348739] pci 0000:06:00.4: PME# supported from D0 D3hot D3cold
[    0.348840] pci 0000:06:00.5: [1022:15e2] type 00 class 0x048000
[    0.348852] pci 0000:06:00.5: reg 0x10: [mem 0xd0580000-0xd05bffff]
[    0.348885] pci 0000:06:00.5: enabling Extended Tags
[    0.348932] pci 0000:06:00.5: PME# supported from D0 D3hot D3cold
[    0.349024] pci 0000:06:00.6: [1022:15e3] type 00 class 0x040300
[    0.349036] pci 0000:06:00.6: reg 0x10: [mem 0xd05c0000-0xd05c7fff]
[    0.349069] pci 0000:06:00.6: enabling Extended Tags
[    0.349116] pci 0000:06:00.6: PME# supported from D0 D3hot D3cold
[    0.349234] pci 0000:00:08.1: PCI bridge to [bus 06]
[    0.349239] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.349241] pci 0000:00:08.1:   bridge window [mem 0xd0200000-0xd05fffff]
[    0.349246] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.349516] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.349598] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.349657] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.349734] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.349805] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.349859] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.349913] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.349966] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.350766] ACPI: EC: interrupt unblocked
[    0.350768] ACPI: EC: event unblocked
[    0.350776] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.350777] ACPI: EC: GPE=0x3
[    0.350778] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization complete
[    0.350780] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions and events
[    0.350854] iommu: Default domain type: Passthrough
[    0.350854] pps_core: LinuxPPS API ver. 1 registered
[    0.350854] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.350854] PTP clock support registered
[    0.350854] EDAC MC: Ver: 3.0.0
[    0.350854] Registered efivars operations
[    0.352310] NetLabel: Initializing
[    0.352313] NetLabel:  domain hash size = 128
[    0.352314] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.352329] NetLabel:  unlabeled traffic allowed by default
[    0.352333] PCI: Using ACPI for IRQ routing
[    0.354651] PCI: pci_cache_line_size set to 64 bytes
[    0.354872] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.354874] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
[    0.354876] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
[    0.354877] e820: reserve RAM buffer [mem 0xaa78b018-0xabffffff]
[    0.354878] e820: reserve RAM buffer [mem 0xaa799018-0xabffffff]
[    0.354879] e820: reserve RAM buffer [mem 0xaa7a8018-0xabffffff]
[    0.354880] e820: reserve RAM buffer [mem 0xb43bd000-0xb7ffffff]
[    0.354881] e820: reserve RAM buffer [mem 0xb7fa3000-0xb7ffffff]
[    0.354882] e820: reserve RAM buffer [mem 0xbf000000-0xbfffffff]
[    0.354883] e820: reserve RAM buffer [mem 0x3bf000000-0x3bfffffff]
[    0.354931] pci 0000:06:00.0: vgaarb: setting as boot VGA device
[    0.354931] pci 0000:06:00.0: vgaarb: bridge control possible
[    0.354931] pci 0000:06:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.354931] vgaarb: loaded
[    0.354931] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.354931] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.358198] clocksource: Switched to clocksource tsc-early
[    0.368935] VFS: Disk quotas dquot_6.6.0
[    0.368955] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.369124] AppArmor: AppArmor Filesystem Enabled
[    0.369149] pnp: PnP ACPI init
[    0.369361] system 00:00: [io  0x0f50-0x0f51] has been reserved
[    0.369367] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reserved
[    0.369371] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.369374] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.369798] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.369801] system 00:02: [io  0x0530-0x0537] has been reserved
[    0.369803] system 00:02: [io  0x0400-0x0427] has been reserved
[    0.369805] system 00:02: [io  0x0430] has been reserved
[    0.369807] system 00:02: [io  0x0440-0x0447] has been reserved
[    0.369809] system 00:02: [io  0x0b00-0x0b1f] has been reserved
[    0.369810] system 00:02: [io  0x0b20-0x0b3f] has been reserved
[    0.369812] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.369814] system 00:02: [io  0x0c14] has been reserved
[    0.369816] system 00:02: [io  0x0c50-0x0c52] has been reserved
[    0.369818] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
[    0.369819] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
[    0.369821] system 00:02: [io  0x0cd4-0x0cd5] has been reserved
[    0.369823] system 00:02: [io  0x0cd6-0x0cd7] has been reserved
[    0.369825] system 00:02: [io  0x0cd8-0x0cdf] has been reserved
[    0.369827] system 00:02: [io  0x0cf9] could not be reserved
[    0.369829] system 00:02: [io  0x8100-0x81ff window] has been reserved
[    0.369831] system 00:02: [io  0x8200-0x82ff window] has been reserved
[    0.369953] system 00:03: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.369956] system 00:03: [mem 0xff000000-0xffffffff] has been reserved
[    0.369959] system 00:03: [mem 0xfec10000-0xfec1001f] has been reserved
[    0.369961] system 00:03: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.369964] system 00:03: [mem 0xfed61000-0xfed613ff] has been reserved
[    0.369966] system 00:03: [mem 0xfed80000-0xfed80fff] has been reserved
[    0.370221] pnp: PnP ACPI: found 6 devices
[    0.376033] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.376095] NET: Registered PF_INET protocol family
[    0.376460] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.378897] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.378916] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.378921] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.379087] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.379402] TCP: Hash tables configured (established 131072 bind 65536)
[    0.379464] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.379513] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.379628] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.379638] NET: Registered PF_XDP protocol family
[    0.379647] pci 0000:00:01.2: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    0.379651] pci 0000:00:01.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.379669] pci 0000:00:01.2: BAR 15: assigned [mem 0xd0b00000-0xd0cfffff 64bit pref]
[    0.379675] pci 0000:00:01.2: BAR 13: assigned [io  0x4000-0x4fff]
[    0.379678] pci 0000:01:00.0: BAR 0: assigned [mem 0xd0a00000-0xd0a03fff 64bit]
[    0.379726] pci 0000:00:01.2: PCI bridge to [bus 01]
[    0.379729] pci 0000:00:01.2:   bridge window [io  0x4000-0x4fff]
[    0.379733] pci 0000:00:01.2:   bridge window [mem 0xd0a00000-0xd0afffff]
[    0.379735] pci 0000:00:01.2:   bridge window [mem 0xd0b00000-0xd0cfffff 64bit pref]
[    0.379740] pci 0000:00:01.3: PCI bridge to [bus 02]
[    0.379744] pci 0000:00:01.3:   bridge window [mem 0xd0900000-0xd09fffff]
[    0.379751] pci 0000:00:01.4: PCI bridge to [bus 03]
[    0.379753] pci 0000:00:01.4:   bridge window [io  0x3000-0x3fff]
[    0.379756] pci 0000:00:01.4:   bridge window [mem 0xd0800000-0xd08fffff]
[    0.379763] pci 0000:00:01.6: PCI bridge to [bus 04]
[    0.379765] pci 0000:00:01.6:   bridge window [io  0x2000-0x2fff]
[    0.379768] pci 0000:00:01.6:   bridge window [mem 0xd0700000-0xd07fffff]
[    0.379774] pci 0000:00:01.7: PCI bridge to [bus 05]
[    0.379778] pci 0000:00:01.7:   bridge window [mem 0xd0600000-0xd06fffff]
[    0.379787] pci 0000:00:08.1: PCI bridge to [bus 06]
[    0.379793] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.379797] pci 0000:00:08.1:   bridge window [mem 0xd0200000-0xd05fffff]
[    0.379800] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.379806] pci_bus 0000:00: resource 4 [mem 0x000a0000-0x000bffff window]
[    0.379808] pci_bus 0000:00: resource 5 [mem 0xc0000000-0xf7ffffff window]
[    0.379810] pci_bus 0000:00: resource 6 [mem 0xfc000000-0xfdffffff window]
[    0.379811] pci_bus 0000:00: resource 7 [io  0x0000-0x0cf7 window]
[    0.379813] pci_bus 0000:00: resource 8 [io  0x0d00-0xffff window]
[    0.379814] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    0.379816] pci_bus 0000:01: resource 1 [mem 0xd0a00000-0xd0afffff]
[    0.379817] pci_bus 0000:01: resource 2 [mem 0xd0b00000-0xd0cfffff 64bit pref]
[    0.379819] pci_bus 0000:02: resource 1 [mem 0xd0900000-0xd09fffff]
[    0.379820] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    0.379821] pci_bus 0000:03: resource 1 [mem 0xd0800000-0xd08fffff]
[    0.379823] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
[    0.379824] pci_bus 0000:04: resource 1 [mem 0xd0700000-0xd07fffff]
[    0.379826] pci_bus 0000:05: resource 1 [mem 0xd0600000-0xd06fffff]
[    0.379827] pci_bus 0000:06: resource 0 [io  0x1000-0x1fff]
[    0.379828] pci_bus 0000:06: resource 1 [mem 0xd0200000-0xd05fffff]
[    0.379830] pci_bus 0000:06: resource 2 [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.380448] pci 0000:06:00.1: D0 power state depends on 0000:06:00.0
[    0.380460] pci 0000:06:00.3: extending delay after power-on from D3hot to 20 msec
[    0.380847] pci 0000:06:00.4: extending delay after power-on from D3hot to 20 msec
[    0.380985] PCI: CLS 32 bytes, default 64
[    0.380998] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.381049] Trying to unpack rootfs image as initramfs...
[    0.381056] pci 0000:00:01.0: Adding to iommu group 0
[    0.381072] pci 0000:00:01.2: Adding to iommu group 1
[    0.381084] pci 0000:00:01.3: Adding to iommu group 2
[    0.381096] pci 0000:00:01.4: Adding to iommu group 3
[    0.381109] pci 0000:00:01.6: Adding to iommu group 4
[    0.381123] pci 0000:00:01.7: Adding to iommu group 5
[    0.381140] pci 0000:00:08.0: Adding to iommu group 6
[    0.381153] pci 0000:00:08.1: Adding to iommu group 7
[    0.381173] pci 0000:00:14.0: Adding to iommu group 8
[    0.381183] pci 0000:00:14.3: Adding to iommu group 8
[    0.381232] pci 0000:00:18.0: Adding to iommu group 9
[    0.381243] pci 0000:00:18.1: Adding to iommu group 9
[    0.381254] pci 0000:00:18.2: Adding to iommu group 9
[    0.381265] pci 0000:00:18.3: Adding to iommu group 9
[    0.381276] pci 0000:00:18.4: Adding to iommu group 9
[    0.381286] pci 0000:00:18.5: Adding to iommu group 9
[    0.381297] pci 0000:00:18.6: Adding to iommu group 9
[    0.381308] pci 0000:00:18.7: Adding to iommu group 9
[    0.381321] pci 0000:01:00.0: Adding to iommu group 10
[    0.381334] pci 0000:02:00.0: Adding to iommu group 11
[    0.381369] pci 0000:03:00.0: Adding to iommu group 12
[    0.381383] pci 0000:03:00.1: Adding to iommu group 12
[    0.381398] pci 0000:03:00.2: Adding to iommu group 12
[    0.381411] pci 0000:03:00.3: Adding to iommu group 12
[    0.381427] pci 0000:03:00.4: Adding to iommu group 12
[    0.381439] pci 0000:04:00.0: Adding to iommu group 13
[    0.381451] pci 0000:05:00.0: Adding to iommu group 14
[    0.381486] pci 0000:06:00.0: Adding to iommu group 15
[    0.381528] pci 0000:06:00.1: Adding to iommu group 16
[    0.381548] pci 0000:06:00.2: Adding to iommu group 16
[    0.381567] pci 0000:06:00.3: Adding to iommu group 16
[    0.381584] pci 0000:06:00.4: Adding to iommu group 16
[    0.381600] pci 0000:06:00.5: Adding to iommu group 16
[    0.381615] pci 0000:06:00.6: Adding to iommu group 16
[    0.381955] pci 0000:00:00.2: can't derive routing for PCI INT A
[    0.381956] pci 0000:00:00.2: PCI INT A: not connected
[    0.382322] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.382323] AMD-Vi: Extended features (0x4f77ef22294ada, 0x0): PPR NX GT IA GA PC GA_vAPIC
[    0.382330] AMD-Vi: Interrupt remapping enabled
[    0.382367] AMD-Vi: Virtual APIC enabled
[    0.382479] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.382480] software IO TLB: mapped [mem 0x00000000ac000000-0x00000000b0000000] (64MB)
[    0.382491] ACPI: bus type thunderbolt registered
[    0.382636] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
[    0.382638] RAPL PMU: hw unit of domain package 2^-16 Joules
[    0.382642] amd_uncore: 4  amd_df counters detected
[    0.382647] amd_uncore: 6  amd_l3 counters detected
[    0.382742] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.383297] Initialise system trusted keyrings
[    0.383307] Key type blacklist registered
[    0.383343] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[    0.383355] zbud: loaded
[    0.383537] integrity: Platform Keyring initialized
[    0.392490] Key type asymmetric registered
[    0.392492] Asymmetric key parser 'x509' registered
[    1.388172] tsc: Refined TSC clocksource calibration: 2295.686 MHz
[    1.388188] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x211749f51e2, max_idle_ns: 440795249748 ns
[    1.388308] clocksource: Switched to clocksource tsc
[    1.598101] Freeing initrd memory: 13752K
[    1.606643] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    1.606684] io scheduler mq-deadline registered
[    1.606687] io scheduler kyber registered
[    1.606704] io scheduler bfq registered
[    1.607756] pcieport 0000:00:01.2: PME: Signaling with IRQ 26
[    1.607818] pcieport 0000:00:01.2: AER: enabled with IRQ 26
[    1.607841] pcieport 0000:00:01.2: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.608046] pcieport 0000:00:01.3: PME: Signaling with IRQ 27
[    1.608112] pcieport 0000:00:01.3: AER: enabled with IRQ 27
[    1.608274] pcieport 0000:00:01.4: PME: Signaling with IRQ 28
[    1.608332] pcieport 0000:00:01.4: AER: enabled with IRQ 28
[    1.608486] pcieport 0000:00:01.6: PME: Signaling with IRQ 29
[    1.608539] pcieport 0000:00:01.6: AER: enabled with IRQ 29
[    1.608697] pcieport 0000:00:01.7: PME: Signaling with IRQ 30
[    1.608751] pcieport 0000:00:01.7: AER: enabled with IRQ 30
[    1.608902] pcieport 0000:00:08.1: PME: Signaling with IRQ 31
[    1.609028] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.609118] Monitor-Mwait will be used to enter C-1 state
[    1.609124] ACPI: \_PR_.C000: Found 2 idle states
[    1.609242] ACPI: \_PR_.C001: Found 2 idle states
[    1.609320] ACPI: \_PR_.C002: Found 2 idle states
[    1.609394] ACPI: \_PR_.C003: Found 2 idle states
[    1.609493] ACPI: \_PR_.C004: Found 2 idle states
[    1.609578] ACPI: \_PR_.C005: Found 2 idle states
[    1.609657] ACPI: \_PR_.C006: Found 2 idle states
[    1.609734] ACPI: \_PR_.C007: Found 2 idle states
[    1.609968] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.610990] serial 0000:03:00.1: enabling device (0000 -> 0003)
[    1.611392] 0000:03:00.1: ttyS4 at I/O 0x3200 (irq = 32, base_baud = 115200) is a 16550A
[    1.611438] serial 0000:03:00.2: enabling device (0000 -> 0003)
[    1.611785] 0000:03:00.2: ttyS5 at I/O 0x3100 (irq = 33, base_baud = 115200) is a 16550A
[    1.611968] Non-volatile memory driver v1.3
[    1.611969] Linux agpgart interface v0.103
[    1.626407] tpm_tis NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
[    1.640009] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.645116] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.645121] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.645199] mousedev: PS/2 mouse device common for all mice
[    1.645240] rtc_cmos 00:01: RTC can wake from S4
[    1.645502] rtc_cmos 00:01: registered as rtc0
[    1.645516] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.645645] ledtrig-cpu: registered to indicate activity on CPUs
[    1.645667] efifb: probing for efifb
[    1.645678] efifb: framebuffer at 0xc0000000, using 8100k, total 8100k
[    1.645680] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    1.645681] efifb: scrolling: redraw
[    1.645682] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.645761] Console: switching to colour frame buffer device 240x67
[    1.648141] fb0: EFI VGA frame buffer device
[    1.648183] hid: raw HID events driver (C) Jiri Kosina
[    1.648243] drop_monitor: Initializing network drop monitor service
[    1.648330] NET: Registered PF_INET6 protocol family
[    1.653627] Segment Routing with IPv6
[    1.653631] RPL Segment Routing with IPv6
[    1.653646] In-situ OAM (IOAM) with IPv6
[    1.654359] microcode: CPU3: patch_level=0x08108102
[    1.654361] microcode: CPU2: patch_level=0x08108102
[    1.654362] microcode: CPU6: patch_level=0x08108102
[    1.654363] microcode: CPU7: patch_level=0x08108102
[    1.654372] microcode: CPU1: patch_level=0x08108102
[    1.654375] microcode: CPU5: patch_level=0x08108102
[    1.654375] microcode: CPU4: patch_level=0x08108102
[    1.654423] microcode: CPU0: patch_level=0x08108102
[    1.654435] microcode: Microcode Update Driver: v2.2.
[    1.654442] IPI shorthand broadcast: enabled
[    1.654814] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.655868] sched_clock: Marking stable (1654019246, 413260)->(1659259352, -4826846)
[    1.656178] registered taskstats version 1
[    1.656257] Loading compiled-in X.509 certificates
[    1.674935] Loaded X.509 cert 'Build time autogenerated kernel key: 1b12a0987fcb9feb173a2a8d517f0db13790e32d'
[    1.675279] zswap: loaded using pool lzo/zbud
[    1.677651] page_owner is disabled
[    1.677688] Key type .fscrypt registered
[    1.677690] Key type fscrypt-provisioning registered
[    1.677812] Key type trusted registered
[    1.683021] Key type encrypted registered
[    1.683026] AppArmor: AppArmor sha1 policy hashing enabled
[    1.683780] integrity: Loading X.509 certificate: UEFI:db
[    1.683811] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad Product CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    1.683812] integrity: Loading X.509 certificate: UEFI:db
[    1.683829] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014: 4b91a68732eaefdd2c8ffffc6b027ec3449e9c8f'
[    1.683830] integrity: Loading X.509 certificate: UEFI:db
[    1.683853] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.683854] integrity: Loading X.509 certificate: UEFI:db
[    1.683878] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.684635] Loading compiled-in module X.509 certificates
[    1.685290] Loaded X.509 cert 'Build time autogenerated kernel key: 1b12a0987fcb9feb173a2a8d517f0db13790e32d'
[    1.685293] ima: Allocated hash algorithm: sha256
[    1.719020] ima: No architecture policies found
[    1.719033] evm: Initialising EVM extended attributes:
[    1.719034] evm: security.selinux
[    1.719035] evm: security.SMACK64 (disabled)
[    1.719036] evm: security.SMACK64EXEC (disabled)
[    1.719037] evm: security.SMACK64TRANSMUTE (disabled)
[    1.719038] evm: security.SMACK64MMAP (disabled)
[    1.719039] evm: security.apparmor
[    1.719040] evm: security.ima
[    1.719040] evm: security.capability
[    1.719041] evm: HMAC attrs: 0x1
[    1.813533] PM:   Magic number: 2:251:827
[    1.813589] misc hw_random: hash matches
[    1.813617] tpm_tis NTC0702:00: hash matches
[    1.813634] acpi NTC0702:00: hash matches
[    1.813930] RAS: Correctable Errors collector initialized.
[    2.535058] psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
[    2.576047] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
[    2.576058] psmouse serio1: synaptics: Your touchpad (PNP: LEN2062 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[    2.650879] psmouse serio1: synaptics: Touchpad model: 1, fw: 10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board id: 3471, fw id: 2909640
[    2.650911] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
[    2.700101] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input2
[    3.233695] psmouse serio2: trackpoint: Elan TrackPoint firmware: 0x11, buttons: 3/3
[    3.470425] input: TPPS/2 Elan TrackPoint as /devices/platform/i8042/serio1/serio2/input/input3
[    3.564281] Freeing unused decrypted memory: 2036K
[    3.564916] Freeing unused kernel image (initmem) memory: 3812K
[    3.564923] Write protecting the kernel read-only data: 20480k
[    3.565122] Freeing unused kernel image (rodata/data gap) memory: 208K
[    3.565130] Run /init as init process
[    3.565132]   with arguments:
[    3.565133]     /init
[    3.565134]   with environment:
[    3.565135]     HOME=/
[    3.565136]     TERM=linux
[    3.565136]     BOOT_IMAGE=/boot/vmlinuz-6.1.0-59.40-default+
[    3.565137]     splash=silent
[    3.578549] efivarfs: module verification failed: signature and/or required key missing - tainting kernel
[    3.661954] systemd[1]: systemd 246.16+suse.259.ge7211d27e1 running in system mode. (+PAM +AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.662092] systemd[1]: Detected architecture x86-64.
[    3.662096] systemd[1]: Running in initial RAM disk.
[    3.716406] systemd[1]: No hostname configured.
[    3.716412] systemd[1]: Set hostname to <localhost>.
[    3.786958] systemd[1]: Queued start job for default target Initrd Default Target.
[    3.787601] systemd[1]: Created slice Slice /system/systemd-hibernate-resume.
[    3.787690] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    3.787747] systemd[1]: Reached target Paths.
[    3.787785] systemd[1]: Reached target Slices.
[    3.787820] systemd[1]: Reached target Swap.
[    3.787853] systemd[1]: Reached target Timers.
[    3.787973] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.788066] systemd[1]: Listening on Journal Socket.
[    3.788167] systemd[1]: Listening on udev Control Socket.
[    3.788276] systemd[1]: Listening on udev Kernel Socket.
[    3.788312] systemd[1]: Reached target Sockets.
[    3.788997] systemd[1]: Started Entropy Daemon based on the HAVEGE algorithm.
[    3.789834] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    3.791025] systemd[1]: Starting Journal Service...
[    3.791909] systemd[1]: Starting Load Kernel Modules...
[    3.792987] systemd[1]: Starting Setup Virtual Console...
[    3.794972] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    3.796565] systemd[1]: Starting Create Static Device Nodes in /dev...
[    3.804845] SCSI subsystem initialized
[    3.805332] alua: device handler registered
[    3.805661] emc: device handler registered
[    3.805979] rdac: device handler registered
[    3.806437] systemd[1]: Finished Create Static Device Nodes in /dev.
[    3.811213] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    3.811247] device-mapper: uevent: version 1.0.3
[    3.811311] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    3.812998] systemd[1]: Finished Setup Virtual Console.
[    3.814172] systemd[1]: Starting dracut ask for additional cmdline parameters...
[    3.814649] systemd[1]: Finished Load Kernel Modules.
[    3.815578] systemd[1]: Starting Apply Kernel Variables...
[    3.822132] systemd[1]: Finished Apply Kernel Variables.
[    3.849689] systemd[1]: Finished dracut ask for additional cmdline parameters.
[    3.851021] systemd[1]: Starting dracut cmdline hook...
[    3.859117] systemd[1]: Started Journal Service.
[    4.051974] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    4.052107] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0b/LNXVIDEO:00/input/input4
[    4.077549] ACPI: bus type USB registered
[    4.077588] usbcore: registered new interface driver usbfs
[    4.077598] usbcore: registered new interface driver hub
[    4.077616] usbcore: registered new device driver usb
[    4.085886] ACPI: battery: Slot [BAT0] (battery present)
[    4.090001] rtsx_pci 0000:05:00.0: enabling device (0000 -> 0002)
[    4.102763] xhci_hcd 0000:06:00.3: xHCI Host Controller
[    4.102896] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 1
[    4.103086] xhci_hcd 0000:06:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000840000410
[    4.103962] ehci-pci 0000:03:00.4: EHCI Host Controller
[    4.103973] ehci-pci 0000:03:00.4: new USB bus registered, assigned bus number 2
[    4.104084] xhci_hcd 0000:06:00.3: xHCI Host Controller
[    4.104090] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 3
[    4.104094] xhci_hcd 0000:06:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    4.104100] ehci-pci 0000:03:00.4: irq 38, io mem 0xd0818000
[    4.104209] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.01
[    4.104214] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.104216] usb usb1: Product: xHCI Host Controller
[    4.104218] usb usb1: Manufacturer: Linux 6.1.0-59.40-default+ xhci-hcd
[    4.104220] usb usb1: SerialNumber: 0000:06:00.3
[    4.104600] hub 1-0:1.0: USB hub found
[    4.104626] hub 1-0:1.0: 4 ports detected
[    4.105171] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
[    4.105211] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.01
[    4.105216] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.105219] usb usb3: Product: xHCI Host Controller
[    4.105222] usb usb3: Manufacturer: Linux 6.1.0-59.40-default+ xhci-hcd
[    4.105224] usb usb3: SerialNumber: 0000:06:00.3
[    4.105480] hub 3-0:1.0: USB hub found
[    4.105504] hub 3-0:1.0: 4 ports detected
[    4.110306] nvme nvme0: pci function 0000:02:00.0
[    4.116202] ehci-pci 0000:03:00.4: USB 0.0 started, EHCI 1.00
[    4.116289] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.01
[    4.116294] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.116297] usb usb2: Product: EHCI Host Controller
[    4.116298] usb usb2: Manufacturer: Linux 6.1.0-59.40-default+ ehci_hcd
[    4.116300] usb usb2: SerialNumber: 0000:03:00.4
[    4.116462] hub 2-0:1.0: USB hub found
[    4.116486] hub 2-0:1.0: 1 port detected
[    4.116629] xhci_hcd 0000:06:00.4: xHCI Host Controller
[    4.116638] xhci_hcd 0000:06:00.4: new USB bus registered, assigned bus number 4
[    4.116795] xhci_hcd 0000:06:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000840000410
[    4.117720] xhci_hcd 0000:06:00.4: xHCI Host Controller
[    4.117726] xhci_hcd 0000:06:00.4: new USB bus registered, assigned bus number 5
[    4.117730] xhci_hcd 0000:06:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    4.117876] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.01
[    4.117880] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.117883] usb usb4: Product: xHCI Host Controller
[    4.117884] usb usb4: Manufacturer: Linux 6.1.0-59.40-default+ xhci-hcd
[    4.117886] usb usb4: SerialNumber: 0000:06:00.4
[    4.118099] hub 4-0:1.0: USB hub found
[    4.118120] hub 4-0:1.0: 2 ports detected
[    4.118331] usb usb5: We don't know the algorithms for LPM for this host, disabling LPM.
[    4.118372] usb usb5: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.01
[    4.118376] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.118378] usb usb5: Product: xHCI Host Controller
[    4.118380] usb usb5: Manufacturer: Linux 6.1.0-59.40-default+ xhci-hcd
[    4.118381] usb usb5: SerialNumber: 0000:06:00.4
[    4.118610] hub 5-0:1.0: USB hub found
[    4.118652] hub 5-0:1.0: 1 port detected
[    4.215256] nvme nvme0: missing or invalid SUBNQN field.
[    4.360156] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    4.380153] usb 4-1: new full-speed USB device number 2 using xhci_hcd
[    4.400354] nvme nvme0: 16/0/0 default/read/poll queues
[    4.411798]  nvme0n1: p1 p2 p3 p4
[    4.496152] raid6: avx2x4   gen() 22170 MB/s
[    4.519310] usb 1-1: New USB device found, idVendor=17ef, idProduct=a392, bcdDevice= d.24
[    4.519319] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.519323] usb 1-1: Product: USB2.0 Hub
[    4.519326] usb 1-1: Manufacturer: VIA Labs, Inc.
[    4.552538] hub 1-1:1.0: USB hub found
[    4.552798] hub 1-1:1.0: 4 ports detected
[    4.553881] usb 4-1: New USB device found, idVendor=8087, idProduct=0025, bcdDevice= 0.02
[    4.553888] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.564161] raid6: avx2x2   gen() 24727 MB/s
[    4.632150] raid6: avx2x1   gen() 22003 MB/s
[    4.632152] raid6: using algorithm avx2x2 gen() 24727 MB/s
[    4.647901] usb 3-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[    4.692156] usb 4-2: new high-speed USB device number 3 using xhci_hcd
[    4.700150] raid6: .... xor() 15066 MB/s, rmw enabled
[    4.700152] raid6: using avx2x2 recovery algorithm
[    4.700804] xor: automatically using best checksumming function   avx
[    4.740820] usb 3-1: New USB device found, idVendor=17ef, idProduct=a391, bcdDevice= d.24
[    4.740829] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.740833] usb 3-1: Product: USB3.1 Hub
[    4.740836] usb 3-1: Manufacturer: VIA Labs, Inc.
[    4.760817] hub 3-1:1.0: USB hub found
[    4.760933] hub 3-1:1.0: 4 ports detected
[    4.786867] Btrfs loaded, crc32c=crc32c-intel, assert=on, zoned=yes, fsverity=no
[    4.793536] BTRFS: device fsid 6b557439-a722-46c6-b9fa-e3395a5f4d40 devid 1 transid 765872 /dev/nvme0n1p2 scanned by systemd-udevd (337)
[    4.812783] PM: Image not found (code -22)
[    4.842247] usb 4-2: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=60.52
[    4.842252] usb 4-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    4.842254] usb 4-2: Product: USB2.0 Hub
[    4.864197] usb 1-2: new low-speed USB device number 3 using xhci_hcd
[    4.886362] hub 4-2:1.0: USB hub found
[    4.886734] hub 4-2:1.0: 4 ports detected
[    5.025433] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[    5.025441] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.172161] usb 1-4: new high-speed USB device number 4 using xhci_hcd
[    5.240204] usb 4-2.1: new high-speed USB device number 4 using xhci_hcd
[    5.327184] usb 1-4: New USB device found, idVendor=04e8, idProduct=6860, bcdDevice= 4.00
[    5.327191] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.327193] usb 1-4: Product: SAMSUNG_Android
[    5.327195] usb 1-4: Manufacturer: SAMSUNG
[    5.327197] usb 1-4: SerialNumber: R58N53Y68AT
[    5.394999] usb 4-2.1: New USB device found, idVendor=13d3, idProduct=56bc, bcdDevice=69.05
[    5.395006] usb 4-2.1: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    5.395009] usb 4-2.1: Product: Integrated Camera
[    5.395011] usb 4-2.1: Manufacturer: Azurewave
[    5.395012] usb 4-2.1: SerialNumber: 200901010001
[    5.438377] usbcore: registered new interface driver usbhid
[    5.438381] usbhid: USB HID core driver
[    5.440335] input: HID 1241:1166 as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-2/1-2:1.0/0003:1241:1166.0001/input/input5
[    5.440431] hid-generic 0003:1241:1166.0001: input,hidraw0: USB HID v1.10 Mouse [HID 1241:1166] on usb-0000:06:00.3-2/input0
[    5.452434] usb 1-1.3: new high-speed USB device number 5 using xhci_hcd
[    5.544188] usb 4-2.2: new full-speed USB device number 5 using xhci_hcd
[    5.603445] usb 1-1.3: New USB device found, idVendor=17ef, idProduct=a394, bcdDevice= d.23
[    5.603453] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.603455] usb 1-1.3: Product: USB2.0 Hub
[    5.603457] usb 1-1.3: Manufacturer: VIA Labs, Inc.
[    5.640783] hub 1-1.3:1.0: USB hub found
[    5.641064] hub 1-1.3:1.0: 4 ports detected
[    5.673898] usb 4-2.2: New USB device found, idVendor=058f, idProduct=9540, bcdDevice= 1.20
[    5.673906] usb 4-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.673908] usb 4-2.2: Product: EMV Smartcard Reader
[    5.673910] usb 4-2.2: Manufacturer: Generic
[    5.704334] usb 3-1.3: new SuperSpeed Plus Gen 2x1 USB device number 3 using xhci_hcd
[    5.800165] usb 4-2.4: new full-speed USB device number 6 using xhci_hcd
[    5.827623] usb 3-1.3: New USB device found, idVendor=17ef, idProduct=a393, bcdDevice= d.23
[    5.827630] usb 3-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.827632] usb 3-1.3: Product: USB3.1 Hub
[    5.827634] usb 3-1.3: Manufacturer: VIA Labs, Inc.
[    5.848672] hub 3-1.3:1.0: USB hub found
[    5.848804] hub 3-1.3:1.0: 4 ports detected
[    5.916899] usb 4-2.4: New USB device found, idVendor=06cb, idProduct=00bd, bcdDevice= 0.00
[    5.916906] usb 4-2.4: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    5.916908] usb 4-2.4: SerialNumber: fb17f8614e26
[    5.925556] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel) checksum algorithm
[    5.925566] BTRFS info (device nvme0n1p2): disk space caching is enabled
[    5.948115] BTRFS info (device nvme0n1p2): enabling ssd optimizations
[    5.948119] BTRFS info (device nvme0n1p2): auto enabling async discard
[    6.202532] systemd-journald[218]: Received SIGTERM from PID 1 (systemd).
[    6.293381] systemd[1]: systemd 246.16+suse.259.ge7211d27e1 running in system mode. (+PAM +AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    6.293464] systemd[1]: Detected architecture x86-64.
[    6.424170] usb 1-1.3.3: new high-speed USB device number 6 using xhci_hcd
[    6.509769] systemd[1]: /usr/lib/systemd/system/pcscd.socket:5: ListenStream= references a path below legacy directory /var/run/, updating /var/run/pcscd/pcscd.comm → /run/pcscd/pcscd.comm; please update the unit file accordingly.
[    6.553112] systemd[1]: initrd-switch-root.service: Succeeded.
[    6.553285] systemd[1]: Stopped Switch Root.
[    6.553554] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    6.553739] systemd[1]: Created slice Slice /system/getty.
[    6.553895] systemd[1]: Created slice Slice /system/modprobe.
[    6.554044] systemd[1]: Created slice Slice /system/systemd-fsck.
[    6.554214] systemd[1]: Created slice User and Session Slice.
[    6.554303] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    6.554468] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    6.554526] systemd[1]: Reached target Local Encrypted Volumes.
[    6.554545] systemd[1]: Stopped target Switch Root.
[    6.554555] systemd[1]: Stopped target Initrd File Systems.
[    6.554562] systemd[1]: Stopped target Initrd Root File System.
[    6.554619] systemd[1]: Reached target Slices.
[    6.554664] systemd[1]: Reached target System Time Set.
[    6.554743] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    6.554849] systemd[1]: Listening on LVM2 poll daemon socket.
[    6.554944] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    6.555058] systemd[1]: Listening on udev Control Socket.
[    6.555144] systemd[1]: Listening on udev Kernel Socket.
[    6.576855] systemd[1]: Mounting Huge Pages File System...
[    6.578152] systemd[1]: Mounting POSIX Message Queue File System...
[    6.579319] systemd[1]: Mounting Kernel Debug File System...
[    6.580427] systemd[1]: Mounting Kernel Trace File System...
[    6.581699] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    6.582633] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    6.583682] systemd[1]: Starting Load Kernel Module configfs...
[    6.584708] systemd[1]: Starting Load Kernel Module drm...
[    6.585780] systemd[1]: Starting Load Kernel Module fuse...
[    6.586043] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    6.586137] systemd[1]: systemd-fsck-root.service: Succeeded.
[    6.586294] systemd[1]: Stopped File System Check on Root Device.
[    6.586440] systemd[1]: Stopped Journal Service.
[    6.586893] systemd[1]: Listening on Syslog Socket.
[    6.588889] systemd[1]: Starting Journal Service...
[    6.590363] systemd[1]: Starting Load Kernel Modules...
[    6.592439] systemd[1]: Starting Remount Root and Kernel File Systems...
[    6.593203] usb 1-1.3.3: New USB device found, idVendor=17ef, idProduct=a395, bcdDevice=60.70
[    6.593214] usb 1-1.3.3: New USB device strings: Mfr=10, Product=11, SerialNumber=0
[    6.593217] usb 1-1.3.3: Product: USB2.0 Hub
[    6.593220] usb 1-1.3.3: Manufacturer: Lenovo
[    6.595402] systemd[1]: Starting Coldplug All udev Devices...
[    6.599612] systemd[1]: sysroot.mount: Succeeded.
[    6.601029] systemd[1]: Mounted Huge Pages File System.
[    6.601248] systemd[1]: Mounted POSIX Message Queue File System.
[    6.601412] systemd[1]: Mounted Kernel Debug File System.
[    6.601636] systemd[1]: Mounted Kernel Trace File System.
[    6.602559] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    6.603476] systemd[1]: modprobe@configfs.service: Succeeded.
[    6.603816] systemd[1]: Finished Load Kernel Module configfs.
[    6.606295] systemd[1]: Mounting Kernel Configuration File System...
[    6.607095] systemd[1]: Finished Load Kernel Modules.
[    6.607488] fuse: init (API version 7.38)
[    6.608675] systemd[1]: Starting Apply Kernel Variables...
[    6.609051] systemd[1]: modprobe@fuse.service: Succeeded.
[    6.609327] systemd[1]: Finished Load Kernel Module fuse.
[    6.611509] systemd[1]: Finished Remount Root and Kernel File Systems.
[    6.611721] systemd[1]: Mounted Kernel Configuration File System.
[    6.613095] systemd[1]: Mounting FUSE Control File System...
[    6.613192] systemd[1]: Condition check resulted in One time configuration for iscsid.service being skipped.
[    6.613286] systemd[1]: Condition check resulted in First Boot Wizard being skipped.
[    6.613847] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    6.613929] systemd[1]: Condition check resulted in Create System Users being skipped.
[    6.614991] systemd[1]: Starting Create Static Device Nodes in /dev...
[    6.617298] systemd[1]: Mounted FUSE Control File System.
[    6.625083] systemd[1]: Finished Apply Kernel Variables.
[    6.628039] systemd[1]: Finished Create Static Device Nodes in /dev.
[    6.629621] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    6.630851] systemd[1]: Started Journal Service.
[    6.632659] hub 1-1.3.3:1.0: USB hub found
[    6.633043] hub 1-1.3.3:1.0: 4 ports detected
[    6.639373] ACPI: bus type drm_connector registered
[    6.656301] usb 3-1.1: new SuperSpeed USB device number 4 using xhci_hcd
[    6.676698] usb 3-1.1: New USB device found, idVendor=17ef, idProduct=a387, bcdDevice=31.03
[    6.676709] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[    6.676714] usb 3-1.1: Product: USB-C Dock Ethernet
[    6.676717] usb 3-1.1: Manufacturer: Realtek
[    6.676721] usb 3-1.1: SerialNumber: 301000001
[    6.770703] acpi_cpufreq: overriding BIOS provided _PSD data
[    6.771240] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input6
[    6.771329] ACPI: button: Power Button [PWRB]
[    6.771427] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input7
[    6.784260] ACPI: button: Lid Switch [LID]
[    6.784582] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input8
[    6.784687] ACPI: button: Sleep Button [SLPB]
[    6.784747] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input9
[    6.784841] ACPI: button: Power Button [PWRF]
[    6.804179] usb 1-1.3.4: new high-speed USB device number 7 using xhci_hcd
[    6.834430] ACPI: AC: AC Adapter [AC] (on-line)
[    6.914336] Adding 14198080k swap on /dev/nvme0n1p4.  Priority:-2 extents:1 across:14198080k SSFS
[    6.921251] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    6.921262] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[    6.921579] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    6.927194] IPMI message handler: version 39.2
[    6.931305] pstore: Using crash dump compression: lzo
[    6.935260] ipmi device interface
[    6.937957] input: PC Speaker as /devices/platform/pcspkr/input/input10
[    6.962064] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    6.962069] thinkpad_acpi: http://ibm-acpi.sf.net/
[    6.962070] thinkpad_acpi: ThinkPad BIOS R12ET55W(1.25 ), EC R12HT55W
[    6.962072] thinkpad_acpi: Lenovo ThinkPad T495, model 20NJS0KQ07
[    6.962998] ipmi_si: IPMI System Interface driver
[    6.977205] ipmi_si: Unable to find any System Interface(s)
[    6.981815] thinkpad_acpi: radio switch found; radios are enabled
[    6.981994] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    6.981995] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    6.983299] usb 1-1.3.4: New USB device found, idVendor=13fd, idProduct=0842, bcdDevice= 6.14
[    6.983306] usb 1-1.3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    6.983309] usb 1-1.3.4: Product: USB Mass Storage Device
[    6.983312] usb 1-1.3.4: Manufacturer: TSSTcorp
[    6.983314] usb 1-1.3.4: SerialNumber: SATASLIM00002004149
[    7.004874] pstore: Registered efi_pstore as persistent store backend
[    7.031568] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    7.039003] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    7.054010] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
[    7.061187] r8169 0000:03:00.0 eth0: RTL8168ep/8111ep, 54:05:db:7e:14:ed, XID 502, IRQ 75
[    7.061202] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    7.061336] r8169 0000:04:00.0: enabling device (0000 -> 0003)
[    7.062394] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
[    7.065700] usb 1-1.3.3.1: new full-speed USB device number 8 using xhci_hcd
[    7.065732] thinkpad_acpi: secondary fan control detected & enabled
[    7.079070] thinkpad_acpi: battery 1 registered (start 95, stop 100, behaviours: 0x7)
[    7.080461] ACPI: battery: new extension: ThinkPad Battery Extension
[    7.081401] cryptd: max_cpu_qlen set to 1000
[    7.082184] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input11
[    7.093213] r8169 0000:04:00.0 eth1: RTL8168gu/8111gu, 54:05:db:7e:14:ec, XID 509, IRQ 77
[    7.093235] r8169 0000:04:00.0 eth1: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    7.114984] systemd-journald[454]: Received client request to flush runtime journal.
[    7.145370] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    7.145643] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    7.151001] audit: type=1400 audit(1671612666.064:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ping" pid=603 comm="apparmor_parser"
[    7.181482] audit: type=1400 audit(1671612666.096:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=622 comm="apparmor_parser"
[    7.194445] AVX2 version of gcm_enc/dec engaged.
[    7.194601] AES CTR mode by8 optimization enabled
[    7.202425] audit: type=1400 audit(1671612666.116:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=632 comm="apparmor_parser"
[    7.202434] audit: type=1400 audit(1671612666.116:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=632 comm="apparmor_parser"
[    7.221188] usb 1-1.3.3.1: New USB device found, idVendor=17ef, idProduct=a38f, bcdDevice= 0.00
[    7.221195] usb 1-1.3.3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.221198] usb 1-1.3.3.1: Product: 40AS
[    7.221201] usb 1-1.3.3.1: Manufacturer: Cypress Semiconductor
[    7.221203] usb 1-1.3.3.1: SerialNumber: 1S40ASZKW1372W
[    7.226394] audit: type=1400 audit(1671612666.140:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="samba-bgqd" pid=649 comm="apparmor_parser"
[    7.244869] audit: type=1400 audit(1671612666.160:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="klogd" pid=667 comm="apparmor_parser"
[    7.265226] audit: type=1400 audit(1671612666.180:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="syslogd" pid=683 comm="apparmor_parser"
[    7.286707] audit: type=1400 audit(1671612666.200:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="syslog-ng" pid=695 comm="apparmor_parser"
[    7.289564] hid-generic 0003:17EF:A38F.0002: hiddev96,hidraw1: USB HID v1.11 Device [Cypress Semiconductor 40AS] on usb-0000:06:00.3-1.3.3.1/input1
[    7.312466] audit: type=1400 audit(1671612666.228:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/lessopen.sh" pid=711 comm="apparmor_parser"
[    7.331506] audit: type=1400 audit(1671612666.244:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/apache2/mpm-prefork/apache2" pid=724 comm="apparmor_parser"
[    7.380172] usb 1-1.3.3.2: new full-speed USB device number 9 using xhci_hcd
[    7.412784] Intel(R) Wireless WiFi driver for Linux
[    7.414532] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[    7.458316] SGI XFS with ACLs, security attributes, quota, no debug enabled
[    7.475596] iwlwifi 0000:01:00.0: WRT: Overriding region id 0
[    7.475652] iwlwifi 0000:01:00.0: WRT: Overriding region id 1
[    7.475673] iwlwifi 0000:01:00.0: WRT: Overriding region id 2
[    7.475690] iwlwifi 0000:01:00.0: WRT: Overriding region id 3
[    7.475701] iwlwifi 0000:01:00.0: WRT: Overriding region id 4
[    7.475717] iwlwifi 0000:01:00.0: WRT: Overriding region id 6
[    7.475728] iwlwifi 0000:01:00.0: WRT: Overriding region id 8
[    7.475744] iwlwifi 0000:01:00.0: WRT: Overriding region id 9
[    7.475754] iwlwifi 0000:01:00.0: WRT: Overriding region id 10
[    7.475767] iwlwifi 0000:01:00.0: WRT: Overriding region id 11
[    7.475781] iwlwifi 0000:01:00.0: WRT: Overriding region id 15
[    7.475798] iwlwifi 0000:01:00.0: WRT: Overriding region id 16
[    7.475815] iwlwifi 0000:01:00.0: WRT: Overriding region id 18
[    7.475835] iwlwifi 0000:01:00.0: WRT: Overriding region id 19
[    7.475854] iwlwifi 0000:01:00.0: WRT: Overriding region id 20
[    7.475869] iwlwifi 0000:01:00.0: WRT: Overriding region id 21
[    7.475892] iwlwifi 0000:01:00.0: WRT: Overriding region id 28
[    7.479800] iwlwifi 0000:01:00.0: loaded firmware version 46.4e1ceb39.0 9260-th-b0-jf-b0-46.ucode op_mode iwlmvm
[    7.521685] XFS (nvme0n1p3): Mounting V5 Filesystem fe8a60ac-2e5b-4090-a9eb-d68149568dfb
[    7.539289] XFS (nvme0n1p3): Ending clean mount
[    7.545984] xfs filesystem being mounted at /home supports timestamps until 2038 (0x7fffffff)
[    7.707538] usb 1-1.3.3.2: New USB device found, idVendor=17ef, idProduct=a396, bcdDevice= 0.14
[    7.707546] usb 1-1.3.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.707549] usb 1-1.3.3.2: Product: ThinkPad USB-C Dock Gen2 USB Audio
[    7.707551] usb 1-1.3.3.2: Manufacturer: Lenovo
[    7.707553] usb 1-1.3.3.2: SerialNumber: 000000000000
[    7.796456] ccp 0000:06:00.2: enabling device (0000 -> 0002)
[    7.797127] ccp 0000:06:00.2: ccp enabled
[    7.797142] ccp 0000:06:00.2: psp: unable to access the device: you might be running a broken BIOS.
[    7.820382] SVM: TSC scaling supported
[    7.820392] kvm: Nested Virtualization enabled
[    7.820394] SVM: kvm: Nested Paging enabled
[    7.820400] SEV supported: 16 ASIDs
[    7.820402] SEV-ES supported: 4294967295 ASIDs
[    7.820439] SVM: Virtual VMLOAD VMSAVE supported
[    7.820440] SVM: Virtual GIF supported
[    7.820441] SVM: LBR virtualization supported
[    7.830843] MCE: In-kernel MCE decoding enabled.
[    7.842610] input: Lenovo ThinkPad USB-C Dock Gen2 USB Audio as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-1/1-1.3/1-1.3.3/1-1.3.3.2/1-1.3.3.2:1.3/0003:17EF:A396.0003/input/input12
[    7.865306] iwlwifi 0000:01:00.0: Detected Intel(R) Wireless-AC 9260 160MHz, REV=0x321
[    7.865437] thermal thermal_zone0: failed to read out thermal zone (-61)
[    7.904321] hid-generic 0003:17EF:A396.0003: input,hidraw2: USB HID v1.11 Device [Lenovo ThinkPad USB-C Dock Gen2 USB Audio] on usb-0000:06:00.3-1.3.3.2/input3
[    7.920145] iwlwifi 0000:01:00.0: base HW address: 38:68:93:82:ee:b6, OTP minor version: 0x0
[    7.984215] usb 1-1.3.3.3: new full-speed USB device number 10 using xhci_hcd
[    7.988493] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    8.007181] intel_rapl_common: Found RAPL domain package
[    8.007189] intel_rapl_common: Found RAPL domain core
[    8.101190] usb 1-1.3.3.3: New USB device found, idVendor=05e1, idProduct=2010, bcdDevice= 1.00
[    8.101198] usb 1-1.3.3.3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    8.101202] usb 1-1.3.3.3: Product: USB VoIP Device
[    8.142439] input: USB VoIP Device as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-1/1-1.3/1-1.3.3/1-1.3.3.3/1-1.3.3.3:1.3/0003:05E1:2010.0004/input/input13
[    8.176788] BTRFS warning (device nvme0n1p2): block group 389723193344 has wrong amount of free space
[    8.176798] BTRFS warning (device nvme0n1p2): failed to load free space cache for block group 389723193344, rebuilding it now
[    8.204289] hid-generic 0003:05E1:2010.0004: input,hidraw3: USB HID v1.00 Device [USB VoIP Device] on usb-0000:06:00.3-1.3.3.3/input3
[    8.248649] snd_pci_acp3x 0000:06:00.5: enabling device (0000 -> 0002)
[    8.248874] snd_pci_acp3x 0000:06:00.5: ACP audio mode : 2
[    8.400020] snd_hda_intel 0000:06:00.1: enabling device (0000 -> 0002)
[    8.400198] snd_hda_intel 0000:06:00.1: Handle vga_switcheroo audio client
[    8.400289] snd_hda_intel 0000:06:00.6: enabling device (0000 -> 0002)
[    8.414357] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:06:00.1/sound/card0/input14
[    8.414451] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:06:00.1/sound/card0/input15
[    8.414531] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:06:00.1/sound/card0/input16
[    8.414591] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:06:00.1/sound/card0/input17
[    8.414663] input: HD-Audio Generic HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:08.1/0000:06:00.1/sound/card0/input18
[    8.415093] input: HD-Audio Generic HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:08.1/0000:06:00.1/sound/card0/input19
[    8.429131] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC257: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    8.429140] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    8.429143] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    8.429146] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    8.429148] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    8.429150] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x19
[    8.429152] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
[    8.479647] AMD-Vi: AMD IOMMUv2 loaded and initialized
[    8.541735] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:08.1/0000:06:00.6/sound/card1/input20
[    8.541816] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:06:00.6/sound/card1/input21
[    8.541878] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:08.1/0000:06:00.6/sound/card1/input22
[    8.700222] bpfilter: Loaded bpfilter_umh pid 1479
[    8.700697] Started bpfilter
[    9.052197] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
[   10.545628] mc: Linux media interface: v0.10
[   10.559682] [drm] amdgpu kernel modesetting enabled.
[   10.584065] r8169 0000:03:00.0 eth0: Link is Down
[   10.588097] amdgpu: Topology: Add APU node [0x0:0x0]
[   10.588461] Console: switching to colour dummy device 80x25
[   10.588531] amdgpu 0000:06:00.0: vgaarb: deactivate vga console
[   10.588610] amdgpu 0000:06:00.0: enabling device (0006 -> 0007)
[   10.588710] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15D8 0x17AA:0x5125 0xD1).
[   10.589457] [drm] register mmio base: 0xD0500000
[   10.589462] [drm] register mmio size: 524288
[   10.589583] [drm] add ip block number 0 <soc15_common>
[   10.589585] [drm] add ip block number 1 <gmc_v9_0>
[   10.589587] [drm] add ip block number 2 <vega10_ih>
[   10.589590] [drm] add ip block number 3 <psp>
[   10.589591] [drm] add ip block number 4 <powerplay>
[   10.589594] [drm] add ip block number 5 <dm>
[   10.589596] [drm] add ip block number 6 <gfx_v9_0>
[   10.589599] [drm] add ip block number 7 <sdma_v4_0>
[   10.589601] [drm] add ip block number 8 <vcn_v1_0>
[   10.591078] amdgpu 0000:06:00.0: amdgpu: Fetched VBIOS from VFCT
[   10.591090] amdgpu: ATOM BIOS: 113-PICASSO-114
[   10.593696] [drm] VCN decode is enabled in VM mode
[   10.593704] [drm] VCN encode is enabled in VM mode
[   10.593706] [drm] JPEG decode is enabled in VM mode
[   10.593712] amdgpu 0000:06:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
[   10.593818] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[   10.593834] amdgpu 0000:06:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
[   10.593843] amdgpu 0000:06:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[   10.593849] amdgpu 0000:06:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
[   10.593866] [drm] Detected VRAM RAM=2048M, BAR=2048M
[   10.593869] [drm] RAM width 64bits DDR4
[   10.594114] [drm] amdgpu: 2048M of VRAM memory ready
[   10.594119] [drm] amdgpu: 6932M of GTT memory ready.
[   10.594144] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   10.594404] [drm] PCIE GART of 1024M enabled.
[   10.594408] [drm] PTB located at 0x000000F400A00000
[   10.594808] videodev: Linux video capture interface: v2.00
[   10.607979] amdgpu 0000:06:00.0: amdgpu: PSP runtime database doesn't exist
[   10.608004] amdgpu 0000:06:00.0: amdgpu: PSP runtime database doesn't exist
[   10.608096] amdgpu: hwmgr_sw_init smu backed is smu10_smu
[   10.616215] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY driver (mii_bus:phy_addr=r8169-0-400:00, irq=MAC)
[   10.668577] usb-storage 1-1.3.4:1.0: USB Mass Storage device detected
[   10.668753] scsi host0: usb-storage 1-1.3.4:1.0
[   10.668925] usbcore: registered new interface driver usb-storage
[   10.670752] cdc_acm 1-4:1.1: ttyACM0: USB ACM device
[   10.670867] usbcore: registered new interface driver cdc_acm
[   10.670869] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[   10.694743] [drm] Found VCN firmware Version ENC: 1.12 DEC: 2 VEP: 0 Revision: 1
[   10.694773] amdgpu 0000:06:00.0: amdgpu: Will use PSP to load VCN firmware
[   10.697988] usb 4-2.1: Found UVC 1.50 device Integrated Camera (13d3:56bc)
[   10.707279] input: Integrated Camera: Integrated C as /devices/pci0000:00/0000:00:08.1/0000:06:00.4/usb4/4-2/4-2.1/4-2.1:1.0/input/input23
[   10.709484] usb 4-2.1: Found UVC 1.50 device Integrated Camera (13d3:56bc)
[   10.711864] input: Integrated Camera: Integrated I as /devices/pci0000:00/0000:00:08.1/0000:06:00.4/usb4/4-2/4-2.1/4-2.1:1.2/input/input24
[   10.711960] usbcore: registered new interface driver uvcvideo
[   10.715542] [drm] reserve 0x400000 from 0xf401c00000 for PSP TMR
[   10.729022] usbcore: registered new interface driver uas
[   10.735858] Bluetooth: Core ver 2.22
[   10.735919] NET: Registered PF_BLUETOOTH protocol family
[   10.735921] Bluetooth: HCI device and connection manager initialized
[   10.735929] Bluetooth: HCI socket layer initialized
[   10.735937] Bluetooth: L2CAP socket layer initialized
[   10.735943] Bluetooth: SCO socket layer initialized
[   10.772469] usbcore: registered new interface driver r8152
[   10.779398] usbcore: registered new interface driver cdc_ether
[   10.805197] r8169 0000:04:00.0 eth1: Link is Down
[   10.817539] amdgpu 0000:06:00.0: amdgpu: RAS: optional ras ta ucode is not available
[   10.832471] amdgpu 0000:06:00.0: amdgpu: RAP: optional rap ta ucode is not available
[   10.832481] amdgpu 0000:06:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[   10.833453] [drm] DM_PPLIB: values for F clock
[   10.833456] [drm] DM_PPLIB:	 400000 in kHz, 2749 in mV
[   10.833457] [drm] DM_PPLIB:	 933000 in kHz, 3224 in mV
[   10.833459] [drm] DM_PPLIB:	 1067000 in kHz, 3924 in mV
[   10.833460] [drm] DM_PPLIB:	 1200000 in kHz, 4074 in mV
[   10.833461] [drm] DM_PPLIB: values for DCF clock
[   10.833462] [drm] DM_PPLIB:	 300000 in kHz, 2749 in mV
[   10.833463] [drm] DM_PPLIB:	 600000 in kHz, 3224 in mV
[   10.833464] [drm] DM_PPLIB:	 626000 in kHz, 3924 in mV
[   10.833465] [drm] DM_PPLIB:	 654000 in kHz, 4074 in mV
[   10.833837] [drm] Display Core initialized with v3.2.215!
[   10.839945] snd_hda_intel 0000:06:00.1: bound 0000:06:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[   10.867074] usbcore: registered new interface driver btusb
[   10.871908] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
[   10.875916] Bluetooth: hci0: Device revision is 2
[   10.875921] Bluetooth: hci0: Secure boot is enabled
[   10.875922] Bluetooth: hci0: OTP lock is enabled
[   10.875923] Bluetooth: hci0: API lock is enabled
[   10.875924] Bluetooth: hci0: Debug lock is disabled
[   10.875925] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   10.899541] [drm] kiq ring mec 2 pipe 1 q 0
[   10.904426] usb 3-1.1: reset SuperSpeed USB device number 4 using xhci_hcd
[   10.910033] Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
[   10.910074] Bluetooth: hci0: Boot Address: 0x40800
[   10.910076] Bluetooth: hci0: Firmware Version: 86-46.21
[   10.911114] [drm] VCN decode and encode initialized successfully(under SPG Mode).
[   10.913840] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[   10.913907] amdgpu: sdma_bitmap: 3
[   10.914555] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.914561] Bluetooth: BNEP filters: protocol multicast
[   10.914570] Bluetooth: BNEP socket layer initialized
[   10.938512] r8152 3-1.1:1.0 (unnamed net_device) (uninitialized): Invalid header when reading pass-thru MAC addr
[   10.949075] memmap_init_zone_device initialised 524288 pages in 8ms
[   10.949088] amdgpu: HMM registered 2048MB device memory
[   10.949188] amdgpu: Topology: Add APU node [0x15d8:0x1002]
[   10.949193] kfd kfd: amdgpu: added device 1002:15d8
[   10.949464] amdgpu 0000:06:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 11, active_cu_number 10
[   10.949639] amdgpu 0000:06:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[   10.949643] amdgpu 0000:06:00.0: amdgpu: ring gfx_low uses VM inv eng 1 on hub 0
[   10.949646] amdgpu 0000:06:00.0: amdgpu: ring gfx_high uses VM inv eng 4 on hub 0
[   10.949649] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 5 on hub 0
[   10.949652] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 6 on hub 0
[   10.949655] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 7 on hub 0
[   10.949658] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 8 on hub 0
[   10.949661] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 9 on hub 0
[   10.949663] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 10 on hub 0
[   10.949666] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 11 on hub 0
[   10.949669] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 12 on hub 0
[   10.949671] amdgpu 0000:06:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 13 on hub 0
[   10.949674] amdgpu 0000:06:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[   10.949677] amdgpu 0000:06:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
[   10.949679] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
[   10.949682] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
[   10.949685] amdgpu 0000:06:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
[   10.956466] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[   10.956686] [drm] Initialized amdgpu 3.49.0 20150101 for 0000:06:00.0 on minor 0
[   11.058090] r8152 3-1.1:1.0 eth2: v1.12.13
[   11.265844] r8152 3-1.1:1.0 eth3: renamed from eth2
[   11.432659] usbcore: registered new interface driver snd-usb-audio
[   11.442929] NET: Registered PF_PACKET protocol family
[   11.468176] [drm] Fence fallback timer expired on ring gfx
[   11.477662] fbcon: amdgpudrmfb (fb0) is primary device
[   11.507121] Console: switching to colour frame buffer device 240x67
[   11.526709] amdgpu 0000:06:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[   11.701339] scsi 0:0:0:0: CD-ROM            TSSTcorp CDDVDW SE-S084C  TS00 PQ: 0 ANSI: 0
[   11.701574] scsi 0:0:0:0: Attached scsi generic sg0 type 5
[   11.719195] sr 0:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   11.719206] cdrom: Uniform CD-ROM driver Revision: 3.20
[   11.722029] sr 0:0:0:0: Attached scsi CD-ROM sr0
[   12.131141] Bluetooth: hci0: Waiting for firmware download to complete
[   12.131877] Bluetooth: hci0: Firmware loaded in 1193200 usecs
[   12.131938] Bluetooth: hci0: Waiting for device to boot
[   12.148884] Bluetooth: hci0: Device booted in 16570 usecs
[   12.148884] Bluetooth: hci0: Malformed MSFT vendor event: 0x02, length requested 9 length available 6
[   12.148934] Buggy packet:00 02 01 02 ff 01
[   12.148958] CPU: 2 PID: 1266 Comm: kworker/u33:1 Tainted: G            E      6.1.0-59.40-default+ #336
[   12.148966] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS R12ET55W(1.25 ) 07/06/2020
[   12.148969] Workqueue: hci0 hci_rx_work [bluetooth]
[   12.149051] Call Trace:
[   12.149055]  <TASK>
[   12.149059]  dump_stack_lvl+0x44/0x5c
[   12.149072]  msft_skb_pull+0x97/0xa0 [bluetooth]
[   12.149178]  msft_vendor_evt+0x115/0x2f0 [bluetooth]
[   12.149273]  hci_event_packet+0x2d1/0x560 [bluetooth]
[   12.149361]  ? __pfx_msft_vendor_evt+0x10/0x10 [bluetooth]
[   12.149455]  hci_rx_work+0x29f/0x580 [bluetooth]
[   12.149528]  ? __schedule+0x323/0x9c0
[   12.149537]  process_one_work+0x226/0x440
[   12.149547]  worker_thread+0x2a/0x3b0
[   12.149554]  ? __pfx_worker_thread+0x10/0x10
[   12.149560]  kthread+0xe8/0x110
[   12.149566]  ? __pfx_kthread+0x10/0x10
[   12.149572]  ret_from_fork+0x2c/0x50
[   12.149585]  </TASK>
[   12.155280] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-18-16-1.ddc
[   12.162893] Bluetooth: hci0: Applying Intel DDC parameters completed
[   12.166895] Bluetooth: hci0: Firmware revision 0.1 build 86 week 46 2021
[   12.356213] Bluetooth: MGMT ver 1.22
[   12.369178] NET: Registered PF_ALG protocol family
[   12.416997] r8169 0000:04:00.0 eth1: Link is Up - 100Mbps/Full - flow control rx/tx
[   12.417015] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   30.129422] Bluetooth: RFCOMM TTY layer initialized
[   30.129449] Bluetooth: RFCOMM socket layer initialized
[   30.129462] Bluetooth: RFCOMM ver 1.11
[   30.857572] retire_capture_urb: 16 callbacks suppressed
[   85.165538] wlan0: authenticate with cc:ce:1e:f4:37:95
[   85.165566] wlan0: 80 MHz not supported, disabling VHT
[   85.177188] wlan0: send auth to cc:ce:1e:f4:37:95 (try 1/3)
[   85.219480] wlan0: authenticated
[   85.222577] wlan0: associate with cc:ce:1e:f4:37:95 (try 1/3)
[   85.326497] wlan0: associate with cc:ce:1e:f4:37:95 (try 2/3)
[   85.390791] wlan0: RX AssocResp from cc:ce:1e:f4:37:95 (capab=0x1431 status=0 aid=3)
[   85.394573] wlan0: associated
[   85.505835] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by cc:ce:1e:f4:37:95
[   86.754805] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   94.270493] wlan0: deauthenticating from cc:ce:1e:f4:37:95 by local choice (Reason: 3=DEAUTH_LEAVING)
[  627.998853] BTRFS info (device nvme0n1p2): qgroup scan completed (inconsistency flag cleared)
[ 1813.581113] tun: Universal TUN/TAP device driver, 1.6
[ 6725.191863] usb 1-2: USB disconnect, device number 3
[ 6739.075535] usb 1-2: new low-speed USB device number 11 using xhci_hcd
[ 6739.236721] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[ 6739.236733] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[ 6739.264026] usbhid 1-2:1.0: can't add hid device: -71
[ 6739.264041] usbhid: probe of 1-2:1.0 failed with error -71
[ 6751.945985] usb 1-2: USB disconnect, device number 11
[ 6752.479604] usb 1-2: new low-speed USB device number 12 using xhci_hcd
[ 6752.640737] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[ 6752.640744] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[ 6752.669028] usbhid 1-2:1.0: can't add hid device: -71
[ 6752.669041] usbhid: probe of 1-2:1.0 failed with error -71
[ 6754.485603] usb 1-2: USB disconnect, device number 12
[ 6755.311631] usb 1-2: new low-speed USB device number 13 using xhci_hcd
[ 6755.439648] usb 1-2: device descriptor read/64, error -71
[ 6755.708816] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[ 6755.708828] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[ 6755.732590] usb 1-2: can't set config #1, error -71
[ 6972.445031] usb 1-2: USB disconnect, device number 13
[ 6975.388714] usb usb1-port2: connect-debounce failed
[ 7407.906756] usb 1-2: new low-speed USB device number 14 using xhci_hcd
[ 7408.034767] usb 1-2: device descriptor read/64, error -71
[ 7408.278770] usb 1-2: device descriptor read/64, error -71
[ 7408.518740] usb 1-2: new low-speed USB device number 15 using xhci_hcd
[ 7408.854805] usb 1-2: device descriptor read/64, error -71
[ 7409.098780] usb 1-2: device descriptor read/64, error -71
[ 7409.207251] usb usb1-port2: attempt power cycle
[ 7409.622750] usb 1-2: new low-speed USB device number 16 using xhci_hcd
[ 7409.665303] usb 1-2: unable to read config index 0 descriptor/all
[ 7409.665309] usb 1-2: can't read configurations, error -71
[ 7409.790753] usb 1-2: new low-speed USB device number 17 using xhci_hcd
[ 7409.834240] usb 1-2: unable to read config index 0 descriptor/all
[ 7409.834246] usb 1-2: can't read configurations, error -71
[ 7409.834314] usb usb1-port2: unable to enumerate USB device
[ 7614.467769] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 7615.028573] r8169 0000:04:00.0 eth1: Link is Down
[ 7615.116439] PM: suspend entry (deep)
[ 7615.134747] Filesystems sync: 0.018 seconds
[ 7615.183349] Freezing user space processes
[ 7615.186226] Freezing user space processes completed (elapsed 0.002 seconds)
[ 7615.186232] OOM killer disabled.
[ 7615.186234] Freezing remaining freezable tasks
[ 7615.187754] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[ 7615.187784] printk: Suspending console(s) (use no_console_suspend to debug)
[ 7616.096329] ACPI: EC: interrupt blocked
[ 7616.164711] ACPI: PM: Preparing to enter system sleep state S3
[ 7616.170738] ACPI: EC: event blocked
[ 7616.170740] ACPI: EC: EC stopped
[ 7616.170740] ACPI: PM: Saving platform NVS memory
[ 7616.170968] Disabling non-boot CPUs ...
[ 7616.172900] smpboot: CPU 1 is now offline
[ 7616.174972] smpboot: CPU 2 is now offline
[ 7616.176852] smpboot: CPU 3 is now offline
[ 7616.179050] smpboot: CPU 4 is now offline
[ 7616.180864] smpboot: CPU 5 is now offline
[ 7616.182958] smpboot: CPU 6 is now offline
[ 7616.184882] smpboot: CPU 7 is now offline
[ 7616.185669] ACPI: PM: Low-level resume complete
[ 7616.185698] ACPI: EC: EC started
[ 7616.185699] ACPI: PM: Restoring platform NVS memory
[ 7616.214499] AMD-Vi: Virtual APIC enabled
[ 7616.214595] AMD-Vi: Virtual APIC enabled
[ 7616.215156] Enabling non-boot CPUs ...
[ 7616.215205] x86: Booting SMP configuration:
[ 7616.215206] smpboot: Booting Node 0 Processor 1 APIC 0x1
[ 7616.217702] ACPI: \_PR_.C001: Found 2 idle states
[ 7616.218048] CPU1 is up
[ 7616.218131] smpboot: Booting Node 0 Processor 2 APIC 0x2
[ 7616.220585] ACPI: \_PR_.C002: Found 2 idle states
[ 7616.220965] CPU2 is up
[ 7616.220986] smpboot: Booting Node 0 Processor 3 APIC 0x3
[ 7616.223437] ACPI: \_PR_.C003: Found 2 idle states
[ 7616.223838] CPU3 is up
[ 7616.223863] smpboot: Booting Node 0 Processor 4 APIC 0x4
[ 7616.226365] ACPI: \_PR_.C004: Found 2 idle states
[ 7616.226889] CPU4 is up
[ 7616.226914] smpboot: Booting Node 0 Processor 5 APIC 0x5
[ 7616.229424] ACPI: \_PR_.C005: Found 2 idle states
[ 7616.230044] CPU5 is up
[ 7616.230061] smpboot: Booting Node 0 Processor 6 APIC 0x6
[ 7616.232581] ACPI: \_PR_.C006: Found 2 idle states
[ 7616.233316] CPU6 is up
[ 7616.233343] smpboot: Booting Node 0 Processor 7 APIC 0x7
[ 7616.235885] ACPI: \_PR_.C007: Found 2 idle states
[ 7616.236845] CPU7 is up
[ 7616.239046] ACPI: PM: Waking up from system sleep state S3
[ 7616.794327] ACPI: EC: interrupt unblocked
[ 7616.867042] ACPI: EC: event unblocked
[ 7616.867293] usb usb2: root hub lost power or was reset
[ 7616.868756] [drm] PCIE GART of 1024M enabled.
[ 7616.868760] [drm] PTB located at 0x000000F400A00000
[ 7616.868778] [drm] PSP is resuming...
[ 7616.888763] [drm] reserve 0x400000 from 0xf401c00000 for PSP TMR
[ 7616.992229] amdgpu 0000:06:00.0: amdgpu: RAS: optional ras ta ucode is not available
[ 7617.006393] amdgpu 0000:06:00.0: amdgpu: RAP: optional rap ta ucode is not available
[ 7617.006394] amdgpu 0000:06:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[ 7617.006480] amdgpu: restore the fine grain parameters
[ 7617.155732] usb 4-2: reset high-speed USB device number 3 using xhci_hcd
[ 7617.157539] nvme nvme0: 16/0/0 default/read/poll queues
[ 7617.315984] usb 1-1.3.3.1: reset full-speed USB device number 8 using xhci_hcd
[ 7617.431663] usb 4-1: reset full-speed USB device number 2 using xhci_hcd
[ 7617.667638] usb 4-2.4: reset full-speed USB device number 6 using xhci_hcd
[ 7617.681194] [drm] kiq ring mec 2 pipe 1 q 0
[ 7617.692539] [drm] VCN decode and encode initialized successfully(under SPG Mode).
[ 7617.692553] amdgpu 0000:06:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[ 7617.692555] amdgpu 0000:06:00.0: amdgpu: ring gfx_low uses VM inv eng 1 on hub 0
[ 7617.692557] amdgpu 0000:06:00.0: amdgpu: ring gfx_high uses VM inv eng 4 on hub 0
[ 7617.692559] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 5 on hub 0
[ 7617.692560] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 6 on hub 0
[ 7617.692561] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 7 on hub 0
[ 7617.692562] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 8 on hub 0
[ 7617.692564] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 9 on hub 0
[ 7617.692565] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 10 on hub 0
[ 7617.692566] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 11 on hub 0
[ 7617.692568] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 12 on hub 0
[ 7617.692569] amdgpu 0000:06:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 13 on hub 0
[ 7617.692570] amdgpu 0000:06:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[ 7617.692571] amdgpu 0000:06:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
[ 7617.692573] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
[ 7617.692574] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
[ 7617.692575] amdgpu 0000:06:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
[ 7617.766376] psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
[ 7617.810400] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
[ 7617.860047] usb 4-2.1: reset high-speed USB device number 4 using xhci_hcd
[ 7618.051873] usb 4-2.2: reset full-speed USB device number 5 using xhci_hcd
[ 7618.217705] [drm] Fence fallback timer expired on ring gfx
[ 7619.860089] OOM killer enabled.
[ 7619.860094] Restarting tasks ...
[ 7619.860129] pci_bus 0000:01: Allocating resources
[ 7619.860178] pci_bus 0000:02: Allocating resources
[ 7619.860183] pcieport 0000:00:01.3: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
[ 7619.860187] pcieport 0000:00:01.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[ 7619.860196] pci_bus 0000:03: Allocating resources
[ 7619.860213] pcieport 0000:00:01.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[ 7619.860221] pci_bus 0000:04: Allocating resources
[ 7619.860225] pcieport 0000:00:01.6: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 100000
[ 7619.860233] pci_bus 0000:05: Allocating resources
[ 7619.860238] pcieport 0000:00:01.7: bridge window [io  0x1000-0x0fff] to [bus 05] add_size 1000
[ 7619.860240] pcieport 0000:00:01.7: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 05] add_size 200000 add_align 100000
[ 7619.860250] pcieport 0000:00:01.3: BAR 15: assigned [mem 0xd0d00000-0xd0efffff 64bit pref]
[ 7619.860253] pcieport 0000:00:01.4: BAR 15: assigned [mem 0xd0f00000-0xd10fffff 64bit pref]
[ 7619.860256] pcieport 0000:00:01.6: BAR 15: assigned [mem 0xd1100000-0xd12fffff 64bit pref]
[ 7619.860258] pcieport 0000:00:01.7: BAR 15: assigned [mem 0xd1300000-0xd14fffff 64bit pref]
[ 7619.860264] pcieport 0000:00:01.3: BAR 13: assigned [io  0x5000-0x5fff]
[ 7619.860266] pcieport 0000:00:01.7: BAR 13: assigned [io  0x6000-0x6fff]
[ 7619.860672] pci_bus 0000:06: Allocating resources
[ 7619.862646] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
[ 7619.865551] done.
[ 7619.865644] random: crng reseeded on system resumption
[ 7619.869601] Bluetooth: hci0: Device revision is 2
[ 7619.869611] Bluetooth: hci0: Secure boot is enabled
[ 7619.869613] Bluetooth: hci0: OTP lock is enabled
[ 7619.869614] Bluetooth: hci0: API lock is enabled
[ 7619.869616] Bluetooth: hci0: Debug lock is disabled
[ 7619.869617] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ 7619.869628] Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
[ 7619.869715] Bluetooth: hci0: Boot Address: 0x40800
[ 7619.869717] Bluetooth: hci0: Firmware Version: 86-46.21
[ 7619.904253] PM: suspend exit
[ 7619.989517] usb 1-2: new low-speed USB device number 18 using xhci_hcd
[ 7620.129529] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
[ 7620.153704] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[ 7620.153710] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[ 7620.179105] input: HID 1241:1166 as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-2/1-2:1.0/0003:1241:1166.0005/input/input25
[ 7620.179296] hid-generic 0003:1241:1166.0005: input,hidraw0: USB HID v1.10 Mouse [HID 1241:1166] on usb-0000:06:00.3-2/input0
[ 7620.179450] usb 1-4: USB disconnect, device number 4
[ 7620.255319] r8169 0000:03:00.0 eth0: Link is Down
[ 7620.285523] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY driver (mii_bus:phy_addr=r8169-0-400:00, irq=MAC)
[ 7620.481792] r8169 0000:04:00.0 eth1: Link is Down
[ 7621.100855] Bluetooth: hci0: Waiting for firmware download to complete
[ 7621.101542] Bluetooth: hci0: Firmware loaded in 1203031 usecs
[ 7621.101564] Bluetooth: hci0: Waiting for device to boot
[ 7621.118556] Bluetooth: hci0: Device booted in 16608 usecs
[ 7621.118561] Bluetooth: hci0: Malformed MSFT vendor event: 0x02, length requested 9 length available 6
[ 7621.118567] Buggy packet:00 02 01 02 ff 01
[ 7621.118571] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-18-16-1.ddc
[ 7621.118570] CPU: 1 PID: 126 Comm: kworker/u33:0 Tainted: G            E      6.1.0-59.40-default+ #336
[ 7621.118574] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS R12ET55W(1.25 ) 07/06/2020
[ 7621.118576] Workqueue: hci0 hci_rx_work [bluetooth]
[ 7621.118624] Call Trace:
[ 7621.118627]  <TASK>
[ 7621.118630]  dump_stack_lvl+0x44/0x5c
[ 7621.118638]  msft_skb_pull+0x97/0xa0 [bluetooth]
[ 7621.118682]  msft_vendor_evt+0x115/0x2f0 [bluetooth]
[ 7621.118721]  hci_event_packet+0x2d1/0x560 [bluetooth]
[ 7621.118757]  ? __pfx_msft_vendor_evt+0x10/0x10 [bluetooth]
[ 7621.118796]  hci_rx_work+0x29f/0x580 [bluetooth]
[ 7621.118825]  ? __schedule+0x323/0x9c0
[ 7621.118829]  process_one_work+0x226/0x440
[ 7621.118834]  worker_thread+0x2a/0x3b0
[ 7621.118837]  ? __pfx_worker_thread+0x10/0x10
[ 7621.118840]  kthread+0xe8/0x110
[ 7621.118843]  ? __pfx_kthread+0x10/0x10
[ 7621.118845]  ret_from_fork+0x2c/0x50
[ 7621.118852]  </TASK>
[ 7621.126573] Bluetooth: hci0: Applying Intel DDC parameters completed
[ 7621.130561] Bluetooth: hci0: Firmware revision 0.1 build 86 week 46 2021
[ 7621.319620] Bluetooth: MGMT ver 1.22
[ 7622.103319] r8169 0000:04:00.0 eth1: Link is Up - 100Mbps/Full - flow control rx/tx
[ 7622.103335] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[ 7916.133779] usb usb1-port2: disabled by hub (EMI?), re-enabling...
[ 7916.133788] usb 1-2: USB disconnect, device number 18
[ 7919.978718] usb 1-2: new full-speed USB device number 19 using xhci_hcd
[ 7920.148833] usb 1-2: New USB device found, idVendor=096e, idProduct=0858, bcdDevice=32.04
[ 7920.148843] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 7920.148847] usb 1-2: Product: FIDO
[ 7920.148851] usb 1-2: Manufacturer: FT
[ 7920.170422] hid-generic 0003:096E:0858.0006: hiddev97,hidraw0: USB HID v1.10 Device [FT FIDO] on usb-0000:06:00.3-2/input0
[ 7924.535576] usb 1-2: USB disconnect, device number 19
[ 7930.190273] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 7934.306785] usb 1-2: new low-speed USB device number 20 using xhci_hcd
[ 7934.471922] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[ 7934.471931] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[ 7934.499041] input: HID 1241:1166 as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-2/1-2:1.0/0003:1241:1166.0007/input/input26
[ 7934.499181] hid-generic 0003:1241:1166.0007: input,hidraw0: USB HID v1.10 Mouse [HID 1241:1166] on usb-0000:06:00.3-2/input0
[ 7963.854904] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8028.710877] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8091.622974] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8155.838982] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8161.373397] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8217.742984] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8279.851144] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8344.659247] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8408.011374] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8471.819494] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8533.783734] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8595.823771] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8660.687949] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8673.380783] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8723.656882] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8787.836216] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8849.588293] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8911.849249] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 8976.744592] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9039.716993] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9066.048799] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9103.828827] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9165.613035] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9227.847300] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9292.759300] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9355.573390] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9419.942360] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9481.909668] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9543.817807] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9608.574248] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9615.050011] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9671.690177] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9735.866300] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9797.841857] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9859.822555] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9924.722700] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[ 9987.686665] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10051.890883] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10113.867052] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10159.062616] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10175.807115] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10240.795397] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10303.863461] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10367.979507] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10429.839779] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10491.855832] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10556.823955] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10619.856112] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10684.012234] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10688.056229] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10745.828402] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10807.868464] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10866.024593] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10872.824657] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[10935.808793] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11000.008889] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11061.757078] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11123.829612] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11139.885234] usb 1-2: USB disconnect, device number 20
[11140.221143] usb 1-2: new low-speed USB device number 21 using xhci_hcd
[11140.382018] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[11140.382025] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[11140.413508] input: HID 1241:1166 as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-2/1-2:1.0/0003:1241:1166.0008/input/input27
[11140.413843] hid-generic 0003:1241:1166.0008: input,hidraw0: USB HID v1.10 Mouse [HID 1241:1166] on usb-0000:06:00.3-2/input0
[11188.069503] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11221.382898] usb 1-2: USB disconnect, device number 21
[11221.729328] usb 1-2: new low-speed USB device number 22 using xhci_hcd
[11221.890073] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[11221.890081] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[11221.917290] input: HID 1241:1166 as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-2/1-2:1.0/0003:1241:1166.0009/input/input28
[11221.917463] hid-generic 0003:1241:1166.0009: input,hidraw0: USB HID v1.10 Mouse [HID 1241:1166] on usb-0000:06:00.3-2/input0
[11249.747236] usb 1-2: USB disconnect, device number 22
[11250.157422] usb 1-2: new low-speed USB device number 23 using xhci_hcd
[11250.322188] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[11250.322203] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[11250.349290] input: HID 1241:1166 as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-2/1-2:1.0/0003:1241:1166.000A/input/input29
[11250.349485] hid-generic 0003:1241:1166.000A: input,hidraw0: USB HID v1.10 Mouse [HID 1241:1166] on usb-0000:06:00.3-2/input0
[11250.877734] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11314.986344] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11376.797820] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11391.694977] usb 1-2: USB disconnect, device number 23
[11392.037706] usb 1-2: new low-speed USB device number 24 using xhci_hcd
[11392.199186] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[11392.199194] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[11392.229431] input: HID 1241:1166 as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-2/1-2:1.0/0003:1241:1166.000B/input/input30
[11392.229584] hid-generic 0003:1241:1166.000B: input,hidraw0: USB HID v1.10 Mouse [HID 1241:1166] on usb-0000:06:00.3-2/input0
[11399.031520] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11438.829856] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11503.764678] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11566.807010] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11631.001684] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11692.794475] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11754.842716] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11819.854838] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11882.794853] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11942.035206] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[11946.911019] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12008.667170] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12070.843358] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12135.563472] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12198.727595] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12262.927813] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12324.742533] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12386.856278] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12445.108179] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12451.655717] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12514.636427] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12578.948651] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12640.763943] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12666.124790] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12702.856824] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12767.964989] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12830.693117] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12894.925437] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[12956.873508] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13018.885700] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13083.861799] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13146.966015] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13185.126074] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13210.930402] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13272.886345] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13334.811313] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13399.872061] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13462.958800] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13526.931005] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13589.099219] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13605.437965] usb 1-2: USB disconnect, device number 24
[13605.787145] usb 1-2: new low-speed USB device number 25 using xhci_hcd
[13605.951708] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[13605.951719] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[13605.983003] input: HID 1241:1166 as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-2/1-2:1.0/0003:1241:1166.000C/input/input31
[13605.983258] hid-generic 0003:1241:1166.000C: input,hidraw0: USB HID v1.10 Mouse [HID 1241:1166] on usb-0000:06:00.3-2/input0
[13636.209289] usb 1-2: USB disconnect, device number 25
[13636.579235] usb 1-2: new low-speed USB device number 26 using xhci_hcd
[13636.739641] usb 1-2: New USB device found, idVendor=1241, idProduct=1166, bcdDevice= 2.70
[13636.739653] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[13636.766935] input: HID 1241:1166 as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-2/1-2:1.0/0003:1241:1166.000D/input/input32
[13636.767090] hid-generic 0003:1241:1166.000D: input,hidraw0: USB HID v1.10 Mouse [HID 1241:1166] on usb-0000:06:00.3-2/input0
[13648.128120] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13714.863495] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13777.823272] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13841.923848] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13903.872055] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13965.856124] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[13991.917467] BTRFS warning (device nvme0n1p2): error accounting new delayed refs extent (err code: -5), quota inconsistent
[14031.001921] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14094.040593] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14157.932684] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14219.720885] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14281.865889] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14346.873255] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14409.849352] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14465.863789] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14473.953574] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14535.901759] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14597.861880] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[14663.000820] r8152 3-1.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
