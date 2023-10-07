Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7AF7BC43E
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Oct 2023 04:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjJGCpe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 22:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjJGCpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 22:45:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CF5BE;
        Fri,  6 Oct 2023 19:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696646717; x=1697251517; i=quwenruo.btrfs@gmx.com;
 bh=7YLR19AXu4kyJKF6NHz6RbhznCooNisw1PcSyiAeicI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ofHKDZKNB3GElfVtD2sY3AEm9Du7Ma8f3lsi1ELvNrWmYKOJz9ZVn4ExRKvM2gt1rvmGcXteIfN
 6h2pEgLxpVrR42AuN9tr0ezTraPs2YTnTDskOc0V4yGWRWyde4SKE64YhG4cPNVDIzf55pt3v6Cnl
 xwCOxAvENW6FC6gn6pJuTAjChBUCPvWnth25eSEb0aTmCHTgbH5hEyKla/2av1kx3T1WPD6O4cHsO
 z4oGrsjryH8JklC67vgoCQoFgotHgtvlG1I1VSuIoNjiPFTO0faLAJS0h8VCSCY+PGdG0bj4qFrSm
 J8Hpth0qgJ96+rVB2p7kmVzM6MyXr/HvcaVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIMfc-1qlhe405wK-00EJn7; Sat, 07
 Oct 2023 04:45:17 +0200
Message-ID: <b82e99c6-af98-4896-894b-dde6e43ca7dc@gmx.com>
Date:   Sat, 7 Oct 2023 13:15:10 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fstests: add configuration option for executing post
 mkfs commands
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1695543976.git.anand.jain@oracle.com>
 <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
 <dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com>
 <5485cd32-2308-c9c5-4c97-9ff6c74c64dd@oracle.com>
 <0a8d40fc-501e-4d85-903a-83d9b3508bf5@gmx.com>
 <20231006060932.GD21283@frogsfrogsfrogs>
 <1f23346d-ad61-412f-b59d-1f76e2d1df6c@gmx.com>
 <ZSCGUUtCY5AsmWaO@dread.disaster.area>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <ZSCGUUtCY5AsmWaO@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/kqfkdEN/CCpf4UbyGj84PIvOMufJY8QWEjnNThN6UiAgPmTcUb
 f30bw7Hn6Ct6THzc9spDeZCFzZ6zOzQV5msYqv/WXT3daKUHQ1bfMfkNYedNLI/q0Hh/y2J
 415DaNWXiCuYeKb0dVrC8d6RDPjEyah11zw1OlV9LhV6A22iT0Vryum4lYj73GZhdT7F06m
 TwAbFLWFtt92bPeYZ/5DA==
UI-OutboundReport: notjunk:1;M01:P0:xMRdAWTOLXg=;1whhovPvaM+ryQNXoKjvHV7ylwa
 aXL0WWtwfCH5j9/Y11IxZGmTAfEFzLChOtjEuLN5ST4FbbHX+M48HngGfARuSWWEpl2cYfPLm
 RSBPtmWyBMKNgsRtebc/YyK1ILO5Paii+7TIfF0lyVlNwjaEVjexLuaygoFZhXSgXOKj38yd5
 3LSEbGpgiRhtyvm6yjJFHA9IClYZSlkVEitcOw+RNUJmifNqEGLxMuWxA6hIOCqotB47U6eYh
 7MVsGtuIHrOQuyUB1w79xklAhq8p3njS7PUWL21YsvuZrRi9bJ7ecM/W2dqbi8ZPzaDAW0Ntg
 MKBwIZyFOJ8jtMn15Uq3n4QPFtHfDy1m5huXRgTYoA1ldrwOvfvLaQgla7zbI2hKq+Ixj10/n
 NCpZphtykDiKtDON0eaIWBVsWf/Nl2FJRgIdXGCeBfq6eb1eJOip3uah9JSBPV180IJ9G3B87
 NZcKonE7YmIwcFRO4sp27stunkziPcA2kqeAuQLcLwDOTb+nb8gh6PzSQibMbTvuUupuPiqwV
 W/KasyHNyR/K14O14Ttlvqmnj5C4aFfb8nICttOr/U8+9XNdAJEcNbk7L8HFUZYKRu2vF5rCO
 jwvGDSh0J4sedKZpzj8QE0iYZGd41poGbDbK9X8vpG/UPAeB02IzEtC23Bg/Hsu1DGsweTev3
 nbV639wajy9XEoJVmbS/9VnnXojAvLeX3zXFTgO0s/LXwU67ehNLb9q3qs16FN7KSN0G+vsrr
 5ZNEBjGwqG+ZIRqRtKJMQNEFmWoHPfXI8Dh5BATg4MB81UvUISS84lmp5AgW9/VeRdrE0ToMR
 4AnQjNOXSXyb75dHTJrLqhDhef2tD4OSI9JI+6keXM8ZtkHQsld5D/Y6zyOKYb/iHqbTPbcT5
 ch1xTgqi48C19EpBp1AeGt6WWtiM3SBQqCymbfCx0ixlYlg/rgBxPIaAN1uQdxOewYs+kuwm+
 M8o46t6NeBYyLfm6+2CbUAsqtwY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/7 08:42, Dave Chinner wrote:
