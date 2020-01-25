Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8943B14954F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 12:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgAYLeS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 25 Jan 2020 06:34:18 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:40315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgAYLeS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 06:34:18 -0500
Received: from [192.168.177.20] ([91.63.166.203]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MsrV2-1jk80G3FAu-00tBQu
 for <linux-btrfs@vger.kernel.org>; Sat, 25 Jan 2020 12:34:16 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Broken Filesystem
Date:   Sat, 25 Jan 2020 11:34:10 +0000
Message-Id: <em16e3d03d-97be-4ddb-b4a4-6a056b469f20@ryzen>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.36908.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:DY859uVZQaNAXCMyGbaS2RZXnoorRSNU23l67RHJD0b+m7M1jRL
 gTrUxoYk6g0kLeVY0U/ClpkCN+2/Za4jKJZNcDi0Gc0iedQZ9nhlJ2LICZnXDBwXrgKTwod
 IYW26jTtmXGkR3ynqmCVjekEo1tDGzos7xmEHmPrwo2l70Rvh9br0mOfLlT75TZLS8jnQMK
 eJ8na5OWJl4O0ZdG0uknQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6W8ZjKA9+kw=:83QJ9h5adddC1Ksb5C76RM
 HRgrwesbfC5MnhBK7OTeTJ0jpeMTrwPxvpf3jxDSvYK+Xq0MjacC1bzrHG05NR8h7bZkGnE4X
 u+Q/eHHAKNVGTgLNeJ99wf/VLx3CNcwlThf1w/KSZQjv6wy1X1fwebjlzdgPXS3773fwz3KiP
 4SE4xYPAz2aVDQ4SB+pp08SPSJ+RXSl6ZpRPJqWoVvyHeCf059cEt8VrFSZKHS6zZArqT1m14
 pRzRttXNHBZ1XcG7oO1rW91gSbVsedLKdUK+GQbebnp3kUdV9dqCUiypaB1QGrZXwEVX4prT+
 q/W1k4xerFm6b3Gk7Zo1SwnuccKkyVQTNKbC6ceiYY4wM+iJB6gV3BpZZxdsRnU84U4I5J3HA
 Rz+KRFzzFfkJSNeH1osBV7bj0CNwVSOmQlgGIy9uyEogWF40bz5yq6Ro07muAWHVVm/84phhT
 sk2xw1Vdr4SLSkK9esKNcqTBAE+s3micM8LJjGQHXeDExP3xow75cnn5/Vsmpkc7SWPwnNowg
 ZfK7qWdPBCvPNG+fWKZCE4BukaN0ySg7HIkokA816h6pftiL5H8Mf7+G5HzzEbOHuNH+6mFA5
 NUYfxF2o5V6dMY7mKUNQ3c/v7lcHdzYY3KYjLcRj9QQLeEq/EnplyhwdrT+wluKuNvybyMECG
 TWHAKqM1LMNNaWml4GfeVBmURKzRWis3NeBReHj3Wp3nGWiXYGVlK054X1exV1Tbfq2heB0GK
 OeOpFgKnAyWkoTjHwzWICG96zdmqGvJnZ0P0C1yKFz8b2NBIrnM3cGtUqCTKZ28QAJPtgro76
 RlOQxjOUCwoyywTMogqNIaijAVVVT1Yt0jVn3Y5G8xigHoWpIsSzk5OqqHpoGbSBAtRM6us
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I am helping someone here 
https://forum.openmediavault.org/index.php/Thread/29290-Harddrive-Failure-and-Data-Recovery/?postID=226502#post226502 
  to recover his data.
He is new to linux.

Two of his drives have a hardware problem.
btrfs filesystem show /dev/sda
Label: 'sdadisk1' uuid: fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
Total devices 1 FS bytes used 128.00KiB
devid 1 size 931.51GiB used 4.10GiB path /dev/sda

The 4.1GiB are way less than what was used.


We tried to mount with mount -t btrfs -o 
recovery,nospace_cache,clear_cache

[Sat Jan 18 11:40:29 2020] BTRFS warning (device sda): 'recovery' is 
deprecated, use 'usebackuproot' instead
[Sat Jan 18 11:40:29 2020] BTRFS info (device sda): trying to use backup 
root at mount time
[Sat Jan 18 11:40:29 2020] BTRFS info (device sda): disabling disk space 
caching
[Sat Jan 18 11:40:29 2020] BTRFS info (device sda): force clearing of 
disk cache
[Sun Jan 19 11:58:24 2020] BTRFS warning (device sda): 'recovery' is 
deprecated, use 'usebackuproot' instead
[Sun Jan 19 11:58:24 2020] BTRFS info (device sda): trying to use backup 
root at mount time
[Sun Jan 19 11:58:24 2020] BTRFS info (device sda): disabling disk space 
caching
[Sun Jan 19 11:58:24 2020] BTRFS info (device sda): force clearing of 
disk cache


The mountpoint does not show any data when mounted

Scrub did not help:
btrfs scrub start /dev/sda
scrub started on /dev/sda, fsid fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16 
(pid=19881)

btrfs scrub status /dev/sda
scrub status for fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
scrub started at Sun Jan 19 12:03:35 2020 and finished after 00:00:00
total bytes scrubbed: 256.00KiB with 0 errors


btrfs check /dev/sda
Checking filesystem on /dev/sda
UUID: fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
checking extents
checking free space cache
cache and super generation don't match, space cache will be invalidated
checking fs roots
checking csums
checking root refs
found 131072 bytes used err is 0
total csum bytes: 0
total tree bytes: 131072
total fs tree bytes: 32768
total extent tree bytes: 16384
btree space waste bytes: 123986
file data blocks allocated: 0
referenced 0


Also btrfs restore -i -v /dev/sda /srv/dev-disk-by-label-NewDrive2 | tee 
/restorelog.txt did not help:
It came immediately back with 'Reached the end of the tree searching the 
directory'


btrfs-find-root /dev/sda
Superblock thinks the generation is 8
Superblock thinks the level is 0
It did not finish even in 54 hours

I am out of ideas. Can you give further advice?

Regards,
Hendrik

