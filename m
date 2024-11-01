Return-Path: <linux-btrfs+bounces-9277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D81D29B8A36
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4313BB220D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 04:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154401482E1;
	Fri,  1 Nov 2024 04:21:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171914658D
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Nov 2024 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730434872; cv=none; b=JvFpB181SRl1d9/sR9xZxI1pDHbPe/ayFyWIle0XWZXKUGGLrCn/6EQeZ+Rvq2ZgS4SA+igNqh3J3bEkMPL/R39VgExNKpduurZ3aRI6dZQ1dxDuRFmdtaIeInkvoVIiTkm9heVE10xJgpKzqiyOAaekDD9FE1YGgdguNn0gyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730434872; c=relaxed/simple;
	bh=Mpy4SKoqCOwfZTioHrn57SPpuALZ5S8Juk7ev9+d6h8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=opjyVAPgKoIs11Z26Pe8umiXYys7IpC/fK/FFOtbWp9kHdKjbN99tNeKL00ujluk1txCYiKXIEUX78bbS97BHbVFB22HBiPKNGbpig6OPMSsug45hWwkqjjk/XPLqmrARE7BClXJbnyJEyLYMlV3WKO+tIGth3EvUTrcfO6BdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so14068165ab.0
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Oct 2024 21:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730434868; x=1731039668;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1adZgegTa+X2++Z7M57k4wS2wTV/AYhdIPSFyHBo678=;
        b=kRF124eW1gQXDN4it3He0rL/A7U2CkriT9G9DYQb3OiqvmO1bHKuGsDQvDs3O+0gCU
         wPQy97okrVHQuAzSOK2zja4CYrA0v+MY3AQRCuMo0PEMpIaFC9/MhS6ytTcaOwpyaj9M
         0MPqFfJ5FaBXjTLcCOmHGnx4BttlpcX2noVDMekQNn2M4PUR60NEzeL1Iat5fvBz1a0A
         dPZ0ohG5TkxoGO/K0dB7fdiYHPB/r9tV/Hj3yOhJ7rxt+gHfRKKVE8Ji0cwufG8g44JT
         kV413wV4uoiTxVZLdAefFpvNDxu9PEnZRCxgKjCqQAibvAR97PPtesxP7Np7t7UBnSaI
         tMbw==
X-Forwarded-Encrypted: i=1; AJvYcCVRipqq8PHcc9imzxC0g+7E5SVkJ2jgk0yhivKxMdOYdUXLR2OhE0v6GKtPY8gfIcMAx2FG7fflZflcRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM4b3oyga82/QbkM1O9nmQfTJQ2bWqh5pid9myPK1Gt7TQYCH7
	1j3Ss/ZWAHSuR6kmJYGM3e1CYLojT41J48jGl1KswAx1qDflVVLtcry1RUoZdUwtokwXOmj+oV3
	DkFZ/33DZVvIJHaoTBb0Engs6SHgYzZ459GCTDHo+9QSXY5oXoRR/yo8=
X-Google-Smtp-Source: AGHT+IFJD9zieL9Bwqn1/UWlWMtu/lCIfBiuX3peld9I2DM0YR0yKDr6haBPZP4meQ7TBmVX5W/8ZZco4pOxZV1HR6IILcN1Us3n
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd86:0:b0:3a3:35f0:4c19 with SMTP id
 e9e14a558f8ab-3a6b03b0cd2mr24500615ab.21.1730434868513; Thu, 31 Oct 2024
 21:21:08 -0700 (PDT)
