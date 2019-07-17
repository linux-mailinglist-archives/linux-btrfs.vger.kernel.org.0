Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1AA46BB45
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfGQLTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 07:19:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:41024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfGQLTv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 07:19:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83ECDAFC5;
        Wed, 17 Jul 2019 11:19:49 +0000 (UTC)
Subject: Re: how do I know a subvolume is a snapshot?
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20190716232456.GA26411@tik.uni-stuttgart.de>
 <eff513b1-a77c-cd5f-5af7-87eae73cff6a@suse.com>
 <20190717091100.GC3462@tik.uni-stuttgart.de>
 <b2410ac6-34f9-f459-8301-c70fcbe6159e@suse.com>
 <CAA91j0U1QBruk+JPE4+FZwuKNOz+YeiQOaeM58Viu6iSCYc99g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <18c3652a-ee3d-a56f-7ebf-1be92d112426@suse.com>
Date:   Wed, 17 Jul 2019 14:19:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAA91j0U1QBruk+JPE4+FZwuKNOz+YeiQOaeM58Viu6iSCYc99g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.07.19 г. 13:29 ч., Andrei Borzenkov wrote:
> On Wed, Jul 17, 2019 at 1:14 PM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>>
>>
>> On 17.07.19 г. 12:11 ч., Ulli Horlacher wrote:
>>> On Wed 2019-07-17 (11:24), Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 17.07.19 3. 2:24 G., Ulli Horlacher wrote:
>>>>
>>>>> I thought, I can recognize a snapshot when it has a Parent UUID, but this
>>>>> is not true for snapshots of toplevel subvolumes:
>>>>
>>>> As you have asked this before - in my testing this is not true.
>>>
>>> It is true on all my SUSE and Ubuntu systems, for all versions.
>>
>> That's strange, as I've shown in the previous thread, using the latest
>> master doesn't exhibit this behavior.
> 
> I doubt you are not aware that distributions rarely use latest master.
> 
> Actually I have here openSUSE Tumbleweed; root top level subvolume
> does not have UUID but if I create new filesystem *now* it does. btrfs
> tools have been updated since initial installation.

I have an ubuntu 18.04 installation lying around and I see : 

sudo btrfs subvolume show btrfs-mount/
/
	Name: 			<FS_TREE>
	UUID: 			-
	Parent UUID: 		-
	Received UUID: 		-
	Creation time: 		-
	Subvolume ID: 		5
	Generation: 		4
	Gen at creation: 	0
	Parent ID: 		0
	Top level ID: 		0
	Flags: 			-
	Snapshot(s):

This is really odd... So this indeed seems to be a userspace problem. 
However, creating a subvolume and then a snapshot I see sane output - parent UUID being there and UUID being there for a kernel-created subvol. : 

nborisov@fisk:~/projects/kernel/source$ sudo btrfs subvolume show btrfs-mount/subvol1-snap1/
subvol1-snap1
	Name: 			subvol1-snap1
	UUID: 			3aebb55e-57bc-9c46-9a34-4ac0220d602e
	Parent UUID: 		fe7e68c6-b9c8-ce4d-8467-7229bd39b0eb
	Received UUID: 		-
	Creation time: 		2019-07-17 13:55:31 +0300
	Subvolume ID: 		258
	Generation: 		9
	Gen at creation: 	9
	Parent ID: 		5
	Top level ID: 		5
	Flags: 			-
	Snapshot(s):

nborisov@fisk:~/projects/kernel/source$ sudo btrfs subvolume show btrfs-mount/subvolume1/
subvolume1
	Name: 			subvolume1
	UUID: 			fe7e68c6-b9c8-ce4d-8467-7229bd39b0eb
	Parent UUID: 		-
	Received UUID: 		-
	Creation time: 		2019-07-17 13:55:14 +0300
	Subvolume ID: 		257
	Generation: 		9
	Gen at creation: 	8
	Parent ID: 		5
	Top level ID: 		5
	Flags: 			-
	Snapshot(s):
				subvol1-snap1


> 
> Better question would be - is it possible to fix it for existing
> filesystems that had been created using old tools?
> 
