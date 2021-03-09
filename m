Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728893327BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 14:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhCINt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 08:49:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:24466 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231899AbhCINtp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Mar 2021 08:49:45 -0500
IronPort-SDR: mIx33Ur7C+N3OCnWd4x6ZZJQ3YfPyQIEL5C44lfMLCr6BO1jyrmccw5r8tGg+9H67c2IsDV/ub
 q9hc/n2nu/dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="184875981"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="xz'?yaml'?scan'208";a="184875981"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 05:49:43 -0800
IronPort-SDR: duOjeIap42cpJiSnzczDJA081O2Q5GdxV6bRYkdNcJWPjVz66so9hK8UWrJDe8S6Kom8os9xxr
 T8380GAK/e4A==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="xz'?yaml'?scan'208";a="403236522"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 05:49:37 -0800
Date:   Tue, 9 Mar 2021 22:04:54 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     0day robot <lkp@intel.com>, TOTE Robot <oslab@tsinghua.edu.cn>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ltp@lists.linux.it, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [fs]  3c6be3a73b: ltp.fsopen01.fail
Message-ID: <20210309140454.GB17567@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20210305094353.13511-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 3c6be3a73b969746256d2ad3573b1ee72e8454ee ("[PATCH] fs: btrfs: fix e=
rror return code of btrfs_recover_relocation()")
url: https://github.com/0day-ci/linux/commits/Jia-Ju-Bai/fs-btrfs-fix-error=
-return-code-of-btrfs_recover_relocation/20210307-120011
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20210101
with following parameters:

	disk: 1HDD
	fs: xfs
	test: syscalls-07
	ucode: 0xe2

test-description: The LTP testsuite contains a collection of tools for test=
ing the Linux kernel and related features.
test-url: http://linux-test-project.github.io/


on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G=
 memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

2021-03-09 01:36:29 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-03-09 01:36:29 ./runltp -f syscalls-07 -d /fs/sda1/tmpdir
INFO: creating /lkp/benchmarks/ltp/output directory
INFO: creating /lkp/benchmarks/ltp/results directory
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

/etc/os-release
PRETTY_NAME=3D"Debian GNU/Linux 10 (buster)"
NAME=3D"Debian GNU/Linux"
VERSION_ID=3D"10"
VERSION=3D"10 (buster)"
VERSION_CODENAME=3Dbuster
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"

uname:
Linux lkp-skl-d02 5.12.0-rc1-g3c6be3a73b96 #1 SMP Mon Mar 8 10:47:45 CST 20=
21 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-07-ucode=3D0xe2-debian-10.4-x86_64-=
20200603.cgz-3c6be3a73b969746256d2ad3573b1ee72e8454ee-20210309-23969-1t26ah=
3-1.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinux-review/Jia-=
Ju-Bai/fs-btrfs-fix-error-return-code-of-btrfs_recover_relocation/20210307-=
120011 commit=3D3c6be3a73b969746256d2ad3573b1ee72e8454ee BOOT_IMAGE=3D/pkg/=
linux/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/vmlinu=
z-5.12.0-rc1-g3c6be3a73b96 max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1HDD=
-xfs-syscalls-07-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/3 LKP_SERVER=
=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_=
enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=
=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic loa=
d_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3De=
rr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS=
0,115200 vga=3Dnormal rw

Gnu C                  gcc (Debian 8.3.0-6) 8.3.0
Clang                =20
Gnu make               4.2.1
util-linux             2.33.1
mount                  linux 2.33.1 (libmount 2.33.1: selinux, smack, btrfs=
, namespaces, assert, debug)
modutils               26
e2fsprogs              1.44.5
Linux C Library        > libc.2.28
Dynamic linker (ldd)   2.28
Procps                 3.3.15
Net-tools              2.10-alpha
iproute2               iproute2-ss190107
iputils                iputils-s20180629
ethtool                4.19
Kbd                    119:
Sh-utils               8.30
Modules Loaded         dm_mod xfs libcrc32c ipmi_devintf ipmi_msghandler sd=
_mod t10_pi sg mei_wdt intel_rapl_msr intel_rapl_common x86_pkg_temp_therma=
l intel_powerclamp coretemp i915 kvm_intel intel_gtt drm_kms_helper syscopy=
area kvm sysfillrect irqbypass sysimgblt crct10dif_pclmul crc32_pclmul crc3=
2c_intel ghash_clmulni_intel fb_sys_fops mei_me rapl wmi_bmof intel_cstate =
ahci drm libahci mei intel_uncore intel_pch_thermal libata wmi video intel_=
pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32754220      306120    29958112       21780     2489988    2972=
2784
Swap:             0           0           0

cpuinfo:
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
Address sizes:       39 bits physical, 48 bits virtual
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               94
Model name:          Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
Stepping:            3
CPU MHz:             3200.000
CPU max MHz:         3600.0000
CPU min MHz:         800.0000
BogoMIPS:            6399.96
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            6144K
NUMA node0 CPU(s):   0-3
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m=
ca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vm=
x smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe=
 popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefe=
tch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi=
 flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 e=
rms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xge=
tbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp m=
d_clear flush_l1d

AppArmor enabled

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2534     -n 2534 -=
p -f /fs/sda1/tmpdir/ltp-rUT0eB0OZ3/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_03_09-01h_36m_29s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_03_09-01h_36m_29s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_03_09-01h_36m_29s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_03_09-01h_36m_29s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_03_09-01h_3=
6m_29s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_03_09-01h_36=
m_29s.tconf
Running tests.......
<<<test_start>>>
tag=3Dabort01 stime=3D1615253789
cmdline=3D"abort01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
abort01.c:61: TPASS: abort() dumped core
abort01.c:64: TPASS: abort() raised SIGIOT

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Daccess02 stime=3D1615253789
cmdline=3D"access02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
access02.c:63: TPASS: access(file_f, F_OK) as root passed
access02.c:142: TPASS: access(file_f, F_OK) as root behaviour is correct.
access02.c:63: TPASS: access(file_f, F_OK) as nobody passed
access02.c:142: TPASS: access(file_f, F_OK) as nobody behaviour is correct.
access02.c:63: TPASS: access(file_r, R_OK) as root passed
access02.c:142: TPASS: access(file_r, R_OK) as root behaviour is correct.
access02.c:63: TPASS: access(file_r, R_OK) as nobody passed
access02.c:142: TPASS: access(file_r, R_OK) as nobody behaviour is correct.
access02.c:63: TPASS: access(file_w, W_OK) as root passed
access02.c:142: TPASS: access(file_w, W_OK) as root behaviour is correct.
access02.c:63: TPASS: access(file_w, W_OK) as nobody passed
access02.c:142: TPASS: access(file_w, W_OK) as nobody behaviour is correct.
access02.c:63: TPASS: access(file_x, X_OK) as root passed
access02.c:142: TPASS: access(file_x, X_OK) as root behaviour is correct.
access02.c:63: TPASS: access(file_x, X_OK) as nobody passed
access02.c:142: TPASS: access(file_x, X_OK) as nobody behaviour is correct.
access02.c:63: TPASS: access(symlink_f, F_OK) as root passed
access02.c:142: TPASS: access(symlink_f, F_OK) as root behaviour is correct.
access02.c:63: TPASS: access(symlink_f, F_OK) as nobody passed
access02.c:142: TPASS: access(symlink_f, F_OK) as nobody behaviour is corre=
ct.
access02.c:63: TPASS: access(symlink_r, R_OK) as root passed
access02.c:142: TPASS: access(symlink_r, R_OK) as root behaviour is correct.
access02.c:63: TPASS: access(symlink_r, R_OK) as nobody passed
access02.c:142: TPASS: access(symlink_r, R_OK) as nobody behaviour is corre=
ct.
access02.c:63: TPASS: access(symlink_w, W_OK) as root passed
access02.c:142: TPASS: access(symlink_w, W_OK) as root behaviour is correct.
access02.c:63: TPASS: access(symlink_w, W_OK) as nobody passed
access02.c:142: TPASS: access(symlink_w, W_OK) as nobody behaviour is corre=
ct.
access02.c:63: TPASS: access(symlink_x, X_OK) as root passed
access02.c:142: TPASS: access(symlink_x, X_OK) as root behaviour is correct.
access02.c:63: TPASS: access(symlink_x, X_OK) as nobody passed
access02.c:142: TPASS: access(symlink_x, X_OK) as nobody behaviour is corre=
ct.

Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dalarm02 stime=3D1615253789
cmdline=3D"alarm02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
alarm02.c:62: TPASS: alarm(2147483647) returned 2147483647 as expected for =
value INT_MAX
alarm02.c:62: TPASS: alarm(2147483647) returned 2147483647 as expected for =
value UINT_MAX/2
alarm02.c:62: TPASS: alarm(1073741823) returned 1073741823 as expected for =
value UINT_MAX/4

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dbind01 stime=3D1615253789
cmdline=3D"bind01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
bind01.c:52: TPASS: invalid salen: EINVAL (22)
bind01.c:52: TPASS: invalid socket: ENOTSOCK (88)
bind01.c:55: TPASS: INADDR_ANYPORT passed
bind01.c:52: TPASS: UNIX-domain of current directory: EAFNOSUPPORT (97)
bind01.c:52: TPASS: non-local address: EADDRNOTAVAIL (99)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dbrk01 stime=3D1615253789
cmdline=3D"brk01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed

Summary:
passed   33
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchmod01 stime=3D1615253789
cmdline=3D"chmod01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chmod01     1  TPASS  :  Functionality of chmod(testfile, 0) successful
chmod01     2  TPASS  :  Functionality of chmod(testfile, 07) successful
chmod01     3  TPASS  :  Functionality of chmod(testfile, 070) successful
chmod01     4  TPASS  :  Functionality of chmod(testfile, 0700) successful
chmod01     5  TPASS  :  Functionality of chmod(testfile, 0777) successful
chmod01     6  TPASS  :  Functionality of chmod(testfile, 02777) successful
chmod01     7  TPASS  :  Functionality of chmod(testfile, 04777) successful
chmod01     8  TPASS  :  Functionality of chmod(testfile, 06777) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchmod07 stime=3D1615253789
cmdline=3D"chmod07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
chmod07.c:59: TPASS: Functionality of chmod(testfile, 01777) successful

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchown01 stime=3D1615253789
cmdline=3D"chown01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chown01     1  TPASS  :  chown(t_2687, 0,0) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchown04_16 stime=3D1615253790
cmdline=3D"chown04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
chown04_16    0  TINFO  :  Found free device 0 '/dev/loop0'
chown04_16    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra =
opts=3D''
chown04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/c=
hown/../utils/compat_16.h:166: 16-bit version of chown() is not supported o=
n your platform
chown04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/c=
hown/../utils/compat_16.h:166: Remaining cases not appropriate for configur=
ation
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dchroot02 stime=3D1615253790
cmdline=3D"chroot02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chroot02    1  TPASS  :  chroot functionality correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_adjtime01 stime=3D1615253790
cmdline=3D"clock_adjtime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
clock_adjtime01.c:191: TINFO: Testing variant: syscall with old kernel spec
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342067(us)
clock_adjtime.h:160: TINFO: SET
             mode: 32769
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342071(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342073(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D8001)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342091(us)
clock_adjtime.h:160: TINFO: SET
             mode: 40961
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342094(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342111(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3Da001)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342115(us)
clock_adjtime.h:160: TINFO: SET
             mode: 16447
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342117(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342120(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D403f)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342124(us)
clock_adjtime.h:160: TINFO: SET
             mode: 1
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342127(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342129(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D1)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342133(us)
clock_adjtime.h:160: TINFO: SET
             mode: 2
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342149(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342152(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D2)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342156(us)
clock_adjtime.h:160: TINFO: SET
             mode: 4
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342158(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342161(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D4)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342165(us)
clock_adjtime.h:160: TINFO: SET
             mode: 8
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342167(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342170(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D8)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342174(us)
clock_adjtime.h:160: TINFO: SET
             mode: 32
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342176(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342179(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D20)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342183(us)
clock_adjtime.h:160: TINFO: SET
             mode: 16384
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 11000
         raw time: 1615253790(s) 342185(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 11000
         raw time: 1615253790(s) 342188(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D4000)

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclose01 stime=3D1615253790
cmdline=3D"close01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
close01     1  TPASS  :  file appears closed
close01     2  TPASS  :  pipe appears closed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dconfstr01 stime=3D1615253790
cmdline=3D"confstr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
confstr01    1  TPASS  :  confstr PATH =3D '/bin:/usr/bin'
confstr01    2  TPASS  :  confstr XBS5_ILP32_OFF32_CFLAGS =3D ''
confstr01    3  TPASS  :  confstr XBS5_ILP32_OFF32_LDFLAGS =3D ''
confstr01    4  TPASS  :  confstr XBS5_ILP32_OFF32_LIBS =3D ''
confstr01    5  TPASS  :  confstr XBS5_ILP32_OFF32_LINTFLAGS =3D ''
confstr01    6  TPASS  :  confstr XBS5_ILP32_OFFBIG_CFLAGS =3D ''
confstr01    7  TPASS  :  confstr XBS5_ILP32_OFFBIG_LDFLAGS =3D ''
confstr01    8  TPASS  :  confstr XBS5_ILP32_OFFBIG_LIBS =3D ''
confstr01    9  TPASS  :  confstr XBS5_ILP32_OFFBIG_LINTFLAGS =3D ''
confstr01   10  TPASS  :  confstr XBS5_LP64_OFF64_CFLAGS =3D '-m64'
confstr01   11  TPASS  :  confstr XBS5_LP64_OFF64_LDFLAGS =3D '-m64'
confstr01   12  TPASS  :  confstr XBS5_LP64_OFF64_LIBS =3D ''
confstr01   13  TPASS  :  confstr XBS5_LP64_OFF64_LINTFLAGS =3D ''
confstr01   14  TPASS  :  confstr XBS5_LPBIG_OFFBIG_CFLAGS =3D ''
confstr01   15  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LDFLAGS =3D ''
confstr01   16  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LIBS =3D ''
confstr01   17  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LINTFLAGS =3D ''
confstr01   18  TPASS  :  confstr GNU_LIBC_VERSION =3D 'glibc 2.28'
confstr01   19  TPASS  :  confstr GNU_LIBPTHREAD_VERSION =3D 'NPTL 2.28'
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dcreat06 stime=3D1615253790
cmdline=3D"creat06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
creat06.c:105: TPASS: got expected failure: EISDIR (21)
creat06.c:105: TPASS: got expected failure: ENAMETOOLONG (36)
creat06.c:105: TPASS: got expected failure: ENOENT (2)
creat06.c:105: TPASS: got expected failure: ENOTDIR (20)
creat06.c:105: TPASS: got expected failure: EFAULT (14)
creat06.c:105: TPASS: got expected failure: EACCES (13)
creat06.c:105: TPASS: got expected failure: ELOOP (40)
creat06.c:105: TPASS: got expected failure: EROFS (30)

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Depoll_create1_01 stime=3D1615253790
cmdline=3D"epoll_create1_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
epoll_create1_01.c:46: TPASS: epoll_create1(EPOLL_CLOEXEC) PASSED

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Deventfd2_01 stime=3D1615253790
cmdline=3D"eventfd2_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
eventfd2_01    1  TPASS  :  eventfd2(EFD_CLOEXEC) Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Deventfd2_02 stime=3D1615253790
cmdline=3D"eventfd2_02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
eventfd2_02    1  TPASS  :  eventfd2(EFD_NONBLOCK) PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dexecveat01 stime=3D1615253790
cmdline=3D"execveat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexit01 stime=3D1615253790
cmdline=3D"exit01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
exit01      1  TPASS  :  exit() test PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfsetxattr01 stime=3D1615253790
cmdline=3D"fsetxattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: TINFO: Kernel supports ext2
tst_supported_fs_types.c:44: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext3
tst_supported_fs_types.c:44: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext4
tst_supported_fs_types.c:44: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports xfs
tst_supported_fs_types.c:44: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:44: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports vfat
tst_supported_fs_types.c:44: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:83: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:92: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:44: TINFO: mkfs.ntfs does exist
tst_test.c:1329: TINFO: Testing on ext2
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1329: TINFO: Testing on ext3
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1329: TINFO: Testing on ext4
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1329: TINFO: Testing on xfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1329: TINFO: Testing on btrfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:870: TBROK: mount(/dev/loop0, mntpoint, btrfs, 0, (nil)) failed:=
 ENOENT (2)

Summary:
passed   36
failed   0
broken   1
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D2 corefile=3Dno
cutime=3D5 cstime=3D20
<<<test_end>>>
<<<test_start>>>
tag=3Dfsetxattr02 stime=3D1615253792
cmdline=3D"fsetxattr02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsetxattr02.c:170: TPASS: fsetxattr(2) on testfile passed
fsetxattr02.c:170: TPASS: fsetxattr(2) on testdir passed
fsetxattr02.c:192: TPASS: fsetxattr(2) on symlink failed: EEXIST (17)
fsetxattr02.c:192: TPASS: fsetxattr(2) on fifo failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on chr failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on blk failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on sock failed: EPERM (1)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dposix_fadvise02 stime=3D1615253792
cmdline=3D"posix_fadvise02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfchmod04 stime=3D1615253792
cmdline=3D"fchmod04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fchmod04    1  TPASS  :  Functionality of fchmod(4, 01777) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfchown04 stime=3D1615253792
cmdline=3D"fchown04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
fchown04    0  TINFO  :  Found free device 0 '/dev/loop0'
fchown04    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
fchown04    1  TPASS  :  fchown failed as expected: TEST_ERRNO=3DEPERM(1): =
Operation not permitted
fchown04    2  TPASS  :  fchown failed as expected: TEST_ERRNO=3DEBADF(9): =
Bad file descriptor
fchown04    3  TPASS  :  fchown failed as expected: TEST_ERRNO=3DEROFS(30):=
 Read-only file system
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl01 stime=3D1615253792
cmdline=3D"fcntl01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl07 stime=3D1615253792
cmdline=3D"fcntl07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl07     1  TPASS  :  regular file CLOEXEC fd was closed after exec()
fcntl07     2  TPASS  :  pipe (write end) CLOEXEC fd was closed after exec()
fcntl07     3  TPASS  :  pipe (read end) CLOEXEC fd was closed after exec()
fcntl07     4  TPASS  :  fifo CLOEXEC fd was closed after exec()
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl07_64 stime=3D1615253792
cmdline=3D"fcntl07_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl07     1  TPASS  :  regular file CLOEXEC fd was closed after exec()
fcntl07     2  TPASS  :  pipe (write end) CLOEXEC fd was closed after exec()
fcntl07     3  TPASS  :  pipe (read end) CLOEXEC fd was closed after exec()
fcntl07     4  TPASS  :  fifo CLOEXEC fd was closed after exec()
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl10 stime=3D1615253792
cmdline=3D"fcntl10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl10     1  TPASS  :  fcntl(tfile_2829, F_SETLKW, &flocks) flocks.l_type=
 =3D F_WRLCK returned 0
fcntl10     2  TPASS  :  fcntl(tfile_2829, F_SETLKW, &flocks) flocks.l_type=
 =3D F_UNLCK returned 0
fcntl10     1  TPASS  :  fcntl(tfile_2829, F_SETLKW, &flocks) flocks.l_type=
 =3D F_RDLCK returned 0
fcntl10     2  TPASS  :  fcntl(tfile_2829, F_SETLKW, &flocks) flocks.l_type=
 =3D F_UNLCK returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl13_64 stime=3D1615253792
cmdline=3D"fcntl13_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl13     1  TPASS  :  got EINVAL
fcntl13     2  TPASS  :  F_SETLK: got EFAULT
fcntl13     3  TPASS  :  F_SETLKW: got EFAULT
fcntl13     4  TPASS  :  F_GETLK: got EFAULT
fcntl13     5  TPASS  :  got EINVAL
fcntl13     6  TPASS  :  got EBADFD
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl16 stime=3D1615253792
cmdline=3D"fcntl16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl16     0  TINFO  :  Entering block 1
fcntl16     0  TINFO  :  Test case 1: without manadatory locking PASSED
fcntl16     0  TINFO  :  Exiting block 1
fcntl16     0  TINFO  :  Entering block 2
fcntl16     0  TINFO  :  Test case 2: with mandatory record locking PASSED
fcntl16     0  TINFO  :  Exiting block 2
fcntl16     0  TINFO  :  Entering block 3
fcntl16     0  TINFO  :  Test case 3: mandatory locking with NODELAY PASSED
fcntl16     0  TINFO  :  Exiting block 3
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl23 stime=3D1615253792
cmdline=3D"fcntl23"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl23     1  TPASS  :  fcntl(tfile_2832, F_SETLEASE, F_RDLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl24_64 stime=3D1615253792
cmdline=3D"fcntl24_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl24     1  TPASS  :  fcntl(tfile_2833, F_SETLEASE, F_WRLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl25 stime=3D1615253792
cmdline=3D"fcntl25"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl25     1  TPASS  :  fcntl(tfile_2834, F_SETLEASE, F_WRLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl29 stime=3D1615253792
cmdline=3D"fcntl29"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl29     1  TPASS  :  fcntl test F_DUPFD_CLOEXEC success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl30_64 stime=3D1615253792
cmdline=3D"fcntl30_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl30     0  TINFO  :  orig_pipe_size: 65536 new_pipe_size: 131072
fcntl30     1  TPASS  :  fcntl test F_GETPIPE_SZand F_SETPIPE_SZ success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl32 stime=3D1615253793
cmdline=3D"fcntl32"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl32     1  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     2  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     3  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     4  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     5  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     6  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     7  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     8  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     9  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl34 stime=3D1615253793
cmdline=3D"fcntl34"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fcntl34.c:90: TINFO: write to a file inside threads with OFD locks
fcntl34.c:36: TINFO: spawning '12' threads
fcntl34.c:45: TINFO: waiting for '12' threads
fcntl34.c:99: TINFO: verifying file's data
fcntl34.c:127: TPASS: OFD locks synchronized access between threads

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl38 stime=3D1615253793
cmdline=3D"fcntl38"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fcntl38.c:67: TPASS: Got event on parent as expected
fcntl38.c:71: TPASS: Got event on subdir as expected

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl38_64 stime=3D1615253793
cmdline=3D"fcntl38_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fcntl38.c:67: TPASS: Got event on parent as expected
fcntl38.c:71: TPASS: Got event on subdir as expected

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfremovexattr01 stime=3D1615253793
cmdline=3D"fremovexattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: TINFO: Kernel supports ext2
tst_supported_fs_types.c:44: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext3
tst_supported_fs_types.c:44: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext4
tst_supported_fs_types.c:44: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports xfs
tst_supported_fs_types.c:44: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:44: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports vfat
tst_supported_fs_types.c:44: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:83: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:92: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:44: TINFO: mkfs.ntfs does exist
tst_test.c:1329: TINFO: Testing on ext2
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1329: TINFO: Testing on ext3
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1329: TINFO: Testing on ext4
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1329: TINFO: Testing on xfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1329: TINFO: Testing on btrfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:870: TBROK: mount(/dev/loop0, mntpoint, btrfs, 0, (nil)) failed:=
 ENOENT (2)

Summary:
passed   4
failed   0
broken   1
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D2 corefile=3Dno
cutime=3D5 cstime=3D22
<<<test_end>>>
<<<test_start>>>
tag=3Dfsopen01 stime=3D1615253794
cmdline=3D"fsopen01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: TINFO: Kernel supports ext2
tst_supported_fs_types.c:44: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext3
tst_supported_fs_types.c:44: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext4
tst_supported_fs_types.c:44: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports xfs
tst_supported_fs_types.c:44: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:44: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports vfat
tst_supported_fs_types.c:44: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:83: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:88: TINFO: Skipping FUSE as requested by the test
tst_test.c:1329: TINFO: Testing on ext2
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1329: TINFO: Testing on ext3
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1329: TINFO: Testing on ext4
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1329: TINFO: Testing on xfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1329: TINFO: Testing on btrfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:42: TFAIL: fsconfig(FSCONFIG_CMD_CREATE) failed: ENOENT (2)
fsopen01.c:42: TFAIL: fsconfig(FSCONFIG_CMD_CREATE) failed: ENOENT (2)
tst_test.c:1329: TINFO: Testing on vfat
tst_test.c:859: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed

Summary:
passed   10
failed   2
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D5 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3Dfstat03_64 stime=3D1615253796
cmdline=3D"fstat03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fstat03.c:49: TPASS: fstat() fails with expected error EBADF
fstat03.c:49: TPASS: fstat() fails with expected error EFAULT

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfstatfs02 stime=3D1615253796
cmdline=3D"fstatfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fstatfs02    1  TPASS  :  expected failure - errno =3D 9 : Bad file descrip=
tor
fstatfs02    2  TPASS  :  expected failure - errno =3D 14 : Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dftruncate03 stime=3D1615253796
cmdline=3D"ftruncate03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EBADF (9)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dftruncate04_64 stime=3D1615253796
cmdline=3D"ftruncate04_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ftruncate04.c:116: TINFO: Child locks file
ftruncate04.c:60: TPASS: ftruncate() offset before lock failed with EAGAIN
ftruncate04.c:60: TPASS: ftruncate() offset in lock failed with EAGAIN
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
ftruncate04.c:127: TINFO: Child unlocks file
ftruncate04.c:84: TPASS: ftruncate() offset in lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset before lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dgetcwd04 stime=3D1615253796
cmdline=3D"getcwd04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
getcwd04.c:60: TPASS: Bug is not reproduced!

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D329 cstime=3D658
<<<test_end>>>
<<<test_start>>>
tag=3Dgeteuid02_16 stime=3D1615253801
cmdline=3D"geteuid02_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
geteuid02_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: 16-bit version of geteuid() is not suppo=
rted on your platform
geteuid02_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: Remaining cases not appropriate for conf=
iguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetgid01_16 stime=3D1615253801
cmdline=3D"getgid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getgid01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getgid/../utils/compat_16.h:102: 16-bit version of getgid() is not supporte=
d on your platform
getgid01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getgid/../utils/compat_16.h:102: Remaining cases not appropriate for config=
uration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetgid03 stime=3D1615253801
cmdline=3D"getgid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getgid03    1  TPASS  :  values from getuid and getpwuid match
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetrandom03 stime=3D1615253801
cmdline=3D"getrandom03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
getrandom03.c:37: TPASS: getrandom returned 1
getrandom03.c:37: TPASS: getrandom returned 2
getrandom03.c:37: TPASS: getrandom returned 3
getrandom03.c:37: TPASS: getrandom returned 7
getrandom03.c:37: TPASS: getrandom returned 8
getrandom03.c:37: TPASS: getrandom returned 15
getrandom03.c:37: TPASS: getrandom returned 22
getrandom03.c:37: TPASS: getrandom returned 64
getrandom03.c:37: TPASS: getrandom returned 127

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresuid01 stime=3D1615253801
cmdline=3D"getresuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid01    1  TPASS  :  Functionality of getresuid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresuid02 stime=3D1615253801
cmdline=3D"getresuid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid02    1  TPASS  :  Functionality of getresuid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsid02 stime=3D1615253801
cmdline=3D"getsid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getsid02    1  TPASS  :  expected failure - errno =3D 3 - No such process
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetxattr05 stime=3D1615253801
cmdline=3D"getxattr05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl01_02 stime=3D1615253801
cmdline=3D"test_ioctl"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty0
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty0

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty1
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty1

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty10
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty10

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty11
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty11

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty12
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty12

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty13
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty13

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty14
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty14

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty15
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty15

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty16
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty16

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty17
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty17

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty18
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty18

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty19
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty19

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty2
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty2

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty20
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty20

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty21
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty21

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty22
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty22

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty23
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty23

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty24
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty24

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty25
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty25

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty26
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty26

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty27
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty27

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty28
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty28

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty29
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty29

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty3
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty3

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty30
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty30

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty31
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty31

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty32
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty32

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty33
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty33

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty34
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty34

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty35
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty35

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty36
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty36

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty37
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty37

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty38
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty38

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty39
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty39

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty4
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty4

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty40
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty40

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty41
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty41

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty42
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty42

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty43
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty43

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty44
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty44

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty45
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty45

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty46
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty46

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty47
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty47

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty48
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty48

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty49
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty49

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty5
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty5

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty50
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty50

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty51
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty51

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty52
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty52

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty53
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty53

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty54
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty54

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty55
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty55

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty56
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty56

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty57
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty57

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty58
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty58

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty59
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty59

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty6
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty6

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty60
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty60

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty61
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty61

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty62
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty62

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty63
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty63

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty7
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty7

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty8
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty8

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty9
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty9

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty0
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty0

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty1
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty1

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty10
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty10

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty11
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty11

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty12
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty12

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty13
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty13

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty14
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty14

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty15
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty15

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty16
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty16

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty17
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty17

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty18
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty18

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty19
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty19

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty2
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty2

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty20
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty20

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty21
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty21

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty22
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty22

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty23
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty23

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty24
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty24

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty25
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty25

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty26
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty26

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty27
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty27

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty28
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty28

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty29
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty29

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty3
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty3

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty30
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty30

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty31
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty31

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty32
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty32

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty33
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty33

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty34
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty34

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty35
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty35

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty36
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty36

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty37
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty37

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty38
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty38

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty39
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty39

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty4
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty4

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty40
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty40

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty41
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty41

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty42
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty42

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty43
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty43

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty44
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty44

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty45
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty45

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty46
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty46

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty47
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty47

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty48
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty48

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty49
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty49

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty5
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty5

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty50
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty50

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty51
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty51

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty52
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty52

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty53
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty53

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty54
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty54

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty55
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty55

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty56
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty56

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty57
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty57

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty58
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty58

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty59
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty59

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty6
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty6

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty60
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty60

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty61
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty61

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty62
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty62

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty63
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty63

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty7
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty7

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty8
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty8

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty9
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty9

<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D21 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl06 stime=3D1615253802
cmdline=3D"ioctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl06.c:26: TINFO: BLKRAGET original value 256
ioctl06.c:33: TPASS: BLKRASET 0 read back correctly
ioctl06.c:33: TPASS: BLKRASET 512 read back correctly
ioctl06.c:33: TPASS: BLKRASET 1024 read back correctly
ioctl06.c:33: TPASS: BLKRASET 1536 read back correctly
ioctl06.c:33: TPASS: BLKRASET 2048 read back correctly
ioctl06.c:33: TPASS: BLKRASET 2560 read back correctly
ioctl06.c:33: TPASS: BLKRASET 3072 read back correctly
ioctl06.c:33: TPASS: BLKRASET 3584 read back correctly
ioctl06.c:33: TPASS: BLKRASET 4096 read back correctly
ioctl06.c:38: TINFO: BLKRASET restoring original value 256

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_ns05 stime=3D1615253802
cmdline=3D"ioctl_ns05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl_ns05.c:91: TPASS: child and parent are consistent
ioctl_ns05.c:50: TPASS: child thinks its pid is 1

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dinotify09 stime=3D1615253802
cmdline=3D"inotify09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:507: TINFO: Minimum sampling period =
ended
=2E./../../../include/tst_fuzzy_sync.h:331: TINFO: loop =3D 1024, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: start_a - start_b: { avg=
 =3D   -61ns, avg_dev =3D     4ns, dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - start_a  : { avg=
 =3D   918ns, avg_dev =3D    11ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_b - start_b  : { avg=
 =3D  1641ns, avg_dev =3D    18ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - end_b    : { avg=
 =3D  -785ns, avg_dev =3D    17ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: spins            : { avg=
 =3D   485  , avg_dev =3D     9  , dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:519: TINFO: Reached deviation ratios=
 < 0.10, introducing randomness
=2E./../../../include/tst_fuzzy_sync.h:522: TINFO: Delay range is [-1014, 5=
67]
=2E./../../../include/tst_fuzzy_sync.h:331: TINFO: loop =3D 1025, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: start_a - start_b: { avg=
 =3D   -61ns, avg_dev =3D     4ns, dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - start_a  : { avg=
 =3D   918ns, avg_dev =3D    11ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_b - start_b  : { avg=
 =3D  1641ns, avg_dev =3D    18ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - end_b    : { avg=
 =3D  -785ns, avg_dev =3D    17ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: spins            : { avg=
 =3D   485  , avg_dev =3D     9  , dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:643: TINFO: Exceeded execution loops=
, requesting exit
inotify09.c:89: TPASS: kernel survived inotify beating

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D15 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1914 cstime=3D1013
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify06 stime=3D1615253817
cmdline=3D"fanotify06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fanotify06.c:155: TINFO: Test #0: Fanotify merge mount mark
fanotify06.c:133: TPASS: group 0 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:133: TPASS: group 1 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:133: TPASS: group 2 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:216: TPASS: group 3 got no event
fanotify06.c:216: TPASS: group 4 got no event
fanotify06.c:216: TPASS: group 5 got no event
fanotify06.c:216: TPASS: group 6 got no event
fanotify06.c:216: TPASS: group 7 got no event
fanotify06.c:216: TPASS: group 8 got no event
fanotify06.c:155: TINFO: Test #1: Fanotify merge overlayfs mount mark
fanotify06.c:133: TPASS: group 0 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:133: TPASS: group 1 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:133: TPASS: group 2 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:216: TPASS: group 3 got no event
fanotify06.c:216: TPASS: group 4 got no event
fanotify06.c:216: TPASS: group 5 got no event
fanotify06.c:216: TPASS: group 6 got no event
fanotify06.c:216: TPASS: group 7 got no event
fanotify06.c:216: TPASS: group 8 got no event

Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify11 stime=3D1615253818
cmdline=3D"fanotify11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fanotify11.c:66: TINFO: Test #0: without FAN_REPORT_TID: tgid=3D3804, tid=
=3D0, event.pid=3D0
fanotify11.c:85: TPASS: event.pid =3D=3D tgid
fanotify11.c:66: TINFO: Test #1: with FAN_REPORT_TID: tgid=3D3804, tid=3D38=
05, event.pid=3D3804
fanotify11.c:83: TPASS: event.pid =3D=3D tid

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dioprio_set01 stime=3D1615253818
cmdline=3D"ioprio_set01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioprio_set01.c:66: TINFO: ioprio_get returned class NONE prio 4
ioprio.h:91: TPASS: ioprio_set new class BEST-EFFORT, new prio 5
ioprio.h:91: TPASS: ioprio_set new class BEST-EFFORT, new prio 3

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dio_pgetevents02 stime=3D1615253818
cmdline=3D"io_pgetevents02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
io_pgetevents02.c:57: TINFO: Testing variant: syscall with old kernel spec
io_pgetevents02.c:118: TPASS: invalid ctx: io_pgetevents() failed as expect=
ed: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid min_nr: io_pgetevents() failed as exp=
ected: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid max_nr: io_pgetevents() failed as exp=
ected: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid events: io_pgetevents() failed as exp=
ected: EFAULT (14)
io_pgetevents02.c:118: TPASS: invalid timeout: io_pgetevents() failed as ex=
pected: EFAULT (14)
io_pgetevents02.c:118: TPASS: invalid sigmask: io_pgetevents() failed as ex=
pected: EFAULT (14)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkeyctl05 stime=3D1615253818
cmdline=3D"keyctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
keyctl05.c:123: TINFO: Try to update the 'asymmetric' key...
keyctl05.c:136: TPASS: updating 'asymmetric' key expectedly failed with EOP=
NOTSUPP
keyctl05.c:92: TCONF: kernel doesn't support key type 'dns_resolver'
keyctl05.c:171: TINFO: Try to update the 'user' key...
keyctl05.c:180: TPASS: didn't crash while racing to update 'user' key

Summary:
passed   2
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dkill02 stime=3D1615253818
cmdline=3D"kill02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill02      1  TPASS  :  The signal was sent to all processes in the proces=
s group.
kill02      2  TPASS  :  The signal was not sent to selective processes tha=
t were not in the process group.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D10 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dkill03 stime=3D1615253828
cmdline=3D"kill03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
kill03.c:41: TPASS: kill failed as expected: EINVAL (22)
kill03.c:41: TPASS: kill failed as expected: ESRCH (3)
kill03.c:41: TPASS: kill failed as expected: ESRCH (3)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown03 stime=3D1615253828
cmdline=3D"lchown03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
lchown03    0  TINFO  :  Found free device 0 '/dev/loop0'
lchown03    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
lchown03    1  TPASS  :  lchown() failed as expected: TEST_ERRNO=3DELOOP(40=
): Too many levels of symbolic links
lchown03    2  TPASS  :  lchown() failed as expected: TEST_ERRNO=3DEROFS(30=
): Read-only file system
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dlistxattr03 stime=3D1615253828
cmdline=3D"listxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
listxattr03.c:54: TPASS: listxattr() succeed with suitable buffer
listxattr03.c:54: TPASS: listxattr() succeed with suitable buffer

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dllseek03 stime=3D1615253828
cmdline=3D"llseek03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
llseek03.c:96: TPASS: llseek returned 1
llseek03.c:115: TPASS: SEEK_SET for llseek
llseek03.c:96: TPASS: llseek returned 5
llseek03.c:115: TPASS: SEEK_CUR for llseek
llseek03.c:96: TPASS: llseek returned 7
llseek03.c:115: TPASS: SEEK_END for llseek
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_SET read returned 0
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_CUR read returned 0
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_END read returned 0
llseek03.c:96: TPASS: llseek returned 10
llseek03.c:107: TPASS: SEEK_SET read returned 0
llseek03.c:96: TPASS: llseek returned 12
llseek03.c:107: TPASS: SEEK_CUR read returned 0
llseek03.c:96: TPASS: llseek returned 12
llseek03.c:107: TPASS: SEEK_END read returned 0

Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlseek02 stime=3D1615253828
cmdline=3D"lseek02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
lseek02.c:65: TPASS: lseek(-1, 1, 0) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(-1, 1, 1) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(-1, 1, 2) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(4, 1, 5) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(4, 1, -1) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(4, 1, 7) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(5, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(5, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(5, 1, 2) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 2) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 2) failed as expected: ESPIPE (29)

Summary:
passed   15
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmigrate_pages01 stime=3D1615253828
cmdline=3D"migrate_pages01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
migrate_pages01    0  TINFO  :  test_empty_mask
migrate_pages01    1  TPASS  :  expected ret success: returned value =3D 0
migrate_pages01    0  TINFO  :  test_invalid_pid -1
migrate_pages01    2  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    3  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): No=
 such process
migrate_pages01    0  TINFO  :  test_invalid_pid unused pid
migrate_pages01    4  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    5  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): No=
 such process
migrate_pages01    0  TINFO  :  test_invalid_masksize
migrate_pages01    6  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22): =
Invalid argument
migrate_pages01    0  TINFO  :  test_invalid_mem -1
migrate_pages01    8  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    9  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_mem invalid prot
migrate_pages01   10  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   11  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_mem unmmaped
migrate_pages01   12  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   13  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_nodes
migrate_pages01   14  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   15  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22): =
Invalid argument
migrate_pages01    0  TINFO  :  test_invalid_perm
migrate_pages01   16  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   17  TPASS  :  expected failure: TEST_ERRNO=3DEPERM(1): Op=
eration not permitted
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmkdirat01 stime=3D1615253828
cmdline=3D"mkdirat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mkdirat01    1  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    2  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    3  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    4  TPASS  :  mkdirat() returned -1: TEST_ERRNO=3DENOTDIR(20): =
Not a directory
mkdirat01    5  TPASS  :  mkdirat() returned -1: TEST_ERRNO=3DEBADF(9): Bad=
 file descriptor
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmlock01 stime=3D1615253828
cmdline=3D"mlock01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mlock01     1  TPASS  :  mlock passed
mlock01     2  TPASS  :  mlock passed
mlock01     3  TPASS  :  mlock passed
mlock01     4  TPASS  :  mlock passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages04 stime=3D1615253828
cmdline=3D"move_pages04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
move_pages04    1  TCONF  :  move_pages_support.c:407: at least 2 allowed N=
UMA nodes are required
move_pages04    2  TCONF  :  move_pages_support.c:407: Remaining cases not =
appropriate for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpkey01 stime=3D1615253828
cmdline=3D"pkey01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_hugepage.c:58: TINFO: 1 hugepage(s) reserved
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pkey.h:48: TCONF: pku is not supported on this CPU

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D5
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_notify01 stime=3D1615253828
cmdline=3D"mq_notify01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBUSY (16)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_notify02 stime=3D1615253828
cmdline=3D"mq_notify02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mq_notify02    1  TPASS  :  mq_notify failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
mq_notify02    2  TPASS  :  mq_notify failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap01 stime=3D1615253828
cmdline=3D"mremap01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mremap01    1  TPASS  :  Functionality of mremap() is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgget02 stime=3D1615253828
cmdline=3D"msgget02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
msgget02.c:57: TPASS: msgget() failed as expected: EEXIST (17)
msgget02.c:57: TPASS: msgget() failed as expected: ENOENT (2)
msgget02.c:57: TPASS: msgget() failed as expected: ENOENT (2)
msgget02.c:57: TPASS: msgget() failed as expected: EACCES (13)
msgget02.c:57: TPASS: msgget() failed as expected: EACCES (13)
msgget02.c:57: TPASS: msgget() failed as expected: EACCES (13)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgrcv02 stime=3D1615253828
cmdline=3D"msgrcv02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
msgrcv02.c:69: TPASS: msgrcv() failed as expected: E2BIG (7)
msgrcv02.c:69: TPASS: msgrcv() failed as expected: EACCES (13)
msgrcv02.c:69: TPASS: msgrcv() failed as expected: EFAULT (14)
msgrcv02.c:69: TPASS: msgrcv() failed as expected: EINVAL (22)
msgrcv02.c:69: TPASS: msgrcv() failed as expected: EINVAL (22)
msgrcv02.c:69: TPASS: msgrcv() failed as expected: ENOMSG (42)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsync01 stime=3D1615253828
cmdline=3D"msync01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
msync01     1  TPASS  :  Functionality of msync() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dname_to_handle_at01 stime=3D1615253828
cmdline=3D"name_to_handle_at01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
tst_buffers.c:55: TINFO: Test is using guarded buffers
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (0)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (1)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (2)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (3)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (4)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (5)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (6)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (7)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (8)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (9)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (10)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (11)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (12)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (13)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (14)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (15)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (16)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (17)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (18)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (19)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (20)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (21)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (22)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (23)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (24)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (25)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (26)

Summary:
passed   27
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen02 stime=3D1615253828
cmdline=3D"open02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
open02.c:53: TPASS: open() new file without O_CREAT: ENOENT (2)
open02.c:53: TPASS: open() unpriviledget O_RDONLY | O_NOATIME: EPERM (1)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen03 stime=3D1615253828
cmdline=3D"open03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open03      1  TPASS  :  open(tfile_3900, O_RDWR|O_CREAT,0700) returned 4
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen14 stime=3D1615253828
cmdline=3D"open14"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open14      0  TINFO  :  creating a file with O_TMPFILE flag
open14      0  TINFO  :  writing data to the file
open14      0  TINFO  :  file size is '4096'
open14      0  TINFO  :  looking for the file in '.'
open14      0  TINFO  :  file not found, OK
open14      0  TINFO  :  renaming '/fs/sda1/tmpdir/ltp-rUT0eB0OZ3/opeQmLa7B=
/#537178209 (deleted)' -> 'tmpfile'
open14      0  TINFO  :  found a file: tmpfile
open14      1  TPASS  :  single file tests passed
open14      0  TINFO  :  create files in multiple directories
open14      0  TINFO  :  removing test directories
open14      0  TINFO  :  writing/reading temporary files
open14      0  TINFO  :  closing temporary files
open14      2  TPASS  :  multiple files tests passed
open14      0  TINFO  :  create multiple directories, link files into them
open14      0  TINFO  :  and check file permissions
open14      0  TINFO  :  remove files, directories
open14      3  TPASS  :  file permission tests passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dopenat01 stime=3D1615253829
cmdline=3D"openat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
openat01    1  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
openat01    2  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
openat01    3  TPASS  :  openat() returned -1: TEST_ERRNO=3DENOTDIR(20): No=
t a directory
openat01    4  TPASS  :  openat() returned -1: TEST_ERRNO=3DEBADF(9): Bad f=
ile descriptor
openat01    5  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmincore03 stime=3D1615253829
cmdline=3D"mincore03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
mincore03.c:66: TPASS: mincore() reports untouched pages are not resident
mincore03.c:66: TPASS: mincore() reports locked pages are resident

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmincore04 stime=3D1615253829
cmdline=3D"mincore04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
mincore04.c:100: TPASS: mincore reports all 3 pages locked by child process=
 are resident

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmadvise01 stime=3D1615253829
cmdline=3D"madvise01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
madvise01.c:112: TPASS: madvise test for MADV_NORMAL PASSED
madvise01.c:112: TPASS: madvise test for MADV_RANDOM PASSED
madvise01.c:112: TPASS: madvise test for MADV_SEQUENTIAL PASSED
madvise01.c:112: TPASS: madvise test for MADV_WILLNEED PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTNEED PASSED
madvise01.c:112: TPASS: madvise test for MADV_REMOVE PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_DOFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_HWPOISON PASSED
madvise01.c:112: TPASS: madvise test for MADV_MERGEABLE PASSED
madvise01.c:112: TPASS: madvise test for MADV_UNMERGEABLE PASSED
madvise01.c:112: TPASS: madvise test for MADV_HUGEPAGE PASSED
madvise01.c:112: TPASS: madvise test for MADV_NOHUGEPAGE PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTDUMP PASSED
madvise01.c:112: TPASS: madvise test for MADV_DODUMP PASSED
madvise01.c:112: TPASS: madvise test for MADV_FREE PASSED
madvise01.c:112: TPASS: madvise test for MADV_WIPEONFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_KEEPONFORK PASSED

Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D17
<<<test_end>>>
<<<test_start>>>
tag=3Dmadvise06 stime=3D1615253829
cmdline=3D"madvise06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
madvise06.c:106: TINFO: dropping caches
madvise06.c:117: TCONF: System swap is too small (838860800 bytes needed)

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D5
<<<test_end>>>
<<<test_start>>>
tag=3Dpause02 stime=3D1615253829
cmdline=3D"pause02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pause02     1  TPASS  :  pause was interrupted correctly
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpidfd_open02 stime=3D1615253829
cmdline=3D"pidfd_open02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pidfd_open02.c:50: TPASS: expired pid: pidfd_open() failed as expected: ESR=
CH (3)
pidfd_open02.c:50: TPASS: invalid pid: pidfd_open() failed as expected: EIN=
VAL (22)
pidfd_open02.c:50: TPASS: invalid flags: pidfd_open() failed as expected: E=
INVAL (22)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe08 stime=3D1615253829
cmdline=3D"pipe08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pipe08      1  TPASS  :  got expected SIGPIPE signal
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe09 stime=3D1615253829
cmdline=3D"pipe09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pipe09      1  TPASS  :  functionality appears to be correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe2_04 stime=3D1615253829
cmdline=3D"pipe2_04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pipe2_04.c:37: TPASS: write failed as expected: EAGAIN/EWOULDBLOCK (11)
pipe2_04.c:53: TPASS: Child process is blocked

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpreadv202 stime=3D1615253829
cmdline=3D"preadv202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
preadv202.c:82: TPASS: preadv2() failed as expected: EINVAL (22)
preadv202.c:82: TPASS: preadv2() failed as expected: EINVAL (22)
preadv202.c:82: TPASS: preadv2() failed as expected: EOPNOTSUPP (95)
preadv202.c:82: TPASS: preadv2() failed as expected: EFAULT (14)
preadv202.c:82: TPASS: preadv2() failed as expected: EBADF (9)
preadv202.c:82: TPASS: preadv2() failed as expected: EBADF (9)
preadv202.c:82: TPASS: preadv2() failed as expected: EISDIR (21)
preadv202.c:82: TPASS: preadv2() failed as expected: ESPIPE (29)

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dprocess_vm_readv01 stime=3D1615253829
cmdline=3D"process_vm01 -r"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
process_vm_readv    0  TINFO  :  test_sane_params
process_vm_readv    1  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_flags, flags=3D-2147483647
process_vm_readv    2  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    3  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D-1
process_vm_readv    4  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    5  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D1
process_vm_readv    6  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D2147483647
process_vm_readv    8  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    9  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D0
process_vm_readv   10  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_iov_len_overflow
process_vm_readv   11  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   12  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec->iov_base
process_vm_readv   13  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   14  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec->iov_base
process_vm_readv   15  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   16  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec
process_vm_readv   17  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   18  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec
process_vm_readv   19  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   20  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_pid
process_vm_readv   21  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   22  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv   23  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   24  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv    0  TINFO  :  test_invalid_perm
process_vm_readv   25  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   26  TPASS  :  expected failure: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
process_vm_readv    0  TINFO  :  test_sane_params
process_vm_readv    1  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_flags, flags=3D-2147483647
process_vm_readv    2  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    3  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D-1
process_vm_readv    4  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    5  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D1
process_vm_readv    6  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D2147483647
process_vm_readv    8  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    9  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D0
process_vm_readv   10  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_iov_len_overflow
process_vm_readv   11  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   12  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec->iov_base
process_vm_readv   13  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   14  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec->iov_base
process_vm_readv   15  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   16  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec
process_vm_readv   17  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   18  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec
process_vm_readv   19  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   20  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_pid
process_vm_readv   21  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   22  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv   23  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   24  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv    0  TINFO  :  test_invalid_perm
process_vm_readv    0  TINFO  :  test_invalid_protection lvec
process_vm_readv   25  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   26  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_protection rvec
process_vm_readv   27  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   28  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpselect03_64 stime=3D1615253829
cmdline=3D"pselect03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pselect03.c:31: TPASS: pselect() succeeded retval=3D0

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace03 stime=3D1615253829
cmdline=3D"ptrace03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ptrace03.c:43: TINFO: Trace a process which does not exist
ptrace03.c:56: TPASS: ptrace() failed as expected: ESRCH (3)
ptrace03.c:43: TINFO: Trace a process which is already been traced
ptrace03.c:56: TPASS: ptrace() failed as expected: EPERM (1)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace11 stime=3D1615253829
cmdline=3D"ptrace11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ptrace11.c:28: TPASS: ptrace() traces init process successfully

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwrite03 stime=3D1615253829
cmdline=3D"pwrite03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwrite03.c:25: TPASS: pwrite(fd, NULL, 0) =3D=3D 0

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwrite04_64 stime=3D1615253829
cmdline=3D"pwrite04_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pwrite04    1  TPASS  :  O_APPEND test passed.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev02_64 stime=3D1615253829
cmdline=3D"pwritev02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EFAULT (14)
pwritev02.c:84: TPASS: pwritev() failed as expected: EBADF (9)
pwritev02.c:84: TPASS: pwritev() failed as expected: EBADF (9)
pwritev02.c:84: TPASS: pwritev() failed as expected: ESPIPE (29)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev03 stime=3D1615253829
cmdline=3D"pwritev03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: TINFO: Kernel supports ext2
tst_supported_fs_types.c:44: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext3
tst_supported_fs_types.c:44: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext4
tst_supported_fs_types.c:44: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports xfs
tst_supported_fs_types.c:44: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:44: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports vfat
tst_supported_fs_types.c:44: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:83: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:92: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:44: TINFO: mkfs.ntfs does exist
tst_test.c:1329: TINFO: Testing on ext2
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1329: TINFO: Testing on ext3
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1329: TINFO: Testing on ext4
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1329: TINFO: Testing on xfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1329: TINFO: Testing on btrfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:870: TBROK: mount(/dev/loop0, mntpoint, btrfs, 0, (nil)) failed:=
 ENOENT (2)

Summary:
passed   12
failed   0
broken   1
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D2 corefile=3Dno
cutime=3D6 cstime=3D17
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev201_64 stime=3D1615253831
cmdline=3D"pwritev201_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev202 stime=3D1615253831
cmdline=3D"pwritev202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev202.c:78: TPASS: pwritev2() failed as expected: EINVAL (22)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EINVAL (22)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EOPNOTSUPP (95)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EFAULT (14)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EBADF (9)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EBADF (9)
pwritev202.c:78: TPASS: pwritev2() failed as expected: ESPIPE (29)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dquotactl05 stime=3D1615253831
cmdline=3D"quotactl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:63: TINFO: Parsing kernel config '/proc/config.gz'
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
quotactl05.c:73: TINFO: Test #0: QCMD(Q_XGETQSTAT, PRJQUOTA) off
quotactl02.h:68: TPASS: quotactl() succeeded to turn off xfs quota and get =
xfs quota off status for project
quotactl05.c:73: TINFO: Test #1: QCMD(Q_XGETQSTAT, PRJQUOTA) on
quotactl02.h:88: TPASS: quotactl() succeeded to turn on xfs quota and get x=
fs quota on status for project
quotactl05.c:73: TINFO: Test #2: QCMD(Q_XGETQUOTA, PRJQUOTA) qlim
quotactl02.h:162: TPASS: quotactl() succeeded to set and use Q_XGETQUOTA fo=
r project to get xfs disk quota limits
quotactl05.c:73: TINFO: Test #3: QCMD(Q_XGETNEXTQUOTA, PRJQUOTA)
quotactl02.h:162: TPASS: quotactl() succeeded to set and use Q_XGETNEXTQUOT=
A for project to get xfs disk quota limits
quotactl05.c:73: TINFO: Test #4: QCMD(Q_XGETQSTATV, PRJQUOTA) off
quotactl02.h:110: TPASS: quotactl() succeeded to turn off xfs quota and get=
 xfs quota off statv for project
quotactl05.c:73: TINFO: Test #5: QCMD(Q_XGETQSTATV, PRJQUOTA) on
quotactl02.h:132: TPASS: quotactl() succeeded to turn on xfs quota and get =
xfs quota on statv for project

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D5
<<<test_end>>>
<<<test_start>>>
tag=3Dread01 stime=3D1615253832
cmdline=3D"read01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
read01.c:24: TPASS: read(2) returned 512

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreadlinkat02 stime=3D1615253832
cmdline=3D"readlinkat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
readlinkat02    1  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEI=
NVAL(22): Invalid argument
readlinkat02    2  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEI=
NVAL(22): Invalid argument
readlinkat02    3  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEN=
OTDIR(20): Not a directory
readlinkat02    4  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEN=
OTDIR(20): Not a directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreadv03 stime=3D1615253832
cmdline=3D"readv03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
readv03     1  TPASS  :  got EISDIR
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreboot01 stime=3D1615253832
cmdline=3D"reboot01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
reboot01    1  TPASS  :  reboot(2) Passed for option LINUX_REBOOT_CMD_CAD_ON
reboot01    2  TPASS  :  reboot(2) Passed for option LINUX_REBOOT_CMD_CAD_O=
FF
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dremovexattr01 stime=3D1615253832
cmdline=3D"removexattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
removexattr01    1  TPASS  :  removexattr() succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drename07 stime=3D1615253832
cmdline=3D"rename07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
rename07    1  TPASS  :  rename() returned ENOTDIR
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drequest_key02 stime=3D1615253832
cmdline=3D"request_key02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
request_key02.c:53: TPASS: request_key() failed expectly: ENOKEY (126)
request_key02.c:53: TPASS: request_key() failed expectly: EKEYREVOKED (128)
request_key02.c:53: TPASS: request_key() failed expectly: EKEYEXPIRED (127)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drt_sigsuspend01 stime=3D1615253834
cmdline=3D"rt_sigsuspend01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
rt_sigsuspend01.c:49: TPASS: rt_sigsuspend() returned with -1 and EINTR
rt_sigsuspend01.c:58: TPASS: signal mask preserved

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_get_priority_min01 stime=3D1615253835
cmdline=3D"sched_get_priority_min01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_get_priority_min01    1  TPASS  :  Test for SCHED_OTHER Passed
sched_get_priority_min01    2  TPASS  :  Test for SCHED_FIFO Passed
sched_get_priority_min01    3  TPASS  :  Test for SCHED_RR Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setparam01 stime=3D1615253835
cmdline=3D"sched_setparam01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_setparam01    1  TPASS  :  sched_setparam() returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_getattr01 stime=3D1615253835
cmdline=3D"sched_getattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_getattr01    1  TPASS  :  attributes were read back correctly
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemctl06 stime=3D1615253835
cmdline=3D"semctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
semctl06    1  TPASS  :  semctl06 ran successfully!
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsemget03 stime=3D1615253835
cmdline=3D"semget03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
semget03    1  TPASS  :  expected failure - errno =3D 2 : No such file or d=
irectory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemop02 stime=3D1615253835
cmdline=3D"semop02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
semop02.c:78: TINFO: Testing variant: semop: syscall
semop02.c:148: TPASS: semop failed as expected: E2BIG (7)
semop02.c:148: TPASS: semop failed as expected: EACCES (13)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: ERANGE (34)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:123: TCONF: Test not supported for variant
semop02.c:123: TCONF: Test not supported for variant
semop02.c:123: TCONF: Test not supported for variant
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
semop02.c:78: TINFO: Testing variant: semtimedop: syscall with old kernel s=
pec
semop02.c:148: TPASS: semop failed as expected: E2BIG (7)
semop02.c:148: TPASS: semop failed as expected: EACCES (13)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: ERANGE (34)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)

Summary:
passed   23
failed   0
broken   0
skipped  3
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsend01 stime=3D1615253835
cmdline=3D"send01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
send01      1  TPASS  :  bad file descriptor successful
send01      2  TPASS  :  invalid socket successful
send01      3  TPASS  :  invalid send buffer successful
send01      4  TPASS  :  UDP message too big successful
send01      5  TPASS  :  local endpoint shutdown successful
send01      6  TPASS  :  invalid flags set successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile03_64 stime=3D1615253835
cmdline=3D"sendfile03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile03_64    1  TPASS  :  sendfile() returned 9 : Bad file descriptor
sendfile03_64    2  TPASS  :  sendfile() returned 9 : Bad file descriptor
sendfile03_64    3  TPASS  :  sendfile() returned 9 : Bad file descriptor
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile04 stime=3D1615253835
cmdline=3D"sendfile04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile04    1  TPASS  :  sendfile() returned 14 : Bad address
sendfile04    2  TPASS  :  sendfile() returned 14 : Bad address
sendfile04    3  TPASS  :  sendfile() returned 14 : Bad address
sendfile04    4  TPASS  :  sendfile() returned 14 : Bad address
sendfile04    5  TPASS  :  sendfile() returned 14 : Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile07_64 stime=3D1615253835
cmdline=3D"sendfile07_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile07_64    1  TPASS  :  sendfile() returned 11 : Resource temporarily=
 unavailable
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendmsg01 stime=3D1615253835
cmdline=3D"sendmsg01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendmsg01    1  TPASS  :  bad file descriptor successful
sendmsg01    2  TPASS  :  invalid socket successful
sendmsg01    3  TPASS  :  invalid send buffer successful
sendmsg01    4  TPASS  :  connected TCP successful
sendmsg01    5  TPASS  :  not connected TCP successful
sendmsg01    6  TPASS  :  invalid to buffer length successful
sendmsg01    7  TPASS  :  invalid to buffer successful
sendmsg01    8  TPASS  :  UDP message too big successful
sendmsg01    9  TPASS  :  local endpoint shutdown successful
sendmsg01   10  TPASS  :  invalid iovec pointer successful
sendmsg01   11  TPASS  :  invalid msghdr pointer successful
sendmsg01   12  TPASS  :  rights passing successful
sendmsg01   13  TPASS  :  invalid flags set successful
sendmsg01   14  TPASS  :  invalid cmsg length successful
sendmsg01   15  TPASS  :  invalid cmsg pointer successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dset_mempolicy02 stime=3D1615253835
cmdline=3D"set_mempolicy02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:191: TINFO: Found 1 NUMA memory nodes
set_mempolicy02.c:39: TCONF: Test requires at least two NUMA memory nodes

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dset_tid_address01 stime=3D1615253835
cmdline=3D"set_tid_address01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
set_tid_address01    1  TPASS  :  set_tid_address call succeeded:  as expec=
ted 4112
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetdomainname01 stime=3D1615253835
cmdline=3D"setdomainname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:36: TINFO: Testing libc setdomainname()
setdomainname01.c:26: TPASS: setdomainname() succeed
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:39: TINFO: Testing __NR_setdomainname syscall
setdomainname01.c:26: TPASS: setdomainname() succeed

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsuid01 stime=3D1615253835
cmdline=3D"setfsuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsuid01    1  TPASS  :  setfsuid() returned expected value : 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsgetmask01 stime=3D1615253835
cmdline=3D"sgetmask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sgetmask01    1  TCONF  :  sgetmask01.c:128: syscall(-1) __NR_ssetmask not =
supported on your arch
sgetmask01    2  TCONF  :  sgetmask01.c:128: Remaining cases not appropriat=
e for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgroups04_16 stime=3D1615253835
cmdline=3D"setgroups04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgroups04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setgroups/../utils/compat_16.h:77: 16-bit version of setgroups() is not =
supported on your platform
setgroups04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setgroups/../utils/compat_16.h:77: Remaining cases not appropriate for c=
onfiguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetitimer03 stime=3D1615253835
cmdline=3D"setitimer03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setitimer03    1  TPASS  :  expected failure - errno =3D 22 - Invalid argum=
ent
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetpgrp01 stime=3D1615253835
cmdline=3D"setpgrp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setpgrp01    1  TPASS  :  setpgrp -  Call the setpgrp system call returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetpriority01 stime=3D1615253835
cmdline=3D"setpriority01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
setpriority01.c:75: TPASS: setpriority(PRIO_PROCESS(0), 4130, -20..19) succ=
eeded
setpriority01.c:75: TPASS: setpriority(PRIO_PGRP(1), 4131, -20..19) succeed=
ed
setpriority01.c:75: TPASS: setpriority(PRIO_USER(2), 1091, -20..19) succeed=
ed
userdel: ltp_setpriority01 mail spool (/var/mail/ltp_setpriority01) not fou=
nd
userdel: ltp_setpriority01 home directory (/home/ltp_setpriority01) not fou=
nd

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsetregid01 stime=3D1615253835
cmdline=3D"setregid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
setregid01.c:49: TPASS: Dont change either real or effective gid
setregid01.c:49: TPASS: Change effective to effective gid
setregid01.c:49: TPASS: Change real to real gid
setregid01.c:49: TPASS: Change effective to real gid
setregid01.c:49: TPASS: Try to change real to current real

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetreuid07 stime=3D1615253835
cmdline=3D"setreuid07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open failed with EACCES as expected
open failed with EACCES as expected
open call succeeded
setreuid07    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetuid01 stime=3D1615253835
cmdline=3D"setuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
setuid01.c:30: TPASS: setuid(0) successfully

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmctl07 stime=3D1615253835
cmdline=3D"shmctl07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
shmctl07.c:31: TPASS: shmctl(1, SHM_LOCK, NULL)
shmctl07.c:37: TPASS: SMH_LOCKED bit is on in shm_perm.mode
shmctl07.c:46: TPASS: shmctl(1, SHM_UNLOCK, NULL)
shmctl07.c:53: TPASS: SHM_LOCKED bit is off in shm_perm.mode

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmget02 stime=3D1615253835
cmdline=3D"shmget02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
shmget02    1  TPASS  :  expected failure - errno =3D 22 : Invalid argument
shmget02    2  TPASS  :  expected failure - errno =3D 22 : Invalid argument
shmget02    3  TPASS  :  expected failure - errno =3D 17 : File exists
shmget02    4  TPASS  :  expected failure - errno =3D 2 : No such file or d=
irectory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsignal02 stime=3D1615253835
cmdline=3D"signal02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal02    1  TPASS  :  expected failure - errno =3D 22 - Invalid argument
signal02    2  TPASS  :  expected failure - errno =3D 22 - Invalid argument
signal02    3  TPASS  :  expected failure - errno =3D 22 - Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsplice03 stime=3D1615253835
cmdline=3D"splice03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EINVAL (22)
splice03.c:99: TPASS: splice() failed as expected: EINVAL (22)
splice03.c:99: TPASS: splice() failed as expected: ESPIPE (29)
splice03.c:99: TPASS: splice() failed as expected: ESPIPE (29)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dssetmask01 stime=3D1615253835
cmdline=3D"ssetmask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
ssetmask01    1  TCONF  :  ssetmask01.c:115: syscall(-1) __NR_ssetmask not =
supported on your arch
ssetmask01    2  TCONF  :  ssetmask01.c:115: Remaining cases not appropriat=
e for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatfs02 stime=3D1615253835
cmdline=3D"statfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs02    1  TPASS  :  expected failure: TEST_ERRNO=3DENOTDIR(20): Not a =
directory
statfs02    2  TPASS  :  expected failure: TEST_ERRNO=3DENOENT(2): No such =
file or directory
statfs02    3  TPASS  :  expected failure: TEST_ERRNO=3DENAMETOOLONG(36): F=
ile name too long
statfs02    4  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): Bad add=
ress
statfs02    5  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): Bad add=
ress
statfs02    6  TPASS  :  expected failure: TEST_ERRNO=3DELOOP(40): Too many=
 levels of symbolic links
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dswapoff01 stime=3D1615253835
cmdline=3D"swapoff01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_ioctl.c:30: TINFO: FIBMAP ioctl is supported
swapoff01    1  TPASS  :  Succeeded to turn off swapfile
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D3 cstime=3D8
<<<test_end>>>
<<<test_start>>>
tag=3Dswitch01 stime=3D1615253836
cmdline=3D"endian_switch01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:881: TCONF: This system does not support running of switch() sys=
call
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsymlink02 stime=3D1615253836
cmdline=3D"symlink02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsymlink05 stime=3D1615253836
cmdline=3D"symlink05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
symlink05    1  TPASS  :  symlink(testfile, slink_file) functionality succe=
ssful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsysinfo02 stime=3D1615253836
cmdline=3D"sysinfo02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sysinfo02    1  TPASS  :  Test to check the error code 14 PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog02 stime=3D1615253836
cmdline=3D"syslog02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog02    0  TINFO  :  Test if messages of all levels are logged.
syslog02    0  TINFO  :  For each level, a separate configuration file is
syslog02    0  TINFO  :  created and that will be used as syslog.conf file.
syslog02    0  TINFO  :  testing whether messages are logged into log file
syslog02    0  TINFO  :  Doing level: emerg...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    1  TPASS  :  ***** Level emerg passed *****
syslog02    0  TINFO  :  Doing level: alert...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    2  TPASS  :  ***** Level alert passed *****
syslog02    0  TINFO  :  Doing level: crit...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    3  TPASS  :  ***** Level crit passed *****
syslog02    0  TINFO  :  Doing level: err...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    4  TPASS  :  ***** Level err passed *****
syslog02    0  TINFO  :  Doing level: warning...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    5  TPASS  :  ***** Level warning passed *****
syslog02    0  TINFO  :  Doing level: notice...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    6  TPASS  :  ***** Level notice passed *****
syslog02    0  TINFO  :  Doing level: info...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    7  TPASS  :  ***** Level info passed *****
syslog02    0  TINFO  :  Doing level: debug...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    8  TPASS  :  ***** Level debug passed *****
syslog02    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D36 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D5 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog10 stime=3D1615253872
cmdline=3D"syslog10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog10    0  TINFO  :   Test setlogmask() with LOG_MASK macro.
syslog10    0  TINFO  :   o Use setlogmask() with LOG_MASK macro to set an
syslog10    0  TINFO  :     individual priority level.
syslog10    0  TINFO  :   o Send the message of above prority and expect it=
 to be
syslog10    0  TINFO  :     logged.
syslog10    0  TINFO  :   o Send message which is at other priority level to
syslog10    0  TINFO  :     the one set above, which should not be logged.
syslog10    0  TINFO  :  syslog: Testing setlogmask() with LOG_MASK macro...
syslog10    0  TINFO  :  restarting syslog daemon
syslog10    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dtimerfd_settime01 stime=3D1615253878
cmdline=3D"timerfd_settime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
timerfd_settime01.c:53: TINFO: Testing variant: syscall with old kernel spec
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EBADF =
(9)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EFAULT=
 (14)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EINVAL=
 (22)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EINVAL=
 (22)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dtimer_delete02 stime=3D1615253878
cmdline=3D"timer_delete02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
timer_delete02.c:30: TPASS: Failed as expected: EINVAL (22)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dutime03 stime=3D1615253878
cmdline=3D"utime03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
utime03     1  TPASS  :  Functionality of utime(tmp_file, NULL) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dutime05 stime=3D1615253882
cmdline=3D"utime05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
utime05     1  TPASS  :  Functionality of utime(tmp_file, &times) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwait02 stime=3D1615253882
cmdline=3D"wait02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
wait02      1  TPASS  :  wait(&status) returned 4490
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwait402 stime=3D1615253883
cmdline=3D"wait402"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
wait402     1  TPASS  :  received expected failure - errno =3D 10 - No chil=
d processes
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid01 stime=3D1615253883
cmdline=3D"waitpid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
waitpid01.c:38: TPASS: waitpid() returned correct pid 4497
waitpid01.c:47: TPASS: WIFSIGNALED() set in status
waitpid01.c:55: TPASS: WTERMSIG() =3D=3D SIGALRM

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid06 stime=3D1615253883
cmdline=3D"waitpid06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
waitpid06.c:54: TPASS: Test PASSED

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitid01 stime=3D1615253883
cmdline=3D"waitid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4511 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4512 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4511 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4512 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4513 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4511 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4512 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4513 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4514 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4515 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4511 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4512 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4513 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4514 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4515 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4516 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4511 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4512 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4513 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4514 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4515 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4516 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4517 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4518 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    1  TPASS  :  waitid(): system call passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwritev02 stime=3D1615253883
cmdline=3D"writev02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
writev02    0  TINFO  :  Enter block 1
writev02    1  TPASS  :  Received EFAULT as expected
writev02    0  TINFO  :  Exit block 1
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfutex_wait01 stime=3D1615253883
cmdline=3D"futex_wait01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
futex_wait01.c:69: TINFO: Testing variant: syscall with old kernel spec
futex_wait01.c:62: TPASS: futex_wait() passed: ETIMEDOUT (110)
futex_wait01.c:62: TPASS: futex_wait() passed: EAGAIN/EWOULDBLOCK (11)
futex_wait01.c:62: TPASS: futex_wait() passed: ETIMEDOUT (110)
futex_wait01.c:62: TPASS: futex_wait() passed: EAGAIN/EWOULDBLOCK (11)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfutex_wait_bitset01 stime=3D1615253883
cmdline=3D"futex_wait_bitset01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
futex_wait_bitset01.c:99: TINFO: Testing variant: syscall with old kernel s=
pec
futex_wait_bitset01.c:45: TINFO: testing futex_wait_bitset() timeout with C=
LOCK_MONOTONIC
futex_wait_bitset01.c:87: TPASS: futex_wait_bitset() waited 100078us, expec=
ted 100010us
futex_wait_bitset01.c:45: TINFO: testing futex_wait_bitset() timeout with C=
LOCK_REALTIME
futex_wait_bitset01.c:87: TPASS: futex_wait_bitset() waited 100064us, expec=
ted 100010us

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20200930-258-g35cb4055d

       ###############################################################

            Done executing testcases.
            LTP Version:  20200930-258-g35cb4055d
       ###############################################################




To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in =
this email
        bin/lkp split-job --compatible job.yaml
        bin/lkp run                    compatible-job.yaml



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Cent=
er
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporati=
on

Thanks,
Oliver Sang


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-rc1-g3c6be3a73b96"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=19
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# LED Blink
#
# CONFIG_LEDS_BLINK is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_BITFIELD_KUNIT is not set
# CONFIG_RESOURCE_KUNIT_TEST is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_CMDLINE_KUNIT_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='ltp'
	export testcase='ltp'
	export category='functional'
	export need_modules=true
	export need_memory='4G'
	export job_origin='ltp-syscalls.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d02'
	export tbox_group='lkp-skl-d02'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='6046c69ae206195da172f19e'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-07-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-3c6be3a73b969746256d2ad3573b1ee72e8454ee-20210309-23969-1t26ah3-1.yaml'
	export id='078ae96bcd266e4e3978be73006788fbb1a15955'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c500746fa0cc-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e41514d5105-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e41514d5105-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_BLK_DEV_LOOP
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_VCAN=m
CONFIG_IPV6_VTI=m
CONFIG_MINIX_FS=m
CONFIG_XFS_FS'
	export commit='3c6be3a73b969746256d2ad3573b1ee72e8454ee'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export ucode='0xe2'
	export enqueue_time='2021-03-09 08:51:39 +0800'
	export _id='6046c69ae206195da172f19e'
	export _rt='/result/ltp/1HDD-xfs-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='751ce6594886274f1cb79ce6d4401e05b52399f1'
	export base_commit='a38fd8748464831584a19438cbb3082b5a2dab15'
	export branch='linux-review/Jia-Ju-Bai/fs-btrfs-fix-error-return-code-of-btrfs_recover_relocation/20210307-120011'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/ltp/1HDD-xfs-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/3'
	export scheduler_version='/lkp/lkp/.src-20210309-090737'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-07-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-3c6be3a73b969746256d2ad3573b1ee72e8454ee-20210309-23969-1t26ah3-1.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Jia-Ju-Bai/fs-btrfs-fix-error-return-code-of-btrfs_recover_relocation/20210307-120011
commit=3c6be3a73b969746256d2ad3573b1ee72e8454ee
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/vmlinuz-5.12.0-rc1-g3c6be3a73b96
max_uptime=2100
RESULT_ROOT=/result/ltp/1HDD-xfs-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.12.0-rc2-wt-ath-04871-g5a18d67eb1f9'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/vmlinuz-5.12.0-rc1-g3c6be3a73b96'
	export dequeue_time='2021-03-09 09:35:17 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-07-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-3c6be3a73b969746256d2ad3573b1ee72e8454ee-20210309-23969-1t26ah3-1.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

	run_setup fs='xfs' $LKP_SRC/setup/fs

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='syscalls-07' $LKP_SRC/tests/wrapper ltp
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='syscalls-07' $LKP_SRC/stats/wrapper ltp
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time ltp.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--JP+T4n/bALQSJXh8
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ltp
Content-Transfer-Encoding: quoted-printable

2021-03-09 01:36:29 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-03-09 01:36:29 ./runltp -f syscalls-07 -d /fs/sda1/tmpdir
INFO: creating /lkp/benchmarks/ltp/output directory
INFO: creating /lkp/benchmarks/ltp/results directory
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

/etc/os-release
PRETTY_NAME=3D"Debian GNU/Linux 10 (buster)"
NAME=3D"Debian GNU/Linux"
VERSION_ID=3D"10"
VERSION=3D"10 (buster)"
VERSION_CODENAME=3Dbuster
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"

uname:
Linux lkp-skl-d02 5.12.0-rc1-g3c6be3a73b96 #1 SMP Mon Mar 8 10:47:45 CST 20=
21 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-skl-d02::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-07-ucode=3D0xe2-debian-10.4-x86_64-=
20200603.cgz-3c6be3a73b969746256d2ad3573b1ee72e8454ee-20210309-23969-1t26ah=
3-1.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinux-review/Jia-=
Ju-Bai/fs-btrfs-fix-error-return-code-of-btrfs_recover_relocation/20210307-=
120011 commit=3D3c6be3a73b969746256d2ad3573b1ee72e8454ee BOOT_IMAGE=3D/pkg/=
linux/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/vmlinu=
z-5.12.0-rc1-g3c6be3a73b96 max_uptime=3D2100 RESULT_ROOT=3D/result/ltp/1HDD=
-xfs-syscalls-07-ucode=3D0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/3 LKP_SERVER=
=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_=
enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=
=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic loa=
d_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3De=
rr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS=
0,115200 vga=3Dnormal rw

Gnu C                  gcc (Debian 8.3.0-6) 8.3.0
Clang                =20
Gnu make               4.2.1
util-linux             2.33.1
mount                  linux 2.33.1 (libmount 2.33.1: selinux, smack, btrfs=
, namespaces, assert, debug)
modutils               26
e2fsprogs              1.44.5
Linux C Library        > libc.2.28
Dynamic linker (ldd)   2.28
Procps                 3.3.15
Net-tools              2.10-alpha
iproute2               iproute2-ss190107
iputils                iputils-s20180629
ethtool                4.19
Kbd                    119:
Sh-utils               8.30
Modules Loaded         dm_mod xfs libcrc32c ipmi_devintf ipmi_msghandler sd=
_mod t10_pi sg mei_wdt intel_rapl_msr intel_rapl_common x86_pkg_temp_therma=
l intel_powerclamp coretemp i915 kvm_intel intel_gtt drm_kms_helper syscopy=
area kvm sysfillrect irqbypass sysimgblt crct10dif_pclmul crc32_pclmul crc3=
2c_intel ghash_clmulni_intel fb_sys_fops mei_me rapl wmi_bmof intel_cstate =
ahci drm libahci mei intel_uncore intel_pch_thermal libata wmi video intel_=
pmc_core acpi_pad ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32754220      306120    29958112       21780     2489988    2972=
2784
Swap:             0           0           0

cpuinfo:
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
Address sizes:       39 bits physical, 48 bits virtual
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               94
Model name:          Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
Stepping:            3
CPU MHz:             3200.000
CPU max MHz:         3600.0000
CPU min MHz:         800.0000
BogoMIPS:            6399.96
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            6144K
NUMA node0 CPU(s):   0-3
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m=
ca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vm=
x smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe=
 popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefe=
tch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi=
 flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 e=
rms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xge=
tbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp m=
d_clear flush_l1d

AppArmor enabled

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 2534     -n 2534 -=
p -f /fs/sda1/tmpdir/ltp-rUT0eB0OZ3/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_03_09-01h_36m_29s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_03_09-01h_36m_29s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_03_09-01h_36m_29s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_03_09-01h_36m_29s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_03_09-01h_3=
6m_29s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_03_09-01h_36=
m_29s.tconf
Running tests.......
<<<test_start>>>
tag=3Dabort01 stime=3D1615253789
cmdline=3D"abort01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
abort01.c:61: TPASS: abort() dumped core
abort01.c:64: TPASS: abort() raised SIGIOT

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Daccess02 stime=3D1615253789
cmdline=3D"access02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
access02.c:63: TPASS: access(file_f, F_OK) as root passed
access02.c:142: TPASS: access(file_f, F_OK) as root behaviour is correct.
access02.c:63: TPASS: access(file_f, F_OK) as nobody passed
access02.c:142: TPASS: access(file_f, F_OK) as nobody behaviour is correct.
access02.c:63: TPASS: access(file_r, R_OK) as root passed
access02.c:142: TPASS: access(file_r, R_OK) as root behaviour is correct.
access02.c:63: TPASS: access(file_r, R_OK) as nobody passed
access02.c:142: TPASS: access(file_r, R_OK) as nobody behaviour is correct.
access02.c:63: TPASS: access(file_w, W_OK) as root passed
access02.c:142: TPASS: access(file_w, W_OK) as root behaviour is correct.
access02.c:63: TPASS: access(file_w, W_OK) as nobody passed
access02.c:142: TPASS: access(file_w, W_OK) as nobody behaviour is correct.
access02.c:63: TPASS: access(file_x, X_OK) as root passed
access02.c:142: TPASS: access(file_x, X_OK) as root behaviour is correct.
access02.c:63: TPASS: access(file_x, X_OK) as nobody passed
access02.c:142: TPASS: access(file_x, X_OK) as nobody behaviour is correct.
access02.c:63: TPASS: access(symlink_f, F_OK) as root passed
access02.c:142: TPASS: access(symlink_f, F_OK) as root behaviour is correct.
access02.c:63: TPASS: access(symlink_f, F_OK) as nobody passed
access02.c:142: TPASS: access(symlink_f, F_OK) as nobody behaviour is corre=
ct.
access02.c:63: TPASS: access(symlink_r, R_OK) as root passed
access02.c:142: TPASS: access(symlink_r, R_OK) as root behaviour is correct.
access02.c:63: TPASS: access(symlink_r, R_OK) as nobody passed
access02.c:142: TPASS: access(symlink_r, R_OK) as nobody behaviour is corre=
ct.
access02.c:63: TPASS: access(symlink_w, W_OK) as root passed
access02.c:142: TPASS: access(symlink_w, W_OK) as root behaviour is correct.
access02.c:63: TPASS: access(symlink_w, W_OK) as nobody passed
access02.c:142: TPASS: access(symlink_w, W_OK) as nobody behaviour is corre=
ct.
access02.c:63: TPASS: access(symlink_x, X_OK) as root passed
access02.c:142: TPASS: access(symlink_x, X_OK) as root behaviour is correct.
access02.c:63: TPASS: access(symlink_x, X_OK) as nobody passed
access02.c:142: TPASS: access(symlink_x, X_OK) as nobody behaviour is corre=
ct.

Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dalarm02 stime=3D1615253789
cmdline=3D"alarm02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
alarm02.c:62: TPASS: alarm(2147483647) returned 2147483647 as expected for =
value INT_MAX
alarm02.c:62: TPASS: alarm(2147483647) returned 2147483647 as expected for =
value UINT_MAX/2
alarm02.c:62: TPASS: alarm(1073741823) returned 1073741823 as expected for =
value UINT_MAX/4

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dbind01 stime=3D1615253789
cmdline=3D"bind01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
bind01.c:52: TPASS: invalid salen: EINVAL (22)
bind01.c:52: TPASS: invalid socket: ENOTSOCK (88)
bind01.c:55: TPASS: INADDR_ANYPORT passed
bind01.c:52: TPASS: UNIX-domain of current directory: EAFNOSUPPORT (97)
bind01.c:52: TPASS: non-local address: EADDRNOTAVAIL (99)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dbrk01 stime=3D1615253789
cmdline=3D"brk01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed
brk01.c:34: TPASS: brk() passed

Summary:
passed   33
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchmod01 stime=3D1615253789
cmdline=3D"chmod01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chmod01     1  TPASS  :  Functionality of chmod(testfile, 0) successful
chmod01     2  TPASS  :  Functionality of chmod(testfile, 07) successful
chmod01     3  TPASS  :  Functionality of chmod(testfile, 070) successful
chmod01     4  TPASS  :  Functionality of chmod(testfile, 0700) successful
chmod01     5  TPASS  :  Functionality of chmod(testfile, 0777) successful
chmod01     6  TPASS  :  Functionality of chmod(testfile, 02777) successful
chmod01     7  TPASS  :  Functionality of chmod(testfile, 04777) successful
chmod01     8  TPASS  :  Functionality of chmod(testfile, 06777) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchmod07 stime=3D1615253789
cmdline=3D"chmod07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
chmod07.c:59: TPASS: Functionality of chmod(testfile, 01777) successful

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchown01 stime=3D1615253789
cmdline=3D"chown01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chown01     1  TPASS  :  chown(t_2687, 0,0) returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dchown04_16 stime=3D1615253790
cmdline=3D"chown04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
chown04_16    0  TINFO  :  Found free device 0 '/dev/loop0'
chown04_16    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra =
opts=3D''
chown04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/c=
hown/../utils/compat_16.h:166: 16-bit version of chown() is not supported o=
n your platform
chown04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/c=
hown/../utils/compat_16.h:166: Remaining cases not appropriate for configur=
ation
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dchroot02 stime=3D1615253790
cmdline=3D"chroot02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
chroot02    1  TPASS  :  chroot functionality correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclock_adjtime01 stime=3D1615253790
cmdline=3D"clock_adjtime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
clock_adjtime01.c:191: TINFO: Testing variant: syscall with old kernel spec
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342067(us)
clock_adjtime.h:160: TINFO: SET
             mode: 32769
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342071(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342073(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D8001)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342091(us)
clock_adjtime.h:160: TINFO: SET
             mode: 40961
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342094(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342111(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3Da001)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 2
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342115(us)
clock_adjtime.h:160: TINFO: SET
             mode: 16447
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342117(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342120(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D403f)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342124(us)
clock_adjtime.h:160: TINFO: SET
             mode: 1
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342127(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342129(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D1)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 0
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342133(us)
clock_adjtime.h:160: TINFO: SET
             mode: 2
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342149(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342152(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D2)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000000
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342156(us)
clock_adjtime.h:160: TINFO: SET
             mode: 4
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342158(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342161(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D4)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000000
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342165(us)
clock_adjtime.h:160: TINFO: SET
             mode: 8
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342167(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342170(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D8)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 6
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342174(us)
clock_adjtime.h:160: TINFO: SET
             mode: 32
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342176(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342179(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D20)
clock_adjtime.h:160: TINFO: GET
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 10000
         raw time: 1615253790(s) 342183(us)
clock_adjtime.h:160: TINFO: SET
             mode: 16384
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 11000
         raw time: 1615253790(s) 342185(us)
clock_adjtime.h:160: TINFO: VERIFY
             mode: 0
           offset: 0
        frequency: 100
         maxerror: 16000100
         esterror: 16000100
           status: 64 (0x40)
    time_constant: 10
        precision: 1
        tolerance: 32768000
             tick: 11000
         raw time: 1615253790(s) 342188(us)
clock_adjtime01.c:182: TPASS: clock_adjtime(): success (mode=3D4000)

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dclose01 stime=3D1615253790
cmdline=3D"close01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
close01     1  TPASS  :  file appears closed
close01     2  TPASS  :  pipe appears closed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dconfstr01 stime=3D1615253790
cmdline=3D"confstr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
confstr01    1  TPASS  :  confstr PATH =3D '/bin:/usr/bin'
confstr01    2  TPASS  :  confstr XBS5_ILP32_OFF32_CFLAGS =3D ''
confstr01    3  TPASS  :  confstr XBS5_ILP32_OFF32_LDFLAGS =3D ''
confstr01    4  TPASS  :  confstr XBS5_ILP32_OFF32_LIBS =3D ''
confstr01    5  TPASS  :  confstr XBS5_ILP32_OFF32_LINTFLAGS =3D ''
confstr01    6  TPASS  :  confstr XBS5_ILP32_OFFBIG_CFLAGS =3D ''
confstr01    7  TPASS  :  confstr XBS5_ILP32_OFFBIG_LDFLAGS =3D ''
confstr01    8  TPASS  :  confstr XBS5_ILP32_OFFBIG_LIBS =3D ''
confstr01    9  TPASS  :  confstr XBS5_ILP32_OFFBIG_LINTFLAGS =3D ''
confstr01   10  TPASS  :  confstr XBS5_LP64_OFF64_CFLAGS =3D '-m64'
confstr01   11  TPASS  :  confstr XBS5_LP64_OFF64_LDFLAGS =3D '-m64'
confstr01   12  TPASS  :  confstr XBS5_LP64_OFF64_LIBS =3D ''
confstr01   13  TPASS  :  confstr XBS5_LP64_OFF64_LINTFLAGS =3D ''
confstr01   14  TPASS  :  confstr XBS5_LPBIG_OFFBIG_CFLAGS =3D ''
confstr01   15  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LDFLAGS =3D ''
confstr01   16  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LIBS =3D ''
confstr01   17  TPASS  :  confstr XBS5_LPBIG_OFFBIG_LINTFLAGS =3D ''
confstr01   18  TPASS  :  confstr GNU_LIBC_VERSION =3D 'glibc 2.28'
confstr01   19  TPASS  :  confstr GNU_LIBPTHREAD_VERSION =3D 'NPTL 2.28'
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dcreat06 stime=3D1615253790
cmdline=3D"creat06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
creat06.c:105: TPASS: got expected failure: EISDIR (21)
creat06.c:105: TPASS: got expected failure: ENAMETOOLONG (36)
creat06.c:105: TPASS: got expected failure: ENOENT (2)
creat06.c:105: TPASS: got expected failure: ENOTDIR (20)
creat06.c:105: TPASS: got expected failure: EFAULT (14)
creat06.c:105: TPASS: got expected failure: EACCES (13)
creat06.c:105: TPASS: got expected failure: ELOOP (40)
creat06.c:105: TPASS: got expected failure: EROFS (30)

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Depoll_create1_01 stime=3D1615253790
cmdline=3D"epoll_create1_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
epoll_create1_01.c:46: TPASS: epoll_create1(EPOLL_CLOEXEC) PASSED

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Deventfd2_01 stime=3D1615253790
cmdline=3D"eventfd2_01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
eventfd2_01    1  TPASS  :  eventfd2(EFD_CLOEXEC) Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Deventfd2_02 stime=3D1615253790
cmdline=3D"eventfd2_02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
eventfd2_02    1  TPASS  :  eventfd2(EFD_NONBLOCK) PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dexecveat01 stime=3D1615253790
cmdline=3D"execveat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected
execveat_child.c:17: TPASS: execveat_child run as expected

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dexit01 stime=3D1615253790
cmdline=3D"exit01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
exit01      1  TPASS  :  exit() test PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfsetxattr01 stime=3D1615253790
cmdline=3D"fsetxattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: TINFO: Kernel supports ext2
tst_supported_fs_types.c:44: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext3
tst_supported_fs_types.c:44: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext4
tst_supported_fs_types.c:44: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports xfs
tst_supported_fs_types.c:44: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:44: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports vfat
tst_supported_fs_types.c:44: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:83: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:92: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:44: TINFO: mkfs.ntfs does exist
tst_test.c:1329: TINFO: Testing on ext2
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1329: TINFO: Testing on ext3
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1329: TINFO: Testing on ext4
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1329: TINFO: Testing on xfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EINVAL (22)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ENODATA (61)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: E2BIG (7)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EEXIST (17)
fsetxattr01.c:164: TPASS: fsetxattr(2) passed
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: ERANGE (34)
fsetxattr01.c:186: TPASS: fsetxattr(2) failed: EFAULT (14)
tst_test.c:1329: TINFO: Testing on btrfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:870: TBROK: mount(/dev/loop0, mntpoint, btrfs, 0, (nil)) failed:=
 ENOENT (2)

Summary:
passed   36
failed   0
broken   1
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D2 corefile=3Dno
cutime=3D5 cstime=3D20
<<<test_end>>>
<<<test_start>>>
tag=3Dfsetxattr02 stime=3D1615253792
cmdline=3D"fsetxattr02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsetxattr02.c:170: TPASS: fsetxattr(2) on testfile passed
fsetxattr02.c:170: TPASS: fsetxattr(2) on testdir passed
fsetxattr02.c:192: TPASS: fsetxattr(2) on symlink failed: EEXIST (17)
fsetxattr02.c:192: TPASS: fsetxattr(2) on fifo failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on chr failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on blk failed: EPERM (1)
fsetxattr02.c:192: TPASS: fsetxattr(2) on sock failed: EPERM (1)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dposix_fadvise02 stime=3D1615253792
cmdline=3D"posix_fadvise02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF
posix_fadvise02.c:59: TPASS: expected failure - returned value =3D 9 : EBADF

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfchmod04 stime=3D1615253792
cmdline=3D"fchmod04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fchmod04    1  TPASS  :  Functionality of fchmod(4, 01777) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfchown04 stime=3D1615253792
cmdline=3D"fchown04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
fchown04    0  TINFO  :  Found free device 0 '/dev/loop0'
fchown04    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
fchown04    1  TPASS  :  fchown failed as expected: TEST_ERRNO=3DEPERM(1): =
Operation not permitted
fchown04    2  TPASS  :  fchown failed as expected: TEST_ERRNO=3DEBADF(9): =
Bad file descriptor
fchown04    3  TPASS  :  fchown failed as expected: TEST_ERRNO=3DEROFS(30):=
 Read-only file system
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D3
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl01 stime=3D1615253792
cmdline=3D"fcntl01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl07 stime=3D1615253792
cmdline=3D"fcntl07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl07     1  TPASS  :  regular file CLOEXEC fd was closed after exec()
fcntl07     2  TPASS  :  pipe (write end) CLOEXEC fd was closed after exec()
fcntl07     3  TPASS  :  pipe (read end) CLOEXEC fd was closed after exec()
fcntl07     4  TPASS  :  fifo CLOEXEC fd was closed after exec()
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl07_64 stime=3D1615253792
cmdline=3D"fcntl07_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl07     1  TPASS  :  regular file CLOEXEC fd was closed after exec()
fcntl07     2  TPASS  :  pipe (write end) CLOEXEC fd was closed after exec()
fcntl07     3  TPASS  :  pipe (read end) CLOEXEC fd was closed after exec()
fcntl07     4  TPASS  :  fifo CLOEXEC fd was closed after exec()
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl10 stime=3D1615253792
cmdline=3D"fcntl10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl10     1  TPASS  :  fcntl(tfile_2829, F_SETLKW, &flocks) flocks.l_type=
 =3D F_WRLCK returned 0
fcntl10     2  TPASS  :  fcntl(tfile_2829, F_SETLKW, &flocks) flocks.l_type=
 =3D F_UNLCK returned 0
fcntl10     1  TPASS  :  fcntl(tfile_2829, F_SETLKW, &flocks) flocks.l_type=
 =3D F_RDLCK returned 0
fcntl10     2  TPASS  :  fcntl(tfile_2829, F_SETLKW, &flocks) flocks.l_type=
 =3D F_UNLCK returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl13_64 stime=3D1615253792
cmdline=3D"fcntl13_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl13     1  TPASS  :  got EINVAL
fcntl13     2  TPASS  :  F_SETLK: got EFAULT
fcntl13     3  TPASS  :  F_SETLKW: got EFAULT
fcntl13     4  TPASS  :  F_GETLK: got EFAULT
fcntl13     5  TPASS  :  got EINVAL
fcntl13     6  TPASS  :  got EBADFD
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl16 stime=3D1615253792
cmdline=3D"fcntl16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl16     0  TINFO  :  Entering block 1
fcntl16     0  TINFO  :  Test case 1: without manadatory locking PASSED
fcntl16     0  TINFO  :  Exiting block 1
fcntl16     0  TINFO  :  Entering block 2
fcntl16     0  TINFO  :  Test case 2: with mandatory record locking PASSED
fcntl16     0  TINFO  :  Exiting block 2
fcntl16     0  TINFO  :  Entering block 3
fcntl16     0  TINFO  :  Test case 3: mandatory locking with NODELAY PASSED
fcntl16     0  TINFO  :  Exiting block 3
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl23 stime=3D1615253792
cmdline=3D"fcntl23"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl23     1  TPASS  :  fcntl(tfile_2832, F_SETLEASE, F_RDLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl24_64 stime=3D1615253792
cmdline=3D"fcntl24_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl24     1  TPASS  :  fcntl(tfile_2833, F_SETLEASE, F_WRLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl25 stime=3D1615253792
cmdline=3D"fcntl25"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl25     1  TPASS  :  fcntl(tfile_2834, F_SETLEASE, F_WRLCK)
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl29 stime=3D1615253792
cmdline=3D"fcntl29"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl29     1  TPASS  :  fcntl test F_DUPFD_CLOEXEC success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl30_64 stime=3D1615253792
cmdline=3D"fcntl30_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl30     0  TINFO  :  orig_pipe_size: 65536 new_pipe_size: 131072
fcntl30     1  TPASS  :  fcntl test F_GETPIPE_SZand F_SETPIPE_SZ success
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl32 stime=3D1615253793
cmdline=3D"fcntl32"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fcntl32     1  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     2  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     3  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     4  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     5  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     6  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     7  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     8  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
fcntl32     9  TPASS  :  fcntl(F_SETLEASE, F_WRLCK) failed as expected: TES=
T_ERRNO=3DEAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl34 stime=3D1615253793
cmdline=3D"fcntl34"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fcntl34.c:90: TINFO: write to a file inside threads with OFD locks
fcntl34.c:36: TINFO: spawning '12' threads
fcntl34.c:45: TINFO: waiting for '12' threads
fcntl34.c:99: TINFO: verifying file's data
fcntl34.c:127: TPASS: OFD locks synchronized access between threads

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl38 stime=3D1615253793
cmdline=3D"fcntl38"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fcntl38.c:67: TPASS: Got event on parent as expected
fcntl38.c:71: TPASS: Got event on subdir as expected

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfcntl38_64 stime=3D1615253793
cmdline=3D"fcntl38_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fcntl38.c:67: TPASS: Got event on parent as expected
fcntl38.c:71: TPASS: Got event on subdir as expected

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfremovexattr01 stime=3D1615253793
cmdline=3D"fremovexattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: TINFO: Kernel supports ext2
tst_supported_fs_types.c:44: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext3
tst_supported_fs_types.c:44: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext4
tst_supported_fs_types.c:44: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports xfs
tst_supported_fs_types.c:44: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:44: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports vfat
tst_supported_fs_types.c:44: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:83: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:92: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:44: TINFO: mkfs.ntfs does exist
tst_test.c:1329: TINFO: Testing on ext2
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1329: TINFO: Testing on ext3
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1329: TINFO: Testing on ext4
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1329: TINFO: Testing on xfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fremovexattr01.c:66: TPASS: fremovexattr(2) removed attribute as expected
tst_test.c:1329: TINFO: Testing on btrfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:870: TBROK: mount(/dev/loop0, mntpoint, btrfs, 0, (nil)) failed:=
 ENOENT (2)

Summary:
passed   4
failed   0
broken   1
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D2 corefile=3Dno
cutime=3D5 cstime=3D22
<<<test_end>>>
<<<test_start>>>
tag=3Dfsopen01 stime=3D1615253794
cmdline=3D"fsopen01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: TINFO: Kernel supports ext2
tst_supported_fs_types.c:44: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext3
tst_supported_fs_types.c:44: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext4
tst_supported_fs_types.c:44: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports xfs
tst_supported_fs_types.c:44: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:44: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports vfat
tst_supported_fs_types.c:44: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:83: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:88: TINFO: Skipping FUSE as requested by the test
tst_test.c:1329: TINFO: Testing on ext2
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1329: TINFO: Testing on ext3
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1329: TINFO: Testing on ext4
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1329: TINFO: Testing on xfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed
tst_test.c:1329: TINFO: Testing on btrfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:42: TFAIL: fsconfig(FSCONFIG_CMD_CREATE) failed: ENOENT (2)
fsopen01.c:42: TFAIL: fsconfig(FSCONFIG_CMD_CREATE) failed: ENOENT (2)
tst_test.c:1329: TINFO: Testing on vfat
tst_test.c:859: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fsopen01.c:64: TPASS: Flag 0: fsopen() passed
fsopen01.c:64: TPASS: Flag FSOPEN_CLOEXEC: fsopen() passed

Summary:
passed   10
failed   2
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D5 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3Dfstat03_64 stime=3D1615253796
cmdline=3D"fstat03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fstat03.c:49: TPASS: fstat() fails with expected error EBADF
fstat03.c:49: TPASS: fstat() fails with expected error EFAULT

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfstatfs02 stime=3D1615253796
cmdline=3D"fstatfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
fstatfs02    1  TPASS  :  expected failure - errno =3D 9 : Bad file descrip=
tor
fstatfs02    2  TPASS  :  expected failure - errno =3D 14 : Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dftruncate03 stime=3D1615253796
cmdline=3D"ftruncate03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EINVAL (22)
ftruncate03.c:57: TPASS: ftruncate() failed expectedly: EBADF (9)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dftruncate04_64 stime=3D1615253796
cmdline=3D"ftruncate04_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ftruncate04.c:116: TINFO: Child locks file
ftruncate04.c:60: TPASS: ftruncate() offset before lock failed with EAGAIN
ftruncate04.c:60: TPASS: ftruncate() offset in lock failed with EAGAIN
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
ftruncate04.c:127: TINFO: Child unlocks file
ftruncate04.c:84: TPASS: ftruncate() offset in lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset before lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dgetcwd04 stime=3D1615253796
cmdline=3D"getcwd04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
getcwd04.c:60: TPASS: Bug is not reproduced!

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D5 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D329 cstime=3D658
<<<test_end>>>
<<<test_start>>>
tag=3Dgeteuid02_16 stime=3D1615253801
cmdline=3D"geteuid02_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
geteuid02_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: 16-bit version of geteuid() is not suppo=
rted on your platform
geteuid02_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls=
/geteuid/../utils/compat_16.h:107: Remaining cases not appropriate for conf=
iguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetgid01_16 stime=3D1615253801
cmdline=3D"getgid01_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getgid01_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getgid/../utils/compat_16.h:102: 16-bit version of getgid() is not supporte=
d on your platform
getgid01_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/=
getgid/../utils/compat_16.h:102: Remaining cases not appropriate for config=
uration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetgid03 stime=3D1615253801
cmdline=3D"getgid03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getgid03    1  TPASS  :  values from getuid and getpwuid match
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetrandom03 stime=3D1615253801
cmdline=3D"getrandom03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
getrandom03.c:37: TPASS: getrandom returned 1
getrandom03.c:37: TPASS: getrandom returned 2
getrandom03.c:37: TPASS: getrandom returned 3
getrandom03.c:37: TPASS: getrandom returned 7
getrandom03.c:37: TPASS: getrandom returned 8
getrandom03.c:37: TPASS: getrandom returned 15
getrandom03.c:37: TPASS: getrandom returned 22
getrandom03.c:37: TPASS: getrandom returned 64
getrandom03.c:37: TPASS: getrandom returned 127

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresuid01 stime=3D1615253801
cmdline=3D"getresuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid01    1  TPASS  :  Functionality of getresuid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetresuid02 stime=3D1615253801
cmdline=3D"getresuid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getresuid02    1  TPASS  :  Functionality of getresuid() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetsid02 stime=3D1615253801
cmdline=3D"getsid02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
getsid02    1  TPASS  :  expected failure - errno =3D 3 - No such process
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dgetxattr05 stime=3D1615253801
cmdline=3D"getxattr05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice
getxattr05.c:87: TPASS: Got same data when acquiring the value of system.po=
six_acl_access twice

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl01_02 stime=3D1615253801
cmdline=3D"test_ioctl"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty0
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty0

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty1
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty1

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty10
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty10

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty11
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty11

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty12
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty12

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty13
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty13

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty14
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty14

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty15
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty15

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty16
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty16

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty17
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty17

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty18
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty18

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty19
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty19

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty2
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty2

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty20
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty20

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty21
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty21

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty22
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty22

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty23
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty23

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty24
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty24

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty25
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty25

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty26
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty26

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty27
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty27

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty28
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty28

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty29
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty29

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty3
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty3

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty30
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty30

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty31
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty31

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty32
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty32

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty33
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty33

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty34
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty34

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty35
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty35

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty36
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty36

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty37
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty37

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty38
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty38

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty39
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty39

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty4
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty4

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty40
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty40

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty41
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty41

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty42
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty42

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty43
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty43

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty44
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty44

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty45
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty45

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty46
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty46

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty47
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty47

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty48
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty48

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty49
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty49

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty5
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty5

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty50
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty50

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty51
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty51

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty52
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty52

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty53
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty53

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty54
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty54

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty55
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty55

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty56
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty56

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty57
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty57

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty58
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty58

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty59
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty59

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty6
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty6

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty60
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty60

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty61
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty61

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty62
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty62

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty63
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty63

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty7
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty7

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty8
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty8

ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty9
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl01.c:71: TPASS: failed as expected: EBADF (9)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: ENOTTY (25)
ioctl01.c:71: TPASS: failed as expected: EFAULT (14)

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
ioctl01_02    1  TPASS  :  ioctl01 Passed with /dev/tty9

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty0
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty0

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty1
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty1

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty10
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty10

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty11
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty11

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty12
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty12

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty13
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty13

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty14
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty14

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty15
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty15

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty16
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty16

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty17
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty17

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty18
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty18

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty19
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty19

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty2
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty2

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty20
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty20

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty21
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty21

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty22
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty22

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty23
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty23

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty24
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty24

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty25
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty25

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty26
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty26

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty27
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty27

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty28
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty28

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty29
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty29

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty3
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty3

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty30
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty30

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty31
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty31

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty32
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty32

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty33
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty33

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty34
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty34

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty35
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty35

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty36
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty36

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty37
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty37

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty38
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty38

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty39
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty39

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty4
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty4

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty40
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty40

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty41
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty41

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty42
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty42

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty43
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty43

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty44
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty44

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty45
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty45

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty46
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty46

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty47
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty47

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty48
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty48

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty49
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty49

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty5
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty5

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty50
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty50

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty51
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty51

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty52
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty52

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty53
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty53

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty54
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty54

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty55
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty55

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty56
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty56

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty57
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty57

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty58
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty58

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty59
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty59

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty6
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty6

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty60
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty60

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty61
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty61

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty62
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty62

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty63
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty63

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty7
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty7

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty8
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty8

ioctl01_02    0  TINFO  :  Testing ioctl02 with /dev/tty9
ioctl02     0  TINFO  :  termio values are set as expected
ioctl02     1  TPASS  :  TCGETA/TCSETA tests SUCCEEDED
ioctl01_02    1  TPASS  :  ioctl02 Passed with /dev/tty9

<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D21 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl06 stime=3D1615253802
cmdline=3D"ioctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl06.c:26: TINFO: BLKRAGET original value 256
ioctl06.c:33: TPASS: BLKRASET 0 read back correctly
ioctl06.c:33: TPASS: BLKRASET 512 read back correctly
ioctl06.c:33: TPASS: BLKRASET 1024 read back correctly
ioctl06.c:33: TPASS: BLKRASET 1536 read back correctly
ioctl06.c:33: TPASS: BLKRASET 2048 read back correctly
ioctl06.c:33: TPASS: BLKRASET 2560 read back correctly
ioctl06.c:33: TPASS: BLKRASET 3072 read back correctly
ioctl06.c:33: TPASS: BLKRASET 3584 read back correctly
ioctl06.c:33: TPASS: BLKRASET 4096 read back correctly
ioctl06.c:38: TINFO: BLKRASET restoring original value 256

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dioctl_ns05 stime=3D1615253802
cmdline=3D"ioctl_ns05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioctl_ns05.c:91: TPASS: child and parent are consistent
ioctl_ns05.c:50: TPASS: child thinks its pid is 1

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dinotify09 stime=3D1615253802
cmdline=3D"inotify09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
=2E./../../../include/tst_fuzzy_sync.h:507: TINFO: Minimum sampling period =
ended
=2E./../../../include/tst_fuzzy_sync.h:331: TINFO: loop =3D 1024, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: start_a - start_b: { avg=
 =3D   -61ns, avg_dev =3D     4ns, dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - start_a  : { avg=
 =3D   918ns, avg_dev =3D    11ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_b - start_b  : { avg=
 =3D  1641ns, avg_dev =3D    18ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - end_b    : { avg=
 =3D  -785ns, avg_dev =3D    17ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: spins            : { avg=
 =3D   485  , avg_dev =3D     9  , dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:519: TINFO: Reached deviation ratios=
 < 0.10, introducing randomness
=2E./../../../include/tst_fuzzy_sync.h:522: TINFO: Delay range is [-1014, 5=
67]
=2E./../../../include/tst_fuzzy_sync.h:331: TINFO: loop =3D 1025, delay_bia=
s =3D 0
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: start_a - start_b: { avg=
 =3D   -61ns, avg_dev =3D     4ns, dev_ratio =3D 0.06 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - start_a  : { avg=
 =3D   918ns, avg_dev =3D    11ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_b - start_b  : { avg=
 =3D  1641ns, avg_dev =3D    18ns, dev_ratio =3D 0.01 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: end_a - end_b    : { avg=
 =3D  -785ns, avg_dev =3D    17ns, dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:320: TINFO: spins            : { avg=
 =3D   485  , avg_dev =3D     9  , dev_ratio =3D 0.02 }
=2E./../../../include/tst_fuzzy_sync.h:643: TINFO: Exceeded execution loops=
, requesting exit
inotify09.c:89: TPASS: kernel survived inotify beating

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D15 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1914 cstime=3D1013
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify06 stime=3D1615253817
cmdline=3D"fanotify06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fanotify06.c:155: TINFO: Test #0: Fanotify merge mount mark
fanotify06.c:133: TPASS: group 0 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:133: TPASS: group 1 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:133: TPASS: group 2 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:216: TPASS: group 3 got no event
fanotify06.c:216: TPASS: group 4 got no event
fanotify06.c:216: TPASS: group 5 got no event
fanotify06.c:216: TPASS: group 6 got no event
fanotify06.c:216: TPASS: group 7 got no event
fanotify06.c:216: TPASS: group 8 got no event
fanotify06.c:155: TINFO: Test #1: Fanotify merge overlayfs mount mark
fanotify06.c:133: TPASS: group 0 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:133: TPASS: group 1 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:133: TPASS: group 2 got event: mask 2 pid=3D3799 fd=3D13
fanotify06.c:216: TPASS: group 3 got no event
fanotify06.c:216: TPASS: group 4 got no event
fanotify06.c:216: TPASS: group 5 got no event
fanotify06.c:216: TPASS: group 6 got no event
fanotify06.c:216: TPASS: group 7 got no event
fanotify06.c:216: TPASS: group 8 got no event

Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D4
<<<test_end>>>
<<<test_start>>>
tag=3Dfanotify11 stime=3D1615253818
cmdline=3D"fanotify11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
fanotify11.c:66: TINFO: Test #0: without FAN_REPORT_TID: tgid=3D3804, tid=
=3D0, event.pid=3D0
fanotify11.c:85: TPASS: event.pid =3D=3D tgid
fanotify11.c:66: TINFO: Test #1: with FAN_REPORT_TID: tgid=3D3804, tid=3D38=
05, event.pid=3D3804
fanotify11.c:83: TPASS: event.pid =3D=3D tid

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dioprio_set01 stime=3D1615253818
cmdline=3D"ioprio_set01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ioprio_set01.c:66: TINFO: ioprio_get returned class NONE prio 4
ioprio.h:91: TPASS: ioprio_set new class BEST-EFFORT, new prio 5
ioprio.h:91: TPASS: ioprio_set new class BEST-EFFORT, new prio 3

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dio_pgetevents02 stime=3D1615253818
cmdline=3D"io_pgetevents02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
io_pgetevents02.c:57: TINFO: Testing variant: syscall with old kernel spec
io_pgetevents02.c:118: TPASS: invalid ctx: io_pgetevents() failed as expect=
ed: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid min_nr: io_pgetevents() failed as exp=
ected: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid max_nr: io_pgetevents() failed as exp=
ected: EINVAL (22)
io_pgetevents02.c:118: TPASS: invalid events: io_pgetevents() failed as exp=
ected: EFAULT (14)
io_pgetevents02.c:118: TPASS: invalid timeout: io_pgetevents() failed as ex=
pected: EFAULT (14)
io_pgetevents02.c:118: TPASS: invalid sigmask: io_pgetevents() failed as ex=
pected: EFAULT (14)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dkeyctl05 stime=3D1615253818
cmdline=3D"keyctl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
keyctl05.c:123: TINFO: Try to update the 'asymmetric' key...
keyctl05.c:136: TPASS: updating 'asymmetric' key expectedly failed with EOP=
NOTSUPP
keyctl05.c:92: TCONF: kernel doesn't support key type 'dns_resolver'
keyctl05.c:171: TINFO: Try to update the 'user' key...
keyctl05.c:180: TPASS: didn't crash while racing to update 'user' key

Summary:
passed   2
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dkill02 stime=3D1615253818
cmdline=3D"kill02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
kill02      1  TPASS  :  The signal was sent to all processes in the proces=
s group.
kill02      2  TPASS  :  The signal was not sent to selective processes tha=
t were not in the process group.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D10 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dkill03 stime=3D1615253828
cmdline=3D"kill03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
kill03.c:41: TPASS: kill failed as expected: EINVAL (22)
kill03.c:41: TPASS: kill failed as expected: ESRCH (3)
kill03.c:41: TPASS: kill failed as expected: ESRCH (3)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlchown03 stime=3D1615253828
cmdline=3D"lchown03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mke2fs 1.44.5 (15-Dec-2018)
lchown03    0  TINFO  :  Found free device 0 '/dev/loop0'
lchown03    0  TINFO  :  Formatting /dev/loop0 with ext2 opts=3D'' extra op=
ts=3D''
lchown03    1  TPASS  :  lchown() failed as expected: TEST_ERRNO=3DELOOP(40=
): Too many levels of symbolic links
lchown03    2  TPASS  :  lchown() failed as expected: TEST_ERRNO=3DEROFS(30=
): Read-only file system
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dlistxattr03 stime=3D1615253828
cmdline=3D"listxattr03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
listxattr03.c:54: TPASS: listxattr() succeed with suitable buffer
listxattr03.c:54: TPASS: listxattr() succeed with suitable buffer

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dllseek03 stime=3D1615253828
cmdline=3D"llseek03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
llseek03.c:96: TPASS: llseek returned 1
llseek03.c:115: TPASS: SEEK_SET for llseek
llseek03.c:96: TPASS: llseek returned 5
llseek03.c:115: TPASS: SEEK_CUR for llseek
llseek03.c:96: TPASS: llseek returned 7
llseek03.c:115: TPASS: SEEK_END for llseek
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_SET read returned 0
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_CUR read returned 0
llseek03.c:96: TPASS: llseek returned 8
llseek03.c:107: TPASS: SEEK_END read returned 0
llseek03.c:96: TPASS: llseek returned 10
llseek03.c:107: TPASS: SEEK_SET read returned 0
llseek03.c:96: TPASS: llseek returned 12
llseek03.c:107: TPASS: SEEK_CUR read returned 0
llseek03.c:96: TPASS: llseek returned 12
llseek03.c:107: TPASS: SEEK_END read returned 0

Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dlseek02 stime=3D1615253828
cmdline=3D"lseek02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
lseek02.c:65: TPASS: lseek(-1, 1, 0) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(-1, 1, 1) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(-1, 1, 2) failed as expected: EBADF (9)
lseek02.c:65: TPASS: lseek(4, 1, 5) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(4, 1, -1) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(4, 1, 7) failed as expected: EINVAL (22)
lseek02.c:65: TPASS: lseek(5, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(5, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(5, 1, 2) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(6, 1, 2) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 0) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 1) failed as expected: ESPIPE (29)
lseek02.c:65: TPASS: lseek(8, 1, 2) failed as expected: ESPIPE (29)

Summary:
passed   15
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmigrate_pages01 stime=3D1615253828
cmdline=3D"migrate_pages01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
migrate_pages01    0  TINFO  :  test_empty_mask
migrate_pages01    1  TPASS  :  expected ret success: returned value =3D 0
migrate_pages01    0  TINFO  :  test_invalid_pid -1
migrate_pages01    2  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    3  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): No=
 such process
migrate_pages01    0  TINFO  :  test_invalid_pid unused pid
migrate_pages01    4  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    5  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): No=
 such process
migrate_pages01    0  TINFO  :  test_invalid_masksize
migrate_pages01    6  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22): =
Invalid argument
migrate_pages01    0  TINFO  :  test_invalid_mem -1
migrate_pages01    8  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01    9  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_mem invalid prot
migrate_pages01   10  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   11  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_mem unmmaped
migrate_pages01   12  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   13  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): =
Bad address
migrate_pages01    0  TINFO  :  test_invalid_nodes
migrate_pages01   14  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   15  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22): =
Invalid argument
migrate_pages01    0  TINFO  :  test_invalid_perm
migrate_pages01   16  TPASS  :  expected ret success: returned value =3D -1
migrate_pages01   17  TPASS  :  expected failure: TEST_ERRNO=3DEPERM(1): Op=
eration not permitted
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmkdirat01 stime=3D1615253828
cmdline=3D"mkdirat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mkdirat01    1  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    2  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    3  TPASS  :  mkdirat() returned 0: TEST_ERRNO=3DSUCCESS(0): Su=
ccess
mkdirat01    4  TPASS  :  mkdirat() returned -1: TEST_ERRNO=3DENOTDIR(20): =
Not a directory
mkdirat01    5  TPASS  :  mkdirat() returned -1: TEST_ERRNO=3DEBADF(9): Bad=
 file descriptor
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmlock01 stime=3D1615253828
cmdline=3D"mlock01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mlock01     1  TPASS  :  mlock passed
mlock01     2  TPASS  :  mlock passed
mlock01     3  TPASS  :  mlock passed
mlock01     4  TPASS  :  mlock passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmove_pages04 stime=3D1615253828
cmdline=3D"move_pages04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
move_pages04    1  TCONF  :  move_pages_support.c:407: at least 2 allowed N=
UMA nodes are required
move_pages04    2  TCONF  :  move_pages_support.c:407: Remaining cases not =
appropriate for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpkey01 stime=3D1615253828
cmdline=3D"pkey01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_hugepage.c:58: TINFO: 1 hugepage(s) reserved
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pkey.h:48: TCONF: pku is not supported on this CPU

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D5
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_notify01 stime=3D1615253828
cmdline=3D"mq_notify01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
/tmp/lkp/ltp/src/ltp/testcases/kernel/syscalls/mq_notify/../utils/mq.h:70: =
TINFO: receive 1/1 message
mq_notify01.c:198: TPASS: mq_notify and mq_timedsend exited expectedly
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBADF (9)
mq_notify01.c:146: TPASS: mq_notify failed expectedly: EBUSY (16)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmq_notify02 stime=3D1615253828
cmdline=3D"mq_notify02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mq_notify02    1  TPASS  :  mq_notify failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
mq_notify02    2  TPASS  :  mq_notify failed as expected: TEST_ERRNO=3DEINV=
AL(22): Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmremap01 stime=3D1615253828
cmdline=3D"mremap01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
mremap01    1  TPASS  :  Functionality of mremap() is correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgget02 stime=3D1615253828
cmdline=3D"msgget02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
msgget02.c:57: TPASS: msgget() failed as expected: EEXIST (17)
msgget02.c:57: TPASS: msgget() failed as expected: ENOENT (2)
msgget02.c:57: TPASS: msgget() failed as expected: ENOENT (2)
msgget02.c:57: TPASS: msgget() failed as expected: EACCES (13)
msgget02.c:57: TPASS: msgget() failed as expected: EACCES (13)
msgget02.c:57: TPASS: msgget() failed as expected: EACCES (13)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsgrcv02 stime=3D1615253828
cmdline=3D"msgrcv02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
msgrcv02.c:69: TPASS: msgrcv() failed as expected: E2BIG (7)
msgrcv02.c:69: TPASS: msgrcv() failed as expected: EACCES (13)
msgrcv02.c:69: TPASS: msgrcv() failed as expected: EFAULT (14)
msgrcv02.c:69: TPASS: msgrcv() failed as expected: EINVAL (22)
msgrcv02.c:69: TPASS: msgrcv() failed as expected: EINVAL (22)
msgrcv02.c:69: TPASS: msgrcv() failed as expected: ENOMSG (42)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmsync01 stime=3D1615253828
cmdline=3D"msync01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
msync01     1  TPASS  :  Functionality of msync() successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dname_to_handle_at01 stime=3D1615253828
cmdline=3D"name_to_handle_at01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
tst_buffers.c:55: TINFO: Test is using guarded buffers
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (0)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (1)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (2)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (3)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (4)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (5)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (6)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (7)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (8)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (9)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (10)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (11)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (12)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (13)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (14)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (15)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (16)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (17)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (18)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (19)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (20)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (21)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (22)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (23)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (24)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (25)
name_to_handle_at01.c:103: TPASS: name_to_handle_at() passed (26)

Summary:
passed   27
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen02 stime=3D1615253828
cmdline=3D"open02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
open02.c:53: TPASS: open() new file without O_CREAT: ENOENT (2)
open02.c:53: TPASS: open() unpriviledget O_RDONLY | O_NOATIME: EPERM (1)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen03 stime=3D1615253828
cmdline=3D"open03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open03      1  TPASS  :  open(tfile_3900, O_RDWR|O_CREAT,0700) returned 4
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dopen14 stime=3D1615253828
cmdline=3D"open14"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open14      0  TINFO  :  creating a file with O_TMPFILE flag
open14      0  TINFO  :  writing data to the file
open14      0  TINFO  :  file size is '4096'
open14      0  TINFO  :  looking for the file in '.'
open14      0  TINFO  :  file not found, OK
open14      0  TINFO  :  renaming '/fs/sda1/tmpdir/ltp-rUT0eB0OZ3/opeQmLa7B=
/#537178209 (deleted)' -> 'tmpfile'
open14      0  TINFO  :  found a file: tmpfile
open14      1  TPASS  :  single file tests passed
open14      0  TINFO  :  create files in multiple directories
open14      0  TINFO  :  removing test directories
open14      0  TINFO  :  writing/reading temporary files
open14      0  TINFO  :  closing temporary files
open14      2  TPASS  :  multiple files tests passed
open14      0  TINFO  :  create multiple directories, link files into them
open14      0  TINFO  :  and check file permissions
open14      0  TINFO  :  remove files, directories
open14      3  TPASS  :  file permission tests passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dopenat01 stime=3D1615253829
cmdline=3D"openat01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
openat01    1  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
openat01    2  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
openat01    3  TPASS  :  openat() returned -1: TEST_ERRNO=3DENOTDIR(20): No=
t a directory
openat01    4  TPASS  :  openat() returned -1: TEST_ERRNO=3DEBADF(9): Bad f=
ile descriptor
openat01    5  TPASS  :  openat() returned -1: TEST_ERRNO=3DSUCCESS(0): Suc=
cess
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmincore03 stime=3D1615253829
cmdline=3D"mincore03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
mincore03.c:66: TPASS: mincore() reports untouched pages are not resident
mincore03.c:66: TPASS: mincore() reports locked pages are resident

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmincore04 stime=3D1615253829
cmdline=3D"mincore04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
mincore04.c:100: TPASS: mincore reports all 3 pages locked by child process=
 are resident

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dmadvise01 stime=3D1615253829
cmdline=3D"madvise01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
madvise01.c:112: TPASS: madvise test for MADV_NORMAL PASSED
madvise01.c:112: TPASS: madvise test for MADV_RANDOM PASSED
madvise01.c:112: TPASS: madvise test for MADV_SEQUENTIAL PASSED
madvise01.c:112: TPASS: madvise test for MADV_WILLNEED PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTNEED PASSED
madvise01.c:112: TPASS: madvise test for MADV_REMOVE PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_DOFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_HWPOISON PASSED
madvise01.c:112: TPASS: madvise test for MADV_MERGEABLE PASSED
madvise01.c:112: TPASS: madvise test for MADV_UNMERGEABLE PASSED
madvise01.c:112: TPASS: madvise test for MADV_HUGEPAGE PASSED
madvise01.c:112: TPASS: madvise test for MADV_NOHUGEPAGE PASSED
madvise01.c:112: TPASS: madvise test for MADV_DONTDUMP PASSED
madvise01.c:112: TPASS: madvise test for MADV_DODUMP PASSED
madvise01.c:112: TPASS: madvise test for MADV_FREE PASSED
madvise01.c:112: TPASS: madvise test for MADV_WIPEONFORK PASSED
madvise01.c:112: TPASS: madvise test for MADV_KEEPONFORK PASSED

Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D17
<<<test_end>>>
<<<test_start>>>
tag=3Dmadvise06 stime=3D1615253829
cmdline=3D"madvise06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
madvise06.c:106: TINFO: dropping caches
madvise06.c:117: TCONF: System swap is too small (838860800 bytes needed)

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D5
<<<test_end>>>
<<<test_start>>>
tag=3Dpause02 stime=3D1615253829
cmdline=3D"pause02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pause02     1  TPASS  :  pause was interrupted correctly
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpidfd_open02 stime=3D1615253829
cmdline=3D"pidfd_open02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pidfd_open02.c:50: TPASS: expired pid: pidfd_open() failed as expected: ESR=
CH (3)
pidfd_open02.c:50: TPASS: invalid pid: pidfd_open() failed as expected: EIN=
VAL (22)
pidfd_open02.c:50: TPASS: invalid flags: pidfd_open() failed as expected: E=
INVAL (22)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe08 stime=3D1615253829
cmdline=3D"pipe08"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pipe08      1  TPASS  :  got expected SIGPIPE signal
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe09 stime=3D1615253829
cmdline=3D"pipe09"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pipe09      1  TPASS  :  functionality appears to be correct
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpipe2_04 stime=3D1615253829
cmdline=3D"pipe2_04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pipe2_04.c:37: TPASS: write failed as expected: EAGAIN/EWOULDBLOCK (11)
pipe2_04.c:53: TPASS: Child process is blocked

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpreadv202 stime=3D1615253829
cmdline=3D"preadv202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
preadv202.c:82: TPASS: preadv2() failed as expected: EINVAL (22)
preadv202.c:82: TPASS: preadv2() failed as expected: EINVAL (22)
preadv202.c:82: TPASS: preadv2() failed as expected: EOPNOTSUPP (95)
preadv202.c:82: TPASS: preadv2() failed as expected: EFAULT (14)
preadv202.c:82: TPASS: preadv2() failed as expected: EBADF (9)
preadv202.c:82: TPASS: preadv2() failed as expected: EBADF (9)
preadv202.c:82: TPASS: preadv2() failed as expected: EISDIR (21)
preadv202.c:82: TPASS: preadv2() failed as expected: ESPIPE (29)

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dprocess_vm_readv01 stime=3D1615253829
cmdline=3D"process_vm01 -r"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
process_vm_readv    0  TINFO  :  test_sane_params
process_vm_readv    1  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_flags, flags=3D-2147483647
process_vm_readv    2  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    3  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D-1
process_vm_readv    4  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    5  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D1
process_vm_readv    6  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D2147483647
process_vm_readv    8  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    9  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D0
process_vm_readv   10  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_iov_len_overflow
process_vm_readv   11  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   12  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec->iov_base
process_vm_readv   13  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   14  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec->iov_base
process_vm_readv   15  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   16  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec
process_vm_readv   17  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   18  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec
process_vm_readv   19  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   20  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_pid
process_vm_readv   21  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   22  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv   23  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   24  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv    0  TINFO  :  test_invalid_perm
process_vm_readv   25  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   26  TPASS  :  expected failure: TEST_ERRNO=3DEPERM(1): O=
peration not permitted
process_vm_readv    0  TINFO  :  test_sane_params
process_vm_readv    1  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_flags, flags=3D-2147483647
process_vm_readv    2  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    3  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D-1
process_vm_readv    4  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    5  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D1
process_vm_readv    6  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    7  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D2147483647
process_vm_readv    8  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv    9  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_flags, flags=3D0
process_vm_readv   10  TPASS  :  expected ret success - returned value =3D =
4096
process_vm_readv    0  TINFO  :  test_iov_len_overflow
process_vm_readv   11  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   12  TPASS  :  expected failure: TEST_ERRNO=3DEINVAL(22):=
 Invalid argument
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec->iov_base
process_vm_readv   13  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   14  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec->iov_base
process_vm_readv   15  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   16  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - lvec
process_vm_readv   17  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   18  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_iov_invalid - rvec
process_vm_readv   19  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   20  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_pid
process_vm_readv   21  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   22  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv   23  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   24  TPASS  :  expected failure: TEST_ERRNO=3DESRCH(3): N=
o such process
process_vm_readv    0  TINFO  :  test_invalid_perm
process_vm_readv    0  TINFO  :  test_invalid_protection lvec
process_vm_readv   25  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   26  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
process_vm_readv    0  TINFO  :  test_invalid_protection rvec
process_vm_readv   27  TPASS  :  expected ret success - returned value =3D =
-1
process_vm_readv   28  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14):=
 Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpselect03_64 stime=3D1615253829
cmdline=3D"pselect03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pselect03.c:31: TPASS: pselect() succeeded retval=3D0

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace03 stime=3D1615253829
cmdline=3D"ptrace03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ptrace03.c:43: TINFO: Trace a process which does not exist
ptrace03.c:56: TPASS: ptrace() failed as expected: ESRCH (3)
ptrace03.c:43: TINFO: Trace a process which is already been traced
ptrace03.c:56: TPASS: ptrace() failed as expected: EPERM (1)

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dptrace11 stime=3D1615253829
cmdline=3D"ptrace11"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
ptrace11.c:28: TPASS: ptrace() traces init process successfully

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwrite03 stime=3D1615253829
cmdline=3D"pwrite03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwrite03.c:25: TPASS: pwrite(fd, NULL, 0) =3D=3D 0

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwrite04_64 stime=3D1615253829
cmdline=3D"pwrite04_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
pwrite04    1  TPASS  :  O_APPEND test passed.
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev02_64 stime=3D1615253829
cmdline=3D"pwritev02_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EINVAL (22)
pwritev02.c:84: TPASS: pwritev() failed as expected: EFAULT (14)
pwritev02.c:84: TPASS: pwritev() failed as expected: EBADF (9)
pwritev02.c:84: TPASS: pwritev() failed as expected: EBADF (9)
pwritev02.c:84: TPASS: pwritev() failed as expected: ESPIPE (29)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev03 stime=3D1615253829
cmdline=3D"pwritev03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: TINFO: Kernel supports ext2
tst_supported_fs_types.c:44: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext3
tst_supported_fs_types.c:44: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports ext4
tst_supported_fs_types.c:44: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports xfs
tst_supported_fs_types.c:44: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:44: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: TINFO: Kernel supports vfat
tst_supported_fs_types.c:44: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:83: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:92: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:44: TINFO: mkfs.ntfs does exist
tst_test.c:1329: TINFO: Testing on ext2
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext2 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1329: TINFO: Testing on ext3
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext3 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1329: TINFO: Testing on ext4
tst_test.c:859: TINFO: Formatting /dev/loop0 with ext4 opts=3D'' extra opts=
=3D''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1329: TINFO: Testing on xfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev03.c:101: TINFO: Using block size 512
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
pwritev03.c:87: TPASS: pwritev(O_DIRECT) wrote 512 bytes successfully with =
content 'a' expectedly=20
tst_test.c:1329: TINFO: Testing on btrfs
tst_test.c:859: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extra opt=
s=3D''
tst_test.c:870: TBROK: mount(/dev/loop0, mntpoint, btrfs, 0, (nil)) failed:=
 ENOENT (2)

Summary:
passed   12
failed   0
broken   1
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D2 corefile=3Dno
cutime=3D6 cstime=3D17
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev201_64 stime=3D1615253831
cmdline=3D"pwritev201_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content=
 'a' expectedly=20

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dpwritev202 stime=3D1615253831
cmdline=3D"pwritev202"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
pwritev202.c:78: TPASS: pwritev2() failed as expected: EINVAL (22)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EINVAL (22)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EOPNOTSUPP (95)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EFAULT (14)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EBADF (9)
pwritev202.c:78: TPASS: pwritev2() failed as expected: EBADF (9)
pwritev202.c:78: TPASS: pwritev2() failed as expected: ESPIPE (29)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dquotactl05 stime=3D1615253831
cmdline=3D"quotactl05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_kconfig.c:63: TINFO: Parsing kernel config '/proc/config.gz'
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:859: TINFO: Formatting /dev/loop0 with xfs opts=3D'' extra opts=
=3D''
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
quotactl05.c:73: TINFO: Test #0: QCMD(Q_XGETQSTAT, PRJQUOTA) off
quotactl02.h:68: TPASS: quotactl() succeeded to turn off xfs quota and get =
xfs quota off status for project
quotactl05.c:73: TINFO: Test #1: QCMD(Q_XGETQSTAT, PRJQUOTA) on
quotactl02.h:88: TPASS: quotactl() succeeded to turn on xfs quota and get x=
fs quota on status for project
quotactl05.c:73: TINFO: Test #2: QCMD(Q_XGETQUOTA, PRJQUOTA) qlim
quotactl02.h:162: TPASS: quotactl() succeeded to set and use Q_XGETQUOTA fo=
r project to get xfs disk quota limits
quotactl05.c:73: TINFO: Test #3: QCMD(Q_XGETNEXTQUOTA, PRJQUOTA)
quotactl02.h:162: TPASS: quotactl() succeeded to set and use Q_XGETNEXTQUOT=
A for project to get xfs disk quota limits
quotactl05.c:73: TINFO: Test #4: QCMD(Q_XGETQSTATV, PRJQUOTA) off
quotactl02.h:110: TPASS: quotactl() succeeded to turn off xfs quota and get=
 xfs quota off statv for project
quotactl05.c:73: TINFO: Test #5: QCMD(Q_XGETQSTATV, PRJQUOTA) on
quotactl02.h:132: TPASS: quotactl() succeeded to turn on xfs quota and get =
xfs quota on statv for project

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D5
<<<test_end>>>
<<<test_start>>>
tag=3Dread01 stime=3D1615253832
cmdline=3D"read01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
read01.c:24: TPASS: read(2) returned 512

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreadlinkat02 stime=3D1615253832
cmdline=3D"readlinkat02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
readlinkat02    1  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEI=
NVAL(22): Invalid argument
readlinkat02    2  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEI=
NVAL(22): Invalid argument
readlinkat02    3  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEN=
OTDIR(20): Not a directory
readlinkat02    4  TPASS  :  readlinkat failed as expected: TEST_ERRNO=3DEN=
OTDIR(20): Not a directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreadv03 stime=3D1615253832
cmdline=3D"readv03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
readv03     1  TPASS  :  got EISDIR
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dreboot01 stime=3D1615253832
cmdline=3D"reboot01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
reboot01    1  TPASS  :  reboot(2) Passed for option LINUX_REBOOT_CMD_CAD_ON
reboot01    2  TPASS  :  reboot(2) Passed for option LINUX_REBOOT_CMD_CAD_O=
FF
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dremovexattr01 stime=3D1615253832
cmdline=3D"removexattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
removexattr01    1  TPASS  :  removexattr() succeeded
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drename07 stime=3D1615253832
cmdline=3D"rename07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
rename07    1  TPASS  :  rename() returned ENOTDIR
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drequest_key02 stime=3D1615253832
cmdline=3D"request_key02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
request_key02.c:53: TPASS: request_key() failed expectly: ENOKEY (126)
request_key02.c:53: TPASS: request_key() failed expectly: EKEYREVOKED (128)
request_key02.c:53: TPASS: request_key() failed expectly: EKEYEXPIRED (127)

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Drt_sigsuspend01 stime=3D1615253834
cmdline=3D"rt_sigsuspend01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
rt_sigsuspend01.c:49: TPASS: rt_sigsuspend() returned with -1 and EINTR
rt_sigsuspend01.c:58: TPASS: signal mask preserved

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_get_priority_min01 stime=3D1615253835
cmdline=3D"sched_get_priority_min01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_get_priority_min01    1  TPASS  :  Test for SCHED_OTHER Passed
sched_get_priority_min01    2  TPASS  :  Test for SCHED_FIFO Passed
sched_get_priority_min01    3  TPASS  :  Test for SCHED_RR Passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_setparam01 stime=3D1615253835
cmdline=3D"sched_setparam01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_setparam01    1  TPASS  :  sched_setparam() returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsched_getattr01 stime=3D1615253835
cmdline=3D"sched_getattr01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sched_getattr01    1  TPASS  :  attributes were read back correctly
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemctl06 stime=3D1615253835
cmdline=3D"semctl06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
semctl06    1  TPASS  :  semctl06 ran successfully!
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsemget03 stime=3D1615253835
cmdline=3D"semget03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
semget03    1  TPASS  :  expected failure - errno =3D 2 : No such file or d=
irectory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsemop02 stime=3D1615253835
cmdline=3D"semop02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
semop02.c:78: TINFO: Testing variant: semop: syscall
semop02.c:148: TPASS: semop failed as expected: E2BIG (7)
semop02.c:148: TPASS: semop failed as expected: EACCES (13)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: ERANGE (34)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:123: TCONF: Test not supported for variant
semop02.c:123: TCONF: Test not supported for variant
semop02.c:123: TCONF: Test not supported for variant
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
semop02.c:78: TINFO: Testing variant: semtimedop: syscall with old kernel s=
pec
semop02.c:148: TPASS: semop failed as expected: E2BIG (7)
semop02.c:148: TPASS: semop failed as expected: EACCES (13)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: EINVAL (22)
semop02.c:148: TPASS: semop failed as expected: ERANGE (34)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EFBIG (27)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EAGAIN/EWOULDBLOCK (11)
semop02.c:148: TPASS: semop failed as expected: EFAULT (14)

Summary:
passed   23
failed   0
broken   0
skipped  3
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsend01 stime=3D1615253835
cmdline=3D"send01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
send01      1  TPASS  :  bad file descriptor successful
send01      2  TPASS  :  invalid socket successful
send01      3  TPASS  :  invalid send buffer successful
send01      4  TPASS  :  UDP message too big successful
send01      5  TPASS  :  local endpoint shutdown successful
send01      6  TPASS  :  invalid flags set successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile03_64 stime=3D1615253835
cmdline=3D"sendfile03_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile03_64    1  TPASS  :  sendfile() returned 9 : Bad file descriptor
sendfile03_64    2  TPASS  :  sendfile() returned 9 : Bad file descriptor
sendfile03_64    3  TPASS  :  sendfile() returned 9 : Bad file descriptor
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile04 stime=3D1615253835
cmdline=3D"sendfile04"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile04    1  TPASS  :  sendfile() returned 14 : Bad address
sendfile04    2  TPASS  :  sendfile() returned 14 : Bad address
sendfile04    3  TPASS  :  sendfile() returned 14 : Bad address
sendfile04    4  TPASS  :  sendfile() returned 14 : Bad address
sendfile04    5  TPASS  :  sendfile() returned 14 : Bad address
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsendfile07_64 stime=3D1615253835
cmdline=3D"sendfile07_64"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendfile07_64    1  TPASS  :  sendfile() returned 11 : Resource temporarily=
 unavailable
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsendmsg01 stime=3D1615253835
cmdline=3D"sendmsg01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sendmsg01    1  TPASS  :  bad file descriptor successful
sendmsg01    2  TPASS  :  invalid socket successful
sendmsg01    3  TPASS  :  invalid send buffer successful
sendmsg01    4  TPASS  :  connected TCP successful
sendmsg01    5  TPASS  :  not connected TCP successful
sendmsg01    6  TPASS  :  invalid to buffer length successful
sendmsg01    7  TPASS  :  invalid to buffer successful
sendmsg01    8  TPASS  :  UDP message too big successful
sendmsg01    9  TPASS  :  local endpoint shutdown successful
sendmsg01   10  TPASS  :  invalid iovec pointer successful
sendmsg01   11  TPASS  :  invalid msghdr pointer successful
sendmsg01   12  TPASS  :  rights passing successful
sendmsg01   13  TPASS  :  invalid flags set successful
sendmsg01   14  TPASS  :  invalid cmsg length successful
sendmsg01   15  TPASS  :  invalid cmsg pointer successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dset_mempolicy02 stime=3D1615253835
cmdline=3D"set_mempolicy02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
tst_numa.c:191: TINFO: Found 1 NUMA memory nodes
set_mempolicy02.c:39: TCONF: Test requires at least two NUMA memory nodes

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dset_tid_address01 stime=3D1615253835
cmdline=3D"set_tid_address01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
set_tid_address01    1  TPASS  :  set_tid_address call succeeded:  as expec=
ted 4112
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetdomainname01 stime=3D1615253835
cmdline=3D"setdomainname01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:36: TINFO: Testing libc setdomainname()
setdomainname01.c:26: TPASS: setdomainname() succeed
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
setdomainname.h:39: TINFO: Testing __NR_setdomainname syscall
setdomainname01.c:26: TPASS: setdomainname() succeed

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetfsuid01 stime=3D1615253835
cmdline=3D"setfsuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setfsuid01    1  TPASS  :  setfsuid() returned expected value : 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsgetmask01 stime=3D1615253835
cmdline=3D"sgetmask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sgetmask01    1  TCONF  :  sgetmask01.c:128: syscall(-1) __NR_ssetmask not =
supported on your arch
sgetmask01    2  TCONF  :  sgetmask01.c:128: Remaining cases not appropriat=
e for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetgroups04_16 stime=3D1615253835
cmdline=3D"setgroups04_16"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setgroups04_16    1  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setgroups/../utils/compat_16.h:77: 16-bit version of setgroups() is not =
supported on your platform
setgroups04_16    2  TCONF  :  /tmp/lkp/ltp/src/ltp/testcases/kernel/syscal=
ls/setgroups/../utils/compat_16.h:77: Remaining cases not appropriate for c=
onfiguration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetitimer03 stime=3D1615253835
cmdline=3D"setitimer03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setitimer03    1  TPASS  :  expected failure - errno =3D 22 - Invalid argum=
ent
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetpgrp01 stime=3D1615253835
cmdline=3D"setpgrp01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setpgrp01    1  TPASS  :  setpgrp -  Call the setpgrp system call returned 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetpriority01 stime=3D1615253835
cmdline=3D"setpriority01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
setpriority01.c:75: TPASS: setpriority(PRIO_PROCESS(0), 4130, -20..19) succ=
eeded
setpriority01.c:75: TPASS: setpriority(PRIO_PGRP(1), 4131, -20..19) succeed=
ed
setpriority01.c:75: TPASS: setpriority(PRIO_USER(2), 1091, -20..19) succeed=
ed
userdel: ltp_setpriority01 mail spool (/var/mail/ltp_setpriority01) not fou=
nd
userdel: ltp_setpriority01 home directory (/home/ltp_setpriority01) not fou=
nd

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsetregid01 stime=3D1615253835
cmdline=3D"setregid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
setregid01.c:49: TPASS: Dont change either real or effective gid
setregid01.c:49: TPASS: Change effective to effective gid
setregid01.c:49: TPASS: Change real to real gid
setregid01.c:49: TPASS: Change effective to real gid
setregid01.c:49: TPASS: Try to change real to current real

Summary:
passed   5
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetreuid07 stime=3D1615253835
cmdline=3D"setreuid07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open failed with EACCES as expected
open failed with EACCES as expected
open call succeeded
setreuid07    0  TINFO  :  Child process returned TPASS
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsetuid01 stime=3D1615253835
cmdline=3D"setuid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
setuid01.c:30: TPASS: setuid(0) successfully

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmctl07 stime=3D1615253835
cmdline=3D"shmctl07"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
shmctl07.c:31: TPASS: shmctl(1, SHM_LOCK, NULL)
shmctl07.c:37: TPASS: SMH_LOCKED bit is on in shm_perm.mode
shmctl07.c:46: TPASS: shmctl(1, SHM_UNLOCK, NULL)
shmctl07.c:53: TPASS: SHM_LOCKED bit is off in shm_perm.mode

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dshmget02 stime=3D1615253835
cmdline=3D"shmget02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
shmget02    1  TPASS  :  expected failure - errno =3D 22 : Invalid argument
shmget02    2  TPASS  :  expected failure - errno =3D 22 : Invalid argument
shmget02    3  TPASS  :  expected failure - errno =3D 17 : File exists
shmget02    4  TPASS  :  expected failure - errno =3D 2 : No such file or d=
irectory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsignal02 stime=3D1615253835
cmdline=3D"signal02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
signal02    1  TPASS  :  expected failure - errno =3D 22 - Invalid argument
signal02    2  TPASS  :  expected failure - errno =3D 22 - Invalid argument
signal02    3  TPASS  :  expected failure - errno =3D 22 - Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dsplice03 stime=3D1615253835
cmdline=3D"splice03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EBADF (9)
splice03.c:99: TPASS: splice() failed as expected: EINVAL (22)
splice03.c:99: TPASS: splice() failed as expected: EINVAL (22)
splice03.c:99: TPASS: splice() failed as expected: ESPIPE (29)
splice03.c:99: TPASS: splice() failed as expected: ESPIPE (29)

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dssetmask01 stime=3D1615253835
cmdline=3D"ssetmask01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
ssetmask01    1  TCONF  :  ssetmask01.c:115: syscall(-1) __NR_ssetmask not =
supported on your arch
ssetmask01    2  TCONF  :  ssetmask01.c:115: Remaining cases not appropriat=
e for configuration
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dstatfs02 stime=3D1615253835
cmdline=3D"statfs02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
statfs02    1  TPASS  :  expected failure: TEST_ERRNO=3DENOTDIR(20): Not a =
directory
statfs02    2  TPASS  :  expected failure: TEST_ERRNO=3DENOENT(2): No such =
file or directory
statfs02    3  TPASS  :  expected failure: TEST_ERRNO=3DENAMETOOLONG(36): F=
ile name too long
statfs02    4  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): Bad add=
ress
statfs02    5  TPASS  :  expected failure: TEST_ERRNO=3DEFAULT(14): Bad add=
ress
statfs02    6  TPASS  :  expected failure: TEST_ERRNO=3DELOOP(40): Too many=
 levels of symbolic links
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dswapoff01 stime=3D1615253835
cmdline=3D"swapoff01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_ioctl.c:30: TINFO: FIBMAP ioctl is supported
swapoff01    1  TPASS  :  Succeeded to turn off swapfile
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D3 cstime=3D8
<<<test_end>>>
<<<test_start>>>
tag=3Dswitch01 stime=3D1615253836
cmdline=3D"endian_switch01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:881: TCONF: This system does not support running of switch() sys=
call
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D32 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsymlink02 stime=3D1615253836
cmdline=3D"symlink02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsymlink05 stime=3D1615253836
cmdline=3D"symlink05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
symlink05    1  TPASS  :  symlink(testfile, slink_file) functionality succe=
ssful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsysinfo02 stime=3D1615253836
cmdline=3D"sysinfo02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
sysinfo02    1  TPASS  :  Test to check the error code 14 PASSED
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog02 stime=3D1615253836
cmdline=3D"syslog02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog02    0  TINFO  :  Test if messages of all levels are logged.
syslog02    0  TINFO  :  For each level, a separate configuration file is
syslog02    0  TINFO  :  created and that will be used as syslog.conf file.
syslog02    0  TINFO  :  testing whether messages are logged into log file
syslog02    0  TINFO  :  Doing level: emerg...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    1  TPASS  :  ***** Level emerg passed *****
syslog02    0  TINFO  :  Doing level: alert...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    2  TPASS  :  ***** Level alert passed *****
syslog02    0  TINFO  :  Doing level: crit...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    3  TPASS  :  ***** Level crit passed *****
syslog02    0  TINFO  :  Doing level: err...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    4  TPASS  :  ***** Level err passed *****
syslog02    0  TINFO  :  Doing level: warning...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    5  TPASS  :  ***** Level warning passed *****
syslog02    0  TINFO  :  Doing level: notice...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    6  TPASS  :  ***** Level notice passed *****
syslog02    0  TINFO  :  Doing level: info...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    7  TPASS  :  ***** Level info passed *****
syslog02    0  TINFO  :  Doing level: debug...
syslog02    0  TINFO  :  restarting syslog daemon
syslog02    8  TPASS  :  ***** Level debug passed *****
syslog02    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D36 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D5 cstime=3D6
<<<test_end>>>
<<<test_start>>>
tag=3Dsyslog10 stime=3D1615253872
cmdline=3D"syslog10"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
syslog10    0  TINFO  :   Test setlogmask() with LOG_MASK macro.
syslog10    0  TINFO  :   o Use setlogmask() with LOG_MASK macro to set an
syslog10    0  TINFO  :     individual priority level.
syslog10    0  TINFO  :   o Send the message of above prority and expect it=
 to be
syslog10    0  TINFO  :     logged.
syslog10    0  TINFO  :   o Send message which is at other priority level to
syslog10    0  TINFO  :     the one set above, which should not be logged.
syslog10    0  TINFO  :  syslog: Testing setlogmask() with LOG_MASK macro...
syslog10    0  TINFO  :  restarting syslog daemon
syslog10    0  TINFO  :  restarting syslog daemon
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D6 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D2 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dtimerfd_settime01 stime=3D1615253878
cmdline=3D"timerfd_settime01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
timerfd_settime01.c:53: TINFO: Testing variant: syscall with old kernel spec
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EBADF =
(9)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EFAULT=
 (14)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EINVAL=
 (22)
timerfd_settime01.c:96: TPASS: timerfd_settime() failed as expected: EINVAL=
 (22)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dtimer_delete02 stime=3D1615253878
cmdline=3D"timer_delete02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
timer_delete02.c:30: TPASS: Failed as expected: EINVAL (22)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dutime03 stime=3D1615253878
cmdline=3D"utime03"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
utime03     1  TPASS  :  Functionality of utime(tmp_file, NULL) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D4 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dutime05 stime=3D1615253882
cmdline=3D"utime05"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
utime05     1  TPASS  :  Functionality of utime(tmp_file, &times) successful
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwait02 stime=3D1615253882
cmdline=3D"wait02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
wait02      1  TPASS  :  wait(&status) returned 4490
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwait402 stime=3D1615253883
cmdline=3D"wait402"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
wait402     1  TPASS  :  received expected failure - errno =3D 10 - No chil=
d processes
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid01 stime=3D1615253883
cmdline=3D"waitpid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
waitpid01.c:38: TPASS: waitpid() returned correct pid 4497
waitpid01.c:47: TPASS: WIFSIGNALED() set in status
waitpid01.c:55: TPASS: WTERMSIG() =3D=3D SIGALRM

Summary:
passed   3
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitpid06 stime=3D1615253883
cmdline=3D"waitpid06"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
waitpid06.c:54: TPASS: Test PASSED

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dwaitid01 stime=3D1615253883
cmdline=3D"waitid01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4511 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4512 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4511 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4512 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4513 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4511 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4512 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4513 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4514 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4515 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4511 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4512 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4513 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4514 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4515 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4516 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4510 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4511 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4512 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4513 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4514 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4515 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    0  TINFO  :  Process 4516 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 123
waitid01    0  TINFO  :  Process 4517 terminated:
waitid01    0  TINFO  :  code =3D 1
waitid01    0  TINFO  :  exit value =3D 0
waitid01    0  TINFO  :  Process 4518 terminated:
waitid01    0  TINFO  :  code =3D 2
waitid01    0  TINFO  :  signal =3D 1
waitid01    1  TPASS  :  waitid(): system call passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dwritev02 stime=3D1615253883
cmdline=3D"writev02"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
writev02    0  TINFO  :  Enter block 1
writev02    1  TPASS  :  Received EFAULT as expected
writev02    0  TINFO  :  Exit block 1
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfutex_wait01 stime=3D1615253883
cmdline=3D"futex_wait01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
futex_wait01.c:69: TINFO: Testing variant: syscall with old kernel spec
futex_wait01.c:62: TPASS: futex_wait() passed: ETIMEDOUT (110)
futex_wait01.c:62: TPASS: futex_wait() passed: EAGAIN/EWOULDBLOCK (11)
futex_wait01.c:62: TPASS: futex_wait() passed: ETIMEDOUT (110)
futex_wait01.c:62: TPASS: futex_wait() passed: EAGAIN/EWOULDBLOCK (11)

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dfutex_wait_bitset01 stime=3D1615253883
cmdline=3D"futex_wait_bitset01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
tst_test.c:1263: TINFO: Timeout per run is 0h 25m 00s
futex_wait_bitset01.c:99: TINFO: Testing variant: syscall with old kernel s=
pec
futex_wait_bitset01.c:45: TINFO: testing futex_wait_bitset() timeout with C=
LOCK_MONOTONIC
futex_wait_bitset01.c:87: TPASS: futex_wait_bitset() waited 100078us, expec=
ted 100010us
futex_wait_bitset01.c:45: TINFO: testing futex_wait_bitset() timeout with C=
LOCK_REALTIME
futex_wait_bitset01.c:87: TPASS: futex_wait_bitset() waited 100064us, expec=
ted 100010us

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20200930-258-g35cb4055d

       ###############################################################

            Done executing testcases.
            LTP Version:  20200930-258-g35cb4055d
       ###############################################################


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/ltp-syscalls.yaml
suite: ltp
testcase: ltp
category: functional
need_modules: true
need_memory: 4G
disk: 1HDD
fs: xfs
ltp:
  test: syscalls-07
job_origin: ltp-syscalls.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d02
tbox_group: lkp-skl-d02
kconfig: x86_64-rhel-8.3
submit_id: 6046a1ffe2061952ad5d639a
job_file: "/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-07-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-3c6be3a73b969746256d2ad3573b1ee72e8454ee-20210309-21165-1vxtyni-0.yaml"
id: 8e594e282e06284c3a6d2b92a2174b1f0dc2bb74
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d02
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c500746fa0cc-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e41514d5105-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e41514d5105-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/disk/nr_hdd
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_BLK_DEV_LOOP
- CONFIG_CAN=m
- CONFIG_CAN_RAW=m
- CONFIG_CAN_VCAN=m
- CONFIG_IPV6_VTI=m
- CONFIG_MINIX_FS=m
- CONFIG_XFS_FS

#! include/ltp

#! include/queue/cyclic
commit: 3c6be3a73b969746256d2ad3573b1ee72e8454ee

#! include/testbox/lkp-skl-d02
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'

#! include/fs/OTHERS
enqueue_time: 2021-03-09 06:15:28.046542863 +08:00
_id: 6046a1ffe2061952ad5d639a
_rt: "/result/ltp/1HDD-xfs-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 751ce6594886274f1cb79ce6d4401e05b52399f1
base_commit: a38fd8748464831584a19438cbb3082b5a2dab15
branch: linux-devel/devel-hourly-20210308-052143
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/ltp/1HDD-xfs-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/0"
scheduler_version: "/lkp/lkp/.src-20210308-140250"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d02/ltp-1HDD-xfs-syscalls-07-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-3c6be3a73b969746256d2ad3573b1ee72e8454ee-20210309-21165-1vxtyni-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210308-052143
- commit=3c6be3a73b969746256d2ad3573b1ee72e8454ee
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/vmlinuz-5.12.0-rc1-g3c6be3a73b96
- max_uptime=2100
- RESULT_ROOT=/result/ltp/1HDD-xfs-syscalls-07-ucode=0xe2/lkp-skl-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210307-130948/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.12.0-rc2-wt-04233-gc35abe128ab2

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/3c6be3a73b969746256d2ad3573b1ee72e8454ee/vmlinuz-5.12.0-rc1-g3c6be3a73b96"
dequeue_time: 2021-03-09 06:19:56.409175992 +08:00

#! /lkp/lkp/.src-20210308-140250/include/site/inn
job_state: finished
loadavg: 1.38 0.73 0.28 1/208 4651
start_time: '1615242082'
end_time: '1615242176'
version: "/lkp/lkp/.src-20210308-140328:f10abbd6:6b4ff2a6e"

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sda1
mkfs -t xfs -f /dev/sda1
mkdir -p /fs/sda1
mount -t xfs -o inode64 /dev/sda1 /fs/sda1
ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
./runltp -f syscalls-07 -d /fs/sda1/tmpdir

--JP+T4n/bALQSJXh8--