Date: Thu, 31 Oct 2024 21:21:08 -0700
In-Reply-To: <dc7a742f3b2a4162f5f0a1f45a20c1fb76ce8eaa.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67245734.050a0220.3c8d68.0858.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in close_ctree
From: syzbot <syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sunjunchao2870@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ss_scheduled_works+0xa2c/0x1830
[   73.327092][   T35]  ? __pfx_process_scheduled_works+0x10/0x10
[   73.333107][   T35]  ? assign_work+0x364/0x3d0
[   73.338035][   T35]  worker_thread+0x86d/0xd70
[   73.342932][   T35]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   73.348918][   T35]  ? __kthread_parkme+0x169/0x1d0
[   73.354380][   T35]  ? __pfx_worker_thread+0x10/0x10
[   73.359663][   T35]  kthread+0x2f0/0x390
[   73.364017][   T35]  ? __pfx_worker_thread+0x10/0x10
[   73.369795][   T35]  ? __pfx_kthread+0x10/0x10
[   73.374478][   T35]  ret_from_fork+0x4b/0x80
[   73.378997][   T35]  ? __pfx_kthread+0x10/0x10
[   73.383608][   T35]  ret_from_fork_asm+0x1a/0x30
[   73.388385][   T35]  </TASK>
[   73.393498][   T35]=20
[   73.396306][   T35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   73.401993][   T35] WARNING: suspicious RCU usage
[   73.407119][   T35] 6.10.0-rc4-syzkaller-00003-gd31e86ef6377 #0 Not tain=
ted
[   73.414474][   T35] -----------------------------
[   73.419426][   T35] net/netfilter/ipset/ip_set_core.c:1211 suspicious rc=
u_dereference_protected() usage!
[   73.429512][   T35]=20
[   73.429512][   T35] other info that might help us debug this:
[   73.429512][   T35]=20
[   73.440230][   T35]=20
[   73.440230][   T35] rcu_scheduler_active =3D 2, debug_locks =3D 1
[   73.448892][   T35] 3 locks held by kworker/u8:2/35:
[   73.454197][   T35]  #0: ffff88801b6e3148 ((wq_completion)netns){+.+.}-{=
0:0}, at: process_scheduled_works+0x90a/0x1830
[   73.465331][   T35]  #1: ffffc90000ab7d00 (net_cleanup_work){+.+.}-{0:0}=
, at: process_scheduled_works+0x945/0x1830
[   73.476037][   T35]  #2: ffffffff8f83e650 (pernet_ops_rwsem){++++}-{3:3}=
, at: cleanup_net+0x16a/0xcc0
[   73.485586][   T35]=20
[   73.485586][   T35] stack backtrace:
[   73.491593][   T35] CPU: 0 PID: 35 Comm: kworker/u8:2 Not tainted 6.10.0=
-rc4-syzkaller-00003-gd31e86ef6377 #0
[   73.502691][   T35] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[   73.513716][   T35] Workqueue: netns cleanup_net
[   73.518809][   T35] Call Trace:
[   73.523025][   T35]  <TASK>
[   73.526175][   T35]  dump_stack_lvl+0x241/0x360
[   73.531256][   T35]  ? __pfx_dump_stack_lvl+0x10/0x10
[   73.536637][   T35]  ? __pfx__printk+0x10/0x10
[   73.541357][   T35]  lockdep_rcu_suspicious+0x221/0x340
[   73.546777][   T35]  _destroy_all_sets+0x53f/0x5f0
[   73.551742][   T35]  ip_set_net_exit+0x20/0x50
[   73.556358][   T35]  cleanup_net+0x802/0xcc0
[   73.561075][   T35]  ? __pfx_cleanup_net+0x10/0x10
[   73.566478][   T35]  ? process_scheduled_works+0x945/0x1830
[   73.572218][   T35]  process_scheduled_works+0xa2c/0x1830
[   73.577987][   T35]  ? __pfx_process_scheduled_works+0x10/0x10
[   73.584088][   T35]  ? assign_work+0x364/0x3d0
[   73.588812][   T35]  worker_thread+0x86d/0xd70
[   73.593517][   T35]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   73.599856][   T35]  ? __kthread_parkme+0x169/0x1d0
[   73.605099][   T35]  ? __pfx_worker_thread+0x10/0x10
[   73.610568][   T35]  kthread+0x2f0/0x390
[   73.614847][   T35]  ? __pfx_worker_thread+0x10/0x10
[   73.620047][   T35]  ? __pfx_kthread+0x10/0x10
[   73.624822][   T35]  ret_from_fork+0x4b/0x80
[   73.629506][   T35]  ? __pfx_kthread+0x10/0x10
[   73.634200][   T35]  ret_from_fork_asm+0x1a/0x30
[   73.639333][   T35]  </TASK>
[   73.837536][ T1018] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   73.846609][ T1018] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   73.881180][   T12] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   73.889451][   T12] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   74.764101][   T54] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   74.774581][   T54] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   74.787132][   T54] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   74.795836][   T54] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   74.804209][   T54] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > =
3
[   74.816388][   T54] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   76.110885][ T5269] chnl_net:caif_netlink_parms(): no params data found
[   76.202433][ T5269] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   76.209738][ T5269] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   76.217802][ T5269] bridge_slave_0: entered allmulticast mode
[   76.232096][ T5269] bridge_slave_0: entered promiscuous mode
[   76.248093][ T5269] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   76.255436][ T5269] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   76.263723][ T5269] bridge_slave_1: entered allmulticast mode
[   76.270778][ T5269] bridge_slave_1: entered promiscuous mode
[   76.307733][ T5269] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   76.319630][ T5269] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   76.352955][ T5269] team0: Port device team_slave_0 added
[   76.365037][ T5269] team0: Port device team_slave_1 added
[   76.393595][ T5269] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   76.400676][ T5269] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   76.428714][ T5269] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   76.444591][ T5269] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   76.452810][ T5269] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   76.479277][ T5269] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   76.518718][ T5269] hsr_slave_0: entered promiscuous mode
[   76.526127][ T5269] hsr_slave_1: entered promiscuous mode
[   76.644065][ T5269] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   76.656191][ T5269] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   76.666601][ T5269] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   76.677174][ T5269] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   76.705301][ T5269] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   76.713063][ T5269] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   76.721178][ T5269] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   76.728612][ T5269] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   76.793408][ T5269] 8021q: adding VLAN 0 to HW filter on device bond0
[   76.813501][   T25] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   76.824694][   T25] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   76.847764][ T5269] 8021q: adding VLAN 0 to HW filter on device team0
[   76.864992][ T5276] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   76.872724][ T5276] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   76.888966][ T5277] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   76.896454][ T5277] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   76.934240][ T5269] hsr0: Slave A (hsr_slave_0) is not up; please bring =
it up to get a fully working HSR network
[   76.946752][ T5269] hsr0: Slave B (hsr_slave_1) is not up; please bring =
it up to get a fully working HSR network
[   77.085939][ T5269] 8021q: adding VLAN 0 to HW filter on device batadv0
[   77.138427][ T5269] veth0_vlan: entered promiscuous mode
[   77.155530][ T5269] veth1_vlan: entered promiscuous mode
[   77.199855][ T5269] veth0_macvtap: entered promiscuous mode
[   77.216097][ T5269] veth1_macvtap: entered promiscuous mode
[   77.241139][ T5269] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   77.265095][ T5269] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   77.280957][ T5269] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   77.293499][ T5269] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   77.302863][ T5269] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   77.314571][ T5269] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   77.503942][ T5269] syz-executor (5269) used greatest stack depth: 18704=
 bytes left
