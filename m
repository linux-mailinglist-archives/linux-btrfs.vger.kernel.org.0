Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B186E3580
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Apr 2023 08:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjDPGt2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Apr 2023 02:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPGt1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Apr 2023 02:49:27 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3538E6C
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 23:49:24 -0700 (PDT)
Date:   Sun, 16 Apr 2023 06:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=2wxy53aejfcwpp3b75k6lf5q7a.protonmail; t=1681627760; x=1681886960;
        bh=n16NmLjYBa+SHXbJQD5ivbuxT6ylA39GFiHW8JpikYQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=e6yLkpl2r26i8svMnlxIQ6xi0oG21d2CCIVZU8p0Xvc8i4ZudtoVsyDWW716RlCAR
         Hk67yuVW0I3vLnQJNuZ+/mka+bDvYZmJ4fklaeG7WiaXW3bRQsNoCIMEO8YSFnKKrv
         G+KdcL8QyL5UguS3rvIfY9eEB4taeYAdha+UP2Tahk7ENgb6h0BU8NR3/PzW7oLh02
         Ca0HxHZBg/bBSjm0iRgmo0Z/q0lx/iX7NRK4FA7UGkTC0IF3YWk4H1s3tMuM/cH0dK
         5aV9/YJDnhIGw2BpNdrA8X+lgXVXAx05eqOfsRfyhwHwKeF0h7M8AyhjFdpxXZgu3u
         RLr6yrkT5r0ug==
To:     linux-btrfs@vger.kernel.org
From:   broetchenrackete <broetchenrackete@proton.me>
Cc:     "quwenruo.btrfs" <quwenruo.btrfs@gmx.com>
Subject: Re: Replacing missing disk failed, lots of parent transid verify failed
Message-ID: <LVq5QlZnCzI9JtsiNcTSW8imMcEEsSv7Qxp95QL7B2iQ7hZB9TIkr3nV3Q4QTSMl6BQQ_gpVwtpvO7f61d6lVq6BqGl2fmUaPa81pVC8tSo=@proton.me>
In-Reply-To: <Zdi37cZTCBbZ_X-DXKMJg9TjeFvz2Ve_dznn-0u371pNBGxDoi4q36m58pWcT9vnO9XKMs9-tXEBjqpqOBa4D2XZxHFzKCKoR7UDpih92JM=@proton.me>
References: <Zdi37cZTCBbZ_X-DXKMJg9TjeFvz2Ve_dznn-0u371pNBGxDoi4q36m58pWcT9vnO9XKMs9-tXEBjqpqOBa4D2XZxHFzKCKoR7UDpih92JM=@proton.me>
Feedback-ID: 71840784:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Oops, seems my mobile App sent the mail with HTML....

---- Original Message -------
On Sunday, April 16th, 2023 at 08:41, broetchenrackete <broetchenrackete@pr=
oton.me> wrote:


> Greetings,
>=20
> I tried to run a btrfs check again, this time it was killed because it we=
nt oom (I have 16G and it never failed because of low memory) so I tried it=
 in lowmem mode again.