> On Fri, Oct 06, 2023 at 05:16:31PM +1030, Qu Wenruo wrote:
>> However for the whole btrfs/fstests combination, we have several
>> features which can not be easily integrated into fstests.
>>
>> The biggest example is multi-device management.
>>
>> For now, only some btrfs specific test cases are utilizing
>> SCRATCH_DEV_POOL to cover multi-device functionality (including all the
>> RAID and seed support).
>> This means way less coverage for seed and btrfs RAID, all generic group
>> would not utilize btrfs RAID/seed functionality at all.
>
> IOWs, you are saying that the btrfs device setup code in fstests is
> functionally deficient.

It always needs the test case to utilize the pool, and choose mkfs
profiles, to proper enable different profiles.

For seed device, it need the test case to enable seed feature, then add
a new device to allow seed sprout.

Thus none of the generic group can utilize them.

>
>>
>> For a better coverage, or for more complex setup (maybe dm-dust for XFS
>> log device?), I am not that convinced if the current plain mkfs options
>> is good enough.
>
> We already know mkfs alone isn't sufficent - that's why we have
> filesystem specific mkfs fucntions for any filesystem that needs to
> do something more complex than run mkfs....

Still not enough for above seed sprout, or to utilize the pool by default.

Sure, you can go the existing environment variables, but that would lead
to other problems explained later.

>
> i.e. we already have infrastructure that we use to solve this
> problem - there are example implementations that you can look at to
> follow.
>
>>
>> Thus I'm more interested in exploring the possibility to "out-source"
>> those basic functionality (from mkfs to check) to outside scripts, as
>> we're not that far away to hit the limits of the existing framework. (A=
t
>> least for btrfs)
>
> The whole idea that we set up devices for testing via magic,
> undocumented, private external scripts is antithetical to the
> purpose of fstests. The device model used in fstests is that you tell it
> what configuration you want, and it does all the work to set them up
> that way. This allows tests to override or skip incompatible
> configurations based on known config variables, etc.

Nope, the "private/closed-source" is only optional.

We would still provide something like this:

mkfs.avail/
|- xfs.sh
|- xfs_external_log.sh
|- btrfs_single.sh
|- btrfs_multi.sh

fsck.avail/
|- xfs.sh
|- btrfs_check_data_csum.sh
|- btrfs.sh

mount.avail/
|- xfs.sh
|- btrfs.sh
|- btrfs_compression.sh

config/
|- mkfs.sh -> ../mkfs.avail/btrfs_single.sh
|- check.sh -> ../fsck.avail/btrfs.sh
|- mount.sh -> ../mount.avail/btrfs_compression.sh

Those basic ones in *.avail/ should still be open-sourced, and managed
by fstests.

It's end users' freedom to open or hide their scripts, but if they
choose to hide, then all the reproducibility problem and maintenance
burden are all on their own.

>
> It also allows -everyone- to test complex configurations without
> needing to share private, external scripts or knowing any of the
> intricate details needed to set up that configuration. External
> scripts are like proprietary code - it only works if you have some
> magic secret sauce that nobody else knows about.

Aren't there more than enough undocumented environment variables already
in common/config?

