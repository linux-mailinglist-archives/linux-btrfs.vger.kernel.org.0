Return-Path: <linux-btrfs+bounces-473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB48013EF
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 21:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE5FB2118C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DC055781;
	Fri,  1 Dec 2023 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="s18UkCes"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC88C4
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 12:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701461390; x=1702066190; i=quwenruo.btrfs@gmx.com;
	bh=mJI7HBJiW+VRkHEef3vp5hRyjrfr7Et+bRyc3oXX5pg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=s18UkCesoy9a9LBvV19pUCF9o8quv4Jw1ONX8xrRIwPJQ9k5/rgPMtWTMWOmY9kB
	 I0GeUyo+f6dnTTHPaMpYUj+GsX1QXSNcrGTaqgvEZfRLiA+24hwDH2WqzF4WGeJg5
	 Gu5N2K42en2rrEBmvZx1ra0/R8C/VJ9iAjCDz48dqdCInzLIPxUUQwKyoc7h8BsJm
	 kwof91BDPA0/fzttB3/Y63EZ98q6X0aQ51AVlx2Go38ow9TO5ba2G6Oy9XBIamlQ5
	 Qzi06zejWFbeZfMvYOKIwVCz1yJR6IXoAppnjdBOH7bGOpRK4ym7QDiMDozEdmnH3
	 ElTV7sxEOTIl1i6FHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1rPIln0Chq-00unUa; Fri, 01
 Dec 2023 21:09:50 +0100
Message-ID: <e20c7d59-c460-4236-9771-9cb4a3f9dfb2@gmx.com>
Date: Sat, 2 Dec 2023 06:39:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS corruption after conversion to block group tree
To: Russell Haley <yumpusamongus@gmail.com>, linux-btrfs@vger.kernel.org
References: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qptxH0ceT86/m/lh0RgLfuf21epGcEWPV7JC4046pRTbrYBUozt
 Z1WZkHXIxCnDa/KXWEpqA/iDXMCadtrWThKZs4RXwtoOADJAoMMvsuxhR5RzzAQvH3pDwgy
 EJWCDaTeUWIW3kA08q293p20uKFE/ea0gLfRWnaH8Tt4mpnOl4u/MfQbewM8aBFymCqZGXC
 pkMWATTZL6kZo7ez/qehg==
UI-OutboundReport: notjunk:1;M01:P0:+xkP6VHnT/8=;BCiq15j0Em8FqePxF8dX5sTSlDF
 QNBTs6PbGZImijWmmvHzAgyRoWWU1d+EKHJTRwem1Lgv1cj4e4gmeTzP+hWPWO+q/OZtZLMrP
 pLF8UL7OxhwSUuJePz0IfAiSrhFNIbQwsu9wV1uGpX1FQfeZUD4c3R2uiZS8fne5Bu6BfUja+
 +vzutoLLE3N+WamSP9CWq97mTC4l+FW4PH5ew7iDTtPMuDtE60RPLuY9VMesJUOe9qKDcaAtI
 ch4qrKb4fnh0jPwDnTQjc2nizNUpbc8PJ1Y1eaQ4lpVIy5VTd3sAz00bptvUYngouZWCRTeUR
 wviyU7Ta59I8yOG6VKd/e2cl8MEvmyuXKEaf5zH9vjUYPYEkbMfpgPf83g0lm5/myh73Jf+E6
 UQoaEX7tk0839dshMzB4dCWrxM2uDm+as1VtCOu0AGgqNz8EPwx41Pa1tjaJJghFdqw8iKWog
 QAJTQxiiJ8ne4yOevZq2/FD7Ip00fWY4mG/NU3ijnxCWNQymu3aK0vsrri988bHzYwGw9TXtc
 jtprdATujSnQ/HvBQAk6M1NFyh1gqMC0XCZs+/bjLsifCBikw7WbO8JggSZkqXWcA/fN5tNlP
 5JwV395z88/6KPayxJM8DR0wazXZ74O5XfMoSzvFVv34hiGfT8E7GccdODMRPJHxFDGpHbV5x
 ghL3HUJli8RRHhIo2xTjaV1GQ6WDxjCtqbHCEIL+onjxY+HLNHs4BOOlP2gqCmYDg+bMICojz
 aTai11+W4x+eEprxcBkYGrbyWleyyZp2KPUOaWP+gHg2KhRjA4zt7RNrasau3PbFC+fOLJQvs
 uveAL+AwIqmEZAExGnTU7dYCwf2wlnpbN3yF+UUao2b+PyyMgdTbtPZuS9CMe9n/Aidyy1FfR
 9oYJynZmAcaJ8+6g5QmC3/69IHkBb7+V/dgQgu6PJ3ycSJHM5T2ikTdP0Upp9ntLnbwyDB7Sl
 TBDHB7CXalHfXMZaTR3LuM2gWlM=



On 2023/12/1 22:16, Russell Haley wrote:
> Distro: Fedora 39
> kernel: 6.5.12
> btrfs-progs: v6.5.1.
>
> To put everyone at ease, the data seems mostly okay. The disk is
> mountable with ro,rescue=3Dingorebadroots:nologreplay, and I'm pulling o=
ff
> what I can.  Furthermore, there's a good chance this is the result of a
> marginally-unstable overclock. However, the symptoms are very similar to
> a recent report from Alexander Duscheleit [1], so there may be a deeper
> problem. I can provide requested metadata dumps if it would be useful,
> and I also have a few questions.
>
> A few days ago I used btrfstune to convert two btrfs filesystems to
> block-group-tree, after reading that it would reduce mount time. After
> about 10 hours, while I was using Steam, the more heavily-used of the
> two disks, which holds (among other things) the Steam game library,
> experienced a transaction abort and went read-only.

Any dmesg of that transaction abort? That's the most critical info here.

>  Attempting to mount
> the drive again after a reboot produces this in dmseg:
>
>> [159873.932366] BTRFS info (device dm-1): using crc32c (crc32c-intel) c=
hecksum algorithm
>> [159873.932372] BTRFS info (device dm-1): using free space tree
>> [159877.771165] BTRFS error (device dm-1): level verify failed on logic=
al 2073442516992 mirror 1 wanted 1 found 0
>> [159877.777624] BTRFS error (device dm-1): level verify failed on logic=
al 2073442516992 mirror 2 wanted 1 found 0
>> [159877.777815] BTRFS error (device dm-1): failed to read block groups:=
 -5
>> [159877.783744] BTRFS error (device dm-1): open_ctree failed
>
> An annotated excerpt from the system journal is included at the end of
> this mail, and here's everything I've discovered or thought of that
> might be relevant:
>
> 1. The disk in question is an https://en.wikipedia.org/wiki/ST3000DM001
>     and it is LUKS-encrypted.
>
> 2. There's something extremely weird with the primary superblock. "btrfs
>     inspect-internal dump-super" says that superblock 0 doesn't have the
>     BLOCK_GROUP_TREE or NO_HOLES flags set, unlike superblocks 1 and 2,
>     which are identical in every field except csum ("[match]", for 0, 1,
>     and 2) and bytenr.