> I got lots and lots of errors like this:
>=20
> parent transid verify failed on 32427662147584 wanted 671816 found 671624
> parent transid verify failed on 32427662180352 wanted 671816 found 671624
> parent transid verify failed on 32427662311424 wanted 671816 found 671624
> parent transid verify failed on 32427662393344 wanted 671816 found 671624
> parent transid verify failed on 32427662426112 wanted 671816 found 671624
> parent transid verify failed on 32427662573568 wanted 671816 found 671624
> parent transid verify failed on 32427662589952 wanted 671816 found 671624
> parent transid verify failed on 32427662655488 wanted 671816 found 671624
> parent transid verify failed on 32427662688256 wanted 671816 found 671624
> parent transid verify failed on 32427662704640 wanted 671816 found 671624
> parent transid verify failed on 32427662786560 wanted 671816 found 671624
> parent transid verify failed on 32427662884864 wanted 671816 found 671624
> parent transid verify failed on 32427662868480 wanted 671816 found 671624
> parent transid verify failed on 32427662934016 wanted 671816 found 671624
> parent transid verify failed on 32427662950400 wanted 671816 found 671624
> parent transid verify failed on 32427663114240 wanted 671816 found 671624
> parent transid verify failed on 32427663179776 wanted 671816 found 671624
> parent transid verify failed on 32427663376384 wanted 671816 found 671624
> parent transid verify failed on 32427663425536 wanted 671816 found 671624
> parent transid verify failed on 32427663441920 wanted 671816 found 671624
> parent transid verify failed on 32427624284160 wanted 671816 found 671623
> parent transid verify failed on 32427663491072 wanted 671816 found 671624
> parent transid verify failed on 32427663507456 wanted 671816 found 671624
> parent transid verify failed on 32427663523840 wanted 671816 found 671624
> parent transid verify failed on 32427663589376 wanted 671816 found 671624
> parent transid verify failed on 32427663622144 wanted 671816 found 671624
> parent transid verify failed on 32427663671296 wanted 671816 found 671624
> parent transid verify failed on 32427663704064 wanted 671816 found 671624
> parent transid verify failed on 32427663802368 wanted 671816 found 671624
> parent transid verify failed on 32427663982592 wanted 671816 found 671624
> parent transid verify failed on 32427664113664 wanted 671816 found 671624
> parent transid verify failed on 32427664146432 wanted 671816 found 671624
> parent transid verify failed on 32427664179200 wanted 671816 found 671624
> parent transid verify failed on 32427661934592 wanted 671816 found 671624
> parent transid verify failed on 32427664474112 wanted 671816 found 671624
> parent transid verify failed on 32427664506880 wanted 671816 found 671624
> parent transid verify failed on 32427664703488 wanted 671816 found 671624
> parent transid verify failed on 32427664736256 wanted 671816 found 671624
> parent transid verify failed on 32427662262272 wanted 671816 found 671624
> parent transid verify failed on 32427664752640 wanted 671816 found 671624
> parent transid verify failed on 32427664850944 wanted 671816 found 671624
> parent transid verify failed on 32427660607488 wanted 671816 found 671624
> parent transid verify failed on 32427664900096 wanted 671816 found 671624
> parent transid verify failed on 32427664932864 wanted 671816 found 671624
> parent transid verify failed on 32427665244160 wanted 671816 found 671624
> parent transid verify failed on 32427668914176 wanted 671816 found 671428
> parent transid verify failed on 32427671224320 wanted 671816 found 671624
> parent transid verify failed on 32427707121664 wanted 671816 found 671625
> parent transid verify failed on 32427709300736 wanted 671816 found 671625
> parent transid verify failed on 32427709317120 wanted 671816 found 671625
> parent transid verify failed on 32427710136320 wanted 671816 found 671625
> parent transid verify failed on 32427710611456 wanted 671816 found 671625
> parent transid verify failed on 32427714543616 wanted 671816 found 671625
> parent transid verify failed on 32427720540160 wanted 671816 found 671625
> parent transid verify failed on 32427720556544 wanted 671816 found 671625
> parent transid verify failed on 32427720572928 wanted 671816 found 671625
> parent transid verify failed on 32427720589312 wanted 671816 found 671625
> parent transid verify failed on 32427622891520 wanted 671816 found 671623
> parent transid verify failed on 32427722653696 wanted 671816 found 671625
> parent transid verify failed on 32427722899456 wanted 671816 found 671625
> parent transid verify failed on 32427722719232 wanted 671816 found 671625
> parent transid verify failed on 32427722997760 wanted 671816 found 671625
> parent transid verify failed on 32427723571200 wanted 671816 found 671625
> parent transid verify failed on 32427723915264 wanted 671816 found 671625
> parent transid verify failed on 32427724029952 wanted 671816 found 671625
> parent transid verify failed on 32427725094912 wanted 671816 found 671625
> parent transid verify failed on 32427725766656 wanted 671816 found 671626
> parent transid verify failed on 32427725930496 wanted 671816 found 671626
> parent transid verify failed on 32427725996032 wanted 671816 found 671626
> parent transid verify failed on 32427726061568 wanted 671816 found 671626
> parent transid verify failed on 32427727683584 wanted 671816 found 671617
> parent transid verify failed on 32427727912960 wanted 671816 found 671626
> parent transid verify failed on 32427728437248 wanted 671816 found 671626
> parent transid verify failed on 32427729469440 wanted 671816 found 671617
> parent transid verify failed on 32427729534976 wanted 671816 found 671626
> parent transid verify failed on 32427730190336 wanted 671816 found 671626
> parent transid verify failed on 32427730993152 wanted 671816 found 671626
> parent transid verify failed on 32427663638528 wanted 671816 found 671624
> parent transid verify failed on 32427731894272 wanted 671816 found 671626
> parent transid verify failed on 32427733204992 wanted 671816 found 671626
> parent transid verify failed on 32427735072768 wanted 671816 found 671428
> parent transid verify failed on 32427746443264 wanted 671816 found 671617
> parent transid verify failed on 32427711823872 wanted 671816 found 671617
> parent transid verify failed on 32427664965632 wanted 671816 found 671624
> parent transid verify failed on 32427724341248 wanted 671816 found 671625
> parent transid verify failed on 32427722932224 wanted 671816 found 671625
> ERROR: errors found in fs roots
> extent buffer leak: start 20295892713472 len 16384
> Opening filesystem to check...
> warning, device 5 is missing
> Checking filesystem on /dev/sda1
> UUID: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
> found 29653236076544 bytes used, error(s) found
> total csum bytes: 116101903616
> total tree bytes: 151425531904
> total fs tree bytes: 7893516288
> total extent tree bytes: 5094506496
> btree space waste bytes: 22200204097
> file data blocks allocated: 181092797280256
> referenced 46284357079040
>=20
>=20
>=20
> I saved the log to a file but it didn't contain much information...
>=20
> Opening filesystem to check...
> warning, device 5 is missing
> Checking filesystem on /dev/sda1
> UUID: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
> found 29653236076544 bytes used, error(s) found
> total csum bytes: 116101903616
> total tree bytes: 151425531904
> total fs tree bytes: 7893516288
> total extent tree bytes: 5094506496
> btree space waste bytes: 22200204097
> file data blocks allocated: 181092797280256
> referenced 46284357079040
>=20
>=20
> I am really at my wits end, anything I can do to save the array exept cop=
ying the data somewhere else and start anew?
>=20
> Thanks,
> Emil
> -------- Original-Nachricht --------
> Am 13. Apr. 2023, 09:36, schrieb broetchenrackete < broetchenrackete@prot=
on.me>:
>=20
> >=20
> > Hi all, I have the feeling that my Mails from my Gmail account get flag=
ged as spam. If not I apologies for the duplicate message. Anyway, forgot t=
o mention kernel and btrfs-progs versions: [bluemond@BlueQ ~]$ uname -aLinu=
x BlueQ 6.2.10-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 07 Apr 2023 02:10:43 +00=
00 x86_64 GNU/Linux [bluemond@BlueQ ~]$ btrfs --version btrfs-progs v6.2.2 =
And here are my original messages: Hi all, I have a raid5 array where one d=
isk failed completely so I wanted to replace it with btrfs replace. After ~=
50% and ~24h it failed. I tried it twice already, the first time i got a Ke=
rnel warning, the second time it failed without a Kernel warning. I used th=
e following to replace the missing disk: sudo btrfs replace start 5 /dev/sd=
f1 /mnt/btrfsrepair/ This is the kernel log from the first try (there are q=
uiet a bit of more errors preceeding this for both log-snippets): Apr 10 11=
:32:58 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild valid log=
ical 14921002348544 for dev Apr 10 11:32:59 BlueQ kernel: BTRFS error (devi=
ce sdf1): failed to rebuild valid logical 14921110454272 for dev Apr 10 11:=
33:00 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild valid logi=
cal 14921191104512 for dev Apr 10 11:33:01 BlueQ kernel: BTRFS error (devic=
e sdf1): failed to rebuild valid logical 14921375891456 for dev Apr 10 11:3=
3:03 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild valid logic=
al 14921493860352 for dev Apr 10 11:33:05 BlueQ kernel: BTRFS error (device=
 sdf1): failed to rebuild valid logical 14921741586432 for dev Apr 10 11:33=
