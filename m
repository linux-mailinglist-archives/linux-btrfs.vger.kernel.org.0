Return-Path: <linux-btrfs+bounces-958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E861813A83
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 20:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96526B21536
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4CB6928D;
	Thu, 14 Dec 2023 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="Wde9KiMD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70D4123D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id Dr71raMqBOtSyDr71r3atg; Thu, 14 Dec 2023 20:11:12 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1702581072; bh=Pf0C65rDum09LJ4KWeUaek8gjaxX7RLMfn4v0g8ueLI=;
	h=From;
	b=Wde9KiMDGBlKTmL2vxwU3cnBnH6gEAVDc/ov06qgdCwXJdMZxxHSvrCD5gRz7A9LK
	 1cUp8MCvOX0A2rOR87fKX3lpAYoWVhMTgaXYwlEjgy/uPNBRhETR3yiL6mMUGvWipc
	 UsO9vanJJN2aBxN+63RnfXaqMnaquh5RQVB8kymlzNqpmqRcwUJmjab/rd9XMAQkTR
	 17OCFKTFvzWJLryyuqtr3iQI+xzTJL0sBfqxFfApqAiB5Y5OaiiRx68mixtLlFaEFu
	 50e+NUO4FYeJTwmHOD09WwyY/1d7nYtgU7ovg0b8xE84IOe8/InsfYTvsYYixALQoC
	 ePPl8aaBeChsg==
X-CNFS-Analysis: v=2.4 cv=Qf+g/OXv c=1 sm=1 tr=0 ts=657b5350 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=ZOX6q3_jwU10vqr_bv4A:9 a=QEXdDO2ut3YA:10
Message-ID: <e40f83ec-3363-48d9-a937-6c56b7ad9ae7@inwind.it>
Date: Thu, 14 Dec 2023 20:11:11 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/9][btrfs-progs] Remove unused dirstream variable
To: dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1702148009.git.kreijack@inwind.it>
 <20231214161749.GA9795@twin.jikos.cz>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <20231214161749.GA9795@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHIBKm2dTcF/mxZvt1SoZqwRENl2ZqCCSuxZjXEHEvWYHrDfz+X07/PGlQE9+ofleSiU+kR4iLJzjvizf6/Juz+2Q9a4jwI4Sg07lvHXCUJSONrsPrNU
 UyH+zpeL8M5H83HlqDvCXw2gqEo/qRxiWoi8BeFhNIWHcPA/8vcg65T+3ndGZnY+Zk2y4NfsSPDNBlmvJ2Xzq1xm96bCRbGK7Com7A+l7glqxZZF8Ysz3fJ3
 1VTxd9tpZE+TtF1MXfNdzg==

On 14/12/2023 17.17, David Sterba wrote:
> On Sat, Dec 09, 2023 at 07:53:20PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
[...]
> 
> As I'm reading dirfd manual page, dirfd returns the internal file
> descriptor of the dirstream and it gets closed after call to closedir().
> This means if we pass a directory and want a file descriptor then its
> lifetime matches the correspoinding DIR.

Yes, more below
> 
>> A call to close_file_or_dir() freed both 'fd' and 'dirstream'.
>>
>> Aim of this patch set is to getrid of this complexity; when the path of
>> a directory is passed, the fd is get directly using open(path, O_RDONLY):
>> so we don't need to use readdir(3) and to maintain the not used variable
>> 'dirstream'.
> 
> Does this work the same way as with the dirstream?

Yes; I tested my patches and these worked properly.

My understanding is that opendir(3)/readdir(3) are based to the pair
open(2)/getdents64(2). opendir(3) does a "open(path, O_RDONLY)",
and store the file descriptors in a malloc-ed DIR structure. Then closedir(3)
closes the fd and free the DIR structure..

You may see further details about the glib implementation.

https://github.com/kraj/glibc/blob/8757659b3cee57c1defee7772c3ee687d310b076/sysdeps/unix/sysv/linux/opendir.c#L81

The BIONIC implementation does the same thing.

The key point is that you may open(2) a directory only in O_RDONLY mode. In fact you cannot write to a directory. You may only read(); to "write" you have to use a different API like rmdir/mkdir/mknod or open("<dir>/<filename>", O_RDWR").

Another test that I did was:

ghigo@venice:/tmp$ cat test.c
#include <sys/types.h>
#include <dirent.h>

int main(int argc, char **argv) {
         DIR *dir = opendir(argv[1]);
         return (int)dir;
}

ghigo@venice:/tmp$ gcc -Wno-pointer-to-int-cast -o test test.c
ghigo@venice:/tmp$ mkdir test2
ghigo@venice:/tmp$ strace ./test test2
[...]
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
munmap(0x7f328b589000, 222607)          = 0
openat(AT_FDCWD, "test2", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3        <----------
newfstatat(3, "", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_EMPTY_PATH) = 0
getrandom("\x04\x76\xb1\xe0\xee\xd8\x8a\xc8", 8, GRND_NONBLOCK) = 8
brk(NULL)                               = 0x55676fffd000
brk(0x55677001e000)                     = 0x55677001e000
exit_group(1879036576)                  = ?
+++ exited with 160 +++
ghigo@venice:/tmp$


BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


