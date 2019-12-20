Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7107512858E
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 00:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfLTXaN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 18:30:13 -0500
Received: from mail.nethype.de ([5.9.56.24]:42391 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfLTXaM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 18:30:12 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiRih-003rat-QN; Fri, 20 Dec 2019 23:30:07 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiRih-0006PP-KE; Fri, 20 Dec 2019 23:30:07 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1iiRih-0000jf-Ju; Sat, 21 Dec 2019 00:30:07 +0100
Date:   Sat, 21 Dec 2019 00:30:07 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs dev del not transaction protected?
Message-ID: <20191220233007.GA1195@schmorp.de>
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
 <20191220165008.GA1603@schmorp.de>
 <CAJCQCtRBTaGoAejs9Ms=EbeJJRvMH8t5xHPgXp8P==sCMZZaJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJCQCtRBTaGoAejs9Ms=EbeJJRvMH8t5xHPgXp8P==sCMZZaJQ@mail.gmail.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 20, 2019 at 01:24:02PM -0700, Chris Murphy <lists@colorremedies.com> wrote:
> > Please don't - I honestly think btrfs developers are way to fast to blame
> > hardware for problems.
> 
> That's because they have a lot of evidence of this, in a way that's
> only inferable with other file systems. This has long been suspected
> by, and demonstrated, well before Btrfs with ZFS development.

But they don't - when I report that on different machines I see this
reproducible behaviour, what is that lot of evidence? At the least they
could inquire

> A reasonable criticism of Btrfs development is the state of the file
> system check repair, which still has danger warnings. But it's also a
> case of damned if they do, and damned if they don't provide it. It
> might be the best chance of recovery, so why not provide it?

Note that I have not asked for a better fsck or anything of the sort.

> usual, and developers apologized. What else can they do? It's not like
> the developers are blaming hardware for their own bugs. They have
> consistently taken responsibility for Btrfs bugs.

That's not the reality I live in, though. Most of my bug reports on btrfs
have either been completely ignored or "oh, I can't reproduce it today
anymore, maybe its fixed itself".

Sure, some of my bug reports have been taken seriously as well, and btrfs
has advanced considerably over the years.

I am a software developer myself, and I understand that not every bug
report can be acted upon, and sometimes you need to be sceptic for other
reasons then the assumed reported ones.

> Usually Btrfs developers do mention the possibility of other software
> layers contributing to the problem, it's a valid observation that this
> possibility be stated.

That's probably why I stated it, yes.

Your mail doesn't really apply to much of what I wrote - have you really
read my bug report, or is this the pre-canned response you send out for
criticism? Sorry to be so blunt, but thats pretty much how your mail feels
to me, as it doesn't seem to take into account what I reported.

> However, if it's exclusively a software problem, then it should be
> reproducible on other systems.

Which in this case, it is.

Even hardware problems can be reproduced on other systems, when it's say,
a controller problem, so reproducability of a problem does not mean it's a
software bug. But likewise jumping to conclusions because it is convenient
is also a non-sequitur.

> > In any case if it is a hardware problem, then linux and/or btrfs has
> > to work around them, because it affects many different controllers on
> > different boards:
> 
> How do you propose Btrfs work around it? In particular when there are
> additional software layers over which it has no control?

Why do I suddenly have to propose btrfs to work around it? I said if its
a hardware problem with practically every current controller, then linux
and/or btrfs have to work around them, otherwise it becomes useless. And
if other filesystems can keep data safe when btrfs can't, then clearly
btrfs can be improved to do likewise.

> Have you tried disabling the (drives') write cache?

The write caches of all drives have been off during the lifetime of the
filesystem.

Nevertheless, whats your basis for asking for write caches to be turned
off? Is there any evidence that drives lose their caches without being
turned off? Maybe such drives exist, but I have not heard of them - have you?

The reason why the write cache is off is because the stupid lsi raid
controllers I use _do_ lose data on power outages when the drive cache is
on, something that 3ware controllers didn't do. Not that power outages
(actual brownouts or manually induced via the power switch) are something
that really happens here.

I do, however, expect that current filesystems properly flush data to
disk, and outside the raid controllers, I do not disable the write cache.

> > [41801.618887] CPU: 2 PID: 5713 Comm: kworker/u8:15 Tainted: P           OE     5.4.5-050405-generic #201912181630
> 
> Why is this kernel tainted?

non-free nvidia driver

> The point of pointing this out isn't to blame whatever it tainting the
> kernel, but to point out that identifying the cause of your problems is
> made a lot more difficult.

I think you are wildly exaggerating. Are there any reports of nvidia
drivers actually corrupting filesystems? I am genuinely curious.

Other than that, your claim that a tainted kernel some makes identifying
the problem a lot more difficult is just taken out of the blue, isn't it?

> I think you need to simplify the setup, a lot, in order to reduce the
> surface area of possible problems. Any bug hunt is made way harder when
> there's complication.

Well, sure, you can hide behind the kernel taint. I am sorry, in that case, I
just cannot provide you with any reports anymore, if that is what you really
want.

Note, however, that this is simply an excuse "oh, a raid controller, you
need to simplify your setup first". "oh, a tainted driver, you need to
simplify your setup first". What's next, "oh, you used a sata disk, you
need to simplify the setup first to see if filesystem corruption happens
without the disk frst".

Debugging real world problems is hard, and just ignoring the real world
because it doesn't fit into a lab doesn't work.

Besides, I already simplified the setup for you - my dell laptop only uses
certiefied genuine non-tainted in-kernel drivers and an nvme controller,
and still szuffered form the open_ctree on first reboot problem once.

> >    Filesystem               Size  Used Avail Use% Mounted on
> >    /dev/mapper/xmnt-cold15   27T   23T     0 100% /cold1
> 
> Clearly a bug, possibly more than one. This problem is being discussed
> in other threads on df misreporting with recent kernels, and a fix is
> pending.

As it turns out, it's not df misreporting, it's simply very bad error
reporting on the side of btrfs, requiring a lot of guesswork on the side of
the user, followed by "you need to fix that problem first" from the btrfs
mailing list.

In any case, I am sorry I was triggered and brought this up - this last
oops report wqas not meant as a request to help me solve my problem, but
to show how bad the user experience really is, both with btrfs and with
this list.

Seriously, when I mention I have a reproducible problem on multiple kernel
versions on multiple very different computers (that I reported in may)
then it is simply not appreciated to tell me its probably a hardware
problem, even if, however inconceivable it might be, it possibly could be
a hardware problem.

> As for the ENOSPC, also clearly a bug. But not clear why or where.

So at least it wasn't immediately obvious to you either - it took me a
while to figure out the "obvious", namely that one disk with free space
is not enough for raid1 metadata. The issue here is not df potentially
misreporting, but the fatc that btrfs simply has no tool to do much about
it in obvious ways, yet the btrfs lsit tells me I need to fix thigs
first. Great advice.

> > Please, don't always chalk it up to hardware problems - btrfs is a
> > wonderful filesystem for many reasons, one reason I like is that it can
> > detect corruption much earlier than other filesystems. This featire alone
> > makes it impossible for me to go back to xfs. However, I had corruption
> > on ext4, xfs, reiserfs over the years, but btrfs *is* simply way buggier
> > still than those - before btrfs (and even now) I kept md5sums of all
> > archived files (~200TB), and xfs and ext4 _do_ a much better job at not
> > corrupting data than btrfs on the same hardware - while I get filesystem
> > problems about every half a year with btrfs, I had (silent) corruption
> > problems maybe once every three to four years with xfs or ext4 (and not
> > yet on the bxoes I use currently).
> 
> I can't really parse the suggestion that you are seeing md5 mismatches
> (indicating data changes) on Btrfs,

Me neither, where do you think I suggested that?

> where Btrfs doesn't produce a csum warning along with EIO on those
> files? Are these files nodatacow,

Well, first of all, the default is a relatively weak crc checksum
(fortunately, current kernels already offer more, another good ppint in
favour of btrfs). second, nocow data isn't checksummed. Third, I didn't
say btrfs claims good checksums on md5 mismatches, I claimed it corrupts
data.

For me, btrfs telling me instantly that a file is unreadable due to a
checksum error is much preferable to me having to manually checksum it to
find it, something I do maybe once a year.

What I am saying is that I lose way more files and data on btrfs than
on any other filesystem I used or use. And that's a fact - we cna now
speculate on why that is.

I have a few data points - most of the problems I ran into have been
other kernel bugs (such as the 4.11 corruption bug, various dmcache
corruption bugs and so on). Some of these have been btrfs bugs that have
been fixed. Some of these have been operator errors. And some are unknown,
but it's easy to scratch it up to bugs in, say, dmcache, which is another
big unknown. I don't report any of these issues because I have no useful
data to report. (And before you ask, the write cache of the dmcache
backing ssd is switche doff, although I believe the crucial ssds that I
use are some of the rare devices which actually honor FUA, and have data
at rest protection).

The big advantage of btrfs is that I can often mount it and make a full
backup (which only stats files to see if they changed) of the disk before
recreating the filesystem, and even if it fails, it usually can and does
loudly tell me so. I had way worse experience with, say, reiserfs long
ago, for example :)

> A mechanism explaining this anecdote isn't clear. Not even crc32c
> checksum collision would explain more than maybe one instance of it.
> 
> I'm curious what Zygo thinks about this.

I think you are reading way too much extra stuff into what I wrote - I
really feel you are replying to a superficial versiob fo what I actually
reported, because you are used to other such reports maybe?

> The problem with the anecdotal method of arguing in favor of software
> bugs as the explanation?

Is this your method? Because it is certainly not mine, or where do you see
that?

I have carefully presented facts together with supporting evidence that
it is unlikely to be a hardware problem. Nowhere did I exclude hardware
problems, nowhere did I exclude operator errors, nowhere did I exclude
errors in other parts of the kernel (the most common source for corruption
problems I have encountered).

Nowhere have I claimed it must be a software problem.

> also anecdote. I've had no problems that I can attribute to Btrfs. All
> were hardware or user sabotage. And I've had zero data loss, outside
> of user sabotage.

That's great for you. I have ~100 active disks here with >>200TB of data,
the vast majority nowadays runs with btrfs. The filesystems tend to be
very busy, with very different use cases, and I think as far as anecdotes
go, I have far better chances of runn inginto btrfs (or other!) bugs than
most other people, possibly (don't know) even you.

> I have seen device UNC read errors, corrected automatically by Btrfs.

Yeah, me too, but only on a USB stick that I knew was badly borked.

I currently see about one unreadable sector every 1-1.5 years, and in most
cases, raid5 scrubbing takes care of that, or I identify the file, delete
it, and move on. I had a single case of a sudden drive death in my whole
3x years career (maybe I am lucky).

Of course these are just anecdotes. But hundreds of disks give a much
better statistical base then, say, a single drive in somebodies home
computer.

But of course I only have as single multi-device btrfs filesystem (as an
experiment), so my statistical basis here is very thin...

> And I have seen devices return bad data that Btrfs caught, that would
> otherwise have been silent corruption of either metadata or data, and

Me too, me too. Wonderful feature, that.

I have also seen btrfs fail to use the mirror copy because of a broken
block, even though the mirror would have been fine - quite the number of
these have been fixed in recent years, did you know that? Until quite
recently, btrfs only believed in the checksum, and if that was good,
dup/raid1 was of no use...

Until recently, btrfs did practically nothing about corruption introduced
by itself or the kernel (or bad ram for example). It's great that this
changed, even though I had a few filesystems that the new stricter 5.4.x
checker refused to mount.

It's painful, but clearly progress.

I really think you confuse me with some other person that mindlessly
complains. I think my complaints do have substance, though, and you chide
unfairly :)

> But in your case, practically ever server and laptop? That's weird and
> unexpected.

Not if you have some google fu. btrfs corruption problems are extremely
common, but it's often very hard to guess what caused it.

I also think you are super badly informed about btrfs (or pretend to to
defend btrfs against all reason) - recent kernels report a lot of scary
corruption messages and refuse mounts, with no hint as to what could be
the problem (a stricter checker - your fs might work fine under previous
kernels).

If btrfs declares my fs as corrupt, I consider that filesystem
corruption. It took me quite a while to realise its stricter checking and
not neccessarily an indication of a real problem. I quietly reformatted those
affected partitions.

Seriosly, if claims that btrfs corruption is unexpected is so far fetched and
unexpected you live in a parallel universe.

Just go through kernel changelogs and count the btrfs bugfixes that cold
somehow lead to corruption on somebidies system - btrfs received a lotm opf
bugfixes (which is good!) but it also means there certaionly were a lot of
bugs in it.

And must I remind you of the raid5 issues - I never ran into these,
because careful reading of the documentation clearly told me to not use
it, but it cetrainly caused a lot of btrfs corruption - let's chalk that
up to user errors, though.

> And it makes me wonder what's in common. Btrfs is much fussier than
> other file systems because the by far largest target for corruption,
> isn't file system metadata, but data. The actual payload

I don'Ät think this is true. File data might offer more surface, but there
are many workloads (wsome of mine included) where metadata is shuffled around
a lot more than data, and there is a lot less that can go wrong with actual
data - btrfs just has to copy and checksum it - while for netadata, evry
complicated algorithms are in use.

Maybe actual data is the largest target, but I don't think you can
substantiate that claim in this generality.

> of a file system isn't the file system. And Btrfs is the only Linux
> native file system that checksums data. The other file systems check

Which is exactly why I am using it. I had a single case of a file that was
silently corrupted on xfs on teh last decade, and I only had a backup of
it because it was silently corrupted and the backup had a good copy, also
practically proving that it was silent data corruption.

> only metadata, and only somewhat recently, depending on the
> distribution you're using.

I think that is a clear case of fanboyism - ext4 has had metadata
checksums for almost 8 years in the standard kernel now, and is probably
the most commonly used fs. XFS has had metadata checksums in the standard
kernel for more than 6 ysears. I am not sure how stable for production
btrfs was when ext4 introduced these.

Sure, metadata checksums are for noobs, but let's not make other
filesystems look worse than they really are.

> For sure. But take the contrary case that other file systems have
> depended on for more than a decade: assuming the hardware is returning
> valid data. This is intrinsic to their design. And go back before they
> had metadata checksumming, and you'd see it stated on their lists that
> they do assume this, and if your devices return any bad data, it's not
> the file system's fault at all. Not even the lack of reporting any
> kind of problem whatsoever. How is that better?

Sure, but I have considerable performance data about devices returning
bad data over decades, as I, remember, keep md5 sums of practically all
my files and more or less regulalry compare them, and in many cases, have
backups so I can even investigate what exactly was corrupted how.

I am sorry to bring you the bad news, but outside of known broken hardware
(e.g. the cmd640 corruption, which I suffered from if somebody is old
enough to remember those), devices returning bad data happens, but is
_exceedingly_ rare. Unreadable sectors are by far more common on spinning
rust, and in my experience, quite rare unless there as "an incident" (such
as a headcrash).

The most common sources of data corruption is not bad hardware, especially
on hardware that otherwise works fine (e.g. survives a few hours of
memtest etc. and keeps file data in general), but software bugs. The, by
far, most common source of data loss for me is kernel bugs, especially
in recent years. The second most common source of data loss is operator
error, at least for me. Having backups certainly made me careless.

> Well indeed, not long after Btrfs was demonstrating these are actually
> more common problems that suspected, metadata checksumming started

Sure they are more common than suspected, but thats trivial since
practically nobody expected them.

And I know these problems exist, having suffered from them. But they are
still an insignificant issue.

Maybe we come from different backgrounds - practically all my data is
on hardware raid5 or better, and an unreadable sector is not something
my filesystem usually has to take care of. They happen. Also, hardware
has become both better (e.g. checksumming on transfer) and worse (asi n,
cheper and much closer to physical limits).

Yet still, disks silently returning other data is exceedingly rare (even
if you include controller firmware problems - I have no doubt that lsi
controller firmwares are a complete bugfest).

However, what you are seeing is "btrfs is reporting bad checksums", and
you wrongly seem to ascribe all these cases to hardware, while probably
many of these cases are driver bugs, mm bugs or even filesystem bugs (a
checksum will also fail if a metadata block is outdated or points to the
wrong data block for example, which can easiily happen if something goes
wrong during tree management).

I think that is not warranted without further evidence, which you don't
seem to have.

> while ago on XFS, and very recently on ext4). And they are catching a
> lot of these same kinds of layer and hardware bugs. Hardware does not
> just mean the drive, it can be power supply, logic board, controller,
> cables, drive write caches, drive firmware, and other drive internals.

And it can also be software. And tghe filesystem. On what grounds do you
exclude btrfs from this list, for example? It clearly had a lot of bugs,
and like every complex piece of softwrae, it surely has a lot of bugs
left.

> And the only way any problem can be fixed, is to understand how, when
> and where it happened.

Yes, and you can't understand how if xyou simply exclude the
filesystem because it prpobably was the hardware anyway and ignore the
problem. "Could not reproduce this in the current kernel anymore, maye its
fixed, closing bug".

a disclaimer: this mail (and your mail!) was way too long. When I can't
fully participate in any (potential) further disucssion, it is because I
lack the time, not for other reasons.

Greetings,

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