:37 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild valid logica=
l 14926675795968 for dev Apr 10 11:33:44 BlueQ kernel: BTRFS error (device =
sdf1): failed to rebuild valid logical 14927684403200 for dev Apr 10 11:33:=
46 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild valid logical=
 14928193597440 for dev Apr 10 11:33:53 BlueQ kernel: BTRFS error (device s=
df1): failed to rebuild valid logical 14929553514496 for dev Apr 10 11:34:1=
2 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild valid logical =
14932636286976 for dev Apr 10 11:34:13 BlueQ kernel: BTRFS error (device sd=
f1): failed to rebuild valid logical 14933068861440 for dev Apr 10 11:34:13=
 BlueQ kernel: BTRFS error (device sdf1): failed to rebuild valid logical 1=
4933090471936 for dev Apr 10 11:34:15 BlueQ kernel: BTRFS error (device sdf=
1): failed to rebuild valid logical 14933359788032 for dev Apr 10 11:34:16 =
BlueQ kernel: BTRFS error (device sdf1): failed to rebuild valid logical 14=
933477769216 for dev Apr 10 11:34:17 BlueQ kernel: BTRFS error (device sdf1=
): failed to rebuild valid logical 14933715648512 for dev Apr 10 11:34:20 B=
lueQ kernel: BTRFS error (device sdf1): failed to rebuild valid logical 149=
34220931072 for dev Apr 10 11:34:26 BlueQ kernel: BTRFS error (device sdf1)=
: failed to rebuild valid logical 14935264264192 for dev Apr 10 11:34:39 Bl=
ueQ kernel: BTRFS error (device sdf1): failed to rebuild valid logical 1493=
7330614272 for dev Apr 10 11:53:20 BlueQ kernel: BTRFS error (device sdf1):=
 parent transid verify failed on logical 20295892680704 mirror 2 wanted 668=
