Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7F6114FDE
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 12:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfLFLjt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 6 Dec 2019 06:39:49 -0500
Received: from rincewind.allchangeplease.de ([85.214.210.89]:58006 "EHLO
        mail.allchangeplease.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLFLjt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 06:39:49 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Dec 2019 06:39:49 EST
Received: from [192.168.188.27] (dslc-082-082-191-073.pools.arcor-ip.net [82.82.191.73])
        by mail.allchangeplease.de (Postfix) with ESMTPSA id 007103E88
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2019 12:31:06 +0100 (CET)
To:     linux-btrfs@vger.kernel.org
From:   =?UTF-8?Q?Bernhard_K=c3=bchnel?= <hupf.vger@allchangeplease.de>
Autocrypt: addr=bkue@allchangeplease.de; prefer-encrypt=mutual; keydata=
 xsDiBEIt8+0RBACMhYuXdcDegppIKcMEeXZi87ChQbj+MZkdQdVdRTlfzs7GlscWL1tOB3Up
 OIHPtEkTp8NM1V093dMcpz1HGvjQ+7Q9f1ISkSyeJxmuw3uOSR6bPOvBaZ/kF2hiw6s429FO
 mNRm+SHEofr4YSWuXs62ebYP7EOtwEA5FyR4IcPVAwCgllE3viTGDpkAHZgiumnL7qYXXsMD
 /32Jsy8IwDfoGm4dA3tUdTELlfe2GFvQO3YGdCHOfZWpslGMlfL57US5zeLjHO/voqhS8J/S
 KcZmOb5XD8SejL9msiCy3XtJjVgscdeEzoNI2PjPlBXdRBw7pvX/4M9BkvZUUE23ZSLr2e1c
 3azULYWoZ1ZcjeZ9jY+1s+iRJRfkA/9wHvFxcw2LilkAM4j6sYynA4+Q4usxfWG4zJ6/y9c4
 EPxm0DsVK6JoG/PVUpVBqHtnTRIg1F0OoBjWUU71N46QTv5hVxOMjKafhXaG71apkEkwJ1bw
 xj2BUqIlLV1vJFq92+Nm29Kk4CKtnNRQVwdOg6yeOpsE8DDgm+PRfk2Eu80qQmVybmhhcmQg
 S8O8aG5lbCA8Ymt1ZUBhbGxjaGFuZ2VwbGVhc2UuZGU+wmMEExECACMCGwMGCwkIBwMCBBUC
 CAMEFgIDAQIeAQIXgAUCVNkVBwIZAQAKCRBpM8hPnu8vqYS5AJ9saNopA6+BalUl4HzfO4hf
 GSK7dwCfZzjp+tebN9EjhkBFs45tUUAdMdbOwU0EQi3z/RAIAL5ncJXepe26Yvnq3C1fJV26
 ZwUd7MtdBpvcr4dfSpB+sDZqvB6k4gc7vDOPQ24YSXKm4FoVGI/mzm+5MZF5gEEzGcfndaTT
 rxHzXbB93BVTrPcg5eDrL3A9jihpf9UASYeHx2J+XPjc81Q0twudBOmqwiWPipJE2Dw4GcFf
 zXgHJr+yWl15setSDkmruOFW7UPuqOf5fkqd+Vo/DmILtAiRZVUHs3xX53xhXiC+YlybgtMt
 +Q5hvmKqQp7x8I35ESDfOB6Bt/QdMaFSDy9s94PdSUcL4NNiukf00JV/8Gk5ATN6oMNAjhif
 sh6cpUs0+IOhdlh5+AyQxnxVKLYtiB8ABAsH/izdb5PjUeMbIdWU3hJKPlyTp53VZTE6XN0Z
 DUXZuJt4NewPurc1zRXqFnBuLP7r+t8UsCxerexoeUOQ3A4WWwR0PUQGJoI1bF3EseS7yywU
 KRLkWfqRi5qZWBZmexMOdyMiTd4+bqKrzT/J/7pXX87B84iqXbPm7RKQCQdxTbR3CwMbi5jz
 hdG1MsBmkgZ/ntNOEG4PLp3f4kzgLrD4mP40cANv4YV22H9vefEE7Z3KqDvH7ObpOpSfMJks
 QvyPSnIr8YZcpPWhyOxDBWR7MmJN1ffSYs4KFshruaA/9fZfFgU906rlGQ116KyBplS1z8aj
 HVdQ0zFWAQ779TQSmlPCSQQYEQIACQUCQi3z/QIbDAAKCRBpM8hPnu8vqS+zAJ9bcTKdIkhS
 iUSXPsNcpudm+QS6TwCfWpIKOyQENBso+FUELB/x5pjz0Ko=
Subject: "btrfs scrub cancel" aborts running replace operation
Message-ID: <bfec29b7-fd82-d358-02da-c1d3992c0bf4@allchangeplease.de>
Date:   Fri, 6 Dec 2019 12:31:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: de-DE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It seems there's a run-time dependency between scrub and replace
operations for which I don't find hints in the documentation.

Steps to reproduce (choosing large-ish file[system] just to ensure the
operations don't finish immediately - I'm not familiar enough with
rate-limiting setup for a more elegant approach):

0. Log software information

# uname -r -m; btrfs version
5.4.1-gentoo x86_64
btrfs-progs v5.4

1. setup a simple multi-device filesystem with one spare and some data

# for i in {1..3}; do truncate -s 512G loop$i; losetup /dev/loop$i
loop$i; done
# mkfs.btrfs -m raid1 -d raid0 /dev/loop{1..2}
# mkdir /mnt/test && mount /dev/loop1 /mnt/test
# dd if=/dev/urandom of=/mnt/test/somedata bs=1M count=65536

2. replace one device with the spare

# btrfs scrub status /mnt/test/; btrfs replace start /dev/loop2
/dev/loop3 /mnt/test/; sleep 1; btrfs scrub status /mnt/test/; btrfs
replace status -1 /mnt/test; btrfs scrub cancel /mnt/test/; sleep 1;
btrfs replace status /mnt/test

output from step 2:

UUID:             eafe3cb7-7ea1-405d-98a9-9dfffee2ea9d
        no stats available
Total to scrub:   64.15GiB
Rate:             0.00B/s
Error summary:    no errors found
UUID:             eafe3cb7-7ea1-405d-98a9-9dfffee2ea9d
        no stats available
Time left:        0:00:00
ETA:              Fri Dec  6 12:10:03 2019
Total to scrub:   64.15GiB
Bytes scrubbed:   0.00B
Rate:             0.00B/s
Error summary:    no errors found
0.1% done, 0 write errs, 0 uncorr. read errs
scrub cancelled
Started on  6.Dec 12:10:02, canceled on  6.Dec 12:10:06 at 0.0%, 0 write
errs, 0 uncorr. read errs


Observations: Prior to starting replace, no scrub is running.
Immediately after issuing replace statement, btrfs scrub status reports
a running scrub operation. After issuing btrfs scrub cancel, the replace
operations is being cancelled instead.


Expectation: As "btrfs scrub cancel" might be issued as part of other
maintenance jobs, it should not affect a replace operation in progress. 
Would it be possible to separate the two operations w.r.t. userspace
tools? Alternatively, should this behaviour be documented?



Regards


Bernhard Kühnel


