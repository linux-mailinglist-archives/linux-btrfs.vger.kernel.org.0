Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7964828CC
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 01:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiABAEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 19:04:20 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:33246 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232731AbiABAET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Jan 2022 19:04:19 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 9541B12FE2A; Sat,  1 Jan 2022 19:04:18 -0500 (EST)
Date:   Sat, 1 Jan 2022 19:04:18 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Martin Raiber <martin@urbackup.org>
Subject: Re: Ghost directory entries (previously "Unable to remove directory
 entry")
Message-ID: <YdDsAl0bx6DLZT+i@hungrycats.org>
References: <20211118210905.GB17148@hungrycats.org>
 <CAL3q7H4T57mBLLyoFQAP=gJKB44XBOW3FMCBAe7dHuMxdphZNw@mail.gmail.com>
 <YZcYBTt4UI542VRx@hungrycats.org>
 <CAL3q7H51ytJ12WuY5Gem3khcECAKtOUnk1441jss1BvTF1S+VQ@mail.gmail.com>
 <YZkOkNTRtG29FGhx@hungrycats.org>
 <CAL3q7H4CYtaW_aEQSEZ_KxZ_ba3u=FmPT8VtXH+OE6FTR8oxOQ@mail.gmail.com>
 <20211120193627.GE17148@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qhof47B7ieYqWFBE"
Content-Disposition: inline
In-Reply-To: <20211120193627.GE17148@hungrycats.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--qhof47B7ieYqWFBE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 20, 2021 at 02:36:27PM -0500, Zygo Blaxell wrote:
> On Sat, Nov 20, 2021 at 05:13:39PM +0000, Filipe Manana wrote:
[...]
> > > > I just tried that loop using that case, and several variations
> > > > (different names, different directories, etc), I still couldn't
> > > > reproduce and I don't see how that alone could lead to any issue.
> > > >
> > > > I think there must be something else happening in parallel besides that loop.
> > >
> > > Definitely something else is required, the loop by itself won't reproduce
> > > the issue.
> > >
> > > I don't know what the other thing is.  Candidates are:  balance or
> > > snapshot delete pushing commit times above watchdog threshold, hitting
> > > a BUG_ON, filesystem ENOSPC, kernel out of memory (i.e.  events that
> > > would normally force a host to reboot).

I've been able to reproduce it 3 times on 5.15.6 with the attached
test program.  It runs 16 threads that try to create, write to, sometimes
fsync(!), and rename files from a pool of 256 fixed names.  Run the script
in an empty directory, load the machine up so that transaction commits
take a long time to run, crash it, and about a third of the time there
will be dirents without inodes behind them, sometimes several hundred
of each file name.

After collecting a few more reports on IRC I found that there's two
sets of behaviors:  on kernels before 5.14, fsync() correlates strongly
with the issue, while on 5.14 and later, fsync() correlates negatively.
I examined the applications that were using the directories where the
ghost dirents appeared, and divided them into a group of apps that call
fsync() and those that don't, and then matched those apps up with incident
reports.  So there might be two distinct bugs leading to a similar result
(or it was always one bug but in 5.14 something changed the mechanics).

In the repro program I call fsync() on half the files and not on the
other half of the files, so it should work on kernels before and after
5.14.

Some more reports of the issue have come in over IRC and in GNOME
bug reports.  They are reporting it on 5.10 which I haven't been able
to reproduce.  I don't think there's anything special about 5.10's code,
but it's the kernel most people will be running now, so "a thing that
happens on all kernel versions before 5.14" will be reported much more
often on 5.10 than any other kernel at this time.

I have one case where a machine rebooted from 5.14 to 5.10 and the issue
was found after the reboot.  The app involved is non-fsyncing, which
would suggest the problem occurred while running 5.14 and not during log
replay on 5.10.  That data seems to fit with what we understand about
the problem, i.e. that it's putting junk in the log tree that is getting
replayed to create the ghost dirents at mount time after the crash.

> > If a transaction abort happened (fs turned into RO), than it's very
> > likely to have been fixed recently in 5.16-rc1 by:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a35fc9542fa6c220d69987612b88c54cba2bc33
> > 
> > The code paths fixed are triggered during a rename of a previously
> > fsynced file, and they are precisely about deleting directory items.
> > 
> > IIRC, the problem Martin reported some months ago, he had transaction aborts.
> 
> OK, if I can cherry-pick or backport that, I can test it in a lot more
> machines than I can run misc-next on.  With a multi-year gap between
> incidents, it will be some time before I can confirm any fix works.
> 
> If this commit is in a -rc kernel anyway (and presumably heading to
> -stable?) then the reports on IRC should come to a stop on their own,
> no action required.

I haven't been able to reproduce this on misc-next (which has the
patch below), or 5.16-rc kernels, or any earlier kernel that I've
tested with the patch backported.

Maybe we should put this commit in -stable?  5.15 is still alive and
definitely affected.

> Thanks!
> 

--qhof47B7ieYqWFBE
Content-Type: text/x-c++src; charset=us-ascii
Content-Disposition: attachment; filename="repro-ghost-dirent.cc"

#include <iostream>
#include <list>
#include <memory>
#include <random>
#include <sstream>
#include <string>
#include <thread>

#include <cstring>

#include <fcntl.h>
#include <unistd.h>

#include <sys/ioctl.h>

using namespace std;

int
main(int argc, char **argv)
{
	(void)argc;
	(void)argv;
	const size_t thread_count = 16;
	random_device rd;
	uniform_int_distribution<default_random_engine::result_type> uid(
		numeric_limits<default_random_engine::result_type>::min(),
		numeric_limits<default_random_engine::result_type>::max()
	);
	default_random_engine generator(uid(rd));
	list<shared_ptr<thread>> threads;
	ostringstream data_str;
	for (size_t x = 0; x < 1024; ++x) {
		data_str << x << endl;
	}
	const string data = data_str.str();
	for (size_t x = 0; x < thread_count; ++x) {
		const size_t base = x * thread_count;
		threads.push_back(make_shared<thread>([x, &data, base, &generator]() {
			uniform_int_distribution<size_t> name_dist(base, base + thread_count - 1);
			uniform_int_distribution<size_t> size_dist(1, data.size());
			char thread_name[32];
			sprintf(thread_name, "%zu ", x);
			while (true) {
				char name[32];
				const size_t file_num = name_dist(generator);
				sprintf(name, "file_%08zx", file_num);
				char tmp_name[1024];
				sprintf(tmp_name, "%s.tmp", name);
				const int fd = open(tmp_name, O_WRONLY | O_CREAT | O_NOFOLLOW | O_EXCL, 0777);
				if (fd < 0) {
					cerr << "open " << tmp_name << " failed: " << strerror(errno) << endl;
				}
				const int rv = write(fd, data.data(), size_dist(generator));
				if (rv < 1) {
					cerr << "write " << tmp_name << " failed: " << strerror(errno) << endl;
				}
				if (file_num & 1) {
					const int fv = fsync(fd);
					if (fv) {
						cerr << "fsync " << tmp_name << " failed: " << strerror(errno) << endl;
					}
				}
				if (close(fd)) {
					cerr << "close " << tmp_name << " failed: " << strerror(errno) << endl;
				}
				if (rename(tmp_name, name)) {
					cerr << "rename " << tmp_name << " -> " << name << " failed: " << strerror(errno) << endl;
				}
				cerr << thread_name;
			}
		}));
	}
	for (auto i : threads) {
		i->join();
	}

	return EXIT_SUCCESS;
}

--qhof47B7ieYqWFBE--
