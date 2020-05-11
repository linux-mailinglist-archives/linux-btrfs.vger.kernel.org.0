Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBDB1CCF37
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 03:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgEKBjL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 21:39:11 -0400
Received: from ipmail04.adl3.internode.on.net ([150.101.137.10]:5812 "EHLO
        ipmail04.adl3.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728381AbgEKBjL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 21:39:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DpAQDMq7he/9y5pztmHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgTYEAQELAYIpgUQyhFCOeYFkCCWbYAsBPAECBAEBhEQCgg4?=
 =?us-ascii?q?kNwYOAhABAQYBAQEBAQUEbYVihXIBBSNWEAsOCgICJgICPBsGDQgBAYMigny?=
 =?us-ascii?q?tWYEyiSCBQCJsKgGMQxqCAIERJwwDglo+aYZ5gmAEjiSKc4FPmAWBOYEbgQO?=
 =?us-ascii?q?XHyOdOq9XI4FWMxoIFxmDJU8YDZBMF443LwNnAgYIAQEDCVkBAYtwBCeCGgE?=
 =?us-ascii?q?B?=
Received: from podling.glasswings.com.au ([59.167.185.220])
  by ipmail04.adl3.internode.on.net with ESMTP; 11 May 2020 11:09:04 +0930
Received: from dash ([192.168.21.15])
        by podling.glasswings.com.au with esmtp (Exim 4.89)
        (envelope-from <andrew@sericyb.com.au>)
        id 1jXxPL-0005DR-Tm; Mon, 11 May 2020 11:39:03 +1000
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
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
 <04f481fd-b8e5-7df6-d547-ece9ab6b8154@sericyb.com.au>
 <CAJCQCtTdSSX15Y7YX7fAg+iKncZf09ZG6KnHmmo4S77OtGWWXw@mail.gmail.com>
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
Message-ID: <b41da576-55b2-4599-10e9-e8aeb0e9ad20@sericyb.com.au>
Date:   Mon, 11 May 2020 11:39:03 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTdSSX15Y7YX7fAg+iKncZf09ZG6KnHmmo4S77OtGWWXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/5/20 6:33 am, Chris Murphy wrote:
> 2. That a scrub started, then cancelled, then resumed, also does
> finish (or not).

OK, I have now run a scrub with multiple cancel and resumes and that
also proceeded and finished normally as expected:

$ sudo ./btrfs scrub status -d /home
NOTE: Reading progress from status file
UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
scrub device /dev/sda (id 1) history
Scrub resumed:    Mon May 11 06:06:37 2020
Status:           finished
Duration:         7:27:31
Total to scrub:   3.67TiB
Rate:             142.96MiB/s
Error summary:    no errors found
scrub device /dev/sdb (id 2) history
Scrub resumed:    Mon May 11 06:06:37 2020
Status:           finished
Duration:         7:27:15
Total to scrub:   3.67TiB
Rate:             143.04MiB/s
Error summary:    no errors found

[54472.936094] BTRFS info (device sda): scrub: started on devid 2
[54472.936095] BTRFS info (device sda): scrub: started on devid 1
[55224.956293] BTRFS info (device sda): scrub: not finished on devid 1
with status: -125
[55226.356563] BTRFS info (device sda): scrub: not finished on devid 2
with status: -125
[58775.602370] BTRFS info (device sda): scrub: started on devid 1
[58775.602372] BTRFS info (device sda): scrub: started on devid 2
[72393.296199] BTRFS info (device sda): scrub: not finished on devid 1
with status: -125
[72393.296215] BTRFS info (device sda): scrub: not finished on devid 2
with status: -125
[77731.999603] BTRFS info (device sda): scrub: started on devid 1
[77731.999604] BTRFS info (device sda): scrub: started on devid 2
[87727.510382] BTRFS info (device sda): scrub: not finished on devid 1
with status: -125
[87727.582401] BTRFS info (device sda): scrub: not finished on devid 2
with status: -125
[89358.196384] BTRFS info (device sda): scrub: started on devid 1
[89358.196386] BTRFS info (device sda): scrub: started on devid 2
[89830.639654] BTRFS info (device sda): scrub: not finished on devid 2
with status: -125
[89830.856232] BTRFS info (device sda): scrub: not finished on devid 1
with status: -125
[94486.300097] BTRFS info (device sda): scrub: started on devid 2
[94486.300098] BTRFS info (device sda): scrub: started on devid 1
[96223.185459] BTRFS info (device sda): scrub: not finished on devid 1
with status: -125
[96223.227246] BTRFS info (device sda): scrub: not finished on devid 2
with status: -125
[97810.489388] BTRFS info (device sda): scrub: started on devid 1
[97810.540625] BTRFS info (device sda): scrub: started on devid 2
[98068.987932] BTRFS info (device sda): scrub: finished on devid 2 with
status: 0
[98085.771626] BTRFS info (device sda): scrub: finished on devid 1 with
status: 0

So by elimination it's starting to look like suspend-to-RAM might be
part of the problem.  That's what I'll test next.

Cheers,
	Andrew
