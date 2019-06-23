Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94C04FE09
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 22:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfFWUp1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 16:45:27 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48434 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726299AbfFWUp1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 16:45:27 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C4B1F35C56C; Sun, 23 Jun 2019 16:45:23 -0400 (EDT)
Date:   Sun, 23 Jun 2019 16:45:23 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery not
 possible)
Message-ID: <20190623204523.GC11831@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2019 at 01:00:50PM +0800, Qu Wenruo wrote:
> On 2019/6/20 =E4=B8=8A=E5=8D=887:45, Zygo Blaxell wrote:
> > On Sun, Jun 16, 2019 at 12:05:21AM +0200, Claudius Winkel wrote:
> >> What should I do now ... to use btrfs safely? Should i not use it with
> >> DM-crypt
> >=20
> > You might need to disable write caching on your drives, i.e. hdparm -W0.
>=20
> This is quite troublesome.
>=20
> Disabling write cache normally means performance impact.

The drives I've found that need write cache disabled aren't particularly
fast to begin with, so disabling write cache doesn't harm their
performance very much.  All the speed gains of write caching are lost
when someone has to spend time doing a forced restore from backup after
transid-verify failure.  If you really do need performance, there are
drives with working firmware available that don't cost much more.

> And disabling it normally would hide the true cause (if it's something
> btrfs' fault).

This is true; however, even if a hypothetical btrfs bug existed,
disabling write caching is an immediately deployable workaround, and
there's currently no other solution other than avoiding drives with
bad firmware.

There could be improvements possible for btrfs to work around bad
firmware...if someone's willing to donate their sanity to get inside
the heads of firmware bugs, and can find a way to fix it that doesn't
make things worse for everyone with working firmware.

> > I have a few drives in my collection that don't have working write cach=
e.
> > They are usually fine, but when otherwise minor failure events occur (e=
=2Eg.
> > bad cables, bad power supply, failing UNC sectors) then the write cache
> > doesn't behave correctly, and any filesystem or database on the drive
> > gets trashed.
>=20
> Normally this shouldn't be the case, as long as the fs has correct
> journal and flush/barrier.

If you are asking the question:

        "Are there some currently shipping retail hard drives that are
        orders of magnitude more likely to corrupt data after simple
        power failures than other drives?"

then the answer is:

	"Hell, yes!  How could there NOT be?"

It wouldn't take very much capital investment or time to find this out
in lab conditions.  Just kill power every 25 minutes while running a
btrfs stress-test should do it--or have a UPS hardware failure in ops,
the effect is the same.  Bad drives will show up in a few hours, good
drives take much longer--long enough that, statistically, the good drives
will probably fail outright before btrfs gets corrupted.

> If it's really the hardware to blame, then it means its flush/fua is not
> implemented properly at all, thus the possibility of a single power loss
> leading to corruption should be VERY VERY high.

That exactly matches my observations.  Only a few disks fail at all,
but the ones that do fail do so very often:  60% of corruptions at
10 power failures or less, 100% at 30 power failures or more.

> >  This isn't normal behavior, but the problem does affect
> > the default configuration of some popular mid-range drive models from
> > top-3 hard disk vendors, so it's quite common.
>=20
> Would you like to share the info and test methodology to determine it's
> the device to blame? (maybe in another thread)

It's basic data mining on operations failure event logs.

We track events like filesystem corruption, data loss, other hardware
failure, operator errors, power failures, system crashes, dmesg error
messages, etc., and count how many times each failure occurs in systems
with which hardware components.  When a failure occurs, we break the
affected system apart and place its components into other systems or
test machines to isolate which component is causing the failure (e.g. a
failing power supply could create RAM corruption events and disk failure
events, so we move the hardware around to see where the failure goes).
If the same component is involved in repeatable failure events, the
correlation jumps out of the data and we know that component is bad.
We can also do correlations by attributes of the components, i.e. vendor,
model, size, firmware revision, manufacturing date, and correlate
vendor-model-size-firmware to btrfs transid verify failures across
a fleet of different systems.

I can go to the data and get a list of all the drive model and firmware
revisions that have been installed in machines with 0 "parent transid
verify failed" events since 2014, and are still online today:

        Device Model: CT240BX500SSD1 Firmware Version: M6CR013
        Device Model: Crucial_CT1050MX300SSD1 Firmware Version: M0CR060
        Device Model: HP SSD S700 Pro 256GB Firmware Version: Q0824G
        Device Model: INTEL SSDSC2KW256G8 Firmware Version: LHF002C
        Device Model: KINGSTON SA400S37240G Firmware Version: R0105A
        Device Model: ST12000VN0007-2GS116 Firmware Version: SC60
        Device Model: ST5000VN0001-1SF17X Firmware Version: AN02
        Device Model: ST8000VN0002-1Z8112 Firmware Version: SC61
        Device Model: TOSHIBA-TR200 Firmware Version: SBFA12.2
        Device Model: WDC WD121KRYZ-01W0RB0 Firmware Version: 01.01H01
        Device Model: WDC WDS250G2B0A-00SM50 Firmware Version: X61190WD
        Model Family: SandForce Driven SSDs Device Model: KINGSTON SV300S37=
A240G Firmware Version: 608ABBF0
        Model Family: Seagate IronWolf Device Model: ST10000VN0004-1ZD101 F=
irmware Version: SC60
        Model Family: Seagate NAS HDD Device Model: ST4000VN000-1H4168 Firm=
ware Version: SC44
        Model Family: Seagate NAS HDD Device Model: ST8000VN0002-1Z8112 Fir=
mware Version: SC60
        Model Family: Toshiba 2.5" HDD MK..59GSXP (AF) Device Model: TOSHIB=
A MK3259GSXP Firmware Version: GN003J
        Model Family: Western Digital Gold Device Model: WDC WD101KRYZ-01JP=
DB0 Firmware Version: 01.01H01
        Model Family: Western Digital Green Device Model: WDC WD10EZRX-00L4=
HB0 Firmware Version: 01.01A01
        Model Family: Western Digital Re Device Model: WDC WD2000FYYZ-01UL1=
B1 Firmware Version: 01.01K02
        Model Family: Western Digital Red Device Model: WDC WD50EFRX-68MYMN=
1 Firmware Version: 82.00A82
        Model Family: Western Digital Red Device Model: WDC WD80EFZX-68UW8N=
0 Firmware Version: 83.H0A83
        Model Family: Western Digital Red Pro Device Model: WDC WD6002FFWX-=
68TZ4N0 Firmware Version: 83.H0A83

So far so good.  The above list of drive model-vendor-firmware have
collectively had hundreds of drive-power-failure events in the last 5
years, so we have been giving the firmware a fair workout [1].

Now let's look for some bad stuff.  How about a list of drives that were
involved in parent transid verify failure events occurring within 1-10
power cycles after mkfs events:

	Model Family: Western Digital Green Device Model: WDC WD20EZRX-00DC0B0 Fir=
mware Version: 80.00A80

Change the query to 1-30 power cycles, and we get another model with
the same firmware version string:

	Model Family: Western Digital Red Device Model: WDC WD40EFRX-68WT0N0 Firmw=
are Version: 80.00A80

Removing the upper bound on power cycle count doesn't find any more.

The drives running 80.00A80 are all in fairly similar condition: no errors
in SMART, the drive was apparently healthy at the time of failure (no
unusual speed variations, no unexpected drive resets, or any of the other
things that happen to these drives as they age and fail, but that are
not reported as official errors on the models without TLER).  There are
multiple transid-verify failures logged in multiple very different host
systems (e.g. Intel 1U server in a data center, AMD desktop in an office,
hardware ages a few years apart).  This is a consistent and repeatable
behavior that does not correlate to any other attribute.

Now, if you've been reading this far, you might wonder why the previous
two ranges were lower-bounded at 1 power cycle, and the reason is because
I have another firmware in the data set with _zero_ power cycles between
mkfs and failure:

	Model Family: Western Digital Caviar Black Device Model: WDC WD1002FAEX-00=
Z3A0 Firmware Version: 05.01D05

These drives have 0 power fail events between mkfs and "parent transid
verify failed" events, i.e. it's not necessary to have a power failure
at all for these drives to unrecoverably corrupt btrfs.  In all cases the
failure occurs on the same days as "Current Pending Sector" and "Offline
UNC sector" SMART events.  The WD Black firmware seems to be OK with write
cache enabled most of the time (there's years in the log data without any
transid-verify failures), but the WD Black will drop its write cache when
it sees a UNC sector, and btrfs notices the failure a few hours later.

Recently I've been asking people on IRC who present btrfs filesystems
with transid-verify failures (excluding those with obvious symptoms of
host RAM failure).  So far all the users who have participated in this
totally unscientific survey have WD Green 2TB and WD Black hard drives
with the same firmware revisions as above.  The most recent report was
this week.  I guess there are lot of drives with these firmwares still
in inventories out there.

The data says there's at least 2 firmware versions in the wild which
have 100% of the btrfs transid-verify failures.  These are only 8%
of the total fleet of disks in my data set, but they are punching far
above their weight in terms of failure event count.

I first observed these correlations back in 2016.  We had a lot of WD
Green and Black drives in service at the time--too many to replace or
upgrade them all early--so I looked for a workaround to force the
drives to behave properly.  Since it looked like a write ordering issue,
I disabled the write cache on drives with these firmware versions, and
found that the transid-verify filesystem failures stopped immediately
(they had been bi-weekly events with write cache enabled).

That was 3 years ago, and there are no new transid-verify failures
logged since then.  The drives are still online today with filesystems
mkfsed in 2016.

One bias to be aware of from this data set:  it goes back further than 5
years, and we use the data to optimize hardware costs including the cost
of ops failures.  You might notice there are no Seagate Barracudas[2] in
the data, while there are the similar WD models.  In an unbiased sample
of hard drives, there are likely to be more bad firmware revisions than
found in this data set.  I found 2, and that's a lower bound on the real
number out there.

> Your idea on hardware's faulty FLUSH/FUA implementation could definitely
> cause exactly the same problem, but the last time I asked similar
> problem to fs-devel, there is no proof for such possibility.

Well, correlation isn't proof, it's true; however, if a behavior looks
like a firmware bug, and quacks like a firmware bug, and is otherwise
indistinguishable from a firmware bug, then it's probably a firmware bug.

I don't know if any of these problems are really device firmware bugs or
Linux bugs, particularly in the WD Black case.  That's a question for
someone who can collect some of these devices and do deeper analysis.

In particular, my data is not sufficient to rule out either of these two
theories for the WD Black:

	1.  Linux doesn't use FLUSH/FUA correctly when there are IO errors
	/ drive resets / other things that happen around the times that
	drives have bad sectors, but it is OK as long as there are no
	cached writes that need to be flushed, or

	2.  It's just a bug in one particular drive firmware revision,
	Linux is doing the right thing with FLUSH/FUA and the firmware
	is not.

For the bad WD Green/Red firmware it's much simpler:  those firmware
revisions fail while the drive is not showing any symptoms of defects.
AFAIK there's nothing happening on these drives for Linux code to get
confused about that doesn't also happen on every other drive firmware.

Maybe it's a firmware bug WD already fixed back in 2014, and it just
takes a decade for all the old drives to work their way through the
supply chain and service lifetime.

> The problem is always a ghost to chase, extra info would greatly help us
> to pin it down.

This lack of information is a bit frustrating.  It's not particularly
hard or expensive to collect this data, but I've had to collect it
myself because I don't know of any reliable source I could buy it from.

I found two bad firmwares by accident when I wasn't looking for bad
firmware.  If I'd known where to look, I could have found them much
faster: I had the necessary failure event observations within a few
months after starting the first btrfs pilot projects, but I wasn't
expecting to find firmware bugs, so I didn't recognize them until there
were double-digit failure counts.

WD Green and Black are low-cost consumer hard drives under $250.
One drive of each size in both product ranges comes to a total price
of around $1200 on Amazon.  Lots of end users will have these drives,
and some of them will want to use btrfs, but some of the drives apparently
do not have working write caching.  We should at least know which ones
those are, maybe make a kernel blacklist to disable the write caching
feature on some firmware versions by default.

A modestly funded deliberate search project could build a map of firmware
reliability in currently shipping retail hard drives from all three
big vendors, and keep it updated as new firmware revisions come out.
Sort of like Backblaze's hard drive reliability stats, except you don't
need a thousand drives to test firmware--one or two will suffice most of
the time [3].  The data can probably be scraped from end user reports
(if you have enough of them to filter out noise) and existing ops logs
(better, if their methodology is sound) too.



> Thanks,
> Qu

[1] Pedants will notice that some of these drive firmwares range in age
=66rom 6 months to 7 years, and neither of those numbers is 5 years, and
the power failure rate is implausibly high for a data center environment.
Some of the devices live in offices and laptops, and the power failures
are not evenly distributed across the fleet.  It's entirely possible that
some newer device in the 0-failures list will fail horribly next week.
Most of the NAS and DC devices and all the SSDs have not had any UNC
sector events in the fleet yet, and they could still turn out to be
ticking time bombs like the WD Black once they start to grow sector
defects.  The data does _not_ say that all of those 0-failure firmwares
are bug free under identical conditions--it says that, in a race to
be the first ever firmware to demonstrate bad behavior, the firmwares
in the 0-failures list haven't left the starting line yet, while the 2
firmwares in the multi-failures list both seem to be trying to _win_.

[2] We had a few surviving Seagate Barracudas in 2016, but over 85% of
those built before 2015 had failed by 2016, and none of the survivors
are still online today.  In practical terms, it doesn't matter if a
pre-2015 Barracuda has correct power-failing write-cache behavior when
the drive hardware typically dies more often than the host's office has
power interruptions.

[3] OK, maybe it IS hard to find WD Black drives to test at the _exact_
moment they are remapping UNC sectors...tap one gently with a hammer,
maybe, or poke a hole in the air filter to let a bit of dust in?

> > After turning off write caching, btrfs can keep running on these problem
> > drive models until they get too old and broken to spin up any more.
> > With write caching turned on, these drive models will eat a btrfs every
> > few months.
> >=20
> >=20
> >> Or even use ZFS instead...
> >>
> >> Am 11/06/2019 um 15:02 schrieb Qu Wenruo:
> >>>
> >>> On 2019/6/11 =E4=B8=8B=E5=8D=886:53, claudius@winca.de wrote:
> >>>> HI Guys,
> >>>>
> >>>> you are my last try. I was so happy to use BTRFS but now i really ha=
te
> >>>> it....
> >>>>
> >>>>
> >>>> Linux CIA 4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC 2=
019
> >>>> x86_64 x86_64 x86_64 GNU/Linux
> >>>> btrfs-progs v4.15.1
> >>> So old kernel and old progs.
> >>>
> >>>> btrfs fi show
> >>>> Label: none=C2=A0 uuid: 9622fd5c-5f7a-4e72-8efa-3d56a462ba85
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes=
 used 4.58TiB
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 =
1 size 7.28TiB used 4.59TiB path /dev/mapper/volume1
> >>>>
> >>>>
> >>>> dmesg
> >>>>
> >>>> [57501.267526] BTRFS info (device dm-5): trying to use backup root at
> >>>> mount time
> >>>> [57501.267528] BTRFS info (device dm-5): disk space caching is enabl=
ed
> >>>> [57501.267529] BTRFS info (device dm-5): has skinny extents
> >>>> [57507.511830] BTRFS error (device dm-5): parent transid verify fail=
ed
> >>>> on 2069131051008 wanted 4240 found 5115
> >>> Some metadata CoW is not recorded correctly.
> >>>
> >>> Hopes you didn't every try any btrfs check --repair|--init-* or anyth=
ing
> >>> other than --readonly.
> >>> As there is a long exiting bug in btrfs-progs which could cause simil=
ar
> >>> corruption.
> >>>
> >>>
> >>>
> >>>> [57507.518764] BTRFS error (device dm-5): parent transid verify fail=
ed
> >>>> on 2069131051008 wanted 4240 found 5115
> >>>> [57507.519265] BTRFS error (device dm-5): failed to read block group=
s: -5
> >>>> [57507.605939] BTRFS error (device dm-5): open_ctree failed
> >>>>
> >>>>
> >>>> btrfs check /dev/mapper/volume1
> >>>> parent transid verify failed on 2069131051008 wanted 4240 found 5115
> >>>> parent transid verify failed on 2069131051008 wanted 4240 found 5115
> >>>> parent transid verify failed on 2069131051008 wanted 4240 found 5115
> >>>> parent transid verify failed on 2069131051008 wanted 4240 found 5115
> >>>> Ignoring transid failure
> >>>> extent buffer leak: start 2024985772032 len 16384
> >>>> ERROR: cannot open file system
> >>>>
> >>>>
> >>>>
> >>>> im not able to mount it anymore.
> >>>>
> >>>>
> >>>> I found the drive in RO the other day and realized somthing was wrong
> >>>> ... i did a reboot and now i cant mount anmyore
> >>> Btrfs extent tree must has been corrupted at that time.
> >>>
> >>> Full recovery back to fully RW mountable fs doesn't look possible.
> >>> As metadata CoW is completely screwed up in this case.
> >>>
> >>> Either you could use btrfs-restore to try to restore the data into
> >>> another location.
> >>>
> >>> Or try my kernel branch:
> >>> https://github.com/adam900710/linux/tree/rescue_options
> >>>
> >>> It's an older branch based on v5.1-rc4.
> >>> But it has some extra new mount options.
> >>> For your case, you need to compile the kernel, then mount it with "-o
> >>> ro,rescue=3Dskip_bg,rescue=3Dno_log_replay".
> >>>
> >>> If it mounts (as RO), then do all your salvage.
> >>> It should be a faster than btrfs-restore, and you can use all your
> >>> regular tool to backup.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>>
> >>>> any help
>=20




--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXQ/k4AAKCRCB+YsaVrMb
nFuMAJ4mqgGmXJS0qUgiw72NDr9kaUhmjACgso/nCswory95ueHK0QIQyH9asVE=
=4SQs
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