185 found 666739 Apr 10 11:53:20 BlueQ kernel: BTRFS error (device sdf1): l=
evel verify failed on logical 20295892713472 mirror 2 wanted 0 found 1 Apr =
10 11:53:36 BlueQ kernel: BTRFS error (device sdf1): level verify failed on=
 logical 20295892713472 mirror 2 wanted 0 found 1 Apr 10 11:53:36 BlueQ ker=
nel: BTRFS error (device sdf1): bad tree block start, mirror 3 want 2029589=
2713472 have 0 Apr 10 11:53:36 BlueQ kernel: BTRFS error (device sdf1): btr=
fs_scrub_dev(, 5, /dev/sdf1) failed -5 Apr 10 11:53:36 BlueQ kernel: ------=
------[ cut here ]------------ Apr 10 11:53:36 BlueQ kernel: WARNING: CPU: =
3 PID: 20126 at fs/btrfs/dev-replace.c:1239 btrfs_dev_replace_kthread+0x16f=
/0x190 [btrfs] Apr 10 11:53:36 BlueQ kernel: Modules linked in: tls tcp_dia=
g udp_diag inet_diag xt_nat xt_tcpudp veth nf_conntrack_netlink nfnetlink x=
t_addrtype wireguard curve25519_x86_64 libchacha20poly1305 chacha_x86_64 po=
ly1305_x86_64 libcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel tun=
 overlay xt_MASQUERADE iptable_nat nf_nat xt_conntrack zram nf_conntrack nf=
_defrag_ipv6 nct6775 nf_defrag_ipv4 nct6775_core iptable_filter hwmon_vid i=
wlmvm intel_rapl_msr xxhash_generic intel_rapl_common mac80211 edac_mce_amd=
 kvm_amd libarc4 kvm btusb irqbypass crct10dif_pclmul btrtl crc32_pclmul bt=
