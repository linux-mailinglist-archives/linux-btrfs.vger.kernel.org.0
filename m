Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369F81549C1
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 17:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBFQy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 11:54:58 -0500
Received: from mail.orlives.de ([148.251.55.246]:44590 "EHLO mail.orlives.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbgBFQy6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 11:54:58 -0500
Received: from mail.orlives.de (localhost [127.0.0.1])
        by mail.orlives.de (Postfix) with ESMTPSA id E24D3A9DAF
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2020 17:54:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orlives.de; s=dkim1;
        t=1581008095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=3fKt5Cr1xaXZks9CB+SZcfwzWuMkOOQOOOnNhvncoWU=;
        b=b05pHSn5K3zMKTDJWPrQi2GVj376TaOcN8Q8VqQSwJlRFRSXz2DqiUquTyyWCouZeLdNTM
        0QtQguRnuOzth/8C/W8QzqGeVQKWO5v4LUgLOSupFGMwQEvePNaoBDiYBU885bBsUc6H8d
        aMQMWJuw8UOwoC649V+JT/LUsC1cLmC2tv7zjpXUWwD0yNRw7DbzQ2ZtvHhsK18kgTmk90
        9USCLrXaDFJXp8ofZexosSA/QD6c/5bihgXwEh2b34ifiLcuECYSL0sdQIhk50xL0fC2hp
        1trDbC2wdsPlOCgtu0ZgTNhR1eu8gze1SlgMTnv+h4cFjBTlSR3qFx2v5D7OHbg+H+IOiD
        70e9kuHiUn1Nkt83t0cX4Ljq3TiJn6p+aLTs3sB0AiZWhKP53YEWhqWv5PFs4Q1VRiuaAI
        TaNt+4pcrRW9gX8bgYZ5Wvk5pt90XO58LekMjVsLXq9xt+j+HYY5gn0RQ326EmIkbJH0Gk
        42wE7kGVyTSQNbWx96a7v4pobs7mnaVyngF2I9I0AecT0lr+fpDsRgodPDcr6ayUh5Z+iz
        V49CNTP7PFglyWTFOFXnUju1mse60DCOiw/30GMHVLq00Q/eMedAOQj6w2CnQlwdjgelUH
        y4zKiK1g62M++gSgqgf8sKSKp69OrmYTZCdUGFkl1zW4A12YYZ3Gk=
Subject: Re: btrfs scrub prevents system suspend
To:     linux-btrfs@vger.kernel.org
References: <6055ac8f-b13d-85ed-7109-3314c5c71c1f@localhost>
From:   Trolli Schmittlauch <t.schmittlauch@orlives.de>
Autocrypt: addr=t.schmittlauch@orlives.de; prefer-encrypt=mutual; keydata=
 mQENBF4y2DoBCADCzwZ+V1tJOR2JK20uAVPkAOC5PdIe/UYCVZsYIbh8aIz0HsiqWeTCj3J8
 nZEVKKm6fQRtyMILZeWNHQ98ck+1tmr4a6UQ4UDl+Xb1VuhU4frZI/d75olkn2JNwYcJJcdn
 MJ4WUZ8BWhmia+8ng+7nJ1yOw1ad0uS8dL+w+m+eimFr7HjIXUV/Y5I8NGhkROFDu72byMn1
 OTaq4HFfgilYsDGu8AWUtn+ZBXmCDIYbvXANjDcyuGTTnS/vgyFx66rHOgZKqTafuSAC1k61
 dAYvLlo06yb4S4VNwkW17ho9L6sgqfY5rFd+zQYnXdau7AK7TLAFywHgafHU20Ffv6PbABEB
 AAG0Gzx0LnNjaG1pdHRsYXVjaEBvcmxpdmVzLmRlPokBSQQQAQgAMwIZAQUCXjLYQAIbAwQL
 CQgHBhUICQoLAgMWAgEWIQSJFhEikPObK3+nglaeUEWy+uvFawAKCRCeUEWy+uvFa6UPCACt
 EeMFD8HIbP6vIfs0dQdYw7SyG/Ws/ZEhi61+HfBeltem2LMbcY3B1UNGWWt1px1oFq0sCd12
 j8JhjTPyFoQv+vRDEygMk/OrXfnn32dl9Ttubgz68ktxjv6xQ2q+TGHStUCe9Q1opGqjWqV0
 bqFV9nbpX5DX3urG4eDqjUrvUMasp3/RBBC6dSzRcutbmnFEUhbnQcG2JhxkUqJxErJO7Rs7
 dw5wR+43zipZznrtP/W8nCmL7E8VYn3KWFSb4jSmMyYneqBrhSZMB/BfiOMrWnnMpPChRLyR
 GLqZoyhWDPZyAbKyjlVQVS3d9BtLn5PzNaYRAl9Gad8h+o/WWHGXuQENBF4y2DoBCACmbQWs
 /CCONpIwsHxKt4fEfbW1XhQFoKPmGF2Xonas6kN3Oh8XXFekkXfnRQJX+fOuv7DbaUsmkPzd
 TB2YtfidZJ6xIYPzSgSMsA945dEOY5yYfeNCH1pQYcq1xfM7bHGSwaNervx0wnK/g7yBgp6E
 1stOwqoR9M3KgmQJPuaSISSfUH5NKcx38S6w+56I3//f1jyCRG5vkQzHsdioBWkAOfagQmcv
 6fMhDYCoxlTooxlj1/5mSkspCS7fDkVcZn48t+sPfQAywpUDrWBZhp1vrDHfl+wUvCSXPYEz
 9dkT9NmLz24H20tLV+btVgMsPXSlnM34lNjABg2x7isCoCZ9ABEBAAGJATYEGAEIACAFAl4y
 2EACGwwWIQSJFhEikPObK3+nglaeUEWy+uvFawAKCRCeUEWy+uvFayO5CACDYH46Tay5BSwn
 FK3EwAYSpXIFzhQet7os7InGRS8/2yuqzsunRDbMy11rTGmXXA1LuTizqsgebQbALpkuHEpi
 gX9b20RfsfuZYbdbtLzzVDuOVuGP3+CSJrB1Z+nGeF1+L4m5n7VDPX0MyWKwhlWY9hVmNQ2+
 lMt+fb6+330M9cXCz6H2/k7b2BTEM9xZPytt2ICT8I9rX5+8tuHDrstr13P40QOR0Exh5EHw
 LA00FYsr0e+ijzxRP9EC3AA9Gt/518IRS7FGvszu4qWWRT33P2cABoVUPpsybrhvuApgpf5y
 DLO17h0Vxwoq2qqCO/RqIw+o8Lj89xOl4VkPpXe4
Message-ID: <3b9fd31d-1f7c-0238-cfee-b28e4dee0538@localhost>
Date:   Thu, 6 Feb 2020 17:54:53 +0100
Mime-Version: 1.0
In-Reply-To: <6055ac8f-b13d-85ed-7109-3314c5c71c1f@localhost>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1firgAne9Qm5xGyqhuLLY22iqDiZOuZqL"
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=t.schmittlauch@orlives.de smtp.mailfrom=t.schmittlauch@orlives.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1firgAne9Qm5xGyqhuLLY22iqDiZOuZqL
Content-Type: multipart/mixed; boundary="yEKCffGY8UDfc34IwZc6o2iROMpHS3cLA";
 protected-headers="v1"
From: Trolli Schmittlauch <t.schmittlauch@orlives.de>
To: linux-btrfs@vger.kernel.org
Message-ID: <3b9fd31d-1f7c-0238-cfee-b28e4dee0538@localhost>
Subject: Re: btrfs scrub prevents system suspend
References: <6055ac8f-b13d-85ed-7109-3314c5c71c1f@localhost>
In-Reply-To: <6055ac8f-b13d-85ed-7109-3314c5c71c1f@localhost>

--yEKCffGY8UDfc34IwZc6o2iROMpHS3cLA
Content-Type: multipart/mixed;
 boundary="------------668E75F02C147EFFE822C979"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------668E75F02C147EFFE822C979
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I can confirm that this issue still appears in a recent 5.4 kernel, see a=
ttached log.

--------------668E75F02C147EFFE822C979
Content-Type: text/x-log; charset=UTF-8;
 name="btrfsscrub_suspend_54.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="btrfsscrub_suspend_54.log"

systemd[1]: Starting Pre-Sleep Actions...
systemd[1]: Starting TLP suspend/resume...
systemd[1]: pre-sleep.service: Succeeded.
systemd[1]: Started Pre-Sleep Actions.
systemd[1]: Started TLP suspend/resume.
systemd[1]: Reached target Sleep.
systemd[1]: Starting Suspend...
systemd-sleep[22694]: Suspending system...
kernel: PM: suspend entry (deep)
kernel: Filesystems sync: 0.285 seconds
kernel: Freezing user space processes ...=20
kernel: Freezing of tasks failed after 20.004 seconds (1 tasks refusing t=
o freeze, wq_busy=3D0):
kernel: btrfs           R  running task        0 22389      1 0x00004004
kernel: Call Trace:
kernel:  ? __schedule+0x35f/0x6a0
kernel:  ? scrub_missing_raid56_end_io+0x40/0x40 [btrfs]
kernel:  ? schedule+0x2f/0xa0
kernel:  ? scrub_add_page_to_rd_bio+0x22c/0x2e0 [btrfs]
kernel:  ? wait_woken+0x80/0x80
kernel:  ? scrub_pages+0x236/0x420 [btrfs]
kernel:  ? scrub_stripe+0x718/0xeb0 [btrfs]
kernel:  ? btrfs_create_pending_block_groups+0xc0/0x230 [btrfs]
kernel:  ? kmem_cache_alloc+0x158/0x210
kernel:  ? join_transaction+0x22/0x3e0 [btrfs]
kernel:  ? scrub_chunk+0xd8/0x140 [btrfs]
kernel:  ? scrub_chunk+0xd8/0x140 [btrfs]
kernel:  ? scrub_enumerate_chunks+0x1f8/0x560 [btrfs]
kernel:  ? woken_wake_function+0x10/0x20
kernel:  ? btrfs_scrub_dev+0x1f4/0x590 [btrfs]
kernel:  ? _cond_resched+0x15/0x30
kernel:  ? __kmalloc_track_caller+0x169/0x250
kernel:  ? btrfs_ioctl+0xf0d/0x3230 [btrfs]
kernel:  ? btrfs_ioctl+0xf57/0x3230 [btrfs]
kernel:  ? do_vfs_ioctl+0xa4/0x620
kernel:  ? do_vfs_ioctl+0xa4/0x620
kernel:  ? ksys_ioctl+0x60/0x90
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __x64_sys_ioctl+0x16/0x20
kernel:  ? do_syscall_64+0x4e/0x120
kernel:  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
kernel: OOM killer enabled.
kernel: Restarting tasks ... done.
X[1517]: (EE) client bug: timer event20 tap: offset negative (-14101ms)
rtkit-daemon[2131]: The canary thread is apparently starving. Taking acti=
on.
systemd[1]: NetworkManager-dispatcher.service: Succeeded.
rtkit-daemon[2131]: Demoting known real-time threads.
rtkit-daemon[2131]: Successfully demoted thread 8662 of process 30654 (/n=
ix/store/bzr1jrf17ypd6l1rhxi4zn572sa0288b-firefox-unwrapped-7).
rtkit-daemon[2131]: Successfully demoted thread 5305 of process 4568 (/ni=
x/store/bzr1jrf17ypd6l1rhxi4zn572sa0288b-firefox-unwrapped-7).
rtkit-daemon[2131]: Successfully demoted thread 4581 of process 4518 (/ni=
x/store/bzr1jrf17ypd6l1rhxi4zn572sa0288b-firefox-unwrapped-7).
rtkit-daemon[2131]: Successfully demoted thread 2198 of process 2123 (/ni=
x/store/kbvkchb68g00clwqav4kfy934navrrlc-pulseaudio-12.2/bin).
rtkit-daemon[2131]: Successfully demoted thread 2197 of process 2123 (/ni=
x/store/kbvkchb68g00clwqav4kfy934navrrlc-pulseaudio-12.2/bin).
rtkit-daemon[2131]: Successfully demoted thread 2123 of process 2123 (/ni=
x/store/kbvkchb68g00clwqav4kfy934navrrlc-pulseaudio-12.2/bin).
rtkit-daemon[2131]: Demoted 6 threads.
nscd[22558]: 22558 checking for monitored file `/etc/netgroup': No such f=
ile or directory
kernel: PM: suspend exit
kernel: PM: suspend entry (s2idle)
xsession[1939]: Connecting to deprecated signal QDBusConnectionInterface:=
:serviceOwnerChanged(QString,QString,QString)
kernel: Filesystems sync: 0.374 seconds
kernel: Freezing user space processes ...=20
kernel: Freezing of tasks failed after 20.000 seconds (1 tasks refusing t=
o freeze, wq_busy=3D0):
kernel: btrfs           D    0 22389      1 0x00004004
kernel: Call Trace:
kernel:  ? __schedule+0x218/0x6a0
kernel:  ? scrub_missing_raid56_end_io+0x40/0x40 [btrfs]
kernel:  schedule+0x2f/0xa0
kernel:  scrub_add_page_to_rd_bio+0x22c/0x2e0 [btrfs]
kernel:  ? wait_woken+0x80/0x80
kernel:  scrub_pages+0x236/0x420 [btrfs]
kernel:  scrub_stripe+0x718/0xeb0 [btrfs]
kernel:  ? btrfs_create_pending_block_groups+0xc0/0x230 [btrfs]
kernel:  ? kmem_cache_alloc+0x158/0x210
kernel:  ? join_transaction+0x22/0x3e0 [btrfs]
kernel:  ? scrub_chunk+0xd8/0x140 [btrfs]
kernel:  scrub_chunk+0xd8/0x140 [btrfs]
kernel:  scrub_enumerate_chunks+0x1f8/0x560 [btrfs]
kernel:  ? woken_wake_function+0x10/0x20
kernel:  btrfs_scrub_dev+0x1f4/0x590 [btrfs]
kernel:  ? _cond_resched+0x15/0x30
kernel:  ? __kmalloc_track_caller+0x169/0x250
kernel:  ? btrfs_ioctl+0xf0d/0x3230 [btrfs]
kernel:  btrfs_ioctl+0xf57/0x3230 [btrfs]
kernel:  ? do_vfs_ioctl+0xa4/0x620
kernel:  do_vfs_ioctl+0xa4/0x620
kernel:  ksys_ioctl+0x60/0x90
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  __x64_sys_ioctl+0x16/0x20
kernel:  do_syscall_64+0x4e/0x120
kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
kernel: RIP: 0033:0x7fbf64f62b57
kernel: Code: Bad RIP value.
kernel: RSP: 002b:00007fbf64e73d48 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00010
kernel: RAX: ffffffffffffffda RBX: 0000000000fd33e0 RCX: 00007fbf64f62b57=

kernel: RDX: 0000000000fd33e0 RSI: 00000000c400941b RDI: 0000000000000003=

kernel: RBP: 0000000000000000 R08: 00007fbf64e74700 R09: 0000000000000000=

kernel: R10: 00007fbf64e74700 R11: 0000000000000246 R12: 00007ffe6edbc67e=

kernel: R13: 00007ffe6edbc67f R14: 00007fbf64e74700 R15: 00007fbf651bf000=

kernel: OOM killer enabled.
rtkit-daemon[2131]: The canary thread is apparently starving. Taking acti=
on.
kernel: Restarting tasks ... done.

--------------668E75F02C147EFFE822C979--

--yEKCffGY8UDfc34IwZc6o2iROMpHS3cLA--

--1firgAne9Qm5xGyqhuLLY22iqDiZOuZqL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEiRYRIpDzmyt/p4JWnlBFsvrrxWsFAl48RN0ACgkQnlBFsvrr
xWvVGwf/bjvDDMgdF61Y48x7l19A9d4tPQPKNVsJH+5+a3vXaYGtWk0XvDO2jqwg
ZrW0438AR6t4XnOLxE+oWQPNDCFa2ZommcEREP2eBjkzBYHtJAQnKZqYzqpdEWmA
rHqldTFrtxRyGprZkqgrIM3/Ci/8/so0mgBVNlaA8WfRnnR+B+/wnHoN3HsY+P9y
s8npqESYQ6ov2A377Fzx+x3PS1aIJS2UVER+58BoZ46uG45bCt0eA/E7AtZfhvLF
YeX6T7L7M2hP/HIIoRHlV/Z0uRS9vDkq5HmYm6mrzs5MTB3E22JT5sbg3Dr0JJTH
cJeOnJAWtGxV4w8AuY8O9FZWfxiF5Q==
=VLxH
-----END PGP SIGNATURE-----

--1firgAne9Qm5xGyqhuLLY22iqDiZOuZqL--
