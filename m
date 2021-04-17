Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2282362C5E
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhDQASC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 20:18:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:49771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235137AbhDQASB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 20:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618618653;
        bh=7aE9gt87jLpde1zA2d2GS5aI+7crZjhrOpAfpI8SLYo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kKCkyoXxLa3QdRw2Ufsw5iSoaLHqu5poHXJeYNc19PESVnkFxV1GqWKmQZ4deu3GE
         Bmy2WPb1/ebOqKEv9V21uLyAvVt6lMgOrpcffS8XaYoSt9iIJajhj9T4F/18E6LU3C
         5rQKxMLhQOF+amnXyl3HGYLmcxiVA7IMLNw/m/H8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2E1M-1lesV83NJG-013awp; Sat, 17
 Apr 2021 02:17:33 +0200
Subject: Re: [PATCH 2/3] btrfs-progs: image: enlarge the output file if no
 tree modification is needed for restore
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20210326125047.123694-1-wqu@suse.com>
 <20210326125047.123694-3-wqu@suse.com> <20210416174015.GG7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <275f1ad8-7004-ceb9-2620-c4a421747ffa@gmx.com>
Date:   Sat, 17 Apr 2021 08:17:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210416174015.GG7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zNUcp4hYDNKo8m+CZqCD+fD4b6J5LF1hW3QwMZwycRTKVGJ/t8Q
 wYCKRcn6vDTn1v9RhNSfE7SbrQYlpJYDw+iXKoEbeac9b8SkvZW4kn2QAbaKB/ApuKhRU8h
 LK8gnB9We6WuXQjQDeNKuDP6O8g6HWlhiiimfnGHaQxiNjLINrOqVuiTdHXNVLGRYQsVMZP
 TwIqa4wR6NENQX/CAj7Jw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZgWLRE0yQk8=:crX14AwaTAET3xA6w5WQuw
 9VEDOPD2r5NepMDCftRvOsjMOq39DiZNo4IE4UEbs9yHV1JiCX+digS2stAs7SgULLCRRsSVO
 Da0jR7xacgRM3zcFaxNgBY0Wvf8GbKOicZ2r256jUhDpYdoZcRkgdRB3ciU4bVSroTrp7wjeJ
 GGdfFnF9V4Q7p+Gfh7/Rozd1UhDPz/0DGWjlajKq5FJqlK4pUQVVlHvADPAZfdKinjHvoRnuq
 P3Ad4z1u3g9lcLcjXUGOGuzDeanUbl+rZuZMO2dXznqT5pzkghybmgJ3v3VKkFNn+0+jZsVmD
 bwJ18BdZ9QqXoViMdW1VB/qHhWJm5rOSpvXt+Rwat0HrUHpf1jLrpHfNkA1oMrMaCaBWB271U
 6qp5eRj+OV/20ITwRCUIcSAFju3ZIFwzE16RPQSH8bH/LHt+Wiv1l1GYdH7xj8WgnbyTW132y
 clwJmyUAkBOyevWY7Wa5l8j3Te7VMI4o3jaOZjY+LdFaGYELmVvWISTygAdMgpDmhBkWTolYw
 U1yKjeSaA2+3KPP7BZXc0NHybynNVXPLioU234fxCDoRbuIWzmfJL7ywV/oVIMKOSlGFacRBp
 PO7iF6bT6thIHjYRx8nASv/N0Asah0hwh58B3CZuR/wYeUrRwt5WwmrunVjaRpM2SFierPX3w
 8rnhBz6s09rlqCXTG4iXHtm/a0qe/7ymavghKsBf4htqK6iywhDu6aMjYIVUbiwgzIIjA7pZP
 ci4T0bUEUv4U6bfDr5+0hebuaWv7q+5tb9YMl2o5ZhCCW6h5sq1HMpDYrPXUzjYn0cEEraO7X
 wr4YwlwLTcwdRFfG0WA7sFhUqjr7zZ3F8nXJarMSeaVVk3i3nrVYYSZd/IYBBjVgitOad+YdZ
 FRbLj7RD1y98ikWgO8IlB2e1HebpdP4ao9J0VRJ9aGx3W96RehutQsXAJ36nV4i438PSV6kSS
 3/3nOM2AnmBhf1LTkeEZBEQ31sZJoQoeNhyCp6ljHDGad/kLD0iVipMNJvJvQaK/sZ/GKj8OZ
 AiRDPuiO6qRYk9FE4HYogYW0xyUG/LhIlx/jbjNS6vI6YYljMf4cf/dgDVy34cRGZq4nspB9p
 ioJuJAr4AWhhEqeLQQ4tb5XtlIVxGt3q47TM0py5/TaF9xxRCv6zw4wIgce3BjBjBmSOeTges
 s/Q9OLM7VZuMiP/NBJVV4ldABUUKz5rT4JzmavgKLfq3/XkntZSOmcSFI3klynLsJF17YQc0v
 z4G52LqtzWaDBEA+x
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/17 =E4=B8=8A=E5=8D=881:40, David Sterba wrote:
> On Fri, Mar 26, 2021 at 08:50:46PM +0800, Qu Wenruo wrote:
>> [BUG]
>> If restoring dumpped image into a new file, under most cases kernel wil=
l
>> reject it:
>>
>>   # mkfs.btrfs -f /dev/test/test
>>   # btrfs-image /dev/test/test /tmp/dump
>>   # btrfs-image -r /tmp/dump ~/test.img
>>   # mount ~/test.img /mnt/btrfs
>>   mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/=
loop0, missing codepage or helper program, or other error.
>>   # dmesg -t | tail -n 7
>>   loop0: detected capacity change from 10592 to 0
>>   BTRFS info (device loop0): disk space caching is enabled
>>   BTRFS info (device loop0): has skinny extents
>>   BTRFS info (device loop0): flagging fs with big metadata feature
>>   BTRFS error (device loop0): device total_bytes should be at most 5423=
104 but found 10737418240
>>   BTRFS error (device loop0): failed to read chunk tree: -22
>>   BTRFS error (device loop0): open_ctree failed
>>
>> [CAUSE]
>> When btrfs-image restores an image into a file, and the source image
>> contains only single device, then we don't need to modify the
>> chunk/device tree, as we can reuse the existing chunk/dev tree without
>> any problem.
>>
>> This also means, for such restore, we also won't do any target file
>> enlarge. This behavior itself is fine, as at that time, kernel won't
>> check if the device is smaller than the device size recorded in device
>> tree.
>>
>> But later kernel commit 3a160a933111 ("btrfs: drop never met disk total
>> bytes check in verify_one_dev_extent") introduces new check on device
>> size at mount time, rejecting any loop file which is smaller than the
>> original device size.
>>
>> [FIX]
>> Do extra file enlarge for single device restore.
>>
>> Reported-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   image/main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/image/main.c b/image/main.c
>> index 24393188e5e3..9933f69d0fdb 100644
>> --- a/image/main.c
>> +++ b/image/main.c
>> @@ -2706,6 +2706,49 @@ static int restore_metadump(const char *input, F=
ILE *out, int old_restore,
>>   		close_ctree(info->chunk_root);
>>   		if (ret)
>>   			goto out;
>> +	} else {
>> +		struct btrfs_root *root;
>> +		struct stat st;
>> +		u64 dev_size;
>> +
>> +		if (!info) {
>> +			root =3D open_ctree_fd(fileno(out), target, 0, 0);
>> +			if (!root) {
>> +				error("open ctree failed in %s", target);
>> +				ret =3D -EIO;
>> +				goto out;
>> +			}
>> +
>> +			info =3D root->fs_info;
>> +
>> +			dev_size =3D btrfs_stack_device_total_bytes(
>> +					&info->super_copy->dev_item);
>> +			close_ctree(root);
>> +			info =3D NULL;
>> +		} else {
>> +			dev_size =3D btrfs_stack_device_total_bytes(
>> +					&info->super_copy->dev_item);
>> +		}
>> +
>> +		/*
>> +		 * We don't need extra tree modification, but if the output is
>> +		 * a file, we need to enlarge the output file so that
>> +		 * newer kernel won't report error.
>> +		 */
>> +		ret =3D fstat(fileno(out), &st);
>> +		if (ret < 0) {
>> +			error("failed to stat result image: %m");
>> +			ret =3D -errno;
>> +			goto out;
>> +		}
>> +		if (S_ISREG(st.st_mode)) {
>> +			ret =3D ftruncate64(fileno(out), dev_size);
>
> This truncates the file unconditionally, so if the file is larger than
> required, I don't think it's necessary to do it.
>
Indeed, I'll update the patchset to do conditional truncation.

Thanks,
Qu
