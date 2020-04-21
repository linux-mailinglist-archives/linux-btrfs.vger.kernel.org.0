Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A83A1B2988
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgDUO1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 10:27:50 -0400
Received: from zeus.leadhosts.com ([86.105.231.130]:52922 "EHLO
        zeus.leadhosts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgDUO1t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 10:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dordea.net;
         s=x; h=Message-Id:In-Reply-To:To:References:Date:Subject:Mime-Version:
        Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XTcEDtC1AvBrONFVS2FFcZsRhTR/oxAzh67xEcUyLUY=; b=s5LiBHOoj/osYbeUigyf/VdosO
        nj4Brf69zho3rlxSuWgoK0fAUFQgE2uXxEYHAAPpo7FV7+Myi3nHQTBjI+B14SBTArz28W8iS78QG
        tUBaf4+LqSoTfxw705VSk1IFHY4fYBQQOlGLVsnJFeCzIp4HLNZxV1BMLPizvk4vtrX9VHyqxKtzC
        VDoxCfPwM2r8MJdDPyNhy+WsHu3dx6f8kPE7VuW8Ho9AACYFTt9F6CJIk3yfu3p6cHamTrPjB/T0s
        WXhihrp3UBIJ+JBzmOJEs/ogwjc9ZKYQqlHb++q8DlZMj3xJgPf44cEEx2BnpzDATs9TDt8IXgiIo
        X6Hz8FIA==;
Received: from [86.105.231.110]
        by zeus.leadhosts.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <alex@dordea.net>)
        id 1jQtsI-000OSF-FF
        for linux-btrfs@vger.kernel.org; Tue, 21 Apr 2020 17:27:46 +0300
From:   Alexandru Dordea <alex@dordea.net>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: btrfs device missing issues
Date:   Tue, 21 Apr 2020 17:27:44 +0300
References: <20200420170738.9879-1-fdmanana@kernel.org>
 <20200421142226.GB32228@bfoster>
To:     linux-btrfs@vger.kernel.org
In-Reply-To: <20200421142226.GB32228@bfoster>
Message-Id: <C2211B40-422F-44D2-BC75-51370536075D@dordea.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Authenticated-Id: alex@dordea.net
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
  I=E2=80=99m encountering some issues and slowness while using device =
delete missing and I am wondering if I=E2=80=99m doing something wrong =
or someone can point e in the right direction:

Some background:
I have a pool with 15 x 8TB hdds and 5 x 14 TB hdds and one of the 8TB =
hdd failed. If i'm trying to run the delete missing the system is =
running extremely slow, most of the hdd's are staying with 100% and =
after calculating the speed I think it will take 3-4 weeks to complete =
the task.
If I'm running a balance, it's slow as well and the sys load is =
increasing fast. Seems that the process is running on only one CPU and =
the process is keeping it 100%. Does balance doesn't know multi-thread?

As of now, my FS is mounted with space_cache=3Dv2 and quotas are =
disabled.

# btrfs filesystem usage /mount
WARNING: RAID56 detected, not implemented
WARNING: RAID56 detected, not implemented
WARNING: RAID56 detected, not implemented
Overall:
Device size: 172.83TiB
Device allocated: 0.00B
Device unallocated: 172.83TiB
Device missing: 7.28TiB
Used: 0.00B
Free (estimated): 0.00B (min: 8.00EiB)
Data ratio: 0.00
Metadata ratio: 0.00
Global reserve: 512.00MiB (used: 0.00B)


Data,RAID6: Size:134.54TiB, Used:131.18TiB (97.51%)
/dev/sdg 7.09TiB
/dev/sdh 7.09TiB
/dev/sdt 7.09TiB
missing 6.08TiB
/dev/sds 7.09TiB
/dev/sdr 7.09TiB
/dev/sdq 7.09TiB
/dev/sdp 7.09TiB
/dev/sdo 7.09TiB
/dev/sdn 7.09TiB
/dev/sdm 7.09TiB
/dev/sdl 7.09TiB
/dev/sdk 7.09TiB
/dev/sdj 7.09TiB
/dev/sdi 7.09TiB
/dev/sdc 11.86TiB
/dev/sdf 11.86TiB
/dev/sde 11.86TiB
/dev/sdb 11.86TiB
/dev/sdd 11.86TiB