It's no different than those separate scripts, and I can also argue
those scripts would have a better naming than `common/config` or
`common/rc`.

>
> If it's hard to set something up in fstests, then *fix that
> problem*. If you are adding code in environment variables and
> hacking in environment varaibles to run that code, then the -code
> itself- should be in fstests.

It's not possible unless we're going to update every generic test cases
to let them specify whatever special setup they want to use for btrfs.

As mentioned, for seed devices, we always need to add a device to do the
sprout, and for multi-devices, we need to specify the number of devices
and profiles at least.

Meanwhile generic tests just go "_scratch_mkfs" and "_scratch_mount",
unless we can override them, it's not that simple.

And if we want to override them, then I see no reason not to go external
scripts to override those functions.
At least much cleaner than export whatever complex environment variables
and involved parsers for them.

>
> Having the code in fstests means that anyone can add
> "BTRFS_SCRATCH_UUID=3D'<uuid>' to their config file to change uuids
> for the devices being tested. They don't need to know waht magic
> command is needed to do this, when it needs to be set, what changes
> elsewhere in fstests they need to watch out for, which tests is
> might conflict with, etc.
>
> Hiding this in some custom script means it can't be easily
> documented,

Nor are those special environment variables.
The "SCRATCH_DEV_POOL" is already not that well documented in
"common/config".


Complexity is unavoidable, but if we want to make simple things complex
or simple is what we can choose.

> can't be easily or widely replicated,

If your setup is using some complex LVM/DM setup, and you just share
your config as:

SCRATCH_DEV=3D"/dev/dm-2"
TEST_DEV=3D"/dev/dm-3"

I don't see it's any different.

In fact, if they share a script like "mkfs.avail/xfs_complex_lvm.sh", it
would be much more clear.


This just shows another point, your existing simpleness is based on the
point that you rely on dm/fs layer to do a lot setup work already.

That's already not part of the fstests, and all the problems can also
apply here.

> it can't be
> discovered by reading the fstests code, and it isn't obvious to
> -anyone- that it is part of the btrfs test matrix that needs to be
> exercised.

Nor the dm setup case either.

And I already said, the external scripts can be part of fstests.
But I also allow end users to hide their scripts for whatever reasons,
it would be recommended for them to open-source (and merged if we see a
real wide benefits), for maintenance or reproducibility reasons, but
that's not mandatory.

>
> IOWs, it's just really bad QA architecture to externalise random
> parts of the test environment configuration.  If the configuration
> needs to be tested, then the infrastructure should support that
> directly and it should be easily discoverable and used by people
> largely unfamiliar with btrfs volume management (i.e. typical distro
> QA environment).

I won't be surprised that "mkfs.avail/btrfs_single.sh" is more readable
than jumping between "common/config", "common/btrfs", "common/rc" or
whatever other files.

>
>>> I suppose the problem there is that mkfs.btrfs won't itself create a
>>> filesystem with the metadata_uuid field that doesn't match the other
>>> uuid?
>>
>> That's not a big deal, we (at least me) are very open to add this mkfs
>> feature.
>>
>> But there are other limits, like the fsck part.
>>
>> For now, btrfs follows the behavior of other fses, just check the
>> correctness of the metadata, and ignore the correctness of data.
>>
>> But remember btrfs has data checksum by default, thus it can easily
>> verify the data too, and we have the extra switch ("--check-data-csum"
>> option) to enable that for "btrfs check".
>
> Which is yet another arguement for the code being in fstests and
> controlled by an environment variable.
>
> This is *exactly* the case for the LARGE_SCRATCH_DEV stuff that ext4
> and XFS support in the mkfs routines. On the XFS side we have
> LARGE_SCRATCH_DEV checks in -both- the XFS mkfs and check/repair
> functions to handle this configuration correctly.

If LARGE_SCRATCH_DEV feature also implies verifying data checksum during
fsck, I'm strongly wondering if any end user would be happy when fsck a
10TB fs and waiting hours, just after a unexpected powerloss.

I can also go with cases like compression feature, bounding a feature to
mkfs flag or offline tuning, is not flex nor end user friendly.

