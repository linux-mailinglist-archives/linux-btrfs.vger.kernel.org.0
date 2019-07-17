Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CD6B7AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 09:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfGQHwp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 17 Jul 2019 03:52:45 -0400
Received: from rincewind.allchangeplease.de ([85.214.210.89]:58956 "EHLO
        mail.allchangeplease.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfGQHwo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 03:52:44 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 03:52:44 EDT
Received: from [192.168.178.50] (dslb-178-008-198-034.178.008.pools.vodafone-ip.de [178.8.198.34])
        by mail.allchangeplease.de (Postfix) with ESMTPSA id 682251E95
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 09:45:51 +0200 (CEST)
To:     linux-btrfs@vger.kernel.org
References: <20190716232456.GA26411@tik.uni-stuttgart.de>
From:   =?UTF-8?Q?Bernhard_K=c3=bchnel?= <bkue@allchangeplease.de>
Openpgp: preference=signencrypt
Autocrypt: addr=bkue@allchangeplease.de; prefer-encrypt=mutual; keydata=
 mQGiBEIt8+0RBACMhYuXdcDegppIKcMEeXZi87ChQbj+MZkdQdVdRTlfzs7GlscWL1tOB3Up
 OIHPtEkTp8NM1V093dMcpz1HGvjQ+7Q9f1ISkSyeJxmuw3uOSR6bPOvBaZ/kF2hiw6s429FO
 mNRm+SHEofr4YSWuXs62ebYP7EOtwEA5FyR4IcPVAwCgllE3viTGDpkAHZgiumnL7qYXXsMD
 /32Jsy8IwDfoGm4dA3tUdTELlfe2GFvQO3YGdCHOfZWpslGMlfL57US5zeLjHO/voqhS8J/S
 KcZmOb5XD8SejL9msiCy3XtJjVgscdeEzoNI2PjPlBXdRBw7pvX/4M9BkvZUUE23ZSLr2e1c
 3azULYWoZ1ZcjeZ9jY+1s+iRJRfkA/9wHvFxcw2LilkAM4j6sYynA4+Q4usxfWG4zJ6/y9c4
 EPxm0DsVK6JoG/PVUpVBqHtnTRIg1F0OoBjWUU71N46QTv5hVxOMjKafhXaG71apkEkwJ1bw
 xj2BUqIlLV1vJFq92+Nm29Kk4CKtnNRQVwdOg6yeOpsE8DDgm+PRfk2Eu7QqQmVybmhhcmQg
 S8O8aG5lbCA8Ymt1ZUBhbGxjaGFuZ2VwbGVhc2UuZGU+iGMEExECACMCGwMGCwkIBwMCBBUC
 CAMEFgIDAQIeAQIXgAUCVNkVBwIZAQAKCRBpM8hPnu8vqYS5AJ9saNopA6+BalUl4HzfO4hf
 GSK7dwCfZzjp+tebN9EjhkBFs45tUUAdMda5Ag0EQi3z/RAIAL5ncJXepe26Yvnq3C1fJV26
 ZwUd7MtdBpvcr4dfSpB+sDZqvB6k4gc7vDOPQ24YSXKm4FoVGI/mzm+5MZF5gEEzGcfndaTT
 rxHzXbB93BVTrPcg5eDrL3A9jihpf9UASYeHx2J+XPjc81Q0twudBOmqwiWPipJE2Dw4GcFf
 zXgHJr+yWl15setSDkmruOFW7UPuqOf5fkqd+Vo/DmILtAiRZVUHs3xX53xhXiC+YlybgtMt
 +Q5hvmKqQp7x8I35ESDfOB6Bt/QdMaFSDy9s94PdSUcL4NNiukf00JV/8Gk5ATN6oMNAjhif
 sh6cpUs0+IOhdlh5+AyQxnxVKLYtiB8ABAsH/izdb5PjUeMbIdWU3hJKPlyTp53VZTE6XN0Z
 DUXZuJt4NewPurc1zRXqFnBuLP7r+t8UsCxerexoeUOQ3A4WWwR0PUQGJoI1bF3EseS7yywU
 KRLkWfqRi5qZWBZmexMOdyMiTd4+bqKrzT/J/7pXX87B84iqXbPm7RKQCQdxTbR3CwMbi5jz
 hdG1MsBmkgZ/ntNOEG4PLp3f4kzgLrD4mP40cANv4YV22H9vefEE7Z3KqDvH7ObpOpSfMJks
 QvyPSnIr8YZcpPWhyOxDBWR7MmJN1ffSYs4KFshruaA/9fZfFgU906rlGQ116KyBplS1z8aj
 HVdQ0zFWAQ779TQSmlOISQQYEQIACQUCQi3z/QIbDAAKCRBpM8hPnu8vqS+zAJ9bcTKdIkhS
 iUSXPsNcpudm+QS6TwCfWpIKOyQENBso+FUELB/x5pjz0Ko=
Subject: Re: how do I know a subvolume is a snapshot?
Message-ID: <1858db2d-8683-0ba9-cc13-9e654a1fa810@allchangeplease.de>
Date:   Wed, 17 Jul 2019 09:45:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716232456.GA26411@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: de-DE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 17.07.2019 um 01:24 schrieb Ulli Horlacher:
> How do I know that /mnt/tmp/ss is a snapshot?
> I cannot see a snapshot identifier.

From the btrfs-subvolume man page:

>       A snapshot is a subvolume like any other, with given initial
content. By default, snapshots are created
>       read-write. File modifications in a snapshot do not affect the
files in the original subvolume.


I believe the usual practice is to create snapshots with the -r flag and
follow some naming convention (e.g. place them in a common .snapshots
folder named by date), but you're free to switch between read-only and
read-write mode for a snapshot at any time using the btrfs property command.

That allows for some intereresting feats: e.g. there's no guarantee that
a (now) read-only snapshot actually reflects the source's state at
creation time (if someone modified it and re-applied the ro flag). On
the other hand, reverting to a snapshotted state may be as easy as
making the snapshot rw and changing the mount options to use it's
subvolid - no need to copy any files back and forth.


If there is a specific reason why you want to discern snapshots from
other subvolumes (verification/auditing/forensics?), maybe you can get
help here by elaborating further on that.


Bernhard Kühnel