Metadata,RAID6: Size:149.90GiB, Used:144.38GiB (96.31%)
/dev/sdg 8.99GiB
/dev/sdh 8.99GiB
/dev/sdt 8.99GiB
missing 7.86GiB
/dev/sds 8.99GiB
/dev/sdr 8.99GiB
/dev/sdq 8.99GiB
/dev/sdp 8.99GiB
/dev/sdo 8.99GiB
/dev/sdn 8.99GiB
/dev/sdm 8.99GiB
/dev/sdl 8.99GiB
/dev/sdk 8.99GiB
/dev/sdj 8.99GiB
/dev/sdi 8.99GiB
/dev/sdc 10.28GiB
/dev/sdf 10.28GiB
/dev/sde 10.28GiB
/dev/sdb 10.28GiB
/dev/sdd 10.28GiB


System,RAID6: Size:13.81MiB, Used:10.72MiB (77.60%)
/dev/sdg 1.06MiB
/dev/sdh 1.06MiB
/dev/sdt 1.06MiB
missing 1.06MiB
/dev/sds 1.06MiB
/dev/sdr 1.06MiB
/dev/sdq 1.06MiB
/dev/sdp 1.06MiB
/dev/sdo 1.06MiB
/dev/sdn 1.06MiB
/dev/sdm 1.06MiB
/dev/sdl 1.06MiB
/dev/sdk 1.06MiB
/dev/sdj 1.06MiB
/dev/sdi 1.06MiB


Unallocated:
/dev/sdg 184.11GiB
/dev/sdh 184.11GiB
/dev/sdt 184.11GiB
missing 1.19TiB
/dev/sds 184.11GiB
/dev/sdr 184.11GiB
/dev/sdq 184.11GiB
/dev/sdp 184.11GiB
/dev/sdo 184.11GiB
/dev/sdn 184.11GiB
/dev/sdm 184.11GiB
/dev/sdl 184.11GiB
/dev/sdk 184.11GiB
/dev/sdj 184.11GiB
/dev/sdi 184.11GiB
/dev/sdc 886.48GiB
/dev/sdf 886.48GiB
/dev/sde 886.48GiB
/dev/sdb 886.48GiB
/dev/sdd 886.48GiB


# btrfs dev stats /mount
[/dev/sdg].write_io_errs 0
[/dev/sdg].read_io_errs 0
[/dev/sdg].flush_io_errs 0
[/dev/sdg].corruption_errs 0
[/dev/sdg].generation_errs 0
[/dev/sdh].write_io_errs 0
[/dev/sdh].read_io_errs 0
[/dev/sdh].flush_io_errs 0
[/dev/sdh].corruption_errs 0
[/dev/sdh].generation_errs 0
[/dev/sdt].write_io_errs 0
[/dev/sdt].read_io_errs 0
[/dev/sdt].flush_io_errs 0
[/dev/sdt].corruption_errs 0
[/dev/sdt].generation_errs 0
[devid:4].write_io_errs 0
[devid:4].read_io_errs 0
[devid:4].flush_io_errs 0
[devid:4].corruption_errs 0
[devid:4].generation_errs 0
[/dev/sds].write_io_errs 0
[/dev/sds].read_io_errs 0
[/dev/sds].flush_io_errs 0
[/dev/sds].corruption_errs 0
[/dev/sds].generation_errs 0
[/dev/sdr].write_io_errs 0
[/dev/sdr].read_io_errs 0
[/dev/sdr].flush_io_errs 0
[/dev/sdr].corruption_errs 0
[/dev/sdr].generation_errs 0
[/dev/sdq].write_io_errs 0
[/dev/sdq].read_io_errs 0
[/dev/sdq].flush_io_errs 0
[/dev/sdq].corruption_errs 0
[/dev/sdq].generation_errs 0
[/dev/sdp].write_io_errs 0
[/dev/sdp].read_io_errs 0
[/dev/sdp].flush_io_errs 0
[/dev/sdp].corruption_errs 0
[/dev/sdp].generation_errs 0
[/dev/sdo].write_io_errs 0
[/dev/sdo].read_io_errs 0
[/dev/sdo].flush_io_errs 0
[/dev/sdo].corruption_errs 0
[/dev/sdo].generation_errs 0
[/dev/sdn].write_io_errs 0
[/dev/sdn].read_io_errs 0
[/dev/sdn].flush_io_errs 0
[/dev/sdn].corruption_errs 0
[/dev/sdn].generation_errs 0
[/dev/sdm].write_io_errs 0
[/dev/sdm].read_io_errs 0
[/dev/sdm].flush_io_errs 0
[/dev/sdm].corruption_errs 0
[/dev/sdm].generation_errs 0
[/dev/sdl].write_io_errs 0
[/dev/sdl].read_io_errs 0
[/dev/sdl].flush_io_errs 0
[/dev/sdl].corruption_errs 0
[/dev/sdl].generation_errs 0
[/dev/sdk].write_io_errs 0
[/dev/sdk].read_io_errs 0
[/dev/sdk].flush_io_errs 0
[/dev/sdk].corruption_errs 0
[/dev/sdk].generation_errs 0
[/dev/sdj].write_io_errs 0
[/dev/sdj].read_io_errs 0
[/dev/sdj].flush_io_errs 0
[/dev/sdj].corruption_errs 0
[/dev/sdj].generation_errs 0
[/dev/sdi].write_io_errs 0
[/dev/sdi].read_io_errs 0
[/dev/sdi].flush_io_errs 0
[/dev/sdi].corruption_errs 0
[/dev/sdi].generation_errs 0
[/dev/sdc].write_io_errs 0
[/dev/sdc].read_io_errs 0
[/dev/sdc].flush_io_errs 0
[/dev/sdc].corruption_errs 0
[/dev/sdc].generation_errs 0
[/dev/sdf].write_io_errs 0
[/dev/sdf].read_io_errs 0
[/dev/sdf].flush_io_errs 0
[/dev/sdf].corruption_errs 0
[/dev/sdf].generation_errs 0
[/dev/sde].write_io_errs 0
[/dev/sde].read_io_errs 0
[/dev/sde].flush_io_errs 0
[/dev/sde].corruption_errs 0
[/dev/sde].generation_errs 0
[/dev/sdb].write_io_errs 0
[/dev/sdb].read_io_errs 0
[/dev/sdb].flush_io_errs 0
[/dev/sdb].corruption_errs 0
[/dev/sdb].generation_errs 0
[/dev/sdd].write_io_errs 0
[/dev/sdd].read_io_errs 0
[/dev/sdd].flush_io_errs 0
[/dev/sdd].corruption_errs 0
[/dev/sdd].generation_errs 0