This is not good at all, if csum of super blocks doesn't match, there
must be something especially wrong.

Thanks,
Qu

  The disk was supposed to have been converted to
>     block-group-tree many hours before.  Furthermore, the generation
>     number for SB 0 is 123887, while for 1 and 2 it is 123917. And
>     "btrfs-check" fails almost completely when pointed at SB 0, with:
>
>>      > sudo btrfs check  /dev/mapper/3tb_spinner
>>      Opening filesystem to check...
>>      parent transid verify failed on 2073442516992 wanted 123754 found =
123917
>>      parent transid verify failed on 2073442516992 wanted 123754 found =
123917
>>      parent transid verify failed on 2073442516992 wanted 123754 found =
123917
>>      Ignoring transid failure
>>      ERROR: child eb corrupted: parent bytenr=3D806912000 item=3D33 par=
ent level=3D2 child bytenr=3D2073442516992 child level=3D0
>>      ERROR: failed to read block groups: Input/output error
>>      ERROR: cannot open file system
>>
>     Checking superblock 1 or 2 spits out 2 GB on stderr, and gets all
> the way to:
>>
>>      [4/7] checking fs roots
>>      root 5 root dir 256 not found
>>      root 260 root dir 256 not found
>>      root 18446744073709551607 root dir 256 not found
>>      ERROR: errors found in fs roots
>>      using SB copy 1, bytenr 67108864
>>      Opening filesystem to check...
>>      Checking filesystem on /dev/mapper/3tb_spinner
>>      UUID: 8cf4bcd8-76c7-4494-a2c8-2578136c0aa6
>>      found 1950654984192 bytes used, error(s) found
>>      total csum bytes: 1700177772
>>      total tree bytes: 5770002432
>>      total fs tree bytes: 3816734720
>>      total extent tree bytes: 0
>>      btree space waste bytes: 698646748
>>      file data blocks allocated: 2145891516416
>>       referenced 2495964958720
>
> 3. The problem is immediately preceded in the log by a "GpuWatchdog"
>     segfault in steamwebhelper. The stack trace points into libcef, and
>     users on Arch [2] and Ubuntu [3] report hangs in Chrome/Electron wit=
h
>     similar log messages. I don't remember a hang, but I could've
>     forgotten in all the excitement. Logs show a similar segfault
>     happened twice on 2023-09-09, 20 minutes apart, under kernel 6.4.13,
>     without affecting anything outside Steam.
>
> 4. I don't open Steam that frequently. This was the first and only time
>     I've run steam on kernel 6.5.12. Prior to that were kernels 6.5.11
>     and 6.5.5.
>
> 5. Steam is running on the Intel Haswell integrated graphics, HD 4600.
>
> 6. At the time of the failure, I had BIOS options set to overclock the
>     iGPU from 1200 MHz to 1600 MHz, with voltage 1.12 V "adaptive". The
>     frequency bump was inactive because the GPU doesn't clock higher tha=
n
>     1200 MHz unless told to do so by writing to gt_boost_freq_mhz under
>     /sys/class/drm/card*, and the systemd unit I have to do that is
>     disabled. The voltage setting might have been doing something. I
>     don't know what the default is, but at least on the CPU core side,
>     "adaptive" voltage only affects voltage-frequency pairs in the
>     "boost" side of the curve. So I *think* it should've done nothing.
>     But I have reset those options to Auto/Auto out of caution.
>
> 7. At the time of the failure, and now, the CPU core and memory bus were
>     also overclocked. I consider the CPU OC to be more tested, since it'=
s
>     been that way for years and was re-stress-tested ~3 months ago,
>     before tuning the memory OC after a new RAM installation. That was
>     all stress tested for hours at considerably higher
>     loads/temperature/current than anything I was doing when this proble=
m
>     occurred, with a variety of stressors and CPU quotas to give the CPU
>     VRM's transient response a hard time. I'm always wary of memory, so
>     out of caution after this incident, I de-rated the memory bus from
>     1866 MT/s to 1800 without changing any timings.
>
> I have 2 theories of what might've happened:
>
> 1. Somehow, the disk silently failed to accept / flush a bunch of
>     writes, but *seemingly* correct data was buffered in the kernel unti=
l
>     heavy I/O from Steam forced it out and it was read back in again.
>     This would explain why the primary superblock seems to be older than
>     the block-group-tree conversion.
>
> 2. That segfault was associated with something scribbling over something
>     important that was going through the memory controller at the same
>     time, because Steam was actively applying updates to the games store=
d
>     on the drive. That would explain why the btrfs error manifested 2
>     seconds after the segfault, and why it happened when I ran Steam and
>     not any time in the preceding 10 hours.
>
> And now... the questions:
>
> First, is the other filesystem that was converted to block group tree in
> danger as well?  Any more than it was a week ago?  It passed a scrub,
> and doesn't seem to have been affected, but I currently have it mounted
> read-only as a precaution.  Should I --convert-from-block-group-tree?
> That FS is used almost exclusively as a backup target for my other
> drives, and did not get any significant I/O traffic (maybe no writes at
> all) between the conversion to block-group-tree and when the corruption
> was discovered.
>
> Second, Fedora has updates to kernel and btrfs-progs 6.6.2.  Will
> installing these help or hinder further troubleshooting and analysis?
> The block group tree conversion was done with btrfs-progs 6.5.1 on
> kernel 6.5.12, which was also running when the corruption happened.
>
> Third... before I re-format the affected disk, is there anything I
> should collect from it that would help improve btrfs?
>
> Alternately, maybe could I just... btrfs-select-super?  Is that crazy?
>
> Links:
>
> 1.
> https://lore.kernel.org/linux-btrfs/49144585162c9dc5a403c442154ecf54f544=
6aca@sweevo.net/
>
> 2. https://bbs.archlinux.org/viewtopic.php?id=3D263124
>
> 3. https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1861294
>
> Annotated log:
>
>> # Faffing around trying to      Nov 25 20:23:21 hogwarts sudo[106477]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/sbin/btrfs inspect-internal /dev/sda
>>    find the command to show      Nov 25 20:23:21 hogwarts sudo[106477]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>    whether block-group-tree      Nov 25 20:23:21 hogwarts sudo[106477]:=
 pam_unix(sudo:session): session closed for user root
>>    is enabled                    Nov 25 20:23:33 hogwarts sudo[106544]:=
   rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/u=
sr/sbin/btrfs inspect-internal tree-stats /dev/sda
>>                                  Nov 25 20:23:33 hogwarts sudo[106544]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:23:33 hogwarts sudo[106544]:=
 pam_unix(sudo:session): session closed for user root
>>                                  Nov 25 20:23:48 hogwarts systemd[1]: f=
printd.service: Deactivated successfully.
>>                                  Nov 25 20:23:49 hogwarts sudo[106597]:=
   rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/u=
