Return-Path: <linux-btrfs+bounces-2255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B0C84E983
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6818B1C20CD2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8190C383B9;
	Thu,  8 Feb 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="E9LChEx4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDB383AE
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423519; cv=none; b=ovJU7Kmz7Ua+85cU4G3lPG1LgROEBYXovuPOVPKo8l5QrjKTPdBwRu2OeZfFTCI81pM//IGSDcKGVasFM4uUmjLxodLbM20RJp3mawqdTjOyPjAL8TUk8Ju74gpTZky0vqBr5Frk2Y/3zbKoltij6BbZTtelkTrKZ9AQMajR3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423519; c=relaxed/simple;
	bh=WfiyDt8gaIXPQEwJoxG6Z3aMx54SXpOyP4UCiNd6eq4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MCrD3S0tmJQfWaTtn6w1/DUKc6KTrP1qhP1ru08rZTi/atpZEaqgQ3JdbQ3GhjQdOKmcyO61QbzDt7fJQmhmww8Sqfvu0aVRGaB2U1xntCb1eC6QscozwN+MkEo/F0TuP1k4c/5785i5RxLP3971yVQqNXt4U6Vi4+zbt02HMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=E9LChEx4; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id YAqurssEuXMxBYAqvr9bQt; Thu, 08 Feb 2024 21:18:33 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1707423513; bh=DmSq0CEl2Tjx7Pai4MfAJwTORvwKr+Oji4iUZnn4rBY=;
	h=From;
	b=E9LChEx4AYKvmHfz5cNQjcrS6HBBeaxq4NmgfMXcTBlR1J+Rc4e5V5u6WhdMiQESF
	 rUadVA3mbldm8rNHPyh/ufL3Ipw5M5TJesVOpn7JKz60i4vM0UAk8ecxmrG/Jobf1W
	 +BwHiJ0g0WOC7z+mxTZO4K5J67KnElrC/L9JO7vTqYCtDYNMeWcWIPmXFu2F1QWRtF
	 oZs2SImUxt/TalxcLA8vZ6ZWK/j1vn/t7XW76Ka14lhb/qXBzdsWudaFzVcCjaCCHH
	 nih/kRRSRZjTsHX/2hoKSfeMolTqPpe2Zid9EwZ2k/53RAZihmRdxBF+m/l39WVnzU
	 f2Q5XG3BTQh/g==
X-CNFS-Analysis: v=2.4 cv=Svkz6+O0 c=1 sm=1 tr=0 ts=65c53719 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=lA4UmfJv2Nr52Xv8etoA:9 a=QEXdDO2ut3YA:10
 a=8LfgHNaa6p4A:10
Message-ID: <e75f6628-4044-4fac-87c3-c0df127df7fd@inwind.it>
Date: Thu, 8 Feb 2024 21:18:32 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 0/9][btrfs-progs] Remove unused dirstream variable
Reply-To: kreijack@inwind.it
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1702148009.git.kreijack@inwind.it>
 <20231214161749.GA9795@twin.jikos.cz>
 <6e4b2c09-b820-4ba8-8117-d13f3556e426@libero.it>
 <20240207101640.GV355@twin.jikos.cz>
 <d03d4140-4795-4fc5-8a8f-9510f3aa841f@inwind.it>
 <7cb2e143-c80c-4f42-9b77-4a2f602f61fe@inwind.it>
Content-Language: en-US
In-Reply-To: <7cb2e143-c80c-4f42-9b77-4a2f602f61fe@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDrC0Sy3oNvWZUdi6SB8Vl71Mau7w7fjecXz8ZFHHIu0WrB3fe+C0QlVQq7oTEsnzXP/FgJ9xMPgr2oSVR1avcXYvqbKka/xzyfeE9/ci8OSESdAcn3b
 s/SWD14XZCAEfClNHav2aR3ZqDeu+VpawPOwdGRb4Mv+AYWEi176Z4WCLwbM46xkjIHrBDUIRdZRtSMZogXTJvSpHWSO6eoUjkxN+nDSg8WHTHIsvYm/dhdI

