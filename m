Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4459154AAE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 09:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352672AbiFNHsW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 03:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354831AbiFNHsS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 03:48:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86853E5C6
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655192890;
        bh=r6vDEV9jsYihFDJM0MTObFqDrQZmPXoNm69KE9lKPSI=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=AnBDOHxjiML9yh9NHWfaHrKSo4DTremFf4f1d1K2CJhGp+VQAfsWr63WKDWTEpM8q
         OO6hcBDi6Q/BSCuVPLRt9e0oDo9CC11qkPNiQJDowbtjUrF7h7dKh5+/qokjvfvvVi
         k30c0L7Pp5+/FZeKlD+qrjoqPGb2IYbeWCNELVNA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw3X-1nJx5V0PoZ-00iy37; Tue, 14
 Jun 2022 09:48:10 +0200
Message-ID: <7d764668-cb95-f410-4846-9a1a98e3b861@gmx.com>
Date:   Tue, 14 Jun 2022 15:48:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1655103954.git.wqu@suse.com>
 <c4b02ac7bf6e4171d8cfb13dcd11b3bad8d2e4df.1655103954.git.wqu@suse.com>
 <YqeKZuET4MDe0D5w@zen>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 2/2] btrfs: warn about dev extents that are inside the
 reserved range
In-Reply-To: <YqeKZuET4MDe0D5w@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JqCbF45UReNYcXvlz/Hd+S0+IcJZz9DMgYqGbl2RCVPWczMybf3
 UwTl7U6tp1m5n7Dgi5IJd51ZVzJX3ROjCnwsC9eXGvkM8VBtfFyr2/lspeV0yhNyBr/uEVT
 DJs3ErhRh8XQMLyeLyEJcGNzft/Bj9oP905uNq0EQzpijQxIDXNOhJFBm52gcQwIFYGjQhM
 ZjonCdCGb67TXOvLET1wA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WHH3j+xFG9c=:cuP5yn7nnaNR30evrpVWER
 22vMo/Qs2FqtMqqwM7lwCoRQdskNeO8Vmt8R80x7LNdB/1KY5uf4w/FMeaivmCrmxk8GmtZI4
 H7XY0ZJnMLFMwnVIpiul1ipmN328LqDyjiWaoaEp9DLeOIUMry0YsxbMry8zAIZPQPiiT/KP6
 rC9soRAI3fw/lcr6XZNryl4V2KDxAxQhm0pw4FqIzw+ilvuDXedSealXWeAHeKGDrID+FRlf0
 QL+JEC6z2QqlDJbzH71CewAdO3CX/F2bnsjAN4nQ8dbR63L+0MMpZNHvFplySajn5f5Wav2OM
 Jls14gHz/7vITXUT8GZA2cO+pFsPqiG2kwGc9g6pkoE1GmvFKGcPZMC3UvPraby0L9l12Ttgd
 fQxNhUv7JE3pk+T+GDX/+4XUEfs8ASfqr9x5YqZIcAtZNEao/uL46+1A88ZqucrWaq9l7waBX
 JrpyuszASvSlz45vu/2VPM87L59FsUuT6ltUiBFmkk7f43Cm6gnC3geCJkHBhhaBEjrmGSXoz
 Ubqjw7RgNCBF5SRGGzNuafYupGBxwwV5S57XyZFfchTALWe7PCuJ97IShTKEZN5qi2WpyegZr
 YUHaNF1kbQeViF3HM4Gxh7uH2gzbazdssrrhGFlgdcMFDS5zmnNQT/WngleEQy1uNlmenUWOB
 l+cHxEgngYuoTAp81fp3UmuVjBfOj3PTIZYSCtkCWej76ErxrEPsdizVIuDyzJeVLz2nj4uM+
 bYztKx1LUj9bQ96YpZUMniwnOjvFrBCLD2f/X8vxTI81f7qynPokr2gH273txddaZOXSUEQd6
 8WPNo2NfEtXD337coW2h+Gz7EDq0he/X7NvpuC4D/AYAzPjlXZ0TuvHeiqmwHrjYOvlsH0VZI
 b5uTxoTwB06fvhNs7VE/SPNJqTTcmpzNl1sCQ875eVHIZDF/qHvmB8UzJcPTMnyHma9zroKk5
 yqlniWpdYzB4p5NqQn6ReM2QM0fj3jxPpZLv/Qb4YrbaeKkRKV1XfE2+PxRL4EPbEh38CQ0m1
 l68xUcSMXgTMktIxwFfVy/7K2ZdXjxWPxJVfUsnzQiVgNjMN73R1s4HCCfxkzmRvDhG/xVVkY
 WlS0hyaFDkxyf19Aa1TqL415wU04fU8cPolm2gH9EQZmrhkVIbOPK0ZdA==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/14 03:05, Boris Burkov wrote:
> On Mon, Jun 13, 2022 at 03:06:35PM +0800, Qu Wenruo wrote:
>> Btrfs has reserved the first 1MiB for the primary super block (at 64KiB
>> offset) and legacy programs like older bootloaders.
>>
>> This behavior is only introduced since v4.1 btrfs-progs release,
>> although kernel can ensure we never touch the reserved range of super
>> blocks, it's better to inform the end users, and a balance will resolve
>> the problem.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/volumes.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 051d124679d1..b39f4030d2ba 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7989,6 +7989,16 @@ static int verify_one_dev_extent(struct btrfs_fs=
_info *fs_info,
>>   		goto out;
>>   	}
>>
>> +	/*
>> +	 * Very old mkfs.btrfs (before v4.1) will not respect the reserved
>> +	 * space. Although kernel can handle it without problem, better to
>> +	 * warn the users.
>> +	 */
>> +	if (physical_offset < BTRFS_DEFAULT_RESERVED)
>> +		btrfs_warn(fs_info,
>> +"devid %llu physical %llu len %llu is inside the reserved space, balan=
ce is needed to solve this problem.",
>
> If I saw this warning, I wouldn't know what balance to run, and it's
> not obvious what to search for online either (if it's even documented).
> I think a more explicit instruction like "btrfs balance start XXXX"
> would be helpful.

Firstly, the balance command needs extra filters, thus the command can
be pretty long, like:

# btrfs balance start -mdrange=3D0..1048576 -ddrange=3D0..1048576
-srange0..1048576 <mnt>

I'm not sure if this is a good idea to put all these into the already
long message.

>
> If it's something we're ok with in general, then maybe a URL for a wiki
> page that explains the issue and the workaround would be the most
> useful.

URL can be helpful but not always. Imagine a poor sysadmin in a noisy
server room, seeing a URL in dmesg, and has to type the full URL into
their phone, if the server has very limited network access.

In fact, this error message for now will be super rare already.

The main usage of this message is for the incoming feature, which will
allow btrfs to reserve extra space for its internal usage.

In that case, we will allow btrfstune to set the reservation (even it's
already used by some dev extent), and btrfstune would give a commandline
how to do the balance.

I guess I'd put all these preparation patches into the incoming on-disk
format change patchset to make it clear.

Thanks,
Qu

>
>> +			   devid, physical_offset, physical_len);
>> +
>>   	for (i =3D 0; i < map->num_stripes; i++) {
>>   		if (map->stripes[i].dev->devid =3D=3D devid &&
>>   		    map->stripes[i].physical =3D=3D physical_offset) {
>> --
>> 2.36.1
>>