sr/sbin/btrfs inspect-internal tree-stats /dev/mapper/3tb_spinner
>>                                  Nov 25 20:23:49 hogwarts sudo[106597]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:25:50 hogwarts smartd[1925]:=
 Device: /dev/disk/by-id/ata-ST3000DM001-1CH166_Z1F42Z96 [SAT], SMART Pref=
ailure Attribute: 1 Raw_Read_Error_Rate changed from 106 to 111
>>                                  Nov 25 20:28:04 hogwarts sudo[106597]:=
 pam_unix(sudo:session): session closed for user root
>>                                  Nov 25 20:28:56 hogwarts systemd[1]: S=
tarting fprintd.service - Fingerprint Authentication Daemon...
>>                                  Nov 25 20:28:56 hogwarts systemd[1]: S=
tarted fprintd.service - Fingerprint Authentication Daemon.
>>                                  Nov 25 20:28:59 hogwarts sudo[107352]:=
   rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/u=
sr/sbin/btrfs inspect-internal dump-tree /mnt/3tb_spinner/
>>                                  Nov 25 20:28:59 hogwarts sudo[107352]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:28:59 hogwarts sudo[107352]:=
 pam_unix(sudo:session): session closed for user root
>>                                  Nov 25 20:29:14 hogwarts sudo[107441]:=
   rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/u=
sr/sbin/btrfs inspect-internal dump-tree /dev/mapper/3tb_spinner
>>                                  Nov 25 20:29:14 hogwarts sudo[107441]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:29:25 hogwarts sudo[107441]:=
 pam_unix(sudo:session): session closed for user root
>>                                  Nov 25 20:29:26 hogwarts systemd[1]: f=
printd.service: Deactivated successfully.
>>                                  Nov 25 20:29:30 hogwarts sudo[107520]:=
   rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/u=
sr/sbin/btrfs inspect-internal dump-tree /dev/mapper/3tb_spinner
>>                                  Nov 25 20:29:30 hogwarts sudo[107520]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:29:50 hogwarts sudo[107520]:=
 pam_unix(sudo:session): session closed for user root
>> # Aha, that's it.               Nov 25 20:29:58 hogwarts sudo[107592]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/sbin/btrfs inspect-internal dump-super /dev/mapper/3tb_spinner
>>                                  Nov 25 20:29:58 hogwarts sudo[107592]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:29:58 hogwarts sudo[107592]:=
 pam_unix(sudo:session): session closed for user root
>>                                  Nov 25 20:30:16 hogwarts systemd[1]: S=
tarting sysstat-collect.service - system activity accounting tool...
>>                                  Nov 25 20:30:16 hogwarts systemd[1]: s=
ysstat-collect.service: Deactivated successfully.
>>                                  Nov 25 20:30:16 hogwarts systemd[1]: F=
inished sysstat-collect.service - system activity accounting tool.
>> # Check the other disk          Nov 25 20:30:38 hogwarts sudo[107679]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/sbin/btrfs inspect-internal dump-super /dev/mapper/8tb_spinner
>>                                  Nov 25 20:30:38 hogwarts sudo[107679]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:30:49 hogwarts sudo[107679]:=
 pam_unix(sudo:session): session closed for user root
>> *snip*
>> # Unmount 8tb_spinner           Nov 25 20:54:49 hogwarts sudo[111798]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/bin/umount /mnt/8tb_spinner
>>                                  Nov 25 20:54:49 hogwarts sudo[111798]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>> # umount succeeds               Nov 25 20:54:49 hogwarts systemd[1]: mn=
t-8tb_spinner.mount: Deactivated successfully.
>>                                  Nov 25 20:54:49 hogwarts dolphin[5493]=
: kf.kio.core: Invalid URL: QUrl("")
>>                                  Nov 25 20:55:01 hogwarts sudo[111798]:=
 pam_unix(sudo:session): session closed for user root
>>                                  Nov 25 20:55:07 hogwarts systemd[2626]=
: Started run-rf6aa7b05f8534a5f89991cfba6deb72a.scope - /usr/bin/fish.
>>                                  Nov 25 20:55:16 hogwarts systemd[1]: f=
printd.service: Deactivated successfully.
>> # Try to convert 8tb_spinner,   Nov 25 20:55:41 hogwarts sudo[111967]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/sbin/btrfstune --convert-to-block-group-tree /mnt/8tb_spinner/
>>    but accidentally using the    Nov 25 20:55:41 hogwarts sudo[111967]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>    mount point.                  Nov 25 20:55:41 hogwarts sudo[111967]:=
 pam_unix(sudo:session): session closed for user root
>> # Do it right this time.        Nov 25 20:55:49 hogwarts sudo[112011]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/sbin/btrfstune --convert-to-block-group-tree /dev/mapper/8tb_spinner
>>                                  Nov 25 20:55:49 hogwarts sudo[112011]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>> # It just does that sometimes.  Nov 25 20:55:50 hogwarts smartd[1925]: =
Device: /dev/disk/by-id/ata-ST3000DM001-1CH166_Z1F42Z96 [SAT], SMART Prefa=
ilure Attribute: 1 Raw_Read_Error_Rate changed from 111 to 114
>>                                  Nov 25 20:56:50 hogwarts sudo[112011]:=
 pam_unix(sudo:session): session closed for user root
>>                                  Nov 25 20:56:51 hogwarts kernel: BTRFS=
: device fsid 4ddb9d32-698c-477e-9177-302ae1528e31 devid 1 transid 12769 /=
dev/dm-6 scanned by (udev-worker) (112218)
>> # See the effect of the change, Nov 25 20:57:03 hogwarts sudo[112253]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/sbin/btrfs inspect-internal dump-super /dev/mapper/8tb_spinner
>>                                  Nov 25 20:57:03 hogwarts sudo[112253]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:57:03 hogwarts sudo[112253]:=
 pam_unix(sudo:session): session closed for user root
>> # And compare to 3tb_spinner.   Nov 25 20:57:12 hogwarts sudo[112284]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/sbin/btrfs inspect-internal dump-super /dev/mapper/3tb_spinner
>>                                  Nov 25 20:57:12 hogwarts sudo[112284]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:57:12 hogwarts sudo[112284]:=
 pam_unix(sudo:session): session closed for user root
>> # Finally, re-mount.            Nov 25 20:57:18 hogwarts sudo[112338]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/bin/mount /mnt/8tb_spinner/
>>                                  Nov 25 20:57:18 hogwarts sudo[112338]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:57:18 hogwarts kernel: BTRFS=
 info (device dm-6): using crc32c (crc32c-intel) checksum algorithm
>>                                  Nov 25 20:57:18 hogwarts kernel: BTRFS=
 info (device dm-6): turning on flush-on-commit
>>                                  Nov 25 20:57:18 hogwarts kernel: BTRFS=
 info (device dm-6): force zstd compression, level 3
>>                                  Nov 25 20:57:18 hogwarts kernel: BTRFS=
 info (device dm-6): using free space tree