On 08/02/2024 18.34, Goffredo Baroncelli wrote:
> On 08/02/2024 18.28, Goffredo Baroncelli wrote:
>> On 07/02/2024 11.16, David Sterba wrote:
>>> On Sat, Dec 30, 2023 at 12:20:54PM +0100, Goffredo Baroncelli wrote:
>>>> On 14/12/2023 17.17, David Sterba wrote:
>>>>> On Sat, Dec 09, 2023 at 07:53:20PM +0100, Goffredo Baroncelli wrote:
>>>>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>>>>
>>>>>> For historical reason, the helpers [btrfs_]open_[file_or_]dir() work with
>>>>>> directory returning the 'fd' and a 'dirstream' variable returned by
>>>>>> opendir(3).
>>>>>>
>>>>>> If the path is a file, the 'fd' is computed from open(2) and
>>>>>> dirstream is set to NULL.
>>>>>> If the path is a directory, first the directory is opened by opendir(3), then
>>>>>> the 'fd' is computed using dirfd(3).
>>>>>> However the 'dirstream' returned by opendir(3) is left open until 'fd'
>>>>>> is not needed anymore.
>>>>>>
>>>>>> In near every case the 'dirstream' variable is not used. Only 'fd' is
>>>>>> used.
>>>>>
>>>>> As I'm reading dirfd manual page, dirfd returns the internal file
>>>>> descriptor of the dirstream and it gets closed after call to closedir().
>>>>> This means if we pass a directory and want a file descriptor then its
>>>>> lifetime matches the correspoinding DIR.
>>>>>
>>>>>> A call to close_file_or_dir() freed both 'fd' and 'dirstream'.
>>>>>>
>>>>>> Aim of this patch set is to getrid of this complexity; when the path of
>>>>>> a directory is passed, the fd is get directly using open(path, O_RDONLY):
>>>>>> so we don't need to use readdir(3) and to maintain the not used variable
>>>>>> 'dirstream'.
>>>>>
>>>>> Does this work the same way as with the dirstream?
>>>>>
>>>>
>>>> Hi David, are you interested in this patch ? I think that it is a
>>>> great simplification.
>>>
>>> Sorry, I got distracted by other things.
>>>
>>> The patchset does not apply cleanly on 6.7 so I've used 6.6.3 as the
>>> base for testing. There's one failure in the cli tests, result can be
>>> seen here https://github.com/kdave/btrfs-progs/actions/runs/7813042695/job/21311365019
>>>
>>> ====== RUN MUSTFAIL /home/runner/work/btrfs-progs/btrfs-progs/btrfs filesystem resize 1:-128M /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
>>> ERROR: not a btrfs filesystem: /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
>>> failed (expected): /home/runner/work/btrfs-progs/btrfs-progs/btrfs filesystem resize 1:-128M /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
>>> no expected error message in the output 2
>>> test failed for case 003-fi-resize-args
>>>
>>> I think it's related to the changes to dirstream, however I can't
>>> reproduce it locally, only on the github actions CI.

I found the problem, and I have an idea why you cannot reproduce the problem

The test

	btrfs filesystem resize 1:-128M /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img

Expect the following error message:

	ERROR: resize works on mounted filesystems and accepts only

However if you pass a file image on a NON btrfs fs, after my patch you got the following error:

	ERROR: not a btrfs filesystem: /home/ghigo/btrfs/btrfs-progs/tests/test.img

But if you do the test on a BTRFS filesystem, you get the following error

	ERROR: not a directory: /mnt/btrfs-raid1/test.img
	ERROR: resize works on mounted filesystems and accepts only
	directories as argument. Passing file containing a btrfs image
	would resize the underlying filesystem instead of the image.


Basically, my patch rearranged the tests as:
- is a btrfs filesystem
- is a directory

where before the tests were
- is a directory
- is a btrfs filesystem


In the test 013-xxxx before failed the test "is a directory", now the test "is a btrfs filesystem" fails first.


The code fails here:

cmds/filesystem.c:
static int cmd_filesystem_resize(const struct cmd_struct *cmd,
[...]
         fd = btrfs_open_dir_fd(path);
         if (fd < 0) {
                 /* The path is a directory */
                 if (fd == -3) {
                         error(
                 "resize works on mounted filesystems and accepts only\n"
                 "directories as argument. Passing file containing a btrfs image\n"
                 "would resize the underlying filesystem instead of the image.\n");
                 }
                 return 1;
         }


However the check implemented in btrfs_open_dir_fd() are:

btrfs_open_dir_fd()
   btrfs_open_fd_2()

[...]
         if (stat(path, &st) != 0) {
                 error_on(verbose, "cannot access '%s': %m", path);
                 return -1;
         }

         if (statfs(path, &stfs) != 0) {
                 error_on(verbose, "cannot access '%s': %m", path);
                 return -1;
         }

         if (stfs.f_type != BTRFS_SUPER_MAGIC) {
                 error_on(verbose, "not a btrfs filesystem: %s", path);    // <---- NOW fail first here IF the filesystem is a not
                 return -2;						  //       btrfs
         }

         if (dir_only && !S_ISDIR(st.st_mode)) {
                 error_on(verbose, "not a directory: %s", path);          // <----- BEFORE failed here
                 return -3;
         }

         if (S_ISDIR(st.st_mode) || !read_write)
                 ret = open(path, O_RDONLY);
         else
                 ret = open(path, O_RDWR);
         if (ret < 0) {
                 error_on(verbose, "cannot access '%s': %m", path);
         }




IN order to solve the issue, I swapped the check orders; to be consistent with the previous errors.
Soon I will send you a V2 version

>>>
>>> Unlike other commands in the test, this one is called on an image and it
>>> must fail to prevent accidentaly resizing underlying filesystem.
>>
>>
>> I will rebase on 6.7 and I will try to reproduce the problem. Could you share the full script, or point me where is it ?
> 
> Ignore my latter request. I found the test code.
> 
>>
>> BR
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