Yes, for some cases, paired fs features are good, especially for
fstests, but sometimes it's not.

(Although for the very initial intention of this patchset, I still
believe we need "mkfs.btrfs --metadata-uuid" option, that problem itself
is not worthy all the hassle)

That's why we allow end users to choose if they want to verify data
checksum at fsck time, just as an example.

>
> IOWs, what you want to do is add a config variable for
> BTFS_SCRATCH_CHECK_DATA, and trigger off that in all btrfs specific
> functions that need to add, modify or check data checksums.

Yes, for this check-data-csum case, it's possible to go environment
variables.

But more and more variables are just also going undocumented, just as
you worried for external scripts.

>
>> For now we're not going to enable the "--check-data-csum" option nor we
>> have the ability to teach fstests how to change the behavior.
>
> We most certainly do have the ability to do this in fstests, and
> quite easily.
>
> Another example is the USE_EXTERNAL variable that tells XFS and ext4
> that external log devices (and rt devices for XFS) are to be used.
> This has hooks all over mkfs, mount, check, repair, xfs_db, quota
> and fs population functions so that they all specify devices
> appropriately.
>
> That is, this config variable directly modifies the command lines
> used for these operations - it is an even better example of FS
> specific device configuration driving by config variables than
> LARGE_SCRATCH_DEV.  This model will work just fine for stuff like
> the --check-data-csum btrfs specific check option being talked about
> here, and the only thing that needs to change is the btrfs specific
> check/repair functions...

I have already explained, sometimes end users really want to choose
between checking just several megabytes of metadata, and checking
several terabytes of data.

Thus paired and on-disk flags is not always the best solution for real
world usage.

>
>> Thus I'm taking the chance to explore any way to "out-source" those
>> mkfs/fsck functionality, even this means other fses may not even bother
>> as the current framework just works good enough for them.
>
> And as I said above, that's the wrong model for fstests - it means
> that a typical QA environment is not going to be able to test
> complex things because the people running the tests do not know how
> to write these complex "out-sourced" scripts to configure the test
> environment.

See my "TEST_DEV=3D/dev/dm-3" vs "mkfs.avail/xfs_lvm_luks.sh" case.

>
> Having all the code in fstests and triggering it via a config
> variable is the right way to do this sort of thing. It works for
> everyone and it's easy to replicate the test environment and
> configurations for reproduction of issues that are found.

Mentioned already, the script can be managed by fstests, either as an
example (need users to modify a little) or guaranteed/recommended test
combinations.

>
> If the test envirnoment is dependent on private scripts for
> configuration and reproduction of issues, then how do other people
> reproduce the problems you might find? Yeah, you have to share all
> your scripts for everyone to run, and at that point the code
> actually needs to be in fstests itself because it's proven to be a
> useful test configuration that everyone should be running....

The existing one is already dependent on the black box block device
provided by end users.

>
>> But IIRC, even f2fs is gaining multi-device support, I believe this is
>> not a btrfs specific thing, but a framework limitation.
>
> The scratch dev pool was an easy extension to support multi-device
> btrfs filesystems done in the really early days when there was
> almost zero btrfs specific test coverage in fstests. I'm not
> surprised that it has warts and may not do everything that btrfs
> developers might need these days.
>
> However, we don't need custom hooks to externalise scripts - we
> already have a working model for config driven filesystem specific
> device configuration. I don't see that there is any major common
> infrastructure change needed, most of what I'm hearing is that the
> btrfs specific device configuration needs to catch up with how other
> filesystems have been testing complex device configurations....

External scripts make overriding _scratch_mkfs() and fsck much easier,
and can still be managed by fstests.

The idea of "external" scripts is to make simple things simple, if your
setup/fs doesn't need complex setup, your mount.sh/mkfs.sh/check.sh
would just be one line for your fs.

Meanwhile if you want to go complex, you have all the freedom, while not
to make other code complex/bloated.

We can even move a lot of notrun checks into the special scripts, making
most test cases just to care about their workload on a very basic setup.
Let the complex setup to check if they are really suitable for that test
case.

Sure there would be some complexity in the communication, but I still
believe this would make most test cases/infrastructure simpler.

Thanks,
Qu

>
> Cheers,
>
> Dave.
