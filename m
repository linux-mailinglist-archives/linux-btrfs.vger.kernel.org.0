Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB610EC13
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 16:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLBPIh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 10:08:37 -0500
Received: from mira.cbaines.net ([212.71.252.8]:54092 "EHLO mira.cbaines.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfLBPIh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Dec 2019 10:08:37 -0500
Received: from localhost (unknown [105.156.108.87])
        by mira.cbaines.net (Postfix) with ESMTPSA id A1640177B7;
        Mon,  2 Dec 2019 15:08:33 +0000 (GMT)
Received: from phact (localhost [127.0.0.1])
        by localhost (OpenSMTPD) with ESMTP id 90778d91;
        Mon, 2 Dec 2019 15:08:30 +0000 (UTC)
References: <8736e9g1gb.fsf@cbaines.net> <1ac24ca2-4f78-13a8-0b06-8970e8ba6e17@gmail.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Christopher Baines <mail@cbaines.net>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Slow performance with Btrfs RAID 10 with a failed disk
In-reply-to: <1ac24ca2-4f78-13a8-0b06-8970e8ba6e17@gmail.com>
Date:   Mon, 02 Dec 2019 16:08:27 +0100
Message-ID: <87a78alq8k.fsf@cbaines.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain


Austin S. Hemmelgarn <ahferroin7@gmail.com> writes:

> On 2019-11-27 03:36, Christopher Baines wrote:
>> Hey,
>>
>> I'm using RAID 10, and one of the disks has recently failed [1], and I'm
>> seeing plenty of warning and errors in the dmesg output [2].
>>
>> What kind of performance should be expected from Btrfs when a disk has
>> failed? [3] At the moment, the system seems very slow. One contributing
>> factor may be that all the logging that Btrfs is generating is being
>> written to the btrfs filesystem that's degraded, probably causing more
>> log messages to be produced.
>>
>> I guess that replacing the failed disk is the long term solution to get
>> the filesystem back in to proper operation, but is there anything else
>> that can be done to get it back operating until then?
>>
>> Also, is there anything that can stop btrfs logging so much about the
>> failures, now that I know that a disk has failed?
>
> You can solve both problems by replacing the disc, or if possible,
> just removing it from the array. You should, in theory, be able to
> convert to regular raid1 and then remove the failed disc, though it
> will likely take a while. Given your output below, I'd actually drop
> /dev/sdb as well, and look at replacing both with a single 1TB disc
> like your other three.
>
> The issue here is that BTRFS doesn't see the disc as failed, so it
> keeps trying to access it. That's what's slowing things down (because
> it eventually times out on the access attempt) and why it's logging so
> much (because BTRFS logs every IO error it encounters (like it
> should)).

Thanks for the tips :)

I've now remounted the filesystem with the degraded flag.

However, I haven't managed to remove the disk from the array yet.

$ sudo btrfs filesystem show /
Label: none  uuid: 620115c7-89c7-4d79-a0bb-4957057d9991
	Total devices 6 FS bytes used 1.08TiB
	devid    1 size 72.70GiB used 72.70GiB path /dev/sda3
	devid    2 size 72.70GiB used 72.70GiB path /dev/sdb3
	devid    3 size 931.48GiB used 530.73GiB path /dev/sdc
	devid    4 size 931.48GiB used 530.73GiB path /dev/sdd
	devid    5 size 931.48GiB used 530.73GiB path /dev/sde
	*** Some devices missing

$ sudo btrfs device delete missing /
ERROR: error removing device 'missing': no missing devices found to remove


So Btrfs knows at some level that a device is missing, from the output
of the first command, but it won't delete the missing device.

Am I missing something?

Thanks,

Chris

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEEPonu50WOcg2XVOCyXiijOwuE9XcFAl3lKOtfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDNF
ODlFRUU3NDU4RTcyMEQ5NzU0RTBCMjVFMjhBMzNCMEI4NEY1NzcACgkQXiijOwuE
9XfxiRAAtrSkeSyJfVzhI9trFS1oSDOnaPWvw0A/b1SlMHlwVJaOXqNakBTQZKSg
gyeTVC5Z5X5IaFQ3acV6q3wFZ/rWRREVOxVzqvya+txO06iHPalwgnKKF7+kqMWK
MvOuKuur3kT0RvqiPSZ+JmreoAf66g5P9kAlYN8xUF43MbueYH7MZrVGf3oEVipj
FeTyfxd3h7sgNdw6urpHDgGmhzNzBvBE+x7K+wShcmaqbwq3uUf8eW+lZGdi+QyJ
MO+YCM/+R+8v9tCUU5w+PRTgr6byDY0p+rimYB6eGyFdfYfQ2iDHRJ9X0FU7RcSJ
ujs1SdWBjzscFr9oS3wLAu85UjJ/w6Zfjt8KnVh3Vs89xldrD/vdTgfWhAUKN/em
gqxbpYDfDuZEWhJcXTJYA4iaXa2WAohpsXLv9giazyqCFHvMt6Vc1oY4NSr1Bh2M
DsgKzv6/jUCJm+zmLiFc+KppnojU/Swim0te3TItuzfYTXT4u1ui2HA3z7fbVixn
02GU7hIj6QhgMDRIbXHzb4nTHx4XmBSlymGbZp0Q5EBIA9QyYgl3wCWwlykqQOs4
tbzYM++zFMIa0KLGN8qXMDbqOPmYZ3yU32T+LAU4wNpD065iktf4CKLbbmVB5Jh7
Mwt2G0Njp2uQ6QS4EKh8MQmAeJEAW5BBkNN+/wbKonXobUXty5s=
=fHhE
-----END PGP SIGNATURE-----
--=-=-=--