# btrfs fi show /mount
Label: 'mount' uuid: 30ab3069-93bc-4952-a77c-61acdc364563
Total devices 20 FS bytes used 131.32TiB
devid 1 size 7.28TiB used 7.10TiB path /dev/sdg
devid 2 size 7.28TiB used 7.10TiB path /dev/sdh
devid 3 size 7.28TiB used 7.10TiB path /dev/sdt
devid 5 size 7.28TiB used 7.10TiB path /dev/sds
devid 6 size 7.28TiB used 7.10TiB path /dev/sdr
devid 7 size 7.28TiB used 7.10TiB path /dev/sdq
devid 8 size 7.28TiB used 7.10TiB path /dev/sdp
devid 9 size 7.28TiB used 7.10TiB path /dev/sdo
devid 10 size 7.28TiB used 7.10TiB path /dev/sdn
devid 11 size 7.28TiB used 7.10TiB path /dev/sdm
devid 12 size 7.28TiB used 7.10TiB path /dev/sdl
devid 13 size 7.28TiB used 7.10TiB path /dev/sdk
devid 14 size 7.28TiB used 7.10TiB path /dev/sdj
devid 15 size 7.28TiB used 7.10TiB path /dev/sdi
devid 16 size 12.73TiB used 11.87TiB path /dev/sdc
devid 17 size 12.73TiB used 11.87TiB path /dev/sdf
devid 18 size 12.73TiB used 11.87TiB path /dev/sde
devid 19 size 12.73TiB used 11.87TiB path /dev/sdb
devid 20 size 12.73TiB used 11.87TiB path /dev/sdd
*** Some devices missing

# cat /sys/block/sdh/queue/scheduler
mq-deadline kyber [bfq] none



Running:
5.6.4-1-default
btrfs-progs v5.6=20
RAM: 64GB DDR4
HDD's are on LSI HBA (no performance issue on R/W).
2 x E5-2698 v3 CPU=E2=80=99s
HDD=E2=80=99s are with APM 254 with no idle.

Anyone have any experience or some best practices to recover the FS?=20
Also is there a way to limit the intensity of the HDD's during the =
delete. I don't mind running it for months but to ensure that the r/w =
are not 90% degraded on the system.
I'm doing something wrong?

Thanks!=
