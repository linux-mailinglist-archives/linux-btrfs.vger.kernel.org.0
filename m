Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2C1418D0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 01:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhIZXVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Sep 2021 19:21:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11838 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhIZXVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Sep 2021 19:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632698394; x=1664234394;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qUyASLd4ErlemiDdQwNkxmbacch8zoRYbU9RNtFnT8Y=;
  b=MAqgAQKMptSm4HgDee7Nc2T/A2AtRkGmqgLX55AT2H8oxuQjeTT50xsR
   XzYVdd+k4xGGNVpXwBL/iTDcAL8SYrCxbPkFa+Hwo7KTywcxNBXb6GjnP
   TYpiv/cTwfmYVnw6m+0cQ+AFIdlwqWRJEE8Ik19I3aeV6EkGarfto8XUd
   K6CVNyBxeytppUqyxw+TWh/QK7wB1DIs37BV7gi1loI9e37BaIxJxUtRj
   yWVB16eE2Q7C+pAioze7JkgKHxwwax9QHC7PrFCA7BO673xs51DCzGtHC
   uHDDL8FgcdsziXoRqdgUSQBkVD64ct0znuiRqF+2qrPV3tb8PaTU5HROd
   w==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="180073828"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 07:19:54 +0800
IronPort-SDR: rtF3HnfkEC/a0oEKpOxXgfItmmPy5+Cxe7LA3AdYVYsEIdHcPjgu4vB8TzMQLFdq8Yv7DMdKdY
 85rTaZp3+XBNXuYXabDjh2+QNo/VBtKSJRaIRDVD/jp/+UElUfRavOHJrQDqqxcOwzBakZfjLF
 LSUfIl2OrtHkJW7Ga7WMl1JljI35lJAqCScOP6jIOaZusB6XW78crfkXWefgpp+l7f46BwIRFw
 YFOFtf9JEdD3cE7PhOfLeNb7lHpXaNITwh5nRBPI6NkE8OoI6ojKFRrLfCsFglc/WucR/c0rLm
 YVLiLSY+vY6OSINwHpBPbOet
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 15:56:01 -0700
IronPort-SDR: eIhXczUOFJREpVFkR3C4dRadyX2Qx5UZ29lNeTsSOeF0DxvkBjcmW4RHdSTzbq3FKAsB38sDZB
 PZov/YdbFwsa4SByhpdRxzozL2P5gtkPAq+jav65NtSciU3f/MA7RaTiwo04dnjaELFrv6ywsv
 9vkRzAKdJLupvfifI8ANTlIa5quMZlFBeotGOsD0NgCxuJ7916H96975zmjK9CiGXbnLG/GWWa
 GalSJCuIPleiCR9FP4qidWDSQ0PQeGAY76K2gR7xTCG1SfW82hhB7tDwWiPSApMN5fp/yWLfTb
 Tik=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 16:19:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HHhZ219LCz1Rvlf
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Sep 2021 16:19:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632698393; x=1635290394; bh=qUyASLd4ErlemiDdQwNkxmbacch8zoRYbU9
        RNtFnT8Y=; b=mz4/hvxf7pDIjbOUsOTuCzXNKrYZ+WGbyOp75IFPpAhjpgQ+ooq
        56sZoUOLnegNxlRb9foNYSURz9j09V+kHCdLJu6Hbtrk4uJA2b76bE1RvrOcHROi
        dji2fekRHLYk+XLdz0hY/A7NaVJz3NLItjWFSFAz7es3x1MVSw5XQnOMgKq/oj4W
        8t0EZBDqgOeSdcsugevLJ3h1RVKdFBNbHVhdJSyeOjsCgwhXK1PpQz7wOIEX6GQs
        kHPvqVaWYoBI70E2LC/b92DNgyAzP27jEHXWOwQ5Db01OjfP0GGfMZ79XLezK4F1
        Jj+66cFLACYi+rLJs7mQNX7RK53afW8Ojtw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dZmsrKIRdAqT for <linux-btrfs@vger.kernel.org>;
        Sun, 26 Sep 2021 16:19:53 -0700 (PDT)
Received: from [10.89.85.1] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HHhZ05VFjz1RvTg;
        Sun, 26 Sep 2021 16:19:52 -0700 (PDT)
Message-ID: <6db88069-e263-ae85-4f69-adb9ec69ee76@opensource.wdc.com>
Date:   Mon, 27 Sep 2021 08:19:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: Host managed SMR drive issue
Content-Language: en-US
To:     Sven Oehme <oehmes@gmail.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <CALssuR00NvTHJJuoOFhw=4+fHARtBN2PLqTr4W06PT5VMagh_A@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CALssuR00NvTHJJuoOFhw=4+fHARtBN2PLqTr4W06PT5VMagh_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/09/25 3:25, Sven Oehme wrote:
> Hi,
> 
> i am running into issues with Host Managed SMR drive testing. when i
> try to copy or move a file to the btrfs filesystem it just hangs. i
> tried multiple 5.12,5.13 as well as 5.14 all the way to 5.14.6 but the
> issue still persists.
> 
> here is the setup :
> 
> I am using btrfs-progs-v5.14.1
> device is a  Host Managed WDC  20TB SMR drive with firmware level C421
> its connected via a HBA 9400-8i Tri-Mode Storage Adapter , latest 20.0 FW

