Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D421CC040
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 12:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgEIKPx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 06:15:53 -0400
Received: from ipmail04.adl3.internode.on.net ([150.101.137.10]:23116 "EHLO
        ipmail04.adl3.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbgEIKPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 06:15:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ADAgB1grZe/9y5pztmHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgTYEAQELAYIpgUMBMoRQjnuBZC2bYQsBPAECBAEBhEQCgg4?=
 =?us-ascii?q?kNwYOAhABAQYBAQEBAQUEbYVihXEBAQEBAgEjVgULCw4KAgImAgI8GwYNCAE?=
 =?us-ascii?q?BgyKCXR+uAHaBMokmgUAibCoBjEMaggCBEScPglo+aYZ5gmAEjkaKUZlUgTm?=
 =?us-ascii?q?BG4EDlx8jnTqvVyOBVjMaCBcZO4JqTxgNkEkDF443LwNnAgYIAQEDCVkBAY1?=
 =?us-ascii?q?rAQE?=
Received: from podling.glasswings.com.au ([59.167.185.220])
  by ipmail04.adl3.internode.on.net with ESMTP; 09 May 2020 19:45:49 +0930
Received: from dash ([192.168.21.15])
        by podling.glasswings.com.au with esmtp (Exim 4.89)
        (envelope-from <andrew@sericyb.com.au>)
        id 1jXMWL-0003sV-2Z; Sat, 09 May 2020 20:15:49 +1000
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au>
 <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au>
 <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au>
 <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au>
 <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au>
 <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au>
 <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au>
 <CAJCQCtSq7Ocar4hJM0Z+Y7UeRM6Cfi_uwN=QM77F2Eg+MtnNWw@mail.gmail.com>
From:   Andrew Pam <andrew@sericyb.com.au>
Autocrypt: addr=andrew@sericyb.com.au; prefer-encrypt=mutual; keydata=
 mQGiBEPPxa8RBACcBTuSu02Fi+ZhvFj8wYJa8P2xF2djPveAkV5iuv/b1OTlzcdC7yJwNKq8
 STgXoe2C9orhZ+3lO0iIwCkZpYj3purc1CojYE0bFh8EAW85usWox+Nrqsb6JYaoJk0ekyfM
 gogjKGf7MUg4lDwfg1D6iiWJ0Dk6OZwARo9u97sqswCgwki1jozMbKx8LhkzbeNAonRxADED
 /2HcSy+OsR2byqdX2BbaZppXZJEzclQNR7BiSwTPVoOX0jcHY0Sn8rdBUlagSEhv4YJ4Tdwd
 QhPs3qcrFm2GQnStV19cLJ1DvO3TfLEikSetWotBv/6RanXRZRweRE4pm/zZMxX6+zcib+jb
 +UlFg7MSyu+z50g0Bf4b5xH6AW/DBACAsgsJaaD1lDOdFMK7jnUiYXI0Y+LfHJ6xOukYUNqC
 Yaxbw4Bk60DeP7hwUfVPMMxIJZdN+WsrtkijppJG6La9KqapYPu3ByapaLoIjtBOeTJfhcDN
 mcAqZaxDhZ6eIMi+IOyS6/2MK76aLEpYY+0+M8mzUZ3LXi/blYVbS7urobQkQW5kcmV3IFBh
 bSA8eGFubmlAZ2xhc3N3aW5ncy5jb20uYXU+iGEEExECACECGwMGCwkIBwMCAxUCAwMWAgEC
 HgECF4AFAkPPySICGQEACgkQGk9LI6KtAU50ZwCeJfVJEMTSK71XD+WR8z9stEhPovYAniEn
 wBEAHXMO4MlxJPMmnYJWG/rbuQINBEPPxbQQCADZy6E8nqM+1s3t1UaIKzGzF8PuA0R+/Zx3
 5Uh4jHHoJyFt/uuJxyJzOrq9Ilz+fWXOrXK44Ga3wOQ6yR9tIhrGNoQ97Y2S5RSufjNVstS1
 otA0N3a6nUz44rAPwXfFhMKTlUjfUwuvQik3yEF1kyXEU7o78G/XG06M/9s1ur1k4hFvAfCE
 y/fXztx86bC5vlDq2r1MAwE+fMJG/Ok21OekdY0D3KrZ1kOi4kYgRoVIGlgfJE3OXi6W8Lko
 c/oO0UUtEoiKGGOBTewmU8N6G2F3OXiONnZIY+FD/NIe+3YAEWAIc5SoXQs4KCmNxaF6vxRQ
 STBOX2A9Y+LfY4lx5+HzAAMFB/9g0VGTdvnQvogs/0b+FdfvPVflwhbW9VMF12kWwgx9q0Gw
 xcWO8IJWlFQouam5u2QMVMKxsscphAPjWDYP8BVGWFx32/Z5XZnp2xOqjaFSG9BfbEqIUizL
 9AEClL04eBKGmVrhPzr2d0Z7DgF5gxehVYZ7m9dW7heFnuiC+ZaYEGRvfyWsWsOihoDkbify
 Ms1RluUU23wKJFaZzafAX4caD9u3bIUaujKUGCh64nLkaxwmZD2QBw0T9jGCIssVCRHwQmTV
 25eADYmSEwf3ONk4ljzfupTOpCLtNapGc3vZO84CQSv9bl3l24uBvVRWaqLJMO0NzAn+qbes
 U3w6WMBCiEkEGBECAAkFAkPPxbUCGwwACgkQGk9LI6KtAU59IACggRqLORG73pZUK1pRh02T
 5kUwjTQAn1F0m2Mx72juiYwF0IKljJ7lR0TR
Organization: Serious Cybernetics
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAALVBMVEUrHhk8LSRTQTZuVkmC
 UkaKalykaGZ3h7KmgG+ahH68lYWXn7mxmpTSqZ3CvLqleibHAAACZElEQVQ4y3XUPWvbQBgH8FOg
 Qzef3EKnEp+qIaOlGJzFi+Xg0YMFcoeMod/AFDpksMpxeHCSZhAYUxoo8mF16NylLYXUCG2F1uSW
 eCimJp+hz+nNctKesTH30/P87ySf0e1/Bsq/hZ4X/Qu+XxiEHNyH9blBsEoOorvwzSQVjAnRJtuw
 Mkk6MknhnGBSIQRiiF6ElZzNxlEBzpIuEKMSrG1gbaQXQz7GaiOHVd5GSpISw42cg0vlJ6TFC0NJ
 BOwuAaKZBmlkQGAKIwWrmrnv2K66l8KqUlFxCSFFo5T5jMchEpYyEqFS+bkQgge8qqVwI6ehoB4I
 ORYdNYUvGCswr3ORwImSA4KXzpICIU7QJIHTkoIVnaUFQoxQIwVopTi8AEcJVHFJ2QGAxUK3qTfK
 WlUhAYD6rsXEomt3snAAJMGtWW3xo+V0djKAxe4w7jf33rSDS3IxepjCLuyuzAJOx/RF4Pfo26cZ
 QMVjyPUpo8HPY/Y5u7tVqHhEYUELzgN4v4tSOEWK8ozG2wAIxK/sCS5RmeiUSfCDhRAfMljjJ4NW
 AvH9ivJnXn3wvhXvesGYCDYQjtAhAIRw65BynsMZLMqiVC7Jtdqc5z+4pYn0rsM453PP7s1nOawN
 pTaQMPW45403cLvENWoDuA6bTZ0CfC3VqQ0Z/BgGnRQqUJ26stdrAD/aAh6X+F2rPS0cnBWAbycl
 bFg8UbsAru3wQISzqAgf63xOu7YXhqG3dWr7tWHgD0yz53lbx/lP/+U4hNvRNMza1h/A737/U3h9
 1d1vNnt3oR9eh65tO8N78CoMr2CT4wz+AgHlxhkkWxq2AAAAAElFTkSuQmCC
Message-ID: <04f481fd-b8e5-7df6-d547-ece9ab6b8154@sericyb.com.au>
Date:   Sat, 9 May 2020 20:15:49 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSq7Ocar4hJM0Z+Y7UeRM6Cfi_uwN=QM77F2Eg+MtnNWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/5/20 7:31 am, Chris Murphy wrote:
> Do you have qgroups enabled?
> 
> $ sudo btrfs qgroup show /home
> ERROR: can't list qgroups: quotas not enabled

No:

$ sudo btrfs qgroup show /home
ERROR: can't list qgroups: quotas not enabled

> What do you get for:
> 
> $ sudo btrfs insp dump-s /dev/
> 
> This dumps out the super block.

$ sudo btrfs insp dump-s /dev/sda
superblock: bytenr=65536, device=/dev/sda
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x36e3f416 [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			85069ce9-be06-4c92-b8c1-8a0f685e43c6
metadata_uuid		85069ce9-be06-4c92-b8c1-8a0f685e43c6
label			home
generation		59159
root			4881572642816
sys_array_size		258
chunk_root_generation	58225
root_level		1
chunk_root		4925720363008
chunk_root_level	1
log_root		4881575936000
log_root_transid	0
log_root_level		0
total_bytes		12002350252032
bytes_used		4022988615680
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		2
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x161
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	59159
uuid_tree_generation	59159
dev_item.uuid		b347d8aa-4563-45db-bcf1-c722e5b3abe8
dev_item.fsid		85069ce9-be06-4c92-b8c1-8a0f685e43c6 [match]
dev_item.type		0
dev_item.total_bytes	6001175126016
dev_item.bytes_used	4055589978112
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0

> There are scrub related fixes in linux git since 5.4.0 but I can't
> tell if any of them are related to this problem. My suggestion is
> scrub with kernel 5.7.rc4. If the problem happens, it's a current and
> unfixed bug. If it's been fixed, then it's a question of what commit
> fixed it and whether it's been backported, or can be, to 5.4 series.

OK, I installed 5.7rc4 and rebooted, then started a fresh scrub:

$ uname -a
Linux RainbowDash 5.7.0-050700rc4-generic #202005051752 SMP Tue May 5
21:56:32 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

After a couple of cancel/resumes here we are again:

$ sudo btrfs scrub status -dR /home
UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
scrub device /dev/sda (id 1) status
Scrub started:    Sat May  9 15:52:21 2020
Status:           running
Duration:         2:25:03
	data_extents_scrubbed: 22903068
	tree_extents_scrubbed: 194348
	data_bytes_scrubbed: 1418082578432
	tree_bytes_scrubbed: 3184197632
	read_errors: 0
	csum_errors: 0
	verify_errors: 0
	no_csum: 60164
	csum_discards: 0
	super_errors: 0
	malloc_errors: 0
	uncorrectable_errors: 0
	unverified_errors: 0
	corrected_errors: 0
	last_physical: 0
scrub device /dev/sdb (id 2) status
Scrub started:    Sat May  9 15:52:21 2020
Status:           running
Duration:         2:25:03
	data_extents_scrubbed: 22903070
	tree_extents_scrubbed: 194348
	data_bytes_scrubbed: 1418082648064
	tree_bytes_scrubbed: 3184197632
	read_errors: 0
	csum_errors: 0
	verify_errors: 0
	no_csum: 60164
	csum_discards: 0
	super_errors: 0
	malloc_errors: 0
	uncorrectable_errors: 0
	unverified_errors: 0
	corrected_errors: 0
	last_physical: 0

Duration, time left and bytes scrubbed are not advancing, and
last_physical is zero.

Thanks,
	Andrew