>>                                  Nov 25 20:57:19 hogwarts kernel: BTRFS=
 info (device dm-6): checking UUID tree
>>                                  Nov 25 20:57:19 hogwarts sudo[112338]:=
 pam_unix(sudo:session): session closed for user root
>> # Try to umount 3tb_spinner,    Nov 25 20:57:32 hogwarts sudo[112401]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/bin/umount /mnt/3tb_spinner
>>    but fail because I had a      Nov 25 20:57:32 hogwarts sudo[112401]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>    file open.                    Nov 25 20:57:32 hogwarts sudo[112401]:=
 pam_unix(sudo:session): session closed for user root
>> # Try again to umount,          Nov 25 20:58:18 hogwarts sudo[112541]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/bin/umount /mnt/3tb_spinner
>>                                  Nov 25 20:58:18 hogwarts sudo[112541]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>> # and succeed.                  Nov 25 20:58:18 hogwarts systemd[1]: mn=
t-3tb_spinner.mount: Deactivated successfully.
>>                                  Nov 25 20:58:18 hogwarts sudo[112541]:=
 pam_unix(sudo:session): session closed for user root
>> # this was 'time sudo mount'    Nov 25 20:58:24 hogwarts sudo[112592]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/bin/mount /mnt/3tb_spinner/
>>                                  Nov 25 20:58:24 hogwarts sudo[112592]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:58:24 hogwarts sudo[112592]:=
 pam_unix(sudo:session): session closed for user root
>> # umount                        Nov 25 20:58:27 hogwarts sudo[112602]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/bin/umount /mnt/3tb_spinner
>>                                  Nov 25 20:58:27 hogwarts sudo[112602]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>> # succeed                       Nov 25 20:58:27 hogwarts systemd[1]: mn=
t-3tb_spinner.mount: Deactivated successfully.
>>                                  Nov 25 20:58:27 hogwarts sudo[112602]:=
 pam_unix(sudo:session): session closed for user root
>> # Drop the cache to better      Nov 25 20:58:40 hogwarts sudo[112649]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/sbin/sysctl vm.drop_caches=3D3
>>    measure mount time.           Nov 25 20:58:40 hogwarts sudo[112649]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>                                  Nov 25 20:58:41 hogwarts kernel: sysct=
l (112651): drop_caches: 3
>>                                  Nov 25 20:58:41 hogwarts sudo[112649]:=
 pam_unix(sudo:session): session closed for user root
>> # time sudo mount               Nov 25 20:58:44 hogwarts sudo[112669]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/bin/mount /mnt/3tb_spinner/
>>    No noticeable difference.     Nov 25 20:58:44 hogwarts sudo[112669]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>    Block cache or something?     Nov 25 20:58:45 hogwarts sudo[112669]:=
 pam_unix(sudo:session): session closed for user root
>> # Umount 3tb_spinner in order   Nov 25 20:58:49 hogwarts sudo[112687]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/bin/umount /mnt/3tb_spinner
>>    to convert to block group     Nov 25 20:58:49 hogwarts sudo[112687]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>    tree.                         Nov 25 20:58:49 hogwarts sudo[112687]:=
 pam_unix(sudo:session): session closed for user root
>>                                  Nov 25 20:58:49 hogwarts systemd[1]: m=
nt-3tb_spinner.mount: Deactivated successfully.
>> # Convert 3tb_spinner to block  Nov 25 20:59:02 hogwarts sudo[112737]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/sbin/btrfstune --convert-to-block-group-tree /dev/mapper/3tb_spinner
>>    group tree. This one will     Nov 25 20:59:02 hogwarts sudo[112737]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>    become a problem.             Nov 25 21:00:02 hogwarts sudo[112737]:=
 pam_unix(sudo:session): session closed for user root
>>                                  Nov 25 21:00:02 hogwarts kernel: BTRFS=
 info: devid 1 device path /dev/mapper/3tb_spinner changed to /dev/dm-1 sc=
anned by (udev-worker) (112908)
>>                                  Nov 25 21:00:02 hogwarts kernel: BTRFS=
 info: devid 1 device path /dev/dm-1 changed to /dev/mapper/3tb_spinner sc=
anned by (udev-worker) (112908)
>>                                  Nov 25 21:00:02 hogwarts systemd[1]: S=
tarting sysstat-collect.service - system activity accounting tool...
>>                                  Nov 25 21:00:02 hogwarts systemd[1]: s=
ysstat-collect.service: Deactivated successfully.
>>                                  Nov 25 21:00:02 hogwarts systemd[1]: F=
inished sysstat-collect.service - system activity accounting tool.
>>                                  Nov 25 21:01:01 hogwarts CROND[113070]=
: (root) CMD (run-parts /etc/cron.hourly)
>>                                  Nov 25 21:01:01 hogwarts run-parts[113=
073]: (/etc/cron.hourly) starting 0anacron
>>                                  Nov 25 21:01:01 hogwarts run-parts[113=
079]: (/etc/cron.hourly) finished 0anacron
>>                                  Nov 25 21:01:01 hogwarts CROND[113069]=
: (root) CMDEND (run-parts /etc/cron.hourly)
>> # Re-mount 3tb_spinner.         Nov 25 21:01:53 hogwarts sudo[113218]: =
  rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/bin/mount /mnt/3tb_spinner/
>>    For some reason there are no  Nov 25 21:01:53 hogwarts sudo[113218]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>    kernel messages about mount   Nov 25 21:01:53 hogwarts sudo[113218]:=
 pam_unix(sudo:session): session closed for user root
>>    options like there were for   Nov 25 21:06:03 hogwarts sudo[114038]:=
   rhaley : TTY=3Dpts/16 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/u=
sr/sbin/btrfs fi usage /mnt/3tb_spinner/
>>    FS A. They're the same in     Nov 25 21:06:03 hogwarts sudo[114038]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>    /etc/fstab...                 Nov 25 21:06:03 hogwarts sudo[114038]:=
 pam_unix(sudo:session): session closed for user root
>>    Fish shell history shows I    Nov 25 21:10:16 hogwarts systemd[1]: S=
tarting sysstat-collect.service - system activity accounting tool...
>>    edited a file on there, so it Nov 25 21:10:16 hogwarts systemd[1]: s=
ysstat-collect.service: Deactivated successfully.
>>    must've mounted okay, right?  Nov 25 21:10:16 hogwarts systemd[1]: F=
inished sysstat-collect.service - system activity accounting tool.
>>                                  Nov 25 21:12:18 hogwarts systemd[1]: S=
tarting dnf-makecache.service - dnf makecache...
>> *snip* 10 hours later
>>                                  Nov 26 07:13:24 hogwarts plasmashell[3=
112]: qt.qpa.wayland: Wayland does not support QWindow::requestActivate()
>>                                  Nov 26 07:13:25 hogwarts plasmashell[3=
112]: QString::arg: 2 argument(s) missing in com.valvesoftware.Steam
>> # Launch Steam flatpak.         Nov 26 07:13:26 hogwarts systemd[2626]:=
 Started app-com.valvesoftware.Steam-7ac4bbfd2b544794b72f01851b78ce4a.scop=