bcm polyval_clmulni iwlwifi polyval_generic nls_iso8859_1 btintel gf128mul =
ghash_clmulni_intel vfat btmtk sha512_ssse3 fat r8169 aesni_intel eeprom bl=
uetooth cfg80211 realtek crypto_simd cryptd mdio_devres sp5100_tco ecdh_gen=
eric wmi_bmof btrfs ccp rapl pcspkr i2c_piix4 libphy rfkill blake2b_generic=
 xor wmi gpio_amdpt raid6_pq ryzen_smu(OE) libcrc32c gpio_generic acpi_cpuf=
req mac_hid zenpower(OE) dm_multipath hfsplus hfs cdrom Apr 10 11:53:36 Blu=
eQ kernel: drivetemp sg br_netfilter bridge stp llc crypto_user fuse loop d=
m_mod bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2=
 mpt3sas nvme raid_class nvme_core crc32c_intel xhci_pci scsi_transport_sas=
 xhci_pci_renesas nvme_common bcache Apr 10 11:53:36 BlueQ kernel: CPU: 3 P=
ID: 20126 Comm: btrfs-devrepl Tainted: G OE 6.2.10-arch1-1 #1 3b64a9154b84a=
23b8badf9e10678249884a952c6 Apr 10 11:53:36 BlueQ kernel: Hardware name: Mi=
cro-Star International Co., Ltd. MS-7A40/B450I GAMING PLUS MAX WIFI (MS-7A4=
0), BIOS B.40 02/08/2021 Apr 10 11:53:36 BlueQ kernel: RIP: 0010:btrfs_dev_=
replace_kthread+0x16f/0x190 [btrfs] Apr 10 11:53:36 BlueQ kernel: Code: 0a =
00 00 48 89 d1 31 d2 48 c1 e9 04 48 f7 f1 48 ba cd cc cc cc cc cc cc cc 48 =
f7 e2 48 89 d0 48 c1 e8 03 89 c5 e9 c7 fe ff ff <0f> 0b 48 89 df e8 67 11 f=
b ff 31 c0 5b 5d e9 32 3e 4c f6 49 c7 c0 Apr 10 11:53:36 BlueQ kernel: RSP:=
 0018:ffffbc589f987f08 EFLAGS: 00010206 Apr 10 11:53:36 BlueQ kernel: RAX: =
00000000fffffffb RBX: ffff9bf63d7c1000 RCX: 0000000000000000 Apr 10 11:53:3=
6 BlueQ kernel: RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff9bf63d=
7c1ab0 Apr 10 11:53:36 BlueQ kernel: RBP: 000000000000000f R08: ffff9bf63d7=
c1b88 R09: ffffbc589f987df8 Apr 10 11:53:36 BlueQ kernel: R10: 000000000000=
0001 R11: 0000000000000110 R12: ffff9bf680d7a040 Apr 10 11:53:36 BlueQ kern=
el: R13: ffff9bf6a30e6900 R14: ffff9bf63d7c1000 R15: ffffffffc0a8ef10 Apr 1=
0 11:53:36 BlueQ kernel: FS: 0000000000000000(0000) GS:ffff9bf8aeec0000(000=
0) knlGS:0000000000000000 Apr 10 11:53:36 BlueQ kernel: CS: 0010 DS: 0000 E=
S: 0000 CR0: 0000000080050033 Apr 10 11:53:36 BlueQ kernel: CR2: 00007f66c8=
b9fef4 CR3: 00000002dec10000 CR4: 00000000003506e0 Apr 10 11:53:36 BlueQ ke=
rnel: Call Trace: Apr 10 11:53:36 BlueQ kernel: Apr 10 11:53:36 BlueQ kerne=
l: kthread+0xde/0x110 Apr 10 11:53:36 BlueQ kernel: ? __pfx_kthread+0x10/0x=
10 Apr 10 11:53:36 BlueQ kernel: ret_from_fork+0x2c/0x50 Apr 10 11:53:36 Bl=
ueQ kernel: Apr 10 11:53:36 BlueQ kernel: ---[ end trace 0000000000000000 ]=
--- And this from the second try: Apr 11 16:20:57 BlueQ kernel: BTRFS error=
 (device sde1): failed to rebuild valid logical 14921375891456 for dev Apr =