[   77.557203][   T35] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
2024/11/01 04:20:05 executed programs: 0
[   77.656155][   T35] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   77.729378][ T4592] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   77.746402][ T4592] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   77.747184][   T35] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   77.762998][ T4592] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   77.775774][ T4592] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   77.785232][ T4592] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > =
3
[   77.793548][ T4592] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   77.820026][   T35] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   77.956684][ T5291] chnl_net:caif_netlink_parms(): no params data found
[   78.025169][ T5291] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   78.032601][ T5291] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   78.039953][ T5291] bridge_slave_0: entered allmulticast mode
[   78.047981][ T5291] bridge_slave_0: entered promiscuous mode
[   78.056275][ T5291] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   78.063812][ T5291] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   78.070975][ T5291] bridge_slave_1: entered allmulticast mode
[   78.078397][ T5291] bridge_slave_1: entered promiscuous mode
[   78.108847][ T5291] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   78.123105][ T5291] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   78.158143][ T5291] team0: Port device team_slave_0 added
[   78.168279][ T5291] team0: Port device team_slave_1 added
[   78.198300][ T5291] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   78.205463][ T5291] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   78.235902][ T5291] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   78.249282][ T5291] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   78.257256][ T5291] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1560 would solve the problem.
[   78.283977][ T5291] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   78.334156][ T5291] hsr_slave_0: entered promiscuous mode
[   78.340571][ T5291] hsr_slave_1: entered promiscuous mode
[   78.348761][ T5291] debugfs: Directory 'hsr0' with parent 'hsr' already =
present!
[   78.357164][ T5291] Cannot create hsr debugfs directory
[   79.832991][   T54] Bluetooth: hci0: command tx timeout
[   81.912093][   T54] Bluetooth: hci0: command tx timeout
[   82.159166][  T786] cfg80211: failed to load regulatory.db
[   82.197063][   T35] bridge_slave_1: left allmulticast mode
[   82.204459][   T35] bridge_slave_1: left promiscuous mode
[   82.211112][   T35] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   82.223520][   T35] bridge_slave_0: left allmulticast mode
[   82.229353][   T35] bridge_slave_0: left promiscuous mode
[   82.237641][   T35] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   82.488532][   T35] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   82.500105][   T35] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   82.510830][   T35] bond0 (unregistering): Released all slaves
[   82.646242][   T35] hsr_slave_0: left promiscuous mode
[   82.656470][   T35] hsr_slave_1: left promiscuous mode
[   82.665484][   T35] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   82.673171][   T35] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   82.681803][   T35] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   82.693548][   T35] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   82.717176][   T35] veth1_macvtap: left promiscuous mode
[   82.723507][   T35] veth0_macvtap: left promiscuous mode
[   82.729270][   T35] veth1_vlan: left promiscuous mode
[   82.738660][   T35] veth0_vlan: left promiscuous mode


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.22.7'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2237638905=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 666f77ed02
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D666f77ed02b98b834393ff84c646a8d611605f6f -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241016-170423'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"666f77ed02b98b834393ff84c646a8d611=
605f6f\"
/usr/bin/ld: /tmp/cc65bbgo.o: in function `test_cover_filter()':
executor.cc:(.text+0x1424b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/cc65bbgo.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D105d32a7980000


Tested on:

commit:         d31e86ef arm64: access_ok() optimization
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git --
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7db415dfa086046=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D2665d678fffcc4608=
e18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