e - Steam.
>>                                  Nov 26 07:13:26 hogwarts systemd[2626]=
: Started app-flatpak-com.valvesoftware.Steam-201383.scope.
>>                                  Nov 26 07:13:26 hogwarts plasmashell[2=
01397]: INFO:root:https://github.com/flathub/com.valvesoftware.Steam/wiki
>>                                  Nov 26 07:13:26 hogwarts plasmashell[2=
01397]: INFO:root:Will set XDG dirs prefix to /home/rhaley/.var/app/com.va=
lvesoftware.Steam
>>                                  Nov 26 07:13:26 hogwarts plasmashell[2=
01397]: DEBUG:root:Checking input devices permissions
>>                                  Nov 26 07:13:26 hogwarts plasmashell[2=
01397]: INFO:root:Overriding TZ to America/Chicago
>>                                  Nov 26 07:13:26 hogwarts plasmashell[2=
01397]: steam.sh[2]: Running Steam on org.freedesktop.platform 23.08 64-bi=
t
>>                                  Nov 26 07:13:26 hogwarts plasmashell[2=
01397]: steam.sh[2]: STEAM_RUNTIME is enabled automatically
>>                                  Nov 26 07:13:26 hogwarts plasmashell[2=
01469]: setup.sh[74]: Steam runtime environment up-to-date!
>>                                  Nov 26 07:13:27 hogwarts plasmashell[2=
01397]: steam.sh[2]: Steam client's requirements are satisfied
>>                                  Nov 26 07:13:27 hogwarts plasmashell[2=
01509]: 11/26 07:13:27 Init: Installing breakpad exception handler for app=
id(steam)/version(1700160213)/tid(108)
>>                                  Nov 26 07:13:30 hogwarts xdg-desktop-p=
ortal-kde[3153]: xdp-kde-settings: Namespace  "org.gnome.desktop.interface=
"  is not supported
>>                                  Nov 26 07:13:30 hogwarts plasmashell[2=
01552]: steamwebhelper.sh[121]: Runtime for steamwebhelper: defaulting to =
/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_=
64/steam-runtime-heavy
>>                                  Nov 26 07:13:30 hogwarts plasmashell[2=
01552]: steamwebhelper.sh[121]: Running under Flatpak, disabling sandbox
>>                                  Nov 26 07:13:30 hogwarts plasmashell[2=
01552]: steamwebhelper.sh[121]: CEF sandbox already disabled
>>                                  Nov 26 07:13:30 hogwarts plasmashell[2=
01509]: CAppInfoCacheReadFromDiskThread took 52 milliseconds to initialize
>>                                  Nov 26 07:13:30 hogwarts rtkit-daemon[=
1918]: Successfully made thread 201588 of process 201509 (/home/rhaley/.va=
r/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_32/steam) owned =
by '1000' high priority at nice level -10.
>>                                  Nov 26 07:13:30 hogwarts rtkit-daemon[=
1918]: Successfully made thread 201589 of process 201509 (/home/rhaley/.va=
r/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_32/steam) owned =
by '1000' high priority at nice level -10.
>>                                  Nov 26 07:13:30 hogwarts rtkit-daemon[=
1918]: Successfully made thread 201607 of process 201509 (/home/rhaley/.va=
r/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_32/steam) owned =
by '1000' high priority at nice level -10.
>>                                  Nov 26 07:13:31 hogwarts plasmashell[2=
01509]: Steam Runtime Launch Service: starting steam-runtime-launcher-serv=
ice
>>                                  Nov 26 07:13:31 hogwarts plasmashell[2=
01509]: Steam Runtime Launch Service: steam-runtime-launcher-service is ru=
nning pid 175
>>                                  Nov 26 07:13:31 hogwarts steam-runtime=
-launcher-service[201617]: E: Unable to acquire bus name "com.steampowered=
.PressureVessel.LaunchAlongsideSteam"
>>                                  Nov 26 07:13:31 hogwarts xdg-desktop-p=
ortal-kde[3153]: xdp-kde-settings: Namespace  "org.gnome.desktop.interface=
"  is not supported
>> # Note that Steam is running    Nov 26 07:13:32 hogwarts plasmashell[20=
1676]: MESA-INTEL: warning: Haswell Vulkan support is incomplete
>>    on the Intel integrated GPU.  Nov 26 07:13:32 hogwarts plasmashell[2=
01509]: Steam Runtime Launch Service: steam-runtime-launcher-service pid 1=
75 exited
>>    This could be related to the  Nov 26 07:13:32 hogwarts plasmashell[2=
01683]: MESA-INTEL: warning: Haswell Vulkan support is incomplete
>>    problem, because this machine Nov 26 07:13:33 hogwarts plasmashell[2=
01509]: Steam Runtime Launch Service: starting steam-runtime-launcher-serv=
ice
>>    has overclocked memory, and   Nov 26 07:13:33 hogwarts plasmashell[2=
01509]: Steam Runtime Launch Service: steam-runtime-launcher-service is ru=
nning pid 245
>>    the IGP could possibly use    Nov 26 07:13:33 hogwarts steam-runtime=
-launcher-service[201693]: E: Unable to acquire bus name "com.steampowered=
.PressureVessel.LaunchAlongsideSteam"
>>    the memory subsystem in ways  Nov 26 07:13:34 hogwarts plasmashell[2=
01509]: Steam Runtime Launch Service: steam-runtime-launcher-service pid 2=
45 exited
>>    CPU-based stress tests don't. Nov 26 07:13:35 hogwarts plasmashell[2=
01509]: Steam Runtime Launch Service: starting steam-runtime-launcher-serv=
ice
>>                                  Nov 26 07:13:35 hogwarts plasmashell[2=
01509]: Steam Runtime Launch Service: steam-runtime-launcher-service is ru=
nning pid 249
>>                                  Nov 26 07:13:35 hogwarts steam-runtime=
-launcher-service[201708]: E: Unable to acquire bus name "com.steampowered=
.PressureVessel.LaunchAlongsideSteam"
>>                                  Nov 26 07:13:36 hogwarts plasmashell[2=
01509]: Steam Runtime Launch Service: steam-runtime-launcher-service pid 2=
49 exited
>>                                  Nov 26 07:13:36 hogwarts plasmashell[2=
01509]: Steam Runtime Launch Service: steam-runtime-launcher-service keeps=
 crashing on startup, disabling
