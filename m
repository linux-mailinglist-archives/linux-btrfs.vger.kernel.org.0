Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF31C81EE
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 07:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGF4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 01:56:33 -0400
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:63384 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbgEGF4d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 01:56:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CEBQCyorNe/9y5pztmHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgUeCKoFDMiqEI45/gWQtm14LATwBAgQBAYREAoIBJDgTAhA?=
 =?us-ascii?q?BAQYBAQEBAQUEbYVihXEBAQEBAgEjVgULCw4GBAICJgICPBsGDQYCAQGDIoJ?=
 =?us-ascii?q?dH69XdoEyiSCBQCJsKoxEGoIAgREnD4JaPmmGd4JgBI4cim6BTpd5gTeBG4E?=
 =?us-ascii?q?Dlw0jnSCvRCKBVjMaCBcZgyRQGA2QSwMXjjcvAzA3AgYIAQEDCVkBAY8mBIJ?=
 =?us-ascii?q?BAQE?=
Received: from podling.glasswings.com.au ([59.167.185.220])
  by ipmail03.adl6.internode.on.net with ESMTP; 07 May 2020 15:26:09 +0930
Received: from dash ([192.168.21.15])
        by podling.glasswings.com.au with esmtp (Exim 4.89)
        (envelope-from <andrew@sericyb.com.au>)
        id 1jWZVt-0003IU-Gt; Thu, 07 May 2020 15:56:05 +1000
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net>
 <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
 <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
 <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au>
 <CAJCQCtTorye5PTcH6crVYES4eAwVphhx3Au6xd7tijef1HU8uA@mail.gmail.com>
 <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
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
Message-ID: <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au>
Date:   Thu, 7 May 2020 15:56:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/5/20 3:36 pm, Chris Murphy wrote:
> This was fixed in 5.2.1. I'm not sure why you're seeing this.
> 
> commit 96ed8e801fa2fc2d8a99e757566293c05572ebe1
> Author: Grzegorz Kowal <grzegorz@amuncode.org>
> Date:   Sun Jul 7 14:58:56 2019 -0300
> 
>     btrfs-progs: scrub: fix ETA calculation

Maybe not fixed under all conditions!  :)

> What I would do is cancel the scrub. And then delete the applicable
> file in /var/lib/btrfs, which is the file that keeps track of the
> scrub. Then do 'btrfs scrub status' on that file system and it should
> say there are no stats, but it'd be interesting to know if Total to
> Scrub is sane.

$ sudo btrfs scrub status /home
UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
	no stats available
Total to scrub:   7.31TiB
Rate:             0.00B/s
Error summary:    no errors found

> You can also start another scrub, and then again check
> status and see if it's still sane or not. If not I'd cancel it and
> keep troubleshooting.

$ sudo btrfs scrub status -d /home
UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
scrub device /dev/sda (id 1) status
Scrub started:    Thu May  7 15:44:21 2020
Status:           running
Duration:         0:06:53
Time left:        9:23:26
ETA:              Fri May  8 01:14:40 2020
Total to scrub:   3.66TiB
Bytes scrubbed:   45.24GiB
Rate:             112.16MiB/s
Error summary:    no errors found
scrub device /dev/sdb (id 2) status
Scrub started:    Thu May  7 15:44:21 2020
Status:           running
Duration:         0:06:53
Time left:        9:24:50
ETA:              Fri May  8 01:16:04 2020
Total to scrub:   3.66TiB
Bytes scrubbed:   45.12GiB
Rate:             111.88MiB/s
Error summary:    no errors found

Still sane after cancelling and resuming.

One thing that might be relevant:  On the original scrub, I started it
on the mountpoint but initially cancelled and resumed it on the device
/dev/sda rather than the mountpoint.  Could that trigger a bug?

Cheers,
	Andrew
