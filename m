Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730831C622E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgEEUjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 16:39:21 -0400
Received: from ipmail03.adl4.internode.on.net ([150.101.137.145]:36548 "EHLO
        ipmail03.adl4.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbgEEUjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 May 2020 16:39:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BPEAD9zbFe/9y5pztmHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgUcCgiiBQzKETY8AgWQtmWSBegsBPAECBAEBhEQCgX4kOgQ?=
 =?us-ascii?q?NAhABAQYBAQEBAQUEbYVihXIBBSNmCw4KAgImAgI8GwYBDAgBAYMigny0GYE?=
 =?us-ascii?q?yiQyBQCJsKoxEGoIAgTgPglo+aYZ3gmAEmQqZR4E3gRuBA5cNI4JKAZpVkBe?=
 =?us-ascii?q?fLwEfgVYzGggXGYMlTxgNnxwvA2cCBggBAQMJWQEBkWsBAQ?=
Received: from podling.glasswings.com.au ([59.167.185.220])
  by ipmail03.adl4.internode.on.net with ESMTP; 06 May 2020 06:09:16 +0930
Received: from dash ([192.168.21.15])
        by podling.glasswings.com.au with esmtp (Exim 4.89)
        (envelope-from <andrew@sericyb.com.au>)
        id 1jW4LR-0008Sl-0v; Wed, 06 May 2020 06:39:13 +1000
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net>
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
Message-ID: <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
Date:   Wed, 6 May 2020 06:39:13 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/5/20 7:51 pm, Graham Cobb wrote:
> Is there actually a scrub in progress?

The scrub has been going for a couple of days now, and has scrubbed
considerably more data than exists on the disks.  Will it ever finish?

Thanks,
	Andrew