11 16:20:59 BlueQ kernel: BTRFS error (device sde1): failed to rebuild vali=
d logical 14921493860352 for dev Apr 11 16:21:00 BlueQ kernel: BTRFS error =
(device sde1): failed to rebuild valid logical 14921741586432 for dev Apr 1=
1 16:21:35 BlueQ kernel: BTRFS error (device sde1): failed to rebuild valid=
 logical 14926675795968 for dev Apr 11 16:21:41 BlueQ kernel: BTRFS error (=
device sde1): failed to rebuild valid logical 14927684403200 for dev Apr 11=
 16:21:42 BlueQ kernel: BTRFS error (device sde1): failed to rebuild valid =
logical 14928193597440 for dev Apr 11 16:21:52 BlueQ kernel: BTRFS error (d=
evice sde1): failed to rebuild valid logical 14929553514496 for dev Apr 11 =
16:22:16 BlueQ kernel: BTRFS error (device sde1): failed to rebuild valid l=
ogical 14932636286976 for dev Apr 11 16:22:17 BlueQ kernel: BTRFS error (de=
vice sde1): failed to rebuild valid logical 14933359788032 for dev Apr 11 1=
6:22:19 BlueQ kernel: BTRFS error (device sde1): failed to rebuild valid lo=
gical 14933715648512 for dev Apr 11 16:22:21 BlueQ kernel: BTRFS error (dev=
ice sde1): failed to rebuild valid logical 14934220931072 for dev Apr 11 16=
:22:23 BlueQ kernel: BTRFS error (device sde1): failed to rebuild valid log=
ical 14933477769216 for dev Apr 11 16:22:23 BlueQ kernel: BTRFS error (devi=
ce sde1): failed to rebuild valid logical 14933068861440 for dev Apr 11 16:=
22:23 BlueQ kernel: BTRFS error (device sde1): failed to rebuild valid logi=
cal 14933090471936 for dev Apr 11 16:22:29 BlueQ kernel: BTRFS error (devic=
e sde1): failed to rebuild valid logical 14935264264192 for dev Apr 11 16:2=
2:42 BlueQ kernel: BTRFS error (device sde1): failed to rebuild valid logic=
al 14937330614272 for dev Apr 11 16:41:13 BlueQ kernel: BTRFS error (device=
 sde1): parent transid verify failed on logical 20295892680704 mirror 2 wan=
ted 668185 found 666739 Apr 11 16:41:13 BlueQ kernel: BTRFS error (device s=
de1): level verify failed on logical 20295892713472 mirror 2 wanted 0 found=
 1 Apr 11 16:41:32 BlueQ kernel: BTRFS error (device sde1): level verify fa=
iled on logical 20295892713472 mirror 2 wanted 0 found 1 Apr 11 16:41:32 Bl=
ueQ kernel: BTRFS error (device sde1): bad tree block start, mirror 3 want =
20295892713472 have 0 Apr 11 16:41:32 BlueQ kernel: BTRFS error (device sde=
1): btrfs_scrub_dev(, 5, /dev/sdf1) failed -5 Some info about the array: [b=
luemond@BlueQ ~]$ sudo btrfs fi us /mnt/btrfsrepair/ Overall: Device size: =
54.58TiB Device allocated: 34.66TiB Device unallocated: 19.92TiB Device mis=
sing: 7.28TiB Device slack: 10.50KiB Used: 34.49TiB Free (estimated): 15.79=
TiB (min: 10.09TiB) Free (statfs, df): 9.92TiB Data ratio: 1.27 Metadata ra=
tio: 2.00 Global reserve: 512.00MiB (used: 0.00B) Multiple profiles: no Dat=
a,RAID5: Size:26.85TiB, Used:26.72TiB (99.52%) /dev/sde1 7.12TiB /dev/sda1 =
7.12TiB /dev/sdb1 2.94TiB /dev/sdd1 2.94TiB missing 6.86TiB /dev/sdg1 7.18T=
iB Metadata,RAID1: Size:259.00GiB, Used:257.92GiB (99.58%) /dev/sde1 163.00=
GiB /dev/sda1 164.00GiB /dev/sdb1 5.00GiB /dev/sdd1 5.00GiB missing 86.00Gi=
B /dev/sdg1 95.00GiB System,RAID1: Size:40.00MiB, Used:1.75MiB (4.38%) /dev=
/sdb1 32.00MiB /dev/sdd1 32.00MiB missing 8.00MiB /dev/sdg1 8.00MiB Unalloc=
ated: /dev/sde1 1.00MiB /dev/sda1 1.00MiB /dev/sdb1 9.79TiB /dev/sdd1 9.79T=
iB missing 342.00GiB /dev/sdg1 1.00MiB [bluemond@BlueQ ~]$ sudo btrfs fi sh=
 Label: 'BlueButter' uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3 Total devic=