>>                                  Nov 26 07:13:40 hogwarts python3[1899]=
: INFO [fancontrol_ng.py:amdgpu_power_gen:276] State.WARM GPU turned OFF
>>                                  Nov 26 07:13:43 hogwarts plasmashell[2=
01509]: BRefreshApplicationsInLibrary 1: 16ms
>>                                  Nov 26 07:13:44 hogwarts plasmashell[3=
112]: libpng warning: iCCP: known incorrect sRGB profile
>>                                  Nov 26 07:13:44 hogwarts plasmashell[3=
112]: libpng warning: known incorrect sRGB profile
>>                                  Nov 26 07:13:44 hogwarts plasmashell[3=
112]: libpng warning: profile matches sRGB but writing iCCP instead
>> # *HORK*                        Nov 26 07:14:01 hogwarts kernel: GpuWat=
chdog[201636]: segfault at 0 ip 00007ff3cb592bc6 sp 00007ff3c2350960 error=
 6 in libcef.so[7ff3c70ef000+7770000] likely on CPU 2 (core 2, socket 0)
>>                                  Nov 26 07:14:01 hogwarts kernel: Code:=
 89 de e8 5d ee 6e ff 80 7d cf 00 79 09 48 8b 7d b8 e8 2e 66 2c 03 41 8b 8=
4 24 e0 00 00 00 89 45 b8 48 8d 7d b8 e8 3a d1 b5 fb <c7> 04 25 00 00 00 0=
0 37 13 00 00 48 83 c4 38 5b 41 5c 41 5d 41 5e
>>                                  Nov 26 07:14:01 hogwarts systemd[1]: C=
reated slice system-systemd\x2dcoredump.slice - Slice /system/systemd-core=
dump.
>>                                  Nov 26 07:14:01 hogwarts systemd[1]: S=
tarted systemd-coredump@0-201803-0.service - Process Core Dump (PID 201803=
/UID 0).
>>                                  Nov 26 07:14:01 hogwarts systemd-cored=
ump[201807]: Process 201629 (steamwebhelper) of user 1000 dumped core.
>>
>>                                                                        =
             Stack trace of thread 192:
>>                                                                        =
             #0  0x00007ff3cb592bc6 n/a (/home/rhaley/.var/app/com.valveso=
ftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x5f92bc6)
>>                                                                        =
             #1  0x00007ff3cb592453 n/a (/home/rhaley/.var/app/com.valveso=
ftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x5f92453)
>>                                                                        =
             #2  0x00007ff3c9a16176 n/a (/home/rhaley/.var/app/com.valveso=
ftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x4416176)
>>                                                                        =
             #3  0x00007ff3c9a26bbc n/a (/home/rhaley/.var/app/com.valveso=
ftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x4426bbc)
>>                                                                        =
             #4  0x00007ff3c99df72a n/a (/home/rhaley/.var/app/com.valveso=
ftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x43df72a)
>>                                                                        =
             #5  0x00007ff3c9a27284 n/a (/home/rhaley/.var/app/com.valveso=
ftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x4427284)
>>                                                                        =
             #6  0x00007ff3c99fee3e n/a (/home/rhaley/.var/app/com.valveso=
ftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x43fee3e)
>>                                                                        =
             #7  0x00007ff3c9a40f47 n/a (/home/rhaley/.var/app/com.valveso=
ftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x4440f47)
>>                                                                        =
             #8  0x00007ff3c9a62a45 n/a (/home/rhaley/.var/app/com.valveso=
ftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x4462a45)
>>                                                                        =
             #9  0x00007ff3c4aa1e39 n/a (/usr/lib/x86_64-linux-gnu/libc.so=
.6 + 0x8ee39)
>>                                                                        =
             #10 0x00007ff3c4b298c4 n/a (/usr/lib/x86_64-linux-gnu/libc.so=
.6 + 0x1168c4)
>>                                                                        =
             ELF object binary architecture: AMD x86-64