Beware of the Broadcom FW rev 20. We found problems with it: very slow zone
command scheduling leading to command timeout is some cases. FW 19 does not seem
to have this issue. But that is likely not the cause of the problem here.

Is there anything of interest in dmesg ? Any IO errors ?

Naohiro, Johannes,

Any idea ?



> I am using the /dev/sd device direct  , no lvm or device mapper or
> anything else in between
> 
> after a few seconds, sometimes minutes data rate to the drive drops to
> 0 and 1 or 2 cores on my system show 100% IO wait time, but no longer
> make any progress
> 
> the process in question has the following stack :
> 
> [ 2168.589160] task:mv              state:D stack:    0 pid: 3814
> ppid:  3679 flags:0x00004000
> [ 2168.589162] Call Trace:
> [ 2168.589163]  __schedule+0x2fa/0x910
> [ 2168.589166]  schedule+0x4f/0xc0
> [ 2168.589168]  schedule_timeout+0x8a/0x140
> [ 2168.589171]  ? __bpf_trace_tick_stop+0x10/0x10
> [ 2168.589173]  io_schedule_timeout+0x51/0x80
> [ 2168.589176]  balance_dirty_pages+0x2fa/0xe30
> [ 2168.589179]  ? __mod_lruvec_state+0x3a/0x50
> [ 2168.589182]  balance_dirty_pages_ratelimited+0x2f9/0x3c0
> [ 2168.589185]  btrfs_buffered_write+0x58e/0x7e0 [btrfs]
> [ 2168.589226]  btrfs_file_write_iter+0x138/0x3e0 [btrfs]
> [ 2168.589260]  ? ext4_file_read_iter+0x5b/0x180
> [ 2168.589262]  new_sync_write+0x114/0x1a0
> [ 2168.589265]  vfs_write+0x1c5/0x260
> [ 2168.589267]  ksys_write+0x67/0xe0
> [ 2168.589270]  __x64_sys_write+0x1a/0x20
> [ 2168.589272]  do_syscall_64+0x40/0xb0
> [ 2168.589275]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 2168.589277] RIP: 0033:0x7ffff7e91c27
> [ 2168.589278] RSP: 002b:00007fffffffdc48 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 2168.589280] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007ffff7e91c27
> [ 2168.589281] RDX: 0000000000020000 RSI: 00007ffff79bd000 RDI: 0000000000000004
> [ 2168.589282] RBP: 00007ffff79bd000 R08: 0000000000000000 R09: 0000000000000000
> [ 2168.589283] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000004
> [ 2168.589284] R13: 0000000000000004 R14: 00007ffff79bd000 R15: 0000000000020000
> 
> and shows up under runnable tasks :
> 
> [ 2168.593562] runnable tasks:
> [ 2168.593562]  S            task   PID         tree-key  switches
> prio     wait-time             sum-exec        sum-sleep
> [ 2168.593563] -------------------------------------------------------------------------------------------------------------
> [ 2168.593565]  S        cpuhp/13    92     88923.802487        19
> 120         0.000000         0.292061         0.000000 2 0 /
> [ 2168.593571]  S  idle_inject/13    93       -11.997255         3
> 49         0.000000         0.005480         0.000000 2 0 /
> [ 2168.593577]  S    migration/13    94       814.287531       551
> 0         0.000000      1015.550514         0.000000 2 0 /
> [ 2168.593582]  S    ksoftirqd/13    95     88762.317130        44
> 120         0.000000         1.940252         0.000000 2 0 /
> [ 2168.593588]  I    kworker/13:0    96        -9.031157         5
> 120         0.000000         0.017423         0.000000 2 0 /
> [ 2168.593593]  I   kworker/13:0H    97      3570.961886         5
> 100         0.000000         0.034345         0.000000 2 0 /
> [ 2168.593603]  I    kworker/13:1   400    101650.731913       578
> 120         0.000000        10.110898         0.000000 2 0 /
> [ 2168.593611]  I   kworker/13:1H  1015    101649.600698        65
> 100         0.000000         1.443300         0.000000 2 0 /
> [ 2168.593618]  S           loop3  1994     99133.655903        70
> 100         0.000000         1.137468         0.000000 2 0 /
> [ 2168.593625]  S           snapd  3161        15.296181       166
> 120         0.000000        90.296991         0.000000 2 0
> /system.slice/snapd.service
> [ 2168.593631]  S           snapd  3198        10.047573        49
> 120         0.000000         5.646247         0.000000 2 0
> /system.slice/snapd.service
> [ 2168.593639]  S            java  2446       970.743682       301
> 120         0.000000       101.648659         0.000000 2 0
> /system.slice/stor_tomcat.service
> [ 2168.593645]  S C1 CompilerThre  2573      1033.157689      3636
> 120         0.000000       615.256247         0.000000 2 0
> /system.slice/stor_tomcat.service
> [ 2168.593654]  D              mv  3814      2263.816953    186734
> 120         0.000000     30087.917319         0.000000 2 0 /user.slice
> 
> any idea what is going on and how to fix this ?



> 
> thx.
> 


-- 
Damien Le Moal
Western Digital Research
