Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E548364FE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 03:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhDTBez (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 21:34:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:49999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhDTBey (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 21:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618882458;
        bh=YTd29X+pRerdjwDALYh3J62MPJ1YbNr7x+yPCWgASQQ=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=k1v+jCsBatA+yLUZW4MISB7wMj4A8KAamE/BM1hLRo1HQlS6VEbO44rIy1OzbJvJ4
         X+J7IBVV7+nRvWAu4T1fqMLoCFeuKI1bjatKlEK1HQ1ciZgEFBTstwAy50GGfx/tAX
         ze5G8Bxh6cbXA3wOXXv15xH7I4auJDW8menP71Hs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbAcs-1m5n6X41Zg-00bdBA; Tue, 20
 Apr 2021 03:34:18 +0200
To:     "Gervais, Francois" <FGervais@distech-controls.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <FdManana@suse.com>
References: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
 <666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
 <SN6PR01MB42690A51D0752719B9F1C6ACF3499@SN6PR01MB4269.prod.exchangelabs.com>
 <41e13913-398a-96b8-0f6f-00cfc83c6304@gmx.com>
 <SN6PR01MB4269861CA9BA4D5E61DF1030F3499@SN6PR01MB4269.prod.exchangelabs.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: read time tree block corruption detected
Message-ID: <709d1a70-e52a-0ff3-8425-f86f18ac0641@gmx.com>
Date:   Tue, 20 Apr 2021 09:34:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <SN6PR01MB4269861CA9BA4D5E61DF1030F3499@SN6PR01MB4269.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h6OVra1yMdO3dVwiINXLdZw4PiOs/YTKrrxPsEZ/uukhAKqm5G+
 c4tcnr2xUhHrUR10QOS1ai/4PjyJ2Hpecy7OfXHyaC5jbQbtJNY/UFNi1sEruo01AWvISnL
 HtJriLjS/lXSRGB9WVntRmlIp2PridJvGyh0PlxmJ2syuzgj8az03ioRcWbsz8Yx7Zl+bZH
 sxgx0d3uJMDUInvm5+A8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kv8qHUZcYzU=:XO4STS7iC2UIwpOEqiH0Yo
 8AEOAJ/c7LybIABkFaNsoeypqIEo3PEeTSvxC3gbt30Mvt+gRC8VgvTQR3csuQGEl87OwRUdK
 QIYLfo/LRME+drf3uJLlsSL5z27mHab1asJHLU6tBA2XOEt8DWz2I7QrMky3ARZiYEweagEds
 97YyDZSBCiNudjNoB8v+51x8gU1HxsT3uD9A7lwaGVJ8dTeqnloQ4wEx6/To4iSZ2240cFRnj
 hTrfk/ekxehpP9c0UC9JfTIVhxGbU0ibwwAZ0tLNQ9kYtT15RNHdb3IbBhmMYAIeB7+OjgVnS
 v5i7ugVuKHK13HjGIaccH9Qkya5g+G93Z0VVqQ+uUArR44K3UCFJh/39WUA+TduzcIw4K8oMP
 L2JPARj4lOz/gAmd/z++84GwY30T8WXPUhJC3ctZ5WMxLN1V1UpP9wnuF1atoEnHjefjvWGzr
 1rIZo5JOcqzNbdBJKztZNrtblF+cse2iEFsKNscMN3K3a6c5icHwaSJwIGKuXpOu5zg1/GAjE
 LKB2sDgU2G+D7Pp0UG9vtu9JnQiTI2boVYBj1436EMOZRqaK0O6evLicH3c4qVUwffHiv3S53
 x1tH00kLm6rhNVeVhWPJ4+BhMBf6wOPO59SNp13jhEUqgwpne6mPutSCYlcNtLw+MyfiLjWDJ
 KVdBtQao9M0VagOTkWoHmFzOda6u29HRkuFnSBXfgf8tpAHqMwlgrN7MjtUjN3At1yiyvQ55f
 eXVhe0xt++IPh6mDTz/TDN4o6NQE+ejjaIwc2YJvdDSmuSjigUP8tthVo9TjsGBkogn6UkcuS
 n9v6MZ+hPMoq5ZV6KVyiJ/r4uZYxKK9HhyXJneF0u0vbzO+6bO7jbJLMJlT6nQXVM1VHtnKDf
 xDnpKFXqslJFnpfnip65Z0IL3rjfBXyXw03UmEbFGhisqkK38NVBaA07SZS7MTkvkdZqZA+Bl
 S25rfzNkWT/pj/ZUo1RFVky/qI5IeMsA/J68gpJiAplnI/kZI711Gyp7oxx/L3LeIxSUulQ6P
 fTsSOLj7lSqd8qPJs4eHQCE+6ewsefgZmwYy5VWX4DKAW964dKnCkImBVxcSPOMaj8nYVzbHO
 x5PnsdtSitSzYOZ7pT1zp4DdUzUhFp4NKBXCWx063bHGK2zvCGQpEv3kRLIbjnuKRayUmVLMI
 1AnzmBMhvx3RMswLWZxwfETkl1OlzZaTRPhAGSROEsIhxTg5q/uJb3CVP8cjgrxBX0cN/qR06
 32P48UGml5QJilfaO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/19 =E4=B8=8B=E5=8D=8810:56, Gervais, Francois wrote:
>> My bad, wrong number.
>>
>> The correct number command is:
>> # btrfs ins dump-tree -b 790151168 /dev/loop0p3
>
>
> root@debug:~# btrfs ins dump-tree -b 790151168 /dev/loop0p3
> btrfs-progs v5.7
[...]
> 	item 4 key (5007 INODE_ITEM 0) itemoff 15760 itemsize 160
> 		generation 294 transid 219603 size 0 nbytes 18446462598731726987

The nbytes looks very strange.

It's 0x0xfffeffffffef008b, which definitely looks aweful for an empty inod=
e.

> 		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
> 		sequence 476091 flags 0x0(none)
> 		atime 1610373772.750632843 (2021-01-11 14:02:52)
> 		ctime 1617477826.205928110 (2021-04-03 19:23:46)
> 		mtime 1617477826.205928110 (2021-04-03 19:23:46)
> 		otime 0.0 (1970-01-01 00:00:00)
> 	item 5 key (5007 INODE_REF 4727) itemoff 15732 itemsize 28
> 		index 0 namelen 0 name:
> 		index 0 namelen 0 name:
> 		index 0 namelen 294 name:

Definitely corrupted. I'm afraid tree-checker is correct.

The log tree is corrupted.
And the check to detect such corrupted inode ref is only introduced in
v5.5 kernel, no wonder v5.4 kernel didn't catch it at runtime.

I don't have any idea why this could happen, as it doesn't look like an
obvious memory flip.

Maybe Filipe could have some clue on this?

Thanks,
Qu

> 	item 6 key (5041 INODE_ITEM 0) itemoff 15572 itemsize 160
> 		generation 295 transid 219603 size 4096 nbytes 4096
> 		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
> 		sequence 321954 flags 0x0(none)
> 		atime 1610373832.763235044 (2021-01-11 14:03:52)
> 		ctime 1617477815.541863825 (2021-04-03 19:23:35)
> 		mtime 1617477815.541863825 (2021-04-03 19:23:35)
> 		otime 0.0 (1970-01-01 00:00:00)
> 	item 7 key (5041 INODE_REF 4727) itemoff 15544 itemsize 28
> 		index 12 namelen 18 name: health_metrics.txt
> 	item 8 key (5041 EXTENT_DATA 0) itemoff 15491 itemsize 53
> 		generation 219603 type 1 (regular)
> 		extent data disk byte 12746752 nr 4096
> 		extent data offset 0 nr 4096 ram 4096
> 		extent compression 0 (none)
> 	item 9 key (EXTENT_CSUM EXTENT_CSUM 12746752) itemoff 15487 itemsize 4
> 		range start 12746752 end 12750848 length 4096
>