>>                                  Nov 26 07:14:01 hogwarts systemd[1]: s=
ystemd-coredump@0-201803-0.service: Deactivated successfully.
>>                                  Nov 26 07:14:02 hogwarts abrt-server[2=
01827]: Unsupported container technology
>>                                  Nov 26 07:14:02 hogwarts abrt-server[2=
01827]: Lock file '.lock' was locked by process 201830, but it crashed?
>>                                  Nov 26 07:14:03 hogwarts abrt-notifica=
tion[201866]: Process 201629 (steamwebhelper) crashed in ??()
>> # Problem manifests on dm-1,    Nov 26 07:14:03 hogwarts kernel: BTRFS =
error (device dm-1): parent transid verify failed on logical 31850496 mirr=
or 1 wanted 123883 found 123907
>>    which is 3tb_spinner.         Nov 26 07:14:03 hogwarts abrt-applet[3=
475]: g_app_info_should_show: assertion 'G_IS_APP_INFO (appinfo)' failed
>>                                  Nov 26 07:14:03 hogwarts plasmashell[3=
112]: Could not find the Plasmoid for Plasma::FrameSvgItem(0x7f76b403aac0)=
 QQmlContext(0x558dda81e8f0) QUrl("file:///usr/share/plasma/plasmoids/org.=
kde.plasma.notifications/contents/ui/global/Globals.qml")
>>                                  Nov 26 07:14:03 hogwarts plasmashell[3=
112]: Could not find the Plasmoid for Plasma::FrameSvgItem(0x7f76b403aac0)=
 QQmlContext(0x558dda81e8f0) QUrl("file:///usr/share/plasma/plasmoids/org.=
kde.plasma.notifications/contents/ui/global/Globals.qml")
>>                                  Nov 26 07:14:03 hogwarts kernel: BTRFS=
 error (device dm-1): parent transid verify failed on logical 31850496 mir=
ror 2 wanted 123883 found 123907
>>                                  Nov 26 07:14:03 hogwarts kernel: BTRFS=
 error (device dm-1): failed to run delayed ref for logical 916815872 num_=
bytes 16384 type 176 action 1 ref_mod 1: -5
>>                                  Nov 26 07:14:03 hogwarts kernel: BTRFS=
 error (device dm-1: state A): Transaction aborted (error -5)
>>                                  Nov 26 07:14:03 hogwarts kernel: BTRFS=
: error (device dm-1: state A) in btrfs_run_delayed_refs:2182: errno=3D-5 =
IO failure
>> # Goes read-only.               Nov 26 07:14:03 hogwarts kernel: BTRFS =
info (device dm-1: state EA): forced readonly
>>                                  Nov 26 07:14:03 hogwarts plasmashell[2=
01509]: BuildCompleteAppOverviewChange: 285 apps
>>                                  Nov 26 07:14:03 hogwarts plasmashell[2=
01509]: RegisterForAppOverview 1: 15ms
>>                                  Nov 26 07:14:03 hogwarts plasmashell[2=
01509]: RegisterForAppOverview 2: 15ms
>>                                  Nov 26 07:14:22 hogwarts plasmashell[3=
112]: file:///usr/share/plasma/plasmoids/org.kde.plasma.notifications/cont=
ents/ui/NotificationItem.qml:256:9: QML QQuickItem: Binding loop detected =
for property "height"
>>                                  Nov 26 07:14:22 hogwarts plasmashell[3=
112]: file:///usr/share/plasma/plasmoids/org.kde.plasma.notifications/cont=
ents/ui/NotificationItem.qml:256:9: QML QQuickItem: Binding loop detected =
for property "height"
>>                                  Nov 26 07:15:25 hogwarts NetworkManage=
r[2069]: <info>  [1701004525.2209] dhcp4 (enp0s25): state changed new leas=
e, address=3D192.168.94.10
>>                                  Nov 26 07:15:25 hogwarts systemd[1]: S=
tarting NetworkManager-dispatcher.service - Network Manager Script Dispatc=
her Service...
>>                                  Nov 26 07:15:25 hogwarts systemd[1]: S=
tarted NetworkManager-dispatcher.service - Network Manager Script Dispatch=
er Service.
>>                                  Nov 26 07:15:27 hogwarts jellyfin[2280=
]: [07:15:27] [INF] [85] Jellyfin.Networking.Manager.NetworkManager: Defin=
ed LAN addresses : [10.0.0.0/8,172.16.0.0/12,192.168.0.0/16]
>>                                  Nov 26 07:15:27 hogwarts jellyfin[2280=
]: [07:15:27] [INF] [85] Jellyfin.Networking.Manager.NetworkManager: Defin=
ed LAN exclusions : []
>>                                  Nov 26 07:15:27 hogwarts jellyfin[2280=
]: [07:15:27] [INF] [85] Jellyfin.Networking.Manager.NetworkManager: Using=
 LAN addresses: [10.0.0.0/8,172.16.0.0/12,192.168.0.0/16]
>>                                  Nov 26 07:15:35 hogwarts systemd[1]: N=
etworkManager-dispatcher.service: Deactivated successfully.
>>                                  Nov 26 07:17:35 hogwarts cupsd[2133]: =
REQUEST localhost - - "POST / HTTP/1.1" 200 185 Renew-Subscription success=
ful-ok
>>                                  Nov 26 07:20:16 hogwarts systemd[1]: S=
tarting sysstat-collect.service - system activity accounting tool...
>>                                  Nov 26 07:20:16 hogwarts systemd[1]: s=
ysstat-collect.service: Deactivated successfully.
>>                                  Nov 26 07:20:16 hogwarts systemd[1]: F=
inished sysstat-collect.service - system activity accounting tool.
>>                                  Nov 26 07:25:33 hogwarts systemd[2626]=
: Started run-r95b9b8d1554342d2922acba57a0a2b60.scope - /usr/bin/fish.
>>                                  Nov 26 07:28:26 hogwarts kwin_wayland[=
2959]: kf.service.services: The desktop entry file "/usr/share/application=
s/org.freedesktop.Xwayland.desktop" has Type=3D "Application" but has no E=
xec field.
>>                                  Nov 26 07:28:26 hogwarts kwin_wayland[=
2959]: kf.service.services: The desktop entry file "/usr/share/application=
s/qemu.desktop" has Type=3D "Application" but has no Exec field.
>>                                  Nov 26 07:30:16 hogwarts systemd[1]: S=
tarting sysstat-collect.service - system activity accounting tool...
>>                                  Nov 26 07:30:16 hogwarts systemd[1]: s=
ysstat-collect.service: Deactivated successfully.
>>                                  Nov 26 07:30:16 hogwarts systemd[1]: F=
inished sysstat-collect.service - system activity accounting tool.
>>                                  Nov 26 07:30:17 hogwarts plasmashell[3=
112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(=
0x558ddef735f0, parent=3D0x558dddabb090, geometry=3D0,0 226x105)
>>                                  Nov 26 07:30:17 hogwarts pipewire[2957=
]: mod.client-node: 0x55807c733170: unknown peer 0x55807cb82f50 fd:90
>>                                  Nov 26 07:30:17 hogwarts plasmashell[3=
112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(=
0x558ddd0f7420, parent=3D0x558ddc1abed0, geometry=3D0,0 226x105)
>>                                  Nov 26 07:30:17 hogwarts plasmashell[3=
112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(=
0x558ddd0f7420, parent=3D0x558ddc1abed0, geometry=3D0,0 226x105)
>>                                  Nov 26 07:30:17 hogwarts plasmashell[3=
112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(=
0x558ddd0f7420, parent=3D0x558ddc1abed0, geometry=3D0,0 226x105)
>>                                  Nov 26 07:30:17 hogwarts plasmashell[3=
112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(=
0x558ddd0f7420, parent=3D0x558ddc1abed0, geometry=3D0,0 226x105)
>>                                  Nov 26 07:30:34 hogwarts pipewire[2957=
]: mod.client-node: 0x55807c73e700: unknown peer 0x55807c5892e0 fd:58
>>                                  Nov 26 07:30:34 hogwarts plasmashell[3=
112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(=
0x558ddd1c3de0, parent=3D0x558ddb4bdcf0, geometry=3D0,0 226x105)
>>                                  Nov 26 07:30:44 hogwarts kwin_wayland[=
2959]: This plugin does not support raise()
>>                                  Nov 26 07:35:32 hogwarts plasmashell[3=
112]: Could not find the Plasmoid for Plasma::FrameSvgItem(0x558dde240460)=
 QQmlContext(0x558dda81e8f0) QUrl("file:///usr/share/plasma/plasmoids/org.=
kde.plasma.notifications/contents/ui/global/Globals.qml")
>>                                  Nov 26 07:35:32 hogwarts plasmashell[3=
112]: Could not find the Plasmoid for Plasma::FrameSvgItem(0x558dde240460)=
 QQmlContext(0x558dda81e8f0) QUrl("file:///usr/share/plasma/plasmoids/org.=
kde.plasma.notifications/contents/ui/global/Globals.qml")
>>                                  Nov 26 07:36:28 hogwarts kwin_wayland[=
2959]: kf.service.services: The desktop entry file "/usr/share/application=
s/org.freedesktop.Xwayland.desktop" has Type=3D "Application" but has no E=
xec field.
>>                                  Nov 26 07:36:28 hogwarts kwin_wayland[=
2959]: kf.service.services: The desktop entry file "/usr/share/application=
s/qemu.desktop" has Type=3D "Application" but has no Exec field.
>>                                  Nov 26 07:36:28 hogwarts kstart5[20513=
9]: Omitting both --window and --windowclass arguments is not recommended
>>                                  Nov 26 07:36:28 hogwarts systemd[2626]=
: Started app-konsole-99f85861097e4dd5a8484ba52cf1a120.scope - konsole.
>>                                  Nov 26 07:36:28 hogwarts kwin_wayland[=
2959]: kf.service.services: The desktop entry file "/usr/share/application=
s/org.freedesktop.Xwayland.desktop" has Type=3D "Application" but has no E=
xec field.
>>                                  Nov 26 07:36:28 hogwarts kwin_wayland[=
2959]: kf.service.services: The desktop entry file "/usr/share/application=
s/qemu.desktop" has Type=3D "Application" but has no Exec field.
>>                                  Nov 26 07:36:28 hogwarts kded5[3090]: =
org.kde.plasma.appmenu: Got an error
>>                                  Nov 26 07:36:28 hogwarts kded5[3090]: =
org.kde.plasma.appmenu: Got an error
>>                                  Nov 26 07:36:29 hogwarts systemd[2626]=
: Started run-r5601954a28844b309ba7ae35844778d6.scope - /usr/bin/fish.
>>                                  Nov 26 07:36:36 hogwarts kernel: [drm]=
 PCIE GART of 256M enabled (table at 0x000000F400000000).
>>                                  Nov 26 07:36:37 hogwarts kernel: [drm]=
 UVD and UVD ENC initialized successfully.
>>                                  Nov 26 07:36:37 hogwarts kernel: [drm]=
 VCE initialized successfully.
>>                                  Nov 26 07:36:37 hogwarts kernel: amdgp=
u 0000:01:00.0: [drm] Cannot find any crtc or sizes
>>                                  Nov 26 07:36:52 hogwarts python3[1899]=
: INFO [fancontrol_ng.py:amdgpu_power_gen:276] State.WARM GPU turned OFF
>>                                  Nov 26 07:40:16 hogwarts systemd[1]: S=
tarting sysstat-collect.service - system activity accounting tool...
>>                                  Nov 26 07:40:16 hogwarts systemd[1]: s=
ysstat-collect.service: Deactivated successfully.
>>                                  Nov 26 07:40:16 hogwarts systemd[1]: F=
inished sysstat-collect.service - system activity accounting tool.
>>                                  Nov 26 07:46:18 hogwarts systemd[1]: S=
tarting dnf-makecache.service - dnf makecache...
>>                                  Nov 26 07:46:18 hogwarts dnf[206741]: =
Metadata cache refreshed recently.
>>                                  Nov 26 07:46:19 hogwarts systemd[1]: d=
nf-makecache.service: Deactivated successfully.
>>                                  Nov 26 07:46:19 hogwarts systemd[1]: F=
inished dnf-makecache.service - dnf makecache.
>>                                  Nov 26 07:50:16 hogwarts systemd[1]: S=
tarting sysstat-collect.service - system activity accounting tool...
>>                                  Nov 26 07:50:16 hogwarts systemd[1]: s=
ysstat-collect.service: Deactivated successfully.
>>                                  Nov 26 07:50:17 hogwarts systemd[1]: F=
inished sysstat-collect.service - system activity accounting tool.
>>                                  Nov 26 08:00:16 hogwarts systemd[1]: S=
tarting sysstat-collect.service - system activity accounting tool...
>>                                  Nov 26 08:00:16 hogwarts systemd[1]: s=
ysstat-collect.service: Deactivated successfully.
>>                                  Nov 26 08:00:16 hogwarts systemd[1]: F=
inished sysstat-collect.service - system activity accounting tool.
>>                                  Nov 26 08:00:57 hogwarts systemd[2626]=
: Started run-r5341136056a24fa79656d83c089e028e.scope - /usr/bin/fish.
>>                                  Nov 26 08:00:59 hogwarts kernel: [drm]=
 PCIE GART of 256M enabled (table at 0x000000F400000000).
>>                                  Nov 26 08:00:59 hogwarts kernel: [drm]=
 UVD and UVD ENC initialized successfully.
>>                                  Nov 26 08:00:59 hogwarts kernel: [drm]=
 VCE initialized successfully.
>>                                  Nov 26 08:00:59 hogwarts kernel: amdgp=
u 0000:01:00.0: [drm] Cannot find any crtc or sizes
>>                                  Nov 26 08:01:01 hogwarts CROND[208772]=
: (root) CMD (run-parts /etc/cron.hourly)
>>                                  Nov 26 08:01:01 hogwarts run-parts[208=
775]: (/etc/cron.hourly) starting 0anacron
>>                                  Nov 26 08:01:01 hogwarts run-parts[208=
781]: (/etc/cron.hourly) finished 0anacron
>>                                  Nov 26 08:01:01 hogwarts CROND[208771]=
: (root) CMDEND (run-parts /etc/cron.hourly)
>>                                  Nov 26 08:01:30 hogwarts python3[1899]=
: INFO [fancontrol_ng.py:amdgpu_power_gen:276] State.WARM GPU turned OFF
>>                                  Nov 26 08:02:01 hogwarts systemd[2626]=
: Started run-r8b14da3ce30c4eb29b6a5c9275766925.scope - /usr/bin/fish.
>>                                  Nov 26 08:02:05 hogwarts systemd[1]: S=
tarting fprintd.service - Fingerprint Authentication Daemon...
>>                                  Nov 26 08:02:05 hogwarts systemd[1]: S=
tarted fprintd.service - Fingerprint Authentication Daemon.
>> # Unrelated curiousity. I       Nov 26 08:02:07 hogwarts sudo[209070]: =
  rhaley : TTY=3Dpts/19 ; PWD=3D/home/rhaley ; USER=3Droot ; COMMAND=3D/us=
r/bin/intel_gpu_top
>>    hadn't noticed the problem    Nov 26 08:02:07 hogwarts sudo[209070]:=
 pam_unix(sudo:session): session opened for user root(uid=3D0) by rhaley(u=
id=3D1000)
>>    yet.                          Nov 26 08:02:07 hogwarts kernel: [drm]=
 PCIE GART of 256M enabled (table at 0x000000F400000000).
>>                                  Nov 26 08:02:07 hogwarts kernel: [drm]=
 UVD and UVD ENC initialized successfully.
>>                                  Nov 26 08:02:08 hogwarts kernel: [drm]=
 VCE initialized successfully.
>>                                  Nov 26 08:02:08 hogwarts kernel: amdgp=
u 0000:01:00.0: [drm] Cannot find any crtc or sizes
>>                                  Nov 26 08:02:11 hogwarts sudo[209070]:=
 pam_unix(sudo:session): session closed for user root
>> *snip* 57 minutes, 418 lines of mostly plasmashell logspam
>> # This pair of messages is      Nov 26 08:59:48 hogwarts kernel: BTRFS =
error (device dm-1: state EA): level verify failed on logical 875102208 mi=
rror 1 wanted 2 found 0
>>    spammed up to the journal     Nov 26 08:59:48 hogwarts kernel: BTRFS=
 error (device dm-1: state EA): level verify failed on logical 875102208 m=
irror 2 wanted 2 found 0
>>    rate limit, ~76,000 times,    Nov 26 08:59:48 hogwarts kernel: BTRFS=
 error (device dm-1: state EA): level verify failed on logical 875102208 m=
irror 1 wanted 2 found 0
>>    until reboot.                 Nov 26 08:59:48 hogwarts kernel: BTRFS=
 error (device dm-1: state EA): level verify failed on logical 875102208 m=
irror 2 wanted 2 found 0
>>
>> # I notice the problem and check SMART (finding nothing unusual) at 11:=
48:01
>> # reboot happens at 11:53:02
>
>

