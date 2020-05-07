Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC951C7FBF
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 03:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgEGBMC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 21:12:02 -0400
Received: from ipmail03.adl4.internode.on.net ([150.101.137.145]:43487 "EHLO
        ipmail03.adl4.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728408AbgEGBMB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 21:12:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CBBQCjX7Ne/9y5pztmHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgUeCKoFDMoRNjn6BZC2bXgsBPAECBAEBhEQCggEkOBMCEAE?=
 =?us-ascii?q?BBgEBAQEBBQRthWKFcQEBAQECASNWBQsLDgoCAiYCAjwbBg0IAQGDIoJdH69?=
 =?us-ascii?q?fdoEyiROBQCJsKoxEGoIAgREnD4JaPmmGd4JgBJkKmUeBN4EbgQOXDSOdIK9?=
 =?us-ascii?q?EIoFWMxoIFxmDJU8YDZBLAxeONy8DZwIGCAEBAwlZAQGRawEB?=
Received: from podling.glasswings.com.au ([59.167.185.220])
  by ipmail03.adl4.internode.on.net with ESMTP; 07 May 2020 10:41:56 +0930
Received: from dash ([192.168.21.15])
        by podling.glasswings.com.au with esmtp (Exim 4.89)
        (envelope-from <andrew@sericyb.com.au>)
        id 1jWV4s-0005Jx-5U; Thu, 07 May 2020 11:11:54 +1000
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net>
 <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
 <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
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
Message-ID: <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au>
Date:   Thu, 7 May 2020 11:09:43 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/5/20 9:42 am, Chris Murphy wrote:
> A raid1 volume has twice as many bytes to scrub as data reported by
> df.

It's scrubbed more than twice as many bytes, though.

> Can you tell us what kernel version?

5.4.0

> And also what you get for:
> $ sudo btrfs fi us /mp/

Overall:
    Device size:		  10.92TiB
    Device allocated:		   7.32TiB
    Device unallocated:		   3.59TiB
    Device missing:		     0.00B
    Used:			   7.31TiB
    Free (estimated):		   1.80TiB	(min: 1.80TiB)
    Data ratio:			      2.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)

Data,RAID1: Size:3.65TiB, Used:3.65TiB (99.89%)
   /dev/sda	   3.65TiB
   /dev/sdb	   3.65TiB

Metadata,RAID1: Size:8.00GiB, Used:6.54GiB (81.74%)
   /dev/sda	   8.00GiB
   /dev/sdb	   8.00GiB

System,RAID1: Size:64.00MiB, Used:544.00KiB (0.83%)
   /dev/sda	  64.00MiB
   /dev/sdb	  64.00MiB

Unallocated:
   /dev/sda	   1.80TiB
   /dev/sdb	   1.80TiB

> $ df -h

/dev/sda        5.5T  3.7T  1.9T  67% /home

> I think what you're seeing is a bug. Most of the size reporting in
> btrfs commands is in btrfs-progs; whereas the scrub is initiated by
> user space, most of the work is done by the kernel. But I don't know
> where the tracking code is.

No kidding.  What concerns me now is that the scrub shows no signs of
ever stopping:

$ sudo btrfs scrub status -d /home
UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
scrub device /dev/sda (id 1) status
Scrub started:    Mon May  4 04:36:54 2020
Status:           running
Duration:         18:06:28
Time left:        31009959:50:08
ETA:              Fri Dec 13 03:58:24 5557
Total to scrub:   3.66TiB
Bytes scrubbed:   9.80TiB
Rate:             157.58MiB/s
Error summary:    no errors found
scrub device /dev/sdb (id 2) status
	no stats available
Time left:        30892482:15:09
ETA:              Wed Jul 19 05:23:25 5544
Total to scrub:   3.66TiB
Bytes scrubbed:   8.86TiB
Rate:             158.18MiB/s
Error summary:    no errors found

Cheers,
	Andrew
