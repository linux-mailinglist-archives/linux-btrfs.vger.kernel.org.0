Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA201C52A7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 12:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgEEKKL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 06:10:11 -0400
Received: from ipmail03.adl4.internode.on.net ([150.101.137.145]:17272 "EHLO
        ipmail03.adl4.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728430AbgEEKKL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 May 2020 06:10:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DTAQDvOrFe/9y5pztmGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAUCBR4IqgUMyhE2Of4FkCCWbXgsBPAECBAEBhEQCgi0?=
 =?us-ascii?q?kOBMCEAEBBgEBAQEBBQRthWKFcQEBAQECASNbCwsOCgICJgICPBsGAQwIAQG?=
 =?us-ascii?q?DIoJdH7IXdoEyiUeBQCJsKoxEGoIAgREnDAOCWj5phneCYASZCplHgTeBG4E?=
 =?us-ascii?q?Dlw0jnSCQF58tIoFWMxoIFxmDJU8YDZBLAxeONy8DZwIGCAEBAwlZAQGPJgS?=
 =?us-ascii?q?CQQEB?=
Received: from podling.glasswings.com.au ([59.167.185.220])
  by ipmail03.adl4.internode.on.net with ESMTP; 05 May 2020 19:40:07 +0930
Received: from dash ([192.168.21.15])
        by podling.glasswings.com.au with esmtp (Exim 4.89)
        (envelope-from <andrew@sericyb.com.au>)
        id 1jVuWa-0003sS-Mh; Tue, 05 May 2020 20:10:04 +1000
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
Message-ID: <7023fbc0-2715-fa3a-58c1-ebe95054a9a4@sericyb.com.au>
Date:   Tue, 5 May 2020 20:10:04 +1000
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
> On 05/05/2020 06:46, Andrew Pam wrote:
>> $ sudo btrfs scrub status /home
>> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
>> 	no stats available
>> Time left:        16964119:40:20
>> ETA:              Mon Aug  8 23:23:14 3955
>> Total to scrub:   7.30TiB
>> Bytes scrubbed:   10.20TiB
>> Rate:             288.06MiB/s
>> Error summary:    no errors found
> 
> btrfs-progs version? (output from 'btrfs version')

btrfs-progs v5.4.1

> Is there actually a scrub in progress?

Yes.

> Presumably there is no stats file? Try 'cat
> /var/lib/btrfs/scrub.status.85069ce9-be06-4c92-b8c1-8a0f685e43c6'

scrub status:1
85069ce9-be06-4c92-b8c1-8a0f685e43c6:1|data_extents_scrubbed:116366415|tree_extents_scrubbed:1154955|data_bytes_scrubbed:7193709023232|tree_bytes_scrubbed:18922782720|read_errors:0|csum_errors:0|verify_errors:0|no_csum:363202|csum_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corrected_errors:0|last_physical:0|t_start:1588531014|t_resumed:0|duration:43505|canceled:0|finished:0
85069ce9-be06-4c92-b8c1-8a0f685e43c6:2|data_extents_scrubbed:99457032|tree_extents_scrubbed:899136|data_bytes_scrubbed:6169469337600|tree_bytes_scrubbed:14731444224|read_errors:0|csum_errors:0|verify_errors:0|no_csum:306304|csum_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corrected_errors:0|last_physical:0|t_start:0|t_resumed:0|duration:37079|canceled:0|finished:0

> Is this a multi-device filesystem?

Yes.

> See what 'btrfs scrub status -d /home' says.

UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
scrub device /dev/sda (id 1) status
Scrub resumed:    Tue May  5 20:08:45 2020
Status:           running
Duration:         12:05:35
Time left:        30907070:08:51
ETA:              Sun Mar 17 11:18:10 5546
Total to scrub:   3.66TiB
Bytes scrubbed:   6.56TiB
Rate:             158.11MiB/s
Error summary:    no errors found
scrub device /dev/sdb (id 2) status
	no stats available
Time left:        30720615:37:35
ETA:              Mon Dec  8 12:46:54 5524
Total to scrub:   3.66TiB
Bytes scrubbed:   5.63TiB
Rate:             159.07MiB/s
Error summary:    no errors found

Cheers,
	Andrew