es 6 FS bytes used 26.97TiB devid 1 size 7.28TiB used 7.28TiB path /dev/sde=
1 devid 2 size 7.28TiB used 7.28TiB path /dev/sda1 devid 3 size 12.73TiB us=
ed 2.94TiB path /dev/sdb1 devid 4 size 12.73TiB used 2.94TiB path /dev/sdd1=
 devid 5 size 0 used 0 path MISSING devid 6 size 7.28TiB used 7.28TiB path =
/dev/sdg1 I don't care if I have to delete a few files (all really importan=
t stuff is backed up already) but I would hate to lose the whole array. Wha=
t should I do? So I tried to find the files responsible for the last errors=
 in the log with inspect-internal but no avail... I then tried to run a btr=
fs check (readonly) and it segfaulted... This is the end of the btrfs check=
 log: parent transid verify failed on 15959631003648 wanted 671918 found 67=
1864 extent back ref already exists for 20295519666176 parent 0 root 4220 e=
xtent back ref already exists for 20295519682560 parent 0 root 4220 extent =
back ref already exists for 20295519698944 parent 0 root 4220 extent back r=
ef already exists for 20295520452608 parent 0 root 4636 extent back ref alr=
eady exists for 20295520468992 parent 0 root 4636 extent back ref already e=
xists for 20295521206272 parent 30423438540800 root 0 extent back ref alrea=
dy exists for 20295521222656 parent 30423438540800 root 0 extent back ref a=
lready exists for 20295521828864 parent 0 root 4636 extent back ref already=
 exists for 20295522369536 parent 0 root 4220 parent transid verify failed =
on 16079759130624 wanted 671918 found 671896 items checked) parent transid =
verify failed on 16200175910912 wanted 671918 found 671896 parent transid v=
erify failed on 16325838782464 wanted 671918 found 671896 extent back ref a=
lready exists for 16569929728000 parent 0 root 463688657 items checked) ext=
ent back ref already exists for 363828461568 parent 0 root 46361788780 item=
s checked) extent back ref already exists for 363828936704 parent 0 root 46=
36 extent back ref already exists for 466136793088 parent 0 root 4636 exten=
t back ref already exists for 466136809472 parent 0 root 4636 Segmentation =
fault [bluemond@BlueQ ~]$ And this the dmesg log: [Wed Apr 12 16:34:35 2023=
] btrfs[205859]: segfault at 10 ip 0000563e56d478fd sp 00007ffff78fc130 err=
or 4 in btrfs[563e56ce4000+a3000] likely on CPU 5 (core 5, socket 0) [Wed A=
pr 12 16:34:35 2023] Code: 00 4c 8d 47 01 0f 1f 84 00 00 00 00 00 48 8b 43 =
20 48 8b 4b 28 48 01 c1 48 39 cf 0f 83 bc 00 00 00 4c 39 c0 0f 83 e3 00 00 =
00 <48> 8b 42 10 48 3d ff 00 00 00 0f 86 e3 00 00 00 48 3b 7a 18 0f 84 Not =
sure what to try next tbh.... Any suggestions?
